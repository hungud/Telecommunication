unit ShowUserStat_IVIDEON;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, CRGrid, ExtCtrls, MemDS, DBAccess, Ora,
  StdCtrls, ActnList, DBCtrls, Mask, Main, Buttons, ComCtrls,
  EditAbonentFrame, VirtualTable, sMaskEdit, sCustomComboEdit,
  sTooledit, math, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP,
  IdMessage,IdCoderHeader,IdCoderMime, IdCoder, IdCoder3to4, IdAttachmentFile,
  Menus, sBitBtn, DateUtils,ReportReplaceSIM, sCheckBox, ExportGridToExcelPDF,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  dmShowUserStat;

type

  TShowUserIvideonForm = class(TForm)
    dsAbonentStatus: TDataSource;
    qAbonentStatus: TOraQuery;
    dsAbonentInfo: TDataSource;
    qAbonentInfo: TOraQuery;
    dsTariffInfo_IV: TDataSource;
    qTariffInfo_IV: TOraQuery;
    dsPayment: TDataSource;
    qPayment: TOraQuery;
    PageControl1: TPageControl;
    tsTariffs: TTabSheet;
    Panel8: TPanel;
    gPhoneStatuses: TCRDBGrid;
    Panel15: TPanel;
    Panel6: TPanel;
    Label13: TLabel;
    DBText13: TDBText;
    LblState: TLabel;
    lTariffStatusText: TLabel;
    Panel14: TPanel;
    Panel19: TPanel;
    pBalanceInfo: TPanel;
    lBalance: TLabel;
    LblBalance: TLabel;
    pTariffInfoButton: TPanel;
    BtUnBlock: TButton;
    UnBlockListBt: TButton;
    tsPayments: TTabSheet;
    PageControl2: TPageControl;
    tsPaymentsReal: TTabSheet;
    Panel7: TPanel;
    gPayments: TCRDBGrid;
    MonthCalendar1: TMonthCalendar;
    qBalance: TOraQuery;
    procedure LblBlueOff(Sender: TObject);
    procedure LblBlueOn(Sender: TObject);
    procedure UnBlockListBtClick(Sender: TObject);
    procedure LblBalanceClick(Sender: TObject);
  private
    { Private declarations }
    FAbonent: integer;
  public
    { Public declarations }
    procedure Execute(const pAbonent : integer);
  end;

var
  ShowUserIvideonForm: TShowUserIvideonForm;

  procedure ShowUserStatAbonent(const pAbonent : integer; const PageName : String = '');

implementation

{$R *.dfm}
uses UnBlockList_Ivideon, ShowBillDetails;

procedure TShowUserIvideonForm.Execute(const pAbonent : integer);
var IsAdmin: boolean;
    balance: double;
    atext: string;
    afontColor: integer;
begin
  // Опредение прав(админ или нет)
  MainForm.CheckAdminPrivs(IsAdmin);
  qAbonentInfo.ParamByName('ABONENT_ID').AsInteger := pAbonent;
  qAbonentInfo.Open;
  //pAbonent_ID := qAbonentInfo.FieldByName('ABONENT_ID').AsInteger;
  FAbonent := pAbonent;
  qTariffInfo_IV.ParamByName('ABONENT_ID').AsInteger := pAbonent;
  qTariffInfo_IV.Open;
  qBalance.ParamByName('ABONENT_ID').AsInteger := pAbonent;
  qBalance.Open;
   // Статус
  if qTariffInfo_IV.EOF then
  begin
    AText := 'Нет данных';
    AFontColor := clWindowText;
  end
  else if qTariffInfo_IV.FieldByName('ACTION_TYPE_ID').AsInteger = 1 then
  begin
    AText := 'Блокирован';
    AFontColor := clRed;
  end
  else
  begin
    AText := 'Активный';
    AFontColor := clGreen;
  end;
  lTariffStatusText.Caption := AText;
  lTariffStatusText.Font.Color := AFontColor;

  // Баланс
  if qBalance.EOF then
  begin
    AText := '???';
    AFontColor := clWindowText;
  end
  else
  begin
    Balance := qBalance.FieldByName('BALANCE').AsFloat;
    AText := FloatToStrF(Balance, ffNumber, 15, 2);
    if Balance  < 0 then
      AFontColor := clRed
    else
      AFontColor := clWindowText;
  end;
  lBalance.Caption := AText;
  lBalance.Font.Color := AFontColor;
  // Платежи
  qPayment.ParamByName('ABONENT_ID').AsInteger := pAbonent;
  qPayment.Open;
  //
  qAbonentStatus.ParamByName('ABONENT_ID').AsInteger := pAbonent;
  qAbonentStatus.Open;

  PageControl1.ActivePage:=tsTariffs;

  //
  try
    ShowModal;
  finally
    qAbonentStatus.Close;
    qPayment.Close;
    qTariffInfo_IV.Close;
    qBalance.Close;
  end;
