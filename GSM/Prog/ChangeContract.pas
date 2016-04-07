unit ChangeContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ora, DB, MemDS, DBAccess, ActnList, StdCtrls, Buttons, Mask,
  DBCtrls, ComCtrls, ExtCtrls;

type
  TChangeContractForm = class(TForm)
    ActionList1: TActionList;
    aSelectContract: TAction;
    aSelectAbonent: TAction;
    dsContarct: TDataSource;
    dsContractChange: TDataSource;
    qFilials: TOraQuery;
    dsFilials: TDataSource;
    qContractChange: TOraQuery;
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
    pOPERATOR_ID: TPanel;
    Label12: TLabel;
    OPERATOR_ID: TDBLookupComboBox;
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
    CONTRACT_CHANGE_DATE: TDateTimePicker;
    pPHONE_NUMBER_FEDERAL: TPanel;
    Label16: TLabel;
    PHONE_NUMBER_FEDERAL: TDBEdit;
    pPHONE_NUMBER_CITY: TPanel;
    Label15: TLabel;
    PHONE_NUMBER_CITY: TDBEdit;
    pSIM_NUMBER: TPanel;
    Label17: TLabel;
    SIM_NUMBER: TDBEdit;
    pSUM_GET: TPanel;
    Label20: TLabel;
    SUM_GET: TDBEdit;
    Label6: TLabel;
    DBText6: TDBText;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetEnabledAll(const pEnabled: boolean);
    function CheckDate(var pErrorMessage : String) : boolean;
  public
    FReadData : boolean;
    FRunMode : String;
    FContractChangeId : Variant;
    FDocumTypeId : Variant;
    function PrepareForm(const pRunMode: String;
                         const pContractChangeId, pContractId, pDocumTypeId: Variant): boolean;
    function SaveData: boolean;
    procedure SetDocumType(const pDocumTypeId: Variant);
  end;

//var
//  ChangeContractForm: TChangeContractForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TChangeContractForm.SetEnabledAll(const pEnabled: boolean);
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

