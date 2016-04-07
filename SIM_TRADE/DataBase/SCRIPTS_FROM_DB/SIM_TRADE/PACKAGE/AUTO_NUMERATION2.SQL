
  CREATE OR REPLACE PACKAGE "SIM_TRADE"."AUTO_NUMERATION2" IS 
-- 
--#Version=3 
-- 
-- 3. Уколов. Добавил параметр pFIND_SQL в функцию GET_NEXT_SEQUENCE_VALUE
-- 2. Уколов. Добавил процедуру освобождения номера FREE_SEQUENCE_VALUE
--
-- Пакет позволяет получать последовательности номеров "без пропусков". 
-- 
-- Правила использования:
-- 1. Для правильной работы алгоритма необходимо вызов функции GET_NEXT_SEQUENCE_VALUE 
--    и последующее сохранение документа делать в одной и той же транзакции. 
--    Выполнение COMMIT (явное или неявное) после вызова функции подтверждает 
--    использование номера, а вызов ROLLBACK возвращает номер в список свободных  
--    номеров для повторного использования.
-- 
-- 2. В качестве параметра в функцию GET_NEXT_SEQUENCE_VALUE передается имя последовательности.  
--    Чтобы нумерация шла с начала года, то необходимо включить в  
--    имя последовательности номер года, а чтобы нумерация ежедневно начиналась с 1,  
--    нужно включить в имя последовательности дату. 
--    Примеры имени последовательности: 'НОМЕР_МЕДКАРТЫ_2007', '№_БИОМАТ_123_45_20070801'.
--    Второй параметр - текст SQL-запроса, который проверяет наличие дубликатов номера в таблице
--    и при их обнаружении считает номер занятым и получает следующий номер.
--
-- Функция возвращает номер из последовательности с именем pSEQUENCE_NAME
-- Если позже будет выполнен ROLLBACK, то номер автоматически попадет
-- в список "свободных" номеров и может быть выдан повторно.
--
FUNCTION GET_NEXT_SEQUENCE_VALUE(
  -- Имя последовательности
  pSEQUENCE_NAME IN VARCHAR2, 
  -- Текст SQL-запроса для проверки уникальности (можно не указывать, тогда проверка не выполняется).
  -- Чтобы сослаться на номер, используйте переменную :NUM. 
  -- например: SELECT 1 FROM DOCUMS WHERE DOC_NUM=RPAD(:NUM, 1, 6) -- дополняем нулями до 6 знаков
  pFIND_SQL IN VARCHAR2 DEFAULT NULL
  --
  ) RETURN INTEGER;
--
-- Функция освобождает ранее взятый номер для последовательности pSEQUENCE_NAME.
--
PROCEDURE FREE_SEQUENCE_VALUE(
  pSEQUENCE_NAME IN VARCHAR2,
  pVALUE IN NUMBER);
--
END AUTO_NUMERATION2; 
CREATE OR REPLACE PACKAGE BODY "SIM_TRADE"."AUTO_NUMERATION2" IS 
-- 
PROCEDURE ADD_VALUE_FROM_SEQUENCE( 
  pSEQUENCE_NAME IN VARCHAR2 
  ) IS 
  PRAGMA AUTONOMOUS_TRANSACTION; 
  vRESULT PLS_INTEGER; 
BEGIN 
  -- Обновляем справочник последовательностей  
  -- (должна быть только одна запись или ни одной) 
  -- и получаем новое значение 
  -- Автономная транзакция должна гарантировать быстрое выполнение процедуры и 
  UPDATE AUTO_NUMERATION2_SEQUENCES 
    SET LAST_VALUE = NVL(LAST_VALUE, 0)+1 
    WHERE SEQUENCE_NAME=pSEQUENCE_NAME 
    RETURNING LAST_VALUE INTO vRESULT; 
  IF vRESULT IS NULL THEN 
    -- Нет записи в справочнике последовательностей 
    -- Добавляем запись 
    INSERT INTO AUTO_NUMERATION2_SEQUENCES (SEQUENCE_NAME, LAST_VALUE)  
      VALUES (pSEQUENCE_NAME, 1); 
    -- Начинаем нумерацию с 1 
    vRESULT := 1; 
  END IF; 
  -- Добавляем значение в пул свободных номеров 
  -- Есть вероятность, что этот номер захватит не наша сессия,  
  -- но это не страшно, так как наша сессия снова ничего не найдет и  
  -- добавит еще один номер.  
  INSERT INTO AUTO_NUMERATION2_FREE_VALUES (SEQUENCE_NAME, VALUE)  
    VALUES (pSEQUENCE_NAME, vRESULT); 
  -- Подтверждаем транзакцию 
  COMMIT; 
