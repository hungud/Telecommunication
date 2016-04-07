create table AUTO_BLOCKED_PHONE(
  phone_number varchar2(50),
  Ballance number,
  Note varchar2(300 CHAR),
  BLOCK_DATE_TIME DATE,
  MANUAL_BLOCK NUMBER DEFAULT 0,
  USER_NAME VARCHAR2(30 CHAR),
  ABONENT_FIO VARCHAR2(100 CHAR),
  TICKET_ID NUMBER(11)
); 

ALTER TABLE AUTO_BLOCKED_PHONE ADD BLOCK_DATE_TIME  DATE;

UPDATE AUTO_BLOCKED_PHONE
 SET BLOCK_DATE_TIME=TO_DATE(DATE_OF_BLOCK || ' ' || Time_of_block, 'MM/DD/YYYY HH24:MI')
 WHERE BLOCK_DATE_TIME IS NULL;
 
ALTER TABLE AUTO_BLOCKED_PHONE ADD (MANUAL_BLOCK NUMBER DEFAULT 0);

ALTER TABLE AUTO_BLOCKED_PHONE ADD USER_NAME VARCHAR2(30 CHAR);

ALTER TABLE AUTO_BLOCKED_PHONE ADD ABONENT_FIO VARCHAR2(100 CHAR);

UPDATE AUTO_BLOCKED_PHONE
 SET ABONENT_FIO=CLIENT_SURNAME || ' ' || CLIENT_NAME
 WHERE ABONENT_FIO IS NULL;
 
CREATE INDEX I_AUTO_BLOCKED_PHONE ON AUTO_BLOCKED_PHONE(PHONE_NUMBER, BLOCK_DATE_TIME);

ALTER TABLE AUTO_BLOCKED_PHONE ADD TICKET_ID NUMBER(11);

update AUTO_BLOCKED_PHONE d
  set d.TICKET_ID = replace(d.note, 'Заявка на блок №', '')
  where d.TICKET_ID is null
    and d.NOTE like 'Заявка на блок №%';
    
update AUTO_BLOCKED_PHONE d
  set d.note = null
  --select * from AUTO_BLOCKED_PHONE d
  where d.TICKET_ID is not null
    and d.NOTE like 'Заявка на блок №%'
    and d.NOTE = 'Заявка на блок №'||d.TICKET_ID ;  
    
update AUTO_BLOCKED_PHONE d
  set d.TICKET_ID = replace(replace(d.note, 'Запрос № ', ''), ' на блокировку успешно отправлен', '')
  where d.TICKET_ID is null
    and d.NOTE like 'Запрос № %'
    and d.NOTE like '% на блокировку успешно отправлен';
    
update AUTO_BLOCKED_PHONE d
  set d.note = null
  --select * from AUTO_BLOCKED_PHONE d
  where d.TICKET_ID is not null
    and d.NOTE like 'Запрос № %'
    and d.NOTE like '% на блокировку успешно отправлен'; 