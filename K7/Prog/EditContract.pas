unit EditContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EditAbonentFrame, ComCtrls, ExtCtrls, Main, ActnList, Buttons,
  DB, MemDS, DBAccess, Ora, DBCtrls, StdCtrls, Mask, sComboBox;

type
  TEditContractForm = class(TForm)
    Panel1: TPanel;
    pcAbonent: TTabControl;
    tsNewAbonent: TTabSheet;
    tsEditAbonent: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    qContracts: TOraQuery;
    qFilials: TOraQuery;
    qOperators: TOraQuery;
    qPhoneTypes: TOraQuery;
    qTariffs: TOraQuery;
    Label1: TLabel;
    CONTRACT_NUM: TDBEdit;
    Label2: TLabel;
    CONTRACT_DATE: TDateTimePicker;
    FILIAL_ID: TDBLookupComboBox;
    Label3: TLabel;
    pPhoneInfo: TPanel;
    dsContracts: TDataSource;
    dsFilials: TDataSource;
    dsOperators: TDataSource;
    dsPhoneTypes: TDataSource;
    dsTariffs: TDataSource;
    Label4: TLabel;
    OPERATOR_ID: TDBLookupComboBox;
    Label5: TLabel;
    PHONE_NUMBER_TYPE: TDBLookupComboBox;
    Label6: TLabel;
    PHONE_NUMBER_FEDERAL: TDBEdit;
    Label7: TLabel;
    TARIFF_ID_: TDBLookupComboBox;
    Label8: TLabel;
    SIM_NUMBER: TDBEdit;
    Label9: TLabel;
    PHONE_NUMBER_CITY: TDBEdit;
    Panel5: TPanel;
    Label19: TLabel;
    Bevel2: TBevel;
    Label11: TLabel;
    START_BALANCE: TDBText;
    Label12: TLabel;
    CONNECT_PRICE: TDBText;
    Label13: TLabel;
    ADVANCE_PAYMENT: TDBText;
    Label14: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    qGetNewId: TOraStoredProc;
    Label16: TLabel;
    lRealBalance: TLabel;
    EditAbonent: TEditAbonentFrme;
    Label15: TLabel;
    DISCONNECT_LIMIT: TDBEdit;
    tCheckContractNum: TTimer;
    qNumDouble: TOraQuery;
    qNextNum: TOraStoredProc;
    RECEIVED_SUM: TDBEdit;
    Label17: TLabel;
    qSaveContractPayment: TOraStoredProc;
    GOLD_NUMBER_SUM: TDBEdit;
    DoublePhoneNum: TOraQuery;
    qExistPhoneNum: TOraQuery;
    cbTariffNameold: TComboBox;
    lTariffCodeCaption: TLabel;
    qPhoneTariff: TOraQuery;
    lTariffCode: TLabel;
    spSendNotice: TOraStoredProc;
    rgTypePaid: TRadioGroup;
    cbTariffName: TComboBox;
    ABONENT_TARIFF_OPTION: TDBEdit;
    lClientTariffOption: TLabel;
    Panel4: TPanel;
    cbDailyAbonPay: TCheckBox;
    spDailyPay: TOraStoredProc;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsContractsDataChange(Sender: TObject; Field: TField);
    procedure dsOperatorsDataChange(Sender: TObject; Field: TField);
    procedure pcAbonentChanging(Sender: TObject; var AllowChange: Boolean);
    procedure tCheckContractNumTimer(Sender: TObject);
    procedure CONTRACT_NUMChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PHONE_NUMBER_TYPEClick(Sender: TObject);
    procedure qContractsAfterInsert(DataSet: TDataSet);
    procedure OPERATOR_IDClick(Sender: TObject);
    procedure dsTariffsDataChange(Sender: TObject; Field: TField);
    procedure RECEIVED_SUMChange(Sender: TObject);
    procedure WinControlEnter(Sender: TObject);
    procedure WinControlExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qContractsAfterOpen(DataSet: TDataSet);
    procedure cbTariffNameoldChange(Sender: TObject);
    procedure PHONE_NUMBER_FEDERALChange(Sender: TObject);
    procedure DISCONNECT_LIMITChange(Sender: TObject);

    procedure cbTariffNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbTariffNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ABONENT_TARIFF_OPTIONChange(Sender: TObject);

  private
    FContractId : Variant;
    vContractNumNew: Variant; // новый номер, который получается 1 раз
    FReadData : boolean;
    FRunMode : String;
    FChanging : boolean;
    FTariffList : array of record
      TariffID : Integer;
      TariffCode : String;
    end;
    FSelectedTariffcode: string;
    FPhoneTariffCode: string;
    FCheckPhoneTariffCode : Boolean;
    FIsAdmin : boolean;

    procedure SetEnabledAll(const pEnabled: boolean);
    function DublicatesExists(const pNum: Variant; const pExceptContractId: Variant): boolean;
    function CheckContractNum(var pErrorMessage: String): boolean;
    procedure SetTariffFilter;
    procedure CalcRealBalance;
    procedure SetTariffIndex;
    procedure MoveToNextControl;
    procedure SetControlHandlers(Parent: TComponent);
    function GetPhoneNumber : String;
    function EditcbDailyAbonPayBanned : Boolean;
  public
    procedure PrepareForm(const pRunMode: String; const pContractId: Variant);
    function SaveData : boolean;

    property PhoneNumber : string read GetPhoneNumber;
    property ContractID : Variant read FContractId;
  end;

