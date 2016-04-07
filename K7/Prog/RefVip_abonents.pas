unit RefVip_abonents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemplateFrm, Ora, Vcl.ActnList,
  Vcl.Menus, Data.DB, MemDS, DBAccess, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TVIP_Abonents = class(TTemplateForm)
    qMainPHONE_NUMBER: TFloatField;
    qMainINFO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VIP_Abonents: TVIP_Abonents;

implementation

{$R *.dfm}

end.
