unit RefPhoneUsername;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError, StdCtrls,
  Buttons;

type
  TRefPhoneUsernameForm = class(TTemplateForm)
    Oracle1: TMenuItem;
    ToolButton9: TToolButton;
    qMainID: TFloatField;
    qMainUSERNAME: TStringField;
    qMainPASSWORD: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure qMainPASSWORDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;


procedure TRefPhoneUsernameForm.qMainBeforePost(DataSet: TDataSet);
begin
  //inherited;
end;

procedure TRefPhoneUsernameForm.qMainPASSWORDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if DisplayText then
    Text := '**********'
  else
    Text := '';
end;

end.
