unit ReportMNRoaming;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Data.DB, MemDS, DBAccess,
  Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  ExecutingForm;

type
  TfReportMNRoaming = class(TExecutingForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbAccounts: TComboBox;
    GridReport: TCRDBGrid;
    qReport: TOraQuery;
    dsReport: TDataSource;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReportSUBSCR_NO: TStringField;
    qReportPROV_NAME: TStringField;
    qReportSUM_CALL: TFloatField;
    qReportSUM_SMS: TFloatField;
    qReportSUM_MMS: TFloatField;
    qReportSUM_INTERNET: TFloatField;
    qReportTemplate: TOraQuery;
    qPeriod: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    { Private declarations }
  public
  end;


implementation

{$R *.dfm}

uses IntecExportGrid, StrUtils, ShowUserStat;

procedure TfReportMNRoaming.aExcelExecute(Sender: TObject);
var
  cr : TCursor;
  MM_YYYY : string;
  YYYTMM : string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    YYYTMM := cbPeriod.Text;
    MM_YYYY := Copy(YYYTMM, 5, 2) + ' ' + Copy(YYYTMM, 1, 4);
    ExportDBGridToExcel('Отчёт по "Международный роуминг" за  ' + MM_YYYY,'', GridReport, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfReportMNRoaming.aRefreshExecute(Sender: TObject);
var
  MM_YYYY : string;
  YYYTMM : string;
  is_collector : Integer;
begin
  if cbPeriod.ItemIndex > -1 then
  begin
    qReport.Close;
    YYYTMM := cbPeriod.Text;
    MM_YYYY := Copy(YYYTMM, 5, 2) + '_' + Copy(YYYTMM, 1, 4);
    qReport.SQL.Text := AnsiReplaceStr(qReportTemplate.SQL.Text , '%MM_YYYY%', MM_YYYY);
    qReport.ParamByName('YEAR_MONTH').AsInteger := StrToInt(YYYTMM);

    case cbAccounts.ItemIndex of
      0 : //все номера
        is_collector := -1;
      1 : //коллекторские номера
          is_collector := 1;
      2 : //номера К7
          is_collector := 0;
    else
       //все номера
        is_collector := -1;
    end;

    qReport.ParamByName('is_collector').AsInteger := is_collector;

    qReport.Open;
  end
  else
    ShowMessage('Нет периодов, доступных для выгрузки!');

end;

procedure TfReportMNRoaming.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('SUBSCR_NO').AsString, 0);
end;

procedure TfReportMNRoaming.FormCreate(Sender: TObject);
begin

  cbPeriod.Items.Clear;
  qPeriod.Close;
  qPeriod.Open;

  qPeriod.First;

  while not qPeriod.Eof do
  begin
    cbPeriod.Items.Add( qPeriod.FieldByName('yyyymm').AsString);
    qPeriod.Next;
  end;

  qPeriod.Close;

  if cbPeriod.Items.Count > 0 then
    cbPeriod.ItemIndex := 0;
end;

end.
