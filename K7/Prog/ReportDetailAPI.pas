unit ReportDetailAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid,ExportGridToExcelPDF,IdSMTP, IdSMTPBase, IdMessageClient, IdExplicitTLSClientServerBase,
  IdMessage,IdCoderHeader,IdCoderMime, IdCoder, IdCoder3to4, IdAttachmentFile,IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,  WSlider, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, Vcl.ComCtrls ;

  type

  mySMTP = class(TThread)
     SMTP_FROMTXT,SMTP_SRV,SMTP_LOG,SMTP_PASS,SMTP_ATT_FILE,SMTP_ADDR,SMTP_TITLE,SMTP_BODY,SMTP_FROM:string;
     SMTP_PORT:word;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  TReportForm1 = class(TReportForm)
  qReportCALLDATE: TStringField;
  qReportCALLNUMBER: TStringField;
  qReportCALLTONUMBER: TStringField;
  qReportSERVICENAME: TStringField;
  qReportCALLTYPE: TStringField;
  qReportDATAVOLUME: TStringField;
  qReportCALLAMT: TFloatField;
  qReportCALLDURATION: TStringField;
  btnSendToMail: TBitBtn;
  aSendToMail: TAction;
  EmailAdress: TEdit;
  lbl: TLabel;
    pDetailBill: TPanel;
    gDetailBill: TCRDBGrid;
    qDetailBill: TOraQuery;
    dsDetailBill: TDataSource;
    qDetailBillUSAGE_CONNECT_DATE: TStringField;
    qDetailBillUSAGE_CONNECT_TIME: TStringField;
    qDetailBillUSAGE_OTHER_NUMBER: TStringField;
    qDetailBillUSAGE_DIALED_DIGITS: TStringField;
    qDetailBillUSAGE_DATA_VOLUME: TStringField;
    qDetailBillUSAGE_DURATION: TStringField;
    qDetailBillUSAGE_FEATURE_DESCRIPTION: TStringField;
    qDetailBillUSAGE_AT_CHARGE_AMT: TStringField;
    qDetailBillUSAGE_CELL_ID: TStringField;
    qDetailBillUSAGE_AT_NUM_MINS_TO_RATE: TStringField;
    qDetailBillUSAGE_CALL_ACTION_CODE: TStringField;
  procedure aLoadInExcelExecute(Sender: TObject);
  procedure aSendToMailExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    //phone: string;
  end;

var
  ReportForm1: TReportForm1;
  number : string;
  procedure DoReportBillsAPI(pPhoneNumber1:string);
  procedure DoReportCollectorBillDetails(pPhoneNumber:string; pYearMonth:integer);

implementation
{$R *.dfm}
 uses ShowUserStat,  ContractsRegistration_Utils, dmShowUserStat, Func_Const;

 procedure DoReportBillsAPI(pPhoneNumber1:string);
 var
 ReportFrm : TReportForm1;
 dmShowUserSt : TdmShowUserSt;
 begin
   number := pPhoneNumber1;
   ReportFrm := TReportForm1.Create(Nil);
   ReportFrm.Caption := 'Детализация по API';
   ReportFrm.pDetailBill.Hide;
   ReportFrm.qReport.Close;
   ReportFrm.qReport.SQL.Clear;
   ReportFrm.qReport.Params.Clear;
   ReportFrm. qReport.params.CreateParam(ftString, 'q_num', ptInput);
   ReportFrm.qReport.params.ParamByName('q_num').Value :=number;
   ReportFrm.qReport.sql.Add('select ' +#13#10+
            ' callDate, ' +#13#10+
            '  callNumber, ' +#13#10+
            '  callToNumber, ' +#13#10+
            '  serviceName, ' +#13#10+
            '  callType, ' +#13#10+
            '  dataVolume, ' +#13#10+
            '  COST_STR_TO_NUMBER(callAmt) callAmt, ' +#13#10+
            '  callDuration '+#13#10+
            'from TABLE(GET_UNBILLED_CALLS_LIST_PIPE(:q_num))'
           );
   ReportFrm.qReport.Execute;
   ReportFrm.ShowModal;
 end;

procedure DoReportCollectorBillDetails(pPhoneNumber:string; pYearMonth:integer);
  var ReportFrm : TReportForm1;
      dmShowUserSt : TdmShowUserSt;
