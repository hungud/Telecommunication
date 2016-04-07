unit uAddEditTurnTariffOpt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  MemDS, DBAccess, Ora;

type
  TfrmAddEditTurnTariffOpt = class(TForm)
    Label1: TLabel;
    ePhone: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnOk: TButton;
    btnCalcel: TButton;
    cbOptionName: TComboBox;
    cbAction_TYPE: TComboBox;
    dtActionDate: TDateTimePicker;
    qTarffOptions: TOraQuery;
    Label5: TLabel;
    cbOptionCode: TComboBox;
    qCheck: TOraQuery;
    qAdd: TOraQuery;
    qUpdate: TOraQuery;
    dtActionTime: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbOptionNameChange(Sender: TObject);
    procedure cbOptionCodeChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FRecId : Integer;
    FPhoneNumber : string;
    FOptCode : String;
    FActionType : Integer;
    FActionDate : TDateTime;
  public
    { Public declarations }
  end;
  function DoAddEditTurnTariffOpt(
                                    pPhoneNumber : String;
                                    pOptCode : String;
                                    pActionType : Integer;
                                    pActionDate : TDateTime;
                                    pRecId : Integer
                                   ) : Boolean;

var
  frmAddEditTurnTariffOpt: TfrmAddEditTurnTariffOpt;

implementation

{$R *.dfm}

function DoAddEditTurnTariffOpt(
                                    pPhoneNumber : String;
                                    pOptCode : String;
                                    pActionType : Integer;
                                    pActionDate : TDateTime;
                                    pRecId : Integer
                                   ) : Boolean;
var
  frm: TfrmAddEditTurnTariffOpt;
begin
  frm := TfrmAddEditTurnTariffOpt.Create(nil);
  try
    if pPhoneNumber <> '' then
    begin
      frm.FPhoneNumber := pPhoneNumber;
      frm.FOptCode := pOptCode;
      frm.FActionType := pActionType;
      frm.FActionDate := pActionDate;
      frm.FRecId := pRecId;
      frm.ePhone.Enabled := False;
      frm.Caption := 'Редактирование записи';
    end
    else
    begin
      frm.FRecId := -1;
      frm.FPhoneNumber := '';
      frm.FOptCode := '';
      frm.FActionType := -1;
      frm.FActionDate := NOW;
      frm.ePhone.Enabled := True;
      frm.Caption := 'Добавление записи';
    end;
    Result := (frm.ShowModal = mrOk);
  finally
    FreeAndNil(frm)
  end;
end;

procedure TfrmAddEditTurnTariffOpt.cbOptionCodeChange(Sender: TObject);
begin
  cbOptionName.ItemIndex := cbOptionCode.ItemIndex;
end;

procedure TfrmAddEditTurnTariffOpt.cbOptionNameChange(Sender: TObject);
begin
  cbOptionCode.ItemIndex := cbOptionName.ItemIndex;
end;

procedure TfrmAddEditTurnTariffOpt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  phone : string;
  ActionDate : TDateTime;
  procedure ShowM (mText : string );
  begin
    MessageDlg(mText, mtError, [mbOK], 0);
    ModalResult := mrNone;
  end;
begin
  if ModalResult = mrOk then
  begin
    // проверяем на ошибки
    phone := Trim(ePhone.Text);
    if Length(phone) = 0 then
      ShowM('Номер телефона обязателен для заполнения!')
    else if cbOptionCode.ItemIndex = -1 then
      ShowM('Тарифная опция обязательна для заполнения!')
    else if cbAction_TYPE.ItemIndex = -1 then
      ShowM('Тип операции обязателен для заполнения!');

    if ModalResult = mrNone then
    begin
      CanClose := False;
      Exit;
    end;

    ActionDate := StrToDateTime(DateToStr(dtActionDate.Date) + TimeToStr(dtActionTime.Time));

    qCheck.Close;
    qCheck.ParamByName('phone_number').Value := phone;
    qCheck.ParamByName('option_code').Value := cbOptionCode.Text ;
    qCheck.ParamByName('ACTION_TYPE').Value := cbAction_TYPE.ItemIndex;
    //qCheck.ParamByName('ACTION_TYPE').Value := cbAction_TYPE.ItemIndex;
    if FRecId = -1 then
      qCheck.ParamByName('ACTION_DATE').Value := null
    else
      qCheck.ParamByName('ACTION_DATE').Value := ActionDate;
    qCheck.Open;

    if qCheck.FieldByName('ct').AsInteger > 0 then
    begin
        MessageDlg('Запись с такими данными уже существует!!!', mtError, [mbOK], 0);
        CanClose := False;
        ModalResult := mrNone;
        exit;
    end;
    //если все проверки пройдены, то добавляем запись/обновляем
    if FRecId <> -1 then
    begin
      qUpdate.ParamByName('OPTION_CODE').Value := cbOptionCode.Text ;
      qUpdate.ParamByName('ACTION_TYPE').Value := cbAction_TYPE.ItemIndex;
      qUpdate.ParamByName('ACTION_DATE').Value := ActionDate;
      qUpdate.ParamByName('DELAYED_TURN_TO_ID').Value := FRecId;
      qUpdate.ExecSQL;
    end
    else
    begin
      qAdd.ParamByName('PHONE_NUMBER').Value := phone;
      qAdd.ParamByName('OPTION_CODE').Value := cbOptionCode.Text ;
      qAdd.ParamByName('ACTION_TYPE').Value := cbAction_TYPE.ItemIndex;
      qAdd.ParamByName('ACTION_DATE').Value := ActionDate;
      qAdd.ExecSQL;
    end;

  end;
end;

procedure TfrmAddEditTurnTariffOpt.FormCreate(Sender: TObject);
begin
  cbOptionName.Items.Clear;
  cbOptionCode.Items.Clear;
  qTarffOptions.Open;
  qTarffOptions.First;
  while not qTarffOptions.Eof do
  begin
    cbOptionName.Items.Add (qTarffOptions.FieldByName('option_name').AsString);
    cbOptionCode.Items.Add (qTarffOptions.FieldByName('option_code').AsString);
    qTarffOptions.Next;
  end;
end;

procedure TfrmAddEditTurnTariffOpt.FormShow(Sender: TObject);
begin
  ePhone.Text := FPhoneNumber;
  cbOptionCode.ItemIndex := cbOptionCode.Items.IndexOf(FOptCode);
  cbOptionName.ItemIndex := cbOptionCode.ItemIndex;
  cbAction_TYPE.ItemIndex := FActionType;
  dtActionDate.DateTime :=  Trunc(FActionDate);
  dtActionTime.Time :=  Frac(FActionDate);
end;

end.
