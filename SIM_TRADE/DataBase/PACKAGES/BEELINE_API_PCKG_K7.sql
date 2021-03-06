CREATE OR REPLACE PACKAGE BEELINE_API_PCKG AS
--
--#Version=21
-- 21.  19.01.2015 �������. �� ��������� ����������� ��� ������ ��� �������� �� API �������� UC.serviceName AT_FT_CODE � HOT_BILLING_GET_CALL_TAB
-- 20. 30.12.2014 �������. ����� ���������-�������� � ��������� �������
-- 19. 29.12.2014 �������. ����� ���������-�������� � ��������� �������
-- 18. 29.12.2014 �������. ���������� �������������� ����������� ���� ������� �� ���
-- 17. 18.12.2014 �������. �������� ��������. ������� �������� ������� �������.
-- 16. 15.10.2014 �������. ����������� �������� ��������. ������ �����.
-- 15. 15.10.2014 �������. ����������� �������� ��������.
-- 14. 15.10.2014 �������. ������� ����� ������ � ��������. ����� �� ������ ��������-������.
-- 13. 10.10.2014 �������. ������� ���������� ���� �������.
-- 12. 02.10.2014 ������ �. �������� ������� ACCOUNT_PHONE_STATUS. ��������� �������� �������� ���� ��������� ����� �������
--    �� XML � ����������� �����������/���������� ���� LAST_CHANGE_STATUS_DATE ������� DB_LOADER_ACCOUNT_PHONES ���������� ���������
-- 11. 25.09.2014 �������. ������ �������������� ��� � ������� ������ �� ������� �� ������ CONVERT_PCKG
-- 10. 10.09.2014 �������. ��������� ��������� UNLOCK_PHONES. ������ ��������� � ����� �������� ������ ������ ���� �������   
-- 9. 01.10.2013 �����. ������� �������� �������� �� �\� � ������������� �\�.
-- 8. 29.08.14. ������. �������� ��� ��������� � �������� �������.
-- 7. 24.07.14. ������. ������� �������� ���� � ���� ��������������� ���������� ��� �����.
-- 6. 24.07.14. ������. �������� ���������� ����� ��� �����������/���������� �����
-- 5 21.07.14 ���������. ������� ������� TURN_TARIFF_OPTION, ������� ���������� ��� ��������� �������� ����� ��� ������.
-- 4.21.07.14 ���������. ����������� ��������
--������ SIM �����
FUNCTION REPLACE_SIM(
  pPHONE_NUMBER IN VARCHAR2,
  pICC         in varchar2
  ) RETURN VARCHAR2;
--���������� ��������.
--pCode - ������� ����������: WIB � ���������� �� �������, STO � ���������� �� �����
FUNCTION LOCK_PHONE(
  pPHONE_NUMBER IN VARCHAR2,
  pMANUAL_BLOCK IN INTEGER DEFAULT 1,
  pCode in varchar2
  ) RETURN VARCHAR2;
--������������� ��������.
FUNCTION UNLOCK_PHONE(
  pPHONE_NUMBER IN VARCHAR2,
  pMANUAL_UNLOCK IN INTEGER DEFAULT 1
  ) RETURN VARCHAR2;
Function account_phone_payments  (
  pAccount_id in number
  ) return varchar2;    
--������ ��������
Function phone_status  (
  pPHONE_NUMBER in number
  ) return varchar2;  
--  
function account_phone_status(
  Paccount_id in number
  ) return varchar2;
--  
function account_phone_options(
  Paccount_id in number
  ) return varchar2;
function Collect_account_phone_status(
  Paccount_id in number,
  nMOD_NUM in number default 0,--������ ������
  nMOD in number default 1--������
  ) return varchar2;
--���������� ������ ��� �� ����������
function Collect_account_BANS(
  Paccount_id in number
  ) return varchar2;                                     
--����� ��������
Function phone_options  (
  pPHONE_NUMBER in number
  ) return varchar2;
function Collect_account_phone_opts(
  Paccount_id in number
  ) return varchar2;
--������� �������
Function phone_detail_call (
  pPHONE_NUMBER in number
  ) return varchar2;
--�������� ����� � ���
Function Get_account_bill (
  pAccount_id in number,
  pRequestID in number
  )return varchar2;
--������ ������ �������
Function get_ticket_status (
  pAccount_id in number,
  pRequestID in VARCHAR2
  ) return varchar2 ;
--�������� ������ �� ����������� �����.
FUNCTION Create_account_bill(
  PaccountId IN VARCHAR2,
  Pyear_month IN INTEGER 
  ) RETURN VARCHAR2;
--������� ���������� �� ������
Function phone_report_data  (
  pPHONE_NUMBER in number
  ) return varchar2;   
--�������� ������� ���������� �� �/� 
function account_report_data(
  Paccount_id in number,
  n_mod in number
  ) return varchar2;  
-- ������� TURN_TARIFF_OPTION ���������� ��� ��������� �������� ����� ��� ������.
-- ������������ �������� ��� ������ ��� ����� ������.
-- ������ ����������� � ������� BEELINE_TICKETS, ������ ������ ��������� ����������� JOB �������� �������.
FUNCTION TURN_TARIFF_OPTION(
  pPHONE_NUMBER IN VARCHAR2,
  pOPTION_CODE IN VARCHAR2,
  pTURN_ON IN INTEGER, -- 0: ���������, 1: ��������
  pEFF_DATE IN DATE,   -- ���� ����������� ������ (NULL - ����� ������)
  pEXP_DATE IN DATE,   -- ���� ��������������� ���������� (NULL - �� ���������)
  pREQUEST_INITIATOR IN VARCHAR2 -- ��������� ������� (�� 10 ������)
  ) RETURN VARCHAR2;        
-- �������� ����������� �� ���
PROCEDURE LOAD_DETAIL_FROM_API(
  pPHONE_NUMBER IN VARCHAR2
  );                  
END;
/
CREATE OR REPLACE PACKAGE BODY BEELINE_API_PCKG AS

  const_year_month number; -- ������� �����-���   
 ----------   
  FUNCTION REPLACE_SIM(
    pPHONE_NUMBER IN VARCHAR2, 
    pICC in varchar2
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN,
             ACCOUNTS.New_Pswd,
             ACCOUNTS.ACCOUNT_NUMBER,
             ACCOUNTS.Company_Name,
             Accounts.Account_Id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);
    --
    vREC     C%ROWTYPE;
    V_RESULT VARCHAR2(20000);
    oICC     VARCHAR2(18);
    Respond  varchar2(5000); -- �����
