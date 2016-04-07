unit CancelContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ExtCtrls, Main, StdCtrls, DBCtrls,
  Buttons, ActnList, ComCtrls, Mask;

type
  TCancelContractForm = class(TForm)
    Panel1: TPanel;
    qContractCancel: TOraQuery;
    sbSelectAbonent: TSpeedButton;
    DBText1: TDBText;
    Label1: TLabel;
    dsContractCancel: TDataSource;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    DBText5: TDBText;
    Panel3: TPanel;
    Label6: TLabel;
    FILIAL_ID: TDBLookupComboBox;
    CONTRACT_CANCEL_TYPE_ID: TDBLookupComboBox;
    dsFilials: TDataSource;
    qFilials: TOraQuery;
    qCancelTypes: TOraQuery;
    dsCancelTypes: TDataSource;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    aSelectContract: TAction;
    aSelectAbonent: TAction;
    aClearCancelType: TAction;
    SpeedButton2: TSpeedButton;
    CONTRACT_CANCEL_DATE: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    SUM_GET: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    SUM_PUT: TDBEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnCancel: TBitBtn;
    Bevel2: TBevel;
    Label19: TLabel;
    Bevel1: TBevel;
    Label11: TLabel;
    qGetNewId: TOraStoredProc;
    dsContarct: TDataSource;
    qContract: TOraQuery;
    dsRecievedPayments: TDataSource;
    qReceivedPayments: TOraQuery;
    dsReceivedPayments: TDataSource;
    qReceivedPaymentsInsUpd: TOraQuery;
    procedure aClearCancelTypeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetEnabledAll(const pEnabled: boolean);
    function CheckDate(var pErrorMessage: String): boolean;
  public
    FReadData : boolean;
    FRunMode : String;
    FContractCancelId : Variant;
    FNewReceivedPaymentsId : Integer;
    FContractId : Variant;
    function  PrepareForm(const pRunMode: String;
                          const pContractCancelId : Variant;
                          const pContractId: Variant) : boolean;
    function SaveData: boolean;
  end;

//var
//  CancelContractForm: TCancelContractForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TCancelContractForm.SetEnabledAll(const pEnabled: boolean);
var i : Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TCustomEdit)
      or (Self.Components[i] is TCustomLabel)
      or (Self.Components[i] is TCommonCalendar)
      or (Self.Components[i] is TDBLookupControl)
    then
      (Self.Components[i] as TControl).Enabled := pEnabled;
  end;
end;

