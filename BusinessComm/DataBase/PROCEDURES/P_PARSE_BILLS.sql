CREATE OR REPLACE PROCEDURE P_PARSE_BILLS AS
--
--#Version=3
--
--
--v.3 Афросин 16.02.2016 - Изменения касательно новой структуры.Касательно filial_id
--v.2 Афросин 19.10.2015 - добавил загрузку наименований тарифов из файла счетов
--v.1 Афросин 12.10.2015 - процеедура разбора распарсенных файлов счетов
--
--
--константы позиций полей в распарснном файле  
  C_SELF_NUMBER_IDX CONSTANT INTEGER := 1;
  C_SERVICE_DATE_IDX CONSTANT INTEGER := 2;
  C_SERVICE_TIME_IDX CONSTANT INTEGER := 3;
  C_OTHER_NUMBER_IDX CONSTANT INTEGER := 4;
  C_SERVICE_DIRECTION_IDX CONSTANT INTEGER := 5;
  C_SERVICE_TYPE_IDX CONSTANT INTEGER := 6;
  C_DURATION_SECONDS_IDX CONSTANT INTEGER := 7;
  C_COST_IDX CONSTANT INTEGER := 8;
  C_IS_GROUP_IDX CONSTANT INTEGER := 9;
  C_ROAMING_TYPE_IDX CONSTANT INTEGER := 10;
  C_SELF_ZONE_IDX CONSTANT INTEGER := 11;
  C_OTHER_ZONE_IDX CONSTANT INTEGER := 12;
  C_ADD_INFO_IDX CONSTANT INTEGER := 13;
  C_ACCOUNT_NO_IDX CONSTANT INTEGER := 14;
--  C_LINE_POS_IDX CONSTANT INTEGER := 15;
--  C_LINE_LENGTH_IDX CONSTANT INTEGER := 16;
  C_ORIGIN_COST_IDX CONSTANT INTEGER := 17;
  C_COST_WITHOUT_VAT_IDX CONSTANT INTEGER := 18;
  C_BILL_NUMBER_IDX CONSTANT INTEGER := 19;
  C_BILL_DATE_IDX CONSTANT INTEGER := 20;
  C_PHONE_LIMIT_IDX CONSTANT INTEGER := 21;
  C_PHONE_CHARGE_LIMIT_IDX CONSTANT INTEGER := 22;
  C_OPTIONS_IDX CONSTANT INTEGER := 23;
  C_CASCADE_NUMBER_IDX CONSTANT INTEGER := 24;
  
  C_FIRST_CASCASE CONSTANT INTEGER := 1;
  C_SERVICE_PHONE CONSTANT PHONES.PHONE_NUMBER%TYPE := '0000000000';
  
  С_PARSED_FILE_STATUS CONSTANT INTEGER := 1;
  С_ERROR_PARSE_STATUS CONSTANT INTEGER := 4;
  C_NO_ERROR_STATUS  CONSTANT INTEGER := 2;
  
  TYPE T_PARSED_FILE_TEMP IS TABLE OF PARSED_FILE_TEMP%ROWTYPE INDEX BY PLS_INTEGER;
  arr_PARSED_FILE_TEMP T_PARSED_FILE_TEMP;
  ARR_IDX INTEGER;
  
  obj         json;
  j_data      json;
  tmpobj      json_list;
  v_data     clob;
  
  str varchar2(5000);
  
  v_phone_id PHONES.PHONE_ID%TYPE;
  
  vBILL_FILE_STATUS_ID DB_LOADER_BILL_LOAD_LOG.BILL_FILE_STATUS_ID%TYPE;
  
  TYPE T_ARR_PHONE IS TABLE OF PHONES.PHONE_ID%TYPE INDEX BY PLS_INTEGER;
  TYPE T_ARR_TARIFFS IS TABLE OF TARIFFS.TARIFF_NAME%TYPE INDEX BY PLS_INTEGER;
  
