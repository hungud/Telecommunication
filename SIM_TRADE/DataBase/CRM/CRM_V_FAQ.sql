CREATE OR REPLACE VIEW CRM_V_FAQ AS
--Vresion = 1
  SELECT * 
    FROM CRM_FAQ;  

CREATE SYNONYM CRM_USER.FAQ FOR LONTANA.CRM_V_FAQ;    
  
GRANT SELECT ON CRM_V_FAQ TO LONTANA_ROLE;
  
GRANT SELECT ON CRM_V_FAQ TO CRM_USER;