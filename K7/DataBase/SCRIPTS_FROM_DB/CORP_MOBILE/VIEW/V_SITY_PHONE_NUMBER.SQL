
  CREATE OR REPLACE FORCE VIEW "CORP_MOBILE"."V_SITY_PHONE_NUMBER" ("ACCOUNT_ID", "PHONE_NUMBER", "PHONE_IS_ACTIVE", "CONSERVATION", "SYSTEM_BLOCK", "BEGIN_DATE", "CONTRACT_FLAG", "OPTION_NAME", "DOP_STATUS", "FIO", "NOTE") AS 
  SELECT  T.ACCOUNT_ID,
        T.PHONE_NUMBER,
        T.PHONE_IS_ACTIVE,
        T.CONSERVATION,
        T.SYSTEM_BLOCK,
        T.BEGIN_DATE,
        CASE
          WHEN (T.YEAR_MONTH = T.MAX_YM) AND (T.CNT > 0) THEN 'С контрактом'
          WHEN (T.YEAR_MONTH = T.MAX_YM) AND (T.CNT = 0) THEN 'Без контракта'
          WHEN T.YEAR_MONTH < T.MAX_YM THEN 'Номер расторгнут'
        END CONTRACT_FLAG,
        T.OPTION_NAME,
        T.DOP_STATUS,
        T.FIO,
        T.NOTE
FROM
  (SELECT P.ACCOUNT_ID,
       P.PHONE_NUMBER,
       P.PHONE_IS_ACTIVE,
       P.CONSERVATION,
       P.SYSTEM_BLOCK,
       H.BEGIN_DATE,
       P.YEAR_MONTH,
       M.MAX_YM,
       (SELECT COUNT(*) FROM v_contracts c WHERE c.CONTRACT_CANCEL_DATE IS NULL AND p.phone_number = c.PHONE_NUMBER_FEDERAL) CNT,
       (SELECT PO.OPTION_NAME
          FROM DB_LOADER_ACCOUNT_PHONE_OPTS PO
          WHERE PO.ACCOUNT_ID = P.ACCOUNT_ID
            AND PO.YEAR_MONTH = P.YEAR_MONTH
            AND PO.PHONE_NUMBER = P.PHONE_NUMBER
            AND INSTR(PO.OPTION_CODE, 'RDIRECT_') > 0
            AND ROWNUM = 1) AS OPTION_NAME,
            inf.dop_status,
            inf.fio,
            inf.note
   FROM DB_LOADER_ACCOUNT_PHONES P,
       DB_LOADER_ACCOUNT_PHONE_HISTS H,
       (SELECT MAX(YEAR_MONTH) MAX_YM FROM DB_LOADER_ACCOUNT_PHONES) M,

       (select con.phone_number_federal,con.phone_number_city, cds.dop_status_name dop_status,
 ab.surname||' '||ab.name||' '||ab.patronymic fio,
 ab.description note
 from abonents ab, contracts con, contract_dop_statuses cds
where ab.abonent_id=con.abonent_id
and con.dop_status=cds.dop_status_id(+)) inf

   WHERE P.CELL_PLAN_CODE IN (SELECT TARIFFS.TARIFF_CODE
                             FROM TARIFFS
                             WHERE TARIFFS.PHONE_NUMBER_TYPE=1)
    AND P.PHONE_NUMBER=H.PHONE_NUMBER
    AND H.END_DATE>=SYSDATE
    AND H.BEGIN_DATE<SYSDATE
    AND P.YEAR_MONTH=(SELECT MAX(YEAR_MONTH)
                      FROM DB_LOADER_ACCOUNT_PHONES
                      WHERE PHONE_NUMBER = P.PHONE_NUMBER)
    AND   P.Phone_Number=inf.phone_number_federal(+)) T

UNION ALL
SELECT -1 ACCOUNT_ID,
       C.PHONE_NUMBER_federal PHONE_NUMBER,
       0 PHONE_IS_ACTIVE,
       NULL CONSERVATION,
       NULL SYSTEM_BLOCK,
       NULL BEGIN_DATE,
       'Без истории' CONTRACT_FLAG,
       'Неизвестно' OPTION_NAME,
       NULL dop_status,
       NULL fio,
       NULL note
FROM CONTRACTS C
WHERE PHONE_NUMBER_TYPE = 1
     AND 0 = (SELECT COUNT(*)
              FROM DB_LOADER_ACCOUNT_PHONES
              WHERE C.PHONE_NUMBER_FEDERAL= PHONE_NUMBER)
