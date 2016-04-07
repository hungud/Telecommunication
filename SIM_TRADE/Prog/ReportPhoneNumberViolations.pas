unit ReportPhoneNumberViolations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

type
  TReportPhoneNumberViolationsFrm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    PhoneNumberViolationsGrid: TCRDBGrid;
    qPhoneNumberViolations: TOraQuery;
    dsPhoneNumberViolations: TDataSource;
    qPeriods: TOraQuery;
    alPhoneNumberViolations: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportPhoneNumberViolations;

var
  ReportPhoneNumberViolationsFrm: TReportPhoneNumberViolationsFrm;

implementation

{$R *.dfm}

procedure DoReportPhoneNumberViolations;
var ReportFrm : TReportPhoneNumberViolationsFrm;
    Sdvig:integer;
begin
  ReportFrm:=TReportPhoneNumberViolationsFrm.Create(Nil);
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
        ReportFrm.qPhoneNumberViolations.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qPhoneNumberViolations.ParamByName('ACCOUNT_ID').Clear;
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
      ReportFrm.qPhoneNumberViolations.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportPhoneNumberViolationsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportPhoneNumberViolationsFrm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      PhoneNumberViolationsGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhoneNumberViolationsFrm.aRefreshExecute(Sender: TObject);
begin
  qPhoneNumberViolations.Close;
  qPhoneNumberViolations.Open;
end;

procedure TReportPhoneNumberViolationsFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qPhoneNumberViolations.Active and (qPhoneNumberViolations.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qPhoneNumberViolations.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPhoneNumberViolationsFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qPhoneNumberViolations.ParamByName('ACCOUNT_ID').asInteger := Account;
 //   aRefresh.Execute;
  end else
  begin
    qPhoneNumberViolations.ParamByName('ACCOUNT_ID').Clear;
  //  aRefresh.Execute;
  end;
end;

procedure TReportPhoneNumberViolationsFrm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qPhoneNumberViolations.ParamByName('YEAR_MONTH').AsInteger := Period;
  //aRefresh.Execute;
end;

procedure TReportPhoneNumberViolationsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    PhoneNumberViolationsGrid.OptionsEx:=PhoneNumberViolationsGrid.OptionsEx+[dgeSearchBar]
  else
    PhoneNumberViolationsGrid.OptionsEx:=PhoneNumberViolationsGrid.OptionsEx-[dgeSearchBar];
end;

end.
