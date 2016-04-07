unit UnBlockList_Ivideon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, MemDS, DBAccess, Ora, CRGrid, StdCtrls, Buttons,
  ExtCtrls, ShowUserStat, IntecExportGrid, ActnList;

type
  TUnBlockListFrm_Ivideon = class(TForm)
    qUnblockList: TOraQuery;
    dsUnblockList: TDataSource;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    cbPhoneForUnBlock: TCheckBox;
    AbonentForUnBlockGrid: TCRDBGrid;
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
    procedure Execute(const Abonent: integer; Modal: Boolean);
  end;


implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TUnBlockListFrm_Ivideon.Execute(const Abonent : integer; Modal: Boolean);
var Sdvig:integer;
begin
    AbonentForUnBlockGrid.Show;
  if Abonent = 0 then
    qUnBlockList.ParamByName('ABONENT').Clear
  else
    qUnBlockList.ParamByName('ABONENT').AsInteger := Abonent;
  qUnBlockList.Open;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;

procedure TUnBlockListFrm_Ivideon.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
      ExportDBGridToExcel('Список блока и разблока','', AbonentForUnBlockGrid, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TUnBlockListFrm_Ivideon.aRefreshExecute(Sender: TObject);
begin
    qUnblockList.Close;
    qUnblockList.Open;
end;

procedure TUnBlockListFrm_Ivideon.aShowUserStatInfoExecute(Sender: TObject);
begin
//  if cbPhoneForUnBlock.Checked then
//    if qPhonesForUnBlock.Active and (qPhonesForUnBlock.RecordCount > 0) then
//      ShowUserStatByPhoneNumber(qPhonesForUnBlock.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0)
//  else
//    if qUnblockList.Active and (qUnblockList.RecordCount > 0) then
//      ShowUserStatByPhoneNumber(qUnblockList.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TUnBlockListFrm_Ivideon.cbPhoneForUnBlockClick(Sender: TObject);
begin
//  if cbPhoneForUnBlock.Checked then
//  begin
//    UnBlockListGrd.Hide;
//    PhoneForUnBlockGrid.Show;
//    qPhonesForUnBlock.Open;
//  end
//  else
//  begin
//    UnBlockListGrd.Show;
//    PhoneForUnBlockGrid.Hide;
//    qPhonesForUnBlock.Close;
//  end;
end;

procedure TUnBlockListFrm_Ivideon.cbSearchClick(Sender: TObject);
begin
    if cbSearch.Checked then
      AbonentForUnBlockGrid.OptionsEx:=AbonentForUnBlockGrid.OptionsEx+[dgeSearchBar]
    else
      AbonentForUnBlockGrid.OptionsEx:=AbonentForUnBlockGrid.OptionsEx-[dgeSearchBar];
end;

procedure TUnBlockListFrm_Ivideon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TUnBlockListFrm_Ivideon.FormCreate(Sender: TObject);
begin
//  if MainForm.FUseFilialBlockAccess then
//  begin
//    qUnblockList.SQL.Insert(19, 'AND ' + IntToStr(MainForm.FFilial)
//     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
//     + 'WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = AC.ACCOUNT_ID)');
//  end;
end;

end.
