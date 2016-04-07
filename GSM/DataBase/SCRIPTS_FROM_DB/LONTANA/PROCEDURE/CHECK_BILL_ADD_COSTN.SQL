
  CREATE OR REPLACE PROCEDURE "LONTANA"."CHECK_BILL_ADD_COSTN" IS
  -- Version = 1
  vYEAR_MONTH    INTEGER;
  phone_numberp  varchar2(10);
  account_idp    integer;
  date_beginp    date;
  date_endp      date;
  nphone_numberp varchar2(10) := '';
  naccount_idp   integer := 0;
  ndate_beginp   date := to_date('01.01.2001', 'dd.mm.yyyy');
  ndate_endp     date := to_date('31.12.2999', 'dd.mm.yyyy');
  fl             integer;
  calls_allp     number(15, 4) := 0;
  callsp         number(15, 4) := 0;
  smsp           number(15, 4) := 0;
  ncallsp        number(15, 4) := 0;
  nsmsp          number(15, 4) := 0;
  rr             rowid;
  CURSOR C IS
    select dlf.account_id,
           dlf.phone_number,
           dlf.date_begin,
           dlf.date_end,
           rowid
      from DB_LOADER_FULL_BILL_ABON_PER dlf
     where dlf.year_month = vYEAR_MONTH
       and dlf.tariff_code is not null
       and ((dlf.tariff_code in
           (SELECT regexp_substr(str, '[^,]+', 1, level) str
                FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILLING_TARIFF_RECALC_SMS') str
                        FROM dual) t
              CONNECT BY instr(str, ',', 1, level - 1) > 0)) or
           (dlf.account_id = 185))
    union all
    select ddf.account_id,
           ddf.phone_number,
           to_date(to_char(vYEAR_MONTH) || '01', 'yyyymmdd'),
           ADD_MONTHS(to_date(to_char(vYEAR_MONTH) || '01', 'yyyymmdd'), 1) - 1,
           null
      from db_loader_full_finance_bill ddf, DB_LOADER_ACCOUNT_PHONES dla
     where ddf.account_id = dla.account_id
       and ddf.year_month = vYEAR_MONTH
       and ddf.year_month = dla.year_month
       and ddf.phone_number = dla.phone_number
       and not exists (select 1
              from DB_LOADER_FULL_BILL_ABON_PER dlf
             where dlf.year_month = ddf.year_month
               and dlf.phone_number = ddf.phone_number
               and dlf.account_id = ddf.account_id)
       and ddf.bill_sum <> 0
       and ((dla.cell_plan_code in
           (SELECT regexp_substr(str, '[^,]+', 1, level) str
                FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILLING_TARIFF_RECALC_SMS') str
                        FROM dual) t
              CONNECT BY instr(str, ',', 1, level - 1) > 0)) or
           (dla.account_id = 185))
     order by 1, 2, 3, 4;
