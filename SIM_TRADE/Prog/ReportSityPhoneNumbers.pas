unit ReportSityPhoneNumbers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, Buttons, ExtCtrls, DB, MemDS, DBAccess, Ora,
  Grids, DBGrids, CRGrid;

type
  TReportSityPhoneNumbersForm = class(TForm)
    qSityNumbers: TOraQuery;
    dsSityNumbers: TDataSource;
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbAccounts: TComboBox;
    cbSearch: TCheckBox;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    grData: TCRDBGrid;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(Modal : Boolean);
  end;

var
  ReportSityPhoneNumbersForm: TReportSityPhoneNumbersForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat, Main;

procedure TReportSityPhoneNumbersForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Список заблокированных номеров','', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportSityPhoneNumbersForm.aRefreshExecute(Sender: TObject);
begin
  qSityNumbers.Close;
  qSityNumbers.Open;
end;

procedure TReportSityPhoneNumbersForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qSityNumbers.Active and (qSityNumbers.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qSityNumbers.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportSityPhoneNumbersForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qSityNumbers.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qSityNumbers.ParamByName('ACCOUNT_ID').Clear;
    aRefresh.Execute;
  end;
end;

procedure TReportSityPhoneNumbersForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

procedure TReportSityPhoneNumbersForm.Execute(Modal: Boolean);
var Sdvig:integer;
begin
  if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
  begin
    lAccount.Show;
    cbAccounts.Show;
    cbAccounts.Items.AddObject('Все', Pointer(0));
    cbAccounts.Items.AddObject('Без договора', Pointer(-1));
    qAccounts.Open;
    while not qAccounts.EOF do
    begin
      cbAccounts.Items.AddObject(
        qAccounts.FieldByName('LOGIN').AsString,
        Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
      qAccounts.Next;
    end;
    qAccounts.Close;
    if cbAccounts.Items.Count > 0 then
      cbAccounts.ItemIndex := 0;
    if Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])>0 then
      qSityNumbers.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
    else
      qSityNumbers.ParamByName('ACCOUNT_ID').Clear;
  end else
  begin
    Sdvig:=BitBtn1.Left;
    lAccount.Hide;
    cbAccounts.Hide;
    BitBtn1.Left:=BitBtn1.Left-Sdvig;
    BitBtn2.Left:=BitBtn2.Left-Sdvig;
    BitBtn3.Left:=BitBtn3.Left-Sdvig;
    cbSearch.Left:=cbSearch.Left-Sdvig;
    qSityNumbers.ParamByName('ACCOUNT_ID').Clear;
  end;
  qSityNumbers.ParamByName('DAYS').AsInteger:=30;
  qSityNumbers.ParamByName('CONSERVATION').Clear;
  qSityNumbers.ParamByName('SYSTEM_BLOCK').Clear;
  qSityNumbers.ParamByName('PHONE_IS_ACTIVE').AsInteger:=0;
  qSityNumbers.Open;
  try
    if Modal then
      ShowModal
    else
      FormStyle := fsMDIChild;
  finally
    Close;
  end;
end;

procedure TReportSityPhoneNumbersForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qSityNumbers.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE V_SITY_PHONE_NUMBER.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

end.
