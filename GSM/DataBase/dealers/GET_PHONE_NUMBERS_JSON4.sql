CREATE OR REPLACE PROCEDURE WWW_DEALER.GET_PHONE_NUMBERS_JSON4( OPERATORID VARCHAR2 DEFAULT NULL, HASH VARCHAR2 DEFAULT NULL) IS
-- #version=2
-- v.2 Афросин А. 2016.02.09 - добавил список пользователей из системы IVIDEON для приема платежей
-- v1. Матюнин И. 2015.06.19 - задача http://redmine.tarifer.ru/issues/2971. Выводим в джейсон спиоск номеров, которые находятся на указанных лицевых счетах   
  CURSOR CUR IS             
    SELECT
      V_ACCOUNT_PHONE_LIST_FOR_1C.PHONE_NUMBER
    FROM
      lontana.V_ACCOUNT_PHONE_LIST_FOR_1C
    UNION ALL
    select
      TO_CHAR(IVIDEON.V_IVIDEION_USERS.ABONENT_ID) PHONE_NUMBER
    FROM
    IVIDEON.V_IVIDEION_USERS                 
     ;
          
  vIS_FIRST BOOLEAN := TRUE;
  FUNCTION PREPARE_JSON(pSTR VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        pSTR, 
        '[', '\['),
        ']', '\]'),
        '''', '\'''),
        '"', '\"'),
        '{', '\{'),
        '}', '\}')
        ;
  END;  
BEGIN
  IF HASH = 'BLABLABLABLA' THEN
    HTP.PRINT('{response: [');
    FOR REC IN CUR LOOP
      -- ['Оператор', 'Номер', 'Цена', 'Склад']
      IF NOT vIS_FIRST THEN 
        HTP.PRN(',['''||PREPARE_JSON(REC.PHONE_NUMBER)||''']');
      ELSE    
        HTP.PRN('['''||PREPARE_JSON(REC.PHONE_NUMBER)||''']');    
        vIS_FIRST := FALSE;
      END IF;      
    END LOOP;
    HTP.PRINT(']}');
  ELSE
    HTP.PRINT(1/0);
  END IF;
END;
/