--    pbsal_id integer;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);        
        panswer:=BEELINE_SOAP_API_PCKG.replaseSIM(Respond, pPHONE_NUMBER, pICC, '',vrec.account_id);                  
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:replaceSIMResponse/return'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null 
        then 
        select 
        nvl(pANSWER.Err_text,
        extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
        ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
        )
        into V_RESULT
        from dual; 
        if V_RESULT is null then  raise_application_error(-20000, '������������� ������ ��.'); else return(V_RESULT);end if;
        else
          --���������� � ��� 
          insert into REPLACE_SIM_LOG
            values(pPHONE_NUMBER, oICC, pICC, null, null,0,pANSWER.BSAL_ID);
          --���������� ������ ������ �� ��������                   
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number, user_created, date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 12, null, null, pPHONE_NUMBER, user, sysdate);                   
          commit;
          return V_RESULT;                  
        end if;

      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          insert into REPLACE_SIM_LOG
           values
          (pPHONE_NUMBER, oICC, pICC, null, null,2,pANSWER.BSAL_ID);
          commit;
          return Respond;
      END;        
    ELSE
      insert into REPLACE_SIM_LOG
           values
          (pPHONE_NUMBER, oICC, pICC, null, null,1,null);
          commit;
      RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
    END IF;
  END;

  FUNCTION LOCK_PHONE(
    pPHONE_NUMBER IN VARCHAR2,
    pMANUAL_BLOCK IN INTEGER DEFAULT 1,
    pCode         in varchar2
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);
    vREC C%ROWTYPE;
  --  abREC    ABONENT%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--�������� �����
        pANSWER:=BEELINE_SOAP_API_PCKG.suspendCTN(Respond, pPHONE_NUMBER, sysdate + 1 / 86400, '', pCode,vrec.account_id);--������ � ���
        --������ ������
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:suspendCTNResponse/return'
                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null then--���� ��� ����������� ������ ������
          --���� ����� ������
          if pANSWER.Err_text!='OK' then 
            V_RESULT:=pANSWER.Err_text;
          else
            select nvl(pANSWER.Err_text,    
                       extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') )
              into V_RESULT from dual; 
          end if;     
          --��� ������ ������ ���������� ������������� ������
          if V_RESULT is null then
            raise_application_error(-20000, '������������� ������ ��.');
          --���� ����� ������ ���������� ���   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --���� �� � ������� � ���� �����
        else
         --���������� � ��� 
          INSERT INTO AUTO_BLOCKED_PHONE(PHONE_NUMBER, BALLANCE, BLOCK_DATE_TIME,
                                          MANUAL_BLOCK, USER_NAME, ABONENT_FIO, note)
            VALUES(pPHONE_NUMBER, GET_ABONENT_BALANCE(pPHONE_NUMBER), SYSDATE,
                    pMANUAL_BLOCK, USER, FIO, '������ �� ���� �'||V_RESULT);
         --���������� ������ ������ �� ��������
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 9, null, null,pPHONE_NUMBER,user,sysdate);
          commit;
          --���������� ����� ������ �� ��������
          return ('������ �� ���� �'||V_RESULT);          
        end if;
      --� ������ ���������� ���������� ������  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;
    ELSE
      RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
    END IF;
  END;
  --
  FUNCTION UNLOCK_PHONE(
    pPHONE_NUMBER  IN VARCHAR2,
    pMANUAL_UNLOCK IN INTEGER DEFAULT 1
    ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);  
    vREC     C%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--�������� �����
        pANSWER:=BEELINE_SOAP_API_PCKG.restoreCTN(Respond, pPHONE_NUMBER, sysdate + 1 / 86400,'',vrec.account_id);--������ � ���
        --������ ������
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:restoreCTNResponse/return'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null then --���� ��� ����������� ������ ������
           --���� ����� ������
          select nvl(pANSWER.Err_text,
                     extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
            into V_RESULT from dual;                        
              --��� ������ ������ ���������� ������������� ������
          if V_RESULT is null then  
            raise_application_error(-20000, '������������� ������ ��.');
          --���� ����� ������ ���������� ���   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --���� �� � ������� � ���� �����
         else
         --���������� � ��� 
          INSERT INTO AUTO_UNBLOCKED_PHONE(PHONE_NUMBER, BALLANCE, UNBLOCK_DATE_TIME,
                                            MANUAL_BLOCK, USER_NAME, ABONENT_FIO, note)
            VALUES(pPHONE_NUMBER, GET_ABONENT_BALANCE(pPHONE_NUMBER), SYSDATE, 
                    pMANUAL_UNLOCK, USER, FIO, '������ �� ������� �'||V_RESULT);
          --���������� ������ ������ �� ��������
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 10, null, null,pPHONE_NUMBER,user,sysdate);
          commit;
          --���������� ����� ������ �� ��������
          return ('������ �� ������� �'||V_RESULT); 
         
        end if;
      --� ������ ���������� ���������� ������  
      exception
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      end;
      return Respond;
    ELSE
      RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
    END IF;
  END;
 
  Function phone_status(
    pPHONE_NUMBER in number
    ) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,
             (case ACCOUNTS.Is_Collector
                when 1 then nvl(bi.ban,0)
                else accounts.account_number
              end) account_number, accounts.account_id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf bi
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          and bi.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = ( select max(YEAR_MONTH) 
                                                        from DB_LOADER_ACCOUNT_PHONES 
                                                        where PHONE_NUMBER = pPHONE_NUMBER);                                                           
    vREC C%ROWTYPE;
    Respond  varchar2(5000); -- �����
    Resp_code varchar2(200);-- ����� ���
    Resp_plan varchar2(200);-- ����� ���
    Resp_date_change varchar2(200 char);
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  
    vCOMMENT VARCHAR2(1000 CHAR);
  
    procedure update_phones (ph in varchar2,ym in number,acc in number, pCODE IN VARCHAR2, pDATE_CHANGE IN DATE) as 
      PRAGMA AUTONOMOUS_TRANSACTION;
    begin
      update db_loader_account_phones q 
        set q.phone_is_active=decode(Respond,'ACTIVE',1,'BLOCKED',0)
           ,q.last_check_date_time=sysdate 
           ,q.conservation=decode(Respond, 'ACTIVE',0,'BLOCKED', decode(Resp_code,'S1B',1,'DUF',1,'BSB',1,'DOSS',1,0))
           ,q.system_block=decode(Respond, 'ACTIVE',0,'BLOCKED', decode(Resp_code,'BSB',1,'DUF',1,'DOSS',1,0))
           ,q.cell_plan_code=Resp_plan
           ,Q.LAST_CHANGE_STATUS_DATE=pDATE_CHANGE
           ,Q.STATUS_ID=CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(pCODE)                                                         
        where q.phone_number=ph 
          and q.year_month=ym 
          and q.account_id=acc
          and trim(Respond) in ('ACTIVE','BLOCKED');               
      temp_add_account_phone_history(ph, Resp_plan, case Respond when 'ACTIVE' then 1 when 'BLOCKED' then 0 end, sysdate);
      commit;
    end;      

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/status',      'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/reasonStatus','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"') 
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/pricePlan',   'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')   
              ,extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList/statusDate',  'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
        into Respond,Resp_code,Resp_plan, Resp_date_change from dual; 
--insert into beeline_soap_api_log(soap_answer) values (pANSWER.ANSWER); commit;--�������� ������ ��� �������!
        update_phones(pPHONE_NUMBER,to_char(sysdate,'YYYYMM'),vrec.account_id, Resp_code, convert_pckg.TIMESTAMP_TZ_TO_DATE(Resp_date_change));
      EXCEPTION
        WHEN OTHERS THEN
          Respond := pANSWER.Err_text||CHR(13)||SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='�� ������ �\�';
    end if;
    SELECT B.COMMENT_CLENT INTO vCOMMENT
      FROM BEELINE_STATUS_CODE B
      WHERE B.STATUS_CODE = Resp_code;
    Return ('������: '||Respond||'. ��� ������: '||Resp_plan||'. ��� �������: '||Resp_code||'('||vCOMMENT||')');
  end;  

  Function phone_options  (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd
             ,decode(accounts.is_collector,1,li.ban,0,accounts.account_number,accounts.account_number) account_number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf li
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         and li.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
         and DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);   

   vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  
    vStart_date date;

    procedure update_options(pctn in varchar2, pserviceId in varchar2, pserviceName in varchar2,pStDate in date,pEndDate in date) as
      pragma autonomous_transaction;
      begin
         db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
                      to_char(sysdate,'YYYY'),
                      to_char(sysdate,'MM'),
                      vrec.login,
                      pctn, /*�����*/
                      pserviceId,       /* ��� ����� */
                      pserviceName,       /* ������������ ����� */
                      null, /* ��������� ����� */
                      pStDate,          /* ���� �����������*/
                      pEndDate,         /* ���� ���������� */
                      null,        /*��������� �����������*/
                      null        /*��������� � �����*/
                      );
        commit;
      end;
    procedure update_option_close(pctn in varchar2, pStart_date in date) as
      pragma autonomous_transaction;
      cursor otp_select is
        select *
          from db_loader_account_phone_opts op
          where op.PHONE_NUMBER = pctn
            and op.LAST_CHECK_DATE_TIME >= pStart_date;
      o_dummy otp_select%rowtype;
      begin
        open otp_select;
        fetch otp_select into o_dummy;
        if otp_select%found then 
          update db_loader_account_phone_opts op
            set op.TURN_OFF_DATE = sysdate
            where op.PHONE_NUMBER = o_dummy.PHONE_NUMBER
              and op.YEAR_MONTH = o_dummy.YEAR_MONTH
              and op.TURN_OFF_DATE is null
              and op.LAST_CHECK_DATE_TIME < pStart_date;
        end if;
        close otp_select;
        commit;
      end;

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        vStart_date:=sysdate;
        pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        For i in(
        select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                     ,extractvalue (value(d) ,'/servicesList/serviceId')   serviceId
                     ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/startDate')) startDate
                     ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/endDate')) endDate
                     ,extractvalue (value(d) ,'/servicesList/serviceName') serviceName
        from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                 ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
        )loop
        update_options(to_char(i.ctn),i.serviceId, i.serviceName,i.startDate,i.endDate);
       
        Respond:=Respond||i.serviceId||' '||i.serviceName||chr(13);
        end loop; 
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='�� ������ �\�';
    end if;
    update_option_close(pPHONE_NUMBER, vStart_date);
    Return (Respond);
  end; 

  Function phone_detail_call (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
       WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
         AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
         AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
            from DB_LOADER_ACCOUNT_PHONES where PHONE_NUMBER = pPHONE_NUMBER);   
 

   vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);  

 begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledCallsList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
/*        For i in(        
        select substr(extractvalue (value(d) ,'UnbilledCallsList/callNumber'),-10) callNumber
                     ,extractvalue (value(d) ,'UnbilledCallsList/callDate')   callDate
                     ,substr(extractvalue (value(d) ,'UnbilledCallsList/callToNumber'),-10) callToNumber
                     ,extractvalue (value(d) ,'UnbilledCallsList/serviceName') serviceName
                     ,extractvalue (value(d) ,'UnbilledCallsList/callType') callType
                     ,extractvalue (value(d) ,'UnbilledCallsList/dataVolume') dataVolume
                     ,extractvalue (value(d) ,'UnbilledCallsList/callAmt') callAmt                                                               
                     ,extractvalue (value(d) ,'UnbilledCallsList/callDuration') callDuration  
        from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList'
                 ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d
        )loop
        
        end loop;*/ 
        respond:=pANSWER.BSAL_ID;
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='�� ������ �\�';
    end if;
  Return (Respond);
 end;

