{--$I DacDemo.inc}

unit ConnForm;

interface

uses
{$IFDEF MSWINDOWS}
  Windows, Messages,
{$ENDIF}
{$IFDEF KYLIX}
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  QComCtrls, QExtCtrls, QGrids, QDBGrids, OdacClx, QButtons, QMask,
{$ELSE}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, OdacVcl,
{$IFNDEF FPC}
  Mask,
{$ENDIF}
{$ENDIF}
{$IFDEF FPC}
  LResources,
{$ENDIF}
  MemUtils, Ora, OraError, IniFiles;

type
  TfmConn = class(TForm)
    Panel: TPanel;
    lbUsername: TLabel;
    lbPassword: TLabel;
    edUsername: TEdit;
    edPassword: TMaskEdit;
    pServerSchema: TPanel;
    Panel2: TPanel;
    btConnect: TBitBtn;
    btCancel: TBitBtn;
    lbServer: TLabel;
    edServer: TComboBox;
    Label1: TLabel;
    eSchema: TEdit;
    btnAdd: TBitBtn;
    cbEncrypt_pwd: TCheckBox;
    procedure btConnectClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure eSchemaChange(Sender: TObject);
  private
    FConnectDialog: TConnectDialog;
    FRetries: integer;
    FRetry: boolean;

    procedure SetConnectDialog(Value:TConnectDialog);
    procedure ReadIniParams(var pUserName, pServer, pSchemaName, pPassword: String);
    procedure WriteIniParams(const pUserName, pServer, pSchemaName, pPassword: String);

  protected
    procedure DoInit; virtual;
    procedure DoConnect; virtual;

  public

  published
    property ConnectDialog:TConnectDialog read FConnectDialog write SetConnectDialog;

  end;

var
  fmConn: TfmConn;

implementation

