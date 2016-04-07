CREATE OR REPLACE procedure LOAD_PAYMENTS(ppAccount_id integer default null) as

--
--#version =2
--
--v.2 Афросин 19,02.2016 добавил обработку ошибок. если ошибка на каком либо из счетов, то другие вс равно грузим 
--v.1 Процедура загрузхки платежей по счетам
--
  procedure LOAD_PAYMENTS_BY_ACCOUNT(pAccount_id integer) as    
    
    cPAYMENT_LOAD_TYPE  CONSTANT INTEGER := 1;--идентификатор загрузки платежей
    cVIRTUAL_ACC_ID     CONSTANT INTEGER := 0; --идентификатоор нераспознанного виртулаьного счета
    cSERVICE_PHONE    CONSTANT PHONES.PHONE_NUMBER%TYPE := '0000000000' ;  
    
    v_blob blob;
    v_clob clob;
    temp json_list;
    tempdata json_value;
    tempobj json;
    TYPE payments_t IS TABLE OF payments%rowtype;
    payments_tmp payments_t;
    v_url varchar2(200 char);
    cnt integer;
    FUNCTION blob_to_clob (blob_in IN BLOB)
    --функция конвертации blob в clob
    RETURN CLOB
    AS
       v_clob    CLOB;
       v_varchar VARCHAR2(32767);
       v_start      PLS_INTEGER := 1;
       v_buffer  PLS_INTEGER := 32767;
    BEGIN
       DBMS_LOB.CREATETEMPORARY(v_clob, TRUE);

       FOR i IN 1..CEIL(DBMS_LOB.GETLENGTH(blob_in) / v_buffer)
       LOOP

          v_varchar := UTL_RAW.CAST_TO_VARCHAR2(DBMS_LOB.SUBSTR(blob_in, v_buffer, v_start));

             DBMS_LOB.WRITEAPPEND(v_clob, LENGTH(v_varchar), v_varchar);

            v_start := v_start + v_buffer;
       END LOOP;
     RETURN v_clob;
    END blob_to_clob;

    function extractpaysum(json_obj json) return number
      as
    begin
      return to_number(json_obj.get('amount').get_string, '999999999999999.00');
    end extractpaysum;  

    function extractpaydate(json_obj json) return date
      as
    begin
      return json_ext.to_date2(json_obj.get('payment_date'));
    end extractpaydate;

    
    
    --функция возвращает PHONE_ID по номеру телефона

   FUNCTION extractphoneid (json_obj json)
      RETURN PHONES.PHONE_ID%TYPE
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;

      vPhone       PHONES.PHONE_NUMBER%TYPE;
      vlPHONE_ID   PHONES.PHONE_ID%TYPE;
   BEGIN
      --v_phone := json_obj.get('phone').get_string;
      vPhone := NVL (json_obj.get('phone').get_string, cSERVICE_PHONE);

      SELECT MAX (phone_id)
        INTO vlPHONE_ID
        FROM PHONES
       WHERE phone_number = vPhone;

      IF NVL (vlPHONE_ID, -1) = -1
      THEN
         INSERT INTO PHONES (PHONE_ID, PHONE_NUMBER)
              VALUES (TO_NUMBER (vPhone), vPhone)
           RETURNING phone_id
                INTO vlPHONE_ID;

         COMMIT;
      END IF;

      RETURN vlPHONE_ID;
   END;
    
  /*  
    function extractphoneid(json_obj json) return number
      as
      PRAGMA AUTONOMOUS_TRANSACTION;
      v_phone_id phones.phone_id%type;
      v_phone phones.phone_number%type;
    begin
      v_phone_id:=null;
      v_phone := json_obj.get('phone').get_string;
      if v_phone is not null then
        select max(p.phone_id) into v_phone_id
        from phones p
        where p.phone_number=v_phone;
        if v_phone_id is null then
          insert into phones(phone_id,phone_number,phone_number_city)
          values(v_phone,v_phone, v_phone)
          returning phone_id into v_phone_id;
          commit;
        end if;
      end if;
      return v_phone_id;
    end extractphoneid;
    */
    
    function get_virtual_acc_id_by_phone_id(pPhone_id PHONES.PHONE_ID%TYPE ) return INTEGER
      as
      PRAGMA AUTONOMOUS_TRANSACTION;
      v_res INTEGER;
    begin
      begin
        select C.VIRTUAL_ACCOUNTS_ID into v_res
        from v_contracts c
        where 
          C.PHONE_ID = pPhone_id
          and rownum <=1;
      exception
        when others then
          v_res := cVIRTUAL_ACC_ID; 
      end;
      
     
      return v_res;
    end;

  BEGIN
    v_url := GET_URL_BY_ACCOUNT_LOAD_TYPE(pAccount_id, cPAYMENT_LOAD_TYPE);
    
    v_blob := GET_BLOB_FROM_URL(v_url, cPAYMENT_LOAD_TYPE);
    
    IF (v_blob is not null) then
      v_clob := blob_to_clob(v_blob);
      tempobj := json(v_clob);
     
      if(tempobj.exist('data')) then
        tempdata := tempobj.get('data');
        
        if (tempdata.is_object) then
          tempobj := json(tempdata);
          --проверяем на окончание формироваиня платежей
          if(tempobj.exist('load_state')) then
           
            if upper(tempobj.get('load_state').get_string) = 'IS_DONE' then 
              
              if(tempobj.exist('payments')) then
                tempdata := tempobj.get('payments');
                
                if(tempdata.is_array) then
                  
                  temp := json_list(tempdata);
                  payments_tmp:=payments_t();
                  
                  for i in 1..temp.count loop
                    payments_tmp.extend;
                    payments_tmp(i).date_pay := extractpaydate(json(temp.get(i)));
                    payments_tmp(i).sum_pay := extractpaysum(json(temp.get(i)));
                    payments_tmp(i).phone_id := extractphoneid(json(temp.get(i)));
                    payments_tmp(i).VIRTUAL_ACCOUNT_ID := get_virtual_acc_id_by_phone_id(payments_tmp(i).phone_id);
                  end loop;
                  
                  DELETE FROM PAYMENTS_TEMP;

                  FORALL i IN 1 .. payments_tmp.COUNT
                    INSERT INTO PAYMENTS_TEMP
                                            (DATE_PAY,
                                            SUM_PAY,
                                            DOC_NUMBER,
                                            PHONE_ID,
                                            VIRTUAL_ACCOUNT_ID
                                            )
                            VALUES (payments_tmp (i).date_pay,
                                    payments_tmp (i).sum_pay,
                                    '?',
                                    payments_tmp (i).phone_id,
                                    payments_tmp(i).VIRTUAL_ACCOUNT_ID
                                    );
                                    
                                    
                  -- исключаем дублирующие записи
                  MERGE INTO payments p1
                         USING (SELECT date_pay,
                                                sum_pay,
                                                doc_number,
                                                phone_id,
                                                virtual_account_id
                                  FROM PAYMENTS_TEMP) p2
                            ON (    p2.date_pay = p1.date_pay
                                AND p2.sum_pay = p1.sum_pay
                                AND p2.phone_id = p1.phone_id
                               )
                  WHEN NOT MATCHED THEN
                    INSERT      (p1.date_pay,
                                   p1.sum_pay,
                                   p1.doc_number,
                                   p1.phone_id,
                                   p1.virtual_account_id,
                                   p1.year_month
                                   )
                    VALUES      (p2.date_pay,
                                   p2.sum_pay,
                                   p2.doc_number,
                                   p2.phone_id,
                                   p2.virtual_account_id,
                                   to_number(to_char(p2.date_pay, 'yyyymm'))
                                   );
                  
                  COMMIT;
                end if;--if(tempdata.is_array) then
                
              end if; --if(tempobj.exist('payments')) then
              
            end if;--if upper(tempobj.get('load_state').get_string) = 'IS_DONE'
            
          end if;--if(tempobj.exist('load_state')) then
          
        end if;--if (tempdata.is_object) then
        
      end if;-- if(tempobj.exist('data')) then
      
    END IF;-- IF (v_blob is not null) then
  END;
begin
  if ppAccount_id is not null then
    LOAD_PAYMENTS_BY_ACCOUNT(ppAccount_id);
  else
    for c in (select
                account_id
              from
                accounts a
              where
                exists (select 1 from filials f
                        where a.filial_id = f.filial_id
                        and branch is not null
                       ) 
              )
    loop
      begin
        LOAD_PAYMENTS_BY_ACCOUNT(c.account_id);
      exception
        when others then
        null;
      end;   
    end loop;
  end if;  
end;