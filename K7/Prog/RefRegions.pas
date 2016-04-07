unit RefRegions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, VirtualTable, Ora,
  MemDS, DBAccess, Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar, DMUnit, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  Vcl.ExtCtrls, sPanel;

type
  TRefRegionsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefRegionsForm: TRefRegionsForm;

implementation

{$R *.dfm}

uses RefCountries;

procedure TRefRegionsForm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qRegions;
  ListCls := TLCls.Create(TRefCountriesForm);
  // Обязательно назначить до inherited;
  inherited;
  CaptList.Add('Справочник стран');
  AddExcelColNumber := False;
end;

end.
