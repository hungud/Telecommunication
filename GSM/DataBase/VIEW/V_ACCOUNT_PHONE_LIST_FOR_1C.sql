CREATE OR REPLACE FORCE VIEW V_ACCOUNT_PHONE_LIST_FOR_1C
AS   
   SELECT                                                               
 -- V2. Матюнин И. - 2016.02.29 - Для определения списка доступных для PayKeeper ЛС, добавлен признак PAYKEEPER_ENABLE=1  
 -- V1. Матюнин И. - 2015.06.19 - для задачи http://redmine.tarifer.ru/issues/2971 возвращаем список телефонов, которые находятся на лицевы счетах
 -- По этим лицевым счетам на сатйе GSM возможно будет делать платежи через банковские карты
         DLA.PHONE_NUMBER,
         (SELECT VC.CONTRACT_ID
            FROM V_CONTRACTS VC
           WHERE     VC.PHONE_NUMBER_FEDERAL = DLA.PHONE_NUMBER
                 AND VC.CONTRACT_CANCEL_DATE IS NULL)
            CONTRACT_ID
    FROM DB_LOADER_ACCOUNT_PHONES DLA, ACCOUNTS AC
   WHERE     DLA.YEAR_MONTH = TO_NUMBER (TO_CHAR (SYSDATE, 'YYYYMM'))
         AND DLA.ACCOUNT_ID = AC.ACCOUNT_ID
         AND nvl(AC.PAYKEEPER_ENABLE, 0) = 1
; 


GRANT SELECT ON V_ACCOUNT_PHONE_LIST_FOR_1C TO WWW_DEALER;
