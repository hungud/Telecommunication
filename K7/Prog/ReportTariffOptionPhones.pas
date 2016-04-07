unit ReportTariffOptionPhones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, StdCtrls, Buttons, ExtCtrls, DB, MemDS,
  DBAccess, Ora, ActnList;

type
  TReportTariffOptionPhonesForm = class(TForm)
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qTariffOptions: TOraQuery;
    qPhones: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    Panel1: TPanel;
    lTariffOptions: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    cbTariffOptions: TComboBox;
    TarOptMonthsGrid: TCRDBGrid;
    qReportOPTION_CODE: TStringField;
    qReportYEAR_MONTH: TStringField;
    qReportCOUNT_OPTION: TFloatField;
    TarOptPhonesGrid: TCRDBGrid;
    Splitter1: TSplitter;
    dsPhones: TDataSource;
    qPhonesPHONE_NUMBER: TStringField;
    qPhonesTURN_ON_DATE: TDateTimeField;
    qPhonesTURN_OFF_DATE: TDateTimeField;
    qPhonesLAST_CHECK_DATE_TIME: TDateTimeField;
    qPhonesSTATUS: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbTariffOptionsChange(Sender: TObject);
    procedure dsReportDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportTariffOptionPhones;

var
  ReportTariffOptionPhonesForm: TReportTariffOptionPhonesForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

procedure DoReportTariffOptionPhones;
var ReportFrm : TReportTariffOptionPhonesForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportTariffOptionPhonesForm.Create(Nil);
  try
    ReportFrm.qTariffOptions.Open;
    while not ReportFrm.qTariffOptions.EOF do
    begin
      ReportFrm.cbTariffOptions.Items.AddObject(
        ReportFrm.qTariffOptions.FieldByName('OPTION_CODE').AsString + ' - ' +
          ReportFrm.qTariffOptions.FieldByName('OPTION_NAME').AsString,
        Pointer(ReportFrm.qTariffOptions.FieldByName('OPTION_CODE').AsString)
        );
      ReportFrm.qTariffOptions.Next;
    end;
    ReportFrm.qTariffOptions.Close;
    if ReportFrm.cbTariffOptions.Items.Count > 0 then
      ReportFrm.cbTariffOptions.ItemIndex := 0;
    if ReportFrm.cbTariffOptions.ItemIndex >= 0 then
      ReportFrm.qReport.ParamByName('OPTION_CODE').AsString:=
        //AnsiString(cbTariffOptions.Items.Objects[cbTariffOptions.ItemIndex])
        copy(ReportFrm.cbTariffOptions.Items[ReportFrm.cbTariffOptions.ItemIndex], 1,
          Pos(' - ', ReportFrm.cbTariffOptions.Items[ReportFrm.cbTariffOptions.ItemIndex]) - 1)
    else
      ReportFrm.qReport.ParamByName('OPTION_CODE').Clear;
    // Отчет
  //  ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportTariffOptionPhonesForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Список номеров с подключенной услугой '
      + qReport.ParamByName('OPTION_CODE').AsString + ' за '
      + Copy(qPhones.ParamByName('YEAR_MONTH').AsString, 1, 4) + ' - '
      + Copy(qPhones.ParamByName('YEAR_MONTH').AsString, 5, 2), '',
      TarOptPhonesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportTariffOptionPhonesForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportTariffOptionPhonesForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qPhones.Active and (qPhones.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qPhones.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportTariffOptionPhonesForm.cbTariffOptionsChange(Sender: TObject);
begin
  if cbTariffOptions.ItemIndex >= 0 then
    qReport.ParamByName('OPTION_CODE').AsString:=
      //AnsiString(cbTariffOptions.Items.Objects[cbTariffOptions.ItemIndex])
      copy(cbTariffOptions.Items[cbTariffOptions.ItemIndex], 1,
        Pos(' - ', cbTariffOptions.Items[cbTariffOptions.ItemIndex]) - 1)
  else
    qReport.ParamByName('OPTION_CODE').Clear;
  aRefresh.Execute;
end;

procedure TReportTariffOptionPhonesForm.dsReportDataChange(Sender: TObject;
  Field: TField);
var Month: string;
begin
  qPhones.ParamByName('OPTION_CODE').AsString:=qReport.FieldByName('OPTION_CODE').AsString;
  Month:=qReport.FieldByName('YEAR_MONTH').AsString;
  Month:=Copy(Month, 1, 4)+Copy(Month, 8, Length(Month) - 7);
  qPhones.ParamByName('YEAR_MONTH').AsString:=Month;
  qPhones.Close;
  qPhones.Open;
end;

end.
