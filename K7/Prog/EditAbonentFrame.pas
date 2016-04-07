unit EditAbonentFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, Ora, MemDS, DBAccess, StdCtrls, Mask, DBCtrls,
  ComCtrls, Buttons, Main, ActnList, ToolWin;

type
  TEditAbonentFrme = class(TFrame)
    qCountries_Citizen: TOraQuery;
    qGetNewId: TOraStoredProc;
    qMain: TOraQuery;
    qCountries: TOraQuery;
    qRegions: TOraQuery;
    Panel1: TPanel;
    dsMain: TDataSource;
    SURNAME: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    NAME: TDBEdit;
    Label3: TLabel;
    PATRONYMIC: TDBEdit;
    Label4: TLabel;
    BDATE: TDBEdit;
    pPassport: TPanel;
    Label6: TLabel;
    PASSPORT_SER: TDBEdit;
    PASSPORT_GET: TDBEdit;
    Label8: TLabel;
    PASSPORT_NUM: TDBEdit;
    Label7: TLabel;
    PASSPORT_DATE: TDBEdit;
    GroupBox2: TPanel;
    Label9: TLabel;
    COUNTRY_ID: TDBLookupComboBox;
    Label10: TLabel;
    REGION_ID: TDBLookupComboBox;
    Label11: TLabel;
    CITY_NAME: TDBEdit;
    STREET_NAME: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    HOUSE: TDBEdit;
    KORPUS: TDBEdit;
    APARTMENT: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox3: TPanel;
    Label16: TLabel;
    CONTACT_INFO: TDBEdit;
    CODE_WORD: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Bevel2: TBevel;
    Label19: TLabel;
    Bevel3: TBevel;
    dsCitizens: TDataSource;
    dsCountry: TDataSource;
    dsRegions: TDataSource;
    Label20: TLabel;
    CITIZENSHIP: TDBLookupComboBox;
    IS_VIP: TCheckBox;
    ActionList1: TActionList;
    aFindAbonent: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    EMAIL: TDBEdit;
    Label21: TLabel;
    qAbonentID: TOraQuery;
    Label22: TLabel;
    DESCRIPTION: TDBMemo;
    procedure aFindAbonentExecute(Sender: TObject);
    procedure DoChange(Sender: TObject);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure BDATEChange(Sender: TObject);
  private
    { Private declarations }
    FRunMode : String;
    FPreparing : boolean;
    fChanged : boolean;
    procedure SetEnabledAll(const pEnabled: boolean);
  public
    FAbonentId : Variant;
    //
    function PrepareFrame(const pRunMode : String; const pAbonentId : Variant) : boolean;
    function PrepareFrameByContractID(const pRunMode : String; const pContractID : Integer) : boolean;
    function SaveData(const DefaultNameValue : String) : boolean;
    procedure CancelChanges;
  end;

//  function DoAddContract(var pContractId : Variant) : boolean;
//  function DoEditContract(const pContractId : Variant) : boolean;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, RefAbonents;

{ TEditAbonentFrme }

procedure TEditAbonentFrme.SetEnabledAll(const pEnabled : boolean);
var i : Integer;
begin
  for i := 0 to Self.ComponentCount-1 do
  begin
    if (Self.Components[i] is TCustomEdit)
      or (Self.Components[i] is TCustomLabel)
      or (Self.Components[i] is TCheckBox)
      or (Self.Components[i] is TCommonCalendar)
      or (Self.Components[i] is TDBLookupControl)
    then
      (Self.Components[i] as TControl).Enabled := pEnabled;
  end;
  aFindAbonent.Enabled := pEnabled;
end;

function TEditAbonentFrme.PrepareFrameByContractID(const pRunMode: String; const pContractID:Integer):boolean;
begin
  qAbonentID.ParamByName('CONTRACT_ID').AsInteger:=pContractID;
  qAbonentID.Open;
  Result:=PrepareFrame(pRunMode,qAbonentID.FieldByName('ABONENT_ID').AsVariant);
  qAbonentID.Close;
end;

function TEditAbonentFrme.PrepareFrame(const pRunMode: String; const pAbonentId: Variant) : boolean;
var vDoPrepare : Boolean;
begin
  // если был изменение, то спрашиваем - нужно ли сохранить
  if fChanged then
  begin
    if mrYes = MessageDlg('В параметры абонента были внесены изменения. Сохранить их ?', mtConfirmation, [mbYes, mbNo], 0) then
      vDoPrepare := SaveData('')
    else
    begin
      vDoPrepare := True;
      fChanged := False;
    end;
  end
  else
    vDoPrepare := True;

  Result := vDoPrepare;

  if vDoPrepare then
  begin
    FPreparing := True;
    try
      FRunMode := pRunMode;

      if pRunMode = 'INSERT' then
      begin
        FAbonentId := Null;

        SetEnabledAll(True);

        qCountries_Citizen.Close;
        qCountries_Citizen.Open;
        qCountries.Close;
        qCountries.Open;
        qRegions.Close;
        qRegions.Open;

        qMain.Close;
        qMain.ParamByName('ABONENT_ID').Value := Null;
        qMain.Open;
        qMain.Insert;
