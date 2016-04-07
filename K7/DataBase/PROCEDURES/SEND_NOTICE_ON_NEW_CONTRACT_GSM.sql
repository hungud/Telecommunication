CREATE OR REPLACE PROCEDURE LONTANA.SEND_NOTICE_ON_NEW_CONTRACT(
  pCONTRACT_ID IN INTEGER
  ) IS
--
--Version=4 
-- Овсянников Л.В. 12.11.2012 Добавление отправка ещё 2-х смс при подключении нового абонента.
-- Овсянников Л.В. 13.11.2012 Исправление текста 2-ой смс.
CURSOR C IS
  SELECT CONTRACTS.PHONE_NUMBER_FEDERAL,
         OPERATORS.OPERATOR_NAME,
         ABONENTS.SURNAME||' '||ABONENTS.NAME||' '||ABONENTS.PATRONYMIC FIO         
    FROM CONTRACTS, 
         OPERATORS,
         ABONENTS      
    WHERE CONTRACTS.CONTRACT_ID=pCONTRACT_ID
      AND CONTRACTS.OPERATOR_ID=OPERATORS.OPERATOR_ID
      AND CONTRACTS.ABONENT_ID=ABONENTS.ABONENT_ID;      
rec C%ROWTYPE;
SMS_TEXT VARCHAR2(500 CHAR);
SMS VARCHAR2(500 CHAR); 
BEGIN
  OPEN C;
  FETCH C INTO rec;
  CLOSE C;
  IF rec.OPERATOR_NAME='Билайн' THEN
    SMS_TEXT:='Вас приветствует gsmcorp.ru,спасибо,что воспользовались услугами нашей компании!';
    SMS:=LOADER3_PCKG.SEND_SMS(
           rec.PHONE_NUMBER_FEDERAL,
           'Смс-оповещение',
           SMS_TEXT);
    SMS_TEXT:= 'Ув. абонент,проверить баланс - *200*555# и 0588, служба поддержки-84956487888 или с мобильного-05455 (работает при блокировке).';
    SMS:=LOADER3_PCKG.SEND_SMS(
           rec.PHONE_NUMBER_FEDERAL,
           'Смс-оповещение',
           SMS_TEXT);
    SMS_TEXT:='Проверить баланс, подключенные услуги и детализацию можно на сайте www.gsmcorp.ru в разделе кабинет абонента.';
    SMS:=LOADER3_PCKG.SEND_SMS(
           rec.PHONE_NUMBER_FEDERAL,
           'Смс-оповещение',
           SMS_TEXT);
    IF SMS IS NULL THEN  
      INSERT INTO BLOCK_SEND_SMS(PHONE_NUMBER, SEND_DATE_TIME, ABONENT_FIO) 
        VALUES (rec.PHONE_NUMBER_FEDERAL, sysdate, rec.FIO);
    END IF;
    COMMIT;       
  END IF;
END;
/

--grant execute on SEND_NOTICE_ON_NEW_CONTRACT to lontana_role;