function TChangeContractForm.PrepareForm(const pRunMode: String;
                                          const pContractChangeId : Variant;
                                          const pContractId: Variant;
                                          const pDocumTypeId : Variant
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
          MessageDlg('Не возможно зарегистрировать изменение договора. Код договора не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else if VarToStr(pDocumTypeId) = '' then
        begin
          MessageDlg('Не возможно зарегистрировать изменение договора. Код типа документа не передан.', mtError, [mbOK], 0);
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

          if qContract.Active and (qContract.RecordCount > 0) then
          begin
            qTariffs.Filter := 'OPERATOR_ID = '+ qContract.FieldByName('OPERATOR_ID').AsString;
            qTariffs.Filtered := True;
          end
          else
            qTariffs.Filtered := False;

          qContractChange.Close;
          qContractChange.ParamByName('CONTRACT_CHANGE_ID').Value := Null;
          qContractChange.Open;
          qContractChange.Insert;
          CONTRACT_CHANGE_DATE.Date := Date();
          //qContractChange.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime := Date();
          //qContractChange.FieldByName('FILIAL_ID').Value := GetDefaultFilialId();
          qContractChange.FieldByName('CONTRACT_ID').Value := pContractId;
          qContractChange.FieldByName('DOCUM_TYPE_ID').Value := pDocumTypeId;

          FDocumTypeId := pDocumTypeId;

          Result := True;
        end;
      end
      else if pRunMode = 'EDIT' then
      begin
        if VarToStr(pContractChangeId) = '' then
        begin
          MessageDlg('Не возможно редактировать изменение договора. Код изменения договора не передан.', mtError, [mbOK], 0);
          Result := False;
        end
        else
        begin
          FContractChangeId := pContractChangeId;

          qFilials.Close;
          qFilials.Open;
          //qOperators.Close;
          //qOperators.Open;
          qTariffs.Close;
          qTariffs.Open;
          qTariffs.Filtered := False;

          qContractChange.Close;
          qContractChange.ParamByName('CONTRACT_CHANGE_ID').Value := pContractChangeId;
          qContractChange.Open;

          if qContractChange.RecordCount = 0 then
          begin
            MessageDlg('Не возможно редактировать изменение договора. Не найден документ изменения договора с кодом .', mtError, [mbOK], 0);
            Result := False;
          end
          else
          begin
            SetEnabledAll(True);

            qContract.Close;
            qContract.ParamByName('CONTRACT_ID').Value := qContractChange.FieldByName('CONTRACT_ID').Value;
            qContract.Open;

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

            qContractChange.Edit;
            if qContractChange.FieldByName('CONTRACT_CHANGE_DATE').IsNull then
              CONTRACT_CHANGE_DATE.Date := 0
            else
              CONTRACT_CHANGE_DATE.Date := qContractChange.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime;

            FDocumTypeId := qContractChange.FieldByName('DOCUM_TYPE_ID').Value;

            Result := True;
          end;
        end;
      end
      else if pRunMode = 'DISABLE' then
      begin
        SetEnabledAll(False);

        qContract.Close;
        qContractChange.Close;
        CONTRACT_CHANGE_DATE.Date := 0;

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

function TChangeContractForm.CheckDate(var pErrorMessage : String) : boolean;
var vIsError : boolean;
begin
  vIsError := False;

  if pCONTRACT_CHANGE_DATE.Visible then
  begin
    if (Trunc(CONTRACT_CHANGE_DATE.Date) = 0) then
    begin
      vIsError := True;
      pErrorMessage := 'Дата изменения договора должна быть заполнена';
    end
    else
    begin
      if qContract.Active and (qContract.RecordCount > 0) then
      begin
        if (Trunc(qContract.FieldByName('CONTRACT_DATE').AsDateTime) >= Trunc(CONTRACT_CHANGE_DATE.Date)) then
        begin
          vIsError := True;
          pErrorMessage := 'Дата изменения договора должна быть больше даты заключения договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_DATE').AsDateTime);
        end
        else if (qContractChange.State in [dsInsert]) and (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) then
        begin
          vIsError := True;
          pErrorMessage := 'Не возможно добавить изменение договора. Договор уже расторгнут.';
        end
        else if (not qContract.FieldByName('CONTRACT_CANCEL_DATE').IsNull) and
                (Trunc(qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime) < Trunc(CONTRACT_CHANGE_DATE.Date)) then
        begin
          vIsError := True;
          pErrorMessage := 'Дата изменения договора не должна быть больше даты расторжения договора '+
                   FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime);
        end
        // проверяем чтобы было после последнего изменения только если добавление
        else if (qContractChange.State in [dsInsert]) and
                 (Trunc(qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime) >= Trunc(CONTRACT_CHANGE_DATE.Date)) then
        begin
          vIsError := True;
          pErrorMessage := 'Дата изменения договора должна быть больше даты предыдущего изменения договора '+
                           FormatDateTime('dd.mm.yyyy', qContract.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime);
        end;
      end;
    end;
  end;
  Result := (not vIsError);
end;

