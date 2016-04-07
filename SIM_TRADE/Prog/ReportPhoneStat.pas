unit ReportPhoneStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls;

type
  TReportPhoneStatFrm = class(TForm)
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
    Label1: TLabel;
    cbPeriod: TComboBox;
    Label2: TLabel;
    cbOperatorNames: TComboBox;
    qOperators: TOraQuery;
    Label3: TLabel;
    eFilter: TEdit;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    qFastPeriods: TOraQuery;
    qFastOperators: TOraQuery;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qReportAfterOpen(DataSet: TDataSet);
    procedure cbOperatorNamesChange(Sender: TObject);
    procedure eFilterChange(Sender: TObject);
    procedure grDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure PHONE_NUMBER_OnGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure AfterPrintReport(const Book: IDispatch);
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportPhoneStat;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, Excel2000;

procedure DoReportPhoneStat;
var ReportFrm : TReportPhoneStatFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportPhoneStatFrm.Create(Nil);
  try
    // Период

    // 01.11.12 г. А. Пискунов вместо выбора из представления
    // используем выбор из таблицы для ускорения выборки

   { ReportFrm.qPeriods.Open;
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
      ReportFrm.cbPeriod.ItemIndex := 0;  }

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

    // Операторы
    {ReportFrm.cbOperatorNames.Items.Add('Все');
    ReportFrm.qOperators.Open;
    while not ReportFrm.qOperators.EOF do
    begin
      ReportFrm.cbOperatorNames.Items.Add(
        ReportFrm.qOperators.FieldByName('OPERATOR_NAME').AsString
        );
      ReportFrm.qOperators.Next;
    end;
    ReportFrm.qOperators.Close;
    if ReportFrm.cbOperatorNames.Items.Count > 0 then
      ReportFrm.cbOperatorNames.ItemIndex := 0;}

    ReportFrm.cbOperatorNames.Items.Add('Все');
    ReportFrm.qFastOperators.Open;
    while not ReportFrm.qFastOperators.EOF do
    begin
      ReportFrm.cbOperatorNames.Items.Add(
        ReportFrm.qFastOperators.FieldByName('OPERATOR_NAME').AsString
        );
      ReportFrm.qFastOperators.Next;
    end;
    ReportFrm.qFastOperators.Close;
    if ReportFrm.cbOperatorNames.Items.Count > 0 then
      ReportFrm.cbOperatorNames.ItemIndex := 0;

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
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex]);
    end else
    begin
      Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      ReportFrm.lAccount.Hide;
      ReportFrm.cbAccounts.Hide;
      ReportFrm.BitBtn1.Left:=ReportFrm.BitBtn1.Left-Sdvig;
      ReportFrm.BitBtn2.Left:=ReportFrm.BitBtn2.Left-Sdvig;
      ReportFrm.BitBtn3.Left:=ReportFrm.BitBtn3.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.Label1.Left:=ReportFrm.Label1.Left-Sdvig;
      ReportFrm.Label2.Left:=ReportFrm.Label2.Left-Sdvig;
      ReportFrm.Label3.Left:=ReportFrm.Label3.Left-Sdvig;
      ReportFrm.cbOperatorNames.Left:=ReportFrm.cbOperatorNames.Left-Sdvig;
      ReportFrm.cbPeriod.Left:=ReportFrm.cbPeriod.Left-Sdvig;
      ReportFrm.eFilter.Left:=ReportFrm.eFilter.Left-Sdvig;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;
    // Обновим.
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportPhoneStatFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportPhoneStatFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по детализации за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      grData, AfterPrintReport, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhoneStatFrm.AfterPrintReport(const Book : IDispatch);
var
  Workbook : _Workbook;
  s : _WorkSheet;
  LastRow : Integer;
  LastRowStr : String;
  SumRowStr : String;
  c : Char;
