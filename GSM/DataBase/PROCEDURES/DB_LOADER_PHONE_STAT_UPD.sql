create or replace procedure DB_LOADER_PHONE_STAT_UPD is

  pYEAR                     NUMBER;
  pMONTH                    NUMBER;
  pLOGIN                    VARCHAR2(50);
  pPHONE_NUMBER             VARCHAR2(11);
  pZEROCOST_OUTCOME_MINUTES NUMBER;
  pZEROCOST_OUTCOME_COUNT   NUMBER;
  pCALLS_COUNT              INTEGER;
  pCALLS_MINUTES            NUMBER;
  pCALLS_COST               NUMBER;
  pSMS_COUNT                INTEGER;
  pSMS_COST                 NUMBER;
  pMMS_COUNT                INTEGER;
  pMMS_COST                 NUMBER;
  pINTERNET_MB              NUMBER;
  pINTERNET_COST            NUMBER;

  call_t  varchar2(1);
  dur_t   number;
  cost_t  number;
  zero_t  number(1);
  count_t number;
  sum_t   number;
  uc_row rowid;
  cursor cur is
    select distinct uc.rowid,uc.year, uc.month, uc.login, uc.phone_number
      from DB_LOADER_PHONE_STAT_UPDate uc;
  --#Version=1
  cursor cur1 is
    select t1.c4,
           sum(t1.t11),
           round(sum(t1.c8), 2),
           decode(t1.c4, 'C', t1.t12, 'U', t1.t12, 'S', t1.t12, 1),
           count(*)
      from (select t.c3,
                   t.c4,
                   decode(to_number(t.c8,
                                    '99999999D9999',
                                    ' NLS_NUMERIC_CHARACTERS = '',.'''),
                          0,
                          ceil(to_number(t.c7,
                                         '99999999D9999',
                                         ' NLS_NUMERIC_CHARACTERS = '',.''') / 60),
                          to_number(t.c7,
                                    '99999999D9999',
                                    ' NLS_NUMERIC_CHARACTERS = '',.''')) t11,
                   t.c8,
                   decode(to_number(t.c8,
                                    '99999999D9999',
                                    ' NLS_NUMERIC_CHARACTERS = '',.'''),
                          0,
                          1,
                          2) t12
              from (select extractvalue(column_value, '/b/c[2]') || ' ' ||
                           extractvalue(column_value, '/b/c[3]') c3,
                           extractvalue(column_value, '/b/c[4]') c4,
                           extractvalue(column_value, '/b/c[7]') c7,
                           sum(to_number(extractvalue(column_value, '/b/c[8]'),
                                         '99999999D9999',
                                         ' NLS_NUMERIC_CHARACTERS = '',.''')) c8
                      from table(xmlsequence(xmltype('<a><b><c>' || replace(replace((select loader3_pckg.GET_PHONE_DETAIL(pYEAR,
                                                                                                                         pMONTH,
                                                                                                                         pPHONE_NUMBER)
                                                                                      from dual), chr(10), '</c></b><b><c>'), chr(9), '</c><c>') || '</c></b></a>')
                                             .extract('//b')))
                     group by extractvalue(column_value, '/b/c[2]') || ' ' ||
                              extractvalue(column_value, '/b/c[3]'),
                              extractvalue(column_value, '/b/c[4]'),
                              extractvalue(column_value, '/b/c[7]')) t) t1
     group by t1.c4,
              decode(t1.c4, 'C', t1.t12, 'U', t1.t12, 'S', t1.t12, 1);

BEGIN
  open cur;
  LOOP
    FETCH cur
      INTO uc_row,pYEAR, pMONTH, pLOGIN, pPHONE_NUMBER;
    EXIT WHEN cur%NOTFOUND;
    open cur1;
    sum_t                     := 0;
    pZEROCOST_OUTCOME_MINUTES := 0;
    pZEROCOST_OUTCOME_COUNT   := 0;
    pCALLS_COUNT              := 0;
    pCALLS_MINUTES            := 0;
    pCALLS_COST               := 0;
    pSMS_COUNT                := 0;
    pMMS_COUNT                := 0;
    pSMS_COST                 := 0;
    pMMS_COST                 := 0;
    pINTERNET_MB              := 0;
    pINTERNET_COST            := 0;
    LOOP
      FETCH cur1
        INTO call_t, dur_t, cost_t, zero_t, count_t;
      EXIT WHEN cur1%NOTFOUND;
      sum_t := sum_t + cost_t;
      case call_t
        when 'C' then
          if zero_t = 1 then
            pZEROCOST_OUTCOME_MINUTES := dur_t;
            pZEROCOST_OUTCOME_COUNT   := count_t;
          else
            pCALLS_COUNT   := count_t;
            pCALLS_MINUTES := round(dur_t / 60, 2);
            pCALLS_COST    := cost_t;
          end if;
        when 'S' then
          if zero_t <> 1 then
            pSMS_COUNT := count_t;
            pSMS_COST  := cost_t;
          end if;
        when 'U' then
          if zero_t <> 1 then
            pMMS_COUNT := count_t;
            pMMS_COST  := cost_t;
          end if;
        when 'G' then
          begin
            pINTERNET_MB   := pINTERNET_MB + dur_t / 1024;
            pINTERNET_COST := pINTERNET_COST + cost_t;
          end;
        when 'W' then
          begin
            pINTERNET_MB   := pINTERNET_MB + dur_t / 1024 / 1024;
            pINTERNET_COST := pINTERNET_COST + cost_t;
          end;
        else
          null;
      end case;
    END LOOP;
    close cur1;
    db_loader_pckg.SET_DB_LOADER_PHONE_STAT(pYEAR,
                                            pMONTH,
                                            pLOGIN,
                                            pPHONE_NUMBER,
                                            sum_t,
                                            pZEROCOST_OUTCOME_MINUTES,
                                            pZEROCOST_OUTCOME_COUNT,
                                            pCALLS_COUNT,
                                            pCALLS_MINUTES,
                                            pCALLS_COST,
                                            pSMS_COUNT,
                                            pSMS_COST,
                                            pMMS_COUNT,
                                            pMMS_COST,
                                            pINTERNET_MB,
                                            pINTERNET_COST);
    delete DB_LOADER_PHONE_STAT_UPDate dll
     where dll.rowid=uc_row;
    commit;
  END LOOP;
  close cur;
EXCEPTION
  WHEN others THEN
    null;
END;

--GRANT EXECUTE ON DB_LOADER_PHONE_STAT_UPD TO CORP_MOBILE_ROLE;

--GRANT EXECUTE ON DB_LOADER_PHONE_STAT_UPD TO CORP_MOBILE_ROLE_RO;  
