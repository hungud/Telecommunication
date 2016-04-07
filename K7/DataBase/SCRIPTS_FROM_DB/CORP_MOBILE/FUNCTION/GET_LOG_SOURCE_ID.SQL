
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_LOG_SOURCE_ID" ( 
  plog_source_mname IN VARCHAR2 
  ) RETURN INTEGER IS 
--Vesion=1   
CURSOR C IS  
   select log_source_id from log_source a where a.log_source_name=plog_source_mname;    
     
Res1 NUMBER;      
Res NUMBER;  
     
BEGIN 
  OPEN C; 
  FETCH C INTO Res1; 
  IF C%FOUND THEN  
    Res:=Res1; 
  ELSE 
    Res:=0; 
  END IF; 
  CLOSE C; 
  RETURN Res; 
   
END; 
