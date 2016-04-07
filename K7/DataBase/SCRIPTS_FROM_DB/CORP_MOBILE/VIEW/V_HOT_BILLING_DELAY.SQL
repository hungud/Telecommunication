
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_HOT_BILLING_DELAY" ("ACCOUNT_ID", "FILE_NAME", "FILE_DATE", "LOAD_SDATE", "MIND", "MAXD") AS 
  select /*+index(hb I_HOT_BILLING_SUBSCR_NO)*/PH_NEW.ACCOUNT_ID,
       hbf.file_name,
       to_date(substr(hbf.file_name, -19, 15), 'yyyymmdd-hh24miss') as file_date,
       hbf.load_sdate,
       min(round((to_date(substr(hbf.file_name, -19, 15),
                          'yyyymmdd-hh24miss') - hb.call_time) * 24,
                 2)) as mind,
       max(round((to_date(substr(hbf.file_name, -19, 15),
                          'yyyymmdd-hh24miss') - hb.call_time) * 24,
                 2)) as maxd
  from hot_billing              hb,
       hot_billing_files        hbf,
       DB_LOADER_ACCOUNT_PHONES PH_NEW
 where hb.hbf_id = hbf.hbf_id
   and (PH_NEW.YEAR_MONTH) IN
       (SELECT FIRST_VALUE(year_month) OVER(ORDER BY year_month DESC)
          FROM DB_LOADER_ACCOUNT_PHONES PH_OLD
         WHERE PH_OLD.PHONE_NUMBER IS NOT NULL
           AND PH_NEW.ACCOUNT_ID = PH_OLD.ACCOUNT_ID)
   and PH_NEW.PHONE_NUMBER = hb.subscr_no
 group by PH_NEW.ACCOUNT_ID,
          hbf.file_name,
          to_date(substr(hbf.file_name, -19, 15), 'yyyymmdd-hh24miss'),
          hbf.load_sdate
union all
select /*+rule*/ -1,hbf.file_name,
       to_date(substr(hbf.file_name, -19, 15), 'yyyymmdd-hh24miss') as file_date,
       hbf.load_sdate,
       min(round((to_date(substr(hbf.file_name, -19, 15),
                          'yyyymmdd-hh24miss') - hb.call_time) * 24,
                 2)) as mind,
       max(round((to_date(substr(hbf.file_name, -19, 15),
                          'yyyymmdd-hh24miss') - hb.call_time) * 24,
                 2)) as maxd
  from hot_billing              hb,
  hot_billing_files hbf
 where hb.hbf_id = hbf.hbf_id
 group by -1,
          hbf.file_name,
          to_date(substr(hbf.file_name, -19, 15), 'yyyymmdd-hh24miss'),
          hbf.load_sdate
