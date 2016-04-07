
  CREATE OR REPLACE FORCE VIEW "SIM_TRADE"."V_ABONENT_ACTIV" ("PHONE_NUMBER", "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20", "A21", "A22", "A23", "A24", "A25", "A26", "A27", "A28", "A29", "A30") AS 
  select b.PHONE_NUMBER,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('01/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('01/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a1,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('02/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('02/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a2,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('03/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('03/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a3,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('04/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('04/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a4,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('05/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('05/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a5,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('06/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('06/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a6,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('07/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('07/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a7,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('08/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('08/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a8,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('09/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('09/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a9,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('10/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('10/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a10,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('11/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('11/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a11,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('12/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('12/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a12,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('13/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('13/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a13,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('14/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('14/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a14,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('15/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('15/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a15,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('06/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('06/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a16,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('17/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('17/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a17,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('18/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('18/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a18,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('19/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('19/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a19,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('20/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('20/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a20,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('21/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('21/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a21,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('22/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('22/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a22,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('23/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('23/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a23,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('24/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('24/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a24,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('25/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('25/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a25,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('26/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('26/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a26,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('27/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('27/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a27,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('28/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('28/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a28,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('29/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('29/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a29,
       NVL((select 1
              from db_loader_account_phone_hists h
              where h.PHONE_NUMBER=b.PHONE_NUMBER and h.PHONE_IS_ACTIVE=1 and rownum = 1
                and h.BEGIN_DATE<=TO_DATE('30/09/2012 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
                and h.END_DATE>=TO_DATE('30/09/2012 00:00:00', 'DD/MM/YYYY HH24:MI:SS')), 0) a30
  from db_loader_bills b
  where b.YEAR_MONTH=201209 