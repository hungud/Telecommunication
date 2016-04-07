unit ReportFinanceSumBills;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.CheckLst,strutils;

type
{ TQueryThread = class(TThread)

  private
    FSession: TOraSession;
    FQuery: TOraQuery;
    FDatasource: TDatasource;
    FQueryException: Exception;
    procedure ConnectDataSource;
    procedure ShowQueryError;
  protected
    procedure Execute; override;
  public
    constructor Create(Session: TOraSession; Query: TOraQuery; DataSource: TDataSource);
      virtual;
  end;
}

  TReportFinanceSumBillsForm = class(TForm)
    qReport_Accounts: TOraQuery;
    dsReport_Accounts: TDataSource;
    alReport: TActionList;
    aExcelAccounts: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qPeriods: TOraQuery;
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcelAccounts: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    qReport_Phones: TOraQuery;
    dsReport_Phones: TDataSource;
    GridReport_Accounts: TCRDBGrid;
    GridReport_Phones: TCRDBGrid;
    qReport_AccountsLOGIN: TStringField;
    qReport_AccountsBILL_SUM: TFloatField;
    qReport_AccountsBILL_SUM_NEW: TFloatField;
    qReport_AccountsPAYMENT_SUM: TFloatField;
    qReport_AccountsPAYMENT_SUM_1: TFloatField;
    qReport_PhonesPHONE_NUMBER: TStringField;
    qReport_PhonesBILL_SUM: TFloatField;
    qReport_PhonesBILL_SUM_NEW: TFloatField;
    qReport_PhonesPAYMENT_SUM: TFloatField;
    qReport_PhonesPAYMENT_SUM_1: TFloatField;
    qReport_AccountsACCOUNT_ID: TFloatField;
    btLoadInExcelPhones: TBitBtn;
    aExcelPhones: TAction;
    clbAccounts: TCheckListBox;
    btRefreshPhone: TBitBtn;
    Panel4: TPanel;
    Panel5: TPanel;
    qReport_Phoneslogin: TStringField;
    procedure aExcelAccountsExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelPhonesExecute(Sender: TObject);
    procedure btRefreshPhoneClick(Sender: TObject);
    procedure clbAccountsClickCheck(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FDefaultSQl:string;
  public
    { Public declarations }
  end;

procedure DoReportFinanceSumBills;

var
  ReportFinanceSumBillsForm: TReportFinanceSumBillsForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, ContractsRegistration_Utils, main;

{constructor TQueryThread.Create(Session: TOraSession; Query: TOraQuery; Datasource: TDataSource);
begin
  inherited Create(True);
  FSession := Session;
  FQuery := Query;
  FDataSource := Datasource;
  FreeOnTerminate := True;
  Resume;
end;

procedure TQueryThread.Execute;
begin
  try
    FQuery.Open;
    Synchronize(ConnectDataSource);
  except
    FQueryException := ExceptObject as Exception;
    Synchronize(ShowQueryError);
  end;
end;

procedure TQueryThread.ConnectDataSource;
begin
  FDataSource.DataSet := FQuery;

end;

procedure TQueryThread.ShowQueryError;
begin
  Application.ShowException(FQueryException);
end;
}
procedure DoReportFinanceSumBills;
var ReportFrm : TReportFinanceSumBillsForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportFinanceSumBillsForm.Create(Nil);
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
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    ReportFrm.FDefaultSQl:=ReportFrm.qReport_Phones.SQL.Text;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportFinanceSumBillsForm.aExcelAccountsExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Cуммы счетов и платежей по л/с за  ' + cbPeriod.Text,'',
      GridReport_Accounts, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceSumBillsForm.aExcelPhonesExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Cуммы счетов и платежей по номерам за  ' + cbPeriod.Text,'',
      GridReport_Phones, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceSumBillsForm.aRefreshExecute(Sender: TObject);
begin
  btRefresh.Enabled:=false;
  qReport_Accounts.Close;
  qReport_Accounts.Open;
  clbAccounts.Items.AddObject('Все',Pointer(-1));
  while not qReport_Accounts.Eof do
  begin
    clbAccounts.Items.AddObject(
          qReport_Accounts.FieldByName('login').AsString,
          Pointer(qReport_Accounts.FieldByName('account_id').AsInteger));

    qReport_Accounts.Next;
  end;
  qReport_Accounts.First;
  FAccountAll:=false;
  btRefresh.Enabled:=true;
{  dsReport_Accounts.DataSet:=nil;
  dsReport_Phones.DataSet:=nil;
  TQueryThread.Create( mainform.OraSession, qReport_Accounts, dsReport_Accounts);
  TQueryThread.Create( mainform.OraSession, qReport_Phones, dsReport_Phones);}
end;

procedure TReportFinanceSumBillsForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport_Phones.Active and (qReport_Phones.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport_Phones.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportFinanceSumBillsForm.btRefreshPhoneClick(Sender: TObject);
var
 i:integer;
 s:string;
begin
 qReport_Phones.Close;
 if clbAccounts.Checked[0] then begin
   qReport_Phones.SQL.Text:=ReplaceStr(FDefaultSQl,'%ACCOUNTS%','');
   qReport_Phones.SQL.Text:=ReplaceStr(qReport_Phones.SQL.Text,'%ACCOUNTS2%','');
   qReport_Phones.Prepare;
   qReport_Phones.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
 end
 else begin
   s:='(';
   for I := 1 to clbAccounts.Count-1 do
    if clbAccounts.Checked[i] then
      if s='(' then
        s:=s+':a'+inttostr(i)
      else
        s:=s+',:a'+inttostr(i);
   if s='(' then begin
     MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
     Exit;
   end;
   s:=s+')';
   qReport_Phones.SQL.Text:=ReplaceStr(FDefaultSQl,'%ACCOUNTS%','AND account_id IN '+s);
   qReport_Phones.SQL.Text:=ReplaceStr(qReport_Phones.SQL.Text,'%ACCOUNTS2%','AND get_account_id_by_phone(phone_number) IN '+s);
   qReport_Phones.Prepare;
   for I := 1 to clbAccounts.Count-1 do
    if clbAccounts.Checked[i] then
      qReport_Phones.ParamByName('a'+inttostr(i)).AsInteger:=integer(clbAccounts.Items.Objects[i]);
   qReport_Phones.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
 end;
 qReport_Phones.Open;
end;

procedure TReportFinanceSumBillsForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport_Accounts.ParamByName('YEAR_MONTH').AsInteger := Period;
end;

procedure TReportFinanceSumBillsForm.clbAccountsClickCheck(Sender: TObject);
var
 i:integer;
begin
  if FAccountAll<>clbAccounts.Checked[0] then
    for i := 1 to clbAccounts.Count-1 do
      clbAccounts.Checked[i]:=clbAccounts.Checked[0]
  else
    clbAccounts.Checked[0]:=false;
  FAccountAll:=clbAccounts.Checked[0];
end;

end.
