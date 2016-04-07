program ContractsRegistration;



{$R *.dres}

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  uDm in 'uDm.pas' {Dm: TDataModule},
  ConnForm in 'ConnForm.pas' {fmConn},
  Func_Const in 'Func_Const.pas',
  TimedMsgBox in 'TimedMsgBox.pas' {TimedMsgForm},
  ChangePassword in 'ChangePassword.pas' {ChangePasswordForm},
  ChildFrm in 'ChildFrm.pas' {ChildForm},
  RefFrmEdit in 'RefFrmEdit.pas' {RefFormEdit},
  ImageVarnCl in 'ImageVarnCl.pas',
  RefUserNames in 'RefUserNames.pas' {RefUserNamesForm},
  ExportGridToExcelPDF in 'ExportGridToExcelPDF.pas',
  uRepFrm in 'uRepFrm.pas' {RepFrm},
  RefFrm in 'RefFrm.pas' {RefForm},
  RefAccounts in 'RefAccounts.pas' {RefAccountsForm},
  RefMobilOperator in 'RefMobilOperator.pas' {RefMobilOperatorForm},
  RefPhones in 'RefPhones.pas' {RefPhonesForm},
  RefPhonesOnAccountHist in 'RefPhonesOnAccountHist.pas' {RefPhonesOnAccountHistForm},
  SettingProg in 'SettingProg.pas' {SettingProgForm},
  RefCountries in 'RefCountries.pas' {RefCountriesForm},
  RefRegions in 'RefRegions.pas' {RefRegionsForm},
  RefAbonents in 'RefAbonents.pas' {RefAbonentsForm},
  RefFilial in 'RefFilial.pas' {RefFilialForm},
  RefTariffs in 'RefTariffs.pas' {RefTariffsForm},
  RefDocum_Types in 'RefDocum_Types.pas' {RefDocum_TypesForm},
  RefContract in 'RefContract.pas' {RefContractForm},
  RepInfoAboutPhone in 'RepInfoAboutPhone.pas' {RepInfoAboutPhoneFrm},
  RepLoaderBill in 'RepLoaderBill.pas' {RepLoaderBillFrm},
  RepLoaderBillLoadLog in 'RepLoaderBillLoadLog.pas' {RepLoaderBillLoadLogFrm},
  RepBillLoadLog in 'RepBillLoadLog.pas' {RepBillLoadLogFrm},
  RefPeriods in 'RefPeriods.pas' {RefPeriodsForm},
  AddPeriod in 'AddPeriod.pas' {AddPeriodForm},
  RefVirtual_Operators in 'RefVirtual_Operators.pas' {RefVirtual_OperatorsForm},
  FindData in 'FindData.pas' {FindDataForm},
  RefDocument in 'RefDocument.pas' {RefDocumentForm},
  uRepPaymentsHist in 'uRepPaymentsHist.pas' {RepPaymentsHist},
  uShowAnotherVirt_Ac in 'uShowAnotherVirt_Ac.pas' {ShowAnotherVirt_Ac},
  uRepPayments in 'uRepPayments.pas' {RepPayments},
  uInsPayment in 'uInsPayment.pas' {InsPaymentFrm},
  ShowLogMail in 'ShowLogMail.pas' {ShowLogMailFrm},
  RefAgent in 'RefAgent.pas' {RefAgentForm},
  RefSubAgent in 'RefSubAgent.pas' {RefSubAgentForm},
  RefAgentAndSubAgent in 'RefAgentAndSubAgent.pas' {frmRefAgentAndSubAgent},
  RefLocal_Phone_Statuses in 'RefLocal_Phone_Statuses.pas' {RefLocal_Phone_StatusesForm},
  RefOperatorPhoneStatuses in 'RefOperatorPhoneStatuses.pas' {RefOperatorPhoneStatusesForm},
  RefOperatorAccountNames in 'RefOperatorAccountNames.pas' {RefOperatorAccountNamesForm},
  RefOperatorSubAccount in 'RefOperatorSubAccount.pas' {RefOperatorSubAccountForm},
  RefProjects in 'RefProjects.pas' {RefProjectsForm},
  RefEditContract in 'RefEditContract.pas' {RefEditContractForm},
  FiltrForContract in 'FiltrForContract.pas' {FiltrForContractFrm},
  RefPhonesOnAcc in 'RefPhonesOnAcc.pas' {RefPhonesOnAccFrm},
  RefPaymentsType in 'RefPaymentsType.pas' {RefPaymentsTypefrm},
  uInsBalanceVirt in 'uInsBalanceVirt.pas' {InsBalanceVirtFrm},
  uTranscriptBalance in 'uTranscriptBalance.pas' {TranscriptBalanceFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tarifer.ru - Разработка современного программного обеспечения';
  Application.CreateForm(TDm, Dm);
  if Dm.OraSession.Connected then
  begin
    if Dm.modal_rez_ChangePassword <> 2 then
    // idCancel   = 2 смена пароля неудачна, выходим
    begin
      Application.Initialize;
      Application.Title := 'Учет абонентов сотовой связи';
      Application.CreateForm(TMainForm, MainForm);
      Application.Run;
    end;
  end
  else
  begin
    Dm.Free;
  end;

end.