//var
//  Form1: TForm1;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, DMUnit;

{
function DoAddContract(var pContractId : Variant) : boolean;
var EditContractForm : TEditContractForm;
begin
  EditContractForm := TEditContractForm.Create(Application);
  try
    EditContractForm.Caption := 'Добавление договора';
    EditContractForm.FRunMode := 'INSERT';
    Result := (mrOk = EditContractForm.ShowModal);
    pContractId := EditContractForm.FContractId;
  finally
    EditContractForm.Free;
  end;
end;

function DoEditContract(const pContractId : Variant) : boolean;
var EditContractForm : TEditContractForm;
begin
  EditContractForm := TEditContractForm.Create(Application);
  try
    EditContractForm.Caption := 'Редактирование параметров договора';
    EditContractForm.FRunMode := 'EDIT';
    EditContractForm.FContractId := pContractId;
    Result := (mrOk = EditContractForm.ShowModal);
  finally
    EditContractForm.Free;
  end;
end;
}

procedure TEditContractForm.SetEnabledAll(const pEnabled: boolean);
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

procedure TEditContractForm.PrepareForm(const pRunMode: String; const pContractId: Variant);
var IsAdmin: boolean;
begin
  // если был получен номер договора, и затем он был изменен вручную (освободить его)
  if (not VarIsNull(vContractNumNew)) and  (vContractNumNew <> '') then
  begin
    FreeContractNum(vContractNumNew);
    vContractNumNew := Null;
  end;
  MainForm.CheckAdminPrivs(IsAdmin);
  FIsAdmin:= IsAdmin;

  FReadData := True;
  try
    FRunMode := pRunMode;

    if pRunMode = 'INSERT' then
    begin
      SetEnabledAll(True);

      qFilials.Close;
      qFilials.Open;
      qOperators.Close;
      qOperators.Open;
      qPhoneTypes.Close;
      qPhoneTypes.Open;
      qTariffs.Close;
      qTariffs.Open;

      qContracts.Close;
      qContracts.ParamByName('CONTRACT_ID').Value := Null;
      qContracts.Open;
      qContracts.Insert;
      CONTRACT_DATE.Date := Date();
      // сбрасываем стоимость разовых услуг
      dsTariffsDataChange(nil, nil);

      pcAbonent.TabIndex := 0; // новый абонент
      EditAbonent.PrepareFrame('INSERT', Null);

      vContractNumNew := GetNextContractNum();
      qContracts.FieldByName('CONTRACT_NUM').Value := vContractNumNew;
      cbDailyAbonPay.Checked:=false;
    end
    else if pRunMode = 'EDIT' then
    begin
      if VarToStr(pContractId) = '' then
        MessageDlg('Не возможно редактировать параметры договора. Код договора не передан.', mtError, [mbOK], 0)
      else
      begin
        cbDailyAbonPay.Visible:=FIsAdmin;
        FContractId := pContractId;

        qFilials.Close;
        qFilials.Open;
        qOperators.Close;
        qOperators.Open;
        qPhoneTypes.Close;
        qPhoneTypes.Open;
        qTariffs.Close;
        qTariffs.Open;

        qContracts.Close;
        qContracts.ParamByName('CONTRACT_ID').Value := pContractId;
        qContracts.Open;

        if qContracts.RecordCount = 0 then
          MessageDlg('Не возможно редактировать параметры договора. Не найден договор с кодом .', mtError, [mbOK], 0)
        else
        begin
          SetEnabledAll(True);

          qContracts.Edit;
          if qContracts.FieldByName('CONTRACT_DATE').IsNull then
            CONTRACT_DATE.Date := 0
          else
            CONTRACT_DATE.Date := qContracts.FieldByName('CONTRACT_DATE').AsDateTime;

          if qContracts.FieldByName('ABONENT_ID').IsNull then
          begin
            pcAbonent.TabIndex := 0; // новый абонент
            EditAbonent.PrepareFrame('INSERT', Null);
          end
          else
          begin
            pcAbonent.TabIndex := 1; // существующий абонент
            EditAbonent.PrepareFrame('EDIT', qContracts.FieldByName('ABONENT_ID').Value);
          end;

          spDailyPay.ParamByName('PPHONE_NUMBER').AsString:=PHONE_NUMBER_FEDERAL.Text;
          spDailyPay.ParamByName('PACTION_TYPE').AsString:='=';
          spDailyPay.ExecProc;
          if spDailyPay.ParamByName('RESULT').AsString = '1' then
          begin
            cbDailyAbonPay.Checked := true;
            cbDailyAbonPay.Enabled := EditcbDailyAbonPayBanned;
          end
          else
            cbDailyAbonPay.Checked := false;

        end;
      end;
    end
    else if pRunMode = 'DISABLE' then
    begin
      cbDailyAbonPay.Visible := FIsAdmin;
      cbDailyAbonPay.Checked := false;
      SetEnabledAll(False);

      qContracts.Close;
      CONTRACT_DATE.Date := 0;

      EditAbonent.PrepareFrame('DISABLE', Null);
    end;
    // скидываем признак дублирования номера договора
    tCheckContractNumTimer(nil);
  finally
    FReadData := False;
  end;
