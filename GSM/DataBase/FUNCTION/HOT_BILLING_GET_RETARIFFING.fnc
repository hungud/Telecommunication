--#if GetVersion("HOT_BILLING_GET_RETARIFFING") < 6
CREATE OR REPLACE function HOT_BILLING_GET_RETARIFFING(
  CALL_ROW IN CALL_TYPE, pcost_koef IN number
  ) return CALL_TYPE IS
--
-- Перетарификация строки детализации
--
--#Version=6
--
-- 6. 30.12.2014 Уколов. Включил автороуминг.
-- 5. 22.09.2014 Крайнов. Добавил пересчет спецтарифа в GSMCorp.
-- 4. 28.07.2014 Уколов. Подключил перерасчет роуминга
-- 3. 27.07.2014 Уколов. В проверку роуминга отдаю и начальную, и пересчитанную стоимость.
--
  RESULT CALL_TYPE;
  cRECALC_SMS_2_0532_TO_2_95 VARCHAR2(100);
  pcost_chngf NUMBER;
BEGIN
  RESULT := CALL_ROW;
  --Ретарификация
  if CALL_ROW.ServiceType = 'S' then
    -- Для SMS делаем перерасчёт в GSM-Corp с 2,05 на 2,95
    cRECALC_SMS_2_0532_TO_2_95 := DB_LOADER_PCKG.GET_CONSTANT_VALUE('RECALC_SMS_2.0532_TO_2.95');
    if (cRECALC_SMS_2_0532_TO_2_95 = '1') and (Round(CALL_ROW.CALL_COST, 2) = 2.05) then
      RESULT.CALL_COST := 2.95;
    end if;
  end if;
  if nvl(CALL_ROW.AT_FT_CODE,'1') not in ('CBIN','CBOUT') then
       RESULT.CALL_COST := trunc(CALL_ROW.CALL_COST * pcost_koef,2);
  end if;
  IF MS_CONSTANTS.GET_CONSTANT_VALUE('SERVER_NAME') = 'GSM_CORP' THEN
    --Ретарификация 
    select count(*)
      into pcost_chngf
      from (SELECT regexp_substr(str, '[^,]+', 1, level) str
              FROM (SELECT MS_params.GET_PARAM_VALUE('HOT_BILL_RETARIF_ACCOUNT_ID') str
                      FROM dual) t
            CONNECT BY instr(str, ',', 1, level - 1) > 0) tt
     where tt.str = to_char(get_account_id_by_phone(CALL_ROW.SUBSCR_NO));
    if pcost_chngf > 0 then
      case CALL_ROW.ServiceType
        when 'S' then
          -- SMS
          if Round(CALL_ROW.CALL_COST, 2) = 2.95 then
            RESULT.CALL_COST := 2.5;
            RESULT.COST_CHNG:= RESULT.COST_CHNG - 0.45;
          end if;
        when 'C' then
          -- Call
          if InStr(Lower(CALL_ROW.AT_FT_DE), 'исх') > 0 then
            if CALL_ROW.CALL_COST = 0 then
              RESULT.CALL_COST := round(0.1 * ceil(CALL_ROW.dur / 60), 4);
              RESULT.COST_CHNG := RESULT.CALL_COST;
            else
              if (CALL_ROW.CALL_COST = 1.3452) or
                 (abs(CALL_ROW.CALL_COST - (CALL_ROW.dur / 60) * 1.3452) < 0.1) then
                RESULT.COST_CHNG := round(CALL_ROW.CALL_COST * 1.5 / 1.3452 -
                                    CALL_ROW.CALL_COST,
                                    4);
                RESULT.CALL_COST := round(CALL_ROW.CALL_COST * 1.5 / 1.3452, 4);
              end if;
            end if;
          end if;
        else
          null;
      end case;
    end if;  
  END IF;
  -- Поставим дату/время последнего роуминга, если нужно
  HOT_BILLING_UPDATE_LAST_ROAMNG(CALL_ROW, RESULT);
  -- Пересчет роуминга (перетарификация)
  HOT_BILLING_RETARIF_ROAMING(RESULT);
  RESULT.COST_CHNG := RESULT.CALL_COST - CALL_ROW.CALL_COST;
  RETURN(RESULT);
END;
/
--#end if
