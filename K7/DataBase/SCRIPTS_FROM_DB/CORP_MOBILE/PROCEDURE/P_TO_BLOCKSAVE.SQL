
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."P_TO_BLOCKSAVE" is 

CURSOR c_ep is 
select V.ACCOUNT_ID, V.PHONE_NUMBER, V.BALANCE, V.BEGIN_DATE
from V_PHONE_NUMBER_FOR_BLOCK_SAVE v
where NVL(V.DOP_STATUS,' ') <> 'ФРОД'
and V.PHONE_NUMBER <> '0884222349'
and V.PHONE_NUMBER not in (select phone_number from BLOCK_TO_BLOCKSAVE)
;

ptb c_ep%ROWTYPE;

--
begin
    open c_ep;
    
    loop--c_ep

        fetch c_ep into ptb;
        exit when c_ep%notfound;
        INSERT INTO BLOCK_TO_BLOCKSAVE(ACCOUNT_ID, PHONE_NUMBER, BALANCE, BEGIN_DATE, DATE_INSERT, TO_BLOCKSAVE, TEST_SUCCESS, ERR_TEXT)
            VALUES(ptb.ACCOUNT_ID, ptb.PHONE_NUMBER, ptb.BALANCE, ptb.BEGIN_DATE, sysdate, NULL, NULL, NULL);
        INSERT INTO PHONE_NUMBER_BLOCK_DENIED(PHONE_NUMBER) VALUES (ptb.PHONE_NUMBER);
        commit;
        end 
    loop;--c_ep

    close c_ep;

end P_TO_BLOCKSAVE;