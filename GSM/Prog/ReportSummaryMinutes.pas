unit ReportSummaryMinutes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls;

type
  TReportSummaryMinutesFrm = class(TForm)
    qReport: TOraQuery;
    DataSource1: TDataSource;
    grData: TCRDBGrid;
    Panel1: TPanel;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    qPeriods: TOraQuery;
    dsPeriods: TDataSource;
    Label1: TLabel;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    qFastPeriods: TOraQuery;
    cbAllPhones: TCheckBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbAllPhonesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportSummaryMinutes;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils;

procedure DoReportSummaryMinutes;
var ReportFrm : TReportSummaryMinutesFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportSummaryMinutesFrm.Create(Nil);
  try

    // 01.11.12 г. А. Пискунов вместо выбора из представления
    // используем выбор из таблицы для ускорения выборки

    ReportFrm.qFastPeriods.Open;
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
      ReportFrm.cbPeriod.ItemIndex := 0;

    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportSummaryMinutesFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.ParamByName('ACCOUNT_ID').Clear;
  qReport.Open;
end;

procedure TReportSummaryMinutesFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт о бесплатных минутах за ' + cbPeriod.Text,'', grData, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportSummaryMinutesFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportSummaryMinutesFrm.cbAllPhonesClick(Sender: TObject);
begin
  if cbAllPhones.Checked
    then qReport.SQL[0]:='SELECT * FROM V_REPORT_SUMMARY_MINUTES_2 V'
    else qReport.SQL[0]:='SELECT * FROM V_REPORT_SUMMARY_MINUTES V';
  aRefresh.Execute;
end;

procedure TReportSummaryMinutesFrm.cbPeriodChange(Sender: TObject);
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

procedure TReportSummaryMinutesFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportSummaryMinutesFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Insert(3, 'AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE V.ACCOUNT_ID = AC.ACCOUNT_ID)');
  end;
end;

procedure TReportSummaryMinutesFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

end.
