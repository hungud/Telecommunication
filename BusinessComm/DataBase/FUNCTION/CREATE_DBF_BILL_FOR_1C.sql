CREATE OR REPLACE function CREATE_DBF_BILL_FOR_1C(p_year_month INTEGER default null )
                                                return varchar2 is
  --
  --#Version=2
  --
  --v.2 Афросин 09.03.2016 - Добавил проверку на VIRTUAL_ACCOUNTS_IS_ACTIVE. В 1С выгружаем только активные лицевые счета
  --v.1 Афросин 08.12.2015 - Функция для выгрузки файла счетов в dbf для отправки в 1C
  --  
  v_year_month varchar2(6 char);
  
  c_SQL_TEXT CONSTANT VARCHAR2(450 CHAR) := 'select
                 INN,
                 sum(ALL_CLIENT_SCHET) BILL_SUMM,
                 last_day(to_date(dlb.YEAR_MONTH||''01'', ''yyyymmdd'')) BILL_DATE
              from
                V_BILLS dlb
              where
                year_month = %v_year_month%
                and not (inn is null and ALL_CLIENT_SCHET < 0)
                and exists(
                          select 1 from
                            virtual_accounts va 
                          where 
                            dlb.VIRTUAL_ACCOUNTS_ID = VA.VIRTUAL_ACCOUNTS_ID
                            and VA.VIRTUAL_ACCOUNTS_IS_ACTIVE =1
                          )
              group by INN, last_day(to_date(dlb.YEAR_MONTH||''01'', ''yyyymmdd''))';
  
 v_SQL_TEXT varchar2(450 char);
 v_file_name varchar2(19 char);
 v_res  varchar2(500 char); 
begin
  begin
  
    if nvl(p_year_month, 0) = 0 then
      select max(year_month) into v_year_month  from V_BILLS;
      
      if nvl(v_year_month, 0) = 0 then 
        v_year_month := to_char(sysdate, 'yyyymm');
      end if;
    else
      v_year_month := to_char(p_year_month);
    end if;
    
    v_file_name := to_char(sysdate ,'yyyymmdd_hh24miss') ||'.DBF';
    v_SQL_TEXT := REPLACE(c_SQL_TEXT, '%v_year_month%', v_year_month);
    
    DBASE_PKG.dump_table(p_dir    => 'DIR_BILL_FOR_1C',
      p_file    =>    v_file_name,
      p_schema    =>    'BUSINESS_COMM',
      p_tname    =>    'V_BILLS', 
      p_cnames    =>    'INN,BILL_SUMM,BILL_DATE',
      p_colnames    =>    'INN,BILL_SUMM,BILL_DATE',
      p_coltype    =>    'C,N,D',  
      p_colsize    =>    '12,10.2,20',
      p_sql => v_SQL_TEXT,
      p_show => TRUE
      
      );
    v_res := 'Счета успешно отправлены';
  exception
    when OTHERS then
      v_res := SUBSTR('Ошибка при отправке счета: '|| SQLERRM, 1, 500);  
  end;
  
  Return v_res;
end;

GRANT EXECUTE ON CREATE_DBF_BILL_FOR_1C TO BUSINESS_COMM_ROLE;