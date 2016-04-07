unit RefUserNames;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, VirtualTable, Ora,
  MemDS, DBAccess, Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar, OraSmart, Vcl.StdCtrls, Vcl.Buttons,
  sBitBtn, Vcl.ExtCtrls, sPanel, Func_Const, uDm, TimedMsgBox;

type
  TRefUserNamesForm = class(TRefForm)
    aLock: TAction;
    aUnLock: TAction;
    ChangeOracleUserState: TOraStoredProc;
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
    procedure qRefAfterInsert(DataSet: TDataSet);
    procedure qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qUserNamesUpdateError(DataSet: TDataSet; E: EDatabaseError;
                                    UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);

  private
    encr_pw: Boolean;
   // ExAfterScroll, ExAfterOpen, ExBeforeOpen, ExAfterPost, ExBeforePost : MyProc;
   // AssignExBeforeOpen, AssignExAfterPost, AssignExBeforePost, AssignExAfterScroll : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefUserNamesForm: TRefUserNamesForm;

implementation

{$R *.dfm}


procedure TRefUserNamesForm.aLockExecute(Sender: TObject);
begin
  inherited;
  try
    ChangeOracleUserState.ParamByName('AuthID').AsString := qRef.FieldByName('USER_NAME').AsString;
    ChangeOracleUserState.ParamByName('EVENT').AsInteger := 0;
    ChangeOracleUserState.ExecProc;
  finally
    if UpperCase(ChangeOracleUserState.ParamByName('RESULT').AsString) = 'OK' then
      TimedMessageBox('Блокировка пользователя выполнена успешно', Caption, mtInformation, [mbOK], mbOK, 15, 3)
    else
      TimedMessageBox('Блокировка пользователя не выполнена! Попробуйте выполнить позже.', Caption, mtError, [mbOK], mbOK, 0, 3);
  end;
end;

procedure TRefUserNamesForm.aUnLockExecute(Sender: TObject);
begin
  inherited;
  try
    ChangeOracleUserState.ParamByName('AuthID').AsString := qRef.FieldByName('USER_NAME').AsString;
    ChangeOracleUserState.ParamByName('EVENT').AsInteger := 1;
    ChangeOracleUserState.ExecProc;
  finally
    if UpperCase(ChangeOracleUserState.ParamByName('RESULT').AsString) = 'OK' then
      TimedMessageBox('Разблокировка пользователя выполнена успешно', Caption, mtInformation, [mbOK], mbOK, 15, 3)
    else
      TimedMessageBox('Разблокировка пользователя не выполнена! Попробуйте выполнить позже.', Caption, mtError, [mbOK], mbOK, 0, 3);
  end;
end;

procedure TRefUserNamesForm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qUserNames;
  qRef.FieldByName('PASSWORD').OnGetText := PasswordGetText;
  qRef.FieldByName('PASSWORD').OnSetText := PasswordSetText;
  // Обязательно назначить до inherited;
  inherited;
  qRef.AfterInsert := qRefAfterInsert;
  qRef.onPostError := qRefPostError;
  qRef.onUpdateError :=  qUserNamesUpdateError;
end;

procedure TRefUserNamesForm.FormShow(Sender: TObject);
begin
  inherited;
  aLock.Enabled := not qRef.IsEmpty;
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
    qRef.FieldByName('ENCRYPT_PWD').AsInteger := 1;
    qRef.FieldByName('ENCRYPT_PWD_STR').AsString := 'Да';
  end
  else
    TStringField(Sender).AsString := Text;
end;

procedure TRefUserNamesForm.qRefAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('ENCRYPT_PWD').AsInteger := 1;
end;

procedure TRefUserNamesForm.qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, '20001') then
  begin
    TimedMessageBox('Имя пользователя должно быть заполнено!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
  if AnsiContainsText(E.Message, '20002') then
  begin
    TimedMessageBox('Пользователь с именем '+ DataSet.FieldByName('USER_NAME').AsString +' уже зарегистрирован. Измените имя пользователя!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
  if AnsiContainsText(E.Message, '20003') then
  begin
    TimedMessageBox('Пароль должен быть определен!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

procedure TRefUserNamesForm.qUserNamesUpdateError(DataSet: TDataSet; E: EDatabaseError;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  TimedMessageBox('Ошибка обновления. Измените параметры!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
  UpdateAction := uaAbort;
end;

end.
