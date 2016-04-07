library IntecScriptWizard;

uses
  ComServ,
  IntecScriptWizard_TLB in 'IntecScriptWizard_TLB.pas',
  ShowScriptFrm in 'ShowScriptFrm.pas' {ShowScriptForm};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
