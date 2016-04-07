unit uInsPayment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.StdCtrls, sComboBox, uRepFrm, TimedMsgBox,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sEdit, sComboEdit,  System.StrUtils,
  sCurrEdit, sCurrencyEdit, Vcl.ExtCtrls, sBevel, sPanel, Vcl.Buttons, sBitBtn,
  Data.DB, MemDS, DBAccess, Ora, DBCtrlsEh;

type
  TInsPaymentFrm = class(TChildForm)
    sPanel1: TsPanel;
    cbVirtAccount: TsComboBox;
    deDatePayment: TsDateEdit;
    seBIK: TsEdit;
    sCurrencyEdit: TsCurrencyEdit;
    seDocNumber: TsEdit;
    sePAYMENT_PURPOSE: TsEdit;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sBevel3: TsBevel;
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    bbShowVirt_Acc: TsBitBtn;
    qPhone: TOraQuery;
    sePhone: TsEdit;
    bbShowPhone: TsBitBtn;
    qPhoneCNT: TFloatField;
    sBitBtn1: TsBitBtn;
    cbTypePayments: TsComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure seDocNumberChange(Sender: TObject);
    procedure CheckControl;
    procedure bbShowVirt_AccClick(Sender: TObject);
    procedure bbShowPhoneClick(Sender: TObject);
    procedure sePhoneExit(Sender: TObject);
    procedure deDatePaymentExit(Sender: TObject);
    procedure sCurrencyEditExit(Sender: TObject);
    procedure cbVirtAccountExit(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);

  private
    { Private declarations }
    frm_from : TRepFrm;
  public
   V_A_NAME: String;
   V_A_ID : Integer;
   NEW_VA : Boolean;
   constructor Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean); reintroduce; overload;

    { Public declarations }
  end;

var
  InsPaymentFrm: TInsPaymentFrm;

implementation

{$R *.dfm}

uses uRepPayments, uDm, RefVirtual_Operators, RefPhones , RefPaymentsType;

constructor TInsPaymentFrm.Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean);
begin
  inherited Create(AOwner, AFormVar, Cpt, ShM);
  frm_from := TRepFrm(AOwner);
end;


