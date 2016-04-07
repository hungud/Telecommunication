CREATE TABLE control_beeline_tickets_log(
  CONTROL_LOG_ID INTEGER,
  PHONE_NUMBER VARCHAR2(10 CHAR),
  CONTROL_TYPE INTEGER,
  TICKET_ID_ERROR NVARCHAR2(15),
  DATE_CREATED DATE,
  RESULT_STR VARCHAR2(1000 CHAR)
  );

COMMENT ON TABLE control_beeline_tickets_log IS 'Лог отслеживания блокировок';
COMMENT ON COLUMN control_beeline_tickets_log.control_log_id IS 'Первичный ключ';
COMMENT ON COLUMN control_beeline_tickets_log.phone_number IS 'Номер телефона';
COMMENT ON COLUMN control_beeline_tickets_log.control_type IS 'Тип отслеживания (1 - отправка заявки в Би, 2 - в очередь на переблокировку, 3 - отправка e-mail на agsv@k7.ru, 0 - ошибка)';
COMMENT ON COLUMN control_beeline_tickets_log.ticket_id_error IS 'Номер ошибочной заявки в Би';
COMMENT ON COLUMN control_beeline_tickets_log.date_created IS 'Дата создания';
COMMENT ON COLUMN control_beeline_tickets_log.result_str IS 'Результат';

ALTER TABLE  control_beeline_tickets_log ADD (
  CONSTRAINT PK_control_log_id
  PRIMARY KEY
  (control_log_id)
  USING INDEX);

CREATE INDEX control_beeline_tickets_log_PN ON control_beeline_tickets_log(PHONE_NUMBER);

CREATE SEQUENCE S_NEW_CONTROL_LOG_ID
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE OR REPLACE FUNCTION NEW_CONTROL_LOG_ID RETURN NUMBER IS
--#Version=1
  vRES NUMBER;
BEGIN
  SELECT S_NEW_CONTROL_LOG_ID.NEXTVAL
  INTO vRES
  FROM DUAL;
  RETURN vRES;
END;

CREATE OR REPLACE TRIGGER TI_control_beeline_tickets_log
  BEFORE INSERT ON control_beeline_tickets_log FOR EACH ROW
--#Version=1
BEGIN
    IF NVL(:NEW.CONTROL_LOG_ID, 0) = 0 then
      :NEW.CONTROL_LOG_ID := NEW_CONTROL_LOG_ID;
    END IF;
END;

GRANT SELECT, INSERT, UPDATE, DELETE ON control_beeline_tickets_log TO CORP_MOBILE_ROLE;
GRANT SELECT ON control_beeline_tickets_log TO CORP_MOBILE_ROLE_RO;
