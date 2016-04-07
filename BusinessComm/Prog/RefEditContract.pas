unit RefEditContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.StdCtrls, Vcl.Buttons,
  ExportGridToExcelPDF,
  uDM, Func_Const, TimedMsgBox,
  sBitBtn, Vcl.ExtCtrls, sPanel, Data.DB, DBAccess, Ora, MemDS, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, sLabel, Vcl.Mask, sSpeedButton, DBCtrlsEh;

type
  TRefEditContractForm = class(TChildForm)
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    qContracts: TOraQuery;
    dsqContracts: TOraDataSource;
    qContractsCONTRACT_ID: TFloatField;
    qContractsCONTRACT_NUM: TFloatField;
    qContractsCONTRACT_DATE: TDateTimeField;
    qContractsVIRTUAL_ACCOUNTS_ID: TFloatField;
    qContractsPHONE_ON_ACCOUNTS_ID: TFloatField;
    qContractsFILIAL_ID: TFloatField;
    qContractsTARIFF_ID: TFloatField;
    qContractsABONENT_ID: TFloatField;
    qContractsSIM_NUMBER: TStringField;
    qContractsCONTRACT_DISCOUNT: TFloatField;
    qContractsOPERATOR_PHONE_STATUSE_ID: TFloatField;
    qContractsLOCAL_PHONE_STATUSE_ID: TFloatField;
    qContractsSALE_COST: TFloatField;
    qContractsSALE_DATE: TDateTimeField;
    qContractsOPERATOR_ACCOUNT_NAME_ID: TFloatField;
    qContractsPROJECT_ID: TFloatField;
    qContractsSUB_ACCOUNT_ID: TFloatField;
    qContractsAGENT_DATE_DISPATCH: TDateTimeField;
    qContractsAGENT_ID: TFloatField;
    pHeader: TPanel;
    sbFilial: TsSpeedButton;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel6: TsLabel;
    cbFILIAL: TDBLookupComboBox;
    eContract_num: TDBEdit;
    gbContract: TGroupBox;
    sLabel12: TsLabel;
    sbAbonent: TsSpeedButton;
    sLabel7: TsLabel;
    sLabel9: TsLabel;
    sbLOCAL_PHONE_STATUS: TsSpeedButton;
    sLabel11: TsLabel;
    sbProject: TsSpeedButton;
    sLabel15: TsLabel;
    sbVIRTUAL_ACCOUNTS: TsSpeedButton;
    sLabel3: TsLabel;
    sLabel13: TsLabel;
    eSALE_COST: TDBEdit;
    cbABONENT: TDBLookupComboBox;
    eCONTRACT_DISCOUNT: TDBEdit;
    cbLOCAL_PHONE_STATUS: TDBLookupComboBox;
    cbPROJECT: TDBLookupComboBox;
    cbVIRTUAL_ACCOUNTS: TDBLookupComboBox;
    grpOperators: TGroupBox;
    sbOPERATOR_ACCOUNT_NAME: TsSpeedButton;
    sLabel14: TsLabel;
    sbSUB_ACCOUNT: TsSpeedButton;
    sLabel16: TsLabel;
    sbSatusOper: TsSpeedButton;
    sLabel10: TsLabel;
    sLabel8: TsLabel;
    sLabel5: TsLabel;
    sbPhone: TsSpeedButton;
    sLabel4: TsLabel;
    cbOPERATOR_ACCOUNT_NAME: TDBLookupComboBox;
    cbSUB_ACCOUNT: TDBLookupComboBox;
    cbOPERATOR_PHONE_STATUSE: TDBLookupComboBox;
    eSIM_NUMBER: TDBEdit;
    cbTARIFF: TDBLookupComboBox;
    cbPhone: TDBLookupComboBox;
    gbAgent: TGroupBox;
    sbAGENT: TsSpeedButton;
    sLabel18: TsLabel;
    sLabel17: TsLabel;
    cbAGENT: TDBLookupComboBox;
    qAbonents: TOraQuery;
    qAbonentsABONENT_ID: TFloatField;
    qAbonentsFIO: TStringField;
    dsqAbonents: TOraDataSource;
    qLocal_Phone_Statuses: TOraQuery;
    qLocal_Phone_StatusesLOCAL_PHONE_STATUSE_ID: TFloatField;
    qLocal_Phone_StatusesSTATUS_NAME: TStringField;
    dsqLocal_Phone_Statuses: TOraDataSource;
    qProjects: TOraQuery;
    qProjectsPROJECT_ID: TFloatField;
    qProjectsPROJECT_NAME: TStringField;
    dsqProjects: TOraDataSource;
    dsvirtual_operator: TOraDataSource;
    qVirtual_Operator: TOraQuery;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_ID: TFloatField;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_NAME: TStringField;
    qOperator_Account_Names: TOraQuery;
    qOperator_Account_NamesOPERATOR_ACCOUNT_NAME_ID: TFloatField;
    qOperator_Account_NamesACCOUNT_NAME: TStringField;
    dsqOperator_Account_Names: TOraDataSource;
    qTariffs: TOraQuery;
    qTariffsTARIFF_ID: TFloatField;
    qTariffsTARIFF_NAME: TStringField;
    dsqTariffs: TOraDataSource;
    qOperatorSubAccounts: TOraQuery;
    qOperatorSubAccountsSUB_ACCOUNT_ID: TFloatField;
    qOperatorSubAccountsSUB_ACCOUNT_NUMBER: TStringField;
    dsqOperatorSubAccounts: TOraDataSource;
    qPhonesForAccount: TOraQuery;
    qPhonesForAccountPHONE_ON_ACCOUNTS_ID: TFloatField;
    qPhonesForAccountPHONE_NUMBER: TStringField;
    dsqPhonesForAccount: TOraDataSource;
    qOperator_Phone_Statuses: TOraQuery;
    qOperator_Phone_StatusesOPERATOR_PHONE_STATUSE_ID: TFloatField;
    qOperator_Phone_StatusesSTATUS_NAME: TStringField;
    dsqOperator_Phone_Statuses: TOraDataSource;
    qFilials: TOraQuery;
    qFilialsFILIAL_ID: TFloatField;
    qFilialsFILIAL_NAME: TStringField;
    dsqFilials: TOraDataSource;
    dsqAgent: TOraDataSource;
    qAgent: TOraQuery;
    qAgentAGENT_ID: TFloatField;
    qAgentAGENT_NAME: TStringField;
    dteContract_date: TDBDateTimeEditEh;
    dteSALE_DATE: TDBDateTimeEditEh;
    dteAGENT_DATE_DISPATCH: TDBDateTimeEditEh;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetCONTRACT_ID(aValue: Integer);
    procedure FormCreate(Sender: TObject);
    procedure sBsaveClick(Sender: TObject);
    procedure qContractsBeforePost(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure qContractsPHONE_ON_ACCOUNTS_IDChange(Sender: TField);
    procedure sbPhoneClick(Sender: TObject);
    procedure sbAbonentClick(Sender: TObject);
    procedure sbFilialClick(Sender: TObject);
    procedure sbSatusOperClick(Sender: TObject);
    procedure sbOPERATOR_ACCOUNT_NAMEClick(Sender: TObject);
    procedure sbSUB_ACCOUNTClick(Sender: TObject);
    procedure sbVIRTUAL_ACCOUNTSClick(Sender: TObject);
    procedure sbProjectClick(Sender: TObject);
    procedure sbLOCAL_PHONE_STATUSClick(Sender: TObject);
    procedure sbAGENTClick(Sender: TObject);
    procedure qContractsAfterInsert(DataSet: TDataSet);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    fCONTRACT_ID : Integer;

    { Private declarations }
  public
    { Public declarations }
  published
    property CONTRACT_ID: Integer read fCONTRACT_ID write SetCONTRACT_ID;

  end;

var
  RefEditContractForm: TRefEditContractForm;

implementation

{$R *.dfm}

uses RefPhones, RefPhonesOnAcc, RefAbonents, RefFilial, RefOperatorPhoneStatuses, RefOperatorAccountNames, RefOperatorSubAccount,
     RefVirtual_Operators, RefProjects, RefLocal_Phone_Statuses, RefAgent, RefTariffs;

procedure TRefEditContractForm.SetCONTRACT_ID(aValue: Integer);
begin
  if aValue  >= 0 then
  begin
    qContracts.ParamByName('CONTRACT_ID').AsInteger := aValue;
    qContracts.Open;
    qContracts.Edit;
    Caption := 'Договора - режим редактирования';
  end
  else
  begin
    qContracts.Open;
    qContracts.Insert;
    //qContracts.FieldByName('CONTRACT_DATE').AsDateTime := Date;

    Caption := 'Договора - режим вставки';
  end;
  fCONTRACT_ID := aValue;
end;


procedure TRefEditContractForm.sSpeedButton1Click(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefTariffsForm.Create(nil, spf, sbAbonent.Hint, true);
  TRefTariffsForm(spf).qRef.Locate('TARIFF_ID', qContracts.FieldByName('TARIFF_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qTariffs.Refresh;
      vl := TRefTariffsForm(spf).qRef.FieldByName('TARIFF_ID').Value;
      qContracts.FieldByName('TARIFF_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbSUB_ACCOUNTClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefOperatorSubAccountForm.Create(nil, spf, sbSUB_ACCOUNT.Hint, true);
  TRefOperatorSubAccountForm(spf).qRef.Locate('SUB_ACCOUNT_ID', qContracts.FieldByName('SUB_ACCOUNT_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qOperatorSubAccounts.Refresh;
      vl := TRefOperatorSubAccountForm(spf).qRef.FieldByName('SUB_ACCOUNT_ID').Value;
      qContracts.FieldByName('SUB_ACCOUNT_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbVIRTUAL_ACCOUNTSClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefVirtual_OperatorsForm.Create(nil, spf, sbVIRTUAL_ACCOUNTS.Hint, true);
  TRefVirtual_OperatorsForm(spf).qRef.Locate('VIRTUAL_ACCOUNTS_ID', qContracts.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qVirtual_Operator.Refresh;
      vl := TRefVirtual_OperatorsForm(spf).qRef.FieldByName('VIRTUAL_ACCOUNTS_ID').Value;
      qContracts.FieldByName('VIRTUAL_ACCOUNTS_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.FormActivate(Sender: TObject);
begin
  inherited;
   if (qContracts.State in [dsInsert]) then
     eContract_num.Enabled := False
   else
     eContract_num.Enabled := True;
  // Dm.qTarif_For_Oper.Close;
  // Dm.qTarif_For_Oper.ParamByName('p_phone_id').AsLargeInt := StrToInt64Def(cbPhone.Text,0);
   //qContracts.FieldByName('PHONE_').AsLargeInt;
 //  Dm.qTarif_For_Oper.Open;

end;

procedure TRefEditContractForm.FormCreate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  qAbonents.Open;
  Application.ProcessMessages;
  qLocal_Phone_Statuses.Open;
  Application.ProcessMessages;
  qProjects.Open;
  Application.ProcessMessages;
  qVirtual_Operator.Open;
  Application.ProcessMessages;
  qAbonents.Open;
  Application.ProcessMessages;
  qOperator_Account_Names.Open;
  Application.ProcessMessages;
  qTariffs.Open;
  Application.ProcessMessages;
  qOperatorSubAccounts.Open;

  Application.ProcessMessages;
  qPhonesForAccount.Open;
  Application.ProcessMessages;
  qOperator_Phone_Statuses.Open;
  Application.ProcessMessages;
  qFilials.Open;
  Application.ProcessMessages;
  qAgent.Open;
end;

procedure TRefEditContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) then
  begin
    close;
    Key := VK_ESCAPE;
  end;

  if (ssCtrl in (Shift)) and ( (Key = ord('S'))  or (Key = ord('s')) ) then
    sBsave.Click;
end;

procedure TRefEditContractForm.qContractsAfterInsert(DataSet: TDataSet);
begin
  inherited;

  qContracts.FieldByName('CONTRACT_DATE').AsDateTime := Date;
  qContracts.FieldByName('AGENT_DATE_DISPATCH').AsDateTime := Date;
  qContracts.FieldByName('SALE_DATE').AsDateTime := Date;
  qContracts.FieldByName('SALE_COST').Asinteger := 0;
  qContracts.FieldByName('CONTRACT_DISCOUNT').Asinteger := 0;
  qContracts.FieldByName('ABONENT_ID').Asinteger := 371;
  qContracts.FieldByName('FILIAL_ID').Asinteger := 81;
  qContracts.FieldByName('OPERATOR_PHONE_STATUSE_ID').Asinteger := 4;
  qContracts.FieldByName('OPERATOR_ACCOUNT_NAME_ID').Asinteger := 2;
  qContracts.FieldByName('SUB_ACCOUNT_ID').Asinteger := 0;
  qContracts.FieldByName('VIRTUAL_ACCOUNTS_ID').Asinteger := 0;
  qContracts.FieldByName('PROJECT_ID').Asinteger := 0;
  qContracts.FieldByName('LOCAL_PHONE_STATUSE_ID').Asinteger := 1;
  qContracts.FieldByName('AGENT_ID').Asinteger := 119;
  qContracts.FieldByName('TARIFF_ID').Asinteger := 122;
  qContracts.FieldByName('PHONE_ON_ACCOUNTS_ID').Asinteger := -1;

end;

procedure TRefEditContractForm.qContractsBeforePost(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to qContracts.FieldCount - 1 do
  begin
    if qContracts.Fields[i].Required then
    begin
      if (
          (qContracts.Fields[i].IsNull)
          AND (
                (qContracts.Fields[i].DataType = ftSmallint)
                or (qContracts.Fields[i].DataType = ftInteger)
                or (qContracts.Fields[i].DataType = ftFloat)
              )
         )
         OR
         (
            (qContracts.Fields[i].DataType = ftString)
            AND
            (
              (qContracts.Fields[i].IsNull)
              or
              (Trim(qContracts.Fields[i].Asstring) = '')
            )
         )
      then
      begin
        TimedMessageBox('Ошибка: значение "' + qContracts.Fields[i].DisplayLabel + '" не заполнено!', 'Внимание!', mtError, [mbAbort], mbAbort, 15, 3);
        raise EAbort.Create('');
      end;
    end;
  end;

  inherited;

end;

procedure TRefEditContractForm.qContractsPHONE_ON_ACCOUNTS_IDChange(
  Sender: TField);
begin
  inherited;
   Dm.qTarif_For_Oper.Close;
   Dm.qTarif_For_Oper.ParamByName('p_phone_id').AsLargeInt := StrToInt64Def(cbPhone.Text,0);
   Dm.qTarif_For_Oper.Open;
end;

procedure TRefEditContractForm.sbAbonentClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefAbonentsForm.Create(nil, spf, sbAbonent.Hint, true);
  TRefAbonentsForm(spf).qRef.Locate('ABONENT_ID', qContracts.FieldByName('ABONENT_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qAbonents.Refresh;
      vl := TRefAbonentsForm(spf).qRef.FieldByName('ABONENT_ID').Value;
      qContracts.FieldByName('ABONENT_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbAGENTClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefAgentForm.Create(nil, spf, sbAGENT.Hint, true);
  TRefAgentForm(spf).qRef.Locate('AGENT_ID', qContracts.FieldByName('AGENT_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qAgent.Refresh;
      vl := TRefAgentForm(spf).qRef.FieldByName('AGENT_ID').Value;
      qContracts.FieldByName('AGENT_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbFilialClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefFilialForm.Create(nil, spf, sbFilial.Hint, true);
  TRefFilialForm(spf).qRef.Locate('FILIAL_ID', qContracts.FieldByName('FILIAL_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qFilials.Refresh;
      vl := TRefFilialForm(spf).qRef.FieldByName('FILIAL_ID').Value;
      qContracts.FieldByName('FILIAL_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbLOCAL_PHONE_STATUSClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefLocal_Phone_StatusesForm.Create(nil, spf, sbLOCAL_PHONE_STATUS.Hint, true);
  TRefLocal_Phone_StatusesForm(spf).qRef.Locate('LOCAL_PHONE_STATUSE_ID', qContracts.FieldByName('LOCAL_PHONE_STATUSE_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qLocal_Phone_Statuses.Refresh;
      vl := TRefLocal_Phone_StatusesForm(spf).qRef.FieldByName('LOCAL_PHONE_STATUSE_ID').Value;
      qContracts.FieldByName('LOCAL_PHONE_STATUSE_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbOPERATOR_ACCOUNT_NAMEClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefOperatorAccountNamesForm.Create(nil, spf, sbOPERATOR_ACCOUNT_NAME.Hint, true);
  TRefOperatorAccountNamesForm(spf).qRef.Locate('OPERATOR_ACCOUNT_NAME_ID', qContracts.FieldByName('OPERATOR_ACCOUNT_NAME_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qOperator_Account_Names.Refresh;
      vl := TRefOperatorAccountNamesForm(spf).qRef.FieldByName('OPERATOR_ACCOUNT_NAME_ID').Value;
      qContracts.FieldByName('OPERATOR_ACCOUNT_NAME_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbPhoneClick(Sender: TObject);
var
  spf : TChildForm;
begin
  spf := TRefPhonesOnAccFrm.Create(nil, spf, sbPhone.Hint, true);
  if cbPhone.Text <> '' then
    TRefPhonesOnAccFrm(spf).qRef.Locate('PHONE_NUMBER', cbPhone.Text,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qPhonesForAccount.Refresh;
      qContracts.FieldByName('PHONE_ON_ACCOUNTS_ID').AsInteger :=
        Dm.qPhonesOnAccount.Lookup('PHONE_NUMBER', TRefPhonesOnAccFrm(spf).qRef.FieldByName('PHONE_NUMBER').Value, 'PHONE_ON_ACCOUNTS_ID');
    end;
  finally
    spf.Free;
  end;

end;

procedure TRefEditContractForm.sbProjectClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefProjectsForm.Create(nil, spf, sbProject.Hint, true);
  TRefProjectsForm(spf).qRef.Locate('PROJECT_ID', qContracts.FieldByName('PROJECT_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qProjects.Refresh;
      vl := TRefProjectsForm(spf).qRef.FieldByName('PROJECT_ID').Value;
      qContracts.FieldByName('PROJECT_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sbSatusOperClick(Sender: TObject);
var
  spf : TChildForm;
  vl: Variant;
begin
  inherited;
  spf := TRefOperatorPhoneStatusesForm.Create(nil, spf, sbSatusOper.Hint, true);
  TRefOperatorPhoneStatusesForm(spf).qRef.Locate('OPERATOR_PHONE_STATUSE_ID', qContracts.FieldByName('OPERATOR_PHONE_STATUSE_ID').AsInteger ,[]);
  try
    if spf.ShowModal = mrOk then
    begin
      qOperator_Phone_Statuses.Refresh;
      vl := TRefOperatorPhoneStatusesForm(spf).qRef.FieldByName('OPERATOR_PHONE_STATUSE_ID').Value;
      qContracts.FieldByName('OPERATOR_PHONE_STATUSE_ID').value := vl;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefEditContractForm.sBsaveClick(Sender: TObject);
begin
  inherited;
  try
    qContracts.Post;
    fCONTRACT_ID :=  qContracts.FieldByName('CONTRACT_ID').AsInteger;
    ModalResult := mrOk;
  except
    on e : exception do
    begin
      if E.Message <> '' then
        TimedMessageBox(E.Message, 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
      ModalResult := mrNone;
    end;
  end;
end;

end.
