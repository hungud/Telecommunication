program RobotDOL_JuridicalPersons;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainFrm},
  BufStr in 'BufStr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
