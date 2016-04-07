
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SEND_SMS_ABOUT_TARIFF_CHANGE" (pPhoneNumber in varchar2) IS
/******************************************************************************
   NAME:       SEND_SMS_ABOUT_TARIFF_CHANGE
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   3.0         06/10/2015  Алексеев       Отменил ограничение по рассылке смс на номера с тп с кодами PB450CL_F, PS750CL_F, PS900CL_F, MSKMINCLF, MSKLIGLCF. Вернул к версии 1.
   2.0         01/10/2015  Алексеев       Ограничил рассылку смс на номера с тп с кодами PB450CL_F, PS750CL_F, PS900CL_F, MSKMINCLF, MSKLIGLCF
   1.0        21/11/2014   Афросин       1.Создал процедуру  для рассылки сообщений о смене тарифа

   NOTES:

******************************************************************************/

  SMS VARCHAR2(500 CHAR);
BEGIN

    SMS := LOADER3_pckg.SEND_SMS(pPhoneNumber,'SMS-info','Тарифный план изменен успешно.', 0, GET_SMS_SENDER_NAME_BY_PHONE (pPhoneNumber));
    
END SEND_SMS_ABOUT_TARIFF_CHANGE;