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
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
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
  end;
end;

end.
