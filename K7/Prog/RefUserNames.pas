unit RefUserNames;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, VirtualTable, Ora,
  MemDS, DBAccess, Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar, OraSmart, Vcl.StdCtrls, Vcl.Buttons,
  sBitBtn, Vcl.ExtCtrls, sPanel, Func_Const, DMUnit, TimedMsgBox;

type
  TRefUserNamesForm = class(TRefForm)
    aLock: TAction;
    aUnLock: TAction;
    fChangeOracleUserState: TOraStoredProc;
    N7: TMenuItem;
    N8: TMenuItem;
    btn2: TToolButton;
    btnLock: TToolButton;
    btnUnLock: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure PasswordGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure PasswordSetText(Sender: TField; const Text: string);
    procedure aLockExecute(Sender: TObject);
    procedure aUnLockExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    encr_pw: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefUserNamesForm: TRefUserNamesForm;

implementation

{$R *.dfm}

Uses RefFilials;

procedure TRefUserNamesForm.aLockExecute(Sender: TObject);
begin
  inherited;
  try
    fChangeOracleUserState.ParamByName('AuthID').AsString :=
      GlQuery.FieldByName('USER_NAME').AsString;
    fChangeOracleUserState.ParamByName('EVENT').AsInteger := 0;
    fChangeOracleUserState.ExecProc;
  finally
    if UpperCase(fChangeOracleUserState.ParamByName('RESULT').AsString) = 'OK'
    then
      TimedMessageBox('Блокировка пользователя выполнена успешно', Caption,
        mtInformation, [mbOK], mbOK, 15, 3)
    else
      TimedMessageBox
        ('Блокировка пользователя не выполнена! Попробуйте выполнить позже.',
        Caption, mtError, [mbOK], mbOK, 0, 3);
  end;
end;

procedure TRefUserNamesForm.aUnLockExecute(Sender: TObject);
begin
  inherited;
  try
    fChangeOracleUserState.ParamByName('AuthID').AsString :=
      GlQuery.FieldByName('USER_NAME').AsString;
    fChangeOracleUserState.ParamByName('EVENT').AsInteger := 1;
    fChangeOracleUserState.ExecProc;
  finally
    if UpperCase(fChangeOracleUserState.ParamByName('RESULT').AsString) = 'OK'
    then
      TimedMessageBox('Разблокировка пользователя выполнена успешно', Caption,
        mtInformation, [mbOK], mbOK, 15, 3)
    else
      TimedMessageBox
        ('Разблокировка пользователя не выполнена! Попробуйте выполнить позже.',
        Caption, mtError, [mbOK], mbOK, 0, 3);
  end;
end;

procedure TRefUserNamesForm.FormCreate(Sender: TObject);
begin
  GlQuery := Dm.qUserNames;
  if Dm.FUseFilialBlockAccess then
    GlQuery.SQL.Append('WHERE UN.FILIAL_ID=' + IntToStr(Dm.FFilial));

  if (Dm.GetValue(Dm.qConstants, 'USE_PROMISED_PAYMENTS') = '1') then
    GlQuery.FieldByName('MAX_PROMISED_PAYMENT').Visible := True
  else
    GlQuery.FieldByName('MAX_PROMISED_PAYMENT').Visible := False;
  GlQuery.FieldByName('PASSWORD').OnGetText := PasswordGetText;
  GlQuery.FieldByName('PASSWORD').OnSetText := PasswordSetText;

  ListCls := TLCls.Create(TRefFilialsForm);

  encr_pw := (Dm.GetValue(Dm.qConstants, 'ENCRYPT_PASSWORD') = '1');

  // Обязательно назначить до inherited;
  inherited;
  CaptList.Add('Справочник филиалов');
end;

procedure TRefUserNamesForm.FormShow(Sender: TObject);
begin
  inherited;
  aLock.Enabled := not GlQuery.IsEmpty;
  aUnLock.Enabled := aLock.Enabled;

end;

procedure TRefUserNamesForm.PasswordGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if DisplayText then
    Text := '**********'
  else
    Text := '';
end;

procedure TRefUserNamesForm.PasswordSetText(Sender: TField; const Text: string);
begin
  if encr_pw then
  begin
    TStringField(Sender).AsString := md5_30(Text);
    GlQuery.FieldByName('ENCRYPT_PWD').AsInteger := 1;
    GlQuery.FieldByName('ENCRYPT_PWD_STR').AsString := 'Да';
  end
  else
    TStringField(Sender).AsString := Text;
end;

end.