end;

procedure TEditContractForm.cbTariffNameoldChange(Sender: TObject);
var
  i: Integer;
  v : Variant;
  TariffCode : String;
begin
  i := cbTariffName.ItemIndex;
  if i < 0 then
  begin
    v := Null;
    TariffCode := '';
  end
  else
  begin
    TariffCode := FTariffList[i].TariffCode;
    v := FTariffList[i].TariffID;
  end;
  FSelectedTariffcode := TariffCode;
  if qContracts.FieldByName('TARIFF_ID').Value <> v then
  begin
    if qContracts.State = dsBrowse then
      qContracts.Edit;
    qContracts.FieldByName('TARIFF_ID').Value := v;
  end;
end;



procedure TEditContractForm.cbTariffNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
key:=0;
end;

procedure TEditContractForm.cbTariffNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
cbTariffName.Text:='';
end;

function TEditContractForm.CheckContractNum(var pErrorMessage : String) : boolean;
var vFloat : Double;
  vIsError : boolean;
begin
  vIsError := False;
  vFloat := 0;
  try
    vFloat := StrToFloat(CONTRACT_NUM.Text);
  except
    pErrorMessage := 'Номер договора должен быть числом';
    vIsError := True;
  end;

  if not vIsError then
  begin
    if vFloat <> Trunc(vFloat) then
    begin
      pErrorMessage := 'Номер договора должен быть целым числом';
      vIsError := True;
    end;
  end;

  Result := (not vIsError);
end;



function TEditContractForm.SaveData: boolean;
var vErrorMessage : String;
    SendNotice:boolean;