//        BDATE.Date := 0;
//        PASSPORT_DATE.Date := Date;

        IS_VIP.Checked := False;

        qMain.FieldByName('CITIZENSHIP').Value := GetDefaultCountry;
        qMain.FieldByName('COUNTRY_ID').Value := GetDefaultCountry;
        qMain.FieldByName('REGION_ID').Value := GetDefaultregion;

        aFindAbonent.Visible := False;
      end
      else if pRunMode = 'EDIT' then
      begin
        if VarToStr(pAbonentId) = '' then
          MessageDlg('Не возможно редактировать параметры абонента. Код абонента не передан.', mtError, [mbOK], 0)
        else
        begin
          FAbonentId := pAbonentId;

          qCountries_Citizen.Close;
          qCountries_Citizen.Open;
          qCountries.Close;
          qCountries.Open;
          qRegions.Close;
          qRegions.Open;

          qMain.Close;
          qMain.ParamByName('ABONENT_ID').Value := FAbonentId;
          qMain.Open;
          if qMain.RecordCount = 0 then
            MessageDlg('Не возможно редактировать параметры абонента. Не найден абонент с кодом .', mtError, [mbOK], 0)
          else
          begin
            SetEnabledAll(True);

            qMain.Edit;
{            if qMain.FieldByName('BDATE').IsNull then
              BDATE.Date := 0
            else
              BDATE.Date := qMain.FieldByName('BDATE').AsDateTime;}
{            if qMain.FieldByName('PASSPORT_DATE').IsNull then
            begin
              PASSPORT_DATE.Date := 0;
              // Если format = 'gg', то текст будет пустой
              PASSPORT_DATE.Format := ' ';
            end
            else
            begin
              PASSPORT_DATE.Date := qMain.FieldByName('PASSPORT_DATE').AsDateTime;
              // Если format = 'gg', то текст будет пустой
              PASSPORT_DATE.Format := '';
            end;}
            IS_VIP.Checked := (qMain.FieldByName('IS_VIP').AsString = '1');

            aFindAbonent.Visible := True;
          end;
        end;
      end
      else if pRunMode = 'VIEW' then
      begin
        if VarToStr(pAbonentId) = '' then
          MessageDlg('Невозможно смотреть параметры абонента. Код абонента не передан.', mtError, [mbOK], 0)
        else
        begin
          FAbonentId := pAbonentId;

          qCountries_Citizen.Close;
          qCountries_Citizen.Open;
          qCountries.Close;
          qCountries.Open;
          qRegions.Close;
          qRegions.Open;

          qMain.Close;
          qMain.ParamByName('ABONENT_ID').Value := FAbonentId;
          qMain.Open;
          if qMain.RecordCount = 0 then
            MessageDlg('Невозможно смотреть параметры абонента. Не найден абонент с кодом .', mtError, [mbOK], 0)
          else
          begin
            qMain.ReadOnly := True;
            SetEnabledAll(True);

//            qMain.Edit;
{            if qMain.FieldByName('BDATE').IsNull then
              BDATE.Date := 0
            else
              BDATE.Date := qMain.FieldByName('BDATE').AsDateTime;}
{            if qMain.FieldByName('PASSPORT_DATE').IsNull then
            begin
              PASSPORT_DATE.Date := 0;
              // Если format = 'gg', то текст будет пустой
              PASSPORT_DATE.Format := ' ';
            end
            else
            begin
              PASSPORT_DATE.Date := qMain.FieldByName('PASSPORT_DATE').AsDateTime;
              // Если format = 'gg', то текст будет пустой
              PASSPORT_DATE.Format := '';
            end;}
            IS_VIP.Checked := (qMain.FieldByName('IS_VIP').AsString = '1');

            aFindAbonent.Visible := False;
          end;
        end;
      end
      else if pRunMode = 'DISABLE' then
      begin
        FAbonentId := Null;

        SetEnabledAll(False);

        qMain.Close;
{        BDATE.Date := 0;
        PASSPORT_DATE.Date := 0;
        // Если format = 'gg', то текст будет пустой
        PASSPORT_DATE.Format := 'gg';}
        IS_VIP.Checked := False;

        aFindAbonent.Visible := True;
      end;
    finally
      FPreparing := False;
    end;
  end;
