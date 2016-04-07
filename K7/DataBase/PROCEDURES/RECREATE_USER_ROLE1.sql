--#if GetVersion("RECREATE_USER_ROLE1") < 8 then
CREATE OR REPLACE PROCEDURE RECREATE_USER_ROLE1(pROLE_NAME VARCHAR2 DEFAULT USER || '_ROLE', 
  pUSER_NAME VARCHAR2 DEFAULT USER) AUTHID CURRENT_USER IS 
--
--#Version=8
--
-- 8. Уколов. Добавил формирование роли *_RO с правами на чтение и на выполнение процедур
-- 7. Уколов. Исключил таблицы, начинающиеся с 'BIN$'.
--
-- 6. Крайнов.
--      Введен DEFAULT USER ROLE
--
-- 5. Уколов. 
--      Добавил выдачу прав на последовательности (SEQUENCE)
--      Перевел выполнение запросов на EXECUTE IMMEDIATE
-- 
-- 4. Сабаев. Внес 'GRANT CREATE SESSION TO' в блок EXCEPTION
--      заменил обработчик ошибки ROLE_EXISTS на OTHERS
--      для пересоздания уже сущестующей роли пользователю теперь 
--      нет необходимости иметь права на CREATE SESSION WITH ADMIN OPTION и CREATE ROLE
--    запускать процедуру теперь можно просто из под имени схемы имея только 
--      CREATE SESSION
-- 3. Уколов. Исправил ошибку, из-за которой права на выполнение  
--    процедур выдавались только в случае, если эти права ранее не 
--    были выданы никому (ни роли, ни пользователю), и создание 
--    второй роли выполнялось неправильно.
-- 2. Уколов. Убрал ссылки на DBA_* объекты, добавил указание 
--    на запуск процедуры от имени запускающего пользователя, 
--    а не от имени владельца схемы. 
--
--  ROLE_EXISTS EXCEPTION;         -- Исключение "рОЛЬ УЖЕ СУЩЕСТВУЕТ" 
--  PRAGMA EXCEPTION_INIT(ROLE_EXISTS, -01921); 
--
  pROLE_NAME_RO VARCHAR2(30); 
--
  CURSOR CUR_TABLES(pUSER_NAME VARCHAR2) IS 
    SELECT OBJECT_NAME FROM ALL_OBJECTS WHERE (OBJECT_TYPE = 'TABLE') 
      AND (OWNER = pUSER_NAME)
      AND OBJECT_NAME NOT LIKE 'BIN$%'; 
  CURSOR CUR_PROCEDURES(pUSER_NAME VARCHAR2) IS 
    SELECT OBJECT_NAME FROM ALL_OBJECTS WHERE 
      (OBJECT_TYPE IN ('PROCEDURE', 'FUNCTION', 'PACKAGE')) 
      AND (OWNER = pUSER_NAME) AND (OBJECT_NAME <> 'RECREATE_USER_ROLE1') 
/*    MINUS 
    SELECT TABLE_NAME FROM ALL_TAB_PRIVS  
          WHERE (TABLE_SCHEMA = pUSER_NAME)  AND (GRANTEE=pROLE_NAME)*/
          ; 
  CURSOR CUR_VIEWS(pUSER_NAME VARCHAR2) IS 
    SELECT OBJECT_NAME FROM ALL_OBJECTS WHERE (OBJECT_TYPE IN ('VIEW', 'SEQUENCE')) AND (OWNER = pUSER_NAME); 
-- 
BEGIN 
  -- Процедура создает роль пользователя с правами: 
  --   добавление, редактирование, удаление и выборку из всех таблиц рабочей схемы 
  --   запуск всех пакетов, процедур и функций 
  --   и выборку из всех вьюшек и последовательностей
--
  BEGIN 
    EXECUTE IMMEDIATE 'CREATE ROLE '||pROLE_NAME; 
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO '||pROLE_NAME; 
  EXCEPTION WHEN OTHERS THEN 
    NULL; 
  END; 
  pROLE_NAME_RO := pROLE_NAME || '_RO';
  BEGIN 
    EXECUTE IMMEDIATE 'CREATE ROLE '||pROLE_NAME_RO; 
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO '||pROLE_NAME_RO; 
  EXCEPTION WHEN OTHERS THEN 
    NULL; 
  END; 
-- 
  FOR REC_TABLES IN CUR_TABLES(pUSER_NAME) LOOP 
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON '||pUSER_NAME||'.'||REC_TABLES.OBJECT_NAME||' TO '||pROLE_NAME;
    EXECUTE IMMEDIATE 'GRANT SELECT                         ON '||pUSER_NAME||'.'||REC_TABLES.OBJECT_NAME||' TO '||pROLE_NAME_RO;
  END LOOP; 
-- 
  FOR REC_PROCEDURES IN CUR_PROCEDURES(pUSER_NAME) LOOP
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON '||pUSER_NAME||'.'||REC_PROCEDURES.OBJECT_NAME||' TO '||pROLE_NAME;
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON '||pUSER_NAME||'.'||REC_PROCEDURES.OBJECT_NAME||' TO '||pROLE_NAME_RO;
  END LOOP; 
-- 
  FOR REC_VIEWS IN CUR_VIEWS(pUSER_NAME) LOOP 
    EXECUTE IMMEDIATE 'GRANT SELECT ON '||pUSER_NAME||'.'||REC_VIEWS.OBJECT_NAME||' TO '||pROLE_NAME;
    EXECUTE IMMEDIATE 'GRANT SELECT ON '||pUSER_NAME||'.'||REC_VIEWS.OBJECT_NAME||' TO '||pROLE_NAME_RO;
  END LOOP;
-- 
END;
/
--#end if
