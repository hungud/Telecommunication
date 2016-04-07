unit ReportBillNoDiscountYear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, DB, Grids, DBGrids, CRGrid,
  MemDS, DBAccess, Ora;

type
  TReportBillNoDiscountYearForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReport: TOraQuery;
    grData: TCRDBGrid;
    dsReport: TDataSource;
    qReportYEAR_MONTH_DOSCOUNT: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportBILL_SUM: TFloatField;
    qReportABONKA: TFloatField;
    qReportCALLS: TFloatField;
    qReportSINGLE_PAYMENTS: TFloatField;
    qReportDISCOUNTS: TFloatField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportBillNoDiscount;

var
  ReportBillNoDiscountYearForm: TReportBillNoDiscountYearForm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, IntecExportGrid;

procedure DoReportBillNoDiscount;
var ReportFrm : TReportBillNoDiscountYearForm;
    Sdvig:integer;
begin
  ReportFrm := TReportBillNoDiscountYearForm.Create(Nil);
  try

   { ReportFrm.qFastPeriods.Open;
    while not ReportFrm.qFastPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qFastPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qFastPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qFastPeriods.Next;
    end;
    ReportFrm.qFastPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;     }

    {ReportFrm.qPeriods.Open;
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
      ReportFrm.cbPeriod.ItemIndex := 0;  }

  {  if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
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
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex]);
    end else
    begin
      Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      ReportFrm.lAccount.Hide;
      ReportFrm.cbAccounts.Hide;
      ReportFrm.BitBtn1.Left:=ReportFrm.BitBtn1.Left-Sdvig;
      ReportFrm.BitBtn2.Left:=ReportFrm.BitBtn2.Left-Sdvig;
      ReportFrm.BitBtn3.Left:=ReportFrm.BitBtn3.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.Label1.Left:=ReportFrm.Label1.Left-Sdvig;
      ReportFrm.cbPeriod.Left:=ReportFrm.cbPeriod.Left-Sdvig;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;    }
  //  ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBillNoDiscountYearForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('—чета, имевшие годовую скидку ранее', '', grData, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBillNoDiscountYearForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportBillNoDiscountYearForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;


procedure TReportBillNoDiscountYearForm.FormShow(Sender: TObject);
begin
  aRefresh.Execute;
end;

end.