function TChangeContractForm.SaveData: boolean;
var vErrorMessage : String;
begin
  Result := False;
  if (FRunMode = 'INSERT') or (FRunMode = 'EDIT') then
  begin
    // чтобы данные из DB компонентов перешли в Dataset
    if Self.Visible and btnOk.CanFocus() then
      btnOk.SetFocus();

    if qContractChange.Active and ((qContractChange.RecordCount > 0) or (qContractChange.State in [dsInsert])) then
    begin
      if pFILIAL_ID.Visible and (qContractChange.FieldByName('FILIAL_ID').AsString = '') then
      begin
        MessageDlg('Филиал должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and FILIAL_ID.CanFocus() then
          FILIAL_ID.SetFocus();
      end
      else if pOPERATOR_ID.Visible and (qContractChange.FieldByName('OPERATOR_ID').AsString = '') then
      begin
        MessageDlg('Оператор должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and OPERATOR_ID.CanFocus() then
          OPERATOR_ID.SetFocus();
      end
      else if pTARIFF_ID.Visible and (qContractChange.FieldByName('TARIFF_ID').AsString = '') then
      begin
        MessageDlg('Тариф должен быть быть определен', mtError, [mbOK], 0);
        if Self.Visible and TARIFF_ID.CanFocus() then
          TARIFF_ID.SetFocus();
      end
      {
      else if pCONTRACT_CHANGE_DATE.Visible and (Trunc(CONTRACT_CHANGE_DATE.Date) = 0) then
      begin
        MessageDlg('Дата изменения договора должна быть заполнена', mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CHANGE_DATE.CanFocus() then
          CONTRACT_CHANGE_DATE.SetFocus();
      end
      }
      else if pPHONE_NUMBER_FEDERAL.Visible and (Trim(PHONE_NUMBER_FEDERAL.Text) = '') then
      begin
        MessageDlg('Федеральный номер телефона должен быть заполнен', mtError, [mbOK], 0);
        if Self.Visible and PHONE_NUMBER_FEDERAL.CanFocus() then
          PHONE_NUMBER_FEDERAL.SetFocus();
      end
      else if pPHONE_NUMBER_CITY.Visible and (Trim(PHONE_NUMBER_CITY.Text) <> '') and (Length(Trim(PHONE_NUMBER_CITY.Text)) <> 7) then
      begin
        MessageDlg('Городской номер должен быть длиной 7 символов', mtError, [mbOK], 0);
        if Self.Visible and PHONE_NUMBER_CITY.CanFocus() then
          PHONE_NUMBER_CITY.SetFocus();
      end
      else if pPHONE_NUMBER_FEDERAL.Visible and (Length(Trim(PHONE_NUMBER_FEDERAL.Text)) <> 10) then
      begin
        MessageDlg('Федеральный номер должен быть длиной 10 символов', mtError, [mbOK], 0);
        if Self.Visible and PHONE_NUMBER_FEDERAL.CanFocus() then
          PHONE_NUMBER_FEDERAL.SetFocus();
      end
      else if pSIM_NUMBER.Visible and (Trim(SIM_NUMBER.Text) = '') then
      begin
        MessageDlg('Номер SIM карты должен быть заполнен', mtError, [mbOK], 0);
        if Self.Visible and SIM_NUMBER.CanFocus() then
          SIM_NUMBER.SetFocus();
      end
      else if pSIM_NUMBER.Visible and (Trim(SIM_NUMBER.Text) = '') then
      begin
        MessageDlg('Номер SIM карты должен быть заполнен', mtError, [mbOK], 0);
        if Self.Visible and SIM_NUMBER.CanFocus() then
          SIM_NUMBER.SetFocus();
      end
{      else if pSIM_NUMBER.Visible and (Length(Trim(SIM_NUMBER.Text)) <> 20) then
      begin
        MessageDlg('Номер SIM карты должен быть длиной 20 символов', mtError, [mbOK], 0);
        if Self.Visible and SIM_NUMBER.CanFocus() then
          SIM_NUMBER.SetFocus();
      end}
      else if (not CheckDate(vErrorMessage)) then
      begin
        MessageDlg(vErrorMessage, mtError, [mbOK], 0);
        if Self.Visible and CONTRACT_CHANGE_DATE.CanFocus() then
          CONTRACT_CHANGE_DATE.SetFocus();
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
        if (qContractChange.State in [dsInsert]) then
        begin
          qGetNewId.ExecSQL;
          qContractChange.FieldByName('CONTRACT_CHANGE_ID').Value := qGetNewId.ParamByName('RESULT').Value;
          FContractChangeId := qContractChange.FieldByName('CONTRACT_CHANGE_ID').Value;
        end;

        qContractChange.FieldByName('CONTRACT_CHANGE_DATE').AsDateTime := Trunc(CONTRACT_CHANGE_DATE.Date);
        //
        try
          qContractChange.Post;
          Result := True;
        except
          on e : exception do
            MessageDlg('Не возможно сохранить параметры изменения договора.'#13#10 + e.Message, mtError, [mbOK], 0);
        end;
      end;
    end
    else
      MessageDlg('Не возможно сохранить параметры изменения договора.', mtError, [mbOK], 0);
  end
  else
    MessageDlg('Сохранить параметры изменения договора можно только в режиме добавления или редактирования.', mtError, [mbOK], 0);
end;

procedure TChangeContractForm.FormShow(Sender: TObject);
begin
  if not FReadData then
  begin
    SetDocumType(FDocumTypeId);

    if pTARIFF_ID.Visible and TARIFF_ID.CanFocus then
      TARIFF_ID.SetFocus()
    else if pPHONE_NUMBER_FEDERAL.Visible and PHONE_NUMBER_FEDERAL.CanFocus then
      PHONE_NUMBER_FEDERAL.SetFocus()
    else if pSIM_NUMBER.Visible and SIM_NUMBER.CanFocus then
      SIM_NUMBER.SetFocus()
    else if pSUM_GET.Visible and SUM_GET.CanFocus then
      SUM_GET.SetFocus();
  end;
end;

procedure TChangeContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

procedure TChangeContractForm.FormCloseQuery(Sender: TObject;
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

procedure TChangeContractForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qTariffs.SQL.Append('    AND FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    qFilials.SQL.Append('    AND FILIAL_ID = ' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TChangeContractForm.SetDocumType(const pDocumTypeId: Variant);
begin
{
  pFILIAL_ID.Visible := False;
  pCONTRACT_CHANGE_DATE.Visible := False;
  pOPERATOR_ID.Visible := False;
  pTARIFF_ID.Visible := False;
  pPHONE_NUMBER_FEDERAL.Visible := False;
  pPHONE_NUMBER_CITY.Visible := False;
  pSIM_NUMBER.Visible := False;
  pSUM_GET.Visible := False;
  pButtons.Visible := False;
}
  if pDocumTypeId = TYPE_DOC_CHANGE_PHONE_NUM then
  begin
    pFILIAL_ID.Visible := True;
    pCONTRACT_CHANGE_DATE.Visible := True;
    pOPERATOR_ID.Visible := False;
    pTARIFF_ID.Visible := False;
    pPHONE_NUMBER_FEDERAL.Visible := True;
    pPHONE_NUMBER_CITY.Visible := True;
    pSIM_NUMBER.Visible := True;
    pSUM_GET.Visible := True;
    pButtons.Visible := True;
    Self.Caption := 'Изменение номера телефона';
    Self.Height := Self.Height + 1;
  end
  else if pDocumTypeId = TYPE_DOC_CHANGE_SIM then
  begin
    pFILIAL_ID.Visible := True;
    pCONTRACT_CHANGE_DATE.Visible := True;
    pOPERATOR_ID.Visible := False;
    pTARIFF_ID.Visible := False;
    pPHONE_NUMBER_FEDERAL.Visible := False;
    pPHONE_NUMBER_CITY.Visible := False;
    pSIM_NUMBER.Visible := True;
    pSUM_GET.Visible := True;
    pButtons.Visible := True;
    Self.Caption := 'Изменение номера СИМ карты';
    Self.Height := Self.Height + 1;
  end
  else if pDocumTypeId = TYPE_DOC_CHANGE_TARIFF then
  begin
    pFILIAL_ID.Visible := True;
    pCONTRACT_CHANGE_DATE.Visible := True;
    pOPERATOR_ID.Visible := False;
    pTARIFF_ID.Visible := True;
    pPHONE_NUMBER_FEDERAL.Visible := False;
    pPHONE_NUMBER_CITY.Visible := False;
    pSIM_NUMBER.Visible := False;
    pSUM_GET.Visible := True;
    pButtons.Visible := True;
    Self.Caption := 'Изменение тарифа';
    Self.Height := Self.Height + 1;
  end
  else
    MessageDlg('Тип изменения договора с кодом '+VarToStr(pDocumTypeId)+' не поддерживается.', mtError, [mbOK], 0);
end;

end.
