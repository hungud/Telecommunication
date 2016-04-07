unit RefFrmEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Data.DB, DBAccess,
  Vcl.Grids, Vcl.DBGrids, ImageVarnCl,
  Vcl.ExtCtrls, Ora, MemDS, CRGrid, TimedMsgBox, DMUnit, Vcl.StdCtrls,
  Vcl.Buttons, sBitBtn, sPanel, sScrollBox, sLabel, Vcl.Mask, Vcl.DBCtrls;

type
  TRefFormEdit = class(TForm)
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    ScrollBox: TsScrollBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefFormEdit: TRefFormEdit;

implementation

{$R *.dfm}

procedure TRefFormEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    close;
  Key := VK_ESCAPE;
end;

end.