--  v_phone_id_arr T_ARR_PHONE;
--  v_tar_name_arr T_ARR_TARIFFS;
  
  
  cursor BILL_FILES is
    select
      db.log_bill_id,
      db.account_id,
      db.year_month,
      ACC.FILIAL_ID
    from
      DB_LOADER_BILL_LOAD_LOG db,
      accounts acc
    where
      db.BILL_FILE_STATUS_ID = С_PARSED_FILE_STATUS-- статус того, что файл прошел парсинг из загруженного формата во внутренний 
      and db.ACCOUNT_ID  = ACC.ACCOUNT_ID;
      
  -- Выделяет N-ное по счёту слово от начала (или конца) строки Str.

  FUNCTION Extract_Word (vList                IN VARCHAR2,
                         nItemNumber          IN NUMBER,
                         vListItemDelimiter   IN VARCHAR2 DEFAULT chr(9))
    RETURN VARCHAR2
  IS
    nItemPosition   NUMBER;
    nItemLength     NUMBER;
   BEGIN
    nItemPosition := INSTR (
                            vListItemDelimiter || vList,
                            vListItemDelimiter,
                           1,
                           nItemNumber
                          );

    nItemLength := INSTR (
                          vList || vListItemDelimiter,
                          vListItemDelimiter,
                          1,
                         nItemNumber
                        )
                        - nItemPosition;
    RETURN TRIM (SUBSTR (vList, nItemPosition, nItemLength));
   END;
   
  
   --проверяем на существование тарифного плана у нас в базе
   --если тарифа еще нет, то добавляем
  procedure CHECK_TARIFF_NAME (pTARIFF_NAME varchar2, pFILIAL_ID integer ) as
    PRAGMA AUTONOMOUS_TRANSACTION;
    
    vTariffName TARIFFS.TARIFF_NAME%TYPE;
  begin
    vTariffName := trim(pTARIFF_NAME);
    
    if vTariffName is not null then
      MERGE INTO TARIFFS t
      USING (
              SELECT vTariffName TariffName FROM DUAL
            ) tmp
      on (
           upper(trim(t.TARIFF_NAME)) = Upper(tmp.TariffName) 
         )
      when not matched then
        Insert (
                 TARIFF_CODE,
                 TARIFF_NAME,
                 FILIAL_ID
               )
        Values (
                 'NO_TARIFF_CODE',
                  tmp.TariffName,
                  pFILIAL_ID
               );
    end if;
    
    commit;
    
  end;
  
  
  --функция возвращает PHONE_ID по номеру телефона
  
  function GET_PHONE_ID (pPhone varchar2) RETURN PHONES.PHONE_ID%TYPE as
   
   PRAGMA AUTONOMOUS_TRANSACTION; 
  
    vPhone PHONES.PHONE_NUMBER%TYPE ;
    vlPHONE_ID PHONES.PHONE_ID%TYPE;
    
  begin
    vPhone := nvl(pPhone, C_SERVICE_PHONE);
    
    select
      max(phone_id) into vlPHONE_ID
    from
      PHONES
    where
      phone_number = vPhone;
    
    if nvl(vlPHONE_ID, -1) = -1 then
      
      
      INSERT INTO
        PHONES (PHONE_ID, PHONE_NUMBER)
      VALUES
        (to_number (vPhone), vPhone)
      RETURNING phone_id INTO vlPHONE_ID;
      
      commit;
      
    end if;
  
    RETURN vlPHONE_ID;  
  end;
  
  --ВОЗВРАЩАЕТ ПОЛУЧЕННЫЕ СТРОКИ  ВРЕМЕНИ И ДАТЫ В ТИП date
  function get_date_time (pDate varchar2, pTime varchar2) RETURN DATE as
    vTempDate varchar2(10 char);
    vTempTime varchar2(8 char);
  begin
   
    if trim(pDate) is not null then
      vTempDate := pDate;
    else
      vTempDate := '01.01.3000';
    end if;
    
    if trim(pTime) is not null then
      vTempTime := pTime;
    else
      vTempTime := '00:00:00';
   end if;
   
   --dbms_output.put_line('vTempDate vTempTime'||vTempDate ||' '||vTempTime);
   
   RETURN to_date (vTempDate ||' '||vTempTime, 'dd.mm.yyyy hh24:mi:ss');  
    
  end;
  
  --Возвращает длительность развоговра в секундах
  --если это звонок
  function get_duration (pServiceType varchar2, pDur varchar2) RETURN NUMBER as
    vGet_duration number;
    vHour varchar2(5 char);
    vMinute varchar2(5 char);
    vSecond varchar2(5 char);
    vCount integer;
    vDur varchar2(50 char);
  begin
    vDur := nvl(pDur, 0);
    if pServiceType = 'C' then
    
      --выясняем количество ":" в строке
      select length(vDur) - length(replace(vDur,':')) into vCount from dual;
      
      --если вхождений 1, то формат мм:сс
      --если 2, то чч:мм:сс
      
      case vCount
        when 2 then
          vHour := nvl(Extract_Word(vDur, 1, ':'), '0');
          vMinute := nvl(Extract_Word(vDur, 2, ':'), '0');
          vSecond := nvl(Extract_Word(vDur, 3, ':'), '0');
          vGet_duration := to_number(vHour)*60*60 + to_number(vMinute)*60 + to_number(vSecond);
        when 1 then
          vHour := 0;
          vMinute := nvl(Extract_Word(vDur, 1, ':'), '0');
          vSecond := nvl(Extract_Word(vDur, 2, ':'), '0');
          vGet_duration := to_number(vMinute)*60 + to_number(vSecond);
      else
        vGet_duration := to_number(vDur);
      end case;
      
         
    else
      vGet_duration := to_number(vDur);
    end if;
  
    RETURN to_number(vGet_duration);
  end;
  
  
       
