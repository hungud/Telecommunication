unit RefFrmEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Data.DB, DBAccess,
  Vcl.Grids, Vcl.DBGrids, ImageVarnCl,
  Vcl.ExtCtrls, Ora, MemDS, CRGrid, TimedMsgBox, uDm, Vcl.StdCtrls,
  Vcl.Buttons, sBitBtn, sPanel, sScrollBox, sLabel, Vcl.Mask, Vcl.DBCtrls;

type
  TRefFormEdit = class(TForm)
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    ScrollBox: TsScrollBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public
    focusedEdit : TDBEdit; //TWinControlClass;
    NeedClose : Boolean; //пременная для закрытия формы редакитрования в любом случае
    { Public declarations }
  end;

var
  RefFormEdit: TRefFormEdit;

implementation

{$R *.dfm}

procedure TRefFormEdit.FormCreate(Sender: TObject);
begin
  NeedClose := False;
end;

procedure TRefFormEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
  begin
    close;
    Key := VK_ESCAPE;
  end;

  if (ssCtrl in (Shift)) and ( (Key = ord('S'))  or (Key = ord('s')) ) then
    sBsave.Click;
end;

procedure TRefFormEdit.FormShow(Sender: TObject);
begin
  if (focusedEdit <> nil) then
    focusedEdit.SetFocus;
end;

end.
