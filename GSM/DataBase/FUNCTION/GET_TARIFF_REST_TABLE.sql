CREATE OR REPLACE FUNCTION GET_TARIFF_REST_TABLE (pPHONE IN VARCHAR2)
   RETURN VARCHAR2
IS
   --
   --Version=1
   --
   --v.1 18.02.2015 ������� - ������� ������� ��� ��������� �������� �� ������� ��� �������� �� USSD
   --
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN

   INSERT INTO USSD_TARIFF_REST_QUEUE (PHONE_NUMBER)
        VALUES (SUBSTR (pPHONE, -10));

   COMMIT;

   RETURN MS_PARAMS.GET_REF_TEXT_VALUE ('TARIFF_REST');
END;

CREATE SYNONYM WWW_DEALER.GET_TARIFF_REST_TABLE FOR GET_TARIFF_REST_TABLE;

GRANT EXECUTE ON GET_TARIFF_REST_TABLE TO WWW_DEALER;