begin
  // Нужно расставить объединения в заголовке отчёта
  Workbook := Book As _Workbook;
  s := Workbook.Sheets[1] As _WorkSheet;

  // Добавим строку после заголовка
  s.Range['4:4', EmptyParam].Insert(xlDown);

  // Сделаем объединения в заголовках
  s.Range['A3:A4', EmptyParam].MergeCells := True;
  s.Range['B3:B4', EmptyParam].MergeCells := True;
  s.Range['C3:C4', EmptyParam].MergeCells := True;
  s.Range['D3:D4', EmptyParam].MergeCells := True;
  s.Range['E3:E4', EmptyParam].MergeCells := True;
  s.Range['F3:F4', EmptyParam].MergeCells := True;
  s.Range['R3:R4', EmptyParam].MergeCells := True;


  s.Range['G3', EmptyParam].Value := 'Бесплатных';
  s.Range['H3', EmptyParam].Value := '';
  s.Range['G3:H3', EmptyParam].MergeCells := True;
  s.Range['G4', EmptyParam].Value := 'минут';
  s.Range['H4', EmptyParam].Value := 'звонков';

  s.Range['I3', EmptyParam].Value := 'Платных';
  s.Range['J3', EmptyParam].Value := '';
  s.Range['K3', EmptyParam].Value := '';
  s.Range['I3:K3', EmptyParam].MergeCells := True;
  s.Range['I4', EmptyParam].Value := 'минут';
  s.Range['J4', EmptyParam].Value := 'звонков';
  s.Range['K4', EmptyParam].Value := 'стоимость';

  s.Range['L3', EmptyParam].Value := 'SMS';
  s.Range['M3', EmptyParam].Value := '';
  s.Range['L3:M3', EmptyParam].MergeCells := True;
  s.Range['L4', EmptyParam].Value := 'кол-во';
  s.Range['M4', EmptyParam].Value := 'стоимость';

  s.Range['N3', EmptyParam].Value := 'MMS';
  s.Range['O3', EmptyParam].Value := '';
  s.Range['N3:O3', EmptyParam].MergeCells := True;
  s.Range['N4', EmptyParam].Value := 'кол-во';
  s.Range['O4', EmptyParam].Value := 'стоимость';

  s.Range['P3', EmptyParam].Value := 'Интернет';
  s.Range['Q3', EmptyParam].Value := '';
  s.Range['P3:Q3', EmptyParam].MergeCells := True;
  s.Range['P4', EmptyParam].Value := 'М/Б';
  s.Range['Q4', EmptyParam].Value := 'стоимость';

  // Заморозим заголовок.
  s.Range['A5', EmptyParam].Select;
  Workbook.Windows[1].FreezePanes := True;

  // ИТОГИ.
  LastRow := qReport.RecordCount+4;
  LastRowStr := IntToStr(LastRow);
  SumRowStr := IntToStr(LastRow+1);
//  s.Range['C'+SumRowStr, EmptyParam].Formula := '=SUM(C5:C'+LastRowStr+')';
  for c := 'D' to 'R' do
    if c <> 'E' then
      s.Range[c+SumRowStr, EmptyParam].Formula := '=SUM('+c+'5:'+c+LastRowStr+')';
  s.Range['B'+SumRowStr, EmptyParam].Value := 'ИТОГО:';
  s.Range[SumRowStr+':'+SumRowStr, EmptyParam].Font.Bold := True;

{  s.Range['', EmptyParam].MergeCells := True;
  s.Range['', EmptyParam].MergeCells := True;
  s.Range['', EmptyParam].MergeCells := True;
  s.Range['', EmptyParam].MergeCells := True;
  s.Range['', EmptyParam].MergeCells := True;
  s.Range['', EmptyParam].MergeCells := True;}
//  for
end;

procedure TReportPhoneStatFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportPhoneStatFrm.cbPeriodChange(Sender: TObject);
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

procedure TReportPhoneStatFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhoneStatFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

procedure TReportPhoneStatFrm.qReportAfterOpen(DataSet: TDataSet);
begin
  // пока отключили форматирование номера - посмотрим, будет ли удобно.
//  DataSet.FieldByName('PHONE_NUMBER').OnGetText := PHONE_NUMBER_OnGetText;

grData.Columns.Items[2].SortOrder:=soAsc;

end;

procedure TReportPhoneStatFrm.PHONE_NUMBER_OnGetText(Sender: TField; var Text: string;
    DisplayText: Boolean);
begin
  // пока отключили форматирование номера - посмотрим, будет ли удобно.
//  Text := FormatPhoneNumber(Sender.AsString);
end;

procedure TReportPhoneStatFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0
    then qReport.ParamByName('ACCOUNT_ID').asInteger := Account
    else qReport.ParamByName('ACCOUNT_ID').Clear;
 //   aRefresh.Execute;
end;

procedure TReportPhoneStatFrm.cbOperatorNamesChange(Sender: TObject);
var
  OperatorName : String;
begin
  if cbOperatorNames.ItemIndex > 0 then
    OperatorName := cbOperatorNames.Items[cbOperatorNames.ItemIndex]
  else
    OperatorName := '';
  qReport.ParamByName('OPERATOR_NAME').AsString := OperatorName;
  //aRefresh.Execute;
end;

procedure TReportPhoneStatFrm.eFilterChange(Sender: TObject);
var
  FilterText : String;
begin
  FilterText := eFilter.Text;
  if FilterText <> '' then
  begin
    qReport.Filter := 'PHONE_NUMBER LIKE ''%' + FilterText + '%''';
    qReport.Filtered := True;
  end
  else
    qReport.Filtered := False;
end;

procedure TReportPhoneStatFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE V_REPORT_PHONE_STAT.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TReportPhoneStatFrm.grDataKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = chr(VK_BACK) then
  begin
    eFilter.Text := Copy(eFilter.Text, 1, Length(eFilter.Text)-1);
    Key := #0;
    eFilterChange(eFilter);
  end
  else if Key in ['0'..'9'] then
  begin
    eFilter.Text := eFilter.Text + Key;
    Key := #0;
    eFilterChange(eFilter);
  end;
end;

end.
