CREATE OR REPLACE PACKAGE ARCHIVE_PCKG AS
--
--#Version=1
--
  FUNCTION ADD_ARCHIVE_RECORD(
    pREPORT_TYPE IN VARCHAR2
    ) RETURN INTEGER;  
--      
  PROCEDURE CREAR_DUBLI_PAYMENTS;  
--       
END;
/

CREATE OR REPLACE PACKAGE BODY ARCHIVE_PCKG AS
   --
  FUNCTION ADD_ARCHIVE_RECORD(
    pREPORT_TYPE IN VARCHAR2
    ) RETURN INTEGER IS
  vDATE DATE;
  NEW_ID INTEGER;
  BEGIN
    NEWID:=S_NEW_ARCHIVE_INFO.NEXTVAL;
    RETURN NEWID;
  END;
   --
  PROCEDURE CREAR_DUBLI_PAYMENTS IS
  BEGIN
    NULL;
  END;
   --
END;
/
