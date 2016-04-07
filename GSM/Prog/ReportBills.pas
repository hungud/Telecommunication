unit ReportBills;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, ActnList, aceCheckComboBox;

type
  TReportBillsForm = class(TForm)
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qCorpMobileDilerPay: TOraQuery;
    qCorpMobileDilerPayACCOUNT_ID: TFloatField;
    qCorpMobileDilerPayYEAR_MONTH: TFloatField;
    qCorpMobileDilerPayPHONE_NUMBER: TStringField;
    qCorpMobileDilerPayKOMISSIYA_SUM: TFloatField;
    qCorpMobileDilerPaySUM_NO_NDS: TFloatField;
    qGsmCorpDiler: TOraQuery;
    cbBadBills: TCheckBox;
    pButton: TPanel;
    Panel1: TPanel;
    pPeriod: TPanel;
    lPeriod: TLabel;
    cbPeriod: TComboBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure grDataCellClick(Column: TColumn);
    procedure cbBadBillsClick(Sender: TObject);
    procedure btCheckAllClick(Sender: TObject);
    procedure btUnCheckAllClick(Sender: TObject);
  private
    chcbAccountList : TacCheckComboBox;
    procedure SetItemsState (State : Boolean);
  public
    { Public declarations }
  end;

var
  ReportBillsForm: TReportBillsForm;

procedure DoReportBills(TypeReport:string);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat,
  ExportGridToExcelPDF;

procedure DoReportBills(TypeReport:string);
var ReportFrm : TReportBillsForm;
    Sdvig:integer;
    Item : TCheckListItem;
    FiledNum : Integer;
begin
  ReportFrm := TReportBillsForm.Create(Nil);
  ReportFrm.cbBadBills.Hide;

  with ReportFrm do
  begin
    qReport.SQL:=qGsmCorpDiler.SQL;
    //qReport.SQLUpdate:=qGsmCorpDiler.SQLUpdate;
    FiledNum := 5;
    grData.Columns.Add;
    grData.Columns[FiledNum].Title.Caption:='Дилерам';
    grData.Columns[FiledNum].Title.Alignment:=taCenter;
    grData.Columns[FiledNum].Title.Font.Style:=[fsBold];
    grData.Columns[FiledNum].Width:=100;
    grData.Columns[FiledNum].FieldName:='DILER';
    {grData.Columns.Add;
    Inc(FiledNum);
    grData.Columns[FiledNum.Title.Caption:='Проверен';
    grData.Columns[FiledNum].Title.Alignment:=taCenter;
    grData.Columns[FiledNum].Title.Font.Style:=[fsBold];
    grData.Columns[FiledNum].Width:=100;
    grData.Columns[FiledNum].FieldName:='BILL_CHECKED';
    }
    Inc(FiledNum);
    grData.Columns.Add;
    grData.Columns[FiledNum].Title.Caption:='Баланс со счетом';
    grData.Columns[FiledNum].Title.Alignment:=taCenter;
    grData.Columns[FiledNum].Title.Font.Style:=[fsBold];
    grData.Columns[FiledNum].Width:=100;
    grData.Columns[FiledNum].FieldName:='BALANCE_FULL_BILLS';
    grData.Columns.Add;
    Inc(FiledNum);
    grData.Columns[FiledNum].Title.Caption:='Тариф';
    grData.Columns[FiledNum].Title.Alignment:=taCenter;
    grData.Columns[FiledNum].Title.Font.Style:=[fsBold];
    grData.Columns[FiledNum].Width:=150;
    grData.Columns[FiledNum].FieldName:='TARIFF_NAME';

    try
      // Период
      qPeriods.Open;
      while not qPeriods.EOF do
      begin
        cbPeriod.Items.AddObject(
          qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
          TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
          );
        qPeriods.Next;
      end;
      qPeriods.Close;
      if cbPeriod.Items.Count > 0 then
        cbPeriod.ItemIndex := 0;
      qReport.ParamByName('ACCOUNT_ID').Clear;

      // Отчет
      cbPeriodChange(cbPeriod);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TReportBillsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  if qReport.Active then
  begin

    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      //ExportDBGridToExcel2(ReportBillsForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      //  grData, nil, False, True);
      ExportDBGrid(ReportBillsForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'','Счета_'+cbPeriod.Text, grData, True, True);
    finally
      Screen.Cursor := cr;
    end;
  end
  else
    ShowMessage('Нет данных для выгрузки!!!');
end;

procedure TReportBillsForm.aRefreshExecute(Sender: TObject);
var
  CheckedItemCount : Integer;
  strCheckedAccountId : String;
  i: Integer;
begin
{  qReport.Close;
  qReport.Open;
}
  qReport.Close;
  if chcbAccountList <> nil then
  begin
    if chcbAccountList.Text <> '' then
    begin
      strCheckedAccountId := '';
      CheckedItemCount := 0;

      for i := 0 to chcbAccountList.Items.Count - 1 do
      begin
        if TCheckListItem(chcbAccountList.Items.Items[i]).Checked then
        begin
          strCheckedAccountId := strCheckedAccountId + IntToStr(Integer(TCheckListItem(chcbAccountList.Items.Items[i]).GetObject)) + ',';
          Inc(CheckedItemCount);
        end;
      end;
      strCheckedAccountId := Copy( strCheckedAccountId, 1, Length(strCheckedAccountId) - 1);


      if CheckedItemCount <> chcbAccountList.Items.Count  then
        qReport.SQL.Add('AND V1.ACCOUNT_ID IN (' + strCheckedAccountId + ')');

      qReport.SQL.Add('ORDER BY DOXOD ASC');

      qReport.Open;
    end;
  end
  else
    qReport.Open;
end;

procedure TReportBillsForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportBillsForm.btCheckAllClick(Sender: TObject);
begin
  SetItemsState(True);
  chcbAccountList.Text := 'Все счета';
end;

procedure TReportBillsForm.btUnCheckAllClick(Sender: TObject);
begin
  SetItemsState(False);
  chcbAccountList.Text := '';
end;

procedure TReportBillsForm.cbBadBillsClick(Sender: TObject);
begin
  if cbBadBills.Checked
    then qReport.ParamByName('SHOW_BAD').AsInteger:=1
    else qReport.ParamByName('SHOW_BAD').AsInteger:=0;
  aRefresh.Execute;
end;

procedure TReportBillsForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('YEAR_MONTH').AsInteger := Period;
 // aRefresh.Execute;
end;

procedure TReportBillsForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;


procedure TReportBillsForm.grDataCellClick(Column: TColumn);
begin
  if Column.FieldName='BILL_CHECKED' then
  begin
    qReport.Edit;
    qReport.FieldByName('BILL_CHECKED').AsInteger:=1-qReport.FieldByName('BILL_CHECKED').AsInteger;
    if not((qReport.FieldByName('BILL_CHECKED').AsInteger=0)
            or (qReport.FieldByName('BILL_CHECKED').AsInteger=1)) then
      qReport.FieldByName('BILL_CHECKED').AsInteger:=0;
    qReport.Post;
  end;
end;

procedure TReportBillsForm.SetItemsState(State: Boolean);
var
  i : Integer;
begin
  for i := 0 to chcbAccountList.Items.Count - 1 do
    TCheckListItem(chcbAccountList.Items.Items[i]).Checked := State;
end;

end.
