unit DefineColumns;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls;

type
  TDefineColumnsForm = class(TForm)
    Panel1: TPanel;
    btnSetAll: TBitBtn;
    btnClearAll: TBitBtn;
    ScrollBox: TScrollBox;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnSetAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

{ TDefineColumnsForm }

procedure TDefineColumnsForm.btnSetAllClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TCheckBox then
      (Components[i] as TCheckBox).Checked := true;
  end;
end;

procedure TDefineColumnsForm.btnClearAllClick(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to ComponentCount-1 do
  begin
    if Components[i] is TCheckBox then
      (Components[i] as TCheckBox).Checked := false;
  end;
end;

procedure TDefineColumnsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key in [VK_RETURN,VK_ESCAPE] then
    Close;
end;

end.
