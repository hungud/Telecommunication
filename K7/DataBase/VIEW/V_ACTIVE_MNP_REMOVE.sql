CREATE OR REPLACE VIEW V_ACTIVE_MNP_REMOVE AS
select 
sv.phone_number, 
 sv.temp_phone_number,  
 sv.date_activate, 
 sv.user_created, 
 sv.date_created,
 sv.Date_Inserted,
 sv.is_active,
 sv.clr ,
 case when nvl(un.USER_FIO, '0') = '0' then 'Cистема; '|| sv.USER_CREATED else un.USER_FIO end USER_CREATED_FIO,
sv.DATE_CREATED  DATE_CREATED_

 from 
(
  select  
   MR.phone_number, 
   MR.temp_phone_number,  
   MR.date_activate, 
   MR.user_created, 
   MR.date_created,
   null Date_Inserted,
   MR.is_active,
   0 clr    
  from MNP_REMOVE MR
  where MR.is_active = 0
 union
  select  
   MR.phone_number, 
   MR.temp_phone_number,  
   MR.date_activate, 
   MR.user_created, 
   MR.date_created,
   null Date_Inserted,
   MR.is_active,
   1 clr    
  from MNP_REMOVE MR
  where MR.is_active = 1
 union
  select  
   MRH.phone_number, 
   MRH.temp_phone_number,  
   MRH.date_activate, 
   MRH.user_created, 
   MRh.date_created,
   MRh.Date_Inserted,
   1 is_active,
   2 clr    
  from MNP_REMOVE_HISTORY MRH) 
       sv,
       USER_NAMES un  
 where sv.USER_CREATED = un.USER_NAME(+)   
 
GRANT SELECT, INSERT, DELETE, UPDATE ON V_ACTIVE_MNP_REMOVE TO CORP_MOBILE_ROLE;     
      
GRANT SELECT ON V_ACTIVE_MNP_REMOVE TO CORP_MOBILE_ROLE_RO