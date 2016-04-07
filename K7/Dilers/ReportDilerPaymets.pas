unit ReportDilerPaymets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, ActnList, VirtualTable;

type
  TReportBillsForm = class(TForm)
    ActionList: TActionList;
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
    grData: TCRDBGrid;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportBILL_SUM_ORIGIN: TFloatField;
    qReportBILL_SUM: TFloatField;
    qReportDISCOUNT_VALUE: TFloatField;
    qReportDILER_PAYMENT: TFloatField;
    qReportDILER_PAYMENT_FULL: TFloatField;
    qReportSUBSCRIBER_PAYMENT_NEW: TFloatField;
    qReportSUBSCRIBER_PAYMENT_OLD: TFloatField;
    qReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField;
    qReportOPTION_COST_DILER: TFloatField;
    qReportOPTION_COST_FULL: TFloatField;
    qReportTARIFF_NAME: TStringField;
    qReportOPTION_COST_DILER_BEELINE: TFloatField;
    qReportTAIL: TFloatField;
    qReportDILER_FULL_SUM: TFloatField;
    qReportBEELINE_FULL_SUM: TFloatField;
    qReportDILER_ITOG_SUM: TFloatField;
    qReportCHECK_LONG_PLUS_BALANCE2: TStringField;
    vtReport: TVirtualTable;
    vtReportPHONE_NUMBER: TStringField;
    vtReportBILL_SUM_ORIGIN: TFloatField;
    vtReportBILL_SUM: TFloatField;
    vtReportDISCOUNT_VALUE: TFloatField;
    vtReportDILER_PAYMENT: TFloatField;
    vtReportDILER_PAYMENT_FULL: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_NEW: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_OLD: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField;
    vtReportOPTION_COST_DILER: TFloatField;
    vtReportOPTION_COST_FULL: TFloatField;
    vtReportTARIFF_NAME: TStringField;
    vtReportOPTION_COST_DILER_BEELINE: TFloatField;
    vtReportTAIL: TFloatField;
    vtReportDILER_FULL_SUM: TFloatField;
    vtReportBEELINE_FULL_SUM: TFloatField;
    vtReportDILER_ITOG_SUM: TFloatField;
    vtReportCHECK_LONG_PLUS_BALANCE2: TStringField;
    vtReportINSTALLMENT_PAYMENT_SUM: TFloatField;
    vtReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField;
    qReportINSTALLMENT_PAYMENT_SUM: TFloatField;
    qReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField;
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

var
  ReportBillsForm: TReportBillsForm;

procedure DoReportBills(TypeReport:string);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat;

procedure DoReportBills(TypeReport:string);
var ReportFrm : TReportBillsForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportBillsForm.Create(Nil);
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
    begin
      ReportFrm.cbPeriod.ItemIndex := 0;
      if ReportFrm.cbPeriod.ItemIndex >= 0 then
      ReportFrm.qReport.ParamByName('YEAR_MONTH').AsInteger :=
        Integer(ReportFrm.cbPeriod.Items.Objects[ReportFrm.cbPeriod.ItemIndex]);
    end;
    if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.cbAccounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex]);
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
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Отчет
    //ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBillsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportBillsForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBillsForm.aRefreshExecute(Sender: TObject);
