--#if not TableExists("USER_NAMES") then
CREATE TABLE USER_NAMES
(
  USER_NAME_ID            INTEGER               NOT NULL,
  USER_FIO                VARCHAR2(400 CHAR),
  USER_NAME               VARCHAR2(120 CHAR),
  PASSWORD2               VARCHAR2(120 CHAR),
  FILIAL_ID               INTEGER,
  RIGHTS_TYPE             INTEGER,
  USER_NAME_CREATED       VARCHAR2(30 CHAR),
  DATE_CREATED            DATE,
  USER_NAME_LAST_UPDATED  VARCHAR2(30 CHAR),
  DATE_LAST_UPDATED       DATE
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;
--#end if

--#if GetTableComment("USER_NAMES")<>"Пользователи" then
COMMENT ON TABLE USER_NAMES IS 'Пользователи';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_ID")<>"Первичный ключ" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_ID IS 'Первичный ключ';
--#end if

--#if GetColumnComment("USER_NAMES.USER_FIO")<>"ФИО пользователя" then
COMMENT ON COLUMN USER_NAMES.USER_FIO IS 'ФИО пользователя';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME")<>"Имя пользователя Oracle" then
COMMENT ON COLUMN USER_NAMES.USER_NAME IS 'Имя пользователя Oracle';
--#end if

--#if GetColumnComment("USER_NAMES.PASSWORD2")<>"Пароль (не хранится)" then
COMMENT ON COLUMN USER_NAMES.PASSWORD2 IS 'Пароль (не хранится)';
--#end if

--#if GetColumnComment("USER_NAMES.FILIAL_ID")<>"Код филиала по умолчанию" then
COMMENT ON COLUMN USER_NAMES.FILIAL_ID IS 'Код филиала по умолчанию';
--#end if

--#if GetColumnComment("USER_NAMES.RIGHTS_TYPE")<>"Тип прав пользователей : 1 - администратор, 2 - просмотр, 3 - только инф. по абоненту, иначе обычный пользователь" then
COMMENT ON COLUMN USER_NAMES.RIGHTS_TYPE IS 'Тип прав пользователей : 1 - администратор, 2 - просмотр, 3 - только инф. по абоненту, иначе обычный пользователь';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_CREATED")<>"Пользователь, создавший запись" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_CREATED IS 'Пользователь, создавший запись';
--#end if

--#if GetColumnComment("USER_NAMES.DATE_CREATED")<>"Дата/время создания записи" then
COMMENT ON COLUMN USER_NAMES.DATE_CREATED IS 'Дата/время создания записи';
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_LAST_UPDATED")<>"Пользователь, редактировавший запись последним" then
COMMENT ON COLUMN USER_NAMES.USER_NAME_LAST_UPDATED IS 'Пользователь, редактировавший запись последним';
--#end if

--#if GetColumnComment("USER_NAMES.DATE_LAST_UPDATED")<>"Дата/время последней редакции записи" then
COMMENT ON COLUMN USER_NAMES.DATE_LAST_UPDATED IS 'Дата/время последней редакции записи';
--#end if


--#if not ConstraintExists("PK_USER_NAMES") then
ALTER TABLE USER_NAMES ADD CONSTRAINT PK_USER_NAMES PRIMARY KEY (USER_NAME_ID);
--#end if

--#if not ConstraintExists("FK_USER_NAMES_FILIAL_ID") then
ALTER TABLE USER_NAMES ADD CONSTRAINT FK_USER_NAMES_FILIAL_ID 
 FOREIGN KEY (FILIAL_ID) REFERENCES FILIALS;
--#end if

--#if not IndexExists("I_USER_NAMES_FILIAL_ID") then
CREATE INDEX I_USER_NAMES_FILIAL_ID ON USER_NAMES (FILIAL_ID);
--#end if

--#if GetVersion("TIU_USER_NAMES")<1 then
CREATE OR REPLACE TRIGGER TIU_USER_NAMES
BEFORE INSERT OR UPDATE
ON USER_NAMES 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    pCount integer;
BEGIN 
    --если вставка
    IF INSERTING THEN
        IF NVL(:NEW.USER_NAME_ID, 0) = 0 then
            :NEW.USER_NAME_ID := NEW_USER_NAME_ID;
        END IF;
        :NEW.USER_NAME_CREATED := USER;
        :NEW.DATE_CREATED := SYSDATE;
        --записываем историю если имеется активность в CRM и указано рабочее место
        IF ( :NEW.LAST_ACTIVE IS NOT NULL ) AND
            ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 )  THEN
            INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
        END IF;   
    END IF;
    :NEW.USER_NAME_LAST_UPDATED := USER;
    :NEW.DATE_LAST_UPDATED := SYSDATE;
    
    --если обновление
    IF UPDATING THEN
        --если оператора нет на рабочем месте или сменилось рабочее место
        IF ( ( :OLD.LAST_ACTIVE IS NULL ) AND ( :NEW.LAST_ACTIVE IS NOT NULL ) AND ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 ) ) OR
            ( ( :NEW.LAST_ACTIVE IS NOT NULL ) AND (NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0) AND ( NVL(:OLD.LAST_CRM_PHONEUNREF_ID, 0) <> NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) ) ) OR
            ( 
              ( :OLD.LAST_ACTIVE IS NOT NULL ) AND ( :NEW.LAST_ACTIVE IS NOT NULL ) AND ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 ) AND
              ( (to_date(to_char(:NEW.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS') - to_date(to_char(:OLD.LAST_ACTIVE, 'DD.MM.YYYY HH24:MI:SS'), 'DD.MM.YYYY HH24:MI:SS')) >=  40/24/60/60)
            )  THEN
            INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
        ELSE
            IF ( :OLD.LAST_ACTIVE IS NOT NULL ) AND 
                ( :NEW.LAST_ACTIVE IS NOT NULL ) AND 
                ( NVL(:NEW.LAST_CRM_PHONEUNREF_ID, 0) <> 0 )  AND 
                (:OLD.LAST_ACTIVE <> :NEW.LAST_ACTIVE) THEN
                --проверяем наличие записи по данному пользователю в истории 
                --(для тех пользователей по которым уже имеется активность в CRM и указано рабочее место)
                SELECT count(*)
                INTO pCount
                FROM LOG_WORK_USER_CRM cr
                WHERE cr.USER_NAME_ID = :NEW.USER_NAME_ID;     
                    
                IF pCount > 0 THEN
                    --обновление
                    UPDATE LOG_WORK_USER_CRM cr
                    SET cr.END_DATE = :NEW.LAST_ACTIVE
                    WHERE cr.CRM_PHONEUNREF_ID = :NEW.LAST_CRM_PHONEUNREF_ID
                    AND cr.USER_NAME_ID = :NEW.USER_NAME_ID
                    AND cr.DATE_CREATED = (select max(wr.DATE_CREATED)
                                                           from LOG_WORK_USER_CRM wr
                                                           where WR.CRM_PHONEUNREF_ID = CR.CRM_PHONEUNREF_ID
                                                           and WR.USER_NAME_ID = CR.USER_NAME_ID);    
                ELSE
                    --вставка
                    INSERT INTO LOG_WORK_USER_CRM (USER_NAME_ID, CRM_PHONEUNREF_ID, BEGIN_DATE, END_DATE) 
                        VALUES (:NEW.USER_NAME_ID, :NEW.LAST_CRM_PHONEUNREF_ID, :NEW.LAST_ACTIVE, :NEW.LAST_ACTIVE);
                END IF;    
            END IF;
        END IF;
    END IF;
END;
--#end if

--#if not ColumnExists("USER_NAMES.CHECK_ALLOW_ACCOUNT") then
ALTER TABLE USER_NAMES ADD CHECK_ALLOW_ACCOUNT NUMBER(1);
--#end if

--#if GetColumnComment("USER_NAMES.CHECK_ALLOW_ACCOUNT")<>"Флаг проверки. 1 - Проверять доступ пользователя к л/с" then
COMMENT ON COLUMN USER_NAMES.CHECK_ALLOW_ACCOUNT IS 'Флаг проверки. 1 - Проверять доступ пользователя к л/с';
--#end if

--#if not ColumnExists("USER_NAMES.USER_NAME_OKTEL") AND ISClient("GSM_CORP") then
ALTER TABLE USER_NAMES ADD USER_NAME_OKTEL VARCHAR2(120 CHAR);
--#end if

--#if GetColumnComment("USER_NAMES.USER_NAME_OKTEL")<>"Имя в Oktel" AND ISClient("GSM_CORP") then
COMMENT ON COLUMN USER_NAMES.USER_NAME_OKTEL IS 'Имя в IP телефонии';
--#end if

--#if not ColumnExists("USER_NAMES.PASSWORD_OKTEL") and isclient("GSM_CORP") then
ALTER TABLE USER_NAMES ADD PASSWORD_OKTEL VARCHAR2(20 CHAR);
--#end if

--#if GetColumnComment("USER_NAMES.PASSWORD_OKTEL")<>"Пароль в IP телефонии" and isclient("GSM_CORP") then
COMMENT ON COLUMN USER_NAMES.PASSWORD_OKTEL IS 'Пароль в Oktel';
--#end if
              
--#if not ColumnExists("USER_NAMES.ENCRYPT_PWD") then
ALTER TABLE USER_NAMES ADD ENCRYPT_PWD NUMBER(1);
--#end if

--#if GetColumnComment("USER_NAMES.ENCRYPT_PWD")<>"1 - Шифрованный пароль" then
COMMENT ON COLUMN USER_NAMES.ENCRYPT_PWD IS '1 - Шифрованный пароль';
--#end if

--#if not ColumnExists("USER_NAMES.MAX_PROMISED_PAYMENT") then
ALTER TABLE USER_NAMES ADD MAX_PROMISED_PAYMENT NUMBER(15, 2);
--#end if

--#if GetColumnComment("USER_NAMES.MAX_PROMISED_PAYMENT")<>"Максимальный обещанный платеж" then
COMMENT ON COLUMN USER_NAMES.MAX_PROMISED_PAYMENT IS 'Максимальный обещанный платеж';
--#end if

CREATE SYNONYM WWW_DEALER.USER_NAMES FOR LONTANA.USER_NAMES;

GRANT SELECT, INSERT ON LONTANA.USER_NAMES TO WWW_DEALER;

alter table USER_NAMES add
(
  LAST_CRM_PHONEUNREF_ID NUMBER(10,0) DEFAULT 0,
  VIEW_OPERATOR_LOG NUMBER(1,0)
);

COMMENT ON COLUMN USER_NAMES.LAST_CRM_PHONEUNREF_ID IS 'Последнее использованное при логине ID пользователя октелл (рабочее место)';
COMMENT ON COLUMN USER_NAMES.VIEW_OPERATOR_LOG IS 'Права на просмотр логов. 1- разрешено; 0 - запрещено';

alter table USER_NAMES add(SHOW_BLOCK_UNBLOCK_BTN  INTEGER);
COMMENT ON COLUMN USER_NAMES.SHOW_BLOCK_UNBLOCK_BTN IS 'Возможность блокировки/разблокировки(Форма Инф.Абонената -> Тарифы и блокировки)';

alter table USER_NAMES add(  CRM_ADMIN INTEGER);

COMMENT ON COLUMN USER_NAMES.CRM_ADMIN IS 'признак влияет только на права в CRM, к десктопной версии отношения не имеет. 1- админ; 0 - обычный пользователь';

ALTER TABLE USER_NAMES ADD RIGHT_CANCEL_CONTRACT INTEGER;

COMMENT ON COLUMN USER_NAMES.RIGHT_CANCEL_CONTRACT IS 'Возможность расторжения договора';

ALTER TABLE USER_NAMES ADD CONTRACT_ACTIVE_CHAT INTEGER DEFAULT 0;

COMMENT ON COLUMN USER_NAMES.CONTRACT_ACTIVE_CHAT IS 'Признак занятости оператором общением с абонентом, указывает id контракта (0 - активного диалога нет)';

ALTER TABLE USER_NAMES ADD WORK_WITH_CHAT INTEGER DEFAULT 0;

COMMENT ON COLUMN USER_NAMES.WORK_WITH_CHAT IS 'Признак того, что пользователь может работать с чатом';

ALTER TABLE USER_NAMES ADD IS_NOT_BREAK_CHAT INTEGER DEFAULT 0;

COMMENT ON COLUMN USER_NAMES.IS_NOT_BREAK_CHAT IS 'Признак отмены разрыва чата по итогам неактивности в 10 мин'; 

alter table user_names add(tickets_per_page integer);

COMMENT ON COLUMN user_names.tickets_per_page is 'Количество заявок на старнице (Для CRM)';

alter table user_names add(work_with_tariff_activation integer);

COMMENT ON COLUMN user_names.work_with_tariff_activation is 'Возможность работы с заявками на активацию тарифов';