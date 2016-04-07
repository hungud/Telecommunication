unit ReportAntiFraudBlocked;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls;

type
  TAntiFraudBlockedFrm = class(TForm)
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
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);

    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportAntiFraudBlocked;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils;

procedure DoReportAntiFraudBlocked;
var ReportFrm : TAntiFraudBlockedFrm;
    Sdvig:integer;
begin
  ReportFrm := TAntiFraudBlockedFrm.Create(Nil);
  try
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').Asinteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
  ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TAntiFraudBlockedFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TAntiFraudBlockedFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчет о номерах блокированных по подозрению в мошеничестве за ' + cbPeriod.Text,'', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TAntiFraudBlockedFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;



procedure TAntiFraudBlockedFrm.cbPeriodChange(Sender: TObject);
var
  Period : integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').Asinteger := Period;
  aRefresh.Execute;
end;

procedure TAntiFraudBlockedFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TAntiFraudBlockedFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;



end.
