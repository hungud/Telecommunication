
  CREATE OR REPLACE FUNCTION "LONTANA"."FLONGSMS" (  p_host in varchar2,
                                       p_port in varchar2,       
                                       p_user in varchar2,
                                       p_passw in varchar2,
                                       p_sourceAddr in varchar2,
                                       p_serviceType in varchar2,
                                       p_longMessage in varchar2                                        
                                    )
      RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'MYJSMPP.FLongSMS( java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String ,     
                        java.lang.String       
                    ) 
return java.lang.String'; 