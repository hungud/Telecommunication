
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."UNBLOCK_FOR_BLOCKSAVE" is 

CURSOR c_ep is
select btb.phone_number
from BLOCK_TO_BLOCKSAVE btb
where btb.to_blocksave is null
and btb.PHONE_NUMBER not in (select bt.phone_number
                            from BEELINE_TICKETS bt
                            where trunc(bt.DATE_CREATE) = trunc(sysdate)
                            and BT.TICKET_TYPE = 10
                            and bt.phone_number = btb.phone_number
                            and (BT.ANSWER = 1 or BT.ANSWER IS NULL)
                            and BT.DATE_CREATE = (select max(DATE_CREATE) 
                                                    from BEELINE_TICKETS
                                                    where trunc(DATE_CREATE) = trunc(sysdate)
                                                    and TICKET_TYPE = BT.TICKET_TYPE
                                                    and phone_number = bt.phone_number))
;

CURSOR c_en is 
select btb.phone_number
from BLOCK_TO_BLOCKSAVE btb
where btb.to_blocksave is null
and btb.err_text like '%Заявка на разблок%'
and btb.PHONE_NUMBER in (select bt.phone_number
                            from BEELINE_TICKETS bt
                            where trunc(bt.DATE_CREATE) = trunc(sysdate)
                            and BT.TICKET_TYPE = 10
                            and bt.phone_number = btb.phone_number
                            and BT.ANSWER = 1
                            and BT.DATE_CREATE = (select max(DATE_CREATE) 
                                                    from BEELINE_TICKETS
                                                    where trunc(DATE_CREATE) = trunc(sysdate)
                                                    and TICKET_TYPE = BT.TICKET_TYPE
                                                    and phone_number = bt.phone_number))
;

ptb c_ep%ROWTYPE;
ptn c_en%ROWTYPE;
UNLOCK_PN varchar2(2000 char);

--
begin
    open c_en;
    
    loop--c_en

        fetch c_en into ptn;
        exit when c_en%notfound;
        UPDATE BLOCK_TO_BLOCKSAVE SET TO_BLOCKSAVE = 1 where  PHONE_NUMBER = ptn.PHONE_NUMBER ;
        commit;
        end 
    loop;--c_en

    close c_en;
    
    open c_ep;
    
    loop--c_ep

        fetch c_ep into ptb;
        exit when c_ep%notfound;
        UNLOCK_PN := BEELINE_API_PCKG.UNLOCK_PHONE(ptb.phone_number);
        UPDATE BLOCK_TO_BLOCKSAVE SET ERR_TEXT = UNLOCK_PN  
            where  PHONE_NUMBER = ptb.PHONE_NUMBER ;
        commit;
        end 
    loop;--c_ep

    close c_ep;

end UNBLOCK_FOR_BLOCKSAVE;