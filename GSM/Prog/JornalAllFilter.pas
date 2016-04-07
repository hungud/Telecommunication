unit JornalAllFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBCtrls, MemDS, DBAccess, Ora, ComCtrls,
  Buttons;

type
  TJornalAllFilterForm = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    rbToday: TRadioButton;
    rbYestoDay: TRadioButton;
    rbThisWeek: TRadioButton;
    rbLastWeek: TRadioButton;
    rbThisMonth: TRadioButton;
    rbLastMonth: TRadioButton;
    rbAll: TRadioButton;
    deBegin: TDateTimePicker;
    deEnd: TDateTimePicker;
    lDates1: TLabel;
    lDates2: TLabel;
    Bevel1: TBevel;
    Panel2: TPanel;
    qFilials: TOraQuery;
    cbFilials: TComboBox;
    cbFilial: TLabel;
    eContractNum: TEdit;
    cbContractNum: TCheckBox;
    cbAbonent: TCheckBox;
    eAbonent: TEdit;
    sbSelectAbonent: TSpeedButton;
    cbBdate: TCheckBox;
    deBDate: TDateTimePicker;
    cbCityName: TCheckBox;
    cbCity: TComboBox;
    cdStreetName: TCheckBox;
    cbStreet: TComboBox;
    cbHouse: TCheckBox;
    eHouse: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    qCityNames: TOraQuery;
    qStreetNames: TOraQuery;
    qAbonentName: TOraQuery;
    cbConfirmed: TComboBox;
    Label1: TLabel;
    cbPhoneNumFed: TCheckBox;
    ePhoneNumFed: TEdit;
    cbPhoneNumCity: TCheckBox;
    ePhoneNumCity: TEdit;
    procedure rbTodayClick(Sender: TObject);
    procedure rbYestoDayClick(Sender: TObject);
    procedure rbThisWeekClick(Sender: TObject);
    procedure rbLastWeekClick(Sender: TObject);
    procedure rbThisMonthClick(Sender: TObject);
    procedure rbLastMonthClick(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbSelectAbonentClick(Sender: TObject);
    procedure deBeginChange(Sender: TObject);
    procedure deEndChange(Sender: TObject);
    procedure cbContractNumClick(Sender: TObject);
    procedure cbAbonentClick(Sender: TObject);
    procedure cbBdateClick(Sender: TObject);
    procedure cbCityNameClick(Sender: TObject);
    procedure cdStreetNameClick(Sender: TObject);
    procedure cbHouseClick(Sender: TObject);
    procedure dsFilialsDataChange(Sender: TObject; Field: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbPhoneNumFedClick(Sender: TObject);
    procedure cbPhoneNumCityClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure GetDates(const pDate: TDateTime; const pDatesTypes: String;
      var pDateBegin, pDateEnd: TDateTime);
    procedure SetDatesEnabled(const pEnabled: boolean);
    function GetAbonentId: Variant;
    function GetBDate: TDateTime;
    function GetCityName: Variant;
    function GetDateBegin: TDateTime;
    function GetDateEnd: TDateTime;
    function GetFilialId: Variant;
    function GetHouse: Variant;
    function GetStreetName: Variant;
    procedure SetAbonentId(const Value: Variant);
    procedure SetBDate(const Value: TDateTime);
    procedure SetCityName(const Value: Variant);
    procedure SetDateBegin(const Value: TDateTime);
    procedure SetDateEnd(const Value: TDateTime);
    procedure SetFilialId(const Value: Variant);
    procedure SetHouse(const Value: Variant);
    procedure SetStreetName(const Value: Variant);
    procedure ResetCheckBoxes;
    function GetContractNum: Variant;
    procedure SetContractNum(const Value: Variant);
    function GetConfirmed: Integer;
    procedure SetConfirmed(const Value: Integer);
    function GetPhoneNumCity: Variant;
    function GetPhoneNumFed: Variant;
    procedure SetPhoneNumCity(const Value: Variant);
    procedure SetPhoneNumFed(const Value: Variant);
    function GetFilterStr: String;
    { Private declarations }
  public
    FChanging : boolean;
    FAbonentId : Variant;
    procedure PrepareCombobox(const pCB: TComboBox;
      const pDataset: TDataset);
    procedure PrepareCombobox2(const pCB: TComboBox;
      const pDataset: TDataset; const pFirstItem: String);

    property DateBegin : TDateTime read GetDateBegin write SetDateBegin;
    property DateEnd : TDateTime read GetDateEnd write SetDateEnd;
    property FilialId : Variant read GetFilialId write SetFilialId;
    property ContractNum : Variant read GetContractNum write SetContractNum;
    property AbonentId : Variant read GetAbonentId write SetAbonentId;
    property BDate : TDateTime read GetBDate write SetBDate;
    property CityName : Variant read GetCityName write SetCityName;
    property StreetName : Variant read GetStreetName write SetStreetName;
    property House : Variant read GetHouse write SetHouse;
    property Confirmed : Integer read GetConfirmed write SetConfirmed;
    property PhoneNumFed : Variant read GetPhoneNumFed write SetPhoneNumFed;
    property PhoneNumCity : Variant read GetPhoneNumCity write SetPhoneNumCity;
    property FilterStr : String read GetFilterStr;
  end;

//var
//  JornalAllFilterForm: TJornalAllFilterForm;

implementation

{$R *.dfm}

uses RefAbonents;

procedure TJornalAllFilterForm.SetDatesEnabled(const pEnabled : boolean);
begin
  lDates1.Enabled := pEnabled;
  deBegin.Enabled := pEnabled;
  lDates2.Enabled := pEnabled;
  deEnd.Enabled := pEnabled;
end;

procedure TJornalAllFilterForm.GetDates(
  const pDate : TDateTime;
  const pDatesTypes : String;
    var pDateBegin, pDateEnd : TDateTime);
var w : Integer;
   Year, Month, Day: Word;
begin
  if pDatesTypes = 'TODAY' then
  begin
    pDateBegin := pDate;
    pDateEnd := pDate;
  end
  else if pDatesTypes = 'YESTODAY' then
  begin
    pDateBegin := pDate - 1;
    pDateEnd := pDate - 1;
  end
  else if pDatesTypes = 'THIS_WEEK' then
  begin
    // DayOfWeek - воскресенье дает = 1, понедельник = 2
    w := DayOfWeek(pDate) - 1;
    if w = 0 then w := 7;
    //
    pDateBegin := pDate - w + 1;
    pDateEnd := pDate - w + 7;
  end
  else if pDatesTypes = 'LAST_WEEK'  then
  begin
    // DayOfWeek - воскресенье дает = 1, понедельник = 2
    w := DayOfWeek(pDate) - 1;
    if w = 0 then w := 7;
    //
    pDateBegin := pDate - w + 1 - 7;
    pDateEnd := pDate - w + 7 - 7;
  end
  else if pDatesTypes = 'THIS_MONTH' then
  begin
    DecodeDate(pDate, Year, Month, Day);
    pDateBegin := EncodeDate(Year, Month, 1);
    if Month = 12 then
      pDateEnd := EncodeDate(Year+1, 1, 1) - 1
    else
      pDateEnd := EncodeDate(Year, Month+1, 1) - 1;
  end
  else if pDatesTypes = 'LAST_MONTH' then
  begin
    DecodeDate(pDate, Year, Month, Day);
    if Month = 1 then
    begin
      Year := Year - 1;
      Month := 12;
    end
    else
      Month := Month - 1;

    pDateBegin := EncodeDate(Year, Month, 1);
    if Month = 12 then
      pDateEnd := EncodeDate(Year+1, 1, 1) - 1
    else
      pDateEnd := EncodeDate(Year, Month+1, 1) - 1;
  end
  else if pDatesTypes = 'ALL' then
  begin
    pDateBegin := EncodeDate(1900, 1, 1);
    pDateEnd := EncodeDate(3000, 1, 1);
  end
  else
    raise Exception.Create('Вид дат ' + pDatesTypes + ' не поддерживается.');
  pDateBegin := Trunc(pDateBegin);
  pDateEnd := Trunc(pDateEnd);
end;

procedure TJornalAllFilterForm.rbTodayClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'TODAY', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbYestoDayClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'YESTODAY', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbThisWeekClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'THIS_WEEK', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbLastWeekClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'LAST_WEEK', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbThisMonthClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'THIS_MONTH', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbLastMonthClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(True);
    GetDates(Date(), 'LAST_MONTH', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.rbAllClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(False);
    GetDates(Date(), 'ALL', vDateBegin, vDateEnd);
    deBegin.Date := vDateBegin;
    deEnd.Date := vDateEnd;
  end;
end;

procedure TJornalAllFilterForm.PrepareCombobox2(const pCB : TComboBox; const pDataset : TDataset;
  const pFirstItem : String);
begin
  PrepareCombobox(pCB, pDataset);
  pCB.Items.Insert(0, pFirstItem);
end;

procedure TJornalAllFilterForm.PrepareCombobox(const pCB : TComboBox; const pDataset : TDataset);
var vInt : Integer;
begin
  if not pDataset.Active then
    pDataset.Open;

  pCB.Clear;
  pDataset.First;
  while not pDataset.Eof do
  begin
    vInt := pDataset.FieldbyName('ID').AsInteger;
    pCB.AddItem(pDataset.FieldbyName('NAME').AsString, Pointer(vInt));
    pDataset.Next;
  end;
end;

procedure TJornalAllFilterForm.FormShow(Sender: TObject);
begin
  FChanging := False;
  if cbFilials.CanFocus() then
    cbFilials.SetFocus();
end;

function TJornalAllFilterForm.GetAbonentId: Variant;
begin
  if cbAbonent.Checked then
    Result := FAbonentId
  else
    Result := Null;
end;

function TJornalAllFilterForm.GetBDate: TDateTime;
begin
  if cbBdate.Checked then
    Result := Trunc(deBDate.Date)
  else
    Result := 0;
end;

function TJornalAllFilterForm.GetCityName: Variant;
begin
  if cbCityName.Checked then
    Result := cbCity.Text
  else
    Result := Null;
end;

function TJornalAllFilterForm.GetDateBegin: TDateTime;
begin
  if rbAll.Checked then
    Result := 0
  else
    Result := Trunc(deBegin.Date);
end;

function TJornalAllFilterForm.GetDateEnd: TDateTime;
begin
  if rbAll.Checked then
    Result := 0
  else
    Result := Trunc(deEnd.Date);
end;

function TJornalAllFilterForm.GetFilialId: Variant;
begin
  if cbFilials.ItemIndex = 0 then
    Result := Null
  else
    Result := Integer(cbFilials.Items.Objects[cbFilials.ItemIndex]);
end;

function TJornalAllFilterForm.GetHouse: Variant;
begin
  if cbHouse.Checked then
    Result := eHouse.Text
  else
    Result := Null;
end;

function TJornalAllFilterForm.GetStreetName: Variant;
begin
  if cdStreetName.Checked then
    Result := cbStreet.Text
  else
    Result := Null;
end;

procedure TJornalAllFilterForm.SetAbonentId(const Value: Variant);
begin
  FAbonentId := Value;
  if VarToStr(FAbonentId) = '' then
  begin
    cbAbonent.Checked := False;
    eAbonent.Text := '';
  end
  else
  begin
    cbAbonent.Checked := True;
    qAbonentName.Close;
    qAbonentName.ParamByName('ABONENT_ID').Value := FAbonentId;
    qAbonentName.Open;
    if qAbonentName.RecordCount > 0 then
      eAbonent.Text := qAbonentName.fieldbyNAme('FIO').AsString
    else
      eAbonent.Text := 'Не найден абонент с кодом ' + VarToStr(FAbonentId);
  end;
end;

procedure TJornalAllFilterForm.SetBDate(const Value: TDateTime);
begin
  deBDate.Date := Value;
  cbBdate.Checked := (Value > 0);
end;

procedure TJornalAllFilterForm.SetCityName(const Value: Variant);
begin
  cbCity.Text := VarToStr(Value);
  cdStreetName.Checked := (VarToStr(Value) <> '');
end;

procedure TJornalAllFilterForm.SetDateBegin(const Value: TDateTime);
begin
  deBegin.Date := Value;
  ResetCheckBoxes;
end;

procedure TJornalAllFilterForm.SetDateEnd(const Value: TDateTime);
begin
  deEnd.Date := Value;
  ResetCheckBoxes;
end;

procedure TJornalAllFilterForm.SetFilialId(const Value: Variant);
var vFilialId : Integer;
  i : Integer;
begin
  if VarToStr(Value) = '' then
    cbFilials.ItemIndex := 0
  else
  begin
    vFilialId := StrToInt(VarToStr(Value));
    i := cbFilials.Items.IndexOfObject(Pointer(vFilialId));
    if i >= 0 then
      cbFilials.ItemIndex := i;
  end;
end;

procedure TJornalAllFilterForm.SetHouse(const Value: Variant );
begin
  eHouse.Text := VarToStr(Value);
  cbHouse.Checked := (VarToStr(Value) <> '');
end;

procedure TJornalAllFilterForm.SetStreetName(const Value: Variant);
begin
  cbStreet.Text := VarToStr(Value);
  cdStreetName.Checked := (VarToStr(Value) <> '');
end;

procedure TJornalAllFilterForm.sbSelectAbonentClick(Sender: TObject);
var vAbonentId : Variant;
begin
  vAbonentId := SelectAbonent();
  if VarToStr(vAbonentId) <> '' then
  begin
    AbonentId := vAbonentId;
  end;
end;

procedure TJornalAllFilterForm.ResetCheckBoxes;
  function CheckDates(const pType : String; const pRButton : TRadioButton) : boolean;
  var vDateBegin, vDateEnd : TDateTime;
  begin
    Result := False;
    GetDates(Date(), pType, vDateBegin, vDateEnd);
    if (Trunc(deBegin.Date) = Trunc(vDateBegin)) and (Trunc(deEnd.Date) = Trunc(vDateEnd)) then
    begin
      pRButton.Checked := True;
      Result := True;
    end;
  end;
begin
  FChanging := True;
  try
    rbToday.Checked := False;
    rbYestoDay.Checked := False;
    rbThisWeek.Checked := False;
    rbLastWeek.Checked := False;
    rbThisMonth.Checked := False;
    rbLastMonth.Checked := False;
    rbAll.Checked := False;

    if not CheckDates('TODAY', rbToday) and
       not CheckDates('YESTODAY', rbYestoDay) and
       not CheckDates('THIS_WEEK', rbThisWeek) and
       not CheckDates('LAST_WEEK', rbLastWeek) and
       not CheckDates('THIS_MONTH', rbThisMonth) and
       not CheckDates('LAST_MONTH', rbLastMonth) and
       not CheckDates('LAST_MONTH', rbLastMonth)
    then
      ;
  finally
    FChanging := False;
  end;
end;

procedure TJornalAllFilterForm.deBeginChange(Sender: TObject);
begin
  ResetCheckBoxes;
end;

procedure TJornalAllFilterForm.deEndChange(Sender: TObject);
begin
  ResetCheckBoxes;
end;

procedure TJornalAllFilterForm.cbContractNumClick(Sender: TObject);
begin
  eContractNum.Enabled := cbContractNum.Checked;
end;

procedure TJornalAllFilterForm.cbAbonentClick(Sender: TObject);
begin
  eAbonent.Enabled := cbAbonent.Checked;
  sbSelectAbonent.Enabled := cbAbonent.Checked;
end;

procedure TJornalAllFilterForm.cbBdateClick(Sender: TObject);
begin
  deBDate.Enabled := cbBdate.Checked;
end;

procedure TJornalAllFilterForm.cbCityNameClick(Sender: TObject);
begin
  cbCity.Enabled := cbCityName.Checked;
end;

procedure TJornalAllFilterForm.cdStreetNameClick(Sender: TObject);
begin
  cbStreet.Enabled := cdStreetName.Checked;
end;

procedure TJornalAllFilterForm.cbHouseClick(Sender: TObject);
begin
  eHouse.Enabled := cbHouse.Checked;
end;

function TJornalAllFilterForm.GetContractNum: Variant;
begin
  if cbContractNum.Checked then
  begin
    try
      Result := StrToInt(Trim(eContractNum.Text))
    except
      Result := Null;
    end;
  end
  else
    Result := Null;
end;

procedure TJornalAllFilterForm.SetContractNum(const Value: Variant);
begin
  eContractNum.Text := VarToStr(Value);
  cbContractNum.Checked := (VarToStr(Value) <> '');
end;

function TJornalAllFilterForm.GetConfirmed: Integer;
begin
  Result := cbConfirmed.ItemIndex;
end;

procedure TJornalAllFilterForm.SetConfirmed(const Value: Integer);
begin
  cbConfirmed.ItemIndex := Value;
end;

function TJornalAllFilterForm.GetPhoneNumCity: Variant;
begin
  if cbPhoneNumCity.Checked then
    Result := ePhoneNumCity.Text
  else
    Result := '';
end;

function TJornalAllFilterForm.GetPhoneNumFed: Variant;
begin
  if cbPhoneNumFed.Checked then
    Result := ePhoneNumFed.Text
  else
    Result := '';
end;

procedure TJornalAllFilterForm.SetPhoneNumCity(const Value: Variant);
begin
  ePhoneNumCity.Text := VarToStr(Value);
  cbPhoneNumCity.Checked := (VarToStr(Value) <> '');
end;

procedure TJornalAllFilterForm.SetPhoneNumFed(const Value: Variant);
begin
  ePhoneNumFed.Text := VarToStr(Value);
  cbPhoneNumFed.Checked := (VarToStr(Value) <> '');
end;

function TJornalAllFilterForm.GetFilterStr: String;
  function AddStr(const pStr : String; const pAddStr : String) : String;
  begin
    if pStr = '' then
      Result := pAddStr
    else
      Result := pStr + '; ' + pAddStr;
  end;
var vRes : String;
begin
  vRes := '';

  if (DateBegin > 0) and (DateEnd > 0) then
    vRes := AddStr(vRes, 'Период с ' + FormatDateTime('dd.mm.yyyy', DateBegin) + ' по ' + FormatDateTime('dd.mm.yyyy', DateEnd))
  else if (DateBegin > 0) then
    vRes := AddStr(vRes, 'Период с ' + FormatDateTime('dd.mm.yyyy', DateBegin))
  else if (DateEnd > 0) then
    vRes := AddStr(vRes, 'Период по ' + FormatDateTime('dd.mm.yyyy', DateEnd));

  if Confirmed = 1 then // только утвержденные
    vRes := AddStr(vRes, 'Только утвержденные')
  else if Confirmed = 2 then // только не утвержденные
    vRes := AddStr(vRes, 'Только НЕ утвержденные');

  if Confirmed = 1 then // только утвержденные
    vRes := AddStr(vRes, 'Только утвержденные')
  else if Confirmed = 2 then // только не утвержденные
    vRes := AddStr(vRes, 'Только НЕ утвержденные');

  if VarToStr(FilialId) <> '' then
    vRes := AddStr(vRes, 'Филиал :' + cbFilials.Text)
  else
    vRes := AddStr(vRes, 'Все филиалы');
  if VarToStr(ContractNum) <> '' then
    vRes := AddStr(vRes, 'Договор № ' + VarToStr(ContractNum));
  if VarToStr(PhoneNumFed) <> '' then
    vRes := AddStr(vRes, 'Телефон федеральный : ' + VarToStr(PhoneNumFed));
  if VarToStr(PhoneNumCity) <> '' then
    vRes := AddStr(vRes, 'Телефон городской : ' + VarToStr(PhoneNumCity));
  if VarToStr(AbonentId) <> '' then
    vRes := AddStr(vRes, 'Абонент : ' + eAbonent.Text);
  if BDate > 0 then
    vRes := AddStr(vRes, 'Дата рождения ' + FormatDateTime('dd.mm.yyyy', BDate));
  if VarToStr(CityName) <> '' then
    vRes := AddStr(vRes, 'Город : ' + VarToStr(CityName));
  if VarToStr(StreetName) <> '' then
    vRes := AddStr(vRes, 'Улица : ' + VarToStr(StreetName));
  if VarToStr(House) <> '' then
    vRes := AddStr(vRes, 'Дом : ' + VarToStr(House));
  if vRes = '' then
    vRes := 'Все документы';
  Result := vRes;
end;

procedure TJornalAllFilterForm.dsFilialsDataChange(Sender: TObject;
  Field: TField);
begin
  ;
end;

procedure TJornalAllFilterForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

procedure TJornalAllFilterForm.cbPhoneNumFedClick(Sender: TObject);
begin
  ePhoneNumFed.Enabled := cbPhoneNumFed.Checked;
end;

procedure TJornalAllFilterForm.cbPhoneNumCityClick(Sender: TObject);
begin
  ePhoneNumCity.Enabled := cbPhoneNumCity.Checked;
end;

procedure TJornalAllFilterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var vFloat : Double;
begin
  CanClose := True;
  if ModalResult = mrOk then
  begin
    if cbContractNum.Checked then
    begin
      vFloat := 0;
      try
        vFloat := StrToFloat(eContractNum.Text);
      except
        MessageDlg('Номер договора должен быть числом', mtError, [mbOK], 0);
        if eContractNum.CanFocus() then
          cbContractNum.SetFocus();
        CanClose := False;
      end;

      if CanClose then
      begin
        if vFloat <> Trunc(vFloat) then
        begin
          MessageDlg('Номер договора должен быть целым числом', mtError, [mbOK], 0);
          if eContractNum.CanFocus() then
            cbContractNum.SetFocus();
          CanClose := False;
        end;
      end;
    end;
  end;
end;

end.
