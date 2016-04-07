CREATE OR REPLACE procedure FULL_SEND_MAIL_LOG
(
pBODY_MAIL  out blob,
pVIRTUAL_ACCOUNTS_ID in Integer,  
pPERIOD              in integer,
pEMAIL               in varchar2,
pERROR               in varchar2,
pDELIVERED           in integer
) 
is
begin
  INSERT INTO SEND_MAIL_LOG (VIRTUAL_ACCOUNTS_ID, DATE_SEND, PERIOD, BODY_MAIL, EMAIL, ERROR, DELIVERED) 
                     VALUES (pVIRTUAL_ACCOUNTS_ID, sysdate, pPERIOD, empty_blob(), pEMAIL, pERROR, pDELIVERED) returning BODY_MAIL into  pBODY_MAIL;  
end;
/


GRANT EXECUTE ON FULL_SEND_MAIL_LOG TO BUSINESS_COMM_ROLE;