unit JournalUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sPanel, sEdit, sLabel, sPageControl, ComCtrls, StdCtrls, ExtCtrls,
  DBGridEhGrouping, DB, MemDS, DBAccess, Ora, GridsEh, DBGridEh, VirtualTable,
  Mask, DBCtrlsEh, DBLookupEh, Buttons, sBitBtn;

type
  TJournalMode=(jmUndefined, jmOptionSet, jmPaidSMS, jmBalances, jmUndefPhone,
                jmOperations, jmBills, jmUnAccess);

type
  TJournalForm = class(TForm)
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sLabel1: TsLabel;
    sEdit1: TsEdit;
    sPageControl1: TsPageControl;
    sTabSheet0: TsTabSheet;
    sTabSheet1: TsTabSheet;
    grMain: TDBGridEh;
    qOptionSetLog: TOraQuery;
    dsMain: TDataSource;
    vtMain: TVirtualTable;
    qOptionSetLogPHONE_NUMBER: TStringField;
    qOptionSetLogOPTION_NAME: TStringField;
    qOptionSetLogTYPE_SET: TStringField;
    qOptionSetLogNOTE: TStringField;
    qSendPaidSMS: TOraQuery;
    vtMainDate: TDateTimeField;
    vtMainCellNum: TStringField;
    vtMainOptionName: TStringField;
    vtMainTypeSet: TStringField;
    vtMainNote: TStringField;
    vtMainDateEnd: TDateTimeField;
    vtMainUser: TStringField;
    vtMainOperation: TStringField;
    vtMainBalance: TFloatField;
    vtMainAccount: TIntegerField;
    vtMainBillSum: TFloatField;
    vtMainKomSum: TFloatField;
    qSendPaidSMSPHONE_NUMBER: TStringField;
    qSendPaidSMSNOTE: TStringField;
    qGetOptions: TOraQuery;
    qOptionSetLogDATE_DO: TDateTimeField;
    qGetBalance: TOraQuery;
    qGetBalanceUndefPhone: TOraQuery;
    qSendPaidSMSDATE_DO: TDateTimeField;
    qGetBalancePHONE_NUMBER: TStringField;
    qGetBalanceBALANCE: TFloatField;
    qGetBalanceDATE_DO: TDateTimeField;
    qGetBalanceUndefPhonePHONE_NUMBER: TStringField;
    qGetBalanceUndefPhoneBALANCE: TFloatField;
    qGetBalanceUndefPhoneDATE_DO: TDateTimeField;
    sTabSheet2: TsTabSheet;
    grOptions: TDBGridEh;
    dsGetOptions: TDataSource;
    qGetOptionsOPTION_NAME: TStringField;
    qGetOptionsDATE_OPTION_CHECK: TDateTimeField;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    qOperations: TOraQuery;
    qOperationsOPERATION_TYPE: TStringField;
    qOperationsNOTE: TStringField;
    qOperationsUSER_CREATED: TStringField;
    qOperationsDATE_BEGIN: TDateTimeField;
    qOperationsDATE_END: TDateTimeField;
    sTabSheet5: TsTabSheet;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    qPeriod: TOraQuery;
    dsPeriod: TDataSource;
    qPeriodYEAR_MONTH: TFloatField;
    qPeriodYEAR_MONTH_NAME: TStringField;
    qBills: TOraQuery;
    qBillsBILL_ID: TFloatField;
    qBillsPHONE_NUMBER: TStringField;
    qBillsBILL_SUM: TFloatField;
    qBillsDATE_BEGIN: TDateTimeField;
    qBillsDATE_END: TDateTimeField;
    qBillsYEAR_MONTH: TFloatField;
    qBillsKOM_SUM: TFloatField;
    qBillsACCOUNT: TStringField;
    sLabel2: TsLabel;
    sBitBtn1: TsBitBtn;
    sTabSheet6: TsTabSheet;
    qPhoneUnAccess: TOraQuery;
    qPhoneUnAccessCELL_NUMBER: TStringField;
    sBitBtn2: TsBitBtn;
    qBillsKOM_SUM_BILL: TFloatField;
    qBillsFULL_SUM: TFloatField;
    qBillsNO_ROUMING_SUM: TFloatField;
    vtMainKomSumBill: TFloatField;
    vtMainFullSum: TFloatField;
    vtMainNoRouming: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsMainDataChange(Sender: TObject; Field: TField);
    procedure DBLookupComboboxEh1Change(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
  private
    fMode:TJournalMode;
    procedure OptionSetMode;
    procedure PaidSMSMode;
    procedure BalancesMode;
    procedure UndefPhoneMode;
    procedure OperationsMode;
    procedure BillsMode;
    procedure UnAccessMode;
  public
    constructor Create(AOwner: TComponent; AMode: TJournalMode); reintroduce;
  end;

var
  JournalForm: TJournalForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

constructor TJournalForm.Create(AOwner: TComponent; AMode: TJournalMode);
var i:integer;
begin
  inherited Create(AOwner);
  fMode := AMode;
  vtMain.Open;

  grMain.ReadOnly:=true;
  grOptions.ReadOnly:=true;
//Дата Date
  grMain.Columns[0].Visible:=not (fMode=jmUnAccess);
//Конец DateEnd
  grMain.Columns[1].Visible:=(fMode=jmOperations)or(fMode=jmBills);
//Телефон CellNum
  grMain.Columns[2].Visible:=not (fMode=jmOperations);
//Действие TypeSet
  grMain.Columns[3].Visible:=(fMode=jmOptionSet);
//Название услуги OptionName
  grMain.Columns[4].Visible:=(fMode=jmOptionSet);
//Операция OperationType
  grMain.Columns[5].Visible:=(fMode=jmOperations);
//Пользователь User
  grMain.Columns[6].Visible:=(fMode=jmOperations);
//Примечание Note
  grMain.Columns[7].Visible:=(fMode=jmOptionSet)or(fMode=jmPaidSMS)
                             or(fMode=jmOperations);
//Баланс Balance
  grMain.Columns[8].Visible:=(fMode=jmBalances)or(fMode=jmUndefPhone);
//Лиц. счет Account
  grMain.Columns[9].Visible:=(fMode=jmBills);
//Счет BillSum
  grMain.Columns[10].Visible:=(fMode=jmBills);
//Комиссия(11%) KomSumBill
  grMain.Columns[11].Visible:=(fMode=jmBills);
//Комиссия(11%) KomSumBill
  grMain.Columns[11].Visible:=(fMode=jmBills);
//Комиссия(11%) KomSumBill
  grMain.Columns[11].Visible:=(fMode=jmBills);
//Комиссия(11%) KomSumBill
  grMain.Columns[11].Visible:=(fMode=jmBills);

  if (fMode=jmBalances)or(fMode=jmUndefPhone) then
    grOptions.Show
  else
    grOptions.Hide;
  if (fMode=jmBills)or(fMode=jmUnAccess) then
    sPanel1.Show
  else
    sPanel1.Hide;

  for i:= 0 to sPageControl1.PageCount-1 do
    sPageControl1.Pages[i].TabVisible := false;
  case fMode of
    jmOptionSet: OptionSetMode;
    jmPaidSMS: PaidSMSMode;
    jmBalances: BalancesMode;
    jmUndefPhone: UndefPhoneMode;
    jmOperations: OperationsMode;
    jmBills: BillsMode;
    jmUnAccess: UnAccessMode;
  end;
end;

procedure TJournalForm.dsMainDataChange(Sender: TObject; Field: TField);
begin
  if (fMode=jmBalances)or(fMode=jmUndefPhone) then
  begin
    qGetOptions.Close;
    qGetOptions.ParamByName('PHONE_NUMBER').AsString:=vtMainCellNum.AsString;
    qGetOptions.Open;
  end;
end;

procedure TJournalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qOptionSetLog.Close;
  qGetOptions.Close;
  qGetBalance.Close;
  qGetBalanceUndefPhone.Close;
  qSendPaidSMS.Close;
  qOperations.Close;
  qBills.Close;
  qPhoneUnAccess.Close;
  vtMain.Close;
end;

procedure TJournalForm.UnAccessMode;
begin
  Width:=400;
  sPanel2.Hide;
  qPhoneUnAccess.Open;
  Caption:='Номера с неработающим Сервис-Гидом';
  sPageControl1.ActivePageIndex:=6;
  qPhoneUnAccess.DisableControls;
  vtMain.DisableControls;
  qPhoneUnAccess.Last;
  while not qPhoneUnAccess.Bof do
  begin
    vtMain.Insert;
    vtMainCellNum.AsString:=qPhoneUnAccessCELL_NUMBER.AsString;
    vtMain.Post;
    qPhoneUnAccess.Prior;
  end;
  qPhoneUnAccess.EnableControls;
  vtMain.EnableControls;
end;

procedure TJournalForm.BillsMode;
begin
  Caption:='Счета и комиссия';
  sPageControl1.ActivePageIndex:=5;
  grMain.Columns[0].Title.Caption:='Начало';
  qPeriod.Open;
  qPeriod.First;
  DBLookupComboboxEh1.KeyValue:=qPeriodYEAR_MONTH.AsVariant;
end;

procedure TJournalForm.DBLookupComboboxEh1Change(Sender: TObject);
begin
  qBills.ParamByName('PERIOD').AsInteger:=DBLookupComboboxEh1.KeyValue;
  qBills.Open;
  qBills.First;
  vtMain.DisableControls;
  while not qBills.Eof do
  begin
    vtMain.Append;
    if qBillsACCOUNT.AsString<>'' then
      vtMainAccount.AsInteger:=qBillsACCOUNT.AsInteger;
    vtMainBillSum.AsFloat:=qBillsBILL_SUM.AsFloat;
    vtMainKomSum.AsFloat:=qBillsKOM_SUM.AsFloat;
    vtMainKomSumBill.AsFloat:=qBillsKOM_SUM_BILL.AsFloat;
    vtMainCellNum.AsString:=qBillsPHONE_NUMBER.AsString;
    vtMainDate.AsDateTime:=qBillsDATE_BEGIN.AsDateTime;
    vtMainDateEnd.AsDateTime:=qBillsDATE_END.AsDateTime;
    vtMainNoRouming.AsFloat:=qBillsNO_ROUMING_SUM.AsFloat;
    vtMainFullSum.AsFloat:=qBillsFULL_SUM.AsFloat;
    vtMain.Post;
    qBills.Next;
  end;
  vtMain.EnableControls;
  qBills.Close;
end;

procedure TJournalForm.OptionSetMode;
var SQL:Tstrings;
begin
  qOptionSetLog.Open;
  Caption:='Журнал подкл. и откл. услуг';
  sPageControl1.ActivePageIndex:=0;
  qOptionSetLog.DisableControls;
  vtMain.DisableControls;
  qOptionSetLog.Last;
  while not qOptionSetLog.Bof do
  begin
    vtMain.Insert;
    vtMainDate.AsDateTime:=qOptionSetLogDATE_DO.AsDateTime;
    vtMainCellNum.AsString:=qOptionSetLogPHONE_NUMBER.AsString;
    vtMainOptionName.AsString:=qOptionSetLogOPTION_NAME.AsString;
    vtMainTypeSet.AsString:=qOptionSetLogTYPE_SET.AsString;
    vtMainNote.AsString:=qOptionSetLogNOTE.AsString;
    vtMain.Post;
    qOptionSetLog.Prior;
  end;
  qOptionSetLog.EnableControls;
  vtMain.EnableControls;
end;

procedure TJournalForm.PaidSMSMode;
begin
  qSendPaidSMS.Open;
  Caption:='Журнал отправок платной СМС';
  sPageControl1.ActivePageIndex:=1;
  qSendPaidSMS.DisableControls;
  vtMain.DisableControls;
  qSendPaidSMS.Last;
  while not qSendPaidSMS.Bof do
  begin
    vtMain.Insert;
    vtMainDate.AsDateTime:=qSendPaidSMSDATE_DO.AsDateTime;
    vtMainCellNum.AsString:=qSendPaidSMSPHONE_NUMBER.AsString;
    vtMainNote.AsString:=qSendPaidSMSNOTE.AsString;
    vtMain.Post;
    qSendPaidSMS.Prior;
  end;
  qSendPaidSMS.EnableControls;
  vtMain.EnableControls;
end;

procedure TJournalForm.sBitBtn1Click(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  vtMain.DisableControls;
  try
    ExportDBGridEhToExcel(Caption, grMain, false);
    Enabled := true;
    Application.MessageBox('Выгрузка в Excel завершена!', 'Уведомление',
      MB_OK + MB_ICONEXCLAMATION);
  finally
    Enabled := true;
    vtMain.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TJournalForm.sBitBtn2Click(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  vtMain.DisableControls;
  try
    ExportDBGridEhToExcel(Caption, grMain, false);
    Enabled := true;
    Application.MessageBox('Выгрузка в Excel завершена!', 'Уведомление',
      MB_OK + MB_ICONEXCLAMATION);
  finally
    Enabled := true;
    vtMain.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TJournalForm.BalancesMode;
begin
  qGetBalance.Open;
  Caption:='Журнал балансов и списков подключенных услуг';
  sPageControl1.ActivePageIndex:=2;
  qGetBalance.DisableControls;
  vtMain.DisableControls;
  qGetBalance.Last;
  while not qGetBalance.Bof do
  begin
    vtMain.Insert;
    vtMainCellNum.AsString:=qGetBalancePHONE_NUMBER.AsString;
    vtMainDate.AsDateTime:=qGetBalanceDATE_DO.AsDateTime;
    vtMainBalance.AsString:=qGetBalanceBALANCE.AsString;
    vtMain.Post;
    qGetBalance.Prior;
  end;
  qGetBalance.EnableControls;
  vtMain.EnableControls;
end;

procedure TJournalForm.UndefPhoneMode;
begin
  qGetBalanceUndefPhone.Open;
  Caption:='Журнал неоприходованных номеров';
  sPageControl1.ActivePageIndex:=3;
  qGetBalanceUndefPhone.DisableControls;
  vtMain.DisableControls;
  qGetBalanceUndefPhone.Last;
  while not qGetBalanceUndefPhone.Bof do
  begin
    vtMain.Insert;
    vtMainCellNum.AsString:=qGetBalanceUndefPhonePHONE_NUMBER.AsString;
    vtMainDate.AsDateTime:=qGetBalanceUndefPhoneDATE_DO.AsDateTime;
    vtMainBalance.AsFloat:=qGetBalanceUndefPhoneBALANCE.AsFloat;
    vtMain.Post;
    qGetBalanceUndefPhone.Prior;
  end;
  qGetBalanceUndefPhone.EnableControls;
  vtMain.EnableControls;
end;

procedure TJournalForm.OperationsMode;
begin
  qOperations.Open;
  Caption:='Журнал операций';
  sPageControl1.ActivePageIndex:=4;
  grMain.Columns[0].Title.Caption:='Начало';
  qOperations.DisableControls;
  vtMain.DisableControls;
  qOperations.Last;
  while not qOperations.Bof do
  begin
    vtMain.Insert;
    vtMainDate.AsDateTime:=qOperationsDATE_BEGIN.AsDateTime;
    vtMainDateEnd.AsDateTime:=qOperationsDATE_END.AsDateTime;
    vtMainOperation.AsString:=qOperationsOPERATION_TYPE.AsString;
    vtMainUser.AsString:=qOperationsUSER_CREATED.AsString;
    vtMainNote.AsString:=qOperationsNOTE.AsString;
    vtMain.Post;
    qOperations.Prior;
  end;
  qOperations.EnableControls;
  vtMain.EnableControls;
end;

end.
