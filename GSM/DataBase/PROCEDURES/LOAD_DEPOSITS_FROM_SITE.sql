CREATE OR REPLACE PROCEDURE LOAD_DEPOSITS_FROM_SITE IS
--
--Version=1
--
--v.1 Афросин - Получение данных из личного кабинета билайна Финансовая информация ->
--
    type loader_table is table of varchar2(1000) INDEX BY binary_integer;
    Tloader  loader_table;--данные аттачмента
    log_EXCEPTION EXCEPTION;
    err varchar2(1000);
    answer_mes blob;--выгрузка
    counter number:=0;
    cMetodId CONSTANT INTEGER := 95; --иденитфикатор метода для депозитов из таблицы ACCOUNT_LOAD_TYPES
    cDividerTab CONSTANT CHAR := chr(9);--разделитель табуляция
    NTitle integer;    
    ValLoad varchar2(200);
    
    --Парсинг строки и Вставка в таблицу GUARANTEE_FEES
    function insertstr(item varchar2, pAccountId Integer) return varchar2  is
        rcGF GUARANTEE_FEES%rowtype;
        sMSG varchar2(200);
        sTMP varchar2(3000);
        sFld varchar2(2000);
        nPozDivider number;
        nIndexField number;
        pBan integer;
        pCountBan integer;
        pres integer;
        
    begin
        sTMP := item||cDividerTab;
        nIndexField:=0;
        
        rcGF.ACCOUNT_ID := pAccountId;
        rcGF.YEAR_MONTH := TO_NUMBER(TO_CHAR(sysdate, 'yyyymm'));
        --парсинг строки 
        loop
            nPozDivider:=instr(sTMP, cDividerTab,1,1);
            sFld:= substr(sTMP,1, nPozDivider-1);
            sTMP:= substr(sTMP, nPozDivider+1);
            
            --при преобразовании в число там не пробел, а символ с кодом 49824
            case nIndexField
                when 0 then rcGF.PHONE_NUMBER := substr(trim(sFLD), -10); --номер телефона
                when 1 then rcGF.STATUS_GUARANT_FEE := trim(sFLD); --Статус гарантийного взноса 
                when 2 then rcGF.SUM_GUARANT_FEE :=  to_number(replace(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.'), ' ', ''), '9999999999.99'); --Сумма гарантийного взноса с НДС
                when 3 then rcGF.PAID := to_number(replace(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.'), ' ', ''), '9999999999.99'); --Оплачено
                when 4 then rcGF.RETURNED :=  to_number(replace(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.'), ' ', ''), '9999999999.99'); --Возвращено
                when 5 then rcGF.WITHDRAWN :=  to_number(replace(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.'), ' ', ''), '9999999999.99'); --Отменено
                when 6 then rcGF.NOT_PAID :=  to_number(replace(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.'), ' ', ''), '9999999999.99'); --Не оплачено
                when 7 then rcGF.BILL_NUMBER := to_number(replace(rtrim(sFLD,chr(10)||chr(13)||chr(9)),',','.')); --Счёт
                else null;
            end case;
            nIndexField:=nIndexField+1;
            exit when  nPozDivider is null;
        end loop;

        
        --проверяем есть ли данный счет в таблице
         MERGE INTO GUARANTEE_FEES gf
          USING  
           (SELECT rcGF.ACCOUNT_ID ACCOUNT_ID, 
                 rcGF.PHONE_NUMBER PHONE_NUMBER,
                 rcGF.STATUS_GUARANT_FEE STATUS_GUARANT_FEE,
                 rcGF.SUM_GUARANT_FEE SUM_GUARANT_FEE,
                 rcGF.PAID PAID,
                 rcGF.RETURNED RETURNED,
                 rcGF.WITHDRAWN WITHDRAWN,
                 rcGF.NOT_PAID NOT_PAID,
                 rcGF.BILL_NUMBER BILL_NUMBER,
                 rcGF.YEAR_MONTH YEAR_MONTH from dual)new_gf
              ON (
              
                 gf.ACCOUNT_ID = new_gf.ACCOUNT_ID AND 
                 gf.PHONE_NUMBER = new_gf.PHONE_NUMBER AND
                 gf.STATUS_GUARANT_FEE = new_gf.STATUS_GUARANT_FEE AND
                 gf.SUM_GUARANT_FEE = new_gf.SUM_GUARANT_FEE AND
                 gf.PAID = new_gf.PAID AND
                 gf.RETURNED = new_gf.RETURNED AND
                 gf.WITHDRAWN = new_gf.WITHDRAWN AND
                 gf.NOT_PAID = new_gf.NOT_PAID AND
                 gf.BILL_NUMBER = new_gf.BILL_NUMBER AND
                 gf.YEAR_MONTH = new_gf.YEAR_MONTH
                )   
            WHEN MATCHED THEN
              UPDATE SET
                 DATE_UPDATE = sysdate,
                 USER_UPDATE = USER
            
            WHEN NOT MATCHED THEN 
             
                INSERT  
                ( gf.ACCOUNT_ID, 
                 gf.PHONE_NUMBER,
                 gf.STATUS_GUARANT_FEE,
                 gf.SUM_GUARANT_FEE,
                 gf.PAID,
                 gf.RETURNED,
                 gf.WITHDRAWN,
                 gf.NOT_PAID,
                 gf.BILL_NUMBER,
                 gf.YEAR_MONTH
                  ) 
            VALUES 
                (new_gf.ACCOUNT_ID, 
                 new_gf.PHONE_NUMBER,
                 new_gf.STATUS_GUARANT_FEE,
                 new_gf.SUM_GUARANT_FEE,
                 new_gf.PAID,
                 new_gf.RETURNED,
                 new_gf.WITHDRAWN,
                 new_gf.NOT_PAID,
                 new_gf.BILL_NUMBER,
                 new_gf.YEAR_MONTH
                 );
            commit;
--          */  
            counter:=counter+1;
        --end if;
        smsg:='OK';
        return(sMSG);
    exception
        when others then 
          ROLLBACK;
          err:=err||' ParsErr^:nIndexField='||nIndexField||';sFld='||sFld||';sTMP='||sTMP||' Counter#'||counter;
    end;
    
    

begin
    
    
  for rec in (select account_id, login, new_pswd from accounts
               where account_id <> 225 --убираем счет экомобайла
               
  ) loop
    counter:=0;
    Tloader.DELETE;
    
    --открываем соединение
    err := RUBY_ROBOT_PCKG.create_conn(rec.login, rec.new_pswd , cMetodId, answer_mes);
    
    if err='OK' then
        RUBY_ROBOT_PCKG.create_rpt_log_tbl(cMetodId, rec.Account_id, answer_mes, 'LOAD_DEPOSITS_FROM_SITE'); 
    else --если не прошло соединение вылетаем
        raise log_EXCEPTION;
    end if;

    --получаем значения Loader
    NTitle := RUBY_ROBOT_PCKG.Get_Count_Loader;
    for i in 1..NTitle loop
        Tloader(i):= RUBY_ROBOT_PCKG.Get_Loader(i);
    end loop i;

    --проверяем , если сообщение об ошибке или подобие xml то вылетаем
    if (instr(Tloader(1),'Error')>0) or (instr(Tloader(1),'<')>0) then
        err:=Tloader(1); 
        raise log_exception;
    end if;
    
    --получение данных
    for i in Tloader.first..Tloader.last loop
        --пропускаем строку с наименованием листа и заголовками и пустые строки
        if (trim(Tloader(i)) is not null) AND 
           (instr(trim(Tloader(i)),'SheetName=',1 ,1 ) = 0) AND (instr(trim(Tloader(i)),'Номер телефона', 1, 1) = 0) then
              if insertstr(Tloader(i), rec.account_id) is null then 
                  raise log_EXCEPTION;
              end if; 
        end if;
    end loop;
 
    --логируем успешное выполнение
    INSERT INTO ACCOUNT_LOAD_LOGS (ACCOUNT_LOAD_LOG_ID, LOAD_DATE_TIME,
        IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
    VALUES(S_NEW_ACCOUNT_LOAD_LOG_ID.NEXTVAL, SYSDATE,
                 1,'Ok! Add '||counter||' rows.', cMetodId);
    commit;
    
  end loop;
EXCEPTION --логируем неудачу
    when others then  --log_EXCEPTION в частности
    ROLLBACK;
    err:=err||' -- '||SQLERRM||'--Записей обновлено:'||nvl(counter,0);
    
                                        
    INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, LOAD_DATE_TIME,
        IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID)
    VALUES(S_NEW_ACCOUNT_LOAD_LOG_ID.NEXTVAL, SYSDATE,
        0,'Update '||err, cMetodId);       
    commit;
                                
END LOAD_DEPOSITS_FROM_SITE;
/
GRANT execute ON LOAD_DEPOSITS_FROM_SITE TO LONTANA_ROLE;
GRANT execute ON LOAD_DEPOSITS_FROM_SITE TO LONTANA_ROLE_RO;   