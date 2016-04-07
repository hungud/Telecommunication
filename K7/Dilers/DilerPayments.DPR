program DilerPayments;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ConnForm in 'ConnForm.pas' {fmConn},
  RefUserNames in 'RefUserNames.pas' {RefUserNamesForm},
  ContractsRegistration_Utils in 'ContractsRegistration_Utils.pas' {dmUtils: TDataModule},
  ShowUserStat in 'ShowUserStat.pas' {ShowUserStatForm},
  LoadData in 'LoadData.pas' {LoadDataFrm},
  IntecExportGrid in 'IntecExportGrid.pas' {SelectPrintColumnsForm},
  CRStrUtils in 'CRStrUtils.pas',
  BeelineLoadFrm in 'BeelineLoadFrm.pas' {BeelineLoadForm},
  ReportDilerPaymets in 'ReportDilerPaymets.pas' {ReportBills},
  TemplateFrm in 'TemplateFrm.pas' {TemplateForm},
  AddDeposite in 'AddDeposite.pas' {AddDepositeFrm},
  EditAbonentFrame in 'EditAbonentFrame.pas' {EditAbonentFrme: TFrame},
  ShowBillDetails in 'ShowBillDetails.pas' {ShowBillDetailsForm},
  RefDetailTypes in 'RefDetailTypes.pas' {RefDetailTypesForm},
  ChangePassword in 'ChangePassword.pas' {ChangePassword},
  ReportLoadMonitor in 'ReportLoadMonitor.pas' {ReportLoadMonitorForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Дилерские расчеты';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TReportLoadMonitorForm, ReportLoadMonitorForm);
  Application.Run;
end.
