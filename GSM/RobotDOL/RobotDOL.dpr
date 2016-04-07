program RobotDOL;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainFrm},
  DOLBeline in 'DOLBeline.pas',
  BufStr in 'BufStr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