BEGIN

  
  for  c in BILL_FILES loop
    begin  
      select parsed_file_text into v_data
      from
        DB_LOADER_BILL_LOAD_LOG
      where
        LOG_BILL_ID = c.log_bill_id;
      
      EXECUTE IMMEDIATE 'TRUNCATE TABLE PARSED_FILE_TEMP';
      IF v_data IS NOT NULL THEN
        obj := json (v_data);
        j_data := JSON_EXT.GET_JSON(obj, 'data');

        tmpobj := json_ext.get_json_list (j_data, 'detail_rows');
         
        ARR_IDX := 1;
        arr_PARSED_FILE_TEMP.DELETE;
        
        for i in 1..tmpobj.count loop
          str := tmpobj.get(i).get_string;
          v_phone_id := GET_PHONE_ID(Extract_Word(str, C_SELF_NUMBER_IDX));
              
          arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_ID := v_phone_id;
          arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DATE_TIME := get_date_time(Extract_Word(str, C_SERVICE_DATE_IDX), Extract_Word(str, C_SERVICE_TIME_IDX));
              
          arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_NUMBER := Extract_Word(str, C_OTHER_NUMBER_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DIRECTION := to_number(Extract_Word(str, C_SERVICE_DIRECTION_IDX));
          arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_TYPE := Extract_Word(str, C_SERVICE_TYPE_IDX);

          arr_PARSED_FILE_TEMP(ARR_IDX).DURATION_SECONDS := get_duration(arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_TYPE, Extract_Word(str, C_DURATION_SECONDS_IDX));
          arr_PARSED_FILE_TEMP(ARR_IDX).COST := to_number(nvl(Extract_Word(str, C_COST_IDX), '0'));
          arr_PARSED_FILE_TEMP(ARR_IDX).ORIGIN_COST := to_number(nvl(Extract_Word(str, C_ORIGIN_COST_IDX), '0'));
          arr_PARSED_FILE_TEMP(ARR_IDX).COST_WITHOUT_VAT := to_number(nvl(Extract_Word(str, C_COST_WITHOUT_VAT_IDX), '0'));
              
          arr_PARSED_FILE_TEMP(ARR_IDX).IS_GROUP := to_number(nvl(Extract_Word(str, C_IS_GROUP_IDX), '0'));

          arr_PARSED_FILE_TEMP(ARR_IDX).ROAMING_TYPE := to_number(nvl(Extract_Word(str, C_ROAMING_TYPE_IDX), '0'));
          arr_PARSED_FILE_TEMP(ARR_IDX).SELF_ZONE := Extract_Word(str, C_SELF_ZONE_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_ZONE := Extract_Word(str, C_OTHER_ZONE_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).ADD_INFO := Extract_Word(str, C_ADD_INFO_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).ACCOUNT_NO := Extract_Word(str, C_ACCOUNT_NO_IDX);
    --        := Extract_Word(str, C_LINE_POS_IDX);
    --        := Extract_Word(str, C_LINE_LENGTH_IDX);
             
          arr_PARSED_FILE_TEMP(ARR_IDX).BILL_NUMBER := Extract_Word(str, C_BILL_NUMBER_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).BILL_DATE := get_date_time(Extract_Word(str, C_BILL_DATE_IDX), null);
          arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_LIMIT := to_number(Extract_Word(str, C_PHONE_LIMIT_IDX));
          arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_CHARGE_LIMIT := to_number(Extract_Word(str, C_PHONE_CHARGE_LIMIT_IDX));
          arr_PARSED_FILE_TEMP(ARR_IDX).OPTIONS := Extract_Word(str, C_OPTIONS_IDX);
          arr_PARSED_FILE_TEMP(ARR_IDX).CASCADE_NUMBER := to_number(nvl(Extract_Word(str, C_CASCADE_NUMBER_IDX), '0'));
    --*/         
            ARR_IDX := ARR_IDX + 1;        

        end loop;
        
        forall ARR_IDX in arr_PARSED_FILE_TEMP.first..arr_PARSED_FILE_TEMP.last
          INSERT INTO  PARSED_FILE_TEMP
            (
              PHONE_ID,
              SERVICE_DATE_TIME,
              OTHER_NUMBER,
              SERVICE_DIRECTION,
              SERVICE_TYPE,
              DURATION_SECONDS,
              COST,
              ORIGIN_COST,
              COST_WITHOUT_VAT,
              IS_GROUP,
              ROAMING_TYPE,
              SELF_ZONE,
              OTHER_ZONE,
              ADD_INFO,
              ACCOUNT_NO,
              BILL_NUMBER,
              BILL_DATE,
              PHONE_LIMIT, 
              PHONE_CHARGE_LIMIT,
              OPTIONS,
              CASCADE_NUMBER
            )
          VALUES
            (
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_ID,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DATE_TIME,
              arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_NUMBER,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DIRECTION,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_TYPE,
              arr_PARSED_FILE_TEMP(ARR_IDX).DURATION_SECONDS,
              arr_PARSED_FILE_TEMP(ARR_IDX).COST,
              arr_PARSED_FILE_TEMP(ARR_IDX).ORIGIN_COST,
              arr_PARSED_FILE_TEMP(ARR_IDX).COST_WITHOUT_VAT,
              
              arr_PARSED_FILE_TEMP(ARR_IDX).IS_GROUP,

              arr_PARSED_FILE_TEMP(ARR_IDX).ROAMING_TYPE,
              arr_PARSED_FILE_TEMP(ARR_IDX).SELF_ZONE,
              arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_ZONE,
              arr_PARSED_FILE_TEMP(ARR_IDX).ADD_INFO,
              arr_PARSED_FILE_TEMP(ARR_IDX).ACCOUNT_NO,
              arr_PARSED_FILE_TEMP(ARR_IDX).BILL_NUMBER,
              arr_PARSED_FILE_TEMP(ARR_IDX).BILL_DATE,
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_LIMIT,
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_CHARGE_LIMIT,
              arr_PARSED_FILE_TEMP(ARR_IDX).OPTIONS,
              arr_PARSED_FILE_TEMP(ARR_IDX).CASCADE_NUMBER
            
            );
          
          insert into DB_LOADER_BILLS
          (
            ACCOUNT_ID,
            YEAR_MONTH,
            PHONE_ID,
            TARIFF_CODE,
            DATE_BEGIN,
            DATE_END,
            BILL_SUM,
            CALL_LOCAL,
            CALL_INTERCITY,
            SMS,
            MMS,
            INTERNET,
            INTERNATIONAL_ROAMING,
            NATIONAL_INTRANET_ROAMING,
            SUBSCRIPTION_ADD,
            SUBSCRIPTION,
            SUBSCRIPTION_DIRECT,
            OTHERS_COST,
            PAYMENTS,
            ADJUSTMENT,
            LOG_BILL_ID
            
          )
          select
              c.account_id ,
              c.year_month ,
              phone_id,
              null,
              null,
              null,
              sum(cost)  BILL_SUM,
              sum(
                  case 
                    when SERVICE_TYPE = 'C' AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
              ) CALL_LOCAL,
              
              sum(
                  case 
                    when SERVICE_TYPE = 'M' AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
                 ) CALL_INTERCITY,
              
               sum(
                  case 
                    when SERVICE_TYPE ='S' AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
                 ) SMS,  
                 
                   sum(
                  case 
                    when SERVICE_TYPE = 'U' AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
                 ) MMS,
                 
               sum(
                  case 
                    when SERVICE_TYPE in ('G','W') AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
                 ) INTERNET,  
               
              sum(
                  case 
                    when ROAMING_TYPE <> 2 OR SERVICE_TYPE in ('P',' N', 'A') then
                      0
                  else
                    cost
                  end
              ) INTERNATIONAL_ROAMING,
              
              sum(
                  case 
                    when ROAMING_TYPE <> 3 OR SERVICE_TYPE in ('P',' N', 'A') then
                      0
                  else
                    cost
                  end
              ) as NATIONAL_INTRANET_ROAMING,
              
                sum(
                  case 
                    when  SERVICE_TYPE ='D' AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
              ) SUBSCRIPTION_ADD,
              
              sum(
                  case SERVICE_TYPE
                    when  'P' then
                      cost
                  else
                      0
                  end
              ) SUBSCRIPTION,
              
              
              sum(
                  case SERVICE_TYPE
                    when  'N' then
                      cost
                  else
                      0
                  end
              ) SUBSCRIPTION_DIRECT,  

             sum(
                case 
                  when SERVICE_TYPE = 'O' AND ROAMING_TYPE =0 then
                    cost
                else
                    0
                end
              ) OTHERS_COST,
              
              sum(
                  case SERVICE_TYPE
                    when 'A' then
                      cost
                  else
                      0
                  end
              ) PAYMENTS,
                  
              sum(
                  case 
                    when SERVICE_TYPE = 'J'  AND ROAMING_TYPE =0 then
                      cost
                  else
                      0
                  end
                 ) ADJUSTMENT,
                 
                 c.log_bill_id

            from
              PARSED_FILE_TEMP aa
            where 
              aa.cascade_number >= 2
            group by phone_id;
            
            
        --получаем список номеров и тарифных планов
        tmpobj := json_ext.get_json_list (j_data, 'tariff_names');
        
        ARR_IDX := 1;
        for i in 1..tmpobj.Count loop
          obj :=  json(tmpobj.get(i));
          --проверяем на существование тарифного плана у нас в базе
          --если тарифа еще нет, то добавляем
          CHECK_TARIFF_NAME (obj.get ('tariff_name').get_string,  c.filial_id);
          --v_phone_id_arr (ARR_IDX) := GET_PHONE_ID(obj.get ('phone').get_string);
          --v_tar_name_arr (ARR_IDX) := obj.get ('tariff_name').get_string;
          --ARR_IDX := ARR_IDX +1;
        end loop;
      /*  
        forall ARR_IDX in v_phone_id_arr.first..v_phone_id_arr.last
          INSERT INTO
            phone_tariffs 
              (
                phone_id,
                tariff_name
              )
          VALUES
              (
                v_phone_id_arr (ARR_IDX),
                v_tar_name_arr (ARR_IDX)
              );    
--    */
            
    /*        
        delete from    PARSED_FILE_TEMP_afr;
        forall ARR_IDX in arr_PARSED_FILE_TEMP.first..arr_PARSED_FILE_TEMP.last
          INSERT INTO  PARSED_FILE_TEMP_afr
            (
             
              PHONE_ID,
              SERVICE_DATE_TIME,
              OTHER_NUMBER,
              SERVICE_DIRECTION,
              SERVICE_TYPE,
              DURATION_SECONDS,
              COST,
              ORIGIN_COST,
              COST_WITHOUT_VAT,
              IS_GROUP,
              ROAMING_TYPE,
              SELF_ZONE,
              OTHER_ZONE,
              ADD_INFO,
              ACCOUNT_NO,
              BILL_NUMBER,
              BILL_DATE,
              PHONE_LIMIT, 
              PHONE_CHARGE_LIMIT,
              OPTIONS,
              CASCADE_NUMBER,
              log_bill_id
            )
          VALUES
            (
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_ID,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DATE_TIME,
              arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_NUMBER,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_DIRECTION,
              arr_PARSED_FILE_TEMP(ARR_IDX).SERVICE_TYPE,
              arr_PARSED_FILE_TEMP(ARR_IDX).DURATION_SECONDS,
              arr_PARSED_FILE_TEMP(ARR_IDX).COST,
              arr_PARSED_FILE_TEMP(ARR_IDX).ORIGIN_COST,
              arr_PARSED_FILE_TEMP(ARR_IDX).COST_WITHOUT_VAT,
              
              arr_PARSED_FILE_TEMP(ARR_IDX).IS_GROUP,

              arr_PARSED_FILE_TEMP(ARR_IDX).ROAMING_TYPE,
              arr_PARSED_FILE_TEMP(ARR_IDX).SELF_ZONE,
              arr_PARSED_FILE_TEMP(ARR_IDX).OTHER_ZONE,
              arr_PARSED_FILE_TEMP(ARR_IDX).ADD_INFO,
              arr_PARSED_FILE_TEMP(ARR_IDX).ACCOUNT_NO,
              arr_PARSED_FILE_TEMP(ARR_IDX).BILL_NUMBER,
              arr_PARSED_FILE_TEMP(ARR_IDX).BILL_DATE,
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_LIMIT,
              arr_PARSED_FILE_TEMP(ARR_IDX).PHONE_CHARGE_LIMIT,
              arr_PARSED_FILE_TEMP(ARR_IDX).OPTIONS,
              arr_PARSED_FILE_TEMP(ARR_IDX).CASCADE_NUMBER,
              c.log_bill_id
            );
  --*/          
        vBILL_FILE_STATUS_ID := C_NO_ERROR_STATUS;
      END IF;
--/*    
    exception
      when OTHERS then
        vBILL_FILE_STATUS_ID := С_ERROR_PARSE_STATUS;   
        rollback;
--  */  
    end;
    
    
    UPDATE DB_LOADER_BILL_LOAD_LOG
       SET
         BILL_FILE_STATUS_ID = vBILL_FILE_STATUS_ID
     where
        LOG_BILL_ID = c.log_bill_id;
    commit; 
    
  end loop;
END;
