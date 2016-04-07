unit RepLoaderBill;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Data.DB, DBAccess, Ora, MemDS, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, System.DateUtils,
  sListBox, sCheckListBox, sComboBox, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, ExportGridToExcelPDF,
  sBevel, sSpeedButton, sLabel, sPanel, Vcl.ComCtrls, sStatusBar, sSplitter,
  idhashsha, IdHashMessageDigest, Vcl.Imaging.jpeg,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdMessage,IdCoderHeader,IdCoderMime, IdCoder, IdCoder3to4, IdAttachmentFile,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  uDm, Func_Const, TimedMsgBox, ChildFrm, Vcl.DBCtrls, sEdit, sGauge, sScrollBox,
  frxClass, frxDBSet, frxExportPDF, frxVariables, frxRes;

type
  TRepLoaderBillFrm = class(TRepFrm)
    qSQL_TEMP: TOraQuery;
    aShowBeginInfo: TAction;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    qReportUSER_LAST_UPDATED_FIO: TStringField;
    qReportDATE_LAST_UPDATED_: TDateTimeField;
    qReportPeriod: TStringField;
    qReportACCOUNT_ID: TFloatField;
    qReportTARIFF_ID: TFloatField;
    qReportABONENT_ID: TFloatField;
    qReportFILIAL_ID: TFloatField;
    qReportVIRTUAL_ACCOUNTS_ID: TFloatField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportLOGIN: TStringField;
    qReportACCOUNT_NUMBER_LOGIN: TStringField;
    qReportFILIAL_NAME: TStringField;
    qReportSURNAME: TStringField;
    qReportVIRTUAL_ACCOUNTS_NAME: TStringField;
    qReportTARIFF_NAME: TStringField;
    qReportCALL_LOCAL: TFloatField;
    qReportCALL_INTERCITY: TFloatField;
    qReportMESSAGE: TFloatField;
    qReportINTERNET: TFloatField;
    qReportOTHERS_SERVISES: TFloatField;
    qReportSUBSCRIPTION_SUM: TFloatField;
    qReportINTERNATIONAL_ROAMING: TFloatField;
    qReportNATIONAL_INTRANET_ROAMING: TFloatField;
    qReportADJUSTMENT: TFloatField;
    qReportPAYMENTS: TFloatField;
    qReportALL_CLIENT_SCHET: TFloatField;
    qReportLOG_BILL_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportMOBILE_OPERATOR_NAME_ID: TFloatField;
    qReportMOBILE_OPERATOR_NAME: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    sbShowBeginInfo: TsSpeedButton;
    qReportPHONE_ID: TStringField;
    aSendEmeilAll: TAction;
    sbSendEmeilAll: TsSpeedButton;
    aSendToFTPfor1C: TAction;
    spCREATE_DBF_BILL_FOR_1C: TOraStoredProc;
    Virt_Acc_With_Email: TOraQuery;
    Virt_Acc_With_EmailVIRTUAL_ACCOUNTS_ID: TFloatField;
    LoadersBill: TOraQuery;
    LoadersBillVIRTUAL_ACCOUNTS_NAME: TStringField;
    LoadersBillPHONE_ID: TStringField;
    LoadersBillCALL_LOCAL: TFloatField;
    LoadersBillCALL_INTERCITY: TFloatField;
    LoadersBillMESSAGE: TFloatField;
    LoadersBillINTERNET: TFloatField;
    LoadersBillOTHERS_SERVISES: TFloatField;
    LoadersBillSUBSCRIPTION_SUM: TFloatField;
    LoadersBillINTERNATIONAL_ROAMING: TFloatField;
    LoadersBillNATIONAL_INTRANET_ROAMING: TFloatField;
    LoadersBillALL_CLIENT_SCHET: TFloatField;
    qMailParam: TOraQuery;
    qMailParamSMPT_SERVER: TStringField;
    qMailParamSMPT_PORT: TFloatField;
    qMailParamUSER_LOGIN: TStringField;
    qMailParamUSER_PASSWORD: TStringField;
    qMailParamSMPT_FROM: TStringField;
    qSEND_MAIL_LOG: TOraQuery;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    dsLoadersBill: TDataSource;
    frxPDFExport1: TfrxPDFExport;
    sbShowReport: TsSpeedButton;
    aShowReport: TAction;
    aShowSendEmeil: TAction;
    sbShowSendEmeil: TsSpeedButton;
    Virt_Acc_With_EmailEMAIL: TStringField;
    qReportMARGIN: TFloatField;
    qReportBILL_SUM: TFloatField;

    procedure FormCreate(Sender: TObject);
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure aShowBeginInfoExecute(Sender: TObject);
    procedure SMTP_send(SMTP_FROMTXT, SMTP_SRV, SMTP_LOG, SMTP_PASS, SMTP_ATT_FILE,
                        SMTP_ADDR, SMTP_TITLE, SMTP_BODY, SMTP_FROM : string; SMTP_PORT, id : Integer);

    procedure aRefreshExecute(Sender: TObject);
    procedure aSendToFTPfor1CExecute(Sender: TObject);
    procedure aSendEmeilAllExecute(Sender: TObject);
    procedure aShowReportExecute(Sender: TObject);
    procedure Virt_Acc_With_EmailBeforeOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure aShowSendEmeilExecute(Sender: TObject);
  private
    ErrorString : TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepLoaderBillFrm: TRepLoaderBillFrm;