{$IFNDEF FPC}
{$IFDEF CLR}
{$R *.nfm}
{$ENDIF}
{$IFDEF WIN32}
{$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
{$R *.xfm}
{$ENDIF}
{$ENDIF}

uses ContractsRegistration_Utils;

procedure TfmConn.DoInit;
var
  List: TStringList;
  pUserName, pServer, pSchemaName, pPassword : String;
begin
  FRetry := False;
  FRetries := FConnectDialog.Retries;
  Caption := FConnectDialog.Caption;

  lbUsername.Caption := FConnectDialog.UsernameLabel;
  lbPassword.Caption := FConnectDialog.PasswordLabel;
  lbServer.Caption := FConnectDialog.ServerLabel;
  btConnect.Caption := FConnectDialog.ConnectButton;
  btCancel.Caption := FConnectDialog.CancelButton;

  List := TStringList.Create;
  try
    FConnectDialog.GetServerList(List);
    list.Assign(edServer.Items);
  finally
    List.Free;
  end;

  {
  edUsername.Text := FConnectDialog.Session.Username;
  edPassword.Text := FConnectDialog.Session.Password;
  edServer.Text := FConnectDialog.Session.Server;
  }

  ReadIniParams(pUserName, pServer, pSchemaName, pPassword);
  edUsername.Text := pUserName;
  edServer.Text := pServer;
  eSchema.Text := pSchemaName;
  edPassword.Text := pPassword;

  pServerSchema.Visible := (edServer.Text = '') or (eSchema.Text = '');

  if (edUsername.Text = '') then
    ActiveControl := edUsername
  else
    ActiveControl := edPassword;
  //Проверяем, показывать ли "галку" шифрования пароля
  if (UpperCase(pSchemaName) = 'CORP_MOBILE')
    OR(UpperCase(pSchemaName) = 'LONTANA')
    or(eSchema.text = 'GSM Корпорация') then begin
    cbEncrypt_pwd.visible:=true;
    cbEncrypt_pwd.checked:=true;
  end
  else begin
    cbEncrypt_pwd.visible:=false;
    cbEncrypt_pwd.checked:=false;
  end;
end;

procedure TfmConn.eSchemaChange(Sender: TObject);
begin
  if (UpperCase(eSchema.text) = 'CORP_MOBILE')
    OR(UpperCase(eSchema.text) = 'LONTANA')
    or(eSchema.text = 'GSM Корпорация') then begin
    cbEncrypt_pwd.visible:=true;
    cbEncrypt_pwd.checked:=true;
  end
  else begin
    cbEncrypt_pwd.visible:=false;
    cbEncrypt_pwd.checked:=false;
  end;
end;

procedure TfmConn.DoConnect;
begin
  if ((UpperCase(edUsername.Text)= 'LONTANA') and (eSchema.Text = 'GSM Корпорация'))
        or (SameText(edUsername.Text,eSchema.Text)) or (not cbEncrypt_pwd.checked)  then
    FConnectDialog.Session.Password := edPassword.Text
  else FConnectDialog.Session.Password := md5_30(edPassword.Text);
  FConnectDialog.Session.Server := edServer.Text;
  FConnectDialog.Session.UserName := edUsername.Text;
  if (edServer.Text = '188.65.209.191:1521:GSMCORP') and (eSchema.Text = 'GSM Корпорация')
    then FConnectDialog.Session.Schema := 'LONTANA'
    else FConnectDialog.Session.Schema := eSchema.Text;
  try
    FConnectDialog.Connection.PerformConnect(FRetry);
    WriteIniParams(edUsername.Text, edServer.Text, eSchema.Text, edPassword.Text);
    ModalResult := mrOk;
  except
    on E:EOraError do begin
      Dec(FRetries);
      FRetry := True;
      if FRetries = 0 then
        ModalResult := mrCancel
      else
      begin
        case E.ErrorCode of
          1005: begin
                  MessageDlg('Неверно указан пароль', mtError, [mbOK], 0);
                  ActiveControl := edPassword;
                end;
          1017: begin
                  MessageDlg('Неверно указано имя пользователя или пароль', mtError, [mbOK], 0);
                  if ActiveControl <> edUsername then ActiveControl := edPassword;
                end;
          12203,12154:
                begin
                  MessageDlg('Не удается соединиться с сервером', mtError, [mbOK], 0);
                  ActiveControl := edServer;
                end;
        else
          raise;
        end;
      end;
    end
    else
      raise;
  end;
end;

procedure TfmConn.SetConnectDialog(Value:TConnectDialog);
begin
  FConnectDialog := Value;
  DoInit;
end;

procedure TfmConn.btConnectClick(Sender: TObject);
begin
  if Trim(edUsername.Text) = '' then
  begin
    MessageDlg('Имя пользователя должно быть заполнено.', mtError, [mbOK], 0);
    if edUsername.CanFocus() then
      edUsername.SetFocus();
  end
  else if Trim(eSchema.Text) = '' then
  begin
    MessageDlg('Имя схемы должно быть заполнено.', mtError, [mbOK], 0);
    if eSchema.CanFocus() then
      eSchema.SetFocus();
  end
  else if Trim(edPassword.Text) = '' then
  begin
    MessageDlg('Пароль должен быть заполнен.', mtError, [mbOK], 0);
    if edPassword.CanFocus() then
      edPassword.SetFocus();
  end
  else
    DoConnect;
end;

procedure TfmConn.ReadIniParams(var pUserName, pServer, pSchemaName, pPassword : String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); // ParamStr(0)
    try
      pUserName := Ini.ReadString('CONNECT', 'USER_NAME', '');
      pServer := Ini.ReadString('CONNECT', 'SERVER', '');
      pSchemaName := Ini.ReadString('CONNECT', 'SCHEMA', '');
      pPassword := Ini.ReadString('CONNECT', 'PASSWORD', '');
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    pUserName := '';
    pServer := '';
    pSchemaName := '';
    pPassword := '';
  end;
end;

procedure TfmConn.WriteIniParams(const pUserName, pServer, pSchemaName, pPassword: String);
var
  Ini: TIniFile;
  vSchemaName: String;
begin
  try
    Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) ); // ParamStr(0)
    try
      Ini.WriteString('CONNECT', 'USER_NAME', pUserName);
      Ini.WriteString('CONNECT', 'SERVER', pServer);
      if (pServer = '188.65.209.191:1521:GSMCORP') and  (pSchemaName = 'LONTANA')
        then vSchemaName := 'GSM Корпорация'
        else vSchemaName:= pSchemaName;
      Ini.WriteString('CONNECT', 'SCHEMA', vSchemaName);
      //Ini.WriteString('CONNECT', 'PASSWORD', pPassword); // пароль не сохраняем, только считываем
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    ;
  end;
end;

procedure TfmConn.btnAddClick(Sender: TObject);
begin
  pServerSchema.Visible := not pServerSchema.Visible;
end;

initialization
  if GetClass('TfmMyConn') = nil then
    Classes.RegisterClass(TfmConn);

{$IFDEF FPC}
{$I MyConnectForm.lrs}
{$ENDIF}

end.
