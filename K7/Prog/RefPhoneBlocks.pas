unit RefPhoneBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar,
  DMUnit;

type
  TRefPhoneBlocksForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefPhoneBlocksForm: TRefPhoneBlocksForm;

implementation

{$R *.dfm}

uses RefOperators;

procedure TRefPhoneBlocksForm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qPhoneBlocks;
  ListCls := TLCls.Create(TRefOperatorsForm);
  // Обязательно назначить до inherited;
  inherited;
  CaptList.Add('Справочник операторов');
end;

end.
