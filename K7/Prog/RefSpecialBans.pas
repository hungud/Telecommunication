unit RefSpecialBans;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TfrmRefSpecialBans = class(TRefForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRefSpecialBans: TfrmRefSpecialBans;

implementation

{$R *.dfm}

uses DMUnit;

procedure TfrmRefSpecialBans.FormCreate(Sender: TObject);
begin
  GlQuery := Dm.qSPECIAL_BANS;
  inherited;
end;

end.
