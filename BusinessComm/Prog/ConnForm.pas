unit ConnForm;

interface

uses
  Classes, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls,
  MemUtils, Ora, OraError, OdacVCL, uDm, Func_Const, sEdit, TimedMsgBox,
  sComboBox, sCheckBox, sBitBtn;

type
  TfmConn = class(TForm)
    Panel: TPanel;
    pServerSchema: TPanel;
    Panel2: TPanel;
    edUsername: TsEdit;
    edPassword: TsEdit;
    eSchema: TsEdit;
    edServer: TsComboBox;
    cbEncrypt_pwd: TsCheckBox;
    btnAdd: TsBitBtn;
    btCancel: TsBitBtn;
    btConnect: TsBitBtn;
    Image1: TImage;
    procedure btConnectClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FConnectDialog: TConnectDialog;
    FRetries: integer;
    FRetry: boolean;

    procedure SetConnectDialog(Value: TConnectDialog);

  protected
    procedure DoInit; virtual;
    procedure DoConnect; virtual;
  public
    { Public declarations }
  published
    property ConnectDialog: TConnectDialog read FConnectDialog
      write SetConnectDialog;

  end;

var
  fmConn: TfmConn;

implementation

{$R *.dfm}

procedure TfmConn.DoInit;
var
  List: TStringList;
begin
  FRetry := False;
  FRetries := FConnectDialog.Retries;
  Caption := FConnectDialog.Caption;
  edUsername.BoundLabel.Caption := FConnectDialog.UsernameLabel;
  edPassword.BoundLabel.Caption := FConnectDialog.PasswordLabel;
  edServer.BoundLabel.Caption := FConnectDialog.ServerLabel;
  btConnect.Caption := FConnectDialog.ConnectButton;
  btCancel.Caption := FConnectDialog.CancelButton;
  List := TStringList.Create;
  try
    FConnectDialog.GetServerList(List);
    List.Assign(edServer.Items);
  finally
    List.Free;
  end;
  edUsername.Text := dm.fUserName;
  edServer.Text := dm.fServer;
  eSchema.Text := dm.fSchemaName;
  edPassword.Text := dm.fPassword;
  pServerSchema.Visible := (edServer.Text = '') or (eSchema.Text = '');
  if (edUsername.Text = '') then
    ActiveControl := edUsername
  else
    ActiveControl := edPassword;
  cbEncrypt_pwd.Visible := true;
  cbEncrypt_pwd.checked := true;
  if not dm.splashDone then
  begin
    dm.splashDone := true;
    dm.SplScreen.Hide;
  end;
end;

procedure TfmConn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btConnect.Click;

end;

procedure TfmConn.FormShow(Sender: TObject);
begin
 SetActiveWindow(Handle);
 SetForegroundWindow(Handle);
 SetActiveWindow(Application.Handle);

end;

procedure TfmConn.DoConnect;
begin
  FConnectDialog.Session.Password := edPassword.Text;
  FConnectDialog.Session.Server := edServer.Text;
  FConnectDialog.Session.UserName := edUsername.Text;
  FConnectDialog.Session.Schema := eSchema.Text;
  try
    FConnectDialog.Connection.PerformConnect(FRetry);
    ModalResult := mrOk;
  except
    on E: EOraError do
    begin
      Dec(FRetries);
      FRetry := true;
      if FRetries = 0 then
        ModalResult := mrCancel
      else
      begin
        case E.ErrorCode of
          1005:
            begin
              TimedMessageBox('Неверно указан пароль!',
                'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
              ActiveControl := edPassword;
            end;
          1017:
            begin
              TimedMessageBox('Неверно указано имя пользователя или пароль',
                'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
              if ActiveControl <> edUsername then
                ActiveControl := edPassword;
            end;
          12203, 12154:
            begin
              TimedMessageBox('Не удается соединиться с сервером',
                'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
              MessageDlg('Не удается соединиться с сервером', mtError,
                [mbOK], 0);
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

procedure TfmConn.SetConnectDialog(Value: TConnectDialog);
begin
  FConnectDialog := Value;
  DoInit;
end;

procedure TfmConn.btConnectClick(Sender: TObject);
begin
  if Trim(edUsername.Text) = '' then
  begin
    // MessageDlg('Имя пользователя должно быть заполнено.', mtError, [mbOK], 0);
    TimedMessageBox('Имя пользователя должно быть заполнено!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
    if edUsername.CanFocus() then
      edUsername.SetFocus();
  end
  else if Trim(eSchema.Text) = '' then
  begin
    // MessageDlg('Имя схемы должно быть заполнено.', mtError, [mbOK], 0);
    TimedMessageBox('Имя схемы должно быть заполнено!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
    if eSchema.CanFocus() then
      eSchema.SetFocus();
  end
  else if Trim(edPassword.Text) = '' then
  begin
    TimedMessageBox('Пароль должен быть заполнен!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 0, 0);
    // MessageDlg('Пароль должен быть заполнен.', mtError, [mbOK], 0);
    if edPassword.CanFocus() then
      edPassword.SetFocus();
  end
  else
    DoConnect;
end;

procedure TfmConn.btnAddClick(Sender: TObject);
begin
  pServerSchema.Visible := not pServerSchema.Visible;
  if pServerSchema.Visible then
  begin
    btnAdd.Caption := 'Скрыть';
    btnAdd.ImageIndex := 29;
  end
  else
  begin
    btnAdd.Caption := 'Дополнительно';
    btnAdd.ImageIndex := 28;
  end;
end;

initialization

if GetClass('TfmConn') = nil then
  Classes.RegisterClass(TfmConn);

end.
