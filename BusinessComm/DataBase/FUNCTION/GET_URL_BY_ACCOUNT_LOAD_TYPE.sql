CREATE OR REPLACE FUNCTION GET_URL_BY_ACCOUNT_LOAD_TYPE (pAccountId integer, pLoadType integer) 
Return varchar2 is
--
--#Version=2
--
--v.2 16.02.2016 Афросин - переделки под filal_id
--v.1 08.02.2016 Афросин - функция возврата ссылки для получения данных по переданному ACCOUNT_ID и типу загрузки
--


  v_url varchar2(500 char);
begin
  v_url := '';
  
  begin
  -- формируем ссылку по шаблону и заданному account_id
   SELECT
          replace (
                    REPLACE (
                              REPLACE (
                                       REPLACE (lt.URL_TEMPLATE, '%branch%', f.branch),
                                      '%login%',
                                       a.login
                                      ),
                               '%password%',
                                a.password
                           ),
                   '%operator%',
                   mon.MOBILE_OPERATOR_NAME_FOR_URL
                  ) 
                 
    INTO v_URL
     FROM
      load_types lt,
      accounts a,
      filials f,
      MOBILE_OPERATOR_NAMEs mon
    WHERE
      lt.load_type_id = pLoadType
      AND a.account_id = pAccountId
      and f.filial_id=A.filial_id
      and F.MOBILE_OPERATOR_NAME_ID = MON.MOBILE_OPERATOR_NAME_ID
--      and A.BRANCH is not null
      and MON.MOBILE_OPERATOR_NAME_FOR_URL is not  null;
  exception
    when others then
     v_url := ''; 
  end;
  
  Return v_url;
end;