
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."ACCOUNT_ALLOWED" 
(
  p_schema varchar2, p_object varchar2
)
RETURN VARCHAR2 IS
TYPE m_SmplTable IS TABLE OF VARCHAR2(128) INDEX BY BINARY_INTEGER;
MY_TBL m_SmplTable;
i integer;
AccCount NUMBER;
res BOOLEAN;
mColumn VARCHAR2(50);
BEGIN
  --определяем имеются ли назначенные лиц. счета
  SELECT COUNT(ACCOUNT_ID)
  INTO AccCount
  FROM USER_NAME_ACCOUNTS ac
  LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID 
  WHERE us.USER_NAME = UPPER(USER);

  IF AccCount <> 0 THEN  --если имеются  
     
     --считываем данные в перменную MY_TBL
     i := 0;
     for rec in (select tbl.column_name
                    from all_tab_columns tbl
                    where tbl.owner = p_schema
                        and tbl.table_name = p_object
                        and ((tbl.column_name = 'ACCOUNT_ID') OR (tbl.column_name = 'PHONE_NUMBER') OR
                                (tbl.column_name = 'PHONE') OR (tbl.column_name = 'MSISDN') OR
                                (tbl.column_name = 'phonea') OR (tbl.column_name = 'phonenr') OR
                                (tbl.column_name = 'PHONE_NUMBER_FEDERAL')))
     loop
        i := i + 1;
        MY_TBL(i) := rec.column_name; 
     end loop;
      
     --пробегаемся по массиву для поиска ACCOUNT_ID
     res := FALSE;
     for i in 1..MY_TBL.Count 
     loop
        if (MY_TBL(i) = 'ACCOUNT_ID') then --если есть поле ACCOUNT_ID             
           RETURN 'ACCOUNT_ID IN (SELECT ACCOUNT_ID FROM USER_NAME_ACCOUNTS ac  '||
                        'LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID '||
                        'WHERE us.USER_NAME = UPPER('''||USER||'''))'; 
           res := TRUE;
           EXIT;    
        end if;
     end loop; 
     
     --если поле ACCOUNT_ID отсутствует
     IF not res THEN
        --пробегаемся по массиву для поиска PHONE_NUMBER, PHONE, MSISDN, phonenr, phonea , SUBSCR_NO, PHONE_NUMBER_FEDERAL
        mColumn := '';
        for i in 1..MY_TBL.Count 
        loop
           if (MY_TBL(i) = 'PHONE_NUMBER') then --если есть поле PHONE_NUMBER  
              mColumn := 'PHONE_NUMBER';  
              res := TRUE;
           elsif  (MY_TBL(i) = 'PHONE')  then
              mColumn := 'PHONE';  
              res := TRUE;           
           elsif  (MY_TBL(i) = 'MSISDN')  then
              mColumn := 'MSISDN';  
              res := TRUE;           
           elsif  (MY_TBL(i) = 'PHONEA')  then
              mColumn := 'PHONEA';  
              res := TRUE;           
           elsif  (MY_TBL(i) = 'PHONENR')  then
              mColumn := 'PHONENR';  
              res := TRUE;      
           elsif  (MY_TBL(i) = 'SUBSCR_NO')  then
              mColumn := 'SUBSCR_NO';  
              res := TRUE;  
           elsif  (MY_TBL(i) = 'PHONE_NUMBER_FEDERAL')  then
              mColumn := 'PHONE_NUMBER_FEDERAL';  
              res := TRUE;                
           end if;
           
           IF res THEN
             EXIT;
           END IF;                              
        end loop;
        
        IF res THEN
          RETURN mColumn||'  IN (SELECT DISTINCT(PHONE_NUMBER) PHONE_NUMBER '||
                      'FROM DB_LOADER_ACCOUNT_PHONES WHERE ACCOUNT_ID IN (SELECT ac.ACCOUNT_ID '||
                      'FROM USER_NAME_ACCOUNTS ac  LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID '|| 
                      'WHERE us.USER_NAME = UPPER('''||USER||''')))'; 
        END IF;       
     END IF;  
         
     IF not res THEN
       RETURN null;
     END IF;
       
  ELSE --если не имеются, то предикат не нужен
     RETURN null;
  END IF;
END ACCOUNT_ALLOWED;