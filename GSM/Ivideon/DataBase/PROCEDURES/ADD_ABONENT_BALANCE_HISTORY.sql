CREATE OR REPLACE PROCEDURE ADD_ABONENT_BALANCE_HISTORY
(
  pABONENT_ID IN INTEGER,
  pHISTORY_DATE IN DATE,
  pAMOUNT IN                 NUMBER,
  pBALANCE_AFTER IN          NUMBER,
  pSERVICE_TYPE_ID IN        INTEGER,
  pTARIFF_ID IN              INTEGER,
  pIVIDEON_PAYMENT_ID IN     INTEGER,
  pPAYMENT_PURPOSE_ID IN     INTEGER,
  pREQUEST_ID in INTEGER default null
) IS
--
--#Version=1
--
--v.1 01.20.2016 - Афросин добавляем записи в историю изменения баланса
--
begin
  INSERT INTO ABONENT_BALANCE_HISTORY 
                                            (
                                              ABONENT_ID,
                                              HISTORY_DATE,
                                              AMOUNT,
                                              BALANCE_AFTER,
                                              SERVICE_TYPE_ID,
                                              TARIFF_ID,
                                              IVIDEON_PAYMENT_ID,
                                              PAYMENT_PURPOSE_ID,
                                              IVIDEON_REQUEST_ID
                                            )
         values
                                            (
                                              pABONENT_ID,
                                              pHISTORY_DATE,
                                              pAMOUNT,
                                              pBALANCE_AFTER,
                                              pSERVICE_TYPE_ID,
                                              pTARIFF_ID,
                                              pIVIDEON_PAYMENT_ID,
                                              pPAYMENT_PURPOSE_ID,
                                              pREQUEST_ID
                                            );
end;