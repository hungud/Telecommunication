unit RegisterPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ora, DB, MemDS, DBAccess, ActnList, StdCtrls, Buttons, Mask,
  DBCtrls, ComCtrls, ExtCtrls;

type
  TRegisterPaymentForm = class(TForm)
    ActionList1: TActionList;
    aSelectContract: TAction;
    aSelectAbonent: TAction;
    dsContarct: TDataSource;
    dsReceivedPayments: TDataSource;
    qFilials: TOraQuery;
    dsFilials: TDataSource;
    qReceivedPayments: TOraQuery;
    qContract: TOraQuery;
    qGetNewId: TOraStoredProc;
    Panel1: TPanel;
    sbSelectAbonent: TSpeedButton;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    DBText5: TDBText;
    SpeedButton2: TSpeedButton;
    Bevel2: TBevel;
    Label19: TLabel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    pButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    pTARIFF_ID: TPanel;
    Label13: TLabel;
    TARIFF_ID: TDBLookupComboBox;
    qOperators: TOraQuery;
    dsOperators: TDataSource;
    qTariffs: TOraQuery;
    dsTariffs: TDataSource;
    pFILIAL_ID: TPanel;
    Label14: TLabel;
    FILIAL_ID: TDBLookupComboBox;
    pCONTRACT_CHANGE_DATE: TPanel;
    Label7: TLabel;
    PAYMENT_DATE_TIME: TDateTimePicker;
    pSUM_GET: TPanel;
    Label20: TLabel;
    PAYMENT_SUM: TDBEdit;
    pRemark: TPanel;
    Label6: TLabel;
    eREMARK: TDBEdit;
    dbcbbTypePayment: TDBComboBox;
    Panel2: TPanel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pnlTypePayment: TPanel;
    dsPaymentTypes: TDataSource;
    qPaymentTypes: TOraQuery;
    lblTypeCaption: TLabel;
    dblkPaymentTypes: TDBLookupComboBox;
    dbchkReverseSchet: TDBCheckBox;
    chbSMS: TCheckBox;
    SendSMS: TOraStoredProc;
    dbchkIsDistributed: TDBCheckBox;
    spADD_DISTRIBUTED_PAYMENT: TOraStoredProc;
    lblPaymentPeriod: TLabel;
    pnlDISTREBUTED_PAYMENT: TPanel;
    dblkcbbPaymentPeriod: TDBLookupComboBox;
    qPaymentPeriod: TOraQuery;
    dsPaymentPeriod: TOraDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbchkIsDistributedClick(Sender: TObject);
    procedure eREMARKChange(Sender: TObject);
  private
    procedure SetEnabledAll(const pEnabled: boolean);
    function CheckDate(var pErrorMessage : String) : boolean;
  public
    FReadData : boolean;
    FRunMode : String;
    FReceivedPaymentId : Variant;
    function PrepareForm(const pRunMode: String;
                         const pReceivedPaymentId, pContractId: Variant): boolean;
    function PrepareFormNoContract(const pRunMode, pPhoneNumber: String;
                         const pReceivedPaymentId, pContractId: Variant): boolean;
    function SaveData: boolean;
  end;

//var
//  ChangeContractForm: TChangeContractForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TRegisterPaymentForm.SetEnabledAll(const pEnabled: boolean);
var i : Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TCustomEdit)
      or (Self.Components[i] is TCustomLabel)
      or (Self.Components[i] is TCommonCalendar)
      or (Self.Components[i] is TDBLookupControl)
      or (Self.Components[i] is TDBCheckBox)
      or (Self.Components[i] is TCheckBox)
    then
      (Self.Components[i] as TControl).Enabled := pEnabled;
  end;
  //
end;

function TRegisterPaymentForm.PrepareForm(const pRunMode: String;
                                          const pReceivedPaymentId : Variant;
                                          const pContractId: Variant
                                          ) : boolean;
