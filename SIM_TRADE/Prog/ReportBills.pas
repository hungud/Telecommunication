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
    pAccounts: TPanel;
    lPeriod: TLabel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportSimTrade: TOraQuery;
    qCorpMobileDilerPay: TOraQuery;
    qCorpMobileDilerPayACCOUNT_ID: TFloatField;
    qCorpMobileDilerPayYEAR_MONTH: TFloatField;
    qCorpMobileDilerPayPHONE_NUMBER: TStringField;
    qCorpMobileDilerPayKOMISSIYA_SUM: TFloatField;
    qCorpMobileDilerPaySUM_NO_NDS: TFloatField;
    qGsmCorpDiler: TOraQuery;
    cbBadBills: TCheckBox;
    pButton: TPanel;
    btCheckAll: TButton;
    btUnCheckAll: TButton;
    qReportK7: TOraQuery;
    Panel1: TPanel;
    pPeriod: TPanel;
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
    if GetConstantValue('SERVER_NAME')='SIM_TRADE' then
    begin
      qReport.SQL:=qReportSimTrade.SQL;
     // grData.Columns[4].Destroy;
      FiledNum := 4;
      grData.Columns[FiledNum].Title.Caption:='Тарифный код';
      grData.Columns[FiledNum].Width:=100;
      grData.Columns[FiledNum].FieldName:='TARIFF_CODE';
      //-----//
      FiledNum := 3;
      grData.Columns[FiledNum].Title.Caption:='Сумма для комиссии';
      grData.Columns[FiledNum].Width:=100;
      grData.Columns[FiledNum].FieldName:='KOMISSIYA';
      qReport.ParamByName('SHOW_BAD').AsInteger:=0;
      cbBadBills.Checked:=false;
      cbBadBills.Show;
      cbBadBills.Enabled:=true;
      qReport.FetchAll:=true;
    end;
    if GetConstantValue('SERVER_NAME')='GSM_CORP' then
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
    end;
    if TypeReport='KOMISSIYA' then
      if GetConstantValue('SERVER_NAME')='CORP_MOBILE' then
      begin
        qReport.SQL:=qCorpMobileDilerPay.SQL;
        grData.Columns[4].Destroy;
        grData.Columns[3].Destroy;
        grData.Columns[2].Destroy;
        grData.Columns[1].Title.Caption:='Комиссия без НДС';
        grData.Columns[1].Width:=120;
        grData.Columns[1].FieldName:='SUM_NO_NDS';
      end;
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
      if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
      begin
        lAccount.Show;
        pAccounts.Visible := True;
        chcbAccountList := TacCheckComboBox.Create(nil);
        chcbAccountList.Align := alNone;
        chcbAccountList.Left := 76;
        chcbAccountList.Height := 21;
        chcbAccountList.Width := 198;
        chcbAccountList.Top := 3;
        chcbAccountList.Visible := True;
        chcbAccountList.Parent := pAccounts;
        chcbAccountList.Show;

        qAccounts.Open;
        while not qAccounts.EOF do
        begin
          Item := (chcbAccountList.Items.Add as TCheckListItem);
          Item.Caption := qAccounts.FieldByName('ACCOUNT_NUMBER').AsString + ' - ' + qAccounts.FieldByName('COMPANY_NAME').AsString;
          Item.AddObject(TObject(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
          qAccounts.Next;
        end;
        qAccounts.Close;
        {
        if cbAccounts.Items.Count > 0 then
          cbAccounts.ItemIndex := 0;
        qReport.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
        }
      end else
      begin
        pAccounts.Visible := False;
        lPeriod.Parent := pPeriod;
        cbPeriod.Parent := pPeriod;
        lPeriod.Top := cbSearch.Top;
        cbPeriod.Top := cbSearch.Top - 2;
        lPeriod.Left := 3;
        cbPeriod.Left := lPeriod.Left + lPeriod.Width + 4;
        pPeriod.Visible := True;

        {
        Sdvig:= chcbAccountList.Left + chcbAccountList.Width;
        lAccount.Hide;
        //chcbAccountList.Hide;
        btLoadInExcel.Left:=btLoadInExcel.Left-Sdvig;
        btRefresh.Left:=btRefresh.Left-Sdvig;
        btInfoAbonent.Left:=btInfoAbonent.Left-Sdvig;
        cbSearch.Left:=cbSearch.Left-Sdvig;
        lPeriod.Left:=lPeriod.Left-Sdvig;
        cbPeriod.Left:=cbPeriod.Left-Sdvig;
        cbBadBills.Left:=cbBadBills.Left-Sdvig;
        }
        qReport.ParamByName('ACCOUNT_ID').Clear;
      end;
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
      qReport.SQL.Text := qReportK7.SQL.Text;
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