END ADD_VALUE_FROM_SEQUENCE; 
-- 
FUNCTION GET_NEXT_SEQUENCE_VALUE( 
  -- Имя последовательности
  pSEQUENCE_NAME IN VARCHAR2, 
  -- Текст SQL-запроса для проверки уникальности (можно не указывать, тогда проверка не выполняется).
  -- Чтобы сослаться на номер, используйте переменную :NUM. 
  -- например: SELECT 1 FROM DOCUMS WHERE DOC_NUM=RPAD(:NUM, 1, 6) -- дополняем нулями до 6 знаков
  pFIND_SQL IN VARCHAR2 DEFAULT NULL
  --
  ) RETURN INTEGER IS 
-- 
  RESOURCE_BUSY  EXCEPTION;          -- Исключение ORA-00054 "RESOURCE_BUSY"       
  PRAGMA EXCEPTION_INIT(RESOURCE_BUSY, -00054);    
-- 
  EMPTY_SEQUENCE_NAME_ERROR CONSTANT PLS_INTEGER := -20387; 
  EMPTY_SEQUENCE_NAME_ERROR_MSG CONSTANT VARCHAR2(44 CHAR) := 'Пустое имя последовательности не допускается'; 
-- 
  vRESULT PLS_INTEGER;
  vCOUNT PLS_INTEGER; 
-- 
BEGIN 
  IF pSEQUENCE_NAME IS NULL THEN 
    RAISE_APPLICATION_ERROR(EMPTY_SEQUENCE_NAME_ERROR, EMPTY_SEQUENCE_NAME_ERROR_MSG); 
  END IF; 
  <<cycle_while_not_found_value>> 
  LOOP -- Цикл 
    -- Перебираем записи в "свободном" пуле 
    <<select_free_pool>> -- Имя цикла 
    FOR rec_free IN ( 
      SELECT F.ROWID FROM AUTO_NUMERATION2_FREE_VALUES F 
        WHERE F.SEQUENCE_NAME=pSEQUENCE_NAME 
        ORDER BY F.VALUE 
      ) LOOP 
      -- Пытаемся заблокировать запись 
      BEGIN 
        -- SELECT ... FOR UPDATE NOWAIT даст исключение RESOURCE_BUSY,  
        -- если запись уже заблокирована другой сессией         
        SELECT F.VALUE  
          INTO vRESULT  
          FROM AUTO_NUMERATION2_FREE_VALUES F 
          WHERE F.ROWID=rec_free.ROWID 
          FOR UPDATE NOWAIT
          ;           
        -- Заблокировать запись удалось, 
        -- Помечаем запись на удаление.  
        -- В этом случае при подтверждении транзакции запись действительно будет удалена, 
        -- а при ROLLBACK удаление откатится, запись станет видимой и незаблокированной  
        -- и будет использована повторно. 
        DELETE FROM AUTO_NUMERATION2_FREE_VALUES F
          WHERE F.ROWID=rec_free.ROWID;
        --
        IF pFIND_SQL IS NULL THEN
          --выходим из цикла 
          -- Блокировка записи будет сохраняться до конца транзакции
          EXIT select_free_pool;
        ELSE 
          -- Проверяем, нет ли записи с таким номером в таблице
          EXECUTE IMMEDIATE
            'SELECT COUNT(*) FROM DUAL WHERE EXISTS ('||pFIND_SQL || ')'
            INTO vCOUNT
            USING IN vRESULT;
          -- Если нет совпадающих записей, выходим из цикла
          EXIT WHEN vCOUNT = 0;
          -- Очищаем результат (он не годится)
          vRESULT := NULL;
        END IF;
      EXCEPTION WHEN RESOURCE_BUSY THEN 
        NULL; -- Ошибка блокировки, возвращаемся в цикл и пробуем следующую запись 
      END; 
    END LOOP select_free_pool; 
    --  
    EXIT cycle_while_not_found_value WHEN vRESULT IS NOT NULL;  
    -- В пуле свободных номеров номер не нашли 
    -- Добавляем номер из последовательности в пул свободных 
    ADD_VALUE_FROM_SEQUENCE(pSEQUENCE_NAME); 
    -- для поиска свободного номера возвращаемся в начало цикла 
  END LOOP cycle_while_not_found_value; 
  RETURN vRESULT; 
END GET_NEXT_SEQUENCE_VALUE;
--
-- Функция освобождает ранее взятый номер для последовательности pSEQUENCE_NAME.
--
PROCEDURE FREE_SEQUENCE_VALUE(
  pSEQUENCE_NAME IN VARCHAR2,
  pVALUE IN NUMBER) IS
BEGIN
  -- Просто добавляем номер в список свободных номеров.
  -- Если транзакция подтвердится, то джобавленный номер увидят все сессии
  -- Если транзакция не подтвердится, добавленнй номер не сохранится.
  -- Если номер освободить и запросить повторно, то получим либо его, либо
  -- другой свободный номер.
  INSERT INTO AUTO_NUMERATION2_FREE_VALUES (SEQUENCE_NAME, VALUE)
    VALUES (pSEQUENCE_NAME, pVALUE);
END FREE_SEQUENCE_VALUE;
--
END AUTO_NUMERATION2; 