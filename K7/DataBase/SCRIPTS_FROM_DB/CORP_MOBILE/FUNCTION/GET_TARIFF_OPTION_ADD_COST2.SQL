
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_TARIFF_OPTION_ADD_COST2" (
  pACCOUNT_ID IN INTEGER,
  pYEAR_MONTH IN INTEGER,
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN NUMBER IS
/*--Version=3
  CURSOR C IS
    SELECT PO.TURN_ON_DATE,
           PO.TURN_OFF_DATE,
           TC.MONTHLY_COST,
           TC.OPERATOR_MONTHLY_COST,
           TC.TURN_ON_COST,
           TC.OPERATOR_TURN_ON_COST,
           PO.OPTION_CODE,
           V.DATE_BEGIN,
           V.DATE_END,
           V.TARIFF_ID,
           TC.TARIFF_OPTION_COST_ID,
           OP.DISCR_SPISANIE
      FROM DB_LOADER_ACCOUNT_PHONE_OPTS PO,
           V_BILL_ABON_PER_FOR_CLIENT V,
           TARIFF_OPTIONS OP,
           TARIFF_OPTION_COSTS TC
      WHERE PO.ACCOUNT_ID = pACCOUNT_ID
        AND PO.YEAR_MONTH = pYEAR_MONTH
        AND PO.PHONE_NUMBER = pPHONE_NUMBER
        AND V.ACCOUNT_ID = PO.ACCOUNT_ID
        AND V.YEAR_MONTH = PO.YEAR_MONTH
        AND V.PHONE_NUMBER = PO.PHONE_NUMBER
        AND V.TARIFF_CODE IS NOT NULL
        AND V.DATE_END > PO.TURN_ON_DATE
        AND PO.OPTION_CODE = OP.OPTION_CODE
        AND OP.TARIFF_OPTION_ID = TC.TARIFF_OPTION_ID
        AND TC.BEGIN_DATE <= V.DATE_BEGIN
        AND TC.END_DATE >= V.DATE_END;*/
  --Version=4 Дискретные услуги при смене тарифного плана в течении месяца НЕ учитываются теперь дважды как в версии 3      
    CURSOR C IS
    select q.TURN_ON_DATE,
           q.TURN_OFF_DATE,
           q.MONTHLY_COST,
           q.OPERATOR_MONTHLY_COST,
           q.TURN_ON_COST,
           q.OPERATOR_TURN_ON_COST,
           q.OPTION_CODE,
           min(q.DATE_BEGIN) DATE_BEGIN,
           max(q.DATE_END) DATE_END,
           max(q.TARIFF_ID) TARIFF_ID,
           q.TARIFF_OPTION_COST_ID,
           q.DISCR_SPISANIE
           from
   (SELECT PO.TURN_ON_DATE,
           PO.TURN_OFF_DATE,
           TC.MONTHLY_COST,
           TC.OPERATOR_MONTHLY_COST,
           TC.TURN_ON_COST,
           TC.OPERATOR_TURN_ON_COST,
           PO.OPTION_CODE,
           V.DATE_BEGIN,
           V.DATE_END,
           V.TARIFF_ID,
           TC.TARIFF_OPTION_COST_ID,
           OP.DISCR_SPISANIE
      FROM DB_LOADER_ACCOUNT_PHONE_OPTS PO,
           V_BILL_ABON_PER_FOR_CLIENT V,
           TARIFF_OPTIONS OP,
           TARIFF_OPTION_COSTS TC
      WHERE PO.ACCOUNT_ID = pACCOUNT_ID
        AND PO.YEAR_MONTH = pYEAR_MONTH
        AND PO.PHONE_NUMBER = pPHONE_NUMBER
        AND V.ACCOUNT_ID = PO.ACCOUNT_ID
        AND V.YEAR_MONTH = PO.YEAR_MONTH
        AND V.PHONE_NUMBER = PO.PHONE_NUMBER
        AND V.TARIFF_CODE IS NOT NULL
        AND V.DATE_END > PO.TURN_ON_DATE
        AND PO.OPTION_CODE = OP.OPTION_CODE
        AND OP.TARIFF_OPTION_ID = TC.TARIFF_OPTION_ID
        AND TC.BEGIN_DATE <= V.DATE_BEGIN
        AND TC.END_DATE >= V.DATE_END
        and NVL(OP.DISCR_SPISANIE, 0)=1) q
         group by q.TURN_ON_DATE,q.TURN_OFF_DATE,q.MONTHLY_COST,q.OPERATOR_MONTHLY_COST,q.TURN_ON_COST,
           q.OPERATOR_TURN_ON_COST,q.OPTION_CODE,q.TARIFF_OPTION_COST_ID,q.DISCR_SPISANIE
        union all
        (SELECT PO.TURN_ON_DATE,
           PO.TURN_OFF_DATE,
           TC.MONTHLY_COST,
           TC.OPERATOR_MONTHLY_COST,
           TC.TURN_ON_COST,
           TC.OPERATOR_TURN_ON_COST,
           PO.OPTION_CODE,
           V.DATE_BEGIN,
           V.DATE_END,
           V.TARIFF_ID,
           TC.TARIFF_OPTION_COST_ID,
           OP.DISCR_SPISANIE
      FROM DB_LOADER_ACCOUNT_PHONE_OPTS PO,
           V_BILL_ABON_PER_FOR_CLIENT V,
           TARIFF_OPTIONS OP,
           TARIFF_OPTION_COSTS TC
      WHERE PO.ACCOUNT_ID = pACCOUNT_ID
        AND PO.YEAR_MONTH = pYEAR_MONTH
        AND PO.PHONE_NUMBER = pPHONE_NUMBER
        AND V.ACCOUNT_ID = PO.ACCOUNT_ID
        AND V.YEAR_MONTH = PO.YEAR_MONTH
        AND V.PHONE_NUMBER = PO.PHONE_NUMBER
        AND V.TARIFF_CODE IS NOT NULL
        AND V.DATE_END > PO.TURN_ON_DATE
        AND PO.OPTION_CODE = OP.OPTION_CODE
        AND OP.TARIFF_OPTION_ID = TC.TARIFF_OPTION_ID
        AND TC.BEGIN_DATE <= V.DATE_BEGIN
        AND TC.END_DATE >= V.DATE_END
        and NVL(OP.DISCR_SPISANIE, 0)=0);      
        
  --Новые стоимости услуг (Приоретет 2)
  CURSOR NC(pTARIFF_ID IN INTEGER, pTARIFF_OPTION_COST_ID IN INTEGER) IS
    SELECT *
      FROM TARIFF_OPTION_NEW_COST NC
      WHERE NC.TARIFF_ID = pTARIFF_ID
        AND NC.TARIFF_OPTION_COST_ID = pTARIFF_OPTION_COST_ID;
  --Доп.группы услуг (Приоретет 1)
  CURSOR GC(PPhone in varchar2, pOption_code in varchar2, pOption_turn_date in date) IS
    select togc.bill_turn_on_cost,togc.bill_monthly_cost
      from contracts ct,tariff_option_group tog,tariff_option_group_costs togc
      where ct.option_group_id=tog.option_group_id and togc.option_group_id=tog.option_group_id
        and not exists (select 1 from contract_cancels cc where ct.contract_id=cc.contract_id and cc.contract_cancel_date<pOption_turn_date)--услуга подключена до закрытия договора
        and ct.phone_number_federal=PPhone
    --  and tog.date_created>=pOption_turn_date--группа создана до подключения услуги
     -- 11.12.2013 
       -- and tog.date_created<=pOption_turn_date 
        and togc.option_code=pOption_code
    ;  
  
  --      
  vGC GC%rowtype;      
  vDUMMY NC%ROWTYPE;   
  ITOG NUMBER(13, 2);    
  vBEGIN DATE;
  vEND DATE;         
  vBEGIN_YM DATE;
  vEND_YM DATE;   
  vTURN_ON_COST NUMBER(15, 2);  
  vMONTHLY_COST NUMBER(15, 2);    
