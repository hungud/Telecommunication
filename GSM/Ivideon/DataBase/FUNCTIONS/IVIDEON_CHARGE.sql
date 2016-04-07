CREATE OR REPLACE FUNCTION IVIDEON_CHARGE 
(
  pPARAMS_IN_JSON in varchar2,
  pORIGN_URL in varchar2

)
  RETURN INTEGER
  AS
  
--
--#VERSION=1
--
--
--v.1 01.02.2016 - Функция обрабатывающая запросы на списание от Ivideon
--                Если списание невозможно, то возвращаем 0, если возможно, то 1
--  
  
--POST http://ivideon.gsmcorp.tarifer.ru/api/ivideon/charge

--{
--   "url":"http://ivideon.gsmcorp.tarifer.ru/api/ivideon/charge",
--   "period_cost":"0",
--   "periodCost":"0",
--   "userId":"100000884138",
--   "purpose_data":{
--      "camera":"0",
--      "cost":10000,
--      "server_name":"w",
--      "action":100013982385,
--      "tariff":"g-cam--old--minin-oco",
--      "camera_name":"C",
--      "expires":1456481506,
--      "type":"cam_tariff-buy",
--      "period":"month_1",
--      "server":"100-3380c8aab5fb80d5ed56f71fab9a912c"
--   },
--   "purposeId":"cam_tariff>buy",
--   "currency":"RUR",
--   "amount":"10000",
--   "extUserId":"263",
--   "paymentId":"100013982386"
--}
  
  --ТИП СПИСАНИМ СТАВИМ КАК СПИСАНИЕ АБОН ПЛАТЫ ЗА ТАРИФ
  cSERVICE_TYPE_ID  CONSTANT SERVICE_TYPES.SERVICE_TYPE_ID%TYPE := 2;

  vRes Integer;
  vCurrentBal NUMBER(10,2);
  v_ct integer;
  v_obj json;
  
  v_url varchar2(500 char);

  v_period_cost  NUMBER(10,2);
  v_periodCost   NUMBER(10,2);
  v_userId       INTEGER;
  v_camera       INTEGER;
  v_cost         NUMBER(10,2);
  v_server_name  VARCHAR2(5 CHAR);
  v_action       INTEGER;
  v_tariff       VARCHAR2(150 CHAR);
  v_camera_name  VARCHAR2(5 CHAR);
  v_expires      INTEGER;
  v_type         VARCHAR2(150 CHAR);
  v_period       VARCHAR2(20 CHAR);
  v_server       VARCHAR2(150 CHAR);
  v_purposeId    VARCHAR2(150 CHAR);
  v_currency     VARCHAR2(3 CHAR);
  v_amount       NUMBER(10,2);
  v_extUserId    INTEGER;
  v_paymentId    INTEGER;
  
  vTARIFF_ID TARIFFS.TARIFF_ID%TYPE;
  vPurposeId PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_ID%TYPE;
  
  vREQUEST_ID IVIDEON_REQUEST_LOG.REQUEST_ID%TYPE;
    
  
  function get_date(pJSON json, section_name varchar2) return varchar2
  is
   vRes varchar2(200 char);
  begin
    vRes := '';
    
    if pJSON.exist(section_name) then
      vRes := pJSON.get (section_name).get_string;
    else
      vRes := '';
    end if;
    
    --dbms_output.put_line(section_name||' = '||vRes);
    Return vRes;
  end;
  
  --возвращает переданную строку как сумму
  --деление на 100 нужно, т.к. сумма приходит в копейках
  function get_cost (pAmmount varchar2) return number
  is
    vRes number;
  begin
    vRes := to_number(pAmmount) / 100;
  --  dbms_output.put_line('pAmmount = '||vRes);
    Return vRes;
  end;
  
  --возвращаем ID тарифного плана по которому делаем списание
  function get_tariff_id (pTariffCode varchar2) return INTEGER
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
    vRes integer;
    vTariffCode TARIFFS.TARIFF_NAME%TYPE ;
  begin
    vTariffCode := trim(pTariffCode);
    merge into tariffs t
      using (select vTariffCode as TariffCode from dual)tab
      on
        (upper(t.tariff_code) = upper(tab.TariffCode))
    when not matched then
      insert (tariff_code, tariff_name, monthly_cost, is_dayly_tariff) values (tab.TariffCode, tab.TariffCode, -1, 0);
      
    select tariff_id into vRes
     from tariffs t
    where upper(t.tariff_name) = upper(vTariffCode);
    
    COMMIT;
    
    Return vRes;  
  end;
  
  --возвращаем ID типа платежа
  function get_purpose_Id (pPurposeName varchar2) return INTEGER
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
    vRes integer;
    vPurposeCode PAYMENT_PURPOSE_TYPE.PAYMENT_PURPOSE_CODE%TYPE ;
  begin
    vPurposeCode := trim(pPurposeName);
    merge into PAYMENT_PURPOSE_TYPE t
      using (select vPurposeCode as PurposeCode from dual)tab
      on
        (upper(T.PAYMENT_PURPOSE_CODE) = upper(tab.PurposeCode))
    when not matched then
      insert (PAYMENT_PURPOSE_CODE, PAYMENT_PURPOSE_DESC) values (tab.PurposeCode, tab.PurposeCode);
      
    select PAYMENT_PURPOSE_ID into vRes
     from PAYMENT_PURPOSE_TYPE t
    where upper(T.PAYMENT_PURPOSE_CODE) = upper(vPurposeCode);
    
    COMMIT;
    
    Return vRes;  
  end;
  
  
