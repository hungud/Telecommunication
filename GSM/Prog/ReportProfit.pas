unit ReportProfit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls;

type
  TReportProfitFrm = class(TForm)
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
    qOtherReport: TOraQuery;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportProfit;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils;

procedure DoReportProfit;
var ReportFrm : TReportProfitFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportProfitFrm.Create(Nil);
  try

    // 01.11.12 г. А. Пискунов вместо выбора из представления
    // используем выбор из таблицы для ускорения выборки

    {ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('BILL_YEAR').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('BILL_YEAR').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;

    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0; }

    ReportFrm.qFastPeriods.Open;
    while not ReportFrm.qFastPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qFastPeriods.FieldByName('BILL_YEAR').AsString,
        TObject(ReportFrm.qFastPeriods.FieldByName('BILL_YEAR').AsInteger)
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

procedure TReportProfitFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportProfitFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт о доходности за ' + cbPeriod.Text + ' год.','', grData, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportProfitFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;

procedure TReportProfitFrm.cbPeriodChange(Sender: TObject);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('BILL_YEAR').AsInteger := Period;
 // aRefresh.Execute;
end;

procedure TReportProfitFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportProfitFrm.FormCreate(Sender: TObject);
var
  FiledNum : Integer;
  procedure InsertCol(ColName: string; FiledName : String; ColIndex : Integer; ColWidth : Integer);
  begin
    grData.Columns.Insert(ColIndex);
    grData.Columns[ColIndex].Title.Caption := ColName;
    grData.Columns[ColIndex].Title.Alignment := taCenter;
    grData.Columns[ColIndex].Title.Font.Style := [fsBold];
    grData.Columns[ColIndex].Width := ColWidth;
    grData.Columns[ColIndex].FieldName:= FiledName;
  end;
begin
  qReport.SQL.Text := qOtherReport.SQL.Text;

  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE MV.ACCOUNT_ID = AC.ACCOUNT_ID)');
  end;
end;

procedure TReportProfitFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

end.
