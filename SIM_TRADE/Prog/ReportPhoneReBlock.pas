unit ReportPhoneReBlock;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, IntecExportGrid, ShowUserStat;

type
  TReportPhoneReBlockForm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbAccounts: TComboBox;
    cbSearch: TCheckBox;
    PageControl1: TPageControl;
    tsReBlock: TTabSheet;
    ReBlockGrd: TCRDBGrid;
    tsReBlockQueue: TTabSheet;
    ReBlockQueueGrid: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qReBlock: TOraQuery;
    dsReBlock: TDataSource;
    qReBlockQueue: TOraQuery;
    dsReBlockQueue: TDataSource;
    qReBlockPHONE_NUMBER: TStringField;
    qReBlockDATE_ACTIV: TDateTimeField;
    qReBlockDATE_CREATED: TDateTimeField;
    qReBlockTICKED_UNLOCK_ID: TStringField;
    qReBlockDATE_UNLOCK: TDateTimeField;
    qReBlockTICKED_LOCK_ID: TStringField;
    qReBlockDATE_LOCK: TDateTimeField;
    qReBlockERROR_STR: TStringField;
    qReBlockLOGIN: TStringField;
    qReBlockQueuePHONE_NUMBER: TStringField;
    qReBlockQueueDATE_ACTIV: TDateTimeField;
    qReBlockQueueDATE_CREATED: TDateTimeField;
    qReBlockQueueTICKED_UNLOCK_ID: TStringField;
    qReBlockQueueDATE_UNLOCK: TDateTimeField;
    qReBlockQueueTICKED_LOCK_ID: TStringField;
    qReBlockQueueDATE_LOCK: TDateTimeField;
    qReBlockQueueERROR_STR: TStringField;
    qReBlockQueueLOGIN: TStringField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure tsReBlockShow(Sender: TObject);
    procedure tsReBlockQueueShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(const PhoneNumber : String; Modal : Boolean);
  end;

var
  ReportPhoneReBlockForm: TReportPhoneReBlockForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TReportPhoneReBlockForm.Execute(const PhoneNumber : String; Modal: Boolean);
var Sdvig:integer;
begin
  PageControl1.ActivePageIndex:=0;
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
      qReBlock.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
      qReBlockQueue.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
    end
    else begin
      qReBlock.ParamByName('ACCOUNT_ID').Clear;
      qReBlockQueue.ParamByName('ACCOUNT_ID').Clear;
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
    qReBlock.ParamByName('ACCOUNT_ID').Clear;
    qReBlockQueue.ParamByName('ACCOUNT_ID').Clear;
  end;
  qReBlock.Open;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;

procedure TReportPhoneReBlockForm.tsReBlockQueueShow(Sender: TObject);
begin
  qReBlockQueue.Close;
  qReBlockQueue.Open;
end;

procedure TReportPhoneReBlockForm.tsReBlockShow(Sender: TObject);
begin
  qReBlock.Close;
  qReBlock.Open;
end;

procedure TReportPhoneReBlockForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if PageControl1.ActivePageIndex = 1 then
      ExportDBGridToExcel('Очередь на переблокировку','', ReBlockQueueGrid, False)
    else
      if PageControl1.ActivePageIndex = 0 then
        ExportDBGridToExcel('Список переблокированных номеров','', ReBlockGrd, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhoneReBlockForm.aRefreshExecute(Sender: TObject);
begin
  qReBlock.Close;
  qReBlock.Open;
  qReBlockQueue.Close;
  qReBlockQueue.Open;
end;

procedure TReportPhoneReBlockForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReBlock.Active and (qReBlock.RecordCount > 0) then
  begin
   if PageControl1.ActivePageIndex=0 then
     ShowUserStatByPhoneNumber(qReBlock.FieldByName('PHONE_NUMBER').AsString, 0);
   if PageControl1.ActivePageIndex=1 then
     ShowUserStatByPhoneNumber(qReBlockQueue.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportPhoneReBlockForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReBlock.ParamByName('ACCOUNT_ID').asInteger := Account;
    qReBlockQueue.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qReBlock.ParamByName('ACCOUNT_ID').Clear;
    qReBlockQueue.ParamByName('ACCOUNT_ID').Clear;
    aRefresh.Execute;
  end;
end;

procedure TReportPhoneReBlockForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    ReBlockGrd.OptionsEx:=ReBlockGrd.OptionsEx+[dgeSearchBar]
  else
    ReBlockGrd.OptionsEx:=ReBlockGrd.OptionsEx-[dgeSearchBar];
  if cbSearch.Checked then
    ReBlockQueueGrid.OptionsEx:=ReBlockQueueGrid.OptionsEx+[dgeSearchBar]
  else
    ReBlockQueueGrid.OptionsEx:=ReBlockQueueGrid.OptionsEx-[dgeSearchBar];
end;

end.
