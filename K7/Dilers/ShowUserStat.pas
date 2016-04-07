unit ShowUserStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, CRGrid, ExtCtrls, MemDS, DBAccess, Ora,
  StdCtrls, ActnList, DBCtrls, Mask, Main, Buttons, ComCtrls,
  EditAbonentFrame, VirtualTable, AddDeposite;

type
  TShowUserStatForm = class(TForm)
    qPeriods: TOraQuery;
    Panel1: TPanel;
    CRDBGrid1: TCRDBGrid;
    dsPeriods: TDataSource;
    Splitter1: TSplitter;
    spGetPhoneDetail: TOraStoredProc;
    Panel2: TPanel;
    mDetailText: TMemo;
    Panel3: TPanel;
    Panel4: TPanel;
    ActionList1: TActionList;
    aSaveDetail: TAction;
    sdDetail: TSaveDialog;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    Label4: TLabel;
    DBText4: TDBText;
    Label5: TLabel;
    DBText5: TDBText;
    Label6: TLabel;
    DBText6: TDBText;
    Label7: TLabel;
    DBText7: TDBText;
    Label8: TLabel;
    DBText8: TDBText;
    Label9: TLabel;
    DBText9: TDBText;
    Label10: TLabel;
    DBText10: TDBText;
    Label11: TLabel;
    DBText11: TDBText;
    Label12: TLabel;
    DBText12: TDBText;
    Panel5: TPanel;
    btnClose: TBitBtn;
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    tsDetail: TTabSheet;
    tsAbonent: TTabSheet;
    EditAbonentFrame: TEditAbonentFrme;
    tsTariffs: TTabSheet;
    Panel6: TPanel;
    Label13: TLabel;
    DBText13: TDBText;
    qTariffInfo: TOraQuery;
    dsTariffInfo: TDataSource;
    DBText14: TDBText;
    DBText15: TDBText;
    DBText16: TDBText;
    Label14: TLabel;
    Label15: TLabel;
    DBText17: TDBText;
    Label16: TLabel;
    lTariffStatusText: TLabel;
    Label17: TLabel;
    lBalance: TLabel;
    CRDBGrid2: TCRDBGrid;
    Label19: TLabel;
    DBText18: TDBText;
    qOptions: TOraQuery;
    dsOptions: TDataSource;
    tsPayments: TTabSheet;
    Panel7: TPanel;
    qPayments: TOraQuery;
    dsPayments: TDataSource;
    gPayments: TCRDBGrid;
    tsBills: TTabSheet;
    CRDBGrid4: TCRDBGrid;
    qBills: TOraQuery;
    dsBills: TDataSource;
    tsOptions: TTabSheet;
    CRDBGrid5: TCRDBGrid;
    qBalanceRows: TOraQuery;
    dsBalanceRows: TDataSource;
    spCalcBalanceRows: TOraStoredProc;
    tsBalanceRows: TTabSheet;
    vtDetailFile: TVirtualTable;
    dbgDetail: TCRDBGrid;
    dsDetail: TDataSource;
    vtDetailFileSELF_NUMBER: TStringField;
    vtDetailFileSERVICE_DATE: TDateField;
    vtDetailFileSERVICE_TIME: TTimeField;
    vtDetailFileSERVICE_TYPE: TStringField;
    vtDetailFileSERVICE_DIRECTION: TStringField;
    vtDetailFileOTHER_NUMBER: TStringField;
    vtDetailFileDURATION: TFloatField;
    vtDetailFileSERVICE_COST: TFloatField;
    vtDetailFileIS_ROAMING: TStringField;
    vtDetailFileROAMING_ZONE: TStringField;
    vtDetailFileADD_INFO: TStringField;
    BitBtn2: TBitBtn;
    aOpenDetailInExcel: TAction;
    qServiceCodes: TOraQuery;
    qPhoneStatuses: TOraQuery;
    dsPhoneStatuses: TDataSource;
    Panel8: TPanel;
    gPhoneStatuses: TCRDBGrid;
    qPhoneStatusesPHONE_NUMBER: TStringField;
    qPhoneStatusesBEGIN_DATE: TDateTimeField;
    qPhoneStatusesEND_DATE: TDateTimeField;
    qPhoneStatusesPHONE_IS_ACTIVE: TIntegerField;
    qPhoneStatusesTARIFF_NAME: TStringField;
    LoaderUnBlockPhoneNum: TOraStoredProc;
    LoaderBlockPhoneNum: TOraStoredProc;
    BtUnBlock: TButton;
    BtBlock: TButton;
    qSelBalDate: TOraQuery;
    qHandBlock: TOraQuery;
    CbHandBlock: TCheckBox;
    qHandBlockStart: TOraQuery;
    BtSetPassword: TButton;
    BtSetPasswordOk: TButton;
    qPassword: TOraQuery;
    eSetPassword: TEdit;
    tsDeposit: TTabSheet;
    qDeposit: TOraQuery;
    qDepositOper: TOraQuery;
    qDepositCURRENT_DEPOSITE_VALUE: TFloatField;
    qDepositOperOPERATION_DATE_TIME: TDateTimeField;
    qDepositOperDEPOSITE_VALUE: TFloatField;
    lDepositValue: TLabel;
    lDepositOper: TLabel;
    qDepositOperOPERATOR_NAME: TStringField;
    qDepositOperNOTE: TStringField;
    dbDepositOper: TCRDBGrid;
    qContractID: TOraQuery;
    dsDepositOper: TDataSource;
    btAddDeposit: TBitBtn;
    dbtDepositValue: TDBText;
    dsDeposit: TDataSource;
    pPaymentsToolBar: TPanel;
    btnUsePayment: TButton;
    Button2: TButton;
    qContractInfo: TOraQuery;
    aLinkPayment: TAction;
    aUnlinkPayment: TAction;
    qLinkPayment: TOraQuery;
    qDiscount: TOraQuery;
    qDiscountIS_DISCOUNT_OPERATOR: TIntegerField;
    spSetDiscount: TOraStoredProc;
    tsDiscount: TTabSheet;
    dtpNewBeginDate: TDateTimePicker;
    qDiscountDISCOUNT_BEGIN_DATE: TDateTimeField;
    qDiscountDISCOUNT_VALIDITY: TFloatField;
    dbtEndDate: TDBText;
    qDiscountDISCOUNT_END_DATE: TDateTimeField;
    dsDiscount: TDataSource;
    dbtBeginDate: TDBText;
    qDiscountCHECKED: TStringField;
    lBegin: TLabel;
    lEnd: TLabel;
    btSetDiscount: TBitBtn;
    lDate: TLabel;
    lLength: TLabel;
    cbDiscount: TCheckBox;
    eLength: TDBEdit;
    dbtShowDateHB: TDBText;
    qHandBlockEndDate: TOraQuery;
    spSetHandBlockEndDate: TOraStoredProc;
    btSetHandBlockDateEnd: TBitBtn;
    dsHandBlockDate: TDataSource;
    emNewDateEnd: TMaskEdit;
    vtDetailFileBASE_STATION_CODE: TStringField;
    vtDetailFileCOST_NO_VAT: TFloatField;
    vtDetailFileBS_PLACE: TStringField;
    lBlockInfo: TLabel;
    tsContractInfo: TTabSheet;
    Label18: TLabel;
    DBText19: TDBText;
    Label20: TLabel;
    Label21: TLabel;
    DBText20: TDBText;
    DBMemo1: TDBMemo;
    dsContractInfo: TDataSource;
    btRefreshCI: TBitBtn;
    btPostComments: TBitBtn;
    qAccountNumber: TOraQuery;
    Label22: TLabel;
    DBText21: TDBText;

    procedure dsPeriodsDataChange(Sender: TObject; Field: TField);
    procedure aSaveDetailExecute(Sender: TObject);
    procedure dsTariffInfoDataChange(Sender: TObject; Field: TField);
    procedure CRDBGrid4GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure aOpenDetailInExcelExecute(Sender: TObject);
    procedure qPhoneStatusesPHONE_IS_ACTIVEGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qPaymentsPAYMENT_STATUS_TEXTGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qPaymentsCONTRACT_IDGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure BtBlockClick(Sender: TObject);
    procedure BtUnBlockClick(Sender: TObject);
    procedure CbHandBlockExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtSetPasswordClick(Sender: TObject);
    procedure BtSetPasswordOkClick(Sender: TObject);
    procedure eSetPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure btAddDepositClick(Sender: TObject);
    procedure tsDetailShow(Sender: TObject);
    procedure qPaymentsAfterOpen(DataSet: TDataSet);
    procedure aLinkPaymentExecute(Sender: TObject);
    procedure aUnlinkPaymentExecute(Sender: TObject);
    procedure cbDiscountClick(Sender: TObject);
    procedure btSetDiscountClick(Sender: TObject);
    procedure CbHandBlockClick(Sender: TObject);
    procedure btSetHandBlockDateEndClick(Sender: TObject);
    procedure spSetHandBlockEndDateAfterExecute(Sender: TObject;
      Result: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
    procedure btRefreshCIClick(Sender: TObject);
    procedure btPostCommentsClick(Sender: TObject);
    procedure CRDBGrid5CellClick(Column: TColumn);
  private
    FYear : Integer;
    FMonth : Integer;
    FDetailText : String;
    FPhoneNumber: String;
    FContractID: Integer;
    FContractDate : TDateTime;
    FHandBlockChecked: Boolean;
    FManualPaymentManagement : Boolean;
    FFilialId: Variant;
    procedure LoadDetailText;
    procedure PrepareDetail;
    procedure RefreshBalanceRows;
    function DecodeServiceType(const Code: String): String;
  public
    procedure Execute(const pPhoneNumber : String; const pContractID : Integer);
  end;

  // показать информацию абонента по коду контракта
//  procedure ShowUserStatByContract(const pContractId : Variant);
  // показать информацию абонента по номеру телефона
  procedure ShowUserStatByPhoneNumber(const pPhoneNumber : String; const vContractID : Integer; const PageName : String = '');

//  procedure DoShowUserStat(const pPhoneNumber : String; const pAbonentId : Variant);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, CRStrUtils,{ SelectContract, }
  ShowBillDetails;

const
  PAYMENT_TYPE_LOADED = 2; // Платёж загружен автоматически (из V_FULL_BALANCE_PAYMENTS.PAYMENT_TYPE)


// Дни до начала контракта, для которых нужно засчитывать платежи
// Это же значение используется в CALC_BALANCE_ROWS2
const DAYS_PAYMENT_BEFORE_CONTRACT = 4;

{ TShowUserStatForm }

procedure DoShowUserStat(const pPhoneNumber : String; const pContractId : Integer;
  const PageName : String = ''
  );
var
  ShowUserStatForm: TShowUserStatForm;
begin
  ShowUserStatForm := TShowUserStatForm.Create(nil);
  try
    if PageName = 'Payments' then
      ShowUserStatForm.PageControl1.ActivePage := ShowUserStatForm.tsPayments;
    ShowUserStatForm.qContractID.Close;
    ShowUserStatForm.qContractID.ParamByName('PHONE_NUMBER').AsString:=pPhoneNumber;
    ShowUserStatForm.qContractID.Open;
    if ShowUserStatForm.qContractID.IsEmpty then
    begin
      ShowMessage('Для данного номера не существует контрактов');
      ShowUserStatForm.Execute(pPhoneNumber, 0);
    end
    else begin
      if pContractId=0 then
        ShowUserStatForm.Execute(pPhoneNumber,ShowUserStatForm.qContractID.FieldByName('CONTRACT_ID').AsInteger)
      else
        ShowUserStatForm.Execute(pPhoneNumber, pContractId);
    end;
  finally
    ShowUserStatForm.Free;
  end;
end;

{
procedure ShowUserStatByContract(const pContractId : Variant);
var vPhoneNumber : String;
    vAbonentId : Variant;
begin
  if not FindPhoneAndAbonent(pContractID, vPhoneNumber, vAbonentId) then
    MessageDlg('Для договора с кодом '+VarToStr(pContractID)+' не найден действующий номер телефона, внутренняя ошибка.', mtError, [mbOK], 0)
  else
  begin
    // если тут оказались, значит номер телефона обязательно должен быть заполнен
    DoShowUserStat(vPhoneNumber, vAbonentId);
  end;
end;
}

procedure ShowUserStatByPhoneNumber(const pPhoneNumber : String;
  const vContractID : Integer;
  const PageName : String = '');
begin
  if pPhoneNumber = '' then
    MessageDlg('Не возможно показать информацию абонента. Код телефона не определен., внутренняя ошибка.', mtError, [mbOK], 0)
  else
    DoShowUserStat(pPhoneNumber,vContractID, PageName);
end;

procedure TShowUserStatForm.Execute(const pPhoneNumber : String; const pContractID : Integer);
begin
  eSetPassword.Hide;
  btSetPasswordOk.Hide;
  if GetConstantValue('ENABLE_INTERNET_KABINET') = '1' then
    btSetPassword.Show
  else
    btSetPassword.Hide;
  qContractInfo.ParamByName('CONTRACT_ID').AsInteger := pContractID;
  qContractInfo.Open;
  try
    if qContractInfo.IsEmpty then
    begin
      FContractDate := 0;
      FFilialId := Null;
    end
    else
    begin
      FContractDate := Trunc(qContractInfo.FieldByName('CONTRACT_DATE').AsDateTime);
      FFilialId := qContractInfo.FieldByName('FILIAL_ID').Value;
    end;
  finally
    qContractInfo.Close;
  end;
  FManualPaymentManagement := (GetConstantValue('MANUAL_LINK_PAYMENTS_ENABLED') = '1');
  pPaymentsToolBar.Visible := FManualPaymentManagement;

  if (GetConstantValue('USE_DEPOSITES') = '1')and(pContractID>0) then
  begin
    tsDeposit.TabVisible:=true;
    qDeposit.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
    qDeposit.Open;
    qDepositOper.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
    qDepositOper.Open;
  end
  else
    tsDeposit.TabVisible:=false;
  //
  Caption := Caption + ' ' + FormatPhoneNumber(pPhoneNumber);
  FPhoneNumber := pPhoneNumber;
  FContractID:=pContractID;
  //
  qSelBalDate.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  qSelBalDate.ParamByName('CONTRACT_ID').AsInteger := pContractID;
  qSelBalDate.Open;
  //
  if (pContractID<>0)and(GetConstantValue('HAND_BLOCK_IS_ROBOT_BLOCK')='1') then
  begin
    dbtShowDateHB.Visible:=true;
    emNewDateEnd.Visible:=false;
    btSetHandBlockDateEnd.Visible:=false;
    qHandBlockEndDate.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
    spSetHandBlockEndDate.ParamByName('PCONTRACT_ID').AsInteger:=pContractID;
    qHandBlockEndDate.Open;
    if (qHandBlockEndDate.FieldByName('HAND_BLOCK').AsInteger=1)
      and(qHandBlockEndDate.FieldByName('HAND_BLOCK_DATE_END').AsDateTime>Date) then
      FHandBlockChecked:=true
    else
      FHandBlockChecked:=false;
    cbHandBlock.Checked:=FHandBlockChecked;
  end else
  begin
    qHandBlockStart.Close;
    qHandBlockStart.ParamByName('CONTRACT_ID').AsInteger :=pContractID;
    qHandBlockStart.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
    qHandBlockStart.Open;
    if qHandBlockStart.IsEmpty then
      CbHandBlock.Visible:=false
    else
      begin
        qHandBlock.Close;
        qHandBlock.SQL.Clear;
        qHandBlock.SQL.Add('Select hand_block from v_contracts where Phone_Number_Federal='+pPhoneNumber+' and CONTRACT_ID='+VartoStr(pContractID));
        qHandBlock.Prepare;
        qHandBlock.Open;
        FHandBlockChecked := (qHandBlock.FieldByName('hand_block').AsInteger <> 0);
        CbHandBlock.Checked := FHandBlockChecked;
     end;
    qHandBlock.Close;
  end;
  //
  if pContractID=0 then
    EditAbonentFrame.PrepareFrameByContractID('DISABLE', 0)
  else
    EditAbonentFrame.PrepareFrameByContractID('VIEW', pContractID);
  //
  qTariffInfo.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  if qSelBalDate.FieldByName('contract_cancel_date').AsString='' then
    qTariffInfo.ParamByName('pBALANCE_DATE').Clear
  else
    qTariffInfo.ParamByName('pBALANCE_DATE').AsDateTime := qSelBalDate.FieldByName('contract_cancel_date').AsDateTime;
  qTariffInfo.Open;
  //
  qOptions.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  qOptions.Open;
  //
  qPassword.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
  //
  qPayments.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  qPayments.Open;
  //
  qBills.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  qBills.Open;
  //
  qPhoneStatuses.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
  qPhoneStatuses.Open;
  //
  if GetConstantValue('SHOW_OPERATOR_DISCOUNT') = '1' then
  begin
    tsDiscount.TabVisible:=true;
    spSetDiscount.ParamByName('PPHONE_NUMBER').AsString := pPhoneNumber;
    qDiscount.ParamByName('PHONE_NUMBER').AsString := pPhoneNumber;
    qDiscount.Open;
    if qDiscountIS_DISCOUNT_OPERATOR.AsInteger=1 then
      cbDiscount.Checked:=true
    else
      cbDiscount.Checked:=false;
  end
  else
    tsDiscount.TabVisible:=false;
  if GetConstantValue('SHOW_CONTRACT_INFO')='1' then
  begin
    tsContractInfo.TabVisible:=true;
    btPostComments.Enabled:=false;
    if pContractID=0 then
    begin
      Label20.Hide;
      Label21.Hide;
      Label22.Hide;
      DBText20.Hide;
      DBText21.Hide;
      DBMemo1.Hide;
      btRefreshCI.Hide;
      btPostComments.Hide;
      dsContractInfo.DataSet:=qAccountNumber;
      qAccountNumber.ParamByName('PHONE_NUMBER').AsString:=pPhoneNumber;
      qAccountNumber.Open;
    end
    else
      qContractInfo.Open;
  end
  else
    tsContractInfo.TabVisible:=false;
  //
  RefreshBalanceRows;
  //
  PageControl1.ActivePage:=tsTariffs;
  //
  try
    ShowModal;
  finally
    qBalanceRows.Close;
    qPhoneStatuses.Close;
    qBills.Close;
    qPayments.Close;
    qTariffInfo.Close;
    qOptions.Close;
    qPeriods.Close;
    qDeposit.Close;
    qDepositOper.Close;
    qDiscount.Close;
    qHandBlockEndDate.Close;
    qContractInfo.Close;
  end;
end;

procedure TShowUserStatForm.RefreshBalanceRows;
begin
  qBalanceRows.Close;
  spCalcBalanceRows.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
  spCalcBalanceRows.ParamByName('pBALANCE_DATE').Value := qSelBalDate.FieldByName('contract_cancel_date').Value;
  spCalcBalanceRows.ExecSQL;
  qBalanceRows.Open;
end;

procedure TShowUserStatForm.spSetHandBlockEndDateAfterExecute(Sender: TObject;
  Result: Boolean);
begin
  qHandBlockEndDate.Close;
  qHandBlockEndDate.Open;
  if (qHandBlockEndDate.FieldByName('HAND_BLOCK').AsInteger=1)
    and(qHandBlockEndDate.FieldByName('HAND_BLOCK_DATE_END').AsDateTime>=Date) then
    FHandBlockChecked:=true
  else
    FHandBlockChecked:=false;
  cbHandBlock.Checked:=FHandBlockChecked;
end;

procedure TShowUserStatForm.dsPeriodsDataChange(Sender: TObject;
  Field: TField);
var
  AYear, AMonth : Integer;
begin
  AYear := qPeriods.FieldByName('YEAR').AsInteger;
  AMonth := qPeriods.FieldByName('MONTH').AsInteger;
//  FPhoneNumber := qPeriods.FieldByName('PHONE_NUMBER').AsString;
  if (AYear <> FYear) or (FMonth <> AMonth) then
  begin
    FYear := AYear;
    FMonth := AMonth;
    LoadDetailText;
    PrepareDetail;
  end;
end;

procedure TShowUserStatForm.LoadDetailText;
var
  DetailText : String;
begin
  if True then
  begin
    spGetPhoneDetail.ParamByName('pYEAR').AsInteger := FYear;
    spGetPhoneDetail.ParamByName('pMONTH').AsInteger := FMonth;
    spGetPhoneDetail.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
    try
      spGetPhoneDetail.ExecProc;
      DetailText := spGetPhoneDetail.ParamByName('RESULT').AsString;
      FDetailText := DetailText;
    except
      on E : Exception do
      begin
        DetailText := 'Ошибка .'#13#10 + E.Message;
        FDetailText := '';
      end;
    end;
    mDetailText.Lines.Text := DetailText;
  end
  else
  begin // Для отладки !!!
    mDetailText.Lines.LoadFromFile('D:\Work\MobileTariff\Lontana\trunk\2.txt');
    FDetailText := mDetailText.Lines.Text;
  end;
end;

procedure TShowUserStatForm.DBMemo1Change(Sender: TObject);
begin
  btPostComments.Enabled:=true;
end;

function TShowUserStatForm.DecodeServiceType(const Code : String) : String;
begin
  if not qServiceCodes.Active then
    qServiceCodes.Open;
  if qServiceCodes.Locate('SERVICE_CODE', Code, []) then
    Result := qServiceCodes.FieldByName('SERVICE_NAME').AsString
  else
    Result := Code;
end;

procedure TShowUserStatForm.PrepareDetail;
var
  i : Integer;
  sl : TStringList;
  s : String;
  Line : String;
  CostNoVatStr: string;
begin
  try
  sl := TStringList.Create;
  vtDetailFile.DisableControls;
  try
    sl.Text := FDetailText;
    if not vtDetailFile.Active then
      vtDetailFile.Open
    else
      vtDetailFile.Clear;
    for i := 0 to sl.Count-1 do
    begin
      Line := sl[i];
      if GetTokenCount(Line) >= 11 then
      begin
        vtDetailFile.Append;
        vtDetailFile.FieldByName('SELF_NUMBER').AsString := Copy(GetToken(Line, 1), 1, 20);
        vtDetailFile.FieldByName('SERVICE_DATE').AsDateTime := StrToDate(GetToken(Line, 2));
        vtDetailFile.FieldByName('SERVICE_TIME').AsDateTime := StrToTime(GetToken(Line, 3));
        vtDetailFile.FieldByName('SERVICE_TYPE').AsString := DecodeServiceType(GetToken(Line, 4));
        s := GetToken(Line, 5);
        if s = '1' then
          s := 'Исходящий'
        else if s = '2' then
          s := 'Входящий'
        else if s = '3' then
          s := 'переадресация'
        else
          s := 'Неопределено';
        vtDetailFile.FieldByName('SERVICE_DIRECTION').AsString := s;
        vtDetailFile.FieldByName('OTHER_NUMBER').AsString := Copy(GetToken(Line, 6), 1, 20);
        vtDetailFile.FieldByName('DURATION').AsFloat := StrToFloat2(GetToken(Line, 7));
        vtDetailFile.FieldByName('SERVICE_COST').AsFloat := StrToFloat2(GetToken(Line, 8));
        if GetToken(Line, 9) = '1' then
          s := 'Да'
        else
          s := '';
        vtDetailFile.FieldByName('IS_ROAMING').AsString := s;
        vtDetailFile.FieldByName('ROAMING_ZONE').AsString := Copy(GetToken(Line, 10), 1, 50);
        vtDetailFile.FieldByName('ADD_INFO').AsString := Copy(GetToken(Line, 11), 1, 100);
        vtDetailFile.FieldByName('BASE_STATION_CODE').AsString := Copy(GetToken(Line, 12), 1, 10);
        // Стоимость без НДС берём готовую, а если её нет, то рассчитываем
        CostNoVatStr := GetToken(Line, 13);
        if CostNoVATStr = '' then
          CostNoVatStr := FloatToStr(vtDetailFile.FieldByName('SERVICE_COST').AsFloat / 1.18);
        vtDetailFile.FieldByName('COST_NO_VAT').AsFloat := StrToFloat2(CostNoVatStr);
        //
        vtDetailFile.FieldByName('BS_PLACE').AsString := Copy(GetToken(Line, 14), 1, 50);

        vtDetailFile.Post;
      end;
    end;
    vtDetailFile.First;
  finally
    vtDetailFile.EnableControls;
    FreeAndNil(sl);
  end;
  except
    on E : Exception do
      ShowMessage('Ошибка обработки детализации. '+E.Message);
  end;
end;

procedure TShowUserStatForm.aSaveDetailExecute(Sender: TObject);
begin
  sdDetail.FileName := Format('%d_%.2d_%s_детализация', [FYear, FMonth, FPhoneNumber]);
  if sdDetail.Execute then
  begin
    mDetailText.Lines.SaveToFile(sdDetail.FileName);
  end;
end;

procedure TShowUserStatForm.aLinkPaymentExecute(Sender: TObject);
begin
  if FManualPaymentManagement then
  begin
    if qPayments.IsEmpty then
      // Nothing
    else if FContractID = 0 then
      ShowMessage('Договор не зарегистрирован, прикрепить платёж нельзя.')
    else if qPayments.FieldByName('PAYMENT_TYPE').AsInteger <> PAYMENT_TYPE_LOADED then
      ShowMessage('Этот платёж внесён вручную, изменить его нельзя.')
    else if qPayments.FieldByName('PAYMENT_DATE').AsDateTime >= FContractDate-DAYS_PAYMENT_BEFORE_CONTRACT then
      ShowMessage('Платёж учтён автоматически, прикрепить его повторно нельзя.')
    else if qPayments.FieldByName('CONTRACT_ID').AsInteger = FContractID then
      ShowMessage('Платёж уже прикреплён.')
    else if not qPayments.FieldByName('CONTRACT_ID').IsNull
      and (IDYES <> Application.MessageBox('Платёж уже прикреплён к другому договору. Открепить?', 'Прикрепление', IDYES or IDNO)) then
      // Nothing
    else
    begin
      qLinkPayment.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
      qLinkPayment.ParamByName('PAYMENT_NUMBER').AsString := qPayments.FieldByName('PAYMENT_NUMBER').AsString;
      qLinkPayment.ParamByName('PAYMENT_SUM').AsFloat := qPayments.FieldByName('PAYMENT_SUM').AsFloat;
      qLinkPayment.ParamByName('CONTRACT_ID').AsInteger := FContractID;
      qLinkPayment.ExecSQL;
      qPayments.Refresh;
      qTariffInfo.Refresh;
      RefreshBalanceRows;
    end;
  end;
end;

procedure TShowUserStatForm.aUnlinkPaymentExecute(Sender: TObject);
begin
  if FManualPaymentManagement then
  begin
    if qPayments.IsEmpty then
      // Nothing
    else if FContractID = 0 then
      ShowMessage('Договор не зарегистрирован, открепить платёж нельзя.')
    else if qPayments.FieldByName('PAYMENT_TYPE').AsInteger <> PAYMENT_TYPE_LOADED then
      ShowMessage('Платёж внесён вручную, открепить его нельзя.')
    else if qPayments.FieldByName('PAYMENT_DATE').AsDateTime >= FContractDate-DAYS_PAYMENT_BEFORE_CONTRACT then
      ShowMessage('Платёж учтён автоматически, открепить его нельзя.')
    else if qPayments.FieldByName('CONTRACT_ID').IsNull or (qPayments.FieldByName('CONTRACT_ID').AsInteger <> FContractID) then
      ShowMessage('Платёж не прикреплён к договору.')
      // Nothing (уже прикреплён)
    else
    begin
      qLinkPayment.ParamByName('PHONE_NUMBER').AsString := FPhoneNumber;
      qLinkPayment.ParamByName('PAYMENT_NUMBER').AsString := qPayments.FieldByName('PAYMENT_NUMBER').AsString;
      qLinkPayment.ParamByName('PAYMENT_SUM').AsFloat := qPayments.FieldByName('PAYMENT_SUM').AsFloat;
      qLinkPayment.ParamByName('CONTRACT_ID').Clear;
      qLinkPayment.ExecSQL;
      qPayments.Refresh;
      qTariffInfo.Refresh;
      RefreshBalanceRows;
    end;
  end;
end;


procedure TShowUserStatForm.dsTariffInfoDataChange(Sender: TObject;
  Field: TField);
var
  AText : String;
  AFontColor : TColor;
  Balance : Double;
begin
  // Статус
  if qTariffInfo.EOF then
  begin
    AText := 'Нет данных';
    AFontColor := clWindowText;
  end
  else if qTariffInfo.FieldByName('PHONE_IS_ACTIVE').AsInteger = 0 then
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
  if qTariffInfo.EOF then
  begin
    AText := '???';
    AFontColor := clWindowText;
  end
  else
  begin
    Balance := qTariffInfo.FieldByName('CURRENT_BALANCE').AsFloat;
    AText := FloatToStrF(Balance, ffNumber, 15, 2);
    if Balance  < 0 then
      AFontColor := clRed
    else
      AFontColor := clWindowText;
  end;
  lBalance.Caption := AText;
  lBalance.Font.Color := AFontColor;

  // Статус
  if qTariffInfo.EOF then
  begin
    AText := 'Нет данных';
    AFontColor := clWindowText;
  end
  else
    if qTariffInfo.FieldByName('CONSERVATION').AsInteger = 1 then
    begin
      if qTariffInfo.FieldByName('SYSTEM_BLOCK').AsInteger = 1 then
      begin
        AText := 'Мошенничество';
        AFontColor := clRed;
      end
      else begin
        AText := 'На сохранении';
        AFontColor := clGreen;
      end
    end
    else
    begin
      AText := 'Не по сохранению';
      AFontColor := clBlack;
    end;
  lBlockInfo.Caption := AText;
  lBlockInfo.Font.Color := AFontColor;
end;

procedure TShowUserStatForm.eSetPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ord(Key)=VK_RETURN then
    BtSetPasswordOk.Click;
end;

procedure TShowUserStatForm.CRDBGrid4GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor;
  State: TGridDrawState; StateEx: TGridDrawStateEx);