var BillSumMax: double;
begin
  BillSumMax:=0;
  qReport.Close;
  qReport.Open;
  qReport.First;
  vtReport.Clear;
  vtReport.Open;
  while not qReport.Eof do
  begin
    if qReportPHONE_NUMBER.AsString=vtReportPHONE_NUMBER.AsString then
    begin
      vtReport.Edit;
      vtReportBILL_SUM_ORIGIN.AsFloat:=
        vtReportBILL_SUM_ORIGIN.AsFloat+qReportBILL_SUM_ORIGIN.AsFloat;
      if BillSumMax<qReportBILL_SUM_ORIGIN.AsFloat then
        BillSumMax:=qReportBILL_SUM_ORIGIN.AsFloat;
      vtReportBILL_SUM.AsFloat:=vtReportBILL_SUM.AsFloat+qReportBILL_SUM.AsFloat;
      vtReportDISCOUNT_VALUE.AsFloat:=
        vtReportDISCOUNT_VALUE.AsFloat+qReportDISCOUNT_VALUE.AsFloat;
      vtReportDILER_PAYMENT.AsFloat:=
        vtReportDILER_PAYMENT.AsFloat+qReportDILER_PAYMENT.AsFloat;
      vtReportDILER_PAYMENT_FULL.AsFloat:=
        vtReportDILER_PAYMENT_FULL.AsFloat+qReportDILER_PAYMENT_FULL.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat+qReportSUBSCRIBER_PAYMENT_NEW.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat+qReportSUBSCRIBER_PAYMENT_OLD.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat+qReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat;
      vtReportOPTION_COST_DILER.AsFloat:=
        vtReportOPTION_COST_DILER.AsFloat+qReportOPTION_COST_DILER.AsFloat;
      vtReportOPTION_COST_FULL.AsFloat:=
        vtReportOPTION_COST_FULL.AsFloat+qReportOPTION_COST_FULL.AsFloat;
      if BillSumMax=qReportBILL_SUM_ORIGIN.AsFloat then
        vtReportTARIFF_NAME.AsString:=qReportTARIFF_NAME.AsString;
      vtReportOPTION_COST_DILER_BEELINE.AsFloat:=
        vtReportOPTION_COST_DILER_BEELINE.AsFloat+qReportOPTION_COST_DILER_BEELINE.AsFloat;
      vtReportTAIL.AsFloat:=vtReportTAIL.AsFloat+qReportTAIL.AsFloat;
      vtReportDILER_FULL_SUM.AsFloat:=
        vtReportDILER_FULL_SUM.AsFloat+qReportDILER_FULL_SUM.AsFloat;
      vtReportBEELINE_FULL_SUM.AsFloat:=
        vtReportBEELINE_FULL_SUM.AsFloat+qReportBEELINE_FULL_SUM.AsFloat;
      vtReportDILER_ITOG_SUM.AsFloat:=
        vtReportDILER_ITOG_SUM.AsFloat+qReportDILER_ITOG_SUM.AsFloat;
      if (vtReportCHECK_LONG_PLUS_BALANCE2.AsString='+')
          or (qReportCHECK_LONG_PLUS_BALANCE2.AsString='+') then
        vtReportCHECK_LONG_PLUS_BALANCE2.AsString:='+'
      else
        vtReportCHECK_LONG_PLUS_BALANCE2.AsString:='-';
      vtReportINSTALLMENT_PAYMENT_SUM.AsFloat:=
        vtReportINSTALLMENT_PAYMENT_SUM.AsFloat+qReportINSTALLMENT_PAYMENT_SUM.AsFloat;
      vtReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat:=
        vtReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat+qReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat;
      vtReport.Post;
    end
    else
    begin
      vtReport.Append;
      vtReportPHONE_NUMBER.AsString:= qReportPHONE_NUMBER.AsString;
      vtReportBILL_SUM_ORIGIN.AsFloat:= qReportBILL_SUM_ORIGIN.AsFloat;
      BillSumMax:=qReportBILL_SUM_ORIGIN.AsFloat;
      vtReportBILL_SUM.AsFloat:= qReportBILL_SUM.AsFloat;
      vtReportDISCOUNT_VALUE.AsFloat:= qReportDISCOUNT_VALUE.AsFloat;
      vtReportDILER_PAYMENT.AsFloat:= qReportDILER_PAYMENT.AsFloat;
      vtReportDILER_PAYMENT_FULL.AsFloat:= qReportDILER_PAYMENT_FULL.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat:= qReportSUBSCRIBER_PAYMENT_NEW.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat:= qReportSUBSCRIBER_PAYMENT_OLD.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat:= qReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat;
      vtReportOPTION_COST_DILER.AsFloat:= qReportOPTION_COST_DILER.AsFloat;
      vtReportOPTION_COST_FULL.AsFloat:= qReportOPTION_COST_FULL.AsFloat;
      vtReportTARIFF_NAME.AsString:= qReportTARIFF_NAME.AsString;
      vtReportOPTION_COST_DILER_BEELINE.AsFloat:= qReportOPTION_COST_DILER_BEELINE.AsFloat;
      vtReportTAIL.AsFloat:= qReportTAIL.AsFloat;
      vtReportDILER_FULL_SUM.AsFloat:= qReportDILER_FULL_SUM.AsFloat;
      vtReportBEELINE_FULL_SUM.AsFloat:= qReportBEELINE_FULL_SUM.AsFloat;
      vtReportDILER_ITOG_SUM.AsFloat:= qReportDILER_ITOG_SUM.AsFloat;
      vtReportCHECK_LONG_PLUS_BALANCE2.AsString:= qReportCHECK_LONG_PLUS_BALANCE2.AsString;
      vtReportINSTALLMENT_PAYMENT_SUM.AsFloat:=qReportINSTALLMENT_PAYMENT_SUM.AsFloat;
      vtReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat:=qReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat;
      vtReport.Post;
    end;
    qReport.Next;
  end;
end;

procedure TReportBillsForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportBillsForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    //aRefresh.Execute;
  end else
  begin
    qReport.ParamByName('ACCOUNT_ID').Clear;
    //aRefresh.Execute;
  end;
end;

procedure TReportBillsForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
  //aRefresh.Execute;
end;

procedure TReportBillsForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;


end.
