CREATE OR REPLACE VIEW CORP_MOBILE_LK.V_TARIFF_DESCRIPTIONS AS
SELECT
--#Version=1
--
-- ���������� � ������
--
  TARIFFS.TARIFF_ID AS ID,
  TARIFFS.TARIFF_NAME AS NAME,
  TARIFFS.TARIFF_CODE AS CODE,
  TARIFF_DESCRIPTIONS.EXTERNAL_URL,
  TARIFF_DESCRIPTIONS.DESCRIPTION
FROM
  CORP_MOBILE.TARIFFS
  LEFT JOIN TARIFF_DESCRIPTIONS ON TARIFF_DESCRIPTIONS.TARIFF_ID=TARIFFS.TARIFF_ID
/

CREATE OR REPLACE TRIGGER CORP_MOBILE_LK.T_V_TARIFF_DESCRIPTIONS
INSTEAD OF UPDATE ON CORP_MOBILE_LK.V_TARIFF_DESCRIPTIONS
FOR EACH ROW
DECLARE
--#Version=1
  CURSOR cFIND IS
    SELECT TARIFF_ID
    FROM TARIFF_DESCRIPTIONS
    WHERE TARIFF_DESCRIPTIONS.TARIFF_ID=:NEW.ID;
  vDUMMY INTEGER;
BEGIN
  OPEN cFIND;
  FETCH cFIND INTO vDUMMY;
  IF cFIND%FOUND THEN
    UPDATE TARIFF_DESCRIPTIONS
    SET
      TARIFF_DESCRIPTIONS.EXTERNAL_URL = :NEW.EXTERNAL_URL,
      TARIFF_DESCRIPTIONS.DESCRIPTION = :NEW.DESCRIPTION
    WHERE
      TARIFF_DESCRIPTIONS.TARIFF_ID=:NEW.ID;
  ELSE
    INSERT INTO TARIFF_DESCRIPTIONS (
      TARIFF_ID,
      EXTERNAL_URL,
      DESCRIPTION
    ) VALUES (
      :NEW.ID,
      :NEW.EXTERNAL_URL,
      :NEW.DESCRIPTION
      );
  END IF;
  CLOSE cFIND;
END;
/