procedure TInsPaymentFrm.deDatePaymentExit(Sender: TObject);
begin
  inherited;
  if (deDatePayment.Text = '') then
  begin
    TimedMessageBox('Обязательно указывать дату платежа!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 10, 3);
    deDatePayment.SetFocus;
  end;
  CheckControl;
end;

procedure TInsPaymentFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Dm.qPAYMENTS_TYPE.Open;
  Dm.qPAYMENTS_TYPE.First;
  while not Dm.qPAYMENTS_TYPE.EOF do
  begin
    cbTypePayments.Items.AddObject(Dm.qPAYMENTS_TYPE.FieldByName('NAME_PAYMENTS_TYPE').AsString,
    Pointer(Dm.qPAYMENTS_TYPE.FieldByName('ID_PAYMENTS_TYPE').AsInteger));
    Dm.qPAYMENTS_TYPE.Next;
  end;
  cbTypePayments.ItemIndex := 0;
  Dm.qPAYMENTS_TYPE.First;
  frm_from.qVirt_Acc.First;
  while not frm_from.qVirt_Acc.EOF do
  begin
    cbVirtAccount.Items.AddObject(Trim(frm_from.qVirt_Acc.FieldByName('VIRTUAL_ACCOUNTS_name').AsString),
     Pointer(frm_from.qVirt_Acc.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger));
    frm_from.qVirt_Acc.Next;
  end;
  frm_from.qVirt_Acc.First;
  cbVirtAccount.ItemIndex := 0;

end;

procedure TInsPaymentFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ((ssCtrl In Shift) And (Key=Ord('s'))) Then
    ModalResult := mrOk;
end;

procedure TInsPaymentFrm.bbShowPhoneClick(Sender: TObject);
var
  New_F: TChildForm;
  PHONE_ID : Int64;
 begin
  inherited;
  New_F := TRefPhonesForm.Create(self, New_F, 'Справочник телефонов', True);
  try
    if (New_F.ShowModal = mrOk) then
    begin
      PHONE_ID  := TRefPhonesForm(New_F).qRef.FieldByName('PHONE_ID').AsLargeInt;
      sePhone.Text := IntToStr(PHONE_ID);
    end;
  finally
    New_F.Free;
  end;
end;

procedure TInsPaymentFrm.sBitBtn1Click(Sender: TObject);
var
  New_F: TChildForm;
 i, ID_PAYMENTS_TYPE : Integer;
 txt, txt2,  NAME_PAYMENTS_TYPE : string;
 is_find : Boolean;
 begin
  inherited;
  New_F := TRefPaymentsTypefrm.Create(self, New_F, 'Справочник телефонов', True);
  TRefPaymentsTypefrm(New_F).qRef.locate('NAME_PAYMENTS_TYPE',cbTypePayments.text,[]);
  try
    if (New_F.ShowModal = mrOk) then
    begin
      NAME_PAYMENTS_TYPE := TRefPaymentsTypefrm(New_F).qRef.FieldByName('NAME_PAYMENTS_TYPE').AsString;
      ID_PAYMENTS_TYPE  := TRefPaymentsTypefrm(New_F).qRef.FieldByName('ID_PAYMENTS_TYPE').AsInteger;
      LockWindowUpdate(cbTypePayments.Handle);
      is_find := False;
      for i := 0 to cbTypePayments.Items.Count - 1 do
      begin
        txt := UpperCase(cbTypePayments.Items.Strings[i]);
        txt2 := UpperCase(Trim(NAME_PAYMENTS_TYPE));

        if (txt = txt2) then
        begin
          cbTypePayments.ItemIndex := i;
          is_find := True;
          Break;
        end;
      end;
      if not is_find then
      begin
        cbTypePayments.Items.AddObject(NAME_PAYMENTS_TYPE,  Pointer(ID_PAYMENTS_TYPE));
        cbTypePayments.ItemIndex := cbTypePayments.Items.Count-1;
        NEW_VA := True;
      end;
    end;
  finally
    New_F.Free;
     LockWindowUpdate(0);
  end;
end;

procedure TInsPaymentFrm.sCurrencyEditExit(Sender: TObject);
begin
  inherited;
  if sCurrencyEdit.AsInteger = 0 then
  begin
    TimedMessageBox('Обязательно указывать сумму платежа!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 10, 3);
    sCurrencyEdit.SetFocus;
  end;
  CheckControl;
end;

procedure TInsPaymentFrm.sePhoneExit(Sender: TObject);
var
  New_F: TChildForm;
  PHONE_ID : Int64;
begin
  inherited;
  if (sePhone.Text <> '' )then
  begin
    qPhone.Close;
    qPhone.ParamByName('PHONE_ID').AsString := sePhone.Text;
    qPhone.Open;
    if (qPhone.FieldByName('cnt').Asinteger = 0) then
    begin
      if TimedMessageBox('Такого номера нет! Добавить его справочник?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3) = mrYes then
      begin
        New_F := TRefPhonesForm.Create(self, New_F, 'Справочник телефонов', True);
        try
          TRefPhonesForm(New_F).aInsert.Execute;
          if (New_F.ShowModal = mrOk) then
          begin
            PHONE_ID  := TRefPhonesForm(New_F).qRef.FieldByName('PHONE_ID').AsLargeInt;
            sePhone.Text := IntToStr(PHONE_ID);
          end;
        finally
          New_F.Free;
          sePhone.SetFocus;
        end;
      end else begin
        sePhone.SetFocus;
      end;
    end;
  end;
end;

procedure TInsPaymentFrm.seDocNumberChange(Sender: TObject);
begin
  inherited;
   CheckControl;
end;

procedure TInsPaymentFrm.bbShowVirt_AccClick(Sender: TObject);
var
  New_F: TChildForm;
  txt, txt2: String;
  i : Integer;
  is_find : Boolean;
begin
  inherited;
  New_F := TRefVirtual_OperatorsForm.Create(self, New_F, 'Виртуальный счет', True);
  TRefVirtual_OperatorsForm(New_F).qRef.locate('VIRTUAL_ACCOUNTS_NAME',cbVirtAccount.text,[]);
  try
    if (New_F.ShowModal = mrOk) then
    begin
      V_A_NAME := TRefVirtual_OperatorsForm(New_F).qRef.FieldByName('VIRTUAL_ACCOUNTS_NAME').AsString;
      V_A_ID  := TRefVirtual_OperatorsForm(New_F).qRef.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
      LockWindowUpdate(cbVirtAccount.Handle);
      is_find := False;
      for i := 0 to cbVirtAccount.Items.Count - 1 do
      begin
        txt := UpperCase(cbVirtAccount.Items.Strings[i]);
        txt2 := UpperCase(Trim(V_A_NAME));

        if (txt = txt2) then
        begin
          cbVirtAccount.ItemIndex := i;
          is_find := True;
          Break;
        end;
      end;
      if not is_find then
      begin
        cbVirtAccount.Items.AddObject(V_A_NAME,  Pointer(V_A_ID));
        cbVirtAccount.ItemIndex := cbVirtAccount.Items.Count-1;
        NEW_VA := True;
      end;
    end;
  finally
    New_F.Free;
     LockWindowUpdate(0);
  end;
end;

procedure TInsPaymentFrm.cbVirtAccountExit(Sender: TObject);
begin
  inherited;
  CheckControl;
end;

procedure TInsPaymentFrm.CheckControl;
begin
  sBsave.Enabled := (seDocNumber.Text <> '');
  sBsave.Enabled := sBsave.Enabled and (deDatePayment.Text<>'');
  sBsave.Enabled := sBsave.Enabled and (sCurrencyEdit.AsInteger <> 0);

end;
end.
