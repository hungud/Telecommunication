
  CREATE OR REPLACE PROCEDURE "LONTANA"."DB_LOADER_PHONE_OPRT_CLOSE3" (pYEAR         IN INTEGER,
                                                        pMONTH        IN INTEGER, 
                                                        pPHONE_NUMBER IN VARCHAR2) IS 
--#Version=2  
--1 добавлена процедура проставления даты закрытия (в таблице DB_LOADER_ACCOUNT_PHONE_OPTS) услуги при остутствии даты зхакрытия и наличия такой же услуги с более поздней датой 
--2 24.09.2013 убрана завязка на Account_id и  option_parameters в определении дубля услуг  
  vYEAR_MONTH BINARY_INTEGER; 
 begin
   
 vYEAR_MONTH := pYEAR * 100 + pMONTH; 
  
 /* for vrec in (select --a.account_id, 
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
                         a.option_name\*, 
                         a.option_parameters*\ 
               having count(*) > 1) */
               
  for vrec in (     
 select z.option_code, z.option_name, z.turn_on_date date_on,trunc(z.last_check_date_time) as turn_off_date    
                from DB_LOADER_ACCOUNT_PHONE_OPTS z 
                where z.phone_number = pPHONE_NUMBER
                and year_month=vYEAR_MONTH
                and z.turn_off_date is null
                and not exists  
(select 1 from ( select            
                      max(trunc(a.last_check_date_time)) last_check_date_time 
                 from DB_LOADER_ACCOUNT_PHONE_OPTS a 
                where a.phone_number = pPHONE_NUMBER
                  and a.year_month = vYEAR_MONTH 
                  and a.turn_off_date is null) v
                           where v.last_check_date_time=trunc(z.last_check_date_time))      
                           )  
               loop 
                 
    update DB_LOADER_ACCOUNT_PHONE_OPTS 
    --   set turn_off_date = vREC.date_on 
    set turn_off_date = vREC.turn_off_date
     where phone_number=pPHONE_NUMBER 
     and year_month=vYEAR_MONTH 
     and turn_off_date is null 
     --and account_id=vrec.account_id 
     and option_code=vrec.option_code 
     --and nvl(option_parameters,'-1')=nvl(vrec.option_parameters,'-1') 
     and turn_on_date=vrec.date_on 
      ; 
     --commit; 
  end loop; 
 
end; 
