unit ReportBalanceOnEndMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, sListBox, sCheckListBox, Vcl.ComCtrls, Vcl.Samples.Gauges;

type
  TReportBalanceOnEndMonthForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportYEAR_MONTH: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportDATE_BALANCE: TDateTimeField;
    qReportBALANCE: TFloatField;
    qReportSTATUS: TStringField;
    qReportBEGIN_DATE: TDateTimeField;
    qReportSUBSCRIBER_PAYMENT_NEW: TFloatField;
    qReportACTIV: TFloatField;
    qReportDILER_CALLS: TFloatField;
    qReportALL_CALLS: TFloatField;
    qReportBILL_SUM_NEW: TFloatField;
    qReportDILER_SUM: TFloatField;
    qReportTARIFF_NAME: TStringField;
    qReportLOGIN: TStringField;
    CLB_Accounts: TsCheckListBox;
    Lb_daterep: TLabel;
    CBRefresh: TCheckBox;
    Timer1: TTimer;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    qReportPHONE_IS_ACTIVE: TIntegerField;
    qReportSESSION_ID: TFloatField;
    qReportDATE_REPORT: TDateTimeField;
    qReportTYPE_ABON: TStringField;
    qReportEXIT_PLUS: TStringField;
    qReportDILER_SUM_OLD: TFloatField;
    LAST_CHANGE_STATUS_DATE: TDateTimeField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure grDataGetCellParams(Sender: TObject; Field: TField; AFont: TFont;
      var Background: TColor; State: TGridDrawState; StateEx: TGridDrawStateEx);
    procedure FormCreate(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    FAccountAll:boolean;
    FAccid : string;
    YEAR_MONTH : integer;
    session_id : integer;
    procedure SHOW_ProgressBar;
    procedure SHOW_LastDateRep;
    procedure SHOW_Report;

  public
    { Public declarations }
  end;

var
  ReportBalanceOnEndMonthForm: TReportBalanceOnEndMonthForm;

procedure DoReportBalanceOnEndMonth;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat, Main;

procedure DoReportBalanceOnEndMonth;
var ReportFrm : TReportBalanceOnEndMonthForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportBalanceOnEndMonthForm.Create(Nil);
  try
    // Период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
{    if ReportFrm.cbPeriod.Items.Count > 1 then
      ReportFrm.cbPeriod.ItemIndex := 1
    else
      if ReportFrm.cbPeriod.Items.Count > 0 then}
      ReportFrm.cbPeriod.ItemIndex := 0;
    ReportFrm.YEAR_MONTH:=integer(ReportFrm.cbPeriod.Items.Objects[ReportFrm.cbPeriod.ItemIndex]);

    //Лиц.счета
    ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    ReportFrm.qAccounts.Open;
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.CLB_Accounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
      );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    // Отчет
//    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBalanceOnEndMonthForm.SHOW_LastDateRep;
var
  SqlOra : TOraQuery;
begin
  Lb_daterep.Hide;
  CBRefresh.Checked:=true;
  CBRefresh.Hide;
  if FAccid <> '' then
  Try
    SqlOra:=TOraQuery.Create(nil);
    with SqlOra do
    begin
     sql.text:='select max(r.DATE_REPORT) balance_date, max(r.session_id) session_id'+
               ' from BalanceEndM_Report r'+
               ' where r.session_id ='+
               '   (select max(p.session_id) session_id'+
               '    from balanceendm_balance_phone p'+
               '    where p.year_month = :YEAR_MONTH and p.accounts = :ACCOUNTS)';
     Prepare;
     ParamByName('YEAR_MONTH').asInteger:=YEAR_MONTH;
     ParamByName('ACCOUNTS').asString:=FAccid;
     Open;
     if not FieldByName('balance_date').IsNull then begin
       Lb_daterep.Caption:='Дата последнего отчета '+FieldByName('balance_date').AsString;
       session_id:=FieldByName('session_id').Asinteger;
       Lb_daterep.Show;
       CBRefresh.Checked:=false;
       CBRefresh.Show;
     end;
    end;
  finally
    SqlOra.Close;
    SqlOra.Free;
  end;
end;

procedure TReportBalanceOnEndMonthForm.SHOW_Report;
begin
 qReport.Close;
 qReport.ParamByName('SESSION_ID').AsInteger:=session_id;
 qReport.Open;
end;

procedure TReportBalanceOnEndMonthForm.SHOW_ProgressBar;
var
  SqlOra : TOraQuery;
begin

// вывод отчета на экран по последней дате
if cbrefresh.Checked=False then
 begin
    StatusBar1.Color:=clBtnFace;
    StatusBar1.SimpleText:='Процесс вывода данных для отчета';
    //вывод отчета
    SHOW_Report;
    StatusBar1.Color:=clMoneyGreen;
    StatusBar1.SimpleText:='Отчет сформирован';
end;

 // формирование отчета с пересбором данных