begin
  if Field.FieldName = 'BILL_SUM' then
    AFont.Style := [fsBold];
end;

procedure TShowUserStatForm.CRDBGrid5CellClick(Column: TColumn);
var Line:string;
    YearMonth:Integer;
begin
  Line:=CRDBGrid5.Columns[3].Field.AsString;
  if Pos('Счёт', Line)>0 then
  begin
    YearMonth:=StrToInt(Copy(Line, Length(Line)-3,4)+Copy(Line, Length(Line)-6,2));
    DoShowBillDetails(FPhoneNumber, YearMonth, CRDBGrid5.Columns[3].Field.AsString);
  end;
end;

procedure TShowUserStatForm.aOpenDetailInExcelExecute(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Детализация по номеру '
      + FPhoneNumber
      + ' за '
      + qPeriods.FieldByName('MONTH').AsString
      + ' - '
      + qPeriods.FieldByName('YEAR').AsString;
  try
    ExportDBGridToExcel(ACaption,
      dbgDetail, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowUserStatForm.qPaymentsAfterOpen(DataSet: TDataSet);
var
  f : TField;
begin
  qPayments.FieldByName('PAYMENT_REMARK').OnGetText := qPaymentsPAYMENT_STATUS_TEXTGetText;
  if FManualPaymentManagement then
  begin
    f := qPayments.FindField('CONTRACT_ID');
    if f <> nil then
      f.OnGetText := qPaymentsCONTRACT_IDGetText;
  end
  else
    gPayments.Columns.Delete(4)
end;

procedure TShowUserStatForm.qPaymentsPAYMENT_STATUS_TEXTGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.DataSet.Eof then
    Text := ''
  else if Sender.AsString = '' then
    Text := 'OK'
  else
    Text := Sender.AsString;
end;

procedure TShowUserStatForm.qPaymentsCONTRACT_IDGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if FManualPaymentManagement then
  begin
    Text := '';
    if (FContractID <> 0) and (Sender.AsInteger = FContractID) then
      Text := 'Да'
    else
    begin
      if qPayments.FieldByName('PAYMENT_DATE').AsDateTime >= FContractDate-DAYS_PAYMENT_BEFORE_CONTRACT then
        Text := 'Да';
    end;
  end;
end;

procedure TShowUserStatForm.qPhoneStatusesPHONE_IS_ACTIVEGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if Sender.AsInteger = 1 then
    Text := 'Активен'
  else
    Text := 'Блокирован';
end;

procedure TShowUserStatForm.tsDetailShow(Sender: TObject);
begin
  qPeriods.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  qPeriods.Open;
end;

procedure TShowUserStatForm.BtBlockClick(Sender: TObject);
 var
  DetailText : String;
  buttonSelected : Integer;
begin
  if True then
  begin
  buttonSelected:=MessageDlg('Вы действительно хотите заблокировать данный номер телефона?', mtCustom, mbOKCancel, 0);
    if buttonSelected = mrCancel then exit;
      LoaderBlockPhoneNum.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
      try
        LoaderBlockPhoneNum.ExecProc;
        DetailText := LoaderBlockPhoneNum.ParamByName('RESULT').AsString;
        FDetailText := DetailText;
      except
        on E : Exception do
        begin
          DetailText := 'Ошибка блокировки.'#13#10 + E.Message;
        end;
      end;
      if DetailText='' then
        ShowMessage('Операция выполнена успешно')
      else
        MessageDlg(DetailText, mtWarning, [mbOk], 0);
      end;
end;


procedure TShowUserStatForm.BtUnBlockClick(Sender: TObject);
var
  DetailText : String;
  buttonSelected : Integer;
begin
  if True then
  begin
    buttonSelected:=MessageDlg('Вы действительно хотите разблокировать данный номер телефона?', mtCustom, mbOKCancel, 0);
    if buttonSelected = mrCancel
      then exit;
      LoaderUnBlockPhoneNum.ParamByName('pPHONE_NUMBER').AsString := FPhoneNumber;
      try
      LoaderUnBlockPhoneNum.ExecProc;
      DetailText := LoaderUnBlockPhoneNum.ParamByName('RESULT').AsString;
      FDetailText := DetailText;
      except
        on E : Exception do
        begin
          DetailText := 'Ошибка разблокировки.'#13#10 + E.Message;
        end;
      end;
      if DetailText='' then
        ShowMessage('Операция выполнена успешно')
      else
        MessageDlg(DetailText, mtWarning, [mbOk], 0);
  end;
end;

procedure TShowUserStatForm.cbDiscountClick(Sender: TObject);
begin
  if cbDiscount.Checked then
  begin
    eLength.Show;
    lLength.Show;
    btSetDiscount.Show;
    dtpNewBeginDate.Show;
    dtpNewBeginDate.DateTime:=qDiscountDISCOUNT_BEGIN_DATE.AsDateTime;
    lDate.Show;
  end else
  begin
    if qDiscountIS_DISCOUNT_OPERATOR.AsInteger=1 then
    begin
      spSetDiscount.ParamByName('PCHECK').AsInteger:=0;
      spSetDiscount.ParamByName('PDISCOUNT_VALIDITY').Value:=null;
      spSetDiscount.ParamByName('PDISCOUNT_BEGIN_DATE').Value:=null;
      spSetDiscount.ExecSQL;
      qDiscount.Close;
      qDiscount.Open;
    end;
    eLength.Hide;
    lLength.Hide;
    btSetDiscount.Hide;
    dtpNewBeginDate.Hide;
    lDate.Hide;
  end;
  if cbDiscount.Checked then
    if qDiscountDISCOUNT_END_DATE.AsDateTime<Date then
      cbDiscount.Font.Color:=clRed
    else
      cbDiscount.Font.Color:=clGreen
  else
    cbDiscount.Font.Color:=clWindowText;
end;

procedure TShowUserStatForm.btSetDiscountClick(Sender: TObject);
begin
  spSetDiscount.ParamByName('PCHECK').AsInteger:=1;
  spSetDiscount.ParamByName('PDISCOUNT_VALIDITY').AsInteger:=qDiscountDISCOUNT_VALIDITY.AsInteger;
  spSetDiscount.ParamByName('PDISCOUNT_BEGIN_DATE').AsDateTime:=dtpNewBeginDate.DateTime;
  spSetDiscount.ExecSQL;
  qDiscount.Close;
  qDiscount.Open;
  if cbDiscount.Checked then
    if qDiscountDISCOUNT_END_DATE.AsDateTime<Date then
      cbDiscount.Font.Color:=clRed
    else
      cbDiscount.Font.Color:=clGreen
  else
    cbDiscount.Font.Color:=clWindowText;
end;

procedure TShowUserStatForm.btSetHandBlockDateEndClick(Sender: TObject);
begin
  if (FContractID<>0)and(GetConstantValue('HAND_BLOCK_IS_ROBOT_BLOCK')='1') then
  begin
    spSetHandBlockEndDate.ParamByName('PHAND_BLOCK_END_DATE').AsDateTime:=
      StrToDate(emNewDateEnd.Text);
    spSetHandBlockEndDate.ExecSQL;
    emNewDateEnd.Visible:=false;
    btSetHandBlockDateEnd.Visible:=false;
    dbtShowDateHB.Visible:=true;
  end;
end;

procedure TShowUserStatForm.BtSetPasswordClick(Sender: TObject);
begin
  if qPassword.ParamByName('ABONENT_ID').AsInteger=0 then
    ShowMessage('Для данного номера не существует договора.'+chr(10)+'Задать пароль невозможно.')
  else
    begin
      BtSetPasswordOk.Show;
      eSetPassword.Show;
      BtSetPassword.Hide;
      eSetPassword.Text:='';
      eSetPassword.SetFocus;
    end;
end;

procedure TShowUserStatForm.BtSetPasswordOkClick(Sender: TObject);
begin
  qPassword.ParamByName('PASSWORD').AsString:=eSetPassword.Text;
  qPassword.ExecSql;
  BtSetPasswordOk.Hide;
  eSetPassword.Hide;
  BtSetPassword.Show;
end;

procedure TShowUserStatForm.btPostCommentsClick(Sender: TObject);
begin
  qContractInfo.Post;
  qContractInfo.Close;
  qContractInfo.Open;
end;

procedure TShowUserStatForm.btRefreshCIClick(Sender: TObject);
begin
  qContractInfo.Close;
  qContractInfo.Open;
end;

procedure TShowUserStatForm.btAddDepositClick(Sender: TObject);
var
  RefFrm : TAddDepositeFrm;
begin
  RefFrm:=TAddDepositeFrm.Create(Application);
  RefFrm.ContractID:=FContractID;
  RefFrm.mAddDepositNote.Text:='';
  RefFrm.ShowModal;
  qDepositOper.Close;
  qDepositOper.Open;
  qDeposit.Close;
  qDeposit.Open;
end;

procedure TShowUserStatForm.CbHandBlockClick(Sender: TObject);
begin
  if (FContractID<>0)and(GetConstantValue('HAND_BLOCK_IS_ROBOT_BLOCK')='1') then
    if cbHandBlock.Checked<>FHandBlockChecked then
    begin
      if cbHandBlock.Checked then
      begin
        emNewDateEnd.Visible:=true;
        btSetHandBlockDateEnd.Visible:=true;
        dbtShowDateHB.Visible:=false;
      end else
      begin
        spSetHandBlockEndDate.ParamByName('PHAND_BLOCK_END_DATE').Value:=null;
        spSetHandBlockEndDate.ExecSQL;
      end;
    FHandBlockChecked:=cbHandBlock.Checked;
    end;
end;

procedure TShowUserStatForm.CbHandBlockExit(Sender: TObject);
begin
  if GetConstantValue('HAND_BLOCK_IS_ROBOT_BLOCK')<>'1' then
  begin
    qSelBalDate.Close;
    qHandBlock.SQL.Clear;
    qSelBalDate.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
    qSelBalDate.Open;
    if CbHandBlock.Visible and (CbHandBlock.Checked <> FHandBlockChecked) then
    begin
      if CbHandBlock.Checked then
      begin
        qHandBlock.Close;
        qHandBlock.SQL.Add('Update contracts set hand_block=1 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
        qHandBlock.Prepare;
        qHandBlock.ExecSql;
      end
      else
      begin
        qHandBlock.Close;
        qHandBlock.SQL.Add('Update contracts set hand_block=0 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
        qHandBlock.Prepare;
        qHandBlock.ExecSql;
      end;
      FHandBlockChecked := CbHandBlock.Checked;
    end;
  end;
end;

procedure TShowUserStatForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qSelBalDate.Close;
  qHandBlock.SQL.Clear;
  qSelBalDate.ParamByName('PHONE_NUMBER').AsString:=FPhoneNumber;
  qSelBalDate.Open;
  if CbHandBlock.Visible and (CbHandBlock.Checked <> FHandBlockChecked) then
  begin
    if CbHandBlock.Checked then
    begin
      qHandBlock.Close;
      qHandBlock.SQL.Add('Update contracts set hand_block=1 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      qHandBlock.Prepare;
      qHandBlock.ExecSql;
    end
    else
    begin
      qHandBlock.Close;
      qHandBlock.SQL.Add('Update contracts set hand_block=0 where CONTRACT_ID='+InttoStr(FContractID)+' and (PHONE_NUMBER_CITY='+FPhoneNumber+' or PHONE_NUMBER_FEDERAL='+FPhoneNumber+')');
      qHandBlock.Prepare;
      qHandBlock.ExecSql;
    end;
    FHandBlockChecked := CbHandBlock.Checked;
  end;
end;

procedure TShowUserStatForm.FormCreate(Sender: TObject);
begin
  if GetConstantValue('SERVER_NAME')<>'CORP_MOBILE' then
    dbgDetail.Columns[13].Visible := False;
end;

end.

