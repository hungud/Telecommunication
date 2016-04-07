unit RefUserNames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError, Vcl.StdCtrls,
  Vcl.ImgList;

type
  TRefUserNamesForm = class(TTemplateForm)
    qMainUSER_NAME_ID: TFloatField;
    qMainUSER_FIO: TStringField;
    qMainUSER_NAME: TStringField;
    qMainFILIAL_ID: TFloatField;
    qMainRIGHTS_TYPE: TFloatField;
    qFilials: TOraTable;
    qMainFILIAL_NAME: TStringField;
    qRightNames: TOraQuery;
    qMainRIGHT_NAME: TStringField;
    OraQuery1: TOraQuery;
    qMainPASSWORD: TStringField;
    qMainCHECK_ALLOW_ACCOUNT: TIntegerField;
    qCheckAllow: TOraQuery;
    qMainCHECK_ALLOW_NAME: TStringField;
    qMainENCRYPT_PWD: TIntegerField;
    qMainENCRYPT_PWD_STR: TStringField;
    aUnLock: TAction;
    Oracle1: TMenuItem;
    FChangeOracleUserState: TOraStoredProc;
    aLock: TAction;
    Oracle2: TMenuItem;
    qMainMAX_PROMISED_PAYMENT: TFloatField;
    qMainUSER_NAME_OKTEL: TStringField;
    qMainPASSWORD_OKTEL: TStringField;
    Splitter1: TSplitter;
    ImageList1: TImageList;
    qMainSHOW_BLOCK_UNBLOCK_BTN: TFloatField;
    qMainRIGHT_CANCEL_CONTRACT: TFloatField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aPostExecute(Sender: TObject);
    procedure qMainPASSWORDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure qMainPASSWORDSetText(Sender: TField; const Text: string);
    procedure FormCreate(Sender: TObject);
    procedure aUnLockExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, main;

procedure TRefUserNamesForm.aUnLockExecute(Sender: TObject);
begin
try
FChangeOracleUserState.ParamByName('AuthID').AsString := qMainUSER_NAME.AsString;
    if (Sender as Taction).Name='aUnLock' then
    FChangeOracleUserState.ParamByName('EVENT').AsInteger:=1 else
      if (Sender as Taction).Name='aLock' then
      FChangeOracleUserState.ParamByName('EVENT').AsInteger:=0;
FChangeOracleUserState.ExecProc;
finally
showmessage(FChangeOracleUserState.ParamByName('RESULT').AsString);
end;
end;

procedure TRefUserNamesForm.FormCreate(Sender: TObject);
var
oktel: TStringField;
tkol_oktel: TColumn;
begin
  inherited;
  if MainForm.FUseFilialBlockAccess then
    qMain.SQL.Append('WHERE UN.FILIAL_ID=' + IntToStr(MainForm.FFilial));


  tkol_oktel:=CRDBGrid1.Columns.Add;
  with tkol_oktel do
  begin
    Title.Caption:='Пользователь Октел';
    visible:=true;
    FieldName:='USER_NAME_OKTEL';
    ReadOnly:=false;
    Width:=80;
    title.font.Style:=[fsBold];
  end;
  qMainPASSWORD_OKTEL.OnGetText:=qMainPASSWORDGetText;
  tkol_oktel:=CRDBGrid1.Columns.Add;
  with tkol_oktel do
  begin
    Title.Caption:='Пароль Октел';
    visible:=true;
    FieldName:='PASSWORD_OKTEL';
    ReadOnly:=false;
    Width:=80;
    title.font.Style:=[fsBold];
  end;

end;

procedure TRefUserNamesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('USER_FIO').IsNull then
  begin
    MessageDlg('ФИО пользователя должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('USER_NAME').IsNull then
  begin
    MessageDlg('Имя пользователя Oracle должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end
  else if (qMain.State in [dsInsert]) and (Trim(DataSet.FieldByName('PASSWORD').AsString) = '') then
  begin
    MessageDlg('Пароль должен быть заполнен.', mtError, [mbOK], 0);
    Abort;
  end;
  // генерация нового ID не требуется
  //inherited;
end;

procedure TRefUserNamesForm.aPostExecute(Sender: TObject);
begin
//  try
    inherited;
//  except
//    on E:EOraError do begin
//    end;
//  end;
end;

procedure TRefUserNamesForm.qMainPASSWORDGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if DisplayText then
    Text := '**********'
  else
    Text := '';
end;

procedure TRefUserNamesForm.qMainPASSWORDSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  if mainform.encrypt_password then begin
    TStringField(sender).Value:=md5_30(text);
    qMainENCRYPT_PWD.value:=1;
    qMainENCRYPT_PWD_STR.value:='Да';
  end
  else TStringField(sender).Value:=text;

end;

end.
