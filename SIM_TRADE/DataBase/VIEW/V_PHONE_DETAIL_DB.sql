CREATE OR REPLACE FORCE VIEW V_PHONE_DETAIL_DB
AS
   SELECT "ACCOUNT_ID",
          "YEAR_MONTH",
          "PHONE_NUMBER",
          "PHONE_IS_ACTIVE",
          "CELL_PLAN_CODE",
          "NEW_CELL_PLAN_CODE",
          "NEW_CELL_PLAN_DATE",
          "LAST_CHECK_DATE_TIME",
          "ORGANIZATION_ID",
          "CONSERVATION",
          "SYSTEM_BLOCK",
          "SUBSCR_NO",
          "CALL_DATE",
          "CALL_TIME",
          "SERVICE_NAME",
          "SERVICEDIRECTION",
          "CALLING_NO",
          "DURATION",
          "CALL_COST",
          "ISROAMING",
          "ROAMINGZONE",
          "AT_FT_DE"
     FROM DB_LOADER_ACCOUNT_PHONES DLA,
          TABLE (
             CAST (
                WWW_GET_PHONE_DETAIL_DB (DLA.PHONE_NUMBER, DLA.YEAR_MONTH) AS DETAIL_LK_TAB)) DD;


GRANT SELECT ON V_PHONE_DETAIL_DB TO CORP_MOBILE_LK;