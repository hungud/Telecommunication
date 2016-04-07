unit ChangePassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus, oraerror, Func_Const, udm, TimedMsgBox;

type
  TChangePasswordForm = class(TForm)
    btConnect: tbitbtn;
    btCancel: tbitbtn;
    old_pwd: TEdit;
    new_pwd: TEdit;
    confirm_pwd: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangePasswordForm: TChangePasswordForm;

implementation

{$R *.dfm}

procedure TChangePasswordForm.btConnectClick(Sender: TObject);
begin
  if dm.fPassword <> old_pwd.text then
  begin
    // MessageDlg('Неверный старый пароль!', mtError, [mbOK], 0);
    TimedMessageBox('Неверный старый пароль!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
    exit;
  end;
  if not SameText(new_pwd.text, confirm_pwd.text) then
  begin
    // MessageDlg('Введенные пароли не совпадают!', mtError, [mbOK], 0);
    TimedMessageBox('Введенные пароли не совпадают!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
    exit;
  end;
end;

end.
