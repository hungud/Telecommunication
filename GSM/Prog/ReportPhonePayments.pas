unit ReportPhonePayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, IntecExportGrid, ActnList;

type
  TReportPhonePaymentsFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Payments: TCRDBGrid;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_SUM: TFloatField;
    qReportPAYMENT_NUMBER: TStringField;
    qReportPAYMENT_STATUS_TEXT: TStringField;
    cbSearch: TCheckBox;
    qReportDATE_CREATED: TDateTimeField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportPAYMENT_DATE: TDateTimeField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure cbOperatorNamesChange(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportPhonePayments;

//var ReportPhonePaymentsFrm: TReportPhonePaymentsFrm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, Excel2000, Main;

procedure DoReportPhonePayments;
var ReportFrm : TReportPhonePaymentsFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportPhonePaymentsFrm.Create(Nil);
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

    // Обновим.
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.qReport.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;


procedure TReportPhonePaymentsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по детализации за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      Payments, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhonePaymentsFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportPhonePaymentsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPhonePaymentsFrm.cbOperatorNamesChange(Sender: TObject);
var
  OperatorName : String;
begin
 { if cbOperatorNames.ItemIndex > 0 then
    OperatorName := cbOperatorNames.Items[cbOperatorNames.ItemIndex]
  else
    OperatorName := '';
  qReport.ParamByName('OPERATOR_NAME').AsString := OperatorName;
  aRefresh.Execute;   }
end;

procedure TReportPhonePaymentsFrm.cbPeriodChange(Sender: TObject);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
 // aRefresh.Execute;
end;

procedure TReportPhonePaymentsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    Payments.OptionsEx:=Payments.OptionsEx+[dgeSearchBar]
  else
    Payments.OptionsEx:=Payments.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhonePaymentsFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE p.ACCOUNT_ID = AC.ACCOUNT_ID)');
  end;

  qReport.SQL.Append('ORDER BY PAYMENT_DATE DESC ');
end;

end.