implementation

{$R *.dfm}

uses RepBillLoadLog, ShowLogMail;

procedure TRepLoaderBillFrm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  aShowBeginInfo.Enabled := qReport.Active and (not qReport.IsEmpty);
  aSendEmeilAll.Enabled := qReport.Active and (not qReport.IsEmpty);
  aShowReport.Enabled := qReport.Active and (not qReport.IsEmpty);
end;

procedure TRepLoaderBillFrm.aSendToFTPfor1CExecute(Sender: TObject);
var
  v_res : string;
begin
  spCREATE_DBF_BILL_FOR_1C.ParamByName('P_YEAR_MONTH').AsInteger := YEAR_MONTH;
  spCREATE_DBF_BILL_FOR_1C.ExecProc;
  v_res := spCREATE_DBF_BILL_FOR_1C.ParamByName('RESULT').AsString;

  TimedMessageBox(v_res, 'Результат отправки ', mtInformation, [mbOK], mbOK, 15, 3);
end;

procedure TRepLoaderBillFrm.aSendEmeilAllExecute(Sender: TObject);
  var
   cnt, cntError, ind, id, Err : Integer;
   cpt, txtMess, f_name, per, emeil : string;
   OraStoredProc : TOraStoredProc;
   vr : TfrxVariable;
   spf : TChildForm;
