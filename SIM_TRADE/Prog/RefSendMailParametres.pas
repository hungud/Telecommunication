unit RefSendMailParametres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TSendMailParametresFrm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SendMailParametresFrm: TSendMailParametresFrm;

implementation

{$R *.dfm}

procedure TSendMailParametresFrm.aRefreshExecute(Sender: TObject);
begin
  qMain.Close;
  qMain.Open;
end;

procedure TSendMailParametresFrm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('SMTP_PORT').IsNull then
    DataSet.FieldByName('SMTP_PORT').AsInteger:=25;
  if DataSet.FieldByName('SMTP_SERVER').IsNull then
  begin
    MessageDlg('Почтовый сервер должен быть назван', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('USER_LOGIN').IsNull then
       begin
         MessageDlg('Имя пользователя должно быть названо', mtError, [mbOK], 0);
         Abort;
       end
       else if DataSet.FieldByName('USER_PASSWORD').IsNull then
            begin
              MessageDlg('Пароль к почте должен быть записан', mtError, [mbOK], 0);
              Abort;
            end;
end;

end.
