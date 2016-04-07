
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."API_CHECK_TICKETS" IS
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
  for c in (  
            select t.account_id,t.ticket_id from beeline_tickets t where t.answer is null and T.TICKET_ID = 2603038602 
           )
  loop
    res:=beeline_api_pckg.get_ticket_status(c.account_id,c.ticket_id);
    DBMS_OUTPUT.PUT_LINE('ОТвет '||res);
    counts:=counts+1;
    OPEN TICKET(c.ticket_id);
    FETCH TICKET INTO TICKET_DUMMY;
    IF (TICKET%FOUND) AND (TICKET_DUMMY.TICKET_TYPE = 15) THEN
      IF TICKET_DUMMY.ANSWER = 1 THEN        
        RES:=beeline_api_pckg.PHONE_OPTIONS(TICKET_DUMMY.PHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE('ОТвет '||res);
      END IF;
    END IF;
    CLOSE TICKET;
  end loop;
  --dbms_output.put_line('итого:'||counts);    
end;