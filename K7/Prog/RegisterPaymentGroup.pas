unit RegisterPaymentGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ora, DB, MemDS, DBAccess, ActnList, StdCtrls, Buttons, Mask,
  DBCtrls, ComCtrls, ExtCtrls;

type
  TRegisterPaymentGroupForm = class(TForm)
    qFilials: TOraQuery;
    dsFilials: TDataSource;
    qReceivedPayments: TOraQuery;
    Panel1: TPanel;
    lblGroup_name: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label19: TLabel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Label11: TLabel;
    pButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    pFILIAL_ID: TPanel;
    Label14: TLabel;
    cbFilial: TComboBox;
    pCONTRACT_CHANGE_DATE: TPanel;
    Label7: TLabel;
    PAYMENT_DATE_TIME: TDateTimePicker;
    pSUM_GET: TPanel;
    Label20: TLabel;
    PAYMENT_SUM: TEdit;
    pRemark: TPanel;
    Label6: TLabel;
    eREMARK: TEdit;
    qContract: TOraQuery;
    qInsReceivedPayments: TOraQuery;
    qUpdReceivedPayments: TOraQuery;
    qBillsPast: TOraQuery;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PAYMENT_SUMKeyPress(Sender: TObject; var Key: Char);
  private
    function CheckDate(var pErrorMessage : String) : boolean;
  public
    FRunMode : String;
    FGroupId : Integer;
    FReceivedPaymentId : Integer;
    function PrepareForm(const pRunMode: String;
                         const pReceivedPaymentId, pGroupId: Integer;
                         const pGroup_Name: String): boolean;
    function SaveData: boolean;
  end;


implementation

{$R *.dfm}

uses ContractsRegistration_Utils,main;