end;

function TEditAbonentFrme.SaveData(const DefaultNameValue : String): boolean;
var
  EmptyNamesAllowed : Boolean;
begin
  Result := False;
  if (FRunMode = 'INSERT') or (FRunMode = 'EDIT') then
  begin
    if qMain.Active and ((qMain.RecordCount > 0) or (qMain.State in [dsInsert])) then
    begin
      EmptyNamesAllowed := ('1' = GetConstantValue('EMPTY_ABONENT_NAME_ALLOWED'));
      if (Trim(SURNAME.Text) = '') and EmptyNamesAllowed then
        SURNAME.Text := DefaultNameValue;
      if (Trim(NAME.Text) = '') and EmptyNamesAllowed then
        NAME.Text := DefaultNameValue;
      if (Trim(PATRONYMIC.Text) = '') and EmptyNamesAllowed then
        PATRONYMIC.Text := DefaultNameValue;
      if Trim(SURNAME.Text) = '' then
      begin
        MessageDlg('Фамилия должна быть заполнена', mtError, [mbOK], 0);
        if Self.Visible and SURNAME.CanFocus() then
          SURNAME.SetFocus();
      end
      else if Trim(NAME.Text) = '' then
      begin
        MessageDlg('Имя должно быть заполнено', mtError, [mbOK], 0);
        if Self.Visible and NAME.CanFocus() then
          NAME.SetFocus();
      end
      else if (Trim(PATRONYMIC.Text) = '') {and (not cbOutPatronymic.Checked)} then
      begin
        MessageDlg('Необходимо заполнить отчество или поставьте "-"', mtError, [mbOK], 0);
        if Self.Visible and PATRONYMIC.CanFocus() then
          PATRONYMIC.SetFocus();
      end
      else if (qMain.FieldByName('BDATE').AsDateTime = 0) and not EmptyNamesAllowed then
      begin
        MessageDlg('Дата рождения должна быть заполнена', mtError, [mbOK], 0);
        if Self.Visible and BDATE.CanFocus() then
          BDATE.SetFocus();
      end
      else
      begin
        if (qMain.State in [dsInsert]) then
        begin
          qGetNewId.ExecSQL;
          qMain.FieldByName(qMain.KeyFields).Value := qGetNewId.ParamByName('RESULT').Value;
          FAbonentId := qMain.FieldByName(qMain.KeyFields).Value;
        end;

//        qMain.FieldByName('BDATE').AsDateTime := Trunc(BDATE.Date);
//        qMain.FieldByName('PASSPORT_DATE').AsDateTime := Trunc(PASSPORT_DATE.Date);
        if IS_VIP.Checked then
          qMain.FieldByName('IS_VIP').Value := 1
        else
          qMain.FieldByName('IS_VIP').Value := Null;
        //
        try
          qMain.Post;
          fChanged := False;
          Result := True;
        except
          on e : exception do
            MessageDlg('Невозможно сохранить параметры абонента.'#13#10 + e.Message, mtError, [mbOK], 0);
        end;
      end;
    end
    else
      MessageDlg('Невозможно сохранить параметры абонента.', mtError, [mbOK], 0);
  end
  else
    MessageDlg('Сохранить параметры абонента можно только в режиме добавления или редактирования.', mtError, [mbOK], 0);
end;

procedure TEditAbonentFrme.aFindAbonentExecute(Sender: TObject);
var vAbonentId : Variant;
begin
  vAbonentId := SelectAbonent();
  if VarToStr(vAbonentId) <> '' then
  begin
    PrepareFrame('EDIT', vAbonentId);
  end; 
end;

procedure TEditAbonentFrme.DoChange(Sender: TObject);
begin
  if not FPreparing then
    fChanged := True;
end;

procedure TEditAbonentFrme.qMainAfterOpen(DataSet: TDataSet);
begin
  (qMain.FieldByName('PASSPORT_DATE') As TDateTimeField).DisplayFormat := 'dd.mm.yyyy';
  (qMain.FieldByName('BDATE') As TDateTimeField).DisplayFormat := 'dd.mm.yyyy';
end;

procedure TEditAbonentFrme.BDATEChange(Sender: TObject);
var
  DBEdit : TDBEdit;
  L : Integer;
begin
  DBEdit := (Sender As TDBEdit);
  L := Length(DBEdit.Text);
  if L in [2, 5] then
  begin
    DBEdit.Text := DBEdit.Text + '.';
    DBEdit.SelStart := L+1;
  end;
  DoChange(Sender);
end;

procedure TEditAbonentFrme.CancelChanges;
begin
  qMain.Cancel;
  fChanged := False;
end;

end.