begin
  frxPDFExport1.ShowDialog := false;
  qMonthYearforRepFrm.Locate('YEAR_MONTH', year_month, []);
  per := qMonthYearforRepFrm.FieldByName('YEAR_MONTH_NAME').AsString;
  qMailParam.Open;
  cnt := 0;
  cntError := 0;
  OraStoredProc := TOraStoredProc.Create(self);
  OraStoredProc.Session := Dm.OraSession;
  OraStoredProc.StoredProcName := 'FULL_SEND_MAIL_LOG';
  OraStoredProc.PrepareSQL;  // receive parameters
  try
    Virt_Acc_With_Email.Close;
    Virt_Acc_With_Email.Open;
    sGauge1.MaxValue := Virt_Acc_With_Email.RecordCount * 22 + 24;
    sGauge1.Progress := 0;
    sp.Visible := True;
    sGauge1.Visible := True;
    Application.ProcessMessages;
    sGauge1.Repaint;
    sGauge1.Refresh;
    while not Virt_Acc_With_Email.Eof do
    begin
      // пробегаем в цикле по списку виртуальных счетов, у которых есть емейл.
      id := Virt_Acc_With_Email.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
      emeil := Virt_Acc_With_Email.FieldByName('EMAIL').AsString;

      sGauge1.Progress := sGauge1.Progress + 6;
      Application.ProcessMessages;
      sGauge1.Repaint;
      sGauge1.Refresh;
      // по айдишнику находим счета и формируем на каждый айдишник отчет в pdf формате
      LoadersBill.Close;
      LoadersBill.ParamByName('VIRTUAL_ACCOUNTS_ID').AsInteger := id;
      LoadersBill.ParamByName('YEAR_MONTH').AsInteger := year_month;
      LoadersBill.Open;
      /////////////////////////
      // пустые отчеты не формируем
      if not LoadersBill.IsEmpty then
      begin
        Inc(cnt);
        //f_name := LoadersBillCreate(LoadersBill, Id, per); //Вариант с Excel
        f_name := GetSystemPath(TMP) + IntToStr(Id) + '.pdf';
        ind  := frxReport1.Variables.IndexOf('period');
        if ind <> -1 then
        begin
          vr := frxReport1.Variables.Items[ind];
          vr.Value := '''' + AnsiLowerCase(per) + '''';
        end;
       frxPDFExport1.FileName := f_name;
       frxPDFExport1.DefaultPath := GetSystemPath(TMP);
       if frxReport1.PrepareReport then
         frxReport1.Export(frxPDFExport1);
        sGauge1.Progress := sGauge1.Progress + 6;
        Application.ProcessMessages;
        sGauge1.Repaint;
        sGauge1.Refresh;
        //отправляем почту
        ErrorString.Clear;
        SMTP_send(qMailParam.FieldByName('SMPT_FROM').AsString,
                  qMailParam.FieldByName('SMPT_SERVER').AsString,
                  qMailParam.FieldByName('USER_LOGIN').AsString,
                  qMailParam.FieldByName('USER_PASSWORD').AsString,
                  f_name,
                  emeil,
                  'Отчет по расходам за услуги',
                  'При этом, ' + qMailParam.FieldByName('SMPT_FROM').AsString + ' направляет Вам отчет по расходам за услуги за ' + AnsiLowerCase(per),
                  qMailParam.FieldByName('USER_LOGIN').AsString,
                  qMailParam.FieldByName('SMPT_PORT').AsInteger,
                  id);
        sGauge1.Progress := sGauge1.Progress + 3;
        Application.ProcessMessages;
        sGauge1.Repaint;
        sGauge1.Refresh;

        if (ErrorString.Text = '') then
          Err := 1
        else
        begin
          Err := 0;
          Inc(cntError);
        end;
        // пишем в журнал в Блоб
        OraStoredProc.ParamByName('pVIRTUAL_ACCOUNTS_ID').Asinteger := id;
        OraStoredProc.ParamByName('pEMAIL').AsString := emeil;
        OraStoredProc.ParamByName('pERROR').AsString := ErrorString.text;
        OraStoredProc.ParamByName('pDELIVERED').Asinteger := Err;
        OraStoredProc.ParamByName('pPERIOD').Asinteger := year_month;
        OraStoredProc.ParamByName('pBODY_MAIL').ParamType := ptInput;  // to transfer Lob data to Oracle
        OraStoredProc.ParamByName('pBODY_MAIL').AsOraBlob.LoadFromFile(f_name);
        OraStoredProc.Execute;

        sGauge1.Progress := sGauge1.Progress + 4;
        Application.ProcessMessages;
        sGauge1.Repaint;
        sGauge1.Refresh;
        if FileExists(f_name) then
          DeleteFile(f_name);
        sGauge1.Progress := sGauge1.Progress + 3;
        Application.ProcessMessages;
        sGauge1.Repaint;
        sGauge1.Refresh;
      end;
      Virt_Acc_With_Email.Next;
    end;
  finally
    OraStoredProc.Free;
    qMailParam.close;
    sGauge1.Progress := sGauge1.Progress + 24;
    Application.ProcessMessages;
    sGauge1.Repaint;
    sGauge1.Refresh;
    sp.Visible := false;
    sGauge1.Visible := false;
    if (cnt > 0)  then
    begin
      txtMess := IntToStr(cnt - cntError)+ Sklonenie_pisem((cnt - cntError)) + ' успешно отправлено! ';
      if (cntError > 0) then
        txtMess := txtMess + IntToStr(cntError) + Sklonenie_pisem(cntError) + ' не отправлено. ';
      txtMess := txtMess + 'Показать журнал отправки писем?';
      if (TimedMessageBox(txtMess , 'Доставка почты!', mtInformation, [mbYes, mbNo], mbNo, 35, 3) = mrYes) then
      begin
        cpt := 'Журнал отправки почтовых сообщений за ' + AnsiLowerCase(cbPeriod.Text);
        spf := TShowLogMailFrm.Create(nil, spf, cpt, true);
        TShowLogMailFrm(spf).Year_month :=  YEAR_MONTH;
        try
          spf.ShowModal;
        finally
          spf.Free;
        end;
      end;
    end else begin
      txtMess := ' У выбранных виртуальных счетов не указан эл. адрес или нет данных. Ничего не отправлено. ';
      TimedMessageBox(txtMess , 'Доставка почты!', mtWarning, [mbOK], mbOK, 35, 3);
    end;
  end;