end;

procedure DoShowUserStat(const pAbonent : integer; const PageName : String = '');
var
  ShowUserStatForm: TShowUserIvideonForm;
 // AdminPriv : boolean;
begin
  try
    ShowUserStatForm := TShowUserIvideonForm.Create(nil);
  //  MainForm.CheckAdminPrivs(AdminPriv);
    ShowUserStatForm.Execute(pAbonent);
    finally
      ShowUserStatForm.Free;
  end;
end;

procedure ShowUserStatAbonent(const pAbonent : integer;
  const PageName : String = '');
begin
  if pAbonent = 0 then
    MessageDlg('Не возможно показать информацию абонента.', mtError, [mbOK], 0)
  else
    DoShowUserStat(pAbonent, PageName);
end;

procedure TShowUserIvideonForm.LblBlueOn(Sender: TObject);
begin
  (sender as TLabel).Font.Color := clblue;
end;

procedure TShowUserIvideonForm.LblBlueOff(Sender: TObject);
begin
  (sender as TLabel).font.color:=clblack;
end;

procedure TShowUserIvideonForm.UnBlockListBtClick(Sender: TObject);
var
  RefFrm : TUnBlockListFrm_Ivideon;
begin
  RefFrm := TUnBlockListFrm_Ivideon.Create(Application);
  try
    RefFrm.Execute(FAbonent, True);
  finally
    FreeAndNil(RefFrm);
  end;
end;

procedure TShowUserIvideonForm.LblBalanceClick(Sender: TObject);
  procedure Pclose(sender:TObject);
   begin
    (sender as TForm).ModalResult:=mrOk;
    //sender.Destroy;
  end;
var fList:TForm;
    Mcloselsit:TMethod;
    qBH:TOraQuery;
    dsBH:TDataSource;
    tBH:TDBGrid;
begin
  flist:=tform.Create(ShowBillDetailsForm);
  with flist do begin
    //  FormStyle:=fsMDIChild;
    BorderStyle:=bsSingle;
    Caption:='История баланса по абоненту '+InttoStr(FAbonent);
    Position:=poScreenCenter;
    Width:=450;
    Height:=350;
  end;
  qBH:=TOraQuery.Create(flist);
  with qBH do begin
    params.CreateParam(ftInteger,'abonent',ptInput);
    params.ParamByName('abonent').Value:=FAbonent;
    sql.Add('select AB.HISTORY_DATE,AB.AMOUNT, AB.BALANCE_AFTER from IVIDEON.ABONENT_BALANCE_HISTORY AB, IVIDEON.IVIDEON_ABONENTS IA where IA.ABONENT_ID = :ABONENT AND AB.ABONENT_ID = IA.ABONENT_ID');
  end;
  dsBH:=TDataSource.Create(flist);
  with dsBH do begin
    DataSet:=qBH;
    Enabled:=true;
  end;
  tBH:=TDBGrid.Create(flist);
  with tBH do begin
    parent:=fList;
    DataSource:=dsBH;
    align:=alClient;
    Visible:=true;
    Mcloselsit.Code:=@pclose;
    Mcloselsit.Data:=tBH.parent;
    ReadOnly:=true;
    OnDblClick:=TNotifyEvent(Mcloselsit);
  end;
  try
    qBH.open;
  finally
    tbh.Columns.Items[0].Title.caption:='Дата списания';
    tbh.Columns.Items[1].Title.caption:='Сумма списания';
    tbh.Columns.Items[2].Title.caption:='Баланс после списания';
   // tbh.Columns.Items[3].Title.caption:='Баланс';
    if not qbh.Eof then
    begin
    fList.ShowModal;
    end else
    begin
      ShowMessage('Нет данных.');
      flist.Destroy;
    end;
  end;
end;

end.
