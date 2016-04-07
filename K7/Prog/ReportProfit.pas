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
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    qFastPeriods: TOraQuery;
    CheckBox1: TCheckBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure qReportBeforeOpen(DataSet: TDataSet);
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

    if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
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
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));    // 31.10.12 А. Пискунов
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex]);
    end
    else
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
    end;
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

procedure TReportProfitFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account
    //  aRefresh.Execute;
  end
  else
    qReport.ParamByName('ACCOUNT_ID').Clear;     // 31.10.12 А. Пискунов
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

procedure TReportProfitFrm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked
    then qReport.SQL[4]:= '   FROM V_PROFIT_BY_PH_YEAR_WITH_PAYM MV,'
    else qReport.SQL[4]:= '   FROM MV_PROFIT_BY_PHONES_YEAR MV,';
end;

procedure TReportProfitFrm.FormCreate(Sender: TObject);
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
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE MV.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TReportProfitFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

procedure TReportProfitFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  if CheckBox1.Checked
    then qReport.SQL[4]:= '   FROM V_PROFIT_BY_PH_YEAR_WITH_PAYM MV,'
    else qReport.SQL[4]:= '   FROM MV_PROFIT_BY_PHONES_YEAR MV,';
end;

end.
