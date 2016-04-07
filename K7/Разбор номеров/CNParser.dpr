program CNParser;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Анализ и оценка номеров';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
