unit EditAbonent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Ora, MemDS, DBAccess, EditAbonentFrame, StdCtrls, Buttons,
  ExtCtrls;

type
  TEditAbonentForm = class(TForm)
    TEditAbonentFrme1: TEditAbonentFrme;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    FRunMode : String; // INSERT, EDIT
    FAbonentId : Variant;
  end;

//var
//  Form1: TForm1;

//  function DoAddAbonent(var pAbonentId : Variant) : boolean;

//  function DoEditAbonent(const pAbonentId :riant) : boolean;

implementation

{$R *.dfm}

{
function DoAddAbonent(var pAbonentId : Variant) : boolean;
var EditAbonentForm : TEditAbonentForm;
begin
  EditAbonentForm := TEditAbonentForm.Create(Application);
  try
    EditAbonentForm.Caption := 'Добавление абонента';
    EditAbonentForm.FRunMode := 'INSERT';
    Result := (mrOk = EditAbonentForm.ShowModal);
    pAbonentId := EditAbonentForm.FAbonentId;
  finally
    EditAbonentForm.Free;
  end;
end;

function DoEditAbonent(const pAbonentId : Variant) : boolean;
var EditAbonentForm : TEditAbonentForm;
begin
  EditAbonentForm := TEditAbonentForm.Create(Application);
  try
    EditAbonentForm.Caption := 'Редактирование параметров абонента';
    EditAbonentForm.FRunMode := 'EDIT';
    EditAbonentForm.FAbonentId := pAbonentId;
    Result := (mrOk = EditAbonentForm.ShowModal);
  finally
    EditAbonentForm.Free;
  end;
end;
}

procedure TEditAbonentForm.FormShow(Sender: TObject);
begin
  TEditAbonentFrme1.PrepareFrame(FRunMode, FAbonentId);
  TEditAbonentFrme1.aFindAbonent.Visible := False;
  if TEditAbonentFrme1.SURNAME.CanFocus then
    TEditAbonentFrme1.SURNAME.SetFocus(); 
end;

procedure TEditAbonentForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    CanClose := TEditAbonentFrme1.SaveData('');
    FAbonentId := TEditAbonentFrme1.FAbonentId;
  end;
end;

procedure TEditAbonentForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
    ModalResult := mrOk;
end;

end.
