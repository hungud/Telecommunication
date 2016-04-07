unit ReportAccountPeriod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TReportAccountPeriodForm = class(TForm)
    pButtons: TPanel;
    pGrid: TPanel;
    gAccount4Period: TCRDBGrid;
    lbl1: TLabel;
    lbl2: TLabel;
    btLoadInExcel: TBitBtn;
    qReportAccount4Period: TOraQuery;
    dsAccount4Period: TDataSource;
    btRefresh: TBitBtn;
    qAccounts: TOraQuery;
    dsAccounts: TDataSource;
    qReportAccountsYEAR_MONTH: TFloatField;
    cbAccounts1: TComboBox;
    cbAccounts2: TComboBox;
    qReportAccount4PeriodACCOUNT_ID: TFloatField;
    qReportAccount4PeriodACCOUNT_NUMBER: TFloatField;
    qReportAccount4PeriodYEAR_MONTH: TFloatField;
    qReportAccount4PeriodPHONE_NUMBER: TStringField;
    qReportAccount4PeriodABONKA: TFloatField;
    qReportAccount4PeriodCALLS: TFloatField;
    qReportAccount4PeriodSINGLE_PAYMENTS: TFloatField;
    qReportAccount4PeriodDISCOUNTS: TFloatField;
    qReportAccount4PeriodBILL_SUM: TFloatField;
    qReportAccount4PeriodCOMPLETE_BILL: TFloatField;
    qReportAccount4PeriodABON_MAIN: TFloatField;
    qReportAccount4PeriodABON_ADD: TFloatField;
    qReportAccount4PeriodABON_OTHER: TFloatField;
    qReportAccount4PeriodSINGLE_MAIN: TFloatField;
    qReportAccount4PeriodSINGLE_ADD: TFloatField;
    qReportAccount4PeriodSINGLE_PENALTI: TFloatField;
    qReportAccount4PeriodSINGLE_CHANGE_TARIFF: TFloatField;
    qReportAccount4PeriodSINGLE_TURN_ON_SERV: TFloatField;
    qReportAccount4PeriodSINGLE_CORRECTION_ROUMING: TFloatField;
    qReportAccount4PeriodSINGLE_INTRA_WEB: TFloatField;
    qReportAccount4PeriodSINGLE_VIEW_BLACK_LIST: TFloatField;
    qReportAccount4PeriodSINGLE_OTHER: TFloatField;
    qReportAccount4PeriodDISCOUNT_YEAR: TFloatField;
    qReportAccount4PeriodDISCOUNT_SMS_PLUS: TFloatField;
    qReportAccount4PeriodDISCOUNT_CALL: TFloatField;
    qReportAccount4PeriodDISCOUNT_COUNT_ON_PHONES: TFloatField;
    qReportAccount4PeriodDISCOUNT_OTHERS: TFloatField;
    qReportAccount4PeriodCALLS_COUNTRY: TFloatField;
    qReportAccount4PeriodCALLS_SITY: TFloatField;
    qReportAccount4PeriodCALLS_LOCAL: TFloatField;
    qReportAccount4PeriodCALLS_SMS_MMS: TFloatField;
    qReportAccount4PeriodCALLS_GPRS: TFloatField;
    qReportAccount4PeriodCALLS_RUS_RPP: TFloatField;
    qReportAccount4PeriodCALLS_ALL: TFloatField;
    qReportAccount4PeriodROUMING_NATIONAL: TFloatField;
    qReportAccount4PeriodROUMING_INTERNATIONAL: TFloatField;
    dtmfldReportAccount4PeriodDATE_LAST_UPDATED: TDateTimeField;
    qReportAccount4PeriodDISCOUNT_SOVINTEL: TFloatField;
    qReportAccount4PeriodBAN: TFloatField;
    procedure btLoadInExcelClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure qReportAccount4PeriodBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportAccountPeriodForm: TReportAccountPeriodForm;

procedure DoReportAccount4Period;

implementation

uses IntecExportGrid;

{$R *.dfm}

procedure DoReportAccount4Period;
var ReportFrm : TReportAccountPeriodForm;
begin
  ReportFrm := TReportAccountPeriodForm.Create(Nil);
  try
    // Заполнение списка "Лиц.счет"
    with ReportFrm do begin
      qAccounts.Open;
      qAccounts.First;
      while not qAccounts.EOF do
      begin
        //список первых дат
        cbAccounts1.Items.Add(qAccounts.FieldByName('YEAR_MONTH').AsString);
        qAccounts.Next;
      end;
      qAccounts.Close;
      //список вторых дат
      cbAccounts2.Items.Assign(cbAccounts1.Items);

      if cbAccounts1.Items.Count > 0 then
      begin
        cbAccounts1.ItemIndex := 0;
        cbAccounts2.ItemIndex := 0;
        qReportAccount4Period.Open;
      end;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

//выгрузка в excel
procedure TReportAccountPeriodForm.btLoadInExcelClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Информация о счетах за период','',
      gAccount4Period, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAccountPeriodForm.btRefreshClick(Sender: TObject);
begin
  if cbAccounts1.Items.Count > 0 then
  begin
    if cbAccounts1.ItemIndex < cbAccounts2.ItemIndex then
    begin
      ShowMessage('Начальный период должен быть меньше или равен конечному!');
      Exit;
    end;
      //cbAccounts1.ItemIndex := cbAccounts2.ItemIndex;
    qReportAccount4Period.Close;
    qReportAccount4Period.Open;
  end
  else
    ShowMessage('Нет ни одного отчета за период!');
end;

procedure TReportAccountPeriodForm.qReportAccount4PeriodBeforeOpen(
  DataSet: TDataSet);
begin
  qReportAccount4Period.ParamByName('pYEAR_MONTH1').AsInteger := StrToInt(cbAccounts1.Text);
  qReportAccount4Period.ParamByName('pYEAR_MONTH2').AsInteger := StrToInt(cbAccounts2.Text);
end;

end.
