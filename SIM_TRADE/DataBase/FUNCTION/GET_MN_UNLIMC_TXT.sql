CREATE OR REPLACE FUNCTION GET_MN_UNLIMC_TXT(pPHONE_NUMBER IN VARCHAR2)
  RETURN varchar2 IS
  --#Version=1
  MN_UNLIMC_TXT  VARCHAR2(300 CHAR);
  SQL_T          VARCHAR2(2000 CHAR);
  MN_UNLIM_SDATE date;
  vYEAR_MONTH    integer;
BEGIN
  MN_UNLIM_SDATE := DB_LOADER_PCKG.GET_MN_UNLIM_SDATE(pPHONE_NUMBER);
  if MN_UNLIM_SDATE <> to_date('31.12.1999', 'dd.mm.yyyy') then
    begin
      select max(sv.sql_text)
        into SQL_T
        from service_volume sv
       where sv.option_code = 'MN_UNLIMC';
    exception
      when others then
        MN_UNLIMC_TXT := 'Внутренняя ошибка!';
    end;
    vYEAR_MONTH := to_number(to_char(sysdate, 'yyyy')) * 100 +
                   to_number(to_char(sysdate, 'mm'));
    SQL_T       := REPLACE(SQL_T, '%ph_num%', '''' || pPHONE_NUMBER || '''');
    SQL_T       := REPLACE(SQL_T, '%y_mo%', to_char(vYEAR_MONTH));
    begin
      execute immediate SQL_T
        into MN_UNLIMC_TXT;
    exception
      when others then
        MN_UNLIMC_TXT := 'Внутренняя ошибка!';
    end;
    if MN_UNLIMC_TXT <> 'Внутренняя ошибка!' then
      MN_UNLIMC_TXT := 'Остаток минут: ' || MN_UNLIMC_TXT;
    end if;
  else
    MN_UNLIMC_TXT := 'Услуга не подключена.';
  end if;
  return MN_UNLIMC_TXT;
end;
