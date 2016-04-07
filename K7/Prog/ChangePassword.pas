unit ChangePassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus,oraerror;

type
  TChangePasswordForm = class(TForm)
    btConnect:tbitbtn;
    btCancel:tbitbtn;
    old_pwd: TEdit;
    new_pwd: TEdit;
    confirm_pwd: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    alter_user_encrypt_pwd: TOraStoredProc;
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

uses ContractsRegistration_Utils, Main, DMUnit;



procedure TChangePasswordForm.btConnectClick(Sender: TObject);
begin
 if dm.OraSession.Password <> old_pwd.text then begin
   MessageDlg('Неверный старый пароль!', mtError, [mbOK], 0);
   exit;
 end;
 if not SameText(new_pwd.text, confirm_pwd.text) then begin
   MessageDlg('Введенные пароли не совпадают!', mtError, [mbOK], 0);
   exit;
 end;
 try
   alter_user_encrypt_pwd.ParamByName('p_USER_NAME').AsString:=dm.OraSession.Username;
   alter_user_encrypt_pwd.ParamByName('p_PASSWORD').AsString:=md5_30(new_pwd.text);
   alter_user_encrypt_pwd.ExecSQL;
   modalresult:=mrOk;
 except
   on e : exception do
     MessageDlg('Ошибка при смене пароля'#13#10+e.Message, mtError, [mbOK], 0);
 end;
end;

end.


