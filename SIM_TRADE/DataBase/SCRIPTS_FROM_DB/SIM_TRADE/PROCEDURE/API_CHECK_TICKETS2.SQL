
  CREATE OR REPLACE PROCEDURE "SIM_TRADE"."API_CHECK_TICKETS2" (
  pACCOUNT_ID IN INTEGER
  ) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  res varchar2(1000);
  counts number;
  CURSOR TICKET(pTICKET_ID IN NVARCHAR2) IS 
    SELECT NVL(beeline_tickets.ANSWER, -1) ANSWER,
           beeline_tickets.PHONE_NUMBER,
           beeline_tickets.TICKET_TYPE
      FROM beeline_tickets
      WHERE beeline_tickets.TICKET_ID = pTICKET_ID;
  TICKET_DUMMY TICKET%ROWTYPE;
begin
  --dbms_output.enable(10000);
  for c in (select t.account_id,t.ticket_id from beeline_tickets t where t.answer is null AND T.ACCOUNT_ID = pACCOUNT_ID)
  loop
    res:=beeline_api_pckg.get_ticket_status(c.account_id,c.ticket_id);
    counts:=counts+1;
    OPEN TICKET(c.ticket_id);
    FETCH TICKET INTO TICKET_DUMMY;
    IF (TICKET%FOUND) AND (TICKET_DUMMY.TICKET_TYPE = 15) THEN
      IF TICKET_DUMMY.ANSWER = 1 THEN
        RES:=beeline_api_pckg.PHONE_OPTIONS(TICKET_DUMMY.PHONE_NUMBER);
      END IF;
    END IF;
    CLOSE TICKET;
  end loop;
  --dbms_output.put_line('итого:'||counts);    
end; 