begin
  number := pPhoneNumber;
  ReportFrm := TReportForm1.Create(Nil);
  ReportFrm.Caption := 'Детализация из счета';
  ReportFrm.pGrid.Hide;
  ReportFrm.qDetailBill.Close;
  ReportFrm.qDetailBill.SQL.Clear;
  ReportFrm.qDetailBill.Params.Clear;
  ReportFrm.qDetailBill.params.CreateParam(ftString, 'PHONE_NUMBER', ptInput);
  ReportFrm.qDetailBill.params.ParamByName('PHONE_NUMBER').Value :=pPhoneNumber;
  ReportFrm.qDetailBill.params.CreateParam(ftString, 'YEAR_MONTH', ptInput);
  ReportFrm.qDetailBill.params.ParamByName('YEAR_MONTH').Value :=pYearMonth;
  ReportFrm.qDetailBill.sql.Add(
    'SELECT X.USAGE_CONNECT_DATE, X.USAGE_CONNECT_TIME, X.USAGE_OTHER_NUMBER,' +
    '       X.USAGE_DIALED_DIGITS, X.USAGE_DATA_VOLUME, X.USAGE_DURATION,' +
    '       X.USAGE_FEATURE_DESCRIPTION, X.USAGE_AT_CHARGE_AMT, X.USAGE_CELL_ID,' +
    '       X.USAGE_AT_NUM_MINS_TO_RATE,' +
    '       CASE'+
    '         WHEN X.USAGE_CALL_ACTION_CODE = ''1'' THEN ''Исходящий''' +
    '         WHEN X.USAGE_CALL_ACTION_CODE = ''2'' THEN ''Входящий''' +
    '         ELSE ''Не определено''' +
    '       END USAGE_CALL_ACTION_CODE' +
    '  FROM TABLE(COLLECTOR_PCKG.GET_BILLING_CALLS_PIPE(:PHONE_NUMBER, :YEAR_MONTH)) X');
   ReportFrm.qDetailBill.Execute;
   ReportFrm.ShowModal;
 end;

procedure TReportForm1.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  if qReport.Active then
  begin
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ExportDBGridToExcel2('Необилинная детализация по номеру  ' + number ,'',
      gReport, nil, False, True)
    finally
      Screen.Cursor := cr;
    end;
  end
  else
    ShowMessage('Нет данных для выгрузки!!!');
end;

procedure TReportForm1.aSendToMailExecute(Sender: TObject);
var
  cr : TCursor;
  ACaption,ANote:string;
  ANameFile : string;
  Qlog_writer: TOraQuery;
  vPaymentSum :integer;
  vFillialId:integer;
  vRemark:string;
  tempStr:string;
  myRpt: mySMTP;
  str : string;
  dmShowUserStNew : TdmShowUserSt;
  FullFileName : string;
begin
  //подготовка к выгрузке Excel
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  dmShowUserStNew := TdmShowUserSt.Create(nil);
  dmShowUserStNew.spGetSIGNATURE_MAIL_ABOUT_DETAIL.ParamByName('PPHONENUMBER').Value := number;
  dmShowUserStNew.spGetSIGNATURE_MAIL_ABOUT_DETAIL.ExecProc;
  ACaption := 'Детализация по номеру ' + number;
  ANameFile:=number+'_Detail_';
  FullFileName := GetSystemPath(Personal) + ANameFile;
  try
    if FileExists(ANameFile+'.xltx') then
    DeleteFile(ANameFile+'.xltx');
  except
    ShowMessage('Ошибка при удалении файла '+ANameFile+'.xltx');
  end;
  try
    if FileExists(FullFileName+'.xls') then
      DeleteFile(FullFileName +'.xls');
  except
    ShowMessage(FullFileName +'.xls');
  end;
  //Выгрузка в Excel
  try
     ANameFile:= ANameFile;
     ExportDBGrid(ACaption,ANote,ANameFile, gReport, False,True);
  finally
    Screen.Cursor := cr;
  end;

  if FileExists(ANameFile+'.xltx') then
    RenameFile(ANameFile+'.xltx', ANameFile+'.xls');

  if FileExists(ANameFile+'.xlt') then
    RenameFile(ANameFile+'.xlt', ANameFile+'.xls');

  try
    dmShowUserStNew.GetSendMailParam.ParamByName('VPHONE_NUMBER').AsString := number;
    dmShowUserStNew.GetSendMailParam.ExecProc;
    myRpt := mySMTP.Create(true);
    myRpt.SMTP_SRV:= dmShowUserStNew.GetSendMailParam.ParamByName('VSMTP_SERVER').AsString;//GetParamValue('SMTP_HOST');
    myRpt.SMTP_LOG:= dmShowUserStNew.GetSendMailParam.ParamByName('VUSER_LOGIN').AsString;//GetParamValue('SMTP_USERNAME');
    myRpt.SMTP_PASS:= dmShowUserStNew.GetSendMailParam.ParamByName('VUSER_PASSWORD').AsString;//GetParamValue('SMTP_PASSWORD');
    myRpt.SMTP_PORT:= dmShowUserStNew.GetSendMailParam.ParamByName('VSMTP_PORT').AsWord;
    myRpt.SMTP_FROM:= dmShowUserStNew.GetSendMailParam.ParamByName('VSMTP_FROM').AsString;
    myRpt.SMTP_ADDR:=EmailAdress.Text;
    myRpt.SMTP_TITLE := 'Детализация по номеру '+number;
    myRpt.SMTP_FROMTXT := GetParamValue('SMTP_FROMTEXT');
    myRpt.SMTP_BODY :=ANote;
    myRpt.SMTP_ATT_FILE := FullFileName;
    myRpt.Resume;
  finally
    FreeAndNil(dmShowUserStNew);
  end;
  Qlog_writer:=TOraQuery.Create(self);
  with Qlog_writer do
  begin
    try
      sql.Clear;
      sql.Add ('insert into log_send_mail ');
      sql.Add('(year_month, phone_number, date_send, mail_subject,note)');
      sql.Add ('values(to_char(sysdate,''YYYYMM''),'+number+', sysdate, '+'''Детализация по номеру '+ number +''','''+EmailAdress.Text+'''||'' User:''||(user))');
      ExecSQL;
    except
      on e : exception do
        MessageDlg('Ошибка вставки записи в таблицу логирования отправки сообщений(log_send_mail)', mtError, [mbOK], 0);
    end;
    Destroy;
  end;