function account_phone_status(
  Paccount_id in number
  ) return varchar2 is--phone_state_table  
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
      FROM  ACCOUNTS
      WHERE ACCOUNTS.account_id = Paccount_id;  
  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- �����
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  vYEAR_MONTH INTEGER;
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=0 or vRec.Is_Collector is null THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number,'');        
        if pANSWER.Err_text='OK' then    
          --             
          DELETE FROM API_GET_CTN_INFO_LIST;
          --
          INSERT INTO API_GET_CTN_INFO_LIST(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR)
            SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                   ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                   ,extractvalue (value(d) ,'/CTNInfoList/status') status
                   ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                   ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                   ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                   ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                   ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR
              FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;
          --     
          vYEAR_MONTH:=TO_NUMBER(to_char(sysdate,'YYYYMM'));         
          MERGE INTO db_loader_account_phones ph
          -- ������� ���������
            USING (select substr(d.ctn, -10) ctn
                         ,d.status stat
                         ,d.reasonStatus reason
                         ,d.pricePlan plan
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(d.statusDate) statusDate
                         ,bsc.IS_CONSERVATION
                         ,bsc.IS_SYSTEM_BLOCK
                     from API_GET_CTN_INFO_LIST d
                     left outer join BEELINE_STATUS_CODE bsc on bsc.STATUS_CODE = d.reasonStatus                     
                  ) api
            ON (ph.phone_number = api.ctn 
                  and ph.year_month=vYEAR_MONTH 
                  and ph.account_id=Paccount_id)                
          WHEN MATCHED THEN
          -- ����� �����
            UPDATE SET ph.phone_is_active=CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END,
                       ph.cell_plan_code=api.plan,
                       ph.last_check_date_time=sysdate,
                       ph.last_change_status_date=api.statusDate,                
                       ph.conservation = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                       ph.system_block = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                       PH.STATUS_ID = CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(API.REASON)
            WHERE (api.stat in ('ACTIVE','BLOCKED')                        -- ��� ���� ������ �� ������ �� ��� 
                    or (api.stat is null and ph.last_check_date_time<sysdate-1))-- ���� ����� �� ���������� ����� ����� � ����� ������� ������ ��� ���� ����� ��� �������    
          WHEN NOT MATCHED THEN
          -- ����� �� �����
            INSERT (ph.account_id, ph.year_month, ph.phone_number,
                    ph.phone_is_active, ph.cell_plan_code, ph.last_check_date_time,
                    ph.organization_id, ph.conservation, ph.system_block, 
                    ph.last_change_status_date, ph.STATUS_ID  )
              VALUES (Paccount_id, vYEAR_MONTH, api.ctn,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END, 
                      api.plan, sysdate, 1, 
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                      api.statusDate, convert_pckg.STATUS_CODE_TO_STATUS_ID(api.reason)  )
            WHERE api.stat in ('ACTIVE','BLOCKED');
          --- MERGE END   
          Respond:='Update '||sql%rowcount;
          -- ������ ������, ������� �������� �/�, �.�. ���� � DB_LOADER_ACCOUNT_PHONES, �� ��� � �������� �� ���
          DELETE 
            FROM DB_LOADER_ACCOUNT_PHONES PH
            WHERE PH.ACCOUNT_ID = pACCOUNT_ID
              AND PH.YEAR_MONTH = vYEAR_MONTH 
              AND PHONE_NUMBER NOT IN (select substr(d.ctn, -10) ctn                         
                                         from API_GET_CTN_INFO_LIST d);
           --��������� ������ � ������� � ���������� ����
          if sql%rowcount>0 then 
            for hist in(select substr(d.ctn,-10) ctn
                              ,d.status stat
                              ,d.reasonStatus reason
                              ,d.pricePlan plan
                          from API_GET_CTN_INFO_LIST d
                          where d.status in ('ACTIVE','BLOCKED'))
            loop
              temp_add_account_phone_history(hist.ctn, hist.plan, case hist.stat when 'ACTIVE' then 1 when 'BLOCKED' then 0 end, sysdate);
              --���.������ ����
              if hist.stat='BLOCKED' and hist.reason in ('BSB','DUF') AND ms_constants.GET_CONSTANT_VALUE('SERVER_NAME')='CORP_MOBILE' then 
                update contracts ct 
                  set ct.dop_status=8 --(�� ����������� contracts_dop_statuses = ����)
                  where not exists (select 1 from contract_cancels cc where cc.contract_id=ct.contract_id) 
                    and ct.phone_number_federal=hist.ctn;
              end if;                                                                                                                                                                                                                                                   
            end loop hist;
          end if;
          commit;
          --����������� � ��� �������� 
          insert into account_load_logs( account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
            values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok!'||Respond, 3);          
          if sql%rowcount>0 then 
            commit;
          end if;
        else 
          Respond:= pANSWER.Err_text;
        end if;
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;--api_responce
    Else
      Respond:='�� ������ �\�';
    end if;--vrec.login
    Return Respond;           
  end;--func

function account_phone_options(
  Paccount_id in number
  ) return varchar2  is--phone_state_table 
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
       WHERE ACCOUNTS.account_id = Paccount_id; 
   vREC     C%ROWTYPE;
   Respond  varchar2(5000); -- �����
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
   count_good integer:=0;
   count_bad integer:=0;   
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and (vRec.Is_Collector=0 or vRec.Is_Collector is null)  THEN
    BEGIN      
      for i in (select ph.phone_number
                     from db_loader_account_phones ph 
                     where ph.year_month=const_year_month and ph.account_id=Paccount_id
                     order by get_last_options_update(ph.phone_number) 
      ) loop
      pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),i.phone_number,vREC.account_number,'');            
      if pANSWER.Err_text='OK' then    
       --���� �� ������
        for s in (select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                         ,trim(extractvalue (value(d) ,'/servicesList/serviceId'))   serviceId
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/startDate')) startDate
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue (value(d) ,'/servicesList/endDate')) endDate
                         ,trim(extractvalue (value(d) ,'/servicesList/serviceName')) serviceName
                   from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                                                                ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d)
        loop
          --�������� ��������� ����� �� ������� ��������
          null;
          db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
               to_char(sysdate,'YYYY'),
               to_char(sysdate,'MM'),
               vrec.login,
               to_char(s.ctn), /*�����*/
               s.serviceId,       /* ��� ����� */
               s.serviceName,       /* ������������ ����� */
               null, /* ��������� ����� */
               s.startDate,          /* ���� �����������*/
               s.endDate,         /* ���� ���������� */
               null,        /*��������� �����������*/
               null        /*��������� � �����*/
               );
          count_good:=count_good+1; 
        end loop s;                                   
      else
        count_bad:=count_bad+1;
      end if;
       --������� ������ ������� ��� ����� �����
      DB_LOADER_PHONE_OPRT_CLOSE2(substr(to_char(const_year_month),1,4), substr(to_char(const_year_month),5,2),i.phone_number); 
      commit;
    end loop i;       
   --����������� � ��� �������� 
      if count_good>0 then --���� ���� ���� ����� - �������� ��� �� ������.
         insert into account_load_logs
           (account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
         values
           (s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update options count '||count_good, 4);
      else 
         insert into account_load_logs
           (account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
         values
           (s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'Update:'||count_good||' err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 4);
      end if;
    commit;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='�� ������ �\�';
  end if;--vrec.login
  Return Respond;
--         
end;--func 

  Function account_phone_payments  (pAccount_id in number) return varchar2 is
     --
    CURSOR C IS
      SELECT distinct ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.account_number,accounts.account_id
        FROM  ACCOUNTS
       WHERE ACCOUNTS.ACCOUNT_ID = pAccount_id;   
  vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- �����

    paysign number(1);--����������� �������.
    counter number:=0;
    counter_PAYM number:=0;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);       
  begin
      OPEN C;
    FETCH C
      INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getPaymentList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',vREC.account_number,'',sysdate-3, sysdate);        
        if pANSWER.Err_text='OK' then    
          --
          DELETE FROM API_GET_PAYMENT_LIST;
          --
          INSERT INTO API_GET_PAYMENT_LIST(ctn, paymentDate, paymentStatus, paymentType, 
                                           paymentOriginalAmt, paymentCurrentAmt, 
                                           bankPaymentID, paymentActivateDate)
            select extractvalue (value(d) ,'/PaymentList/ctn') ctn
                  ,extractvalue (value(d) ,'/PaymentList/paymentDate') paymentDate
                  ,extractvalue (value(d) ,'/PaymentList/paymentStatus') paymentStatus
                  ,extractvalue (value(d) ,'/PaymentList/paymentType') paymentType
                  ,extractvalue (value(d) ,'/PaymentList/paymentOriginalAmt') paymentOriginalAmt
                  ,extractvalue (value(d) ,'/PaymentList/paymentCurrentAmt') paymentCurrentAmt
                  ,extractvalue (value(d) ,'/PaymentList/bankPaymentID') bankPaymentID
                  ,extractvalue (value(d) ,'/PaymentList/paymentActivateDate') paymentActivateDate
              from table(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getPaymentListResponse/PaymentList'
                                                           ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d;       
            --���� �� ��������
          for payments in (select substr(PL.ctn, -10) ctn
                                  ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentDate) paymentDate
                                  ,PL.paymentStatus paymentStatus
                                  ,PL.paymentType paymentType
                                  ,PL.paymentOriginalAmt paymentOriginalAmt
                                  ,PL.paymentCurrentAmt paymentCurrentAmt
                                  ,nvl(PL.bankPaymentID,0) bankPaymentID
                                  ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentActivateDate) paymentActivateDate
                              from API_GET_PAYMENT_LIST PL
          ) LOOP
             --�������� ��������
             --������ ����������� �������
             /*
             Backout ������ �������
             Funds transfer from ������� ������� �� ������� �������
             Funds transfer to ������� ������� c ������� �������
             Refund ������� �������
             Payment ������ ��������
             Refund reversal ������ �������� �������
             */
            paysign:=case 
                       when payments.paymentStatus='Payment' then 1
                       when payments.paymentStatus='Backout' then -1
                       when payments.paymentStatus='Funds transfer from' then -1
                       when payments.paymentStatus='Funds transfer to' then 1
                       when payments.paymentStatus='Refund' then -1
                       when payments.paymentStatus='Refund reversal' then 1
                       else 0
                     end;      
            IF INSTR(payments.paymentStatus, 'Funds transfer') = 0 THEN                                         
              db_loader_pckg.add_payment(pyear => substr(to_char(const_year_month),1,4),
                                         pmonth => to_char(payments.paymentDate,'MM'),
                                         plogin => vREC.Login,
                                         pphone_number => NVL(payments.ctn, '0000000000'),
                                         ppayment_date => payments.paymentDate,
                                         ppayment_sum => to_number(replace(rtrim(payments.paymentOriginalAmt,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')*paysign,
                                         ppayment_number => payments.bankPaymentID,
                                         ppayment_valid_flag => case
                                                                WHEN paysign=-1 THEN 0
                                                                else 1
                                                                end ,
                                         ppayment_status_text => case 
                                                                 when payments.paymentStatus='Payment' then '������ ��������'
                                                                 when payments.paymentStatus='Backout' then '������ �������'
                                                                 when payments.paymentStatus='Funds transfer from' then '������� ������� �� ������� �������'
                                                                 when payments.paymentStatus='Funds transfer to' then '������� ������� c ������� �������'
                                                                 when payments.paymentStatus='Refund' then '������� �������'
                                                                 when payments.paymentStatus='Refund reversal' then '������ �������� �������'
                                                                 else '��� ������'
                                                                 end
                                        );                                
              counter:=counter+1;
            END IF;
            counter_PAYM:=counter_PAYM+1;
          end loop;   
          -- ���������� �������� �����    
          MERGE INTO DB_LOADER_PAYMENT_TRANSFERS PT
            USING (select substr(PL.ctn, -10) ctn
                          ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentDate) paymentDate
                          ,PL.paymentStatus paymentStatus
                          ,PL.paymentType paymentType
                          ,PL.paymentOriginalAmt paymentOriginalAmt
                          ,PL.paymentCurrentAmt paymentCurrentAmt
                          ,PL.bankPaymentID bankPaymentID
                          ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(PL.paymentActivateDate) paymentActivateDate
                      from API_GET_PAYMENT_LIST PL
                      WHERE INSTR(PL.paymentStatus, 'Funds transfer') > 0) API
              ON (PT.PHONE_NUMBER = API.ctn 
                    AND NVL(PT.BANK_PAYMENT_ID, 0) = NVL(API.bankPaymentID, 0)
                    AND PT.PAYMENT_STATUS = API.paymentStatus 
                    AND PT.ACCOUNT_ID = pACCOUNT_ID)
            WHEN MATCHED THEN 
              UPDATE SET PT.PAYMENT_DATE=API.paymentDate, PT.PAYMENT_TYPE=API.paymentType, PT.PAYMENT_ORIGINAL_AMT=API.paymentOriginalAmt, 
                         PT.PAYMENT_CURRENT_AMT=API.paymentCurrentAmt, PT.PAYMENT_ACTIVATE_DATE=API.paymentActivateDate               
            WHEN NOT MATCHED THEN   
              INSERT(PT.ACCOUNT_ID, PT.PHONE_NUMBER, PT.PAYMENT_DATE, PT.PAYMENT_STATUS, PT.PAYMENT_TYPE, 
                     PT.PAYMENT_ORIGINAL_AMT, PT.PAYMENT_CURRENT_AMT, PT.BANK_PAYMENT_ID, PT.PAYMENT_ACTIVATE_DATE)   
                VALUES(pACCOUNT_ID, API.ctn, API.paymentDate, API.paymentStatus, API.paymentType, 
                       API.paymentOriginalAmt, API.paymentCurrentAmt, API.bankPaymentID, API.paymentActivateDate);   
          --�������� �������� ����������
          INSERT INTO ACCOUNT_LOAD_LOGS(ACCOUNT_LOAD_LOG_ID, ACCOUNT_ID, LOAD_DATE_TIME,
                                 IS_SUCCESS, ERROR_TEXT, ACCOUNT_LOAD_TYPE_ID,BEELINE_RN)
            VALUES(NEW_ACCOUNT_LOAD_LOG_ID, pACCOUNT_ID, SYSDATE,
             1, 'Ok! Add '||counter||' rows. All '||counter_PAYM||' rows.', 1, pANSWER.BSAL_ID);commit;
          Respond:='Ok! Add '||counter;
          commit;
        else 
          Respond:= pANSWER.Err_text;
        end if;  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='�� ������ �\�';
    end if;
    Return (Respond);
  end;  
--���������� ������ ��� �� ����������
function Collect_account_BANS(Paccount_id in number) return varchar2
  is 
  CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
       WHERE ACCOUNTS.account_id = Paccount_id; 
   vREC     C%ROWTYPE;
   err varchar2(1000);--��� ����������� ��������� �� �������+
   count_rec integer:=0;
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
      Begin--�������� ������� ������ ��������
        --�������������
        err:='';
        --��������� ������ BAN-��
        pANSWER:=BEELINE_SOAP_API_PCKG.getBANInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),vREC.Login,vREC.Account_Id,'');
    /*� ���� ����������� ��������� ������ �� ���������� (������� �� ����� ������ �����,�.�. �������� ������)*/
     /*merge into beeline_loader_inf bi 
             using 
             (select  extractvalue (value(d) ,'BanInfoList/ban') BAN
        from table(XmlSequence
                      (pANSWER.ANSWER.extract(
                              'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                             ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"')
                      )
                  )d
             full outer join (select bli.ban from beeline_loader_inf bli where bli.account_id=Paccount_id) bli_out
             on bli_out.ban=extractvalue (value(d) ,'BanInfoList/ban')
             ) list 
      ON (bi.ban=list.ban and bi.account_id=Paccount_id)
      when matched then
           update set bi.obj_id=000 where list.ban is null
           delete where list.ban is null
      when not matched then
           insert (account_id,ban) values (Paccount_id,list.ban);
           commit;*/

           --�������� �� ���������� ������� � ������
         
        select count(*) into count_rec
          from (select  extractvalue (value(d) ,'BanInfoList/ban') BAN
                  from table(XmlSequence
                              (pANSWER.ANSWER.extract(
                                      'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                     ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"')))d
                 -- where not exists (select 1 from beeline_loader_inf bl where bl.ban=extractvalue (value(d) ,'BanInfoList/ban') and bl.account_id=Paccount_id)
               )xml_data;
             
        if count_rec>1 then --���� ����������� ������                       
          -- ���������� � ��������������� ������� ����� ��������
          Insert into beeline_loader_inf 
          select Paccount_id,null,null,xml_data.ban 
          from (select extractvalue(value(d) ,'BanInfoList/ban') BAN
                  from table(XmlSequence
                              (pANSWER.ANSWER.extract(
                                      'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                     ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"') ))d
                  where not exists (select 1 
                                      from beeline_loader_inf bl 
                                      where bl.ban=extractvalue (value(d) ,'BanInfoList/ban') 
                                        and bl.account_id=Paccount_id)
               )xml_data;
           -- �������� �� ��������������� ������� �������� ��������              
          delete from beeline_loader_inf bli 
            where bli.ban in (select to_char(bl.ban) 
                                from beeline_loader_inf bl 
                                where bl.account_id=Paccount_id
                              minus
                              select to_char(xml_data.ban) 
                              from (select extractvalue(value(d) ,'BanInfoList/ban') BAN
                                      from table(XmlSequence
                                                    (pANSWER.ANSWER.extract(
                                                            'S:Envelope/S:Body/ns0:getBANInfoListResponse/BanInfoList'
                                                           ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d ) xml_data );
           --���������
           commit;
        else raise VALUE_ERROR; 
        end if;--�������� ���������� ����������� �������.
      exception
        when VALUE_ERROR then 
          err:='������ �������� ���.�/� ������ 100.'; 
        when others then 
          err:='�� ���������� �������� ������ ��������.';
      return err;
      end;-- ����� �������� ��������   
    end if;

  --��������, ��� ����������
    insert into account_load_logs
           ( account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
      values(s_new_account_load_log_id.nextval,Paccount_id, sysdate,
              case err when null then 1 else 0 end , nvl(err,'OK! Get '||count_rec||' rows;'),14);
    commit;
    return nvl(err,'OK!');   
  --  
  end;         
--                 
 --���������� �������� �� ������������� �/� 
function Collect_account_phone_status(
  Paccount_id in number,
  nMOD_NUM in number default 0,--������ ������
  nMOD in number default 1--������
  ) return varchar2 is--phone_state_table 
  CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
        WHERE ACCOUNTS.account_id = Paccount_id;    
  type tBAN is table of varchar2(30) INDEX BY binary_integer;
  BANs tBAN;
  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- �����
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
  count_good integer:=0;
  count_bad integer:=0;
  i integer:=0;
  err varchar2(1000);--��� ����������� ��������� �� �������+
  dogovor_date date;
  vYEAR_MONTH INTEGER;
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
    BEGIN    
       --���� ������ ����� �� ����
      For old_ban in (select bl.ban 
                        from beeline_loader_inf bl, 
                             db_loader_account_phones ph 
                        where --�����
                              bl.phone_number=ph.phone_number(+)
                          and ph.year_month(+)=const_year_month--J O I N ��� ������ ������                         
                          --�����
                          and bl.account_id=Paccount_id 
                          and mod(bl.ban,nMOD)=nMOD_NUM--������� ������
                          --������� ����� , ����� �� ��� ����� �� ����������
                        group by bl.ban
                        order by max(ph.last_check_date_time) asc NULLS FIRST )
      loop
        i:=i+1;
        bans(i):=old_ban.ban;
      end loop;     
      for PBAN in bans.first .. bans.last
      LOOP 
        begin 
          pANSWER:= SOAP_API_ANSWER_TYPE(NULL, NULL,null);--������� ���������� ������
          pANSWER:=BEELINE_SOAP_API_PCKG.getCTNInfoList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',bans(PBAN),'');
        exception
          when others then 
            pANSWER.Err_text:=sqlerrm;  
        end;    
        if pANSWER.Err_text='OK' then 
          ---��������� �������             
          DELETE FROM API_GET_CTN_INFO_LIST;
          --
          INSERT INTO API_GET_CTN_INFO_LIST(ctn, statusDate, status, pricePlan, reasonStatus, lastActivity, activationDate, subscriberHLR)
            SELECT extractvalue (value(d) ,'CTNInfoList/ctn') ctn
                   ,extractvalue (value(d) ,'/CTNInfoList/statusDate') statusDate
                   ,extractvalue (value(d) ,'/CTNInfoList/status') status
                   ,extractvalue (value(d) ,'/CTNInfoList/pricePlan') pricePlan
                   ,extractvalue (value(d) ,'/CTNInfoList/reasonStatus') reasonStatus
                   ,extractvalue (value(d) ,'/CTNInfoList/lastActivity') lastActivity
                   ,extractvalue (value(d) ,'/CTNInfoList/activationDate') activationDate
                   ,extractvalue (value(d) ,'/CTNInfoList/subscriberHLR') subscriberHLR
              FROM TABLE(XmlSequence(pANSWER.ANSWER.extract('S:Envelope/S:Body/ns0:getCTNInfoListResponse/CTNInfoList'
                                                            ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;
          ---��������� �������  
          vYEAR_MONTH:=TO_NUMBER(to_char(sysdate,'YYYYMM'));
          MERGE INTO db_loader_account_phones ph
          -- ���������
            USING (select substr(d.ctn, -10) acc_ctn
                         ,substr(d.ctn, -10) ctn
                         ,d.status stat
                         ,d.reasonStatus reason
                         ,d.pricePlan plan
                         ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(d.statusDate) statusDate
                         ,bsc.IS_CONSERVATION
                         ,bsc.IS_SYSTEM_BLOCK
                     from API_GET_CTN_INFO_LIST d
                     left outer join BEELINE_STATUS_CODE bsc on bsc.STATUS_CODE = d.reasonStatus   
                  ) api                  
              ON (ph.phone_number = api.acc_ctn 
                    and ph.year_month=vYEAR_MONTH 
                    and ph.account_id=Paccount_id)        
          WHEN MATCHED THEN
          --����� �����
            UPDATE SET ph.phone_is_active=CASE  WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END,
                       ph.cell_plan_code=api.plan,
                       ph.last_check_date_time=sysdate,
                       ph.last_change_status_date=api.statusDate,                
                       ph.conservation = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                       ph.system_block = CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                       PH.STATUS_ID = CONVERT_PCKG.STATUS_CODE_TO_STATUS_ID(API.REASON) 
              WHERE ((api.stat in('ACTIVE','BLOCKED'))
                      or (api.stat is null and ph.last_check_date_time<sysdate-1))-- ���� ����� �� ���������� ����� ����� � ����� ������� ������ ��� ���� ����� ��� �������
            -- ��������� DELETE �������� ������ ��� ��� �������, ������� ������ ��� UPDATE
            DELETE where api.ctn is null          
          WHEN NOT MATCHED THEN
          -- ����� �� �����
            INSERT (ph.account_id, ph.year_month, ph.phone_number, ph.phone_is_active, ph.cell_plan_code, ph.last_check_date_time,
                    ph.organization_id, ph.conservation, ph.system_block, PH.LAST_CHANGE_STATUS_DATE, PH.STATUS_ID )
              VALUES (Paccount_id, vYEAR_MONTH, api.ctn,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 1 ELSE 0 END, 
                      api.plan, sysdate, 1, 
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_CONSERVATION END,
                      CASE WHEN API.STAT = 'ACTIVE' THEN 0 ELSE API.IS_SYSTEM_BLOCK END,
                      api.statusDate, convert_pckg.STATUS_CODE_TO_STATUS_ID(api.reason))
            WHERE api.stat in ('ACTIVE','BLOCKED');
          --������� �������   
          count_good:=count_good+sql%rowcount;  
            --���� � �������� ������� ���-�� ����������-���������
          if sql%rowcount>0 then 
            for hist in (select substr(d.ctn,-10) ctn
                              ,d.status stat
                              ,d.reasonStatus reason
                              ,d.pricePlan plan
                          from API_GET_CTN_INFO_LIST d
                          where d.status in ('ACTIVE','BLOCKED'))
            loop
             --��������� ������ � ������� ������������ ��������.
              update beeline_loader_inf bl 
                set bl.ban=bans(PBAN) 
                where bl.phone_number=hist.ctn;
              if sql%rowcount=0 then 
                insert into beeline_loader_inf bl (bl.account_id,bl.phone_number,bl.ban) 
                  values (Paccount_id,hist.ctn,bans(PBAN));
              end if;
             --��������� ������ � �������
              dogovor_date:=sysdate;
              for add_hist in (select count(*) as exist 
                                 from db_loader_account_phone_hists t 
                                 where t.phone_number=hist.ctn)
              loop
                --���� ��� ������ ������ � ������� �� �������������� ������ ������ ���� ��������
                if add_hist.exist=0 then
                  --������� ���� ��������
                  begin
                    select trunc(ct.contract_date) into dogovor_date 
                      from contracts ct 
                      where ct.phone_number_federal=hist.ctn 
                        and not exists (select 1 from contract_cancels cc where cc.contract_id=ct.contract_id);
                    --���� ������� � �������� ������ ������ ��� ���� ������ � db_loader_account_phones
                    if to_number(to_char(dogovor_date,'YYYYMM'))<const_year_month then 
                      insert into db_loader_account_phones(account_id, year_month, phone_number, 
                                                           phone_is_active, cell_plan_code, new_cell_plan_code, new_cell_plan_date, 
                                                           last_check_date_time, organization_id, conservation, system_block)
                        select qph.account_id, to_number(to_char(dogovor_date,'YYYYMM')), qph.phone_number, 
                               qph.phone_is_active, qph.cell_plan_code, qph.new_cell_plan_code, qph.new_cell_plan_date, 
                               qph.last_check_date_time, qph.organization_id, qph.conservation, qph.system_block
                          from db_loader_account_phones qph 
                          where qph.phone_number=hist.ctn 
                            and qph.year_month=const_year_month
                            and qph.account_id=Paccount_id;
                    end if;
                  exception
                    when others then 
                      dogovor_date:=trunc(sysdate);
                  end;
                end if;
              end loop add_hist;
              temp_add_account_phone_history(hist.ctn,hist.plan,
                  case hist.stat 
                    when 'ACTIVE' then 1
                    when 'BLOCKED' then 0
                  end, dogovor_date);
              CHECK_MNP_ACCOUNT_PHONE_STATUS(hist.ctn);--�������� ������� ���������� ������� MNP // 30.06.14
            end loop hist;                    
          end if;        
          --������� ������ ������ �� beeline_loader_inf
          delete from beeline_loader_inf t 
            where t.phone_number is null 
              and t.account_id=Paccount_id 
              and t.ban=bans(PBAN)
              AND EXISTS (SELECT 1
                            FROM BEELINE_LOADER_INF Z 
                            WHERE Z.PHONE_NUMBER IS NOT NULL 
                              AND Z.ACCOUNT_ID=PACCOUNT_ID 
                              AND Z.BAN=BANS(PBAN));  
          commit;--� ��� �������� � ��� �������       
        else
          insert into aaa(nnn1,sss1,sss2)values(pANSWER.BSAL_ID,pANSWER.Err_text,bans(PBAN));commit;
          count_bad:=count_bad+1;
        end if;                 
      END LOOP PBAN;
   --����������� � ��� �������� 
      if count_good>0 then --���� ���� ���� ����� - �������� ��� �� ������.
        insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 1, 'Ok! Update '||count_good||' rows,err_count='||count_bad||';'||err, 3);
      else 
        insert into account_load_logs(account_load_log_id, account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval, Paccount_id, sysdate, 0, 'err_count='||count_bad||',last err_txt:'||pANSWER.Err_text||';'||err, 3);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM||';'||err;
        return Respond;
    END;--api_responce
  Else
    Respond:='�� ������ �\�';
  end if;--vrec.login
  Return Respond;
--         
end;--func

function Collect_account_phone_opts(
  Paccount_id in number
  ) return varchar2  is--phone_state_table
  type Tbans is table of varchar2(20);  
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
      FROM ACCOUNTS
      WHERE ACCOUNTS.account_id = Paccount_id;    
  CURSOR TECH is 
    select distinct bl.ban 
      from beeline_loader_inf bl 
      where bl.account_id=Paccount_id; 
   Bans Tbans;
   vREC     C%ROWTYPE;
   Respond  varchar2(5000); -- �����
   pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
   count_good integer:=0;
   count_bad integer:=0;
   err varchar2(1000);
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1 THEN
    BEGIN      
      OPEN TECH;
      FETCH TECH bulk collect into Bans;
      CLOSE TECH;
      --���� �� ��������
      for I in Bans.first..bans.last
      LOOP
        Begin
          pANSWER:=BEELINE_SOAP_API_PCKG.getServiceList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),'',bans(i),'');            
          if pANSWER.Err_text='OK' then      
         --���� �� ������
          for s in (select substr(extractvalue (value(d) ,'servicesList/ctn'),-10)ctn
                           ,trim(extractvalue (value(d) ,'/servicesList/serviceId'))   serviceId
                           ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue(value(d) ,'/servicesList/startDate')) startDate
                           ,CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(extractvalue(value(d) ,'/servicesList/endDate')) endDate
                           ,trim(extractvalue (value(d) ,'/servicesList/serviceName')) serviceName
                      from table(XmlSequence(pANSWER.ANSWER.extract(
                             'S:Envelope/S:Body/ns0:getServicesListResponse/servicesList'
                             ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) d)
            loop
            --�������� ��������� ����� �� ������� ��������
              null;
              db_loader_pckg.ADD_ACCOUNT_PHONE_OPTION2(
                  to_char(sysdate,'YYYY'),
                  to_char(sysdate,'MM'),
                  vrec.login,
                  to_char(s.ctn), /*�����*/
                  s.serviceId,       /* ��� ����� */
                  s.serviceName,       /* ������������ ����� */
                  null, /* ��������� ����� */
                  s.startDate,          /* ���� �����������*/
                  s.endDate,         /* ���� ���������� */
                  null,        /*��������� �����������*/
                  null        /*��������� � �����*/
                  );
            end loop s;                   
            commit;
            count_good:=count_good+1;                    
          else
            insert into aaa(nnn1,sss1,sss2)values(pANSWER.BSAL_ID,pANSWER.Err_text,bans(i));commit;
            count_bad:=count_bad+1;
          end if;       
        EXCEPTION
          WHEN OTHERS THEN 
            err:=sqlerrm;
            insert into aaa(sss2)values(err||' '||bans(i)||' '||to_char(i));commit;
            count_bad:=count_bad+1;
        END;        
      END LOOP I; 
      
      for u in (select * from db_loader_account_phones p where p.year_month=const_year_month and p.account_id=Paccount_id)
      loop
        --������� ������ ������� ��� ����� �����
        DB_LOADER_PHONE_OPRT_CLOSE2(substr(to_char(const_year_month),1,4), substr(to_char(const_year_month),5,2),u.phone_number); 
      end loop u;
          
     --����������� � ��� �������� 
      if count_good>0 then --���� ���� ���� ����� - �������� ��� �� ������.
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update options on'||count_good||' ban''s,err_count='||count_bad, 4);
      else 
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 4);
      end if;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='�� ������ �\�';
  end if;--vrec.login
  Return Respond;
--         
end;--func 
  
Function get_ticket_status (
  pAccount_id in number,
  pRequestID in VARCHAR2
  ) return varchar2 is
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,accounts.account_id
        FROM  ACCOUNTS
       WHERE ACCOUNTS.ACCOUNT_ID=pAccount_id;    

  vREC     C%ROWTYPE;
  Respond  varchar2(5000); -- �����
  Resp_code varchar2(200);-- ����� ���
  pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);      
    
procedure update_ticket (pRespond in varchar2,pResp_code in varchar2) as 
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  update beeline_tickets k 
    set k.answer=decode(Respond,'COMPLETE',1
                             ,'REJECTED',0
                             ,'CANCELED',0
                             ,'EXPIRED_REQ',0
                             ,'NULL',0
                             ,'NEED_MORE_INFORMATION',0
                             ,null                                                          
                       ),k.comments=k.comments||' '||pResp_code||' '||Resp_code,k.date_update=sysdate 
  where k.ticket_id=pRequestID and pRespond is not null;         
  commit;
end; 
 
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getRequestList(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),pRequestID,vREC.LOGIN,pAccount_id);
        select extractValue(pANSWER.ANSWER, 'S:Envelope/S:Body/ns0:getRequestListResponse/requestList/requests/requestStatus',
                                            'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
              ,extractValue(pANSWER.ANSWER, 'S:Envelope/S:Body/ns0:getRequestListResponse/requestList/requests/requestComments',
                                            'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')      
          into Respond,Resp_code from dual; 
--insert into beeline_soap_api_log(soap_answer) values (pANSWER.ANSWER); commit;--�������� ������ ��� �������!        
        update_ticket(Respond,Resp_code);
        /*FULFILL_REQ ��������� ��������� ������
        OPEN ������
        IN_PROGRESS � �������� ����������
        COMPLETE ��������
        AUTO_COMPLETE �������� �������������
        PARTIALLY_COMPLETE �������� ��������
        WAITING_FOR_APPROVAL ������� �������������
        NEED_MORE_INFORMATION ��������� ������ ����������
        REJECTED ��������
        NULL ������ ������
        CANCELED �����������
        PENDING � ��������
        PENDING_OPEN � �������� ��������
        PENDING_CLOSE � �������� ��������
        EXPIRED_REQ ����� ������� �������
        PERIODIC_IN_PROGRESS ����������� ������������*/        
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return (Respond);
      END;
    Else
    Respond:='�� ������ �\�';
    end if;
    Return (Respond||';'||Resp_code);
  end;  
  --
/*  --��������� ��������� ������ � ������ ��� � ���� ������. (���� ������ ���� ������� ����)
procedure check_tickets is
 CURSOR TICKETS IS
      select * from BEELINE_TICKETS t where t.answer=0 and t.date_create>sysdate-1;--��� ������ ������ �����   
   recT TICKETS%ROWTYPE;
   

begin  
  --������� ������� ��� ������ ������ �����, �.�. ��������� �� - ����� ����.
  update BEELINE_TICKETS t set t.answer=1,t.comments=t.comments||' ������� �� ��������.' where t.answer=0 and t.date_update<sysdate-1;
  commit;
  --������ ���������� ���������� �� ��������� ��������
  -- 9-����� : ��������� ������ � �������� -> � ��� -> ���� ACTIVE - �� ��� ��
  -- 10-�������� : ��������� ������ � �������� -> � ��� -> ���� BLOCKED � �� ���� - �� ��� ��
  -- 12-����� ��� : ������� ����� ��� � ��� � ������� ����� ���, ���� != ��� ��
  for c in TICKETS loop
    fetch c into recT;
    
  end loop c;
  

end;*/

FUNCTION Create_account_bill(
  PaccountId IN VARCHAR2,
  Pyear_month IN INTEGER 
  ) RETURN VARCHAR2 IS
    --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
        FROM ACCOUNTS
        WHERE ACCOUNTS.ACCOUNT_ID = PaccountId;
    vREC     C%ROWTYPE;
    Bill_Date date;
    V_RESULT VARCHAR2(20000);
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        begin
          select pr.end_date into Bill_Date from db_loader_bills_period pr where pr.account_id=PaccountId and pr.year_month=Pyear_month;
        exception
          when no_data_found then Return('������ �� �������� ��� ������');
        end;
        Respond:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--�������� �����
        pANSWER:=BEELINE_SOAP_API_PCKG.createBillChargesRequest(Respond,vrec.account_number,vrec.account_id,Bill_Date);--������ � ���
        --������ ������
        /* 
        <?xml version="1.0" encoding="UTF-8"?>
        <S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">
            <S:Header>
                <work:WorkContext xmlns:work="http://oracle.com/weblogic/soap/workarea/"></work:WorkContext>
            </S:Header>
            <S:Body>
                <ns0:createBillChargesRequestResponse xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber">
                    <requestId>2185195147</requestId>
                </ns0:createBillChargesRequestResponse>
            </S:Body>
        </S:Envelope>*/                
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:createBillChargesRequestResponse/requestId'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;            
        if V_RESULT is null --���� ��� ����������� ������ ������
           then --���� ����� ������
          if pANSWER.Err_text!='OK' then 
            V_RESULT:=pANSWER.Err_text;
          else
            select nvl(pANSWER.Err_text, 
                       extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
              into V_RESULT from dual; 
          end if;     
          --��� ������ ������ ���������� ������������� ������
          if V_RESULT is null then  
            raise_application_error(-20000, '������������� ������ ��.');
          --���� ����� ������ ���������� ���   
          else 
            return('Error_Api:'||V_RESULT); 
          end if;
        --���� �� � ������� � ���� �����
        else
         --���������� ������ ������ �� ��������
          insert into beeline_tickets(ticket_id, account_id, ban, ticket_type, answer, comments, phone_number,user_created,date_create)
            values(V_RESULT,vrec.account_id, vrec.account_number, 5, null, Pyear_month,null,user,sysdate);
          commit;
          --���������� ����� ������ �� ��������
          return ('������� ����� '||V_RESULT);          
        end if;
      --� ������ ���������� ���������� ������  
      EXCEPTION
        WHEN OTHERS THEN
          Respond := SQLERRM;
          return Respond;
      END;
    ELSE
      RETURN PaccountId || ' �� ������ � ���� ������.';
    END IF;
  END;
 --�������� ���������� �� �����.
 Function Get_account_bill (
  pAccount_id in number,
  pRequestID in number
  ) return varchar2 is
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,accounts.account_id
        FROM  ACCOUNTS
        WHERE ACCOUNTS.ACCOUNT_ID=pAccount_id;    
    bill_exception exception;
    vREC     C%ROWTYPE;
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);   
  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getBillCharges(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd),pRequestID,pAccount_id);
          if instr(pANSWER.Err_text,'OK')=0 then raise bill_exception;end if; 
              
      EXCEPTION
        WHEN OTHERS THEN
          return (SQLERRM);
      END;
    Else
    Return('�� ������ �\�');
    end if;
    Return (pANSWER.BSAL_ID);
  end;
 
--������� ���������� �� ������
 Function phone_report_data  (pPHONE_NUMBER in number) return varchar2 is
     --
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,
             case ACCOUNTS.Is_Collector
               when 1 then nvl(bi.ban,0)
               else accounts.account_number
             end account_number, 
             accounts.account_id
        FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS, beeline_loader_inf bi
        WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
          and bi.phone_number(+)=DB_LOADER_ACCOUNT_PHONES.Phone_Number
          AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
          AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                       from  DB_LOADER_ACCOUNT_PHONES 
                                                       where PHONE_NUMBER = pPHONE_NUMBER);    
    vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);     
 
/*   procedure update_RD (ph in varchar2,ym in number) as 
      PRAGMA AUTONOMOUS_TRANSACTION;
    begin
                update db_loader_report_data q set q.detail_sum=to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')
               ,q.date_last_update=sysdate 
               where q.phone_number=ph and q.year_month=ym
               and to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')>=0;
               if sql%rowcount=0 then
                 insert into db_loader_report_data
                   (year_month, phone_number, detail_sum, date_last_update)
                 values
                   (ym, ph, to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99'), sysdate);
               end if;                  
               commit;
    end; */
  procedure upd_RD (ph in varchar2,val in number) as 
      PRAGMA AUTONOMOUS_TRANSACTION; 
  begin
    db_loader_pckg.SET_REPORT_DATA(ph, val, to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')); 
  end;       

  begin
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledBalances(BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd), pPHONE_NUMBER,vREC.account_number, '');
        select extractValue(pANSWER.ANSWER,'S:Envelope/S:Body/ns0:getUnbilledBalancesResponse/unbilledBalances/uc','xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
          into Respond from dual; 
/*        update_RD(pPHONE_NUMBER,to_char(sysdate,'YYYYMM'));*/
        upd_RD(pPHONE_NUMBER,to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99'));
      EXCEPTION
        WHEN OTHERS THEN
          Respond := pANSWER.Err_text||CHR(13)||SQLERRM;
          return (Respond);
      END;
    Else
      Respond:='�� ������ �\�';
    end if;
    Return (Respond);
  end; 
 
--�������� ������� ���������� �� �/� 
function account_report_data(
  Paccount_id in number,
  n_mod in number
  ) return varchar2  is--phone_state_table 
    CURSOR C IS
      SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd, accounts.account_number,accounts.account_id,accounts.is_collector
        FROM ACCOUNTS
        WHERE ACCOUNTS.account_id = Paccount_id;    
    vREC     C%ROWTYPE;
    Respond  varchar2(5000); -- �����
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null); 
    count_good integer:=0;
    count_bad integer:=0;
    token varchar2(100);
begin
  OPEN C;
  FETCH C INTO vREC;
  CLOSE C;
  IF vREC.LOGIN IS NOT NULL and vRec.Is_Collector=1  THEN
    BEGIN
      token:=BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);  
      for i in (select ph.phone_number
                 from db_loader_account_phones ph 
                 where ph.year_month=const_year_month and ph.account_id=Paccount_id
                 and mod(ph.phone_number,5)=n_mod/*������������� 5 �������*/
                 order by get_last_RD_update(ph.phone_number)) 
      loop
        pANSWER:=BEELINE_SOAP_API_PCKG.getUnbilledBalances(token,i.phone_number,Paccount_id);     
        if pANSWER.Err_text='OK' then 
          select extractValue(pANSWER.ANSWER,
                  'S:Envelope/S:Body/ns0:getUnbilledBalancesResponse/unbilledBalances/uc',
                  'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')     
            into Respond from dual; 
          db_loader_pckg.SET_REPORT_DATA(
              i.phone_number
             ,to_number(replace(rtrim(Respond,chr(10)||chr(13)||chr(9)),',','.'), '9999999999.99')
             ,to_char(sysdate,'DD.MM.YYYY-HH24:MI:SS')); 
          count_good:=count_good+1;                     
        else
          count_bad:=count_bad+1;
        end if;
      end loop i;       
      --����������� � ��� �������� 
      if count_good>0 then --���� ���� ���� ����� - �������� ��� �� ������.
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 1, 'Ok! Update RD count '||count_good, 6);
      else 
        insert into account_load_logs(account_load_log_id,account_id, load_date_time, is_success, error_text, account_load_type_id)
          values(s_new_account_load_log_id.nextval,Paccount_id, sysdate, 0, 'Update: err_count='||count_bad||',last err_txt:'||pANSWER.Err_text, 6);
      end if;
      commit;  
    EXCEPTION
      WHEN OTHERS THEN
        Respond := SQLERRM;
        return Respond;
    END;--api_responce
  Else
    Respond:='�� ������������� ����.'; -- �������, �.�.�� ������� ������ �� �� ������������� ����� ��������� �������
  end if;--vrec.login
  Return Respond;         
end;--func 

-- ���������� ��� ��������� �������� ����� ��� ������.
FUNCTION TURN_TARIFF_OPTION(
  pPHONE_NUMBER IN VARCHAR2,
  pOPTION_CODE IN VARCHAR2,
  pTURN_ON IN INTEGER, -- 0: ���������, 1: ��������
  pEFF_DATE IN DATE,   -- ���� ����������� ������ (NULL - ����� ������)
  pEXP_DATE IN DATE,   -- ���� ��������������� ���������� (NULL - �� ���������)
  pREQUEST_INITIATOR IN VARCHAR2 -- ��������� ������� (�� 10 ������)
  ) RETURN VARCHAR2 IS
    --
  CURSOR C IS
    SELECT ACCOUNTS.LOGIN, ACCOUNTS.New_Pswd,ACCOUNTS.Account_Id,ACCOUNTS.Account_Number
      FROM DB_LOADER_ACCOUNT_PHONES, ACCOUNTS
      WHERE DB_LOADER_ACCOUNT_PHONES.PHONE_NUMBER = pPHONE_NUMBER
        AND ACCOUNTS.ACCOUNT_ID = DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID
        AND DB_LOADER_ACCOUNT_PHONES.YEAR_MONTH = (select max(YEAR_MONTH) 
                                                     from DB_LOADER_ACCOUNT_PHONES 
                                                     where PHONE_NUMBER = pPHONE_NUMBER);
    --
    vREC     C%ROWTYPE;
    FIO      VARCHAR2(2000);
    V_RESULT VARCHAR2(20000);
    vTOKEN varchar2(5000); -- �����
    vINCLUSION_TYPE VARCHAR2(1);
    pANSWER SOAP_API_ANSWER_TYPE := SOAP_API_ANSWER_TYPE(NULL, NULL,null);
  BEGIN
    OPEN C;
    FETCH C INTO vREC;
    CLOSE C;
    IF vREC.LOGIN IS NOT NULL THEN
      BEGIN
        vINCLUSION_TYPE := CASE WHEN pTURN_ON=1 THEN 'A' ELSE 'D' END;
        vTOKEN := BEELINE_SOAP_API_PCKG.auth(vREC.LOGIN, vREC.New_Pswd);--�������� �����
        pANSWER:=BEELINE_SOAP_API_PCKG.addDelSOC(vTOKEN, pPHONE_NUMBER, pOPTION_CODE, vINCLUSION_TYPE, pEFF_DATE, pEXP_DATE, vREC.ACCOUNT_ID);--������ � ���
        --������ ������
        select extractValue(pANSWER.ANSWER,
                  'S:Envelope/S:Body/ns0:addDelSOCResponse/return'
                  ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"')
          into V_RESULT from dual;
        IF V_RESULT IS NULL THEN--���� ��� ����������� ������ ������ ���� ����� ������
          IF pANSWER.Err_text!='OK' THEN 
            V_RESULT:=pANSWER.Err_text;
          ELSE
            SELECT nvl(pANSWER.Err_text, extractValue(pANSWER.ANSWER,
                                          'S:Envelope/S:Body/ns0:Fault/detail/ns1:UssWsApiException/errorDescription'
                                          ,'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://schemas.xmlsoap.org/soap/envelope/ xmlns:ns1="urn:uss-wsapi:Types" xmlns:ns0="urn:uss-wsapi:Subscriber"'))
              into V_RESULT from dual; 
          END IF;     
          --��� ������ ������ ���������� ������������� ������
          IF V_RESULT IS NULL THEN  
            raise_application_error(-20000, '������������� ������ ������.');
          ELSE --���� ����� ������ ���������� ���
            RETURN('Error_Api:'||V_RESULT); 
          END IF;
        ELSE --���� �� � ������� � ���� �����
          --���������� � ��� 
          LOG_TARIFF_OPTIONS_REQ(pPHONE_NUMBER, pOPTION_CODE, vINCLUSION_TYPE, pEFF_DATE, pEXP_DATE, V_RESULT, pREQUEST_INITIATOR);
          --���������� ������ ������ �� ��������
          INSERT INTO BEELINE_TICKETS(TICKET_ID, ACCOUNT_ID, BAN, TICKET_TYPE, ANSWER, COMMENTS, PHONE_NUMBER,USER_CREATED,DATE_CREATE)
            VALUES(V_RESULT,vrec.account_id, vrec.account_number, 15, null, null,pPHONE_NUMBER,user,sysdate);
          COMMIT;
          --���������� ����� ������ �� �����������
          return ('������ � '||V_RESULT); 
        END IF;
      --� ������ ���������� ���������� ������  
      EXCEPTION
        WHEN OTHERS THEN
          RETURN SQLERRM;
      END;
    ELSE
      RETURN pPHONE_NUMBER || ' �� ������ � ���� ������.';
    END IF;
  END;
        
-- �������� ����������� �� ���
PROCEDURE LOAD_DETAIL_FROM_API(
  pPHONE_NUMBER IN VARCHAR2
  ) IS
    smonth date;
    pvLOADING_MONTH varchar2(4);
    pbsal_id VARCHAR2 (20);
    vSOAP_ANSWER XMLTYPE;
  PROCEDURE AUTO_UPDATE_SERVICES_API AS
  PRAGMA AUTONOMOUS_TRANSACTION; 
  begin    
    MERGE INTO SERVICES_API SA
      USING (SELECT DISTINCT UC.SERVICENAME AT_FT_DE, UC.CALLTYPE AT_FT_DESC
               FROM API_GET_UNBILLED_CALLS_LIST UC) API
        ON (SA.AT_FT_DE = API.AT_FT_DE AND SA.AT_FT_DESC = API.AT_FT_DESC)
      WHEN MATCHED THEN
        UPDATE SET SA.DATE_UPDATE = SYSDATE
      WHEN NOT MATCHED THEN 
        INSERT(SA.AT_FT_DE, SA.AT_FT_DESC, SA.DATE_INSERT, SA.DATE_UPDATE)
          VALUES(API.AT_FT_DE, API.AT_FT_DESC, SYSDATE, SYSDATE);
    --
    COMMIT;
  end;
  
  BEGIN
    pbsal_id := beeline_api_pckg.phone_detail_call(pPHONE_NUMBER);
    --
    DELETE FROM API_GET_UNBILLED_CALLS_LIST;   
    --
    SELECT L.SOAP_ANSWER INTO vSOAP_ANSWER 
      FROM BEELINE_SOAP_API_LOG L
      WHERE L.BSAL_ID = TO_NUMBER (pBSAL_ID);
    --
    INSERT INTO API_GET_UNBILLED_CALLS_LIST(callDate, callNumber, callToNumber, serviceName, callType, dataVolume, callAmt, callDuration)
      SELECT  extractvalue (value(d) ,'/UnbilledCallsList/callDate') callDate
             ,extractvalue (value(d) ,'/UnbilledCallsList/callNumber') callNumber
             ,extractvalue (value(d) ,'/UnbilledCallsList/callToNumber') callToNumber
             ,extractvalue (value(d) ,'/UnbilledCallsList/serviceName') serviceName
             ,extractvalue (value(d) ,'/UnbilledCallsList/callType') callType
             ,extractvalue (value(d) ,'/UnbilledCallsList/dataVolume') dataVolume
             ,extractvalue (value(d) ,'/UnbilledCallsList/callAmt') callAmt
             ,extractvalue (value(d) ,'/UnbilledCallsList/callDuration') callDuration
        FROM TABLE(XmlSequence(vSOAP_ANSWER.extract('S:Envelope/S:Body/ns0:getUnbilledCallsListResponse/UnbilledCallsList',
                                                    'xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:uss-wsapi:Subscriber"'))) D;  
    --
    SELECT TRUNC(SYSDATE, 'MM')
      INTO smonth 
      FROM DUAL;
    --
    execute immediate 'merge into CALL_' || to_char(smonth, 'mm_yyyy') || ' ct
                        using (select distinct tabs.SUBSCR_NO, tabs.START_TIME, tabs.AT_FT_CODE, tabs.DBF_ID, tabs.call_cost, 
                                      tabs.costnovat, tabs.dur, tabs.IMEI, tabs.ServiceType, tabs.ServiceDirection, 
                                      tabs.IsRoaming, tabs.RoamingZone, tabs.CALL_DATE, tabs.CALL_TIME, tabs.DURATION, 
                                      tabs.DIALED_DIG, tabs.AT_FT_DE, tabs.AT_FT_DESC, tabs.CALLING_NO, tabs.AT_CHG_AMT, 
                                      tabs.DATA_VOL, tabs.CELL_ID, tabs.MN_UNLIM, tabs.cost_chng  
                                 from table (HOT_BILLING_GET_CALL_TAB(CURSOR(SELECT *
                                                                               FROM (SELECT ''' || pPHONE_NUMBER || ''' SUBSCR_NO,
                                                                                            TO_CHAR(CONVERT_PCKG.TIMESTAMP_TZ_TO_DATE(UC.callDate), ''yyyymmddhh24miss'') CH_SEIZ_DT,
                                                                                            UC.serviceName AT_FT_CODE,
                                                                                            DECODE(REPLACE(UC.callAmt, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.callAmt, ''.'', '','')) AT_CHG_AMT,
                                                                                            UC.callNumber CALLING_NO,
                                                                                            REGEXP_REPLACE(UC.callDuration, '':'', '''') DURATION,
                                                                                            DECODE(REPLACE(UC.dataVolume, ''.'', '',''), ''0,0'', ''0'', REPLACE(UC.dataVolume, ''.'', '','')) DATA_VOL,
                                                                                            '''' IMEI,
                                                                                            '''' CELL_ID,
                                                                                            DECODE(UC.callToNumber, ''' || pPHONE_NUMBER || ''', '''', UC.callToNumber) DIALED_DIG,
                                                                                            UC.callType AT_FT_DESC,
                                                                                            TO_NUMBER(MS_CONSTANTS.GET_CONSTANT_VALUE (''API_DBF_ID'')) DBF_ID
                                                                                       FROM API_GET_UNBILLED_CALLS_LIST UC) TT
                                                                               where TT.ch_seiz_dt is not null 
                                                                                 and trunc(to_date(TT.ch_seiz_dt, ''yyyymmddhh24miss''), ''mm'')=
                                                                                      to_date(''' || to_char(smonth, 'dd.mm.yyyy') || ''',''dd.mm.yyyy'')
                                             ))) tabs
                              ) t
                          on (ct.subscr_no = t.subscr_no and ct.start_time = t.start_time 
                              and to_number(ct.AT_CHG_AMT,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')= 
                                    to_number(t.AT_CHG_AMT, ''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''') 
                              and to_number(ct.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')=
                                    to_number(t.DATA_VOL,''99999999999D99'','' NLS_NUMERIC_CHARACTERS = '''',.'''''')
                              and ct.dur=t.dur)
                        when not matched then
                          insert (ct.SUBSCR_NO, ct.START_TIME, ct.AT_FT_CODE, ct.DBF_ID, ct.call_cost, 
                                  ct.costnovat, ct.dur, ct.IMEI, ct.ServiceType, ct.ServiceDirection, 
                                  ct.IsRoaming, ct.RoamingZone, ct.CALL_DATE, ct.CALL_TIME, ct.DURATION, 
                                  ct.DIALED_DIG, ct.AT_FT_DE, ct.AT_FT_DESC, ct.CALLING_NO, ct.AT_CHG_AMT, 
                                  ct.DATA_VOL, ct.CELL_ID, ct.MN_UNLIM, ct.INSERT_DATE, ct.cost_chng) 
                            values (t.SUBSCR_NO, t.START_TIME, t.AT_FT_CODE, t.DBF_ID, t.call_cost, 
                                    t.costnovat, t.dur, t.IMEI, t.ServiceType, t.ServiceDirection, 
                                    t.IsRoaming, t.RoamingZone, t.CALL_DATE, t.CALL_TIME, t.DURATION, 
                                    t.DIALED_DIG, t.AT_FT_DE, t.AT_FT_DESC, t.CALLING_NO, t.AT_CHG_AMT, 
                                    t.DATA_VOL,t.CELL_ID,t.MN_UNLIM,sysdate,t.cost_chng)';
    DELETE_DOUBLE_DETAIL(pPHONE_NUMBER);
    commit;
    HOT_BILLING_PCKG.i_usm_PHONE(pPHONE_NUMBER, smonth);
    --
    AUTO_UPDATE_SERVICES_API;
    --
  END; 
   
BEGIN
  --Initialization
  --�����
  const_year_month:=to_number(to_char(sysdate,'YYYYMM')); 
end;
/