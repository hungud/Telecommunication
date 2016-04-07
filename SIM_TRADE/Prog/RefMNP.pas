unit RefMNP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemplateFrm, Data.DB, Ora, Vcl.ActnList,
  Vcl.Menus, MemDS, DBAccess, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtCtrls;

type
  TMNP_NUMBERS = class(TTemplateForm)
    qMainPHONE_NUMBER: TStringField;
    qMainTEMP_PHONE_NUMBER: TStringField;
    qMainDATE_ACTIVATE: TDateTimeField;
    qMainIS_ACTIVE: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MNP_NUMBERS: TMNP_NUMBERS;

implementation

{$R *.dfm}

end.
