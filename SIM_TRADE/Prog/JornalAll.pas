unit JornalAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, Menus,
  ActnList, DB, Ora, MemDS, DBAccess, EditContract, JornalAllFilter,
  StdCtrls, CancelContract, ChangeContract,ExportGridToExcelPDF,
  RegisterPayment, Excel2000, ComObj, ActiveX;

type
  TJornalAllForm = class(TForm)
    qGetNewId: TOraStoredProc;
    qMain: TOraQuery;
    DataSource1: TDataSource;
    ActionList1: TActionList;
    aNewContract: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aCancelContract: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton7: TToolButton;
    tbPrint: TToolButton;
    ToolButton8: TToolButton;
    tbAddFunctions: TToolButton;
    Panel2: TPanel;
    CRDBGrid1: TCRDBGrid;
    aPrint: TAction;
    aChangeNumber: TAction;
    aExcel: TAction;
    ToolButton3: TToolButton;
    aFilter: TAction;
    ToolButton9: TToolButton;
    N4: TMenuItem;
    N8: TMenuItem;
    MSExcel1: TMenuItem;
    N9: TMenuItem;
    pFilter: TPanel;
    qFilials: TOraQuery;
    qMainSQL: TOraQuery;
    lFilterCaption: TLabel;
    Label2: TLabel;
    qPrintContract: TOraQuery;
    tbCurrentFilial: TToolButton;
    pmFilials: TPopupMenu;
    ToolButton11: TToolButton;
    pmPrint: TPopupMenu;
    aPrintContract2: TAction;
    aPrintContractExcel: TAction;
    N10: TMenuItem;
    N21: TMenuItem;
    Excel1: TMenuItem;
    qDeleteContract: TOraQuery;
    qDeleteContractCancel: TOraQuery;
    qDeleteContractChange: TOraQuery;
    aChangeSIM: TAction;
    aChangeTariff: TAction;
    pmAddFunctions: TPopupMenu;
    N11: TMenuItem;
    SIM1: TMenuItem;
    N12: TMenuItem;
    N7: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    SIM2: TMenuItem;
    N15: TMenuItem;
    N22: TMenuItem;
    Excel2: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    ToolButton5: TToolButton;
    aRegisterPayment: TAction;
    ToolButton6: TToolButton;
    ToolButton10: TToolButton;
    N19: TMenuItem;
    aShowUserStatInfo: TAction;
    ToolButton4: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    aLoadFromExcel: TAction;
    Excel3: TMenuItem;
    Excel4: TMenuItem;
    qDeletePayment: TOraQuery;
    ToolButton15: TToolButton;
    CheckFilter: TCheckBox;
    spChangeSendActiv: TOraStoredProc;
    procedure aNewContractExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CRDBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aFilterExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aPrintExecute(Sender: TObject);
    procedure SelectFilialExecute(Sender: TObject);
    procedure tbCurrentFilialClick(Sender: TObject);
    procedure aCancelContractExecute(Sender: TObject);
    procedure pFilterDblClick(Sender: TObject);
    procedure aChangeNumberExecute(Sender: TObject);
    procedure tbAddFunctionsClick(Sender: TObject);
    procedure aChangeSIMExecute(Sender: TObject);
    procedure aChangeTariffExecute(Sender: TObject);
    procedure CRDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CRDBGrid1TitleClick(Column: TColumn);
    procedure aRegisterPaymentExecute(Sender: TObject);
    procedure tbPrintClick(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure aLoadFromExcelExecute(Sender: TObject);
    procedure CheckFilterClick(Sender: TObject);
    procedure CRDBGrid1CellClick(Column: TColumn);
  private
    FPrintCopysCount : Integer;
    FDefaultFilialId : Variant;
    procedure PrepareFilials;
    function GetFilialName(const pFilialId: Variant): String;
    procedure AddContractChange(const pDocumTypeId : Integer);
    procedure EditContractChange;
    procedure AddPayment;
    procedure OnGetPhoneText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  public
    FFilterForm : TJornalAllFilterForm;
    FEditContractForm : TEditContractForm;
    FCancelContractForm : TCancelContractForm;
    //FChangeContractForm : TChangeContractForm;
  end;

implementation

{$R *.dfm}

uses CommCtrl, ContractsRegistration_Utils,SelectContract_, SelectContract,  Main,
  ShowUserStat, LoadData;

procedure TJornalAllForm.aNewContractExecute(Sender: TObject);
begin
  if VarToStr(FFilterForm.FilialId) = '' then
  begin
    MessageDlg('Для добавления документа необходимо сначала выбрать филиал в фильтре', mtConfirmation, [mbOK], 0);
    tbCurrentFilial.CheckMenuDropdown;
    //if pmFilials.Items.Count > 0 then
    //  pmFilials.PopupPoint

  end
  else
  begin
    if not Assigned(FEditContractForm) then
      FEditContractForm := TEditContractForm.Create(Application);
    FEditContractForm.PrepareForm('INSERT', Null);
    FEditContractForm.qContracts.FieldByName('FILIAL_ID').Value := FFilterForm.FilialId;
    if (mrOk = FEditContractForm.ShowModal) then
    begin
      // Для К7
      if GetConstantValue('MANUAL_LINK_PAYMENTS_ENABLED') = '1' then
      begin
        // Покажем страницу платежей
        ShowUserStatByPhoneNumber(
          FEditContractForm.PhoneNumber,
          FEditContractForm.ContractID,
          'Payments'
          );

      end;
      //
      aRefresh.Execute;
      qMain.Locate('CONTRACT_ID', FEditContractForm.ContractId, []);
    end;
  end;
end;

procedure TJornalAllForm.EditContractChange;
var FChangeContractForm : TChangeContractForm;
    pRunMode : string;
begin
  //if not Assigned(FChangeContractForm) then
  FChangeContractForm := TChangeContractForm.Create(Application);
  try
    // ДЛЯ ПЛАТЕЖЕЙ СФОРМИРОВАННЫХ АВТОМАТИЧЕСКИ ЗАПРЕЩАЕТСЯ РЕДАКТИРОВАНИЕ (С РАСПРЕДЕЛЕНИЕМ ПЛАТЕЖА ПО ГРУППЕ)
    if VarIsNull(qMain.FieldByName('PARENT_PAYMENT_ID').Value) then
      pRunMode := 'EDIT'
    else
      pRunMode := 'DISABLE';

    FChangeContractForm.PrepareForm(pRunMode, qMain.FieldByName('DOCUM_ID').Value, Null, Null);
    if (mrOk = FChangeContractForm.ShowModal) then
    begin
      aRefresh.Execute;
      //qMain.Locate('DOCUM_ID', FChangeContractForm.FContractCancelId, []);
    end;

  finally
    FChangeContractForm.Free;
  end;
end;

procedure TJornalAllForm.aEditExecute(Sender: TObject);
var
  RegisterPaymentForm : TRegisterPaymentForm;
  pRunEdit : string;
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if VarIsNull(qMain.FieldByName('PARENT_PAYMENT_ID').Value) then
      pRunEdit := 'EDIT'
    else
      pRunEdit := 'READONLY';

    case qMain.FieldByName('DOCUM_TYPE_ID').AsInteger of
      TYPE_DOC_PAYMENT :
        begin
          RegisterPaymentForm := TRegisterPaymentForm.Create(nil);
          try
            // если не удачно, то там внутри должно быть сообщение об ошибке
            if RegisterPaymentForm.PrepareForm(pRunEdit,
              qMain.FieldByName('DOCUM_ID').Value,
              qMain.FieldByName('CONTRACT_ID').Value) then
            begin
              if (mrOk = RegisterPaymentForm.ShowModal) then
              begin
                aRefresh.Execute;
//                qMain.Locate('DOCUM_ID;DOCUM_TYPE_ID',
//                             VarArrayOf([RegisterPaymentForm.FReceivedPaymentId, TYPE_DOC_PAYMENT]), []);
              end;
            end;
          finally
            RegisterPaymentForm.Free;
          end;
        end;
      TYPE_DOC_CONTRACT :
        begin
          if not Assigned(FEditContractForm) then
            FEditContractForm := TEditContractForm.Create(Application);

          FEditContractForm.PrepareForm(pRunEdit, qMain.FieldByName('DOCUM_ID').Value);
          if (mrOk = FEditContractForm.ShowModal) then
          begin
            aRefresh.Execute;
            //qMain.Locate('CONTRACT_ID', FEditContractForm.FContractId, []);
          end;
        end;
      TYPE_DOC_CONTRACT_CANCEL :
        begin
          if not Assigned(FCancelContractForm) then
            FCancelContractForm := TCancelContractForm.Create(Application);

          FCancelContractForm.PrepareForm(pRunEdit, qMain.FieldByName('DOCUM_ID').Value, qMain.FieldByName('CONTRACT_ID').Value);
          if (mrOk = FCancelContractForm.ShowModal) then
          begin
            aRefresh.Execute;
            //qMain.Locate('DOCUM_ID', FCancelContractForm.FContractCancelId, []);
          end;
        end;
      TYPE_DOC_CHANGE_SIM       : EditContractChange;
      TYPE_DOC_CHANGE_PHONE_NUM : EditContractChange;
      TYPE_DOC_CHANGE_TARIFF    : EditContractChange;
    else
      MessageDlg('Тип документов не поддерживается.', mtInformation, [mbOK], 0);
    end;
  end;
end;

procedure TJornalAllForm.aRefreshExecute(Sender: TObject);
var vDocumType, vDocumId : Variant;
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    vDocumType := qMain.FieldByName('DOCUM_TYPE_ID').Value;
    vDocumId := qMain.FieldByName('DOCUM_ID').Value;
  end;

  qMain.Close;
  qMain.SQL.Text := qMainSQL.SQL.Text;
  if Assigned(FFilterForm) then
  begin
    if FFilterForm.DateBegin > 0 then
    begin
      qMain.SQL.Add('  AND DOCUM_DATE >= :DATE_BEGIN');
      qMain.ParamByName('DATE_BEGIN').AsDateTime := FFilterForm.DateBegin;
    end;
    if FFilterForm.DateEnd > 0 then
    begin
      qMain.SQL.Add('  AND DOCUM_DATE < TO_DATE(:DATE_END+1)');
      qMain.ParamByName('DATE_END').AsDateTime := FFilterForm.DateEnd;
    end;
    if FFilterForm.Confirmed = 1 then // только утвержденные
      qMain.SQL.Add('  AND C.CONFIRMED = 1')
    else if FFilterForm.Confirmed = 2 then // только не утвержденные
      qMain.SQL.Add('  AND NVL(C.CONFIRMED, 0) = 0');
    if VarToStr(FFilterForm.FilialId) <> '' then
    begin
      qMain.SQL.Add('  AND DC.FILIAL_ID = :FILIAL_ID');
      qMain.ParamByName('FILIAL_ID').Value := FFilterForm.FilialId;
    end;
    if VarToStr(FFilterForm.ContractNum) <> '' then
    begin
      qMain.SQL.Add('  AND CONTRACT_NUM = :CONTRACT_NUM');
      qMain.ParamByName('CONTRACT_NUM').Value := FFilterForm.ContractNum;
    end;
    if VarToStr(FFilterForm.PhoneNumFed) <> '' then
    begin
      qMain.SQL.Add('  AND INSTR(:PHONE_NUMBER_FEDERAL, C.PHONE_NUMBER_FEDERAL)>0');
      qMain.ParamByName('PHONE_NUMBER_FEDERAL').Value := FFilterForm.PhoneNumFed;
    end;
    if VarToStr(FFilterForm.PhoneNumCity) <> '' then
    begin
      qMain.SQL.Add('  AND DC.PHONE_NUMBER_CITY = :PHONE_NUMBER_CITY');
      qMain.ParamByName('PHONE_NUMBER_CITY').Value := FFilterForm.PhoneNumCity;
    end;
    if VarToStr(FFilterForm.AbonentId) <> '' then
    begin
      qMain.SQL.Add('  AND C.ABONENT_ID = :ABONENT_ID');
      qMain.ParamByName('ABONENT_ID').Value := FFilterForm.AbonentId;
    end;
    if FFilterForm.BDate > 0 then
    begin
      qMain.SQL.Add('  AND BDATE = :BDATE');
      qMain.ParamByName('BDATE').Value := FFilterForm.BDate;
    end;
    if VarToStr(FFilterForm.CityName) <> '' then
    begin
      qMain.SQL.Add('  AND CITY_NAME LIKE :CITY_NAME || ''%''');
      qMain.ParamByName('CITY_NAME').Value := FFilterForm.CityName;
    end;
    if VarToStr(FFilterForm.StreetName) <> '' then
    begin
      qMain.SQL.Add('  AND STREET_NAME LIKE :STREET_NAME || ''%''');
      qMain.ParamByName('STREET_NAME').Value := FFilterForm.StreetName;
    end;
    if VarToStr(FFilterForm.House) <> '' then
    begin
      qMain.SQL.Add('  AND HOUSE LIKE :HOUSE || ''%''');
      qMain.ParamByName('HOUSE').Value := FFilterForm.House;
    end;
    lFilterCaption.Caption := FFilterForm.FilterStr;
  end;

  qMain.Close;
  qMain.Open;
  if (VarToStr(vDocumType) <> '') or (VarToStr(vDocumId) <> '') then
  begin
    qMain.Locate('DOCUM_TYPE_ID;DOCUM_ID', VarArrayOf([vDocumType, vDocumId]), []);
  end;
end;

procedure TJornalAllForm.aDeleteExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    case qMain.FieldByName('DOCUM_TYPE_ID').AsInteger of
      TYPE_DOC_PAYMENT :
        begin
          if mrOk = MessageDlg(PChar('Удалить платёж '+qMain.FieldByName('CONTRACT_NUM').AsString+' ?'), mtConfirmation, [mbOK, mbCancel], 0) then
          begin
            if NOT VarIsNull(qMain.FieldByName('PARENT_PAYMENT_ID').Value) then
            begin
              MessageDlg(PChar('Данный платеж удалить нельзя! Этот платеж автоматически сформирован в результате распределения '+
                 'платежа по группе договоров. Удалить можно лишь основной платеж, вместе с ним удалятся все дочерние платежи!' )
                 , mtConfirmation, [mbOK], 0);
            end
            else
            begin
              // Проверяем является ли платеж распределенным
              if (qMain.FieldByName('IS_DISTRIBUTED').AsInteger = 1) then
              begin
                IF mrOk = MessageDlg(PChar('Данный платеж распределен по группе. При его удалении все дочерние платежи будут удалены!' +
                                          ' Удалить?'), mtConfirmation, [mbOK, mbNo], 0) then
                begin
                  qDeletePayment.ParamByName('RECEIVED_PAYMENT_ID').Value := qMain.FieldByName('DOCUM_ID').Value;
                  qDeletePayment.ExecSQL;
                  //
                  qMain.Prior;
                  aRefresh.Execute;
                end;
              end
              else
              begin
                qDeletePayment.ParamByName('RECEIVED_PAYMENT_ID').Value := qMain.FieldByName('DOCUM_ID').Value;
                qDeletePayment.ExecSQL;
                //
                qMain.Prior;
                aRefresh.Execute;
              //qMain.Delete;
              end;
            end;
          end;
        end;
      TYPE_DOC_CONTRACT :
        begin
          if mrOk = MessageDlg(PChar('Удалить договор № '+qMain.FieldByName('CONTRACT_NUM').AsString+' ?'), mtConfirmation, [mbOK, mbCancel], 0) then
          begin
            qDeleteContract.ParamByName('CONTRACT_ID').Value := qMain.FieldByName('DOCUM_ID').Value;
            qDeleteContract.ExecSQL;
            //
            qMain.Prior;
            aRefresh.Execute;
            //qMain.Delete;
          end;
        end;
      TYPE_DOC_CONTRACT_CANCEL :
        begin
          if mrOk = MessageDlg(PChar('Отменить расторжение договора № '+qMain.FieldByName('CONTRACT_NUM').AsString+' ?'), mtConfirmation, [mbOK, mbCancel], 0) then
          begin
            qDeleteContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value := qMain.FieldByName('DOCUM_ID').Value;
            qDeleteContractCancel.ExecSQL;
            //
            qMain.Prior;
            aRefresh.Execute;
            //qMain.Delete;
          end;
        end;
      TYPE_DOC_CHANGE_SIM,
      TYPE_DOC_CHANGE_TARIFF,
      TYPE_DOC_CHANGE_PHONE_NUM :
        begin
          if mrOk = MessageDlg(PChar('Удалить документ изменения договора № '+qMain.FieldByName('CONTRACT_NUM').AsString+' ?'), mtConfirmation, [mbOK, mbCancel], 0) then
          begin
            qDeleteContractChange.ParamByName('CONTRACT_CHANGE_ID').Value := qMain.FieldByName('DOCUM_ID').Value;
            qDeleteContractChange.ExecSQL;
            //
            qMain.Prior;
            aRefresh.Execute;
            //qMain.Delete;
          end;
        end;
    else
      MessageDlg('Тип документов не поддерживается.', mtInformation, [mbOK], 0);
    end;
  end;

end;

procedure TJornalAllForm.PrepareFilials;
var vMI : TMenuItem;
begin
  pmFilials.Items.Clear;
  FDefaultFilialId := Null;

  qFilials.Close;
  qFilials.Open;
  if qFilials.RecordCount > 0 then
  begin
    vMI := TMenuItem.Create(pmFilials);
    vMI.OnClick := SelectFilialExecute;
    vMI.Caption := 'Все филиалы';
    vMI.Tag := -1;
    pmFilials.Items.Add(vMI);
  end;

  while not qFilials.Eof do
  begin
    vMI := TMenuItem.Create(pmFilials);
    vMI.OnClick := SelectFilialExecute;
    vMI.Caption := qFilials.FieldByName('FILIAL_NAME').AsString;
    vMI.Tag := qFilials.FieldByName('FILIAL_ID').AsInteger;
    pmFilials.Items.Add(vMI);

    if qFilials.FieldByName('IS_DEFAULT_FILIAL_ID').AsInteger > 0 then
      FDefaultFilialId := qFilials.FieldByName('FILIAL_ID').AsInteger;

    qFilials.Next;
  end;
end;

function TJornalAllForm.GetFilialName(const pFilialId : Variant) : String;
begin
  if not qFilials.Active then
    qFilials.Open;
  qFilials.First;
  if qFilials.Locate('FILIAL_ID', pFilialId, []) then
    Result := qFilials.FieldByName('FILIAL_NAME').AsString
  else
    Result := 'Все филиалы';
end;

procedure TJornalAllForm.FormShow(Sender: TObject);
var i:integer;
begin
  //Если Филиал, то только по филиалу
  if MainForm.FUseFilialBlockAccess then
  begin
    qMainSQL.SQL.Append('and DC.FILIAL_ID=' + IntToStr(MainForm.FFilial));
    qFilials.SQL.Insert(10, 'WHERE F.FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
  if (MainForm.UserRightsType=2) or (MainForm.UserRightsType=3) then begin
    ToolButton6.Enabled:=false;
  end;

  //Если нет показа, то сносим столбец "Акт."
  if not(GetConstantValue('SHOW_CONTRACT_SEND_ACTIV')='1') then
    for i:=0 to CRDBGrid1.Columns.Count - 1 do
      if CRDBGrid1.Columns[i].FieldName='SEND_ACTIV' then
        CRDBGrid1.Columns[i].Visible:=false;
  if GetConstantValue('USE_TYPE_PAYMENTS') <> '1' then
    for i:=0 to CRDBGrid1.Columns.Count - 1 do
      if (CRDBGrid1.Columns[i].FieldName='TYPE_NAME')
          or (CRDBGrid1.Columns[i].FieldName='REVERSESCHET') then
        CRDBGrid1.Columns[i].Visible:=false;
  if GetConstantValue('SERVER_NAME')<>'GSM_CORP' then
    for i:=0 to CRDBGrid1.Columns.Count - 1 do
      if CRDBGrid1.Columns[i].FieldName='ABONENT_TARIFF_OPTION' then
        CRDBGrid1.Columns[i].Visible:=false;
  // заполняем меню со списком филиалов и определяем филиал по умолчанию (FDefaultFilialId)
  // и значение фильтра FFilterForm.FilialId
  PrepareFilials;

  if not Assigned(FFilterForm) then
  begin
    FFilterForm := TJornalAllFilterForm.Create(Application);

    FFilterForm.qFilials.Close;
    FFilterForm.qFilials.Open;
    FFilterForm.PrepareCombobox(FFilterForm.cbCity, FFilterForm.qCityNames);
    FFilterForm.PrepareCombobox(FFilterForm.cbStreet, FFilterForm.qStreetNames);
    FFilterForm.PrepareCombobox2(FFilterForm.cbFilials, FFilterForm.qFilials, 'Все филиалы');

    FFilterForm.DateBegin := Date(); // - 100;
    FFilterForm.DateEnd := Date();
    FFilterForm.FilialId := FDefaultFilialId;
    tbCurrentFilial.Caption := GetFilialName(FDefaultFilialId);
    FFilterForm.ContractNum := Null;
    FFilterForm.AbonentId := Null;
    FFilterForm.BDate := 0;
    FFilterForm.CityName := Null;
    FFilterForm.StreetName := Null;
    FFilterForm.House := '';
    // 0 - все, 1 - только утвержденные, 2 - только не утвержденные
    FFilterForm.Confirmed := 0;
    FFilterForm.PhoneNumFed := Null;
    FFilterForm.PhoneNumCity := Null;
  end;

  try
    aRefresh.Execute;
  except
    on E: exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      Close;
    end;
  end;
end;

procedure TJornalAllForm.DataSource1DataChange(Sender: TObject;
  Field: TField);
var
  vEnabled : boolean;
  IsContract : Boolean;
begin
  vEnabled := qMain.Active and (qMain.RecordCount > 0);

  aNewContract.Enabled := qMain.Active;
  aEdit.Enabled := vEnabled;
  aDelete.Enabled := vEnabled;
  aExcel.Enabled := vEnabled;

  aFilter.Enabled := True;
  aRefresh.Enabled := True;
  aCancelContract.Enabled := True;
  aChangeNumber.Enabled := True;

  IsContract := (TYPE_DOC_CONTRACT = qMain.FieldByName('DOCUM_TYPE_ID').AsInteger);
  aPrint.Enabled := IsContract;
  aPrintContract2.Enabled := IsContract;
  aPrintContractExcel.Enabled := IsContract;
end;

procedure TJornalAllForm.CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if aEdit.Enabled then
      aEdit.Execute;
  end;
end;

procedure TJornalAllForm.CheckFilterClick(Sender: TObject);
begin
  if CheckFilter.Checked then
    CRDBGrid1.OptionsEx:=CRDBGrid1.OptionsEx+[dgeFilterBar]
  else
    CRDBGrid1.OptionsEx:=CRDBGrid1.OptionsEx-[dgeFilterBar];
end;

procedure TJornalAllForm.CRDBGrid1CellClick(Column: TColumn);
//var ContractNum: integer;
begin
  if (GetConstantValue('SHOW_CONTRACT_SEND_ACTIV')='1')
    and (Column.Title.Caption='Акт.') then
    if mrOk = MessageDlg('Сменить статус?', mtConfirmation, [mbOK, mbCancel], 0) then
    begin
      spChangeSendActiv.ParamByName('PCONTRACT_NUM').Value:=CRDBGrid1.Columns[1].Field.Value;
      spChangeSendActiv.ExecProc;
      aRefresh.Execute;
    end;
end;

procedure TJornalAllForm.CRDBGrid1DblClick(Sender: TObject);
begin
  if aEdit.Enabled then
    aEdit.Execute;
end;

procedure TJornalAllForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TJornalAllForm.aFilterExecute(Sender: TObject);
var
  vDateBegin : TDateTime;
  vDateEnd : TDateTime;
  vFilialId : Variant;
  vContractNum : Variant;
  vAbonentId : Variant;
  vBDate : TDateTime;
  vCityName : Variant;
  vStreetName : Variant;
  vHouse : Variant;
  vConfirmed : Integer;
  vPhoneNumFed : Variant;
  vPhoneNumCity : Variant;
begin
  vDateBegin := FFilterForm.DateBegin;
  vDateEnd := FFilterForm.DateEnd;
  vFilialId := FFilterForm.FilialId;
  vContractNum := FFilterForm.ContractNum;
  vAbonentId := FFilterForm.AbonentId;
  vBDate := FFilterForm.BDate;
  vCityName := FFilterForm.CityName;
  vStreetName := FFilterForm.StreetName;
  vHouse := FFilterForm.House;
  vConfirmed := FFilterForm.Confirmed;
  vPhoneNumFed := FFilterForm.PhoneNumFed;
  vPhoneNumCity := FFilterForm.PhoneNumCity;

  if (mrOk = FFilterForm.ShowModal()) then
  begin
    aRefresh.Execute();
    tbCurrentFilial.Caption := GetFilialName(FFilterForm.FilialId);
  end
  else
  begin
    FFilterForm.DateBegin := vDateBegin;
    FFilterForm.DateEnd := vDateEnd;
    FFilterForm.FilialId := vFilialId;
    FFilterForm.ContractNum := vContractNum;
    FFilterForm.AbonentId := vAbonentId;
    FFilterForm.BDate := vBDate;
    FFilterForm.CityName := vCityName;
    FFilterForm.StreetName := vStreetName;
    FFilterForm.House := vHouse;
    FFilterForm.Confirmed := vConfirmed;
    FFilterForm.PhoneNumFed := vPhoneNumFed;
    FFilterForm.PhoneNumCity := vPhoneNumCity;
  end;
end;



function CreateExcelApplication : ExcelApplication;
const
  ExcelApplicationString = 'Excel.Application';
begin
  try
    try
//      ExcelApplication := IDispatch(GetActiveOleObject('Excel.Application')) As Excel97.ExcelApplication;
      Result := CreateOleObject(ExcelApplicationString) as Excel2000._Application;
    except
      Result := CreateOleObject(ExcelApplicationString) as Excel2000._Application;
//      Result := CoExcelApplication.Create;
    end;
//    ExcelLanguageID := Result.LanguageSettings.LanguageID[msoLanguageIDUI];
  except
    on E : Exception do
    begin
//      ShowMessage('Error!');
      Raise Exception.Create('Ошибка создания книги Ms Excel. '+E.Message);
    end;
  end;
end;


procedure TJornalAllForm.aExcelExecute(Sender: TObject);
var
  //pTemplatePath : String;
//  xlReportJornal: TxlReport;
  //ds : TxlDataSource;
  //dEx: TDatasource;
  //dEx1: TxlDataSource;
{  TemplateFileName,TemplateFileNameX : String;
  ExcelApp : ExcelApplication;
  Workbook : Excel2000._Workbook;
  Sheet : Excel2000._Worksheet;
  FormulasRange : Variant;
  Formulas : IEnumVariant;
  Fetched : Cardinal;
  FormulaCell : OleVariant;
  FormulaValue : String;
  FieldName : String;
  I,j,K : integer;
  RecordId: Pointer;}
  FieldNameStr : Array of String;
 //ver:string;
//  LCID: integer;
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
//  for I := 1 to 42 do begin
    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CONTRACT_NUM';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='№ контракта';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='DOCUM_TYPE_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Тип документа';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='DOCUM_DATE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Дата документа';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='SURNAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Фамилия';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Имя';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PATRONYMIC';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Отчество';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='BDATE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Д.Р.';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='FILIAL_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Филиал';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='OPERATOR_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Оператор';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='IS_VIP_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='VIP';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='ABONENT_TARIFF_OPTION';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Аб.тар.опции';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='TARIFF_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Тариф';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PHONE_NUMBER_FEDERAL';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='№ телефона федеральн';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PHONE_NUMBER_CITY';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='№ телефона городской';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='SUM_GET';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Внесенная сумма';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='USER_CREATED';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Зарегистрировал';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='USER_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Обновил';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='SIM_NUMBER';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='SIM карта';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='DISCONNECT_LIMIT';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Лимит отключения';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PHONE_NUMBER_TYPE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Тип тел номера';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='TARIFF_CODE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Код тарифа';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='IS_ACTIVE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Тариф действующий';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CONNECT_PRICE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Стоимость подключения';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='ADVANCE_PAYMENT';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Авансовый платеж';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='DAYLY_PAYMENT';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Абонентская плата';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='DAYLY_PAYMENT_LOCKED';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Абонентская плата по тарифу (заблок)';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PASSPORT_SER';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Серия паспорта';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PASSPORT_NUM';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Номер паспорта';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PASSPORT_DATE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Когда выдан паспорт';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='PASSPORT_GET';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Кем выдан паспорт';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='COUNTRY_CITIZEN';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Гражданство';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='COUNTRY_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Страна прописки';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='REGION_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Регион прописки';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CITY_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Город прописки';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='STREET_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Улица прописки';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='HOUSE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Дом прописки';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='KORPUS';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Корпус';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='APARTMENT';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Квартира';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CONTACT_INFO';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Контактная информация';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CODE_WORD';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Кодовое слово';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='EMAIL';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='E-mail';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='START_BALANCE';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='стартовый баланс';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='GOLD_NUMBER_SUM';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Стоим золотого номера';

    setlength(FieldNameStr,length(FieldNameStr)+1);
    FieldNameStr[length(FieldNameStr)-1] :='CONTRACT_CANCEL_TYPE_NAME';
    qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Причина расторжения договора';

    if (GetConstantValue('USE_TYPE_PAYMENTS')='1') then begin
     setlength(FieldNameStr,length(FieldNameStr)+1);
     FieldNameStr[length(FieldNameStr)-1] :='TYPE_NAME';
     qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Вид платежа';

     setlength(FieldNameStr,length(FieldNameStr)+1);
     FieldNameStr[length(FieldNameStr)-1] :='REVERSESCHET';
     qMain.FieldByName(FieldNameStr[length(FieldNameStr)-1]).DisplayLabel:='Компенсировать после счёта';
    end;


//  end;
  ExportOraQuery('Журнал регистрации документов','', 'JornalAll', qMain,
  FieldNameStr,True,True);
    {
    xlReportJornal := TxlReport.Create(nil);

    xlReportJornal.DataExportMode := xdmVariant; // xdmDDE;
    xlReportJornal.Options := [xroDisplayAlerts, xroAutoOpen];
    xlReportJornal.XLSTemplate := 'D:\Work\Lontana\Projects\JornalAll.xls';
    ds := TxlDataSource.Create(xlReportJornal.DataSources);
    ds.DataSet := qMain;
    ds.Alias := 'qMain';
    ds.Range := 'RangeData';
    ds.Options := [xrgoAutoOpen, xrgoPreserveRowHeight];
    xlReportJornal.Preview := false;
    xlReportJornal.Params.Add.Name := 'Filter';
    pTemplatePath :=    ExtractFilePath(Application.ExeName) + 'JornalAll.xls';
    xlReportJornal.ParamByName['Filter'].AsString := lFilterCaption.Caption;
    xlReportJornal.XLSTemplate := pTemplatePath;
    }

   { setlength(FieldNameStr,50);
    TemplateFileName := ExtractFilePath(Application.ExeName) + 'JornalAll.xls';
    TemplateFileNameX := ExtractFilePath(Application.ExeName) + 'JornalAll.xltx';
    try
      ExcelApp := IDispatch(GetActiveOleObject('Excel.Application')) As Excel2000.ExcelApplication;
    except
      ExcelApp := CoExcelApplication.Create;
    end;
    LCID:=GetUserDefaultLCID;
    ver:=ExcelApp.Version[LCID];
//    ExcelApp.SheetsInNewWorkbook[0] := 1;
      if (ver='12.0') or (ver='14.0') then
        Workbook := ExcelApp.Workbooks.Add(TemplateFileNameX,0)
      else  Workbook := ExcelApp.Workbooks.Add(TemplateFileName,0);

   // ExcelApp := CreateExcelApplication;
//    Workbook := ExcelApp.Workbooks.Add(TemplateFileName, 0);
    Sheet := Workbook.Sheets.Item[1] As Excel2000._WorkSheet;
    FormulasRange := Sheet.UsedRange[0].SpecialCells(xlCellTypeFormulas, EmptyParam);
    Formulas := IUnknown(FormulasRange._NewEnum) As IEnumVariant;
    j:=0;
    while S_OK = Formulas.Next(1, FormulaCell, Fetched) do
    begin
      if Fetched = 0 then
        Break;
      FormulaValue := VarToStr(FormulaCell.Formula);
      if Copy(FormulaValue, 1, 7) = '=qMain_' then
      begin
        FieldNameStr[j] := Copy(FormulaValue, 8, MAXINT);
        j:=j+1;
       end;
        VarClear(FormulaCell);
      end;
      sheet.Cells.Item[3,3].clear;
      k:=0;
      I:=6;
      qMain.First;
        while Not (qMain.Eof) do
        begin
          I:=I+1;
          sheet.Cells.Item[i,k+1].Borders.LineStyle := xlContinuous;
          sheet.Cells.Item[i,k+2].Borders.LineStyle := xlContinuous;
          sheet.Cells.Item[i,k+2]:=IntToStr(I-6);
          while k<j do
          begin

          try
            sheet.Cells.Item[i,k+3] :=qMain.FieldByName(FieldNameStr[k]).AsString;
            sheet.Cells.Item[i,k+3].Borders.LineStyle := xlContinuous;
          except
               sheet.Cells.Item[i,k+3]:=#39+qMain.FieldByName(FieldNameStr[k]).AsString;
               sheet.Cells.Item[i,k+3].Borders.LineStyle := xlContinuous;
          end;

            k:=k+1;
          end;
          qMain.Next;
          k:=0;
        end;
      end;
 ExcelApp.Visible[0] := True;
 Workbook.Activate(0);           }
  end;
end;

procedure TJornalAllForm.aPrintExecute(Sender: TObject);
var TemplateFileName : String;
  ExcelApp : ExcelApplication;
  Workbook : Excel2000._Workbook;
  Sheet : Excel2000._Worksheet;
  FormulasRange : Variant;
  Formulas : IEnumVariant;
  Fetched : Cardinal;
  FormulaCell : OleVariant;
  FormulaValue : String;
  FieldName : String;
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    TemplateFileName := ExtractFilePath(Application.ExeName) + '\Contract.xls';
    if not FileExists(TemplateFileName) then
      Raise Exception.Create('Файл шаблона "'+TemplateFileName+'" не установлен');
    if (Sender is TComponent) then
    begin
      if (Sender as TComponent).Tag = 0 then
        FPrintCopysCount := 1 // просто печать
      else if (Sender as TComponent).Tag = 1 then
        FPrintCopysCount := 2 // печать 2 экз
      else
        FPrintCopysCount := 0;
    end
    else
      FPrintCopysCount := 0;

    qPrintContract.Close;
    qPrintContract.ParamByName('CONTRACT_ID').AsInteger := qMain.FieldByName('CONTRACT_ID').AsInteger;
    qPrintContract.Open;

    ExcelApp := CreateExcelApplication;
    Workbook := ExcelApp.Workbooks.Add(TemplateFileName, 0);
    Sheet := Workbook.Sheets.Item[1] As Excel2000._WorkSheet;
    FormulasRange := Sheet.UsedRange[0].SpecialCells(xlCellTypeFormulas, EmptyParam);
    Formulas := IUnknown(FormulasRange._NewEnum) As IEnumVariant;
    while S_OK = Formulas.Next(1, FormulaCell, Fetched) do
    begin
      if Fetched = 0 then
        Break;
//      FormulaCell := FormulaCellDisp;
      FormulaValue := VarToStr(FormulaCell.Formula);
      if Copy(FormulaValue, 1, 7) = '=qData_' then
      begin
        FieldName := Copy(FormulaValue, 8, MAXINT);
        FormulaCell.Formula := qPrintContract.FieldValues[FieldName];
      end;
      VarClear(FormulaCell);
    end;
    qPrintContract.Close;

    if FPrintCopysCount > 0 then
    begin
      while FPrintCopysCount > 0 do
      begin
        Variant(Workbook).PrintOut;
        Dec(FPrintCopysCount);
      end;
      Workbook.Close(False, EmptyParam, EmptyParam, 0);
      ExcelApp.Quit;
    end
    else
    begin
      // покажем форму
      ExcelApp.Visible[0] := True;
      Workbook.Activate(0);
    end;

{    if FPrintCopysCount > 0 then
      xlReportContract.Options := xlReportContract.Options + [xroHideExcel]
    else
      xlReportContract.Options := xlReportContract.Options - [xroHideExcel];

    //xlReportContract.ParamByName['Filter'].AsString := lFilterCaption.Caption;
    xlReportContract.XLSTemplate := TemplateFileName;
    xlReportContract.Report;}
  end;
end;

procedure TJornalAllForm.SelectFilialExecute(Sender: TObject);
begin
  if (Sender is tMenuItem) then
  begin
    if (Sender as tMenuItem).Tag = -1 then
    begin
      FFilterForm.FilialId := Null;
      tbCurrentFilial.Caption := 'Все филиалы';
    end
    else
    begin
      FFilterForm.FilialId := (Sender as tMenuItem).Tag;
      tbCurrentFilial.Caption := (Sender as tMenuItem).Caption;
    end;
  end;
  aRefresh.Execute();
end;

procedure TJornalAllForm.tbCurrentFilialClick(Sender: TObject);
begin
  tbCurrentFilial.CheckMenuDropdown;
end;

procedure TJornalAllForm.aCancelContractExecute(Sender: TObject);
var //vContractId : Variant;
    vContractCancelId : Variant;
    vEditType : String;
     vContractId : Integer; //Variant;
    vPhoneNumber : String;
begin
{
  if qMain.Active and (qMain.FieldByName('DOCUM_TYPE_ID').AsInteger = TYPE_DOC_CONTRACT) then
  begin
    if (qMain.FieldByName('CONTRACT_CANCEL_ID').AsString <> '') then
    begin
      MessageDlg('Выбранный договор № '+qMain.FieldByName('CONTRACT_NUM').AsString+' уже расторгнут.', mtWarning, [mbOK], 0);
      vEditType := 'EDIT';
    end
    else
      vEditType := 'INSERT';
    vContractId := qMain.FieldByName('DOCUM_ID').Value;
    vContractCancelId := qMain.FieldByName('CONTRACT_CANCEL_ID').Value;
  end
  else
}
  begin
    // выбираем только не закрытые договоры
    //vContractId := SelectContractId();
    SelectPhoneNumber_(vPhoneNumber, vContractID, MainForm.FUseFilialBlockAccess, MainForm.OraSession, MainForm.FFilial);
    vContractCancelId := Null;
    vEditType := 'INSERT';
  end;

  if (vContractId <> 0) then
  begin
    if not Assigned(FCancelContractForm) then
      FCancelContractForm := TCancelContractForm.Create(Application);
    // если не удачно, то там внутри должно быть сообщение об ошибке
    if FCancelContractForm.PrepareForm(vEditType, vContractCancelId, vContractId) then
    begin
      if vEditType = 'INSERT' then
        FCancelContractForm.qContractCancel.FieldByName('FILIAL_ID').Value := FFilterForm.FilialId;
      //FCancelContractForm.Caption := 'Расторжение договора № ' +
      if (mrOk = FCancelContractForm.ShowModal) then
      begin
        aRefresh.Execute;
        qMain.Locate('DOCUM_ID;DOCUM_TYPE_ID',
                     VarArrayOf([FCancelContractForm.FContractCancelId, TYPE_DOC_CONTRACT_CANCEL]), []);
      end;
    end;
  end;
end;

procedure TJornalAllForm.pFilterDblClick(Sender: TObject);
begin
  if aFilter.Enabled then
    aFilter.Execute();
end;

procedure TJornalAllForm.tbAddFunctionsClick(Sender: TObject);
begin
  tbAddFunctions.CheckMenuDropdown;
end;

procedure TJornalAllForm.AddContractChange(const pDocumTypeId : Integer);
var
  vContractId : Integer; //Variant;
  vPhoneNumber : String;
    FChangeContractForm : TChangeContractForm;
begin
  // выбираем только не закрытые договоры
   SelectPhoneNumber_(vPhoneNumber, vContractID, MainForm.FUseFilialBlockAccess, MainForm.OraSession, MainForm.FFilial);
//  vContractId := SelectContractId();

  if  (vContractId <> 0) then
  begin
    FChangeContractForm := TChangeContractForm.Create(Application);
    try
      // если не удачно, то там внутри должно быть сообщение об ошибке
      if FChangeContractForm.PrepareForm('INSERT', Null, vContractId, pDocumTypeId) then
      begin
        FChangeContractForm.qContractChange.FieldByName('FILIAL_ID').Value := FFilterForm.FilialId;
        if (mrOk = FChangeContractForm.ShowModal) then
        begin
          aRefresh.Execute;
          qMain.Locate('DOCUM_ID;DOCUM_TYPE_ID',
                       VarArrayOf([FChangeContractForm.FContractChangeId, pDocumTypeId]), []);
        end;
      end;
    finally
      FChangeContractForm.Free;
    end;
  end;
end;

procedure TJornalAllForm.AddPayment;
var vContractId : Integer; //Variant;
  vPhoneNumber : String;
    RegisterPaymentForm : TRegisterPaymentForm;
begin
  // выбираем только не закрытые договоры
  //vContractId := SelectContractId();
   SelectPhoneNumber_(vPhoneNumber, vContractID, MainForm.FUseFilialBlockAccess, MainForm.OraSession, MainForm.FFilial);
  if (vContractId <> 0) then
  begin
    RegisterPaymentForm := TRegisterPaymentForm.Create(nil);
    try
      // если не удачно, то там внутри должно быть сообщение об ошибке
      if RegisterPaymentForm.PrepareForm('INSERT', Null, vContractId) then
      begin
        RegisterPaymentForm.qReceivedPayments.FieldByName('FILIAL_ID').Value := FFilterForm.FilialId;
        if (mrOk = RegisterPaymentForm.ShowModal) then
        begin
          aRefresh.Execute;
          qMain.Locate('DOCUM_ID;DOCUM_TYPE_ID',
                       VarArrayOf([RegisterPaymentForm.FReceivedPaymentId, TYPE_DOC_PAYMENT]), []);
        end;
      end;
    finally
      RegisterPaymentForm.Free;
    end;
  end;
end;

procedure TJornalAllForm.aChangeNumberExecute(Sender: TObject);
begin
  AddContractChange(TYPE_DOC_CHANGE_PHONE_NUM);
end;

procedure TJornalAllForm.aChangeSIMExecute(Sender: TObject);
begin
  AddContractChange(TYPE_DOC_CHANGE_SIM);
end;

procedure TJornalAllForm.aChangeTariffExecute(Sender: TObject);
begin
  AddContractChange(TYPE_DOC_CHANGE_TARIFF);
end;

procedure TJornalAllForm.CRDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  vImageIndex : Integer;
  g : TCRDBGrid;
begin
  g := Sender as TCRDBGrid;
  if not qMain.FieldByName('CONTRACT_CANCEL_DATE').IsNull then
    g.Canvas.Font.Color := clGray;

  if Column.FieldName <> 'DOCUM_TYPE_NAME' then
    g.DefaultDrawColumnCell(Rect, DataCol, Column, State{, Column.FieldName = 'DOCUM_TYPE_NAME'})
  else
  begin
    // Рисуем иконку типа документа
    if qMain.FieldByName('DOCUM_TYPE_ID').IsNull then
      vImageIndex := -1
    else case qMain.FieldByName('DOCUM_TYPE_ID').AsInteger of
      TYPE_DOC_PAYMENT          : vImageIndex := 5;
      TYPE_DOC_CONTRACT         : vImageIndex := 4;
      TYPE_DOC_CONTRACT_CANCEL  : vImageIndex := 2;
      TYPE_DOC_CHANGE_SIM       : vImageIndex := 3;
      TYPE_DOC_CHANGE_PHONE_NUM : vImageIndex := 3;
      TYPE_DOC_CHANGE_TARIFF    : vImageIndex := 3;
    else
      vImageIndex := -1;
    end;

    g.Canvas.FillRect(Rect);
    if vImageIndex >= 0 then
      MainForm.ImageList16.Draw(g.Canvas,
                              (Rect.Left+Rect.Right - MainForm.ImageList16.Width) div 2, Rect.Top,
                              vImageIndex);
  end;
end;

procedure TJornalAllForm.CRDBGrid1TitleClick(Column: TColumn);
begin
  qMain.IndexFieldNames := qMain.IndexFieldNames + ';DOCUM_DATE;DOCUM_TYPE_ID;CONTRACT_NUM';
end;

procedure TJornalAllForm.aRegisterPaymentExecute(Sender: TObject);
var
 users:TStringList;
begin
//  MainForm.CheckAdminPrivileges;
 Try
  users:=TStringList.Create;
  users.Delimiter:=';';
  users.DelimitedText:=GetParamValue('USERS_ADD_PAYMENT');
  if (users.IndexOf(UpperCase(mainform.orasession.Username)) <> -1) or (GetConstantValue('SERVER_NAME') <> 'GSM_CORP') then
    AddPayment
  else
    MessageDlg('Отсутствуют права на добавление платежей!',mtError, [mbOK], 0);
 Finally
   users.Free;
 End;
end;

procedure TJornalAllForm.tbPrintClick(Sender: TObject);
begin
  tbPrint.CheckMenuDropdown;
end;

procedure TJornalAllForm.aShowUserStatInfoExecute(Sender: TObject);
var
  vPhoneNumber : String;
  vContractID : Integer;

begin
  //SelectPhoneNumber (vPhoneNumber, vContractID) ;
  SelectPhoneNumber_(vPhoneNumber, vContractID, MainForm.FUseFilialBlockAccess, MainForm.OraSession, MainForm.FFilial);
  if vPhoneNumber <> '' then
    ShowUserStatByPhoneNumber(vPhoneNumber,vContractID);
end;

procedure TJornalAllForm.OnGetPhoneText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatPhoneNumber(Sender.AsString);
end;

procedure TJornalAllForm.qMainAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('PHONE_NUMBER_FEDERAL').OnGetText := OnGetPhoneText;
end;

procedure TJornalAllForm.aLoadFromExcelExecute(Sender: TObject);
begin
  LoadDataFromExcelFile;
end;

end.