BEGIN 
  ITOG:=0;
  vBEGIN_YM:=TO_DATE(TO_CHAR(pYEAR_MONTH)||'01', 'YYYYMMDD');
  vEND_YM:=LAST_DAY(vBEGIN_YM);
  FOR rec IN C LOOP
    --Открываем новые стоимости
    OPEN NC(rec.TARIFF_ID, rec.TARIFF_OPTION_COST_ID);
    FETCH NC INTO vDUMMY;
    --Откр.группы услуг
    OPEN GC(pPHONE_NUMBER,rec.OPTION_CODE,rec.TURN_ON_DATE);
    FETCH GC INTO vGC;
    
    if GC%found then
      vTURN_ON_COST:=NVL(vGC.bill_turn_on_cost, rec.TURN_ON_COST);
      vMONTHLY_COST:=NVL(vGC.bill_monthly_cost, rec.MONTHLY_COST);       
    elsIF NC%FOUND THEN
      vTURN_ON_COST:=NVL(vDUMMY.TURN_ON_COST_FOR_BILLS, rec.TURN_ON_COST);
      vMONTHLY_COST:=NVL(vDUMMY.MONTHLY_COST_FOR_BILLS, rec.MONTHLY_COST);   
    ELSE
      vTURN_ON_COST:=rec.TURN_ON_COST;
      vMONTHLY_COST:=rec.MONTHLY_COST; 
    END IF;
    CLOSE NC;
    CLOSE GC;
    vBEGIN:=rec.TURN_ON_DATE;
    IF vBEGIN < rec.DATE_BEGIN THEN
      vBEGIN:=rec.DATE_BEGIN;
    END IF;
    vEND:=NVL(rec.TURN_OFF_DATE, TO_DATE('20501231', 'YYYYMMDD'));
    IF vEND > rec.DATE_END THEN
      vEND:=rec.DATE_END;
    END IF;
   /* IF vTURN_ON_COST <> rec.OPERATOR_TURN_ON_COST THEN
      IF (rec.TURN_ON_DATE >= vBEGIN) AND (rec.TURN_ON_DATE <= vEND) THEN
        ITOG:=ITOG + vTURN_ON_COST - rec.OPERATOR_TURN_ON_COST;
      END IF;
    END IF;*/   -- как выяснилось платы за подключение идут в Разовых начислениях.
    IF vMONTHLY_COST <> rec.OPERATOR_MONTHLY_COST THEN
      IF NVL(rec.DISCR_SPISANIE, 0) = 1 THEN        
        ITOG:=ITOG + (vMONTHLY_COST - rec.OPERATOR_MONTHLY_COST);  
      ELSE
        ITOG:=ITOG + (vMONTHLY_COST - rec.OPERATOR_MONTHLY_COST)*(vEND - vBEGIN + 1)/(vEND_YM - vBEGIN_YM + 1);      
      END IF;
    END IF;
  END LOOP;
  RETURN ITOG;
END;

--GRANT EXECUTE ON GET_TARIFF_OPTION_ADD_COST2 TO SIM_TRADE_ROLE;

--GRANT EXECUTE ON GET_TARIFF_OPTION_ADD_COST2 TO LONTANA_ROLE;

--GRANT EXECUTE ON GET_TARIFF_OPTION_ADD_COST2 TO CORP_MOBILE_ROLE; 