procedure TRegisterPaymentGroupForm.PAYMENT_SUMKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (key in['0'..'9',DecimalSeparator,#8]) then key:=#0;
end;

function TRegisterPaymentGroupForm.PrepareForm(const pRunMode: String;
                                          const pReceivedPaymentId : Integer;
                                          const pGroupId : Integer;
                                          const pGroup_Name: String
                                          ) : boolean;
var
  cnt, year_month_past : integer;
begin
    try
      FRunMode := pRunMode;
      lblGroup_Name.Caption:=pGroup_Name;

      if pRunMode = 'INSERT' then
      begin
        if pGroupId = 0 then
        begin
          MessageDlg('Невозможно добавить платёж. Код группы не передан.', mtError, [mbOK], 0);
          Exit(False);
        end
        else
        begin
           //Проверка наличия выставленных счетов прошлого месяца
          qBillsPast.close;
          qBillsPast.ParamByName('GROUP_ID').AsInteger:=pGroupId;
          qBillsPast.open;
          cnt:=qBillsPast.FieldByName('cnt').AsInteger;
          year_month_past:=qBillsPast.FieldByName('year_month_past').AsInteger;
          qBillsPast.close;
          if cnt = 0 then
          begin
            MessageDlg('Невозможно добавить платёж. Ни в одном из прошлых месяцов нет выставленных счетов.', mtError, [mbOK], 0);
            Exit(False);
          end;

          FGroupId:=pGroupId;
          //Заполняем выпадающий список Филиал
          qFilials.Close;
          qFilials.Open;
          while not qFilials.EOF do
            begin
              cbFilial.Items.AddObject(
                qFilials.FieldByName('FILIAL_NAME').AsString,
                TObject(qFilials.FieldByName('FILIAL_ID').AsInteger)
               );
              qFilials.Next;
          end;
          qFilials.Close;

          PAYMENT_DATE_TIME.Date := Date();

          qInsReceivedPayments.Close;
          qInsReceivedPayments.ParamByName('IS_CONTRACT_PAYMENT').AsInteger := 0;
          qInsReceivedPayments.ParamByName('GROUP_ID').AsInteger := pGroupId;
          qInsReceivedPayments.ParamByName('YEAR_MONTH_PAST').AsInteger := year_month_past;
          Exit(True);
        end;
      end
      else if pRunMode = 'EDIT' then
      begin
        if pReceivedPaymentId = 0 then
        begin
          MessageDlg('Невозможно редактировать платёж. Код платежа не передан.', mtError, [mbOK], 0);
          Exit(False);
        end
        else
        begin
          FReceivedPaymentId := pReceivedPaymentId;
          //Заполняем выпадающий список Филиал
          qFilials.Close;
          qFilials.Open;
          while not qFilials.EOF do
            begin
              cbFilial.Items.AddObject(
                qFilials.FieldByName('FILIAL_NAME').AsString,
                TObject(qFilials.FieldByName('FILIAL_ID').AsInteger)
               );
              qFilials.Next;
          end;
          qFilials.Close;
          //Проверка наличия платежа
          qReceivedPayments.Close;
          qReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').AsInteger := pReceivedPaymentId;
          qReceivedPayments.Open;
          if qReceivedPayments.RecordCount = 0 then
          begin
            MessageDlg('Невозможно редактировать платёж. Не найден документ платежа с кодом '+IntToStr(pReceivedPaymentId)+'.', mtError, [mbOK], 0);
            qReceivedPayments.Close;
            Exit(False);
          end
          else
          begin
            //Филиал
            cbFilial.ItemIndex:=cbFilial.Items.IndexOfObject(tObject(qReceivedPayments.FieldByName('FILIAL_ID').AsInteger));
            //Дата платежа
            if qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').IsNull then
              PAYMENT_DATE_TIME.Date := 0
            else
              PAYMENT_DATE_TIME.Date := qReceivedPayments.FieldByName('PAYMENT_DATE_TIME').AsDateTime;
            //Полученная сумма
            PAYMENT_SUM.Text:=qReceivedPayments.FieldByName('PAYMENT_SUM').AsString;
            //Примечание
            eREMARK.Text:=qReceivedPayments.FieldByName('REMARK').AsString;

            qUpdReceivedPayments.Close;
            qUpdReceivedPayments.ParamByName('RECEIVED_PAYMENT_ID').Value := pReceivedPaymentId;

            qReceivedPayments.Close;
            Exit(True);
          end;
        end;
      end;
  except
    on e : exception do begin
      MessageDlg('Ошибка при открытии формы регистрации платежа'#13#10+e.Message, mtError, [mbOK], 0);
      Exit(False);
    end;
  end;
end;

function TRegisterPaymentGroupForm.SaveData: boolean;
var vErrorMessage : String;
begin
  Result := False;

  if cbFilial.Text = '' then
  begin
    MessageDlg('Филиал должен быть указан', mtError, [mbOK], 0);
    if Self.Visible and cbFilial.CanFocus() then
      cbFilial.SetFocus();
  end
  else if (not CheckDate(vErrorMessage)) then
  begin
    MessageDlg(vErrorMessage, mtError, [mbOK], 0);
    if Self.Visible and PAYMENT_DATE_TIME.CanFocus() then
      PAYMENT_DATE_TIME.SetFocus();
  end
  else
  begin
    if FRunMode = 'INSERT' then
    begin
      qInsReceivedPayments.ParamByName('FILIAL_ID').AsInteger := Integer(cbFilial.Items.Objects[cbFilial.ItemIndex]);
      qInsReceivedPayments.ParamByName('PAYMENT_SUM').AsFloat := StrToFloat(payment_sum.text);
      qInsReceivedPayments.ParamByName('PAYMENT_DATE_TIME').AsDateTime := Trunc(PAYMENT_DATE_TIME.Date);
      qInsReceivedPayments.ParamByName('REMARK').AsString := eREMARK.Text;
      try
        qInsReceivedPayments.ExecSQL;
        Result := True;
      except
        on e : exception do
          MessageDlg('Произошла ошибка, оплата не зарегистрирована.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end
    else if FRunMode = 'EDIT' then
    begin
      qUpdReceivedPayments.ParamByName('FILIAL_ID').AsInteger := Integer(cbFilial.Items.Objects[cbFilial.ItemIndex]);
      qUpdReceivedPayments.ParamByName('PAYMENT_SUM').AsFloat := StrToFloat(payment_sum.text);
      qUpdReceivedPayments.ParamByName('PAYMENT_DATE_TIME').AsDateTime := Trunc(PAYMENT_DATE_TIME.Date);
      qUpdReceivedPayments.ParamByName('REMARK').AsString := eREMARK.Text;
      try
        qUpdReceivedPayments.ExecSQL;
        Result := True;
      except
        on e : exception do
          MessageDlg('Произошла ошибка, оплата не отредактирована.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

function TRegisterPaymentGroupForm.CheckDate(var pErrorMessage : String) : boolean;
var vIsError : boolean;
begin
  vIsError := False;

  if (Trunc(PAYMENT_DATE_TIME.Date) = 0) then
  begin
    vIsError := True;
    pErrorMessage := 'Дата платежа должна быть заполнена';
  end;
//проверка дат временно убрана
{    else
    begin
      try
        qContract.Close;
        qContract.ParamByName('GROUP_ID').AsInteger:=FGroupId;
        qContract.Open;
        if qContract.Active and (qContract.RecordCount > 0) then
        begin
          if (Trunc(qContract.FieldByName('CONTRACT_DATE').AsDateTime) > Trunc(PAYMENT_DATE_TIME.Date)) then
          begin
            vIsError := True;
            pErrorMessage := 'Дата платежа должна быть больше даты договора '+
                     FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_DATE').AsDateTime);
          end
          else if (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) and
                  (Trunc(qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime) < Trunc(PAYMENT_DATE_TIME.Date)) then
          begin
            vIsError := True;
            pErrorMessage := 'Дата платежа не должна быть больше даты расторжения договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime);
          end;
        end;
      finally
        qContract.Close;
      end;
    end;}
  Result := (not vIsError);
end;


procedure TRegisterPaymentGroupForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    CanClose := SaveData;
  end;
  if CanClose and btnCancel.CanFocus() then
    btnCancel.SetFocus();
end;

procedure TRegisterPaymentGroupForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

end.
