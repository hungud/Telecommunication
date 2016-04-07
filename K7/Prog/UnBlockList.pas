unit UnBlockList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, MemDS, DBAccess, Ora, CRGrid, StdCtrls, Buttons,
  ExtCtrls, ShowUserStat, IntecExportGrid, ActnList;

type
  TUnBlockListFrm = class(TForm)
    qUnblockList: TOraQuery;
    dsUnblockList: TDataSource;
    UnBlockListGrd: TCRDBGrid;
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
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    PhoneForUnBlockGrid: TCRDBGrid;
    cbPhoneForUnBlock: TCheckBox;
    dsPhonesForUnBlock: TDataSource;
    qPhonesForUnBlock: TOraQuery;
    qPhonesForUnBlockLOGIN: TStringField;
    qPhonesForUnBlockPHONE_NUMBER_FEDERAL: TStringField;
    qPhonesForUnBlockBALANCE: TFloatField;
    qPhonesForUnBlockDISCONNECT_LIMIT: TFloatField;
    qPhonesForUnBlockFIO: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbPhoneForUnBlockClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(const PhoneNumber: String; Modal: Boolean);
  end;


implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TUnBlockListFrm.Execute(const PhoneNumber : String; Modal: Boolean);
var Sdvig:integer;
begin
  if cbPhoneForUnBlock.Checked then
  begin
    UnBlockListGrd.Hide;
    PhoneForUnBlockGrid.Show;
  end
  else
  begin
    UnBlockListGrd.Show;
    PhoneForUnBlockGrid.Hide;
  end;
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
    if Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])>0 then begin
      qUnBlockList.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
      qPhonesForUnBlock.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
    end
    else begin
      qUnBlockList.ParamByName('ACCOUNT_ID').Clear;
      qPhonesForUnBlock.ParamByName('ACCOUNT_ID').Clear;
    end;
  end else
  begin
    Sdvig:=BitBtn1.Left;
    lAccount.Hide;
    cbAccounts.Hide;
    BitBtn1.Left:=BitBtn1.Left-Sdvig;
    BitBtn2.Left:=BitBtn2.Left-Sdvig;
    BitBtn3.Left:=BitBtn3.Left-Sdvig;
    cbSearch.Left:=cbSearch.Left-Sdvig;
    qUnBlockList.ParamByName('ACCOUNT_ID').Clear;
  end;
  if PhoneNumber = '' then
    qUnBlockList.ParamByName('PHONE_NUMBER').Clear
  else
    qUnBlockList.ParamByName('PHONE_NUMBER').AsString := PhoneNumber;
  qUnBlockList.Open;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;

procedure TUnBlockListFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if cbPhoneForUnBlock.Checked then
      ExportDBGridToExcel('Список номеров для разблокировки','', PhoneForUnBlockGrid, False)
    else
      ExportDBGridToExcel('Список разблокированных номеров','', UnBlockListGrd, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TUnBlockListFrm.aRefreshExecute(Sender: TObject);
begin
  if cbPhoneForUnBlock.Checked then
  begin
    qPhonesForUnBlock.Close;
    qPhonesForUnBlock.Open;
  end else
  begin
    qUnblockList.Close;
    qUnblockList.Open;
  end;
end;

procedure TUnBlockListFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if cbPhoneForUnBlock.Checked then
    if qPhonesForUnBlock.Active and (qPhonesForUnBlock.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qPhonesForUnBlock.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0)
  else
    if qUnblockList.Active and (qUnblockList.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qUnblockList.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TUnBlockListFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qUnblockList.ParamByName('ACCOUNT_ID').asInteger := Account;
    qPhonesForUnBlock.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qUnblockList.ParamByName('ACCOUNT_ID').Clear;
    qPhonesForUnBlock.ParamByName('ACCOUNT_ID').Clear;
    aRefresh.Execute;
  end;
end;

procedure TUnBlockListFrm.cbPhoneForUnBlockClick(Sender: TObject);
begin
  if cbPhoneForUnBlock.Checked then
  begin
    UnBlockListGrd.Hide;
    PhoneForUnBlockGrid.Show;
    qPhonesForUnBlock.Open;
  end
  else
  begin
    UnBlockListGrd.Show;
    PhoneForUnBlockGrid.Hide;
    qPhonesForUnBlock.Close;
  end;
end;

procedure TUnBlockListFrm.cbSearchClick(Sender: TObject);
begin
  if cbPhoneForUnBlock.Checked then
    if cbSearch.Checked then
      PhoneForUnBlockGrid.OptionsEx:=PhoneForUnBlockGrid.OptionsEx+[dgeSearchBar]
    else
      PhoneForUnBlockGrid.OptionsEx:=PhoneForUnBlockGrid.OptionsEx-[dgeSearchBar]
  else
    if cbSearch.Checked then
      UnBlockListGrd.OptionsEx:=UnBlockListGrd.OptionsEx+[dgeSearchBar]
    else
      UnBlockListGrd.OptionsEx:=UnBlockListGrd.OptionsEx-[dgeSearchBar];
end;

procedure TUnBlockListFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TUnBlockListFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qUnblockList.SQL.Insert(19, 'AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

end.
