--#if GetVersion("DB_LOADER_PHONE_OPRT_CLOSE2") < 2 then
CREATE OR REPLACE PROCEDURE DB_LOADER_PHONE_OPRT_CLOSE2(pYEAR         IN INTEGER,
                                                        pMONTH        IN INTEGER,
                                                        pPHONE_NUMBER IN VARCHAR2) IS
--#Version=2 
--1 ��������� ��������� ������������ ���� �������� (� ������� DB_LOADER_ACCOUNT_PHONE_OPTS) ������ ��� ���������� ���� ��������� � ������� ����� �� ������ � ����� ������� �����
--2 24.09.2013 ������ ������� �� Account_id �  option_parameters � ����������� ����� ����� 
  vYEAR_MONTH BINARY_INTEGER;

begin

 vYEAR_MONTH := pYEAR * 100 + pMONTH;
 
  for vrec in (select --a.account_id,
                      a.option_code,
                      a.option_name,
                      --a.option_parameters,
                      count(*) cnt,
                      max(turn_on_date) date_on
                 from DB_LOADER_ACCOUNT_PHONE_OPTS a
                where a.phone_number = pPHONE_NUMBER
                  and a.year_month = vYEAR_MONTH
                  and a.turn_off_date is null
                group by --a.account_id,
                         a.option_code,
                         a.option_name/*,
                         a.option_parameters*/
               having count(*) > 1) loop
    update DB_LOADER_ACCOUNT_PHONE_OPTS
       set turn_off_date = vREC.date_on
     where phone_number=pPHONE_NUMBER
     and year_month=vYEAR_MONTH
     and turn_off_date is null
     --and account_id=vrec.account_id
     and option_code=vrec.option_code
     --and nvl(option_parameters,'-1')=nvl(vrec.option_parameters,'-1')
     and turn_on_date<vrec.date_on
      ;
     commit;
  end loop;

end;
/
--#end if

--CREATE SYNONYM CORP_MOBILE_DB_LOADER.DB_LOADER_PHONE_OPRT_CLOSE2 FOR DB_LOADER_PHONE_OPRT_CLOSE2;

--GRANT EXECUTE ON DB_LOADER_PHONE_OPRT_CLOSE2 TO CORP_MOBILE_DB_LOADER;
