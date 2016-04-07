GRANT CREATE TYPE TO CORP_MOBILE_LK;
GRANT EXECUTE ON CORP_MOBILE.BEELINE_REST_API_PCKG TO CORP_MOBILE_LK;
GRANT EXECUTE ON CORP_MOBILE.beeline_api_pckg TO CORP_MOBILE_LK;
GRANT EXECUTE ON CORP_MOBILE.TARIFF_RESTS_TABLE TO CORP_MOBILE_LK;


CREATE TYPE CORP_MOBILE_LK.TARIFF_REST_ROW_TYPE AS OBJECT
(
  PHONE_NUMBER VARCHAR2(10 CHAR)
 ,UNIT_TYPE    VARCHAR2(50 CHAR)
 ,REST_TYPE    VARCHAR2(50 CHAR)
 ,INITIAL_SIZE NUMBER(18,2)
 ,CURR_VALUE   NUMBER(18,2)
 ,NEXT_VALUE   NUMBER(18,2)
 ,FREQUENCY    VARCHAR2(16 CHAR)
 ,SOC          VARCHAR2(16 CHAR)
 ,SOC_NAME     VARCHAR2(1024 CHAR)
 ,REST_NAME    VARCHAR2(2048 CHAR)
);

CREATE OR REPLACE TYPE CORP_MOBILE_LK.TARIFF_REST_ROW_TAB AS TABLE OF TARIFF_REST_ROW_TYPE
/


CREATE OR REPLACE FUNCTION CORP_MOBILE_LK.TARIFF_RESTS_TABLE(
  pPHONE_NUMBER IN VARCHAR2
  ) RETURN CORP_MOBILE_LK.TARIFF_REST_ROW_TAB PIPELINED AS
--#Version=3
--
-- Возвращает остатки пакетов
--
-- 3. Уколов. На безлимитных тарифах (Безлимит* и Драйв Анлим) возвращается 
--    безлимитный остаток интернета,  а реальный интернет не показывается.
--
CURSOR C_USER IS
  SELECT 
    LK_USERS.TARIFF_ID,
    LK_USERS.ID,
    TARIFFS.IS_AUTO_INTERNET
  FROM 
    LK_USERS
    JOIN CORP_MOBILE.TARIFFS 
      ON TARIFFS.TARIFF_ID=LK_USERS.TARIFF_ID
    WHERE
      LK_USERS.LOGIN=pPHONE_NUMBER;
recUSER C_USER%ROWTYPE;
vUNLIM_INTERNET BOOLEAN;
--
BEGIN
  -- Особая обраотка - если тариф с "автоинтернетом" или Драйв Анлим, то интернет безлимитный
  OPEN C_USER;
  FETCH C_USER INTO recUSER;
  CLOSE C_USER;
  vUNLIM_INTERNET := (NVL(recUSER.IS_AUTO_INTERNET, 0)=1) OR (recUSER.TARIFF_ID = 2020); -- 2020=Drive Unim 
  FOR vREC IN (
    SELECT * FROM TABLE(CORP_MOBILE.TARIFF_RESTS_TABLE(pPHONE_NUMBER))
    WHERE -- некоторые тексты исключаем из показа
      REST_NAME NOT IN ('Международная связь Золото')
    ) LOOP
      IF NOT vUNLIM_INTERNET OR vREC.UNIT_TYPE<>'INTERNET' THEN
        PIPE ROW(
          TARIFF_REST_ROW_TYPE(
            vREC.PHONE_NUMBER,
            vREC.UNIT_TYPE,
            vREC.REST_TYPE,
            vREC.INITIAL_SIZE,
            vREC.CURR_VALUE,
            vREC.NEXT_VALUE,
            vREC.FREQUENCY,
            vREC.SOC,
            vREC.SOC_NAME,
            vREC.REST_NAME)
        );
      END IF;
      --
  END LOOP;
  --
  -- для безлимитного интернета вставляем фиктивную запись
  IF vUNLIM_INTERNET THEN
    PIPE ROW(
      TARIFF_REST_ROW_TYPE(
        pPHONE_NUMBER,
        'INTERNET',
        'AS',
        -100, -- Магическое значение Безлимит
        0,
        0,
        NULL,
        'UNLIM',
        'Безлимитный интернет',
        'мобильный интернет'
      )
    );
  END IF;
/*
  PIPE ROW(
    TARIFF_REST_ROW_TYPE(
      pPHONE_NUMBER,
      'SMS',
      'AL',
      300,
      2,
      420,
      'M',
      'MSK1000_F',
      'ВдБ Золото 1000 1.0 (фед)',
      'SMS и MMS')
  );
  PIPE ROW(
    TARIFF_REST_ROW_TYPE(
      pPHONE_NUMBER,
      'VOICE',
      'AL',
      4000,
      3999,
      4720,
      'M',
      'MSK1000_F',
      'ВдБ Золото 1000 1.0 (фед)',
      'местные вызовы')
  );
  PIPE ROW(
    TARIFF_REST_ROW_TYPE(
      pPHONE_NUMBER,
      'INTERNET',
      'AS',
      10240,
      7256,
      12083.19,
      'M',
      'MSK1000_F',
      'ВдБ Золото 1000 1.0 (фед)',
      'мобильный интернет')
  );
*/
END;
/

-- select * from table(CORP_MOBILE_LK.TARIFF_RESTS_TABLE2('9637124181'))
-- select * from table(CORP_MOBILE_LK.TARIFF_RESTS_TABLE2('9684045555'))
-- select * from table(CORP_MOBILE_LK.TARIFF_RESTS_TABLE2('9637124181'))
-- SELECT * FROM TABLE(CORP_MOBILE.TARIFF_RESTS_TABLE('9684045555'))