begin
  Result := False;
  try
    FReadData := True;
    try
      FRunMode := pRunMode;

      if pRunMode = 'INSERT' then
      begin
        dbchkIsDistributed.Checked := False;
        if (VarToStr(pContractId) = '')or(VarToStr(pContractId) = '0') then
        begin
          MessageDlg('Невозможно добавить платёж. Код договора не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          SetEnabledAll(True);

          qFilials.Close;
          qFilials.Open;
          //qOperators.Close;
          //qOperators.Open;
          qTariffs.Close;
          qTariffs.Open;
          qTariffs.Filtered := False;

          qContract.Close;
          qContract.ParamByName('CONTRACT_ID').Value := pContractId;
          qContract.Open;

          if GetConstantValue('USE_TYPE_PAYMENTS') = '1' then  begin
            qPaymentTypes.Close;
            qPaymentTypes.Open;
          end
          else
          pnlTypePayment.Visible:=false;

          if qContract.Active and (qContract.RecordCount > 0) then
          begin
            qTariffs.Filter := 'OPERATOR_ID = '+ qContract.FieldByName('OPERATOR_ID').AsString;
            qTariffs.Filtered := True;
          end
          else
            qTariffs.Filtered := False;

          qReceivedPayments.Close;
          qReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').Value := Null;
          qReceivedPayments.Open;
          qReceivedPayments.Append;
          PAYMENT_DATE_TIME.Date := Date();
          //qContractChange.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime := Date();
          //qContractChange.FieldByName('FILIAL_ID').Value := GetDefaultFilialId();
          qReceivedPayments.FieldByName('CONTRACT_ID').Value := pContractId;
          qReceivedPayments.FieldByName('IS_CONTRACT_PAYMENT').AsInteger := 0;
          qReceivedPayments.FieldByName('PHONE_NUMBER').Value := qContract.FieldByName('PHONE_NUMBER_FEDERAL').Value;

          // если включено распределение платежа по группе IS_DISTRIBUTED_PAYMENT и есть группа у договора,
          // то отрисоваваем возможность указать распределение платежа
          pnlDISTREBUTED_PAYMENT.Visible := ((GetConstantValue('SHOW_CONTRACT_GROUPS')='1') and
                                             (not VarIsNull(qContract.FieldByName('GROUP_ID').Value)) ); //Справочник: Групповые договора
          // пока делаем невидимым выбор период распрделения затрат, если будет выбрано распределение платежа - делаем видным
          dblkcbbPaymentPeriod.Visible := False;
          lblPaymentPeriod.Visible := False;

          if GetConstantValue('SHOW_CONTRACT_GROUPS')='1' then
          begin
            qPaymentPeriod.Close;
            qPaymentPeriod.ParamByName('pPHONE_NUMBER').AsString := qContract.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
            qPaymentPeriod.Open;
          end;

          Result := True;
        end;
      end
      else if ((pRunMode = 'EDIT') or (pRunMode = 'READONLY')) then
      begin
        if VarToStr(pReceivedPaymentId) = '' then
        begin
          MessageDlg('Невозможно редактировать платёж. Код платежа не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          FReceivedPaymentId := pReceivedPaymentId;

          qFilials.Close;
          qFilials.Open;
          //qOperators.Close;
          //qOperators.Open;
          qTariffs.Close;
          qTariffs.Open;
          qTariffs.Filtered := False;

          if GetConstantValue('USE_TYPE_PAYMENTS') = '1' then  begin
            qPaymentTypes.Close;
            qPaymentTypes.Open;
          end
          else
          pnlTypePayment.Visible:=false;


          qReceivedPayments.Close;
          qReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').Value := pReceivedPaymentId;
          qReceivedPayments.Open;



          if qReceivedPayments.RecordCount = 0 then
          begin
            MessageDlg('Невозможно редактировать платёж. Не найден документ платежа с кодом '+VarToStr(pReceivedPaymentId)+'.', mtError, [mbOK], 0);
            Result := False;
          end
          else
          begin

            qContract.Close;
            qContract.ParamByName('CONTRACT_ID').Value := qReceivedPayments.FieldByName('CONTRACT_ID').Value;
            qContract.Open;

            //В РЕЖИМЕ РЕДАКТИРОВАНИЯ ЗАПРЕЩАЕМ ИЗМЕНЕНИЕ ПРИЗНАКА РАСПРЕДЕЛЕНИЕ ПО ГРУППЕ, УКАЗЫВАЕТСЯ ТОЛЬКО ПРИ СОЗДАНИИ ПЛАТЕЖА
            dbchkIsDistributed.ReadOnly := True;

            if qContract.Active and (qContract.RecordCount > 0) then
            begin
              qTariffs.DisableControls;
              try
                qTariffs.Filtered := False;
                qTariffs.Filter := 'OPERATOR_ID = '+ qContract.FieldByName('OPERATOR_ID').AsString;
                qTariffs.Filtered := True;
              finally
                qTariffs.EnableControls;
              end;
            end
            else
              qTariffs.Filtered := False;

            {
            qTariffs.Filter := '0=1';
            if pTARIFF_ID.Visible then
            begin
              if qContract.Active and (qContract.RecordCount > 0) then
                qTariffs.Filter := 'OPERATOR_ID = '+ qContract.FieldByName('OPERATOR_ID').AsString;
            end;
            qTariffs.Filtered := True;
            }
            //TARIFF_ID.Da
            //if GetConstantValue('SHOW_CONTRACT_GROUPS')='1' then

            {
            if GetConstantValue('SHOW_CONTRACT_GROUPS')='1' then
            begin
              qPaymentPeriod.Close;
              qPaymentPeriod.ParamByName('pPHONE_NUMBER').AsString := qContract.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
              qPaymentPeriod.Open;
              qPaymentPeriod.Locate('YEAR_MONTH', qReceivedPayments.FieldByName('PAYMENT_PERIOD').AsInteger, []);
            end;
            }

            // ЕСЛИ ПЛАТЕЖ БЫЛ РАСПРЕДЕЛЕН, ТОГДА ПОКАЗЫВАЕМ ЭЛЕМЕНТЫ ДЛЯ РАСПРЕДЕЛЕННОГО ПЛАТЕЖА
            if ( (qReceivedPayments.FieldByName('IS_DISTRIBUTED').AsInteger = 1) OR
                 (NOT VarIsNull(qReceivedPayments.FieldByName('PARENT_PAYMENT_ID').Value)) ) then
            begin
              pnlDISTREBUTED_PAYMENT.Visible := TRUE;
              qPaymentPeriod.Close;
              qPaymentPeriod.ParamByName('pPHONE_NUMBER').AsString := qContract.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
              qPaymentPeriod.Open;
              //устанавливаем значение для периода
              dblkcbbPaymentPeriod.KeyValue := qReceivedPayments.FieldByName('PAYMENT_PERIOD').AsInteger;
              dbchkIsDistributed.Enabled := False;
            end
            else
              pnlDISTREBUTED_PAYMENT.Visible := False;

            if pRunMode='READONLY' then
            begin
              // Данные загружаем, но менять не даем
              SetEnabledAll(False);
            end
            else
            begin
              SetEnabledAll(True);
              qReceivedPayments.Edit;
              if qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').IsNull then
                PAYMENT_DATE_TIME.Date := 0
              else
                PAYMENT_DATE_TIME.Date := qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').AsDateTime;
            end;

            Result := True;
          end;
        end;
      end
      else if pRunMode = 'DISABLE' then
      begin
        SetEnabledAll(False);

        qContract.Close;
        qReceivedPayments.Close;
        PAYMENT_DATE_TIME.Date := 0;

        Result := True;
      end;
    finally
      FReadData := False;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при открытии формы изменения договора'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

function TRegisterPaymentForm.PrepareFormNoContract(const pRunMode, pPhoneNumber: String;
                                          const pReceivedPaymentId : Variant;
                                          const pContractId: Variant
                                          ) : boolean;
begin
  Result := False;
  try
    FReadData := True;
    try
      FRunMode := pRunMode;

      if pRunMode = 'INSERT' then
      begin
        if not((VarToStr(pContractId) = '')or(VarToStr(pContractId) = '0')) then
        begin
          MessageDlg('Невозможно добавить платёж.  Передан код договора.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          SetEnabledAll(True);

          qFilials.Close;
          qFilials.Open;
          //qOperators.Close;
          //qOperators.Open;
          qTariffs.Close;
          qTariffs.Open;
          qTariffs.Filtered := False;

          qReceivedPayments.Close;
          qReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').Value := Null;
          qReceivedPayments.Open;
          qReceivedPayments.Append;
          PAYMENT_DATE_TIME.Date := Date();
          qReceivedPayments.FieldByName('CONTRACT_ID').Value := pContractId;
          qReceivedPayments.FieldByName('IS_CONTRACT_PAYMENT').AsInteger := 0;
          qReceivedPayments.FieldByName('PHONE_NUMBER').AsString := pPhoneNumber;

          Result := True;
        end;
      end
      else if (pRunMode = 'EDIT') then
      begin
        if VarToStr(pReceivedPaymentId) = '' then
        begin
          MessageDlg('Невозможно редактировать платёж. Код платежа не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          FReceivedPaymentId := pReceivedPaymentId;

          qFilials.Close;
          qFilials.Open;
          //qOperators.Close;
          //qOperators.Open;
          qTariffs.Close;
          qTariffs.Open;
          qTariffs.Filtered := False;

          qReceivedPayments.Close;
          qReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').Value := pReceivedPaymentId;
          qReceivedPayments.Open;

          if qReceivedPayments.RecordCount = 0 then
          begin
            MessageDlg('Невозможно редактировать платёж. Не найден документ платежа с кодом '+VarToStr(pReceivedPaymentId)+'.', mtError, [mbOK], 0);
            Result := False;
          end
          else
          begin
            SetEnabledAll(True);
            {
            qTariffs.Filter := '0=1';
            if pTARIFF_ID.Visible then
            begin
              if qContract.Active and (qContract.RecordCount > 0) then
                qTariffs.Filter := 'OPERATOR_ID = '+ qContract.FieldByName('OPERATOR_ID').AsString;
            end;
            qTariffs.Filtered := True;
            }
            //TARIFF_ID.Da

            qReceivedPayments.Edit;
            if qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').IsNull then
              PAYMENT_DATE_TIME.Date := 0
            else
              PAYMENT_DATE_TIME.Date := qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').AsDateTime;
            Result := True;
          end;
        end;
      end
      else if pRunMode = 'DISABLE' then
      begin
        SetEnabledAll(False);

        qContract.Close;
        qReceivedPayments.Close;
        PAYMENT_DATE_TIME.Date := 0;

        Result := True;
      end;
    finally
      FReadData := False;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при открытии формы изменения договора'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

function TRegisterPaymentForm.CheckDate(var pErrorMessage : String) : boolean;
var vIsError : boolean;
begin
  vIsError := False;

  if pCONTRACT_CHANGE_DATE.Visible then
  begin
    if (Trunc(PAYMENT_DATE_TIME.Date) = 0) then
    begin
      vIsError := True;
      pErrorMessage := 'Дата платежа должна быть заполнена';
    end
    else
    begin
      if qContract.Active and (qContract.RecordCount > 0) then
      begin
        if (Trunc(qContract.FieldByName('CONTRACT_DATE').AsDateTime) > Trunc(PAYMENT_DATE_TIME.Date)) then
        begin
          vIsError := True;
          pErrorMessage := 'Дата платежа должна быть больше даты договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_DATE').AsDateTime);
        end
{        else if (qReceivedPayments.State in [dsInsert]) and (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) then
        begin
          vIsError := True;
          pErrorMessage := 'Нельзя добавить платёж, договор уже расторгнут.';
        end}
        else if (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) and
                (Trunc(qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime) < Trunc(PAYMENT_DATE_TIME.Date)) then
        begin
          vIsError := True;
          pErrorMessage := 'Дата платежа не должна быть больше даты расторжения договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime);
        end;
      end;
    end;
  end;
  Result := (not vIsError);
end;

function TRegisterPaymentForm.SaveData: boolean;
var vErrorMessage : String;
begin
  Result := False;
  if (FRunMode = 'INSERT') or (FRunMode = 'EDIT') then
  begin
    // чтобы данные из DB компонентов перешли в Dataset
    if Self.Visible and btnOk.CanFocus() then
      btnOk.SetFocus();

    if qReceivedPayments.Active and ((qReceivedPayments.RecordCount > 0) or (qReceivedPayments.State in [dsInsert])) then
    begin
      if pFILIAL_ID.Visible and (qReceivedPayments.FieldByName('FILIAL_ID').AsString = '') then
      begin
        MessageDlg('Филиал должен быть быть указан', mtError, [mbOK], 0);
        if Self.Visible and FILIAL_ID.CanFocus() then
          FILIAL_ID.SetFocus();
      end
{      else if pOPERATOR_ID.Visible and (qReceivedPayments.FieldByName('OPERATOR_ID').AsString = '') then
      begin
        MessageDlg('Оператор должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and OPERATOR_ID.CanFocus() then
          OPERATOR_ID.SetFocus();
      end}
{      else if pTARIFF_ID.Visible and (qReceivedPayments.FieldByName('TARIFF_ID').AsString = '') then
      begin
        MessageDlg('Тариф должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and TARIFF_ID.CanFocus() then
          TARIFF_ID.SetFocus();
      end}
      {
      else if pCONTRACT_CHANGE_DATE.Visible and (Trunc(CONTRACT_CHANGE_DATE.Date) = 0) then
      begin
        MessageDlg('Дата изменения договора должна быть заполнена', mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CHANGE_DATE.CanFocus() then
          CONTRACT_CHANGE_DATE.SetFocus();
      end
      }
      else if (not CheckDate(vErrorMessage)) then
      begin
        MessageDlg(vErrorMessage, mtError, [mbOK], 0);
        if Self.Visible and PAYMENT_DATE_TIME.CanFocus() then
          PAYMENT_DATE_TIME.SetFocus();
      end
      {
      else if pCONTRACT_CHANGE_DATE.Visible and
              qContract.Active and
              (qContract.RecordCount > 0) and
              (Trunc(qContract.FieldByName('CONTRACT_DATE').AsDateTime) >= Trunc(CONTRACT_CHANGE_DATE.Date))
      then
      begin
        MessageDlg('Дата изменения договора должна быть больше даты договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_DATE').AsDateTime),
                   mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CHANGE_DATE.CanFocus() then
          CONTRACT_CHANGE_DATE.SetFocus();
      end
      else if pCONTRACT_CHANGE_DATE.Visible and
              qContract.Active and
              (qContract.RecordCount > 0) and
              (Trunc(qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime) >= Trunc(CONTRACT_CHANGE_DATE.Date))
      then
      begin
        MessageDlg('Дата изменения договора должна быть больше даты предыдущего изменения договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime),
                   mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CHANGE_DATE.CanFocus() then
          CONTRACT_CHANGE_DATE.SetFocus();
      end
      }
      else
      begin

        if dbchkIsDistributed.Checked then
        begin
          spADD_DISTRIBUTED_PAYMENT.Close;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('PHONE_NUMBER').AsString := qReceivedPayments.FieldByName('PHONE_NUMBER').AsString;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('PAYMEN_SUM').AsFloat := StrToFloat(DBEdit1.Text);
          spADD_DISTRIBUTED_PAYMENT.ParamByName('PAYMENT_DATE_TIME').AsDate := PAYMENT_DATE_TIME.Date;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('pREMARK').AsString := eREMARK.Text;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('RECEIVED_PAYMENT_TYPE_ID').AsInteger := qReceivedPayments.FieldByName('RECEIVED_PAYMENT_TYPE_ID').AsInteger; //dblkPaymentTypes.;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('YEAR_MONTH').AsInteger := qPaymentPeriod.FieldByName('YEAR_MONTH').AsInteger;
          spADD_DISTRIBUTED_PAYMENT.ParamByName('PRECEIVED_PAYMENT_ID').Value := null; // иначе ругается
        end;

        if (qReceivedPayments.State in [dsInsert]) then
        begin
          if dbchkIsDistributed.Checked then
          begin
            try
              spADD_DISTRIBUTED_PAYMENT.ParamByName('RUN_MODE').AsString := 'INSERT';
              spADD_DISTRIBUTED_PAYMENT.ExecProc;
              RESULT := TRUE;
            except
              on e : Exception do
                MessageDlg('Произошла ошибка при добавлении распределенного платежа, оплата не зарегистрирована.'#13#10 + e.Message, mtError, [mbOK], 0);
            end;
          end
          else
          begin
            qGetNewId.ExecSQL;
            FReceivedPaymentId := qGetNewId.ParamByName('RESULT').Value;
            qReceivedPayments.FieldByName('RECEIVED_PAYMENT_ID').Value := FReceivedPaymentId;
            qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').AsDateTime := Trunc(PAYMENT_DATE_TIME.Date);
          end;
        end
        else
        begin
          if dbchkIsDistributed.Checked then
          begin
            try
              spADD_DISTRIBUTED_PAYMENT.ParamByName('RUN_MODE').AsString := 'EDIT';
              spADD_DISTRIBUTED_PAYMENT.ParamByName('pRECEIVED_PAYMENT_ID').AsInteger := qReceivedPayments.FieldByName('RECEIVED_PAYMENT_ID').AsInteger;
              spADD_DISTRIBUTED_PAYMENT.ExecProc;
              RESULT := TRUE;
            except
              on e : Exception do
                MessageDlg('Произошла ошибка при обновлении распределенного платежа, платеж не обновлен.'#13#10 + e.Message, mtError, [mbOK], 0);
            end;
          end
        end;

        if not dbchkIsDistributed.Checked then
        begin
          try
            qReceivedPayments.Post;
            Result := True;
          except
            on e : exception do
              MessageDlg('Произошла ошибка, оплата не зарегистрирована.'#13#10 + e.Message, mtError, [mbOK], 0);
          end;
        end;
      end;
    end
    else
      MessageDlg('Не возможно сохранить параметры изменения договора.', mtError, [mbOK], 0);
  end
  else
    MessageDlg('Сохранить параметры изменения договора можно только в режиме добавления или редактирования.', mtError, [mbOK], 0);

if Result and chbSMS.Checked then
    begin
      SendSMS.ParamByName('PPHONE_NUMBER').AsString:=qContract.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
      Sendsms.ParamByName('PSMS_TEXT').AsString:='Зарегистрирован платеж на сумму: '+qReceivedPayments.FieldByName('PAYMENT_SUM').AsString+' руб.';
      Sendsms.ExecProc;
    end;

end;

procedure TRegisterPaymentForm.FormShow(Sender: TObject);
begin
  if not FReadData then
  begin
    if PAYMENT_SUM.CanFocus then
      PAYMENT_SUM.SetFocus();
  end;
end;


procedure TRegisterPaymentForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

procedure TRegisterPaymentForm.dbchkIsDistributedClick(Sender: TObject);
begin
  // при изменении состояния чекбокса, соответсвенно меняем видимость периода распределения платежа
  dblkcbbPaymentPeriod.Visible := dbchkIsDistributed.Checked;
  lblPaymentPeriod.Visible := dbchkIsDistributed.Checked;
end;

procedure TRegisterPaymentForm.eREMARKChange(Sender: TObject);
begin
  eREMARK.Hint := eREMARK.Text;
end;

procedure TRegisterPaymentForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    CanClose := SaveData;
  end;
  // иначе при открытом Combobox-е дает ошибку что не может
  if CanClose and btnCancel.CanFocus() then
    btnCancel.SetFocus();
end;

end.
