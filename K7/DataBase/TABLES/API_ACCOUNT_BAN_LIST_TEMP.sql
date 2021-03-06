CREATE GLOBAL TEMPORARY TABLE API_ACCOUNT_BAN_LIST_TEMP
(
   BAN NUMBER,
   BAN_NAME VARCHAR2(250),
   MARKET_CODE VARCHAR2(10),
   BAN_CURRENCY_IND VARCHAR2(1)
)
ON COMMIT PRESERVE ROWS;

COMMENT ON TABLE API_ACCOUNT_BAN_LIST_TEMP IS '��������� ������� ��� �������� c������ �������� �� ������ getBANInfoList';

COMMENT ON COLUMN API_ACCOUNT_BAN_LIST_TEMP.BAN IS '����� ����';

COMMENT ON COLUMN API_ACCOUNT_BAN_LIST_TEMP.BAN_NAME IS '��� ����';

COMMENT ON COLUMN API_ACCOUNT_BAN_LIST_TEMP.MARKET_CODE IS '��� �������';

COMMENT ON COLUMN API_ACCOUNT_BAN_LIST_TEMP.BAN_CURRENCY_IND IS '��� ������ ���� ("P" - �����,"D" - ������)';