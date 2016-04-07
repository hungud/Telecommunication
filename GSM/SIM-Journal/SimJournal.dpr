program SimJournal;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ConnForm in 'ConnForm.pas' {fmConn},
  InitUnit in 'InitUnit.pas' {InitForm},
  DictionaryUnit in 'DictionaryUnit.pas' {DictionaryForm},
  OperationUnit in 'OperationUnit.pas' {OperationForm},
  FilterFrameUnit in 'FilterFrameUnit.pas' {FilterFrame: TFrame},
  JournalUnit in 'JournalUnit.pas' {JournalForm},
  OperationFrameUnit in 'OperationFrameUnit.pas' {Frame1: TFrame},
  ExcelUnit in 'ExcelUnit.pas',
  IntecExportGrid in 'IntecExportGrid.pas' {SelectPrintColumnsForm},
  ShowSimInfo in 'ShowSimInfo.pas' {ShowSimInfoForm},
  CorpPortal in 'CorpPortal.pas' {CorpPortalForm},
  SettingsPanel in 'SettingsPanel.pas' {SettingsPanelForm},
  CorpPortalJournal in 'CorpPortalJournal.pas' {CorpPortalJournalForm},
  ChangePassword in 'ChangePassword.pas' {ChangePassword},
  CaptchaCheck in 'CaptchaCheck.pas' {CapchaCheckForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '”чЄт SIM-карт';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCapchaCheckForm, CapchaCheckForm);
  Application.Run;
end.
