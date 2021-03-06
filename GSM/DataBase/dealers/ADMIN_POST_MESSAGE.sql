CREATE OR REPLACE PROCEDURE ADMIN_POST_MESSAGE(
  SESSION_ID IN VARCHAR2 DEFAULT NULL,
  MESSAGE_ID IN VARCHAR2 DEFAULT NULL,
  RESPONSE_TEXT IN VARCHAR2 DEFAULT NULL,
  SEND_RESPONSE IN VARCHAR2 DEFAULT NULL
  ) IS
BEGIN
  S_BEGIN(SESSION_ID=>SESSION_ID);
  IF G_STATE.USER_ID IS NOT NULL THEN
    HTP.PRINT('<div id="content">');
    IF SEND_RESPONSE IS NOT NULL 
      AND MESSAGE_ID IS NOT NULL THEN
      IF RESPONSE_TEXT IS NOT NULL THEN 
        UPDATE D_MESSAGES
          SET D_MESSAGES.RESPONSE_USER_ID=G_STATE.USER_ID, 
          D_MESSAGES.RESPONSE_DATE_TIME=SYSDATE, 
          D_MESSAGES.RESPONSE_TEXT=ADMIN_POST_MESSAGE.RESPONSE_TEXT
          WHERE D_MESSAGES.D_MESSAGE_ID=ADMIN_POST_MESSAGE.MESSAGE_ID;
        --
        IF SQL%ROWCOUNT=0 THEN
          HTP.PRINT('������, ��������� � ����� ����� �� �������.');
        ELSE
          HTP.PRINT('����� ���������.
          <br />
          <a href="ADMIN_MESSAGES?'||G_STATE.SESSION_KEY_PARAM_1||'">���������</a>
          ');
        END IF;
      ELSE
        HTP.PRINT('������ ����� ������ �� �����������.');
        S_ADMIN_PRINT_MESSAGE_FORM(MESSAGE_ID);
      END IF;
    ELSE
      HTP.PRINT('������ ����������.');
    END IF;
    HTP.PRINT('</div>');
  END IF;
  S_END;
EXCEPTION WHEN OTHERS THEN
  OUT_ERROR(SQLERRM);
END;
/