BEGIN

  vRes := 0;
  
  --добавим запрос в лог
  INSERT INTO IVIDEON_REQUEST_LOG (ORIGINAL_URL, URL_PARAMETRS)
  values(pORIGN_URL, pPARAMS_IN_JSON)
  RETURNING REQUEST_ID INTO vREQUEST_ID;
  
  v_obj := json(pPARAMS_IN_JSON);
  
  
  v_period_cost := get_cost(get_date(v_obj, 'period_cost'));
  v_periodCost  := get_cost(get_date(v_obj, 'periodCost'));
  v_userId  := to_number(get_date(v_obj, 'userId'));
  v_purposeId   := get_date(v_obj, 'purposeId');
  v_currency    := get_date(v_obj, 'currency');
  v_amount       := get_cost(get_date(v_obj, 'amount'));
  v_extUserId   := to_number(get_date(v_obj, 'extUserId'));
  v_paymentId    := to_number(get_date(v_obj, 'paymentId'));
  
  v_obj := JSON_EXT.GET_JSON(v_obj, 'purpose_data');

  v_camera  := to_number(get_date(v_obj, 'camera'));
  v_cost  := get_cost(get_date(v_obj, 'cost'));
  v_server_name  := get_date(v_obj, 'server_name');
  v_action   := to_number(get_date(v_obj, 'action'));
  v_tariff    := get_date(v_obj, 'tariff');
  v_camera_name  := get_date(v_obj, 'camera_name');
  v_expires    := to_number(get_date(v_obj, 'expires'));
  v_type      := get_date(v_obj, 'type');
  v_period     := get_date(v_obj, 'period');
  v_server      := get_date(v_obj, 'server'); 
  
  
  if v_extUserId is not null and v_amount is not null then
    
    --проверяем на наличие пользователя у нас
    select count(*) into v_ct from IVIDEON_ABONENTS ia
    where IA.ABONENT_ID = v_extUserId;
    
    if nvl(v_ct, 0) > 0 then
      
        -- переесчитатаем баланс на всякий случай
        CALC_BALANCE(v_extUserId);

        --получаем текущий баланс
        select balance into vCurrentBal
        from ABONENT_BALANCE ab
        where AB.ABONENT_ID = v_extUserId;
        
        vCurrentBal := nvl(vCurrentBal, 0);
        
        -- проверяем хватает ли денег для списания
        if (vCurrentBal - v_amount) >= 0 then
          --пишем в лог
          vCurrentBal := vCurrentBal - v_amount;
          vTARIFF_ID := get_tariff_id(v_tariff);
          vPurposeId := get_purpose_Id(v_purposeId);
          
          --уменьшаем баланс на сумму списания
          MERGE INTO ABONENT_BALANCE ab
          using
            (SELECT vCurrentBal BALANCE_AFTER,
                    v_extUserId ABONENT_ID
              FROM dual
            )HIST
          ON
            (AB.ABONENT_ID  = HIST.ABONENT_ID)   
          WHEN MATCHED THEN
            UPDATE SET
              BALANCE = HIST.BALANCE_AFTER 
            
          WHEN NOT MATCHED THEN
            INSERT
              (ABONENT_ID, BALANCE)
            values
              (HIST.ABONENT_ID, HIST.BALANCE_AFTER );
          
          
          --добавляем запись о списании в историю
          
          ADD_ABONENT_BALANCE_HISTORY (
                                       v_extUserId,
                                       sysdate,
                                       v_amount,
                                       vCurrentBal,
                                       cSERVICE_TYPE_ID,
                                       vTARIFF_ID,
                                       v_paymentId,
                                       vPurposeId,
                                       vREQUEST_ID
              );
          
          vRes := 1;
            
        else
          vRes := 0;
        end if;
         
    end if;--nvl(v_ct, 0) > 0
    
    
  end if;--if v_extUserId is not null then 
  

  Return vRes;
END;  