begin
  Result := False;
  if (FRunMode = 'INSERT') or (FRunMode = 'EDIT') then
  begin
    if qContracts.Active and ((qContracts.RecordCount > 0) or (qContracts.State in [dsInsert])) then
    begin
      if Trim(CONTRACT_NUM.Text) = '' then
      begin
        MessageDlg('Номер договора должен быть заполнен', mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_NUM.CanFocus() then
          CONTRACT_NUM.SetFocus();
      end
      else if (not CheckContractNum(vErrorMessage)) then
      begin
        MessageDlg(vErrorMessage, mtError, [mbOK], 0);
        if CONTRACT_NUM.CanFocus() then
          CONTRACT_NUM.SetFocus();
      end
      else if Trunc(CONTRACT_DATE.Date) = 0 then
      begin
        MessageDlg('Дата договора должна быть заполнена', mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_DATE.CanFocus() then
          CONTRACT_DATE.SetFocus();
      end
      else if qContracts.FieldByName('FILIAL_ID').AsString = '' then
      begin
        MessageDlg('Филиал должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and FILIAL_ID.CanFocus() then
          FILIAL_ID.SetFocus();
      end
      else if qContracts.FieldByName('OPERATOR_ID').AsString = '' then
      begin
        MessageDlg('Оператор должен быть определен', mtError, [mbOK], 0);
        if Self.Visible and OPERATOR_ID.CanFocus() then
          OPERATOR_ID.SetFocus();
      end
      else if Trim(PHONE_NUMBER_FEDERAL.Text) = '' then
      begin
        MessageDlg('Федеральный номер должен быть заполнен', mtError, [mbOK], 0);
        if Self.Visible and PHONE_NUMBER_FEDERAL.CanFocus() then
          PHONE_NUMBER_FEDERAL.SetFocus();
      end
      else if Length(Trim(PHONE_NUMBER_FEDERAL.Text)) <> 10 then
      begin
        MessageDlg('Федеральный номер должен быть длиной 10 символов', mtError, [mbOK], 0);
        //Windows.SetFocus(PHONE_NUMBER_FEDERAL.Handle);
        if Self.Visible and PHONE_NUMBER_FEDERAL.CanFocus() then
          PHONE_NUMBER_FEDERAL.SetFocus();
      end
      else if (Trim(PHONE_NUMBER_CITY.Text) <> '') and (Length(Trim(PHONE_NUMBER_CITY.Text)) <> 7) then
      begin
        MessageDlg('Городской номер должен быть длиной 7 символов', mtError, [mbOK], 0);
        if Self.Visible and PHONE_NUMBER_CITY.CanFocus() then
          PHONE_NUMBER_CITY.SetFocus();
      end
      else if qContracts.FieldByName('TARIFF_ID').AsString = '' then
      begin
        MessageDlg('Тарифный план должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and cbTariffName.CanFocus() then
          cbTariffName.SetFocus();
      end
{      else if (Trim(SIM_NUMBER.Text) <> '') and (Length(Trim(SIM_NUMBER.Text)) <> 20) then
      begin
        MessageDlg('Номер SIM карты должен быть длиной 20 символов', mtError, [mbOK], 0);
        if Self.Visible and SIM_NUMBER.CanFocus() then
          SIM_NUMBER.SetFocus();
      end}

        else if DublicatesExists(CONTRACT_NUM.Text, qContracts.FieldByName('CONTRACT_ID').Value) then
      begin
        MessageDlg('С данным номером уже зарегистрирован другой договор', mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_NUM.CanFocus() then
          CONTRACT_NUM.SetFocus();
      end
      else
      begin
        // если что-то не получилось, там внутри должно выйти соощение об ошибке
        //Проверка на заключение договоров с одинаковыми номерами телефонов
          DoublePhoneNum.Close;
          DoublePhoneNum.ParamByName('PHONENUMBER').AsString:=PHONE_NUMBER_FEDERAL.Text;
          DoublePhoneNum.ParamByName('contract_new_num').AsString:= CONTRACT_NUM.text;
          if  PHONE_NUMBER_FEDERAL.Text<>'' then
            begin
              DoublePhoneNum.Open;
              if (DoublePhoneNum.IsEmpty=false) then
                begin
                  MessageDlg('С данным номером телефона уже зарегистрирован другой договор', mtError, [mbOK], 0);
                  exit;
                end;
             end;
        DoublePhoneNum.ParamByName('PHONENUMBER').AsString:=PHONE_NUMBER_CITY.Text;
        DoublePhoneNum.ParamByName('contract_new_num').AsString:= CONTRACT_NUM.text;
        if  PHONE_NUMBER_CITY.Text<>'' then
          begin
            DoublePhoneNum.Close;
            DoublePhoneNum.Open;
            if (DoublePhoneNum.IsEmpty=false) then
              begin
                MessageDlg('С данным номером телефона уже зарегистрирован другой договор', mtError, [mbOK], 0);
                exit;
              end;
          end;
        if EditAbonent.SaveData(PHONE_NUMBER_FEDERAL.Text) then
        begin
          // если сохранено без ошибок то обязательно FAbonentId должен быть заполнен
          //Assert(VarToStr(EditAbonent.FAbonentId) = '', 'Код абонента должен быть заполнен.');
          qContracts.FieldByName('ABONENT_ID').Value := EditAbonent.FAbonentId;

          // если был получен номер договора, и затем он был изменен вручную (освободить его)
          if (not VarIsNull(vContractNumNew)) and
             (vContractNumNew <> '') and
             (trim(VarToStr(vContractNumNew)) <> trim(CONTRACT_NUM.Text))
          then
          begin
            FreeContractNum(vContractNumNew);
            vContractNumNew := Null;
          end;

          if (qContracts.State in [dsInsert]) then
          begin
            qGetNewId.ExecSQL;
            qContracts.FieldByName('CONTRACT_ID').Value := qGetNewId.ParamByName('RESULT').Value;
            FContractId := qContracts.FieldByName('CONTRACT_ID').Value;
          end;
          //
          qContracts.FieldByName('CONTRACT_DATE').AsDateTime := Trunc(CONTRACT_DATE.Date);
          //
          qContracts.FieldByName('IS_CREDIT_CONTRACT').AsInteger:=rgTypePaid.ItemIndex;
          //
          Dm.OraSession.StartTransaction;
          try
            qContracts.Post;
            // Параметры платежа сохраняем отдельной процедурой
            qSaveContractPayment.ParamByName('pCONTRACT_ID').Value := qContracts.FieldByName('CONTRACT_ID').Value;
            qSaveContractPayment.ParamByName('pPAYMENT_SUM').Value := qContracts.FieldByName('START_BALANCE').Value;
            qSaveContractPayment.ExecProc;
            //Фиксация посуточного списания для GSMCorp
            spDailyPay.ParamByName('PPHONE_NUMBER').AsString:=PHONE_NUMBER_FEDERAL.Text;
            if cbDailyAbonPay.Checked then
              spDailyPay.ParamByName('PACTION_TYPE').AsString := '+'
            else
              spDailyPay.ParamByName('PACTION_TYPE').AsString := '-';
            spDailyPay.ExecProc;
            // Фиксируем
            Dm.OraSession.Commit;
            Result := True;
            SendNotice:=true;

          except
            on e : exception do
            begin
              Dm.OraSession.Rollback;
              SendNotice:=false;
              if AnsiPos('PK_DAILY_ABON_PH_N) VIOLATED', UpperCase(e.Message)) > 0 then
                MessageDlg('Ошибка сохранения договора.'#13#10 + 'На номере "'+ PHONE_NUMBER_FEDERAL.Text +'" запрещено посуточное списание', mtError, [mbOK], 0)
              else
                MessageDlg('Ошибка сохранения договора.'#13#10 + e.Message, mtError, [mbOK], 0);
            end;
          end;
          if (SendNotice)
              and(GetParamValue('SEND_WELCOME_SMS')='1')
              and(FRunMode = 'INSERT') then
          begin
            spSendNotice.ParamByName('PCONTRACT_ID').AsInteger:=qContracts.FieldByName('CONTRACT_ID').AsInteger;
            spSendNotice.ExecSQL;
          end;
        end;
      end;
    end
    else
      MessageDlg('Невозможно сохранить параметры договора.', mtError, [mbOK], 0);
  end
  else
    MessageDlg('Сохранить параметры договора можно только в режиме добавления или редактирования.', mtError, [mbOK], 0);
end;

procedure TEditContractForm.FormShow(Sender: TObject);
begin
  if not FReadData then
  begin
    if CONTRACT_NUM.CanFocus then
      CONTRACT_NUM.SetFocus();
  end;

  if GetConstantValue('CALC_ABON_PAYMENT_TO_MONTH_END') <> '1' then
    cbDailyAbonPay.Visible := false
  else if (FIsAdmin) or (not(FIsAdmin) and (FRunMode = 'INSERT')) then
    cbDailyAbonPay.Visible := true
  else
    cbDailyAbonPay.Visible := false;

  FChanging := False;

  if Length(ABONENT_TARIFF_OPTION.Text)=0 then
    btnOK.Enabled:=false
  else
    btnOK.Enabled:=true;
end;

procedure TEditContractForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  tCheckContractNum.Enabled := False;
  if FCheckPhoneTariffCode and (ModalResult = mrOk) then
  begin
    if (FPhoneTariffCode <> '') and (cbTariffName.ItemIndex >= 0) then
    begin
      if (FTariffList[cbTariffName.ItemIndex].TariffCode <> '')
        and (FPhoneTariffCode <> FTariffList[cbTariffName.ItemIndex].TariffCode) then
        CanClose := (IDYES = Application.MessageBox(PChar('Тариф договора "'+FTariffList[cbTariffName.ItemIndex].TariffCode
          +'"не совпадает с реальным тарифом "'+FPhoneTariffCode+'". Продолжить?'),
          'Внимание!', MB_YESNO or MB_ICONQUESTION));
    end;
  end;
  if CanClose then
  begin
    if ModalResult = mrOk then
    begin
      CanClose := SaveData;
    end
    else
    begin
      CanClose := (IDYES = MessageDlg('Отменить ввод и закрыть форму?', mtConfirmation, [mbYes, mbNo], 0));
    end;
  end;
end;

procedure TEditContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk
  else if (Key = VK_RETURN) and (Shift = []) then
    MoveToNextControl;
end;

procedure TEditContractForm.MoveToNextControl;
const
  MovePath : array[0..26] of String = (
    'CONTRACT_NUM',
    'pcAbonent',
    'SURNAME',
    'NAME',
    'PATRONYMIC',
    'BDATE',
    'PASSPORT_SER',
    'PASSPORT_NUM',
    'PASSPORT_DATE',
    'PASSPORT_GET',
    'CITY_NAME',
    'STREET_NAME',
    'HOUSE',
    'KORPUS',
    'APARTMENT',
    'CONTACT_INFO',
    'CODE_WORD',
    'EMAIL',
    'OPERATOR_ID',
    'PHONE_NUMBER_TYPE',
    'SIM_NUMBER',
    'cbTariffName',
    'PHONE_NUMBER_FEDERAL',
    'GOLD_NUMBER_SUM',
    'DISCONNECT_LIMIT',
    'RECEIVED_SUM',
    'btnOK'
  );
var
  c : TWinControl;
  ActiveControlName : String;
  i : Integer;
begin
  c := ActiveControl;
  if c <> nil then
  begin
    ActiveControlName := c.Name;
    for i := 0 to High(MovePath)-1 do // Кроме последнего элемента!
    begin
      if MovePath[i] = ActiveControlName then
      begin
        ActiveControlName := MovePath[i+1];
        c := Self.FindComponent(ActiveControlName) As TWinControl;
        if c = nil then
          c := EditAbonent.FindComponent(ActiveControlName) As TWinControl;

        if (c <> nil) and c.CanFocus then
        begin
          c.SetFocus;
          Exit;
        end;
      end;
    end;
  end;
  Self.Next;
end;

procedure TEditContractForm.dsContractsDataChange(Sender: TObject;
  Field: TField);
begin
  CalcRealBalance;
  SetTariffIndex;
end;

procedure TEditContractForm.SetTariffIndex;
var
  i : Integer;
begin
  i := Length(FTariffList)-1;
  while i >= 0 do
  begin
    if FTariffList[i].TariffID = qContracts.FieldByName('TARIFF_ID').AsInteger then
      Break;
    Dec(i);
  end;
  cbTariffName.ItemIndex := i;
  if i >= 0 then
    cbTariffName.Hint := cbTariffName.Text
  else
    cbTariffName.Hint := '';
end;

procedure TEditContractForm.ABONENT_TARIFF_OPTIONChange(Sender: TObject);
begin
  if Length(ABONENT_TARIFF_OPTION.Text)=0 then
    btnOK.Enabled:=false
  else
    btnOK.Enabled:=true;
end;

procedure TEditContractForm.CalcRealBalance;
const
  ValidColors : array[False..True] of TColor = (clRed, clBlack);
var
  vBalance : Double;
  ReceivedSumText : String;
begin
  vBalance := 0;
  if qContracts.Active and (not qContracts.FieldByName('TARIFF_ID').IsNull) and
     qTariffs.Active and (qTariffs.RecordCount > 0) then
  begin
    vBalance := vBalance +
      qTariffs.FieldByName('START_BALANCE').AsFloat
      - qTariffs.FieldByName('ADVANCE_PAYMENT').AsFloat
      - qTariffs.FieldByName('CONNECT_PRICE').AsFloat;
    ReceivedSumText := RECEIVED_SUM.Text;
    if ReceivedSumText <> '' then
      vBalance := vBalance + StrToFloat(ReceivedSumText);// qContracts.FieldByName('RECEIVED_SUM').AsFloat
  end
  else
  begin
    CONNECT_PRICE.Caption := '';
    START_BALANCE.Caption := '';
    ADVANCE_PAYMENT.Caption := '';
  end;
  if qContracts.Active and (not qContracts.FieldByName('GOLD_NUMBER_SUM').IsNull) then
  vBalance := vBalance - qContracts.FieldByName('GOLD_NUMBER_SUM').AsFloat;
  lRealBalance.Caption := FormatFloat('0.00', vBalance);
//  if qContracts.State in [dsInsert] then
//    qContracts.FieldByName('START_BALANCE').AsFloat := vBalance;
  if qContracts.State in [dsInsert, dsEdit] then
    if qContracts.FieldByName('START_BALANCE').IsNull or (qContracts.FieldByName('START_BALANCE').AsFloat <> vBalance) then
      qContracts.FieldByName('START_BALANCE').AsFloat := vBalance;

  ReceivedSumText := RECEIVED_SUM.Text;
  if ReceivedSumText <> '' then
  begin
    RECEIVED_SUM.Font.Color := ValidColors[
      (vBalance >= qTariffs.FieldByName('START_BALANCE').AsFloat)
      ];
  end;
end;

procedure TEditContractForm.dsOperatorsDataChange(Sender: TObject;
  Field: TField);
begin
  if not FReadData then
  begin
{    if qOperators.Active and (qOperators.RecordCount > 0) then
    begin
      qTariffs.Filter := 'OPERATOR_ID = '+ qOperators.FieldByName('OPERATOR_ID').AsString;
      qTariffs.Filtered := True;
    end
    else
      qTariffs.Filtered := False;}

    if qContracts.Active and (qContracts.State in [dsEdit, dsInsert]) then
      qContracts.FieldByName('TARIFF_ID').Value := Null;
  end
//  else
//    qTariffs.Filtered := False;
end;

procedure TEditContractForm.pcAbonentChanging(Sender: TObject;
  var AllowChange: Boolean);
var vAbonentId : Variant;
begin
  if not FChanging then
  begin
    FChanging := True;
    try
      if pcAbonent.TabIndex = 1 then
      begin
        AllowChange := EditAbonent.PrepareFrame('INSERT', Null);
      end
      else if pcAbonent.TabIndex = 0 then
      begin
        if qContracts.Active then
          vAbonentId := qContracts.FieldByName('ABONENT_ID').Value;
        if VarToStr(vAbonentId) = '' then
        begin
          EditAbonent.aFindAbonent.Execute();
          // переключаем обратно на страницу добавления, выбор не получился
          AllowChange := (VarToStr(EditAbonent.FAbonentId) <> '');
        end
        else
          AllowChange := EditAbonent.PrepareFrame('EDIT', vAbonentId);
      end;
    finally
      FChanging := False;
    end;
  end;
end;

function TEditContractForm.DublicatesExists(const pNum : Variant; const pExceptContractId : Variant) : boolean;
var vErrorMessage : String;
begin
  Result := False;
  if CheckContractNum(vErrorMessage) then
  begin
    try
      qNumDouble.Close;
      qNumDouble.ParamByName('CONTRACT_NUM').Value := Trunc(StrToFloat(Trim(pNum)));
      qNumDouble.ParamByName('CONTRACT_ID').Value := pExceptContractId;
      qNumDouble.Open;
      Result := (qNumDouble.FieldByName('CNT').AsInteger > 0);
    except
      on e : exception do
        MessageDlg('Ошибка проверки дубликатов номера договора'#13#10+e.Message, mtError, [mbOK], 0);
    end;
  end;
end;

function TEditContractForm.EditcbDailyAbonPayBanned: Boolean;
begin
  if GetConstantValue('SERVER_NAME')='GSM_CORP' then
    Result := (LowerCase(MainForm.FUser) = LowerCase('MATVEEVNS'))
        or (LowerCase(MainForm.FUser) = LowerCase('ADMIN'))
  else
    Result := True;
end;

procedure TEditContractForm.tCheckContractNumTimer(Sender: TObject);
begin
  tCheckContractNum.Enabled := False;

  if qContracts.Active and DublicatesExists(CONTRACT_NUM.Text, qContracts.FieldByName('CONTRACT_ID').Value) then
  begin
    CONTRACT_NUM.Font.Color := clRed;
    CONTRACT_NUM.Hint := 'С данным номером уже зарегистрирован другой договор';
    CONTRACT_NUM.ShowHint := True;
  end
  else
  begin
    CONTRACT_NUM.Font.Color := clWindowText;
    CONTRACT_NUM.Hint := '';
    CONTRACT_NUM.ShowHint := False;
  end;
end;

procedure TEditContractForm.CONTRACT_NUMChange(Sender: TObject);
begin
  if not FReadData then
  begin
    tCheckContractNum.Enabled := False;
    tCheckContractNum.Enabled := True;
  end;
end;

procedure TEditContractForm.DISCONNECT_LIMITChange(Sender: TObject);
var IsAdmin: boolean;
begin
  if GetConstantValue('SERVER_NAME')='GSM_CORP' then
  begin
    MainForm.CheckAdminPrivs(IsAdmin);
    if not IsAdmin then
    begin
      qContracts.FieldByName('DISCONNECT_LIMIT').Value:=
        qContracts.FieldByName('DISCONNECT_LIMIT').OldValue;
      ShowMessage('Это функция доступна только администратору системы!');
    end;
  end;
end;

procedure TEditContractForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    // если был получен номер договора, и затем он был изменен вручную (освободить его)
    if (not VarIsNull(vContractNumNew)) and  (vContractNumNew <> '') then
    begin
      FreeContractNum(vContractNumNew);
      vContractNumNew := Null;
    end;
    qContracts.Cancel;
    EditAbonent.CancelChanges;
    tCheckContractNum.Enabled := False; // Уберём признак проверки.
  end;
end;

procedure TEditContractForm.PHONE_NUMBER_FEDERALChange(Sender: TObject);
begin
  if FCheckPhoneTariffCode then
  begin
    FPhoneTariffCode := '';
    if Length(PHONE_NUMBER_FEDERAL.Text) = 10 then
    begin
      qPhoneTariff.ParamByName('PHONE_NUMBER').AsString := PHONE_NUMBER_FEDERAL.Text;
      qPhoneTariff.Open;
      try
        FPhoneTariffCode := qPhoneTariff.FieldByName('CELL_PLAN_CODE').AsString;
      finally
        qPhoneTariff.Close;
      end;
    end;
    lTariffCode.Caption := FPhoneTariffCode;
  end;
end;

procedure TEditContractForm.PHONE_NUMBER_TYPEClick(Sender: TObject);
begin
  if VarToStr(PHONE_NUMBER_TYPE.KeyValue) = '1' then
  begin // Городской (прямой) номер
    PHONE_NUMBER_CITY.Enabled := True;
  end
  else
  begin
    PHONE_NUMBER_CITY.Clear;
    PHONE_NUMBER_CITY.Enabled := False;
  end;
  SetTariffFilter;
end;

procedure TEditContractForm.SetTariffFilter;
  function VarToStrOrEmpty(const v : Variant) : String;
  begin
    if VarIsNull(v) then
      Result := '-125830'
    else
      Result := v;
  end;
var
  FilterStr : String;
  L: Integer;
begin
  FilterStr := 'OPERATOR_ID='+VarToStrOrEmpty(OPERATOR_ID.KeyValue)
    + ' AND PHONE_NUMBER_TYPE=' + VarToStrOrEmpty(PHONE_NUMBER_TYPE.KeyValue);
  if qContracts.State = dsInsert then
    FilterStr := FilterStr + ' AND IS_ACTIVE=1';
  qTariffs.Filter := FilterStr;
  qTariffs.Filtered := True;
  // Заполним список тарифов
  qTariffs.First;
  cbTariffName.Items.Clear;
  SetLength(FTariffList, 0);
  L := 0;
  while not qTariffs.EOF do
  begin
    cbTariffName.Items.Add(qTariffs.FieldByName('TARIFF_NAME').AsString);
    SetLength(FTariffList, L+1);
    FTariffList[L].TariffID := qTariffs.FieldByName('TARIFF_ID').AsInteger;
    FTariffList[L].TariffCode := qTariffs.FieldByName('TARIFF_CODE').AsString;
    Inc(L);
    qTariffs.Next;
  end;
  SetTariffIndex;
   // cbTariffName.ItemIndex:=0;
//  cbTariffNameChange(self);
end;

procedure TEditContractForm.qContractsAfterInsert(DataSet: TDataSet);
begin
  // Тип номер - федеральный
  DataSet.FieldByName('PHONE_NUMBER_TYPE').AsInteger := 0;
  // Услуга - 0 (нет услуги)
  DataSet.FieldByName('GOLD_NUMBER_SUM').AsInteger := 0;
  // Принятая сумма
  DataSet.FieldByName('RECEIVED_SUM').AsFloat := 0;
  // Оператор связи
  if not qOperators.Active then
    qOperators.Open;
  DataSet.FieldByName('OPERATOR_ID').Value := qOperators.FieldByName('OPERATOR_ID').Value;
  PHONE_NUMBER_TYPEClick(DataSet);
end;

procedure TEditContractForm.qContractsAfterOpen(DataSet: TDataSet);
begin
  SetTariffFilter;
  if qContracts.FieldByName('IS_CREDIT_CONTRACT').AsInteger=1 then
    rgTypePaid.ItemIndex:=1
  else
    rgTypePaid.ItemIndex:=0;
end;

procedure TEditContractForm.OPERATOR_IDClick(Sender: TObject);
begin
  SetTariffFilter;
end;

procedure TEditContractForm.dsTariffsDataChange(Sender: TObject;
  Field: TField);
begin
  CalcRealBalance;
end;

procedure TEditContractForm.RECEIVED_SUMChange(Sender: TObject);
begin
  CalcRealBalance;
end;

type
  THackWinControl = class(TWinControl)
  end;

procedure TEditContractForm.WinControlEnter(Sender: TObject);
begin
  THackWinControl(Sender As TWinControl).Color := $00FEFBE0;
  THackWinControl(Sender As TWinControl).Font.Color := clBlack;
  if (Sender Is TDBLookupComboBox)
    and (qContracts.State = dsInsert)
    and (VarIsNull(TDBLookupComboBox(Sender).KeyValue){ qContracts.FieldByName('TARIFF_ID').IsNull}) then
    TDBLookupComboBox(Sender).DropDown
  else if (Sender Is TComboBox)
    and (qContracts.State = dsInsert)
    and (TComboBox(Sender).ItemIndex < 0) then
    begin
    //TComboBox(Sender).DroppedDown := True;
    end;
end;

procedure TEditContractForm.WinControlExit(Sender: TObject);
begin
  THackWinControl(Sender As TWinControl).Color := clWindow;
  THackWinControl(Sender As TWinControl).Font.Color := clWindowText;
end;

procedure TEditContractForm.SetControlHandlers(Parent : TComponent);
var
  i : Integer;
  c : Tcomponent;
begin
  for i := 0 to Parent.ComponentCount-1 do
  begin
    c := Parent.Components[i];
    if (c Is TCustomEdit)
      or (c Is TCustomComboBox)
      or (c Is TDBLookupComboBox)
      then
    begin
      THackWinControl(c).OnEnter := WinControlEnter;
      THackWinControl(c).OnExit := WinControlExit;
    end;
  end;
end;

function TEditContractForm.GetPhoneNumber : String;
begin
  Result := PHONE_NUMBER_FEDERAL.Text;
end;

procedure TEditContractForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qTariffs.SQL.Insert(2, '    WHERE FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    qFilials.SQL.Insert(2, '    WHERE FILIAL_ID = ' + IntToStr(MainForm.FFilial));
  end;
  SetControlHandlers(Self);
  SetControlHandlers(EditAbonent);
  FCheckPhoneTariffCode := (GetConstantValue('CHECK_CONTRACT_TARIFF_CODES') = '1');
  lTariffCodeCaption.Visible := FCheckPhoneTariffCode;
  lTariffCode.Visible := FCheckPhoneTariffCode;
  if not FCheckPhoneTariffCode then
    pPhoneInfo.Height := pPhoneInfo.Height-16;
  if GetConstantValue('CREDIT_SYSTEM_ENABLE') = '1' then
    rgTypePaid.Visible:=true
  else
    rgTypePaid.Visible:=false;
end;

end.
