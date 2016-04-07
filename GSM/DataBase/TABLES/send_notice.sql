CREATE TABLE send_notice
(
  phone_number		VARCHAR2(50),
  send_date_time	DATE,
  balance_notice	INTEGER 

);

CREATE INDEX i_send_notice_phone_number
ON send_notice (phone_number);

--GRANT SELECT, INSERT, UPDATE, DELETE ON  send_notice TO CORP_MOBILE_ROLE;
--GRANT SELECT ON send_notice TO CORP_MOBILE_ROLE_RO;

