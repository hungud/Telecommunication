
  CREATE OR REPLACE FORCE VIEW "LONTANA"."V_CONTRACTS_FOR_1C" ("PHONE_NUMBER", "DATE_ACTIVATE", "CONTRACT_CANCEL_DATE", "TARIFF_NAME") AS 
  SELECT C1.phone_number,
         C1.date_activate,
         C1.CONTRACT_CANCEL_DATE,
         TARIFFS.TARIFF_NAME
    FROM (select contracts.PHONE_NUMBER_FEDERAL phone_number,
                 contracts.CONTRACT_DATE date_activate,
                 contract_cancels.CONTRACT_CANCEL_DATE,
                 CONTRACTS.TARIFF_ID,
                 (select contract_changes.TARIFF_ID
                    from contract_changes
                    where contract_changes.CONTRACT_ID = contracts.CONTRACT_ID
                      AND contract_changes.CONTRACT_CHANGE_DATE = (SELECT MAX(contract_changes.CONTRACT_CHANGE_DATE)
                                                                     FROM contract_changes
                                                                     WHERE contract_changes.CONTRACT_ID = contracts.CONTRACT_ID) 
                      AND ROWNUM = 1                                               
                 ) TARIFF_ID_CHANGE
            from contracts,
                 contract_cancels
            where contracts.CONTRACT_ID=contract_cancels.CONTRACT_ID(+)) C1, 
         TARIFFS
    WHERE NVL(C1.TARIFF_ID_CHANGE, C1.TARIFF_ID) = TARIFFS.TARIFF_ID 