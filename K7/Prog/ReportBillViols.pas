unit ReportBillViols;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, ActnList,
  Grids, DBGrids, CRGrid, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils,
  ComCtrls;

type
  TReportBillViolsForm = class(TForm)
    alBillViols: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Panel1: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qBillViolBl: TOraQuery;
    BillViolGrid: TCRDBGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    dsBillViolBl: TDataSource;
    qBillViolNoContr: TOraQuery;
    dsBillViolNoContr: TDataSource;
    BillViolNoContrGrid: TCRDBGrid;
    qBillViolBlPHONE_NUMBER: TStringField;
    qBillViolBlBILL_SUM: TFloatField;
    qBillViolBlABONKA: TFloatField;
    qBillViolBlCALLS: TFloatField;
    qBillViolBlSINGLE_PAYMENTS: TFloatField;
    qBillViolBlDISCOUNTS: TFloatField;
    qBillViolNoContrPHONE_NUMBER: TStringField;
    qBillViolNoContrBILL_SUM: TFloatField;
    qBillViolNoContrABONKA: TFloatField;
    qBillViolNoContrCALLS: TFloatField;
    qBillViolNoContrSINGLE_PAYMENTS: TFloatField;
    qBillViolNoContrDISCOUNTS: TFloatField;
    TabSheet3: TTabSheet;
    ReportDataGrid: TCRDBGrid;
    qReportData: TOraQuery;
    dsReportData: TDataSource;
    qReportDataPHONE_NUMBER: TStringField;
    qReportDataDETAIL_SUM: TFloatField;
    qBillViolBlaccount_number: TFloatField;
    qBillViolNoContrACCOUNT_NUMBER: TFloatField;
    qReportDataACCOUNT_NUMBER: TFloatField;
    tsCallInSave: TTabSheet;
    Panel2: TPanel;
    GridCIS: TCRDBGrid;
    qCallInSave: TOraQuery;
    dsCallInSave: TDataSource;
    qCallInSavePHONE_NUMBER: TStringField;
    qCallInSaveDETAIL_SUM: TFloatField;
    Panel3: TPanel;
    Panel4: TPanel;
    btCISSave: TBitBtn;
    cbCISDetailFilter: TCheckBox;
    GridCISDetalis: TCRDBGrid;
    btCISDetailRefresh: TBitBtn;
    qCISDetals: TOraQuery;
    qCISDetalsSUBSCR_NO: TStringField;
    qCISDetalsCALL_COST: TFloatField;
    qCISDetalsAT_FT_DE: TStringField;
    qCISDetalsDIALED_DIG: TStringField;
    qCISDetalsCNT: TFloatField;
    dsCISDetals: TDataSource;
    qCallInSaveBILL_SUM: TFloatField;
    qCallInSaveABON_TP: TStringField;
    qCallInSaveLOGIN: TStringField;
    Splitter1: TSplitter;
    qReportDataOPTION_CODE: TStringField;
    qBillViolBlOPTION_NAME: TStringField;
    qBillViolBlTURN_ON_DATE: TDateTimeField;
    qBillViolBlTURN_OFF_DATE: TDateTimeField;
    qBillViolBlOPTION_CODE_PERIOD: TStringField;
    qBillViolBlOPTION_CODE_NOW: TStringField;
    qBillViolNoContrDOP_STATUS_NAME: TStringField;
    procedure cbAccountsChange(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure btCISDetailRefreshClick(Sender: TObject);
    procedure btCISSaveClick(Sender: TObject);
    procedure cbCISDetailFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportBillViols;

var
  ReportBillViolsForm: TReportBillViolsForm;

implementation

{$R *.dfm}



procedure DoReportBillViols;
var ReportFrm : TReportBillViolsForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportBillViolsForm.Create(Nil);
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
        ReportFrm.qBillViolBl.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qBillViolBl.ParamByName('ACCOUNT_ID').Clear;
      if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
        ReportFrm.qBillViolNoContr.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qBillViolNoContr.ParamByName('ACCOUNT_ID').Clear;
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
      ReportFrm.qBillViolBl.ParamByName('ACCOUNT_ID').Clear;
      ReportFrm.qBillViolNoContr.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Отчет
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.PageControl1.ActivePageIndex:=0;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBillViolsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if PageControl1.ActivePageIndex = 0 then
      ExportDBGridToExcel2('Отчёт по нарушениям в счетах в блокировке за ' + cbPeriod.Text,'',
        BillViolGrid, nil, False, True);
    if PageControl1.ActivePageIndex = 1 then
      ExportDBGridToExcel2('Отчёт по нарушениям в счетах без договоров за ' + cbPeriod.Text,'',
        BillViolNoContrGrid, nil, False, True);
    if PageControl1.ActivePageIndex = 2 then
      ExportDBGridToExcel2('Нарушениям в отчете о тек начислениях','',
        ReportDataGrid, nil, False, True);
    if PageControl1.ActivePageIndex = 3 then
      ExportDBGridToExcel2('Нарушения: Звонки на номерах в сохранении за ' + cbPeriod.Text,'',
        GridCIS, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBillViolsForm.aRefreshExecute(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    qBillViolBl.Close;
    qBillViolBl.Open;
  end;
  if PageControl1.ActivePageIndex = 1 then
  begin
    qBillViolNoContr.Close;
    qBillViolNoContr.Open;
  end;
  if PageControl1.ActivePageIndex = 2 then
  begin
    qReportData.Close;
    qReportData.Open;
  end;
  if PageControl1.ActivePageIndex = 3 then
  begin
    qCallInSave.Close;
    qCallInSave.Open;
  end;
end;

procedure TReportBillViolsForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
    if qBillViolBl.Active and (qBillViolBl.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qBillViolBl.FieldByName('PHONE_NUMBER').AsString, 0);
  if PageControl1.ActivePageIndex = 1 then
    if qBillViolNoContr.Active and (qBillViolNoContr.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qBillViolNoContr.FieldByName('PHONE_NUMBER').AsString, 0);
  if PageControl1.ActivePageIndex = 2 then
    if qReportData.Active and (qReportData.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qReportData.FieldByName('PHONE_NUMBER').AsString, 0);
  if PageControl1.ActivePageIndex = 3 then
    if qCallInSave.Active and (qCallInSave.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qCallInSave.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportBillViolsForm.btCISDetailRefreshClick(Sender: TObject);
begin
  qCISDetals.Close;
  qCISDetals.Open;
end;

procedure TReportBillViolsForm.btCISSaveClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Нарушения: Список звонков на номерах в сохранении за ' + cbPeriod.Text,'',
      GridCISDetalis, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBillViolsForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qBillViolBl.ParamByName('ACCOUNT_ID').asInteger := Account;
    qBillViolNoContr.ParamByName('ACCOUNT_ID').asInteger := Account;
    qCallInSave.ParamByName('ACCOUNT_ID').asInteger := Account;
    qCISDetals.ParamByName('ACCOUNT_ID').asInteger := Account;
  //  aRefresh.Execute;
  end else
  begin
    qBillViolBl.ParamByName('ACCOUNT_ID').Clear;
    qBillViolNoContr.ParamByName('ACCOUNT_ID').Clear;
    qCallInSave.ParamByName('ACCOUNT_ID').Clear;
    qCISDetals.ParamByName('ACCOUNT_ID').Clear;
  //  aRefresh.Execute;
  end;
end;

procedure TReportBillViolsForm.cbCISDetailFilterClick(Sender: TObject);
begin
  if cbCISDetailFilter.Checked then
    GridCISDetalis.OptionsEx:=GridCISDetalis.OptionsEx+[dgeFilterBar]
  else
    GridCISDetalis.OptionsEx:=GridCISDetalis.OptionsEx-[dgeFilterBar];
end;

procedure TReportBillViolsForm.cbPeriodChange(Sender: TObject);
var Period, Month : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  Month:= Period mod 100;
  qBillViolBl.ParamByName('YEAR_MONTH').AsInteger := Period;
  qBillViolNoContr.ParamByName('YEAR_MONTH').AsInteger := Period;
  qCallInSave.ParamByName('YEAR_MONTH').AsInteger := Period;
  qCallInSave.SQL[22]:='                  FROM CALL_' + IntToStr(Month div 10)
    + IntToStr(Month mod 10) + '_' + IntToStr(Period div 100) + ' HB';
  qCISDetals.ParamByName('YEAR_MONTH').AsInteger := Period;
  qCISDetals.SQL[5]:='  FROM CALL_' + IntToStr(Month div 10)
    + IntToStr(Month mod 10) + '_' + IntToStr(Period div 100) + ' HB';
 // aRefresh.Execute;
end;

procedure TReportBillViolsForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    BillViolGrid.OptionsEx:=BillViolGrid.OptionsEx+[dgeSearchBar]
  else
    BillViolGrid.OptionsEx:=BillViolGrid.OptionsEx-[dgeSearchBar];
  if cbSearch.Checked then
    BillViolNoContrGrid.OptionsEx:=BillViolNoContrGrid.OptionsEx+[dgeSearchBar]
  else
    BillViolNoContrGrid.OptionsEx:=BillViolNoContrGrid.OptionsEx-[dgeSearchBar];
  if cbSearch.Checked then
    ReportDataGrid.OptionsEx:=ReportDataGrid.OptionsEx+[dgeSearchBar]
  else
    ReportDataGrid.OptionsEx:=ReportDataGrid.OptionsEx-[dgeSearchBar];
  if cbSearch.Checked then
    GridCIS.OptionsEx:=ReportDataGrid.OptionsEx+[dgeSearchBar]
  else
    GridCIS.OptionsEx:=ReportDataGrid.OptionsEx-[dgeSearchBar];
end;

procedure TReportBillViolsForm.FormShow(Sender: TObject);
begin
//1.8.17.11
//if GetConstantValue('SERVER_NAME')='GSM_CORP' then
if (GetConstantValue('SHOW_BILL_VIOLATION_IN_ACCOUNT')='1') then
begin
  PageControl1.Pages[1].TabVisible := False;
  PageControl1.Pages[2].TabVisible := False;
  PageControl1.Pages[3].TabVisible := False;
end;

end;

procedure TReportBillViolsForm.TabSheet1Show(Sender: TObject);
begin
  aRefresh.Execute;
end;

end.
