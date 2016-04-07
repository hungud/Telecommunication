unit ReportPhoneForUnblockSave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, StdCtrls, Buttons, ExtCtrls, ActnList, DB,
  MemDS, DBAccess, Ora;

type
  TReportPhoneForUnblockSaveForm = class(TForm)
    qReport: TOraQuery;
    dsReport: TDataSource;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbAccounts: TComboBox;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    RGmethod: TRadioGroup;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(Modal : Boolean);
  end;

var
  ReportPhoneForUnblockSaveForm: TReportPhoneForUnblockSaveForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, ShowUserStat, IntecExportGrid;

procedure TReportPhoneForUnblockSaveForm.aExcelExecute(Sender: TObject);
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

procedure TReportPhoneForUnblockSaveForm.aRefreshExecute(Sender: TObject);
begin
case Self.RGmethod.ItemIndex of
0:     self.qReport.SQL.Text:='SELECT * '+            //Старый метод-полный пересчёт
  'from V_PHONE_NUMBER_FOR_UNBL_SAVE '+
  'WHERE ((:ACCOUNT_ID IS NULL) OR (ACCOUNT_ID=:ACCOUNT_ID))';
1:     self.qReport.SQL.Text:='SELECT * '+            //Пересчёт балансов, быстрый подбор тарифа
   'from V_PHONE_NUMBER_FOR_UNBL_SAVE_2 '+
   'WHERE ((:ACCOUNT_ID IS NULL)OR(ACCOUNT_ID=:ACCOUNT_ID))';
2:     self.qReport.SQL.Text:='SELECT * '+            //Пересчёт баланса, только для платежей за 3 дн.
   'from V_PHONE_NUMBER_FOR_UNBL_SAVE_3 '+
   'WHERE ((:ACCOUNT_ID IS NULL)OR(ACCOUNT_ID=:ACCOUNT_ID))';
end;

  qReport.Close;
  qReport.Open;
end;

procedure TReportPhoneForUnblockSaveForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportPhoneForUnblockSaveForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qReport.ParamByName('ACCOUNT_ID').Clear;
    aRefresh.Execute;
  end;
end;

procedure TReportPhoneForUnblockSaveForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhoneForUnblockSaveForm.Execute(Modal: Boolean);
var Sdvig:integer;
begin
  if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
  begin
    lAccount.Show;
    cbAccounts.Show;
    cbAccounts.Items.AddObject('Все', Pointer(0));
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
      qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
    else
      qReport.ParamByName('ACCOUNT_ID').Clear;
  end else
  begin
    Sdvig:=BitBtn1.Left;
    lAccount.Hide;
    cbAccounts.Hide;
    BitBtn1.Left:=BitBtn1.Left-Sdvig;
    BitBtn2.Left:=BitBtn2.Left-Sdvig;
    BitBtn3.Left:=BitBtn3.Left-Sdvig;
    cbSearch.Left:=cbSearch.Left-Sdvig;
    qReport.ParamByName('ACCOUNT_ID').Clear;
  end;
 //qReport.Open;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;


end.
