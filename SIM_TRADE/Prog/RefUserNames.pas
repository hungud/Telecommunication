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
    pAccounts: TPanel;
    Splitter1: TSplitter;
    gUser_Acc: TCRDBGrid;
    Label1: TLabel;
    qUser_Accounts: TOraQuery;
    dsUser_Accounts: TDataSource;
    qUser_AccountsACCOUNT_ID: TFloatField;
    qUser_AccountsACCOUNT_NUMBER: TFloatField;
    qUser_AccountsUSERN: TFloatField;
    ImageList1: TImageList;
    qNamberAccounts: TOraQuery;
    qNamberAccountsUSER_NAME_ID: TFloatField;
    qNamberAccountsACCOUNT_ID: TFloatField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aPostExecute(Sender: TObject);
    procedure qMainPASSWORDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure qMainPASSWORDSetText(Sender: TField; const Text: string);
    procedure FormCreate(Sender: TObject);
    procedure aUnLockExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qMainAfterScroll(DataSet: TDataSet);
    procedure qUser_AccountsBeforeOpen(DataSet: TDataSet);
    procedure gUser_AccDblClick(Sender: TObject);
    procedure gUser_AccDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qNamberAccountsBeforeOpen(DataSet: TDataSet);
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

  if not (GetConstantValue('SERVER_NAME')='GSM_CORP') then exit  //только для GSM_CORP then
  else begin
    tkol_oktel:=CRDBGrid1.Columns.Add;
    with tkol_oktel do begin
     Title.Caption:='Пользователь Октел';
     visible:=true;
     FieldName:='USER_NAME_OKTEL';
     ReadOnly:=false;
     Width:=80;
     title.font.Style:=[fsBold];
    end;
    qMainPASSWORD_OKTEL.OnGetText:=qMainPASSWORDGetText;
    tkol_oktel:=CRDBGrid1.Columns.Add;
    with tkol_oktel do begin
     Title.Caption:='Пароль Октел';
     visible:=true;
     FieldName:='PASSWORD_OKTEL';
     ReadOnly:=false;
     Width:=80;
     title.font.Style:=[fsBold];
    end;
  end;
end;

procedure TRefUserNamesForm.FormShow(Sender: TObject);
begin
  inherited;
  //показываем/скрываем столбец обещанного платежа
  if (GetConstantValue('USE_PROMISED_PAYMENTS') = '1') then
    VisibleColumnByFieldName(CRDBGrid1, qMainMAX_PROMISED_PAYMENT.FieldName, true)
  else
    VisibleColumnByFieldName(CRDBGrid1, qMainMAX_PROMISED_PAYMENT.FieldName, false);

  //показываем/скрываем панель соотсветствия лицевых счетов
  pAccounts.Visible := (GetConstantValue('SHOW_USER_NAME_ACCOUNTS')='1');
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

procedure TRefUserNamesForm.qNamberAccountsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qNamberAccounts.ParamByName('pUSER_NAME_ID').AsInteger := qMainUSER_NAME_ID.AsInteger;
end;

procedure TRefUserNamesForm.qUser_AccountsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qUser_Accounts.ParamByName('pUSER_NAME_ID').AsInteger := qMainUSER_NAME_ID.AsInteger;
end;

procedure TRefUserNamesForm.gUser_AccDblClick(Sender: TObject);
var qS: TOraQuery;
    i: integer;
begin
  inherited;
  if TCRDBGrid(Sender).SelectedField.Name = qUser_AccountsUSERN.Name then //если щелкнули по полю доступности
  begin
    i := qUser_Accounts.RecNo;
    qUser_Accounts.DisableControls;

    qS := TOraQuery.Create(nil);
    try
      if qUser_AccountsUSERN.IsNull then //вставляем данные
        qS.SQL.Text := 'INSERT INTO USER_NAME_ACCOUNTS (USER_NAME_ID, ACCOUNT_ID) ' +
          ' VALUES (:pUSER_NAME_ID, :pACCOUNT_ID) '
      else
        qS.SQL.Text := 'DELETE FROM USER_NAME_ACCOUNTS WHERE USER_NAME_ID = :pUSER_NAME_ID ' +
          ' AND ACCOUNT_ID = :pACCOUNT_ID ';

      qS.ParamByName('pUSER_NAME_ID').AsInteger := qMainUSER_NAME_ID.AsInteger;
      qS.ParamByName('pACCOUNT_ID').AsInteger := qUser_AccountsACCOUNT_ID.AsInteger;

      qS.ExecSQL;
      //обновляем данные по соответствиям
      qUser_Accounts.Close;
      qUser_Accounts.Open;
      qNamberAccounts.Close;
      qNamberAccounts.Open;
    finally
      FreeANDNil(qS);
    end;

    qUser_Accounts.RecNo := i;
    qUser_Accounts.EnableControls;
  end;
end;

procedure TRefUserNamesForm.qMainAfterScroll(DataSet: TDataSet);
var
i: integer;
begin
  inherited;
  if (GetConstantValue('SHOW_USER_NAME_ACCOUNTS')='1') then
  begin
    if not qMain.IsEmpty then
    begin
      qUser_Accounts.Close;
      qUser_Accounts.Open;
      qNamberAccounts.Close;
      qNamberAccounts.Open;
    end;
  end;
end;

procedure TRefUserNamesForm.gUser_AccDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var Im1: TBitmap;
begin
  inherited;
  if Column.FieldName = qUser_AccountsUSERN.FieldName then
    if (qNamberAccounts.IsEmpty) or (not qUser_AccountsUSERN.IsNull) then
      with gUser_Acc.Canvas do
      begin
        Brush.Color := clWhite;
        FillRect(Rect);

        Im1 := TBitmap.Create;//создание
        try
          ImageList1.GetBitmap(0,Im1);
          Draw(round((Rect.Left+Rect.Right-Im1.Width)/2),Rect.Top,Im1);
        finally
          Im1.Free;
        end;
      end;
end;

end.
