unit BlockList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, MemDS, DBAccess, Ora, CRGrid, IntecExportGrid,
  StdCtrls, Buttons, ExtCtrls, ShowUserStat, ActnList, ComCtrls;

type
  TBlockListFrm = class(TForm)
    dsBlockList: TDataSource;
    qBlockList: TOraQuery;
    BlockListGrd: TCRDBGrid;
    Panel1: TPanel;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    PhoneForBlockGrid: TCRDBGrid;
    qPhonesForBlock: TOraQuery;
    dsPhonesForBlock: TDataSource;
    qPhonesForBlockLOGIN: TStringField;
    qPhonesForBlockPHONE_NUMBER_FEDERAL: TStringField;
    qPhonesForBlockBALANCE: TFloatField;
    qPhonesForBlockBALANCE_BLOCK: TFloatField;
    qPhonesForBlockDISCONNECT_LIMIT: TFloatField;
    qPhonesForBlockIS_CREDIT_CONTRACT: TIntegerField;
    qPhonesForBlockFIO: TStringField;
    PageControl1: TPageControl;
    tsAllPhoneBlock: TTabSheet;
    tsBlockPhoneNoContract: TTabSheet;
    PhoneNoContGrid: TCRDBGrid;
    dsPhoneNoContract: TDataSource;
    qPhoneNoContract: TOraQuery;
    qPhoneNoContractACCOUNT_NUMBER: TFloatField;
    qPhoneNoContractPHONE_NUMBER: TStringField;
    qPhoneNoContractBLOCK_DATE_TIME: TDateTimeField;
    qPhoneNoContractMANUAL_BLOCK: TFloatField;
    qPhoneNoContractUSER_NAME: TStringField;
    qPhoneNoContractNOTE: TStringField;
    tsPhoneForBlock: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure tsBlockPhoneNoContractShow(Sender: TObject);
    procedure tsPhoneForBlockShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(const PhoneNumber : String; Modal : Boolean);
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

{ TBlockListFrm }

procedure TBlockListFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if PageControl1.ActivePageIndex = 2 then
      ExportDBGridToExcel('Список номеров для блокировки','', PhoneForBlockGrid, False)
    else
      if PageControl1.ActivePageIndex = 1 then
        ExportDBGridToExcel('Список заблокированных номеров без контракта','', PhoneNoContGrid, False)
      else
        if PageControl1.ActivePageIndex = 0 then
          ExportDBGridToExcel('Список заблокированных номеров','', BlockListGrd, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TBlockListFrm.aRefreshExecute(Sender: TObject);
begin
  qBlockList.Close;
  qBlockList.Open;
end;

procedure TBlockListFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qBlockList.Active and (qBlockList.RecordCount > 0) then
  begin
   if PageControl1.ActivePageIndex=0 then
     ShowUserStatByPhoneNumber(qBlockList.FieldByName('PHONE_NUMBER').AsString, 0);
   if PageControl1.ActivePageIndex=1 then
     ShowUserStatByPhoneNumber(qPhoneNoContract.FieldByName('PHONE_NUMBER').AsString, 0);
   if PageControl1.ActivePageIndex=2 then
     ShowUserStatByPhoneNumber(qPhonesForBlock.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TBlockListFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    BlockListGrd.OptionsEx:=BlockListGrd.OptionsEx+[dgeSearchBar]
  else
    BlockListGrd.OptionsEx:=BlockListGrd.OptionsEx-[dgeSearchBar];
end;

procedure TBlockListFrm.Execute(const PhoneNumber : String; Modal: Boolean);
var Sdvig:integer;
begin
  PageControl1.ActivePageIndex:=0;
  qBlockList.ParamByName('ACCOUNT_ID').Clear;
  qPhonesForBlock.ParamByName('ACCOUNT_ID').Clear;

  if PhoneNumber = '' then
    qBlockList.ParamByName('PHONE_NUMBER').Clear
  else
    qBlockList.ParamByName('PHONE_NUMBER').AsString := PhoneNumber;
  qBlockList.Open;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;

procedure TBlockListFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TBlockListFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qBlockList.SQL.Insert(25, 'AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = AC.ACCOUNT_ID)');
  end;
end;

procedure TBlockListFrm.tsBlockPhoneNoContractShow(Sender: TObject);
begin
  qPhoneNoContract.Close;
  qPhoneNoContract.Open;
end;

procedure TBlockListFrm.tsPhoneForBlockShow(Sender: TObject);
begin
  qPhonesForBlock.Close;
  qPhonesForBlock.Open;
end;

end.