end;

procedure TRepLoaderBillFrm.SMTP_send(SMTP_FROMTXT, SMTP_SRV, SMTP_LOG, SMTP_PASS, SMTP_ATT_FILE,
                        SMTP_ADDR, SMTP_TITLE, SMTP_BODY, SMTP_FROM : string; SMTP_PORT, id : Integer);
var
  idsmtp : TIdSMTP;
  idMessage : TIdMessage;
  IdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
begin
  idsmtp:=TIdSMTP.Create();
  idMessage:=TIdMessage.Create();
  try
    try
      IdSMTP.AuthType := satDefault;
      IdSMTP.Host     := SMTP_SRV;
      IdSMTP.Username := SMTP_LOG;
      IdSMTP.Password := SMTP_PASS;
      IdSMTP.Port     := SMTP_PORT;
      if SMTP_PORT <> 25 then
      begin
        IdSMTP.CreateIOHandler(nil);
        IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
        IdSSLIOHandlerSocketOpenSSL.SSLOptions. Method := sslvTLSv1;
        IdSSLIOHandlerSocketOpenSSL. SSLOptions.Mode:= sslmUnassigned;
        IdSMTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
        IdSMTP.UseTLS := utUseImplicitTLS;
      end;
      try
        idMessage.Date := Now;
        idMessage.From.Text := SMTP_FROMTXT;
        idMessage.Recipients.EMailAddresses := SMTP_ADDR;
        idMessage.Subject := SMTP_TITLE;
        idMessage.From.Name := SMTP_FROMTXT;
        idMessage.From.Address := SMTP_LOG;
        idMessage.ContentTransferEncoding:='8bit';
        idMessage.ContentType := 'multipart/mixed';
        idMessage.CharSet := 'Windows-1251';
        idMessage.Body.Text := SMTP_BODY;
        try
          TIdAttachmentFile.Create( idMessage.MessageParts, SMTP_ATT_FILE);
          try
            IdSMTP.Connect;
            try
              IdSMTP.Send(idMessage);
            finally
              IdSMTP.Disconnect;
            end;
          except
            on e : exception do
            begin
              ErrorString.Add('Ошибка. Сообщение не отправлено!'#13#10 + e.Message);
            end;
          end;
        except
          on e : exception do
          begin
            ErrorString.Add('Ошибка создания TIdAttachmentFile!'#13#10+e.Message + '! для счёта - ' + inttostr(id));
          end;
        end;
      except
        ErrorString.Add('Ошибка создания TIdMessage! для счёта - ' + inttostr(id));
      end;
    except
      ErrorString.Add('Ошибка создания TIdSMTP! для счёта - ' + inttostr(id));
    end;
  finally
    //очищаем из памяти
    if SMTP_PORT <> 25 then
      FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
    IdMessage.Clear;
    idsmtp.Free;
    idMessage.Free;
  end;
end;

procedure TRepLoaderBillFrm.Virt_Acc_With_EmailBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if FVSchid <> '' then
    Virt_Acc_With_Email.SQL.Text := 'SELECT VIRTUAL_ACCOUNTS_ID, EMAIL FROM VIRTUAL_ACCOUNTS ' +
                                    ' where EMAIL is not null and VIRTUAL_ACCOUNTS_IS_ACTIVE <> 2 ' +
                                    ' and VIRTUAL_ACCOUNTS_ID in (' + FVSchid + ')' +
                                    ' order by VIRTUAL_ACCOUNTS_ID'
  else
    Virt_Acc_With_Email.SQL.Text := 'SELECT VIRTUAL_ACCOUNTS_ID, EMAIL FROM VIRTUAL_ACCOUNTS ' +
                                    ' where EMAIL is not null and VIRTUAL_ACCOUNTS_IS_ACTIVE <> 2 ' +
                                    ' order by VIRTUAL_ACCOUNTS_ID';
end;

procedure TRepLoaderBillFrm.aShowBeginInfoExecute(Sender: TObject);
var
  spf : TChildForm;
  cpt : string;
begin
  inherited;
  cpt := 'Исходные данные по лицевому счету - ' + qReport.FieldByName('ACCOUNT_NUMBER').AsString + ' за ' + qReport.FieldByName('Period').AsString;
  spf := TRepBillLoadLogFrm.Create(nil, spf, cpt, true);
  TRepBillLoadLogFrm(spf).LOG_BILL_ID := qReport.FieldByName('LOG_BILL_ID').AsInteger;
  TRepBillLoadLogFrm(spf).Account_name := qReport.FieldByName('ACCOUNT_NUMBER').AsString;
  TRepBillLoadLogFrm(spf).Period := qReport.FieldByName('Period').AsString;
  TRepBillLoadLogFrm(spf).qReport.Open;
  try
    if spf.ShowModal = mrOk then
    begin
      TRepBillLoadLogFrm(spf).qReport.Close;
    end;
  finally
    spf.Free;
  end;

end;

procedure TRepLoaderBillFrm.aShowReportExecute(Sender: TObject);
var
   per : string;
   ind, id : Integer;
   vr : TfrxVariable;
begin
  inherited;
  frxPDFExport1.ShowDialog := True;
  qMonthYearforRepFrm.Locate('YEAR_MONTH', year_month, []);
  per := qMonthYearforRepFrm.FieldByName('YEAR_MONTH_NAME').AsString;
  id := qReport.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
  LoadersBill.Close;
  LoadersBill.ParamByName('VIRTUAL_ACCOUNTS_ID').AsInteger := id;
  LoadersBill.ParamByName('YEAR_MONTH').AsInteger := year_month;
  LoadersBill.Open;
  if not LoadersBill.IsEmpty then
  begin
    ind  := frxReport1.Variables.IndexOf('period');
    if ind <> -1 then
    begin
      vr := frxReport1.Variables.Items[ind];
      vr.Value := '''' + AnsiLowerCase(per) + '''';
    end;
    if frxReport1.PrepareReport then
      frxReport1.ShowPreparedReport;
  end else begin
    TimedMessageBox('За указанный период по выбранному виртуальному счету данных нет!', 'Ошибка при просмотре отчета!', mtWarning, [mbOK], mbOK, 35, 3);
  end;
end;

procedure TRepLoaderBillFrm.aShowSendEmeilExecute(Sender: TObject);
var
  spf : TChildForm;
  cpt : string;
begin
  inherited;
  cpt := 'Журнал отправки почтовых сообщений за ' + AnsiLowerCase(cbPeriod.Text);
  spf := TShowLogMailFrm.Create(nil, spf, cpt, true);
  TShowLogMailFrm(spf).Year_month :=  YEAR_MONTH;
  try
    if spf.ShowModal = mrOk then
    begin
    end;
  finally
    spf.Free;
  end;
end;

procedure TRepLoaderBillFrm.FormCreate(Sender: TObject);
var
  rStream: TResourceStream;
begin
  inherited;
  ErrorString := TStringList.Create;
  // назначаем имя файлу Excel при экспорте
  Name_File_Excel := Caption;
  // назначаем заголовок внутри файла Excel при экспорте
  Zagolovok_Excel := 'Журнал выставленных оператором счетов';
  // делаем видимы данные мобильного оператора
  cb_Mob_Oper := True;
  CLB_VirtAccs := True;
  CLB_FilialT := True;
  CLBAccounts := true;

  // выделяем сразу всех операторов, при этом заполняются счета по каждому выделенному оператору
// aCheckedAll1.Execute;
 // aCheckedAll2.Execute;
 // aCheckedAll3.Execute;
  // делаем видимым месяц
  cb_Period   := True;
  // делаем видимым кнопку информации по клиенту
 //b_PhoneField := True;
  //PhoneField := qReport.FieldByName('PHONE_ID');

  //загрузим локализацию для FastReporta
  try
    rStream := TResourceStream.Create(hInstance, 'Russian_frc', RT_RCDATA);
    rStream.Position := 0;
    frxResources.LoadFromStream(rStream);
  finally
    FreeAndNil(rStream);
  end;

end;

procedure TRepLoaderBillFrm.FormDestroy(Sender: TObject);
begin
  inherited;
  ErrorString.Free;
end;

procedure TRepLoaderBillFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  qReport.SQL.Clear;
  qReport.SQL := qSQL_TEMP.SQL;
  qReport.SQL.Add(' and dlb.YEAR_MONTH = :YEAR_MONTH');

  if (account_check_count = 1) then
    qReport.SQL.Add(' and dlb.ACCOUNT_ID = :ACCOUNT_ID')
  else if not((account_check_count = account_count) or (account_check_count = CLB_Accounts.Count)) then
  begin
    if (account_check_count > 1000) then
      qReport.SQL.Add(' and exists (select 1 from T_ACCOUNTS t where t.ACCOUNT_ID = dlb.ACCOUNT_ID)')
    else if FAccid <> '' then
      qReport.SQL.Add(' and dlb.ACCOUNT_ID in (' + FAccid + ')');
  end;

  if (FMOpid <> '') AND (Mob_Check_count <> CLB_Mob_Oper.Count) then
    qReport.SQL.Add(' and dlb.MOBILE_OPERATOR_NAME_ID in (' + FMOpid + ')');

  if (FVSchid <> '') AND (VSch_count <> CLB_VirtAcc.Count) then
    qReport.SQL.Add(' and dlb.VIRTUAL_ACCOUNTS_ID in (' + FVSchid + ')');

  if (Filialid <> '') AND (Filial_count <> CLB_Filial.Count) then
    qReport.SQL.Add(' and dlb.filial_id in (' + Filialid + ')');

  qReport.SQL.Add(' order by dlb.VIRTUAL_ACCOUNTS_name nulls first, dlb.phone_id');

  if (account_check_count = 1) then
    qReport.ParamByName('ACCOUNT_ID').AsString :=  FAccid;

  qReport.ParamByName('YEAR_MONTH').AsInteger :=  YEAR_MONTH;
end;

end.
