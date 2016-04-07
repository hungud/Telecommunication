unit ReportAccountPhones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

type
  TReportAccountPhonesForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    PhoneNumberViolationsGrid: TCRDBGrid;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    alReports: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReports: TOraQuery;
    dsReports: TDataSource;
    qReportsPHONE_IS_ACTIVE: TIntegerField;
    qReportsLAST_CHECK_DATE_TIME: TDateTimeField;
    qReportsCONSERVATION: TIntegerField;
    qReportsSYSTEM_BLOCK: TIntegerField;
    qReportsACCOUNT_NUMBER: TFloatField;
    qReportsPHONE_NUMBER: TStringField;
    qReportsCELL_PLAN_CODE: TStringField;
    cbSubstValues: TCheckBox;
    qReportsDETAIL_SUM: TFloatField;
    qReportsIS_CONTRACT: TStringField;
    pCount: TPanel;
    qReportsCONTRACT_NUM: TFloatField;
    qReportsTARIFF_NAME: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure cbSubstValuesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportAccountPhones;

var
  ReportAccountPhonesForm: TReportAccountPhonesForm;

implementation

uses Main;

{$R *.dfm}

procedure DoReportAccountPhones;
var ReportFrm : TReportAccountPhonesForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportAccountPhonesForm.Create(Nil);
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
    if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.cbAccounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
        ReportFrm.qReports.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qReports.ParamByName('ACCOUNT_ID').Clear;
    end else
    begin
      Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      ReportFrm.lAccount.Hide;
      ReportFrm.cbAccounts.Hide;
      ReportFrm.btLoadInExcel.Left:=ReportFrm.btLoadInExcel.Left-Sdvig;
      ReportFrm.btRefresh.Left:=ReportFrm.btRefresh.Left-Sdvig;
      ReportFrm.btInfoAbonent.Left:=ReportFrm.btInfoAbonent.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.lPeriod.Left:=ReportFrm.lPeriod.Left-Sdvig;
      ReportFrm.cbPeriod.Left:=ReportFrm.cbPeriod.Left-Sdvig;
      ReportFrm.qReports.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportAccountPhonesForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportAccountPhonesForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      PhoneNumberViolationsGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAccountPhonesForm.aRefreshExecute(Sender: TObject);
var CountPhone: integer;
begin
  qReports.Close;
  qReports.Open;
  if qReports.Active and (qReports.RecordCount > 0) then
  begin
    CountPhone:= qReports.RecordCount;
    pCount.Font.Color:= ClGreen;
  end else
  begin
    CountPhone:=0;
    pCount.Font.Color:= ClRed;
  end;
  pCount.Caption:='Количество номеров: ' + IntToStr(CountPhone);
end;

procedure TReportAccountPhonesForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReports.Active and (qReports.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReports.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportAccountPhonesForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReports.ParamByName('ACCOUNT_ID').asInteger := Account;
    //aRefresh.Execute;
  end else
  begin
    qReports.ParamByName('ACCOUNT_ID').Clear;
   // aRefresh.Execute;
  end;
end;

procedure TReportAccountPhonesForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReports.ParamByName('YEAR_MONTH').AsInteger := Period;
  //aRefresh.Execute;
end;

procedure TReportAccountPhonesForm.cbSubstValuesClick(Sender: TObject);
 var
  sqlValue:string;
begin
 if cbSubstValues.Checked then begin
  PhoneNumberViolationsGrid.Columns.Items[9].Visible:=true;
  PhoneNumberViolationsGrid.Columns.Items[10].Visible:=true;
 end
 else
  PhoneNumberViolationsGrid.Columns.Items[9].Visible:=false;
  if (GetConstantValue('SERVER_NAME')='GSM') then
    PhoneNumberViolationsGrid.Columns.Items[10].Visible:=True;
end;

procedure TReportAccountPhonesForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReports.SQL.Insert(9, 'AND A.FILIAL_ID=' + IntToStr(MainForm.FFilial));
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;

  if (GetConstantValue('SERVER_NAME')='GSM_CORP') then
  begin
    PhoneNumberViolationsGrid.Columns.Items[1].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[2].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[4].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[6].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[7].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[8].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[9].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[10].Visible:=True;
    cbSubstValues.Visible := False;
    cbSearch.Visible := False;
  end
  else
  begin
    PhoneNumberViolationsGrid.Columns.Items[1].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[2].Visible:=False;
    PhoneNumberViolationsGrid.Columns.Items[4].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[6].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[7].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[8].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[9].Visible:=True;
    PhoneNumberViolationsGrid.Columns.Items[10].Visible:=True;
  end;
end;

end.