end;

procedure mySMTP.Execute;
var
  c:integer;
  idsmtp1:TIdSMTP;
  idMessage1:TIdMessage;
begin
  if SMTP_PORT<>25 then
  begin
    try
    except
      ShowMessage('Ошибка создания SSL!');
    end;
  end;

  try
     idsmtp1:=TIdSMTP.Create();
  except
     ShowMessage('Ошибка создания TIdSMTP!');
  end;
  idsmtp1.Host := SMTP_SRV;
  idsmtp1.Username :=SMTP_LOG;
  idsmtp1.Password:=SMTP_PASS;
  idsmtp1.Port:=SMTP_PORT;
  if SMTP_PORT<>25 then
  begin
    //IOHandler := IdSSLIOHandlerSocketOpenSSL;
    idsmtp1.UseTLS := utUseExplicitTLS;
    //  end;
  end;

  try
    idMessage1:=TIdMessage.Create();
  except
    ShowMessage('Ошибка создания TIdMessage!');
  end;
  with idMessage1 do begin
    Date := Now;
    From.Text := SMTP_FROM;//SMTP_FROMTXT;
    Recipients.EMailAddresses := SMTP_ADDR;
    Subject := SMTP_TITLE;
    From.Name := SMTP_FROM;//'Агентство связи';
    From.Address := SMTP_LOG;
    ContentTransferEncoding:='8bit';
    ContentType := 'multipart/mixed;';
    CharSet := 'Windows-1251';
    Body.Text := SMTP_BODY;
    // Body :=SMTP_BODY;
  end;

  try
    TIdAttachmentFile.Create( idMessage1.MessageParts, SMTP_ATT_FILE+'.xls');
  except
    on e : exception do
      ShowMessage('Ошибка создания TIdAttachmentFile!'#13#10+e.Message);
  end;

  try
    try
      idsmtp1.Connect();
      try
        IdSMTP1.Send(idMessage1);
        ShowMessage(SMTP_TITLE+': отправлена!');
        try
          if FileExists(SMTP_ATT_FILE+'.xltx') then
            DeleteFile(SMTP_ATT_FILE+'.xltx');
        except
          ShowMessage('Ошибка удаления '+SMTP_ATT_FILE+'.xltx!');
        end;
        try
          if FileExists(SMTP_ATT_FILE+'.xls') then
            DeleteFile(SMTP_ATT_FILE+'.xls');
        except
          ShowMessage('Ошибка удаления '+SMTP_ATT_FILE+'.xls!');
        end;
      finally
        IdSMTP1.Disconnect;
      end;
    except
      on e : exception do
        Application.MessageBox(PChar('Ошибка. Сообщение не отправлено!'#13#10+e.Message),
       'Предупреждение', MB_OK+MB_ICONWARNING);
    end;
  finally
    //очищаем из памяти
    IdMessage1.Clear;
    idsmtp1.Destroy;
    idMessage1.Destroy;
    //if SMTP_PORT<>25 then
    //IdSSLIOHandlerSocketOpenSSL.Free;
    //FreeAndNil(idMessage1);
  end;
end;


end.

