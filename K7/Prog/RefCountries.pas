unit RefCountries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Ora, Data.DB, MemDS, DBAccess,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, DMUnit,
  Vcl.ToolWin, sToolBar, Vcl.ExtCtrls, Vcl.StdCtrls, VirtualTable, Vcl.Mask,
  TimedMsgBox,
  Vcl.DBCtrls, Vcl.Imaging.jpeg, Vcl.Buttons, sBitBtn, sPanel;

type
  TRefCountriesForm = class(TRefForm)
    img1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dd: boolean;
  end;

var
  RefCountriesForm: TRefCountriesForm;

implementation

{$R *.dfm}

procedure TRefCountriesForm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qCountry;
  inherited;

end;

end.
