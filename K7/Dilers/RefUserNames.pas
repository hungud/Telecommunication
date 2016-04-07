unit RefUserNames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError;

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
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aPostExecute(Sender: TObject);
    procedure qMainPASSWORDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure qMainPASSWORDSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils,main;

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