begin
  vYEAR_MONTH := TO_NUMBER(TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM'));
  open c;
  loop
    FETCH c
      into account_idp, phone_numberp, date_beginp, date_endp, rr;
    EXIT WHEN c%NOTFOUND;
    --скидываем суммы
    if (nphone_numberp <> phone_numberp or naccount_idp <> account_idp) and
       (naccount_idp <> 0) then
      if calls_allp > 0 then
        SELECT count(*)
          into fl
          FROM BILL_RECALC_ADD_COST
         WHERE ACCOUNT_ID = naccount_idp
           AND YEAR_MONTH = vYEAR_MONTH
           AND PHONE_NUMBER = nphone_numberp;
        if fl > 0 then
          UPDATE BILL_RECALC_ADD_COST BR
             SET BR.CALLS_ALL = calls_allp,
                 BR.CALLS     = callsp,
                 BR.SMS       = SMSp
           WHERE BR.ACCOUNT_ID = naccount_idp
             AND BR.YEAR_MONTH = vYEAR_MONTH
             AND BR.PHONE_NUMBER = nphone_numberp;
        ELSE
          INSERT INTO BILL_RECALC_ADD_COST
            (ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, CALLS_ALL, CALLS, SMS)
          VALUES
            (naccount_idp,
             vYEAR_MONTH,
             nphone_numberp,
             calls_allp,
             callsp,
             SMSp);
        END IF;
        commit;
      end if;
      nphone_numberp := '';
      naccount_idp   := 0;
      ndate_beginp   := to_date('01.01.2001', 'dd.mm.yyyy');
      ndate_endp     := to_date('31.12.2999', 'dd.mm.yyyy');
      calls_allp     := 0;
      callsp         := 0;
      smsp           := 0;
      ncallsp        := 0;
      nsmsp          := 0;
    end if;
  
    --if (nphone_numberp=phone_numberp and naccount_idp = account_idp) or (naccount_idp = 0) then
    select count(*)
      into fl
      from DB_LOADER_FULL_BILL_ABON_PER dlf
     where dlf.account_id = account_idp
       and dlf.year_month = vYEAR_MONTH
       and dlf.phone_number = phone_numberp
       and ((dlf.date_begin <= date_endp) or
           (dlf.date_begin = date_endp + 1))
       and dlf.date_end > date_beginp
       and rowid <> rr
       and dlf.tariff_code in
           (SELECT regexp_substr(str, '[^,]+', 1, level) str
              FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILLING_TARIFF_RECALC_SMS') str
                      FROM dual) t
            CONNECT BY instr(str, ',', 1, level - 1) > 0);
    if fl = 0 then
      if (naccount_idp = 0) or (date_beginp > ndate_endp + 1) then
        nphone_numberp := phone_numberp;
        naccount_idp   := account_idp;
        ndate_beginp   := date_beginp;
        ndate_endp     := date_endp;
      else
        ndate_endp := date_endp;
      end if;
      execute immediate 'select sum(c.cost_chng) from call_' ||
                        TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MM_YYYY') || ' c
          where c.subscr_no=''' || nphone_numberp || '''
          and c.servicetype=''C''
          and c.start_time between to_date(''' ||
                        to_char(ndate_beginp, 'dd.mm.yyyy') ||
                        ''',''dd.mm.yyyy'') and to_date(''' ||
                        to_char(ndate_endp + 1 - 1 / 86400,
                                'dd.mm.yyyy hh24:mi:ss') ||
                        ''',''dd.mm.yyyy hh24:mi:ss'')'
        into ncallsp;
      execute immediate 'select sum(c.cost_chng) from call_' ||
                        TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MM_YYYY') || ' c
          where c.subscr_no=''' || nphone_numberp || '''
          and c.servicetype=''S''
          and c.start_time between to_date(''' ||
                        to_char(ndate_beginp, 'dd.mm.yyyy') ||
                        ''',''dd.mm.yyyy'') and to_date(''' ||
                        to_char(ndate_endp + 1 - 1 / 86400,
                                'dd.mm.yyyy hh24:mi:ss') ||
                        ''',''dd.mm.yyyy hh24:mi:ss'')'
        into nsmsp;
      callsp     := callsp + ncallsp;
      smsp       := smsp + nsmsp;
      calls_allp := callsp + smsp;
    else
      if (naccount_idp = 0) or (date_beginp > ndate_endp + 1) then
        nphone_numberp := phone_numberp;
        naccount_idp   := account_idp;
        ndate_beginp   := date_beginp;
        ndate_endp     := date_endp;
      else
        ndate_endp := date_endp;
      end if;
    end if;
  end loop;
  close c;
  if calls_allp > 0 then
    SELECT count(*)
      into fl
      FROM BILL_RECALC_ADD_COST
     WHERE ACCOUNT_ID = naccount_idp
       AND YEAR_MONTH = vYEAR_MONTH
       AND PHONE_NUMBER = nphone_numberp;
    if fl > 0 then
      UPDATE BILL_RECALC_ADD_COST BR
         SET BR.CALLS_ALL = calls_allp, BR.CALLS = callsp, BR.SMS = SMSp
       WHERE BR.ACCOUNT_ID = naccount_idp
         AND BR.YEAR_MONTH = vYEAR_MONTH
         AND BR.PHONE_NUMBER = nphone_numberp;
    ELSE
      INSERT INTO BILL_RECALC_ADD_COST
        (ACCOUNT_ID, YEAR_MONTH, PHONE_NUMBER, CALLS_ALL, CALLS, SMS)
      VALUES
        (naccount_idp,
         vYEAR_MONTH,
         nphone_numberp,
         calls_allp,
         callsp,
         SMSp);
    END IF;
    commit;
    /*nphone_numberp := '';
    naccount_idp   := 0;
    ndate_beginp   := to_date('01.01.2001', 'dd.mm.yyyy');
    ndate_endp     := to_date('31.12.2999', 'dd.mm.yyyy');
    calls_allp     := 0;
    callsp         := 0;
    smsp           := 0;
    ncallsp        := 0;
    nsmsp          := 0;*/
  end if;
end;