function TCancelContractForm.PrepareForm(const pRunMode: String;
                                          const pContractCancelId : Variant;
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
        if VarToStr(pContractId) = '' then
        begin
          MessageDlg('Ќе возможно зарегистрировать расторжени€ договора.  од договора не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          SetEnabledAll(True);

          qCancelTypes.Close;
          qCancelTypes.Open;
          qFilials.Close;
          qFilials.Open;
          qContract.Close;
          qContract.ParamByName('CONTRACT_ID').Value := pContractId;
          FContractId := pContractId;
          qContract.Open;

          qReceivedPayments.Close;
          qReceivedPayments.Open;

          qContractCancel.Close;
          qContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value := Null;
          qContractCancel.Open;
          qContractCancel.Insert;
          CONTRACT_CANCEL_DATE.Date := Date();
          //qContractCancel.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime := Date();
          //qContractCancel.FieldByName('FILIAL_ID').Value := GetDefaultFilialId();
          qContractCancel.FieldByName('CONTRACT_ID').Value := pContractId;

          Result := True;
        end;
      end
      else if pRunMode = 'EDIT' then
      begin
        if VarToStr(pContractCancelId) = '' then
        begin
          MessageDlg('Ќе возможно редактировать параметры расторжени€ договора.  од расторжени€ договора не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          FContractCancelId := pContractCancelId;

          qCancelTypes.Close;
          qCancelTypes.Open;
          qFilials.Close;
          qFilials.Open;

          qContractCancel.Close;
          qContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value := pContractCancelId;
          qContractCancel.Open;

          if qContractCancel.RecordCount = 0 then
          begin
            MessageDlg('Ќе возможно редактировать параметры расторжени€ договора. Ќе найдено расторжение договора с кодом .', mtError, [mbOK], 0);
            Result := False;
          end
          else
          begin
            SetEnabledAll(True);

            qContract.Close;
            qContract.ParamByName('CONTRACT_ID').Value := qContractCancel.FieldByName('CONTRACT_ID').Value;
            qContract.Open;

            qContractCancel.Edit;
            if qContractCancel.FieldByName('CONTRACT_CANCEL_DATE').IsNull then
              CONTRACT_CANCEL_DATE.Date := 0
            else
              CONTRACT_CANCEL_DATE.Date := qContractCancel.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime;

            Result := True;
          end;
        end;
      end
      else if pRunMode = 'DISABLE' then
      begin
        SetEnabledAll(False);

        qContract.Close;
        qContractCancel.Close;
        CONTRACT_CANCEL_DATE.Date := 0;

        Result := True;
      end;
    finally
      FReadData := False;
    end;
  except
    on e : exception do
      MessageDlg('ќшибка при открытии формы расторжени€ договора'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

function TCancelContractForm.CheckDate(var pErrorMessage : String) : boolean;
var vIsError : boolean;
begin
  vIsError := False;

  if (Trunc(CONTRACT_CANCEL_DATE.Date) = 0) then
  begin
    vIsError := True;
    pErrorMessage := 'ƒата расторжени€ договора должна быть заполнена';
  end
  else
  begin
    if qContract.Active and (qContract.RecordCount > 0) then
    begin
      if Trunc(qContract.FieldByName('CONTRACT_DATE').AsDateTime) > Trunc(CONTRACT_CANCEL_DATE.Date) then
      begin
        vIsError := True;
        pErrorMessage := 'ƒата расторжени€ договора должна быть больше даты заключени€ договора '+
                 FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_DATE').AsDateTime);
      end
      else if (qContractCancel.State in [dsInsert]) and (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) then
      begin
        vIsError := True;
        pErrorMessage := 'Ќе возможно повторно расторгнуть договор. ƒоговор уже расторгнут.';
      end
      else if (Trunc(qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime) > Trunc(CONTRACT_CANCEL_DATE.Date)) then
      begin
        vIsError := True;
        pErrorMessage := 'ƒата расторжени€ договора не должна быть меньше даты последнего изменени€ договора '+
                 FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime);
      end;
    end;
  end;
  Result := (not vIsError);
end;

function TCancelContractForm.SaveData: boolean;
var vErrorMessage : String;
    SQLString : String;

    vPhoneNumber : String;
    vPaymentSum : Double;
    vPaymentDateTime : TDateTime;
    vFillialId : String;
    vIsContractPayment : Byte;
    vRemark: String;

begin
  Result := False;
  if (FRunMode = 'INSERT') or (FRunMode = 'EDIT') then
  begin

    if qContractCancel.Active and ((qContractCancel.RecordCount > 0) or (qContractCancel.State in [dsInsert])) then
    begin
      if (not CheckDate(vErrorMessage)) then
      begin
        MessageDlg(vErrorMessage, mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CANCEL_DATE.CanFocus() then
          CONTRACT_CANCEL_DATE.SetFocus();
      end
      else if qContractCancel.FieldByName('FILIAL_ID').AsString = '' then
      begin
        MessageDlg('‘илиал должен быть определен', mtError, [mbOK], 0);
        if Self.Visible and FILIAL_ID.CanFocus() then
          FILIAL_ID.SetFocus();
      end
      else if (not qContractCancel.FieldByName('SUM_GET').IsNull) and (not qContractCancel.FieldByName('SUM_PUT').IsNull) then
      begin
        MessageDlg('ƒолжна быть заполнена только одна из сумм (полученна€ от клиента или выданна€ клиенту).', mtError, [mbOK], 0);
        if Self.Visible and SUM_GET.CanFocus() then
          SUM_GET.SetFocus();
      end
      else
      begin
        if (qContractCancel.State in [dsInsert]) then
        begin
          qContractCancel.FieldByName('CONTRACT_CANCEL_ID').Value := qGetNewId.ParamByName('RESULT').Value;
          FContractCancelId := qContractCancel.FieldByName('CONTRACT_CANCEL_ID').Value;

          if (FRunMode = 'INSERT') then
          begin

            //ShowMessage('—осто€ние Insert');
            qGetNewId.ExecSQL;

            if (not qContractCancel.FieldByName('SUM_GET').IsNull) or (not qContractCancel.FieldByName('SUM_PUT').IsNull) then
            begin

              vPhoneNumber := DBText5.Caption;   /// ѕотом »зменить !!!!!

              if not qContractCancel.FieldByName('SUM_GET').IsNull then
                vPaymentSum := StrToFloat(SUM_GET.Text)
              else if not qContractCancel.FieldByName('SUM_PUT').IsNull then
                vPaymentSum := StrToFloat(SUM_PUT.Text) * (-1);

              vPaymentDateTime := CONTRACT_CANCEL_DATE.Date;
              vFillialId := qContractCancel.FieldByName('FILIAL_ID').AsString;
              vIsContractPayment := 0;
              vRemark := CONTRACT_CANCEL_TYPE_ID.Text;

              FNewReceivedPaymentsId := StrToInt(qReceivedPayments.FieldByName('NEW_RECEIVED_PAYMENT_ID').AsString) + 1;
              //ShowMessage(IntToStr(FNewReceivedPaymentsId));

              SQLString := 'INSERT INTO RECEIVED_PAYMENTS (RECEIVED_PAYMENT_ID, PHONE_NUMBER, PAYMENT_SUM, PAYMENT_DATE_TIME, CONTRACT_ID, IS_CONTRACT_PAYMENT, FILIAL_ID, REMARK) values (' +
                            #39 + IntToStr(FNewReceivedPaymentsId) + #39 + ', ' + #39 + vPhoneNumber + #39 + ',to_number(replace(''' + FloatToStr(vPaymentSum) + ''', '','', ''.''), ''999999999999999.99''), to_date(' + #39 + DateToStr(vPaymentDateTime) + #39 + ', ' + #39 + 'dd.mm.yyyy' + #39 + '), ' + IntToStr(FContractId) +
                            ', ' + IntToStr(vIsContractPayment) + ', ' + vFillialId + ', ' + #39 + vRemark + #39 + ')';

              qReceivedPaymentsInsUpd.Close;
              qReceivedPaymentsInsUpd.SQL.Text := SQLString;

              //InputBox(qReceivedPaymentsInsUpd.SQL.Text, qReceivedPaymentsInsUpd.SQL.Text, qReceivedPaymentsInsUpd.SQL.Text);

              qReceivedPaymentsInsUpd.ExecSQL;

              qContractCancel.FieldByName('RECEIVED_PAYMENT_ID').Value := FNewReceivedPaymentsId;

            end;
          end;
        end

        else if (FRunMode = 'EDIT') then
        begin
          vPhoneNumber := DBText5.Caption;   /// ѕотом »зменить !!!!!

          if not qContractCancel.FieldByName('SUM_GET').IsNull then
            vPaymentSum := StrToFloat(SUM_GET.Text)
          else if not qContractCancel.FieldByName('SUM_PUT').IsNull then
            vPaymentSum := StrToFloat(SUM_PUT.Text) * (-1);

          vPaymentDateTime := CONTRACT_CANCEL_DATE.Date;
          vFillialId := qContractCancel.FieldByName('FILIAL_ID').AsString;
          vIsContractPayment := 0;
          vRemark := CONTRACT_CANCEL_TYPE_ID.Text;

          qContractCancel.Open;
          FNewReceivedPaymentsId := StrToInt(qContractCancel.FieldByName('RECEIVED_PAYMENT_ID').AsString);
          //ShowMessage(IntToStr(FNewReceivedPaymentsId));

          qReceivedPaymentsInsUpd.Close;
          SQLString := 'UPDATE RECEIVED_PAYMENTS SET PAYMENT_SUM = '  + FloatToStr(vPaymentSum) +
                                                             ', FILIAL_ID = ' + vFillialId +
                                                             ', PAYMENT_DATE_TIME = ' + 'to_date(' + #39 + DateToStr(vPaymentDateTime) + #39 + ', ' + #39 + 'dd.mm.yyyy' + #39 +
                                                             '), REMARK = '  + #39 + vRemark + #39 +
                                                             ' WHERE RECEIVED_PAYMENT_ID = ' + IntToStr(FNewReceivedPaymentsId) + '';
          qReceivedPaymentsInsUpd.SQL.Text := SQLString;
          //ShowMessage(qReceivedPaymentsInsUpd.SQL.Text);
          qReceivedPaymentsInsUpd.ExecSQL;


        end;

        qContractCancel.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime := Trunc(CONTRACT_CANCEL_DATE.Date);
        //
        try
          qContractCancel.Post;
          Result := True;
        except
          on e : exception do
            MessageDlg('Ќе возможно сохранить параметры расторжени€ договора.'#13#10 + e.Message, mtError, [mbOK], 0);
        end;
      end;
    end
    else
      MessageDlg('Ќе возможно сохранить параметры расторжени€ договора.', mtError, [mbOK], 0);
  end
  {else if FRunMode = 'DISABLE' then
    begin
      qContractCancel.Open;
      FNewReceivedPaymentsId := StrToInt(qContractCancel.FieldByName('RECEIVED_PAYMENT_ID').AsString);
      //ShowMessage(IntToStr(FNewReceivedPaymentsId));

      qReceivedPaymentsInsUpd.Close;
      SQLString := 'DELETE FROM RECEIVED_PAYMENTS WHERE RECEIVED_PAYMENT_ID = ' + IntToStr(FNewReceivedPaymentsId) + '';
      qReceivedPaymentsInsUpd.SQL.Text := SQLString;
      //ShowMessage(qReceivedPaymentsInsUpd.SQL.Text);
      qReceivedPaymentsInsUpd.ExecSQL;

    end}

  else
    MessageDlg('—охранить параметры расторжени€ договора можно только в режиме добавлени€ или редактировани€.', mtError, [mbOK], 0);
end;

procedure TCancelContractForm.aClearCancelTypeExecute(Sender: TObject);
begin
  if qContractCancel.Active and ((qContractCancel.RecordCount > 0) or (qContractCancel.State in [dsInsert])) then
    qContractCancel.FieldByName('CONTRACT_CANCEL_TYPE_ID').Value := Null;
end;

procedure TCancelContractForm.FormShow(Sender: TObject);
begin
  if not FReadData then
  begin
    if CONTRACT_CANCEL_TYPE_ID.CanFocus then
      CONTRACT_CANCEL_TYPE_ID.SetFocus();
  end;
end;

procedure TCancelContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

procedure TCancelContractForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    CanClose := SaveData;
  end;
end;

procedure TCancelContractForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
    qFilials.SQL.Append('    AND FILIAL_ID = ' + IntToStr(MainForm.FFilial));
end;

end.
