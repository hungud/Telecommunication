CREATE OR REPLACE PROCEDURE GET_PHONE_REST_INFO
(
  pPHONE varchar2 
)
-- version 2
--
--v2. 25.05.2015 Алексеев. Процедуру GET_TARIFF_REST_TABLE внес после проверки номера, а то номер передавался пустым
-- авторы: Алексеев А., Матюнин И. 
-- процедура взаимодействия с IVR (голосовой робот). Дергается вот эта ссылка и возвращается результат обработки запроса: заявка принята или нет. 
--отправка смс с остатком (Ответ: Ваша заявка принята. Результат будет доставлен в SMS.)
IS 
  vRES VARCHAR2(1000 CHAR);
BEGIN
  BEGIN 
    IF (pPHONE IS NOT NULL) AND (LENGTH(pPHONE) = 10) THEN
      vRES := GET_TARIFF_REST_TABLE(pPHONE);
      HTP.PRINT(vRES);
    ELSE
      HTP.PRINT('НЕ КОРРЕКТНО ЗАДАН НОМЕР ТЕЛЕФОНА!'); 
    END IF;
  EXCEPTION 
    WHEN OTHERS THEN
      HTP.PRINT('Error! При выполнении запроса возникла ошибка!');    
  END;        
END;