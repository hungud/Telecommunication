unit MonitorOutgoingCalls;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Main, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.Buttons, IntecExportGrid;

type
  TMonitorOutgoingCallsFrm = class(TForm)
    pMAIN: TPanel;
    pInfoPanel: TPanel;
    pRulePanel: TPanel;
    pPhoneList: TPanel;
    spl1: TSplitter;
    lbl1: TLabel;
    lbl2: TLabel;
    grpRule: TGroupBox;
    g1: TCRDBGrid;
    grpPhoneList: TGroupBox;
    dsRules: TDataSource;
    dsPhoneList: TDataSource;
    qRules: TOraQuery;
    qPhoneList: TOraQuery;
    qTariffs: TOraQuery;
    spGetNEW_RULE_FOR_CALL_MONITOR_ID: TOraStoredProc;
    spRunMonitor: TOraStoredProc;
    qReportRulesRULE_FOR_CALLS_MONITOR_ID: TFloatField;
    qReportRulesTARIFF_ID: TFloatField;
    qReportRulesLIMIT_INET_TRAFFIC: TFloatField;
    intgrfldRulesTURN_ON: TIntegerField;
    qRulesTARIFF_NAME: TStringField;
    g2: TCRDBGrid;
    lblDateLastRun: TLabel;
    qDateLastRunMonitor: TOraQuery;
    qReportRulesLIMIT_OUT_SMS: TFloatField;
    qMonitorStateInfo: TOraQuery;
    lblStateMonitorInfo: TLabel;
    qYesNo: TOraQuery;
    qRulesTURN_ON_NAME: TStringField;
    p1: TPanel;
    tlb1: TToolBar;
    btnInsert: TToolButton;
    btnEdit: TToolButton;
    btnDelete: TToolButton;
    btnPost: TToolButton;
    btn4: TToolButton;
    btnCancel: TToolButton;
    btn7: TToolButton;
    btnRefresh: TToolButton;
    btRefreshMonitor: TBitBtn;
    chkGroupPhone: TCheckBox;
    btLoadInExcel: TBitBtn;
    qGetCurrentPeriod: TOraQuery;
    qReportRulesLIMIT_OUT_CALL_NO_PAY_ONLY_BEE: TFloatField;
    qReportRulesLIMIT_OUT_CALL_NO_PAY_OTHER: TFloatField;
    qReportRulesLIMIT_OUT_CALL_PAY_ONLY_BEE: TFloatField;
    qReportRulesLIMIT_OUT_CALL_PAY_OTHER: TFloatField;
    qReportRulesLIMIT_OUT_CALL_NO_PAY_ALL: TFloatField;
    qReportRulesLIMIT_OUT_CALL_PAY_ALL: TFloatField;
    procedure qRulesBeforePost(DataSet: TDataSet);
    procedure qRulesBeforeClose(DataSet: TDataSet);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
{    procedure g1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
}
    procedure btRefreshMonitorClick(Sender: TObject);
    procedure dsRulesDataChange(Sender: TObject; Field: TField);
    procedure chkGroupPhoneClick(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure RefreshPhoneList;  // Обновляем список номеров, подходящих под условия
    procedure SetDateLastRunMonitor;
  public
    { Public declarations }
  end;

var
  MonitorOutgoingCallsFrm: TMonitorOutgoingCallsFrm;
  procedure DoMonitorOutgoingCalls;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure DoMonitorOutgoingCalls;
var
  vFRM : TMonitorOutgoingCallsFrm;
  IsAdmin : Boolean;
  vUserName : string;
begin
  try
    // проверим привелегии пользователя, доступ только админам
    MainForm.CheckAdminPrivs(IsAdmin);
    vUserName := ';' + UpperCase(MainForm.OraSession.Username) + ';';

    if (not IsAdmin) and not(AnsiPos(vUserName, UpperCase(GetParamValue('MONITOR_OUT_GOING_CALLS'))) > 0) then
    begin
      ShowMessage('Это функция доступна только администратору системы!')
    end
    else
    begin
      vFRM := TMonitorOutgoingCallsFrm.Create(nil);
      with vFRM do
      begin
        try
          qTariffs.Close;
          qTariffs.ParamByName('OPERATOR_ID').Value := 3; // Только билайн
          qTariffs.Open;

          qRules.Close;
          qRules.Open;

          // устанавливаем дату последнего обсчета
          SetDateLastRunMonitor;

          ShowModal;
        except
          on e : exception  do
          begin
            MessageDlg('Произошла ошибка открытии формы монитора.'#13#10 + e.Message, mtError, [mbOK], 0);
          end;
        end;
      end;
    end;
  finally
    vfrm.Free;
  end;
end;


procedure TMonitorOutgoingCallsFrm.btnInsertClick(Sender: TObject);
begin
  if not (qRules.State in [dsInsert]) then
   qRules.Insert;
end;

procedure TMonitorOutgoingCallsFrm.btnEditClick(Sender: TObject);
begin
  if not (qRules.State in [dsEdit]) then
    qRules.Edit;
end;

procedure TMonitorOutgoingCallsFrm.btnDeleteClick(Sender: TObject);
begin
  if mrOk = MessageDlg('Удалить правило для тарифа' + qRules.FieldByName('TARIFF_NAME').AsString +'?', mtConfirmation, [mbOK, mbCancel], 0) then
      qRules.Delete;
end;

procedure TMonitorOutgoingCallsFrm.btnPostClick(Sender: TObject);
begin
  if qRules.State in [dsEdit, dsInsert] then
    qRules.Post;
  qRules.Refresh;
end;

procedure TMonitorOutgoingCallsFrm.btLoadInExcelClick(Sender: TObject);
var
  cr : TCursor;
  vTITLE : string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    qGetCurrentPeriod.Close;
    qGetCurrentPeriod.Open;

    if chkGroupPhone.Checked then
    begin
      vTITLE := 'Для тарифа: "' + qRules.FieldByName('TARIFF_NAME').AsString + '": ' +#13#10;
      vTITLE := vTITLE + '   лимит исходящих бесплатных минут на билайн: ' + qRules.FieldByName('LIMIT_OUT_CALL_NO_PAY_ONLY_BEE').AsString +#13#10;
      vTITLE := vTITLE + '   лимит исходящих бесплатных минут на других операторов: ' + qRules.FieldByName('LIMIT_OUT_CALL_NO_PAY_OTHER').AsString +#13#10;
      vTITLE := vTITLE + '   лимит исходящих платных минут на билайн: ' + qRules.FieldByName('LIMIT_OUT_CALL_PAY_ONLY_BEE').AsString +#13#10;
      vTITLE := vTITLE + '   лимит исходящих платных минут на других операторов: ' + qRules.FieldByName('LIMIT_OUT_CALL_PAY_OTHER').AsString +#13#10;
      vTITLE := vTITLE + '   лимит исходящих СМС: ' + qRules.FieldByName('LIMIT_OUT_SMS').AsString +#13#10;
      vTITLE := vTITLE + '   лимит интернет трафика: ' + qRules.FieldByName('LIMIT_INET_TRAFFIC').AsString +#13#10;
      vTITLE := vTITLE + 'за период ' + qGetCurrentPeriod.FieldByName('MONTH_YEAR_STRING').AsString ;
    end
    else
    begin
      vTITLE := 'Для всех тарифных планов за период ' + qGetCurrentPeriod.FieldByName('MONTH_YEAR_STRING').AsString ;
    end;

    qGetCurrentPeriod.Close;

    ExportDBGridToExcel2('Монитор исходящего голосового трафика' + #13#10 + vTITLE, '', g2, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TMonitorOutgoingCallsFrm.btnCancelClick(Sender: TObject);
begin
  if qRules.Active then
    qRules.Close;
end;

procedure TMonitorOutgoingCallsFrm.btnRefreshClick(Sender: TObject);
begin
  qRules.Refresh;
end;

procedure TMonitorOutgoingCallsFrm.RefreshPhoneList;
begin
  qPhoneList.Refresh;
end;

procedure TMonitorOutgoingCallsFrm.SetDateLastRunMonitor;
begin
  try
    // ИНТЕРЕСУЕТ ИМЕННО ДАТА ПОСЛЕДНЕЙ ВСТАВКИ ЗА ТЕКУЩИЙ ПЕРИОД
    qDateLastRunMonitor.Close;
    qDateLastRunMonitor.ParamByName('pYEAR_MONTH').Value := StrToInt(FormatDateTime('YYYYMM', Now));
    qDateLastRunMonitor.Open;
    if (qDateLastRunMonitor.FieldByName('DATE_LAST_UPDATED').AsString = '') then
      lblDateLastRun.Caption := 'В текущем периоде рассчет еще не проводился'
    else
      lblDateLastRun.Caption := qDateLastRunMonitor.FieldByName('DATE_LAST_UPDATED').AsString;
    qDateLastRunMonitor.Close;

    //  Обновлям иинформацию о сотояние джоба
    qMonitorStateInfo.Close;
    qMonitorStateInfo.Open;
    lblStateMonitorInfo.Caption := qMonitorStateInfo.FieldByName('State_info').AsString;
    qMonitorStateInfo.Close;
  except
    on e : exception do
      MessageDlg('При обновлении состояния монитора возникли ошибки.'#13#10 + e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TMonitorOutgoingCallsFrm.btRefreshMonitorClick(Sender: TObject);
begin
  try
    // Сначала запускаем процедуру по пересбору статистики
    // Затем обновляем данные в гриде со списком номеров, подошедшим под условия

    //стартуем ДЖОБ, который дергаетпроцедура CALC_CALL_SUMMARY_STAT (TO_NUMBER(TO_CHAR(TRUNC(SYSDATE,'MM'), 'YYYYMM')), 1)
    //  spRunMonitor.ParamByName('pYEAR_MONTH').Value := StrToInt(FormatDateTime('YYYYMM', Now)); // указываем текущий месяц
    //  spRunMonitor.ParamByName('CALC_CUR_CALL').Value := 1; // пересчитываем статистику за текущий период

    //  Обновлям иинформацию о сотояние джоба
    qMonitorStateInfo.Close;
    qMonitorStateInfo.Open;
    lblStateMonitorInfo.Caption := qMonitorStateInfo.FieldByName('State_info').AsString;

    // Если уже запущен джоб выдаем сообщение, если нет то запускаем при утверждении пользователем задания
    if qMonitorStateInfo.FieldByName('State').AsString = 'SCHEDULED' then
    begin
      if mrOk = MessageDlg('Запустить пересчет статистики для монитора?', mtConfirmation, [mbOK, mbCancel], 0)  then
        spRunMonitor.ExecProc;
    end
    else
    begin
      if qMonitorStateInfo.FieldByName('State').AsString = 'RUNNING' then
        MessageDlg('В настоящее время уже выполянется обновление данныз для монитора!'#13#10, mtInformation , [mbOK], 0);
    end;
    qMonitorStateInfo.Close;

    // устанавливаем дату последнего обсчета в текущем месяце
    SetDateLastRunMonitor;
  except
    on e : exception do
      MessageDlg('При обновлении состояния монитора возникли ошибки.'#13#10 + e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TMonitorOutgoingCallsFrm.chkGroupPhoneClick(Sender: TObject);
begin

  if chkGroupPhone.Checked then
    qPhoneList.ParamByName('pSHOW_ALL').Value := 0
  else
    qPhoneList.ParamByName('pSHOW_ALL').Value := 1;

  qRules.Refresh;
end;

procedure TMonitorOutgoingCallsFrm.dsRulesDataChange(Sender: TObject;
  Field: TField);
begin
  if chkGroupPhone.Checked then
    qPhoneList.ParamByName('pSHOW_ALL').Value := 0
  else
    qPhoneList.ParamByName('pSHOW_ALL').Value := 1;
  qPhoneList.ParamByName('pMonitor_id').AsInteger := qRules.FieldByName('RULE_FOR_CALLS_MONITOR_ID').AsInteger;
  qPhoneList.Close;
  qPhoneList.Open;
end;
procedure TMonitorOutgoingCallsFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MainForm.Timer_CALLs_MONITORTimer(sender);
end;

//------------------------------------------
  {помещение в поле галочки}

procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);
var
  DrawFlags: Integer;
begin
  Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, ' ');
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_ADJUSTRECT);
  DrawFlags := DFCS_BUTTONCHECK or DFCS_ADJUSTRECT;// DFCS_BUTTONCHECK
  if Checked then
    DrawFlags := DrawFlags or DFCS_CHECKED;
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DrawFlags);
end;

{
procedure TMonitorOutgoingCallsFrm.g1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'TURN_ON' then
    if Column.Field.AsInteger = 1  then
      DrawGridCheckBox(g1.Canvas, Rect, true)
    else
      DrawGridCheckBox(g1.Canvas, Rect,false);
end;
}

procedure TMonitorOutgoingCallsFrm.qRulesBeforeClose(DataSet: TDataSet);
begin
  if DataSet.State in [dsEdit, dsInsert] then
    DataSet.Post;
end;

procedure TMonitorOutgoingCallsFrm.qRulesBeforePost(DataSet: TDataSet);
begin
  if qRules.Active and (qRules.State in [dsInsert]) then
  begin
    spGetNEW_RULE_FOR_CALL_MONITOR_ID.ExecSQL;
    qRules.FieldByName('RULE_FOR_CALLS_MONITOR_ID').Value := spGetNEW_RULE_FOR_CALL_MONITOR_ID.ParamByName('RESULT').Value;
  end;
end;

end.