if cbrefresh.Checked=True then
Try
  StatusBar1.Color:=clBtnFace;
  SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
  begin
     // определим сколько джобов запущено по данному процессу
     Close;
     sql.Text:='select count(*) as count_job_work from dba_jobs where  what like '' BalanceEndM.BalanceEndM_Rep%'' ';
     Open;
     if FieldByName('count_job_work').AsInteger>0 then
     begin
       MessageDlg('В данный момент запущено формирование отчета , попробуйте сформировать отчет позже. ', mtConfirmation, [mbOK], 0);
       Exit;
     end;

  end;
  StatusBar1.SimpleText:='Процесс формирования данных для отчета';

  with SqlOra do
  begin
      // назначение номера сессии формирования отчета
     Close;
     sql.Text:='select s_session_balnow.nextval as sessionid from dual';
     Execute;
     session_id:=sqlOra.FieldByName('sessionid').AsInteger;
     try
       Close;
       sql.Text:='begin BalanceEndM.BalanceEndM_balphone(:YEAR_MONTH, :SESSION_ID, :ACCOUNTS); end;';
       Prepare;
       ParamByName('YEAR_MONTH').AsInteger:=YEAR_MONTH;
       ParamByName('SESSION_ID').AsInteger:=session_id;
       ParamByName('ACCOUNTS').AsString:=FAccid;
       Execute;
     except
       on e : exception do
         MessageDlg('Ошибка выполнения BalanceEndM.BalanceEndM_balphone', mtError, [mbOK], 0);
     end;

     Close;
     sql.Clear;
     sql.Text:='SELECT count(*) as record_count from BalanceEndM_balance_phone where session_id=:SESSION_ID';
     Prepare;
     ParamByName('SESSION_ID').AsInteger:=session_id;
     Open;
     Gauge1.MaxValue:=sqlOra.FieldByName('record_count').AsInteger;
     // запускаем  джобы
     try
     Close;
     sql.Text:='begin BalanceEndM.BalanceEndM_balance_jobs(:SESSION_ID); end;';
     Prepare;
     ParamByName('SESSION_ID').AsInteger:=session_id;
     Execute;
     except
       on e : exception do
         MessageDlg('Ошибка выполнения BalanceEndM.BalanceEndM_balance_jobs', mtError, [mbOK], 0);
     end;
  end;
  Timer1.Enabled:=true; //запуск таймера
finally
  SqlOra.Close;
  SqlOra.Free;
end;
end;

procedure TReportBalanceOnEndMonthForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportBalanceOnEndMonthForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBalanceOnEndMonthForm.aRefreshExecute(Sender: TObject);
begin
  if FAccid <> '' then
    SHOW_ProgressBar
  else
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
end;

procedure TReportBalanceOnEndMonthForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;


procedure TReportBalanceOnEndMonthForm.cbPeriodChange(Sender: TObject);
begin
  if cbPeriod.ItemIndex >= 0 then
  begin
    YEAR_MONTH := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    SHOW_LastDateRep;
  end;
end;

procedure TReportBalanceOnEndMonthForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

procedure TReportBalanceOnEndMonthForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];

  FAccid:='';
  if not FAccountAll then
  for i := 1 to CLB_Accounts.Items.Count - 1 do
    if CLB_Accounts.Checked[i] then
      FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';

  if not FAccountAll then
    FAccid:=copy(FAccid,1,Length(FAccid)-1)
  else
    FAccid:='-1';

  SHOW_LastDateRep;

end;
procedure TReportBalanceOnEndMonthForm.CLB_AccountsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var xPoint: TPoint;
    xIndex: Integer;
begin
  xPoint.X:=X;
  xPoint.Y:=Y;
  xIndex:=CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then begin
    CLB_Accounts.Hint:=CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else Application.CancelHint;
end;

procedure TReportBalanceOnEndMonthForm.FormCreate(Sender: TObject);
begin
{  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Clear;
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;}
end;

procedure TReportBalanceOnEndMonthForm.grDataGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
begin
  if (Field.FieldName='ACTIV')and(Field.AsString<>'1') then AFont.Color := clBlue;
  if (Field.FieldName='PHONE_IS_ACTIVE')and(Field.AsString='Блок.') then AFont.Color := clRed;
end;

procedure TReportBalanceOnEndMonthForm.Timer1Timer(Sender: TObject);
var
  SqlOra : TOraQuery;
begin
 try
  SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
  begin
    Close;
    sql.Text:=' SELECT count(*) cnt FROM BalanceEndM_Report WHERE session_id=:SESSION_ID';
    Prepare;
    ParamByName('SESSION_ID').AsInteger:=session_id;
    Open;
    StatusBar1.SimpleText:='Обработано записей '+FieldByName('cnt').AsString+' из '+inttostr(Gauge1.MaxValue);
    Gauge1.Progress:= FieldByName('cnt').AsInteger;
    close;
  end;
  If (Gauge1.Progress=Gauge1.MaxValue)    Then
  begin
    Timer1.Enabled:=False;
    Gauge1.Progress:=0;
    StatusBar1.SimpleText:='Процесс вывода данных для отчета на экран';
    //вывод отчета
    SHOW_Report;

    StatusBar1.Color:=clMoneyGreen;
    StatusBar1.SimpleText:='Отчет сформирован';
    SHOW_LastDateRep;
    CBRefresh.Checked:=false;
  end;
 finally
   SqlOra.Close;
   SqlOra.Free;
 end;
end;


end.
