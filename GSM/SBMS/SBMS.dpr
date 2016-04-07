program SBMS;

uses
  Forms,
  ClientsListUnit in 'ClientsListUnit.pas' {Form1},
  ExportExcel in 'ExportExcel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
