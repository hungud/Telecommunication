unit RefAccounts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,   Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefAccountsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure PasswordGetText(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefAccountsForm: TRefAccountsForm;

implementation

{$R *.dfm}

uses RefMobilOperator, RefFrmEdit, RefFilial;

procedure TRefAccountsForm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qAccounts;
  ListCls := TLCls.Create(TRefFilialForm, TRefMobilOperatorForm);
  inherited;
  CaptList.Add('Справочник филиалов');
  CaptList.Add('Справочник мобильных операторов');
  qRef.FieldByName('PASSWORD').OnGetText := PasswordGetText;
  qRef.OnDeleteError  := qRefDeleteError;
  qRef.OnPostError :=  qRefPostError;
end;

procedure TRefAccountsForm.PasswordGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if DisplayText then
    Text := '**********'
  else
    Text := '';
end;

procedure TRefAccountsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'PHONE_ON_ACCOUNTS_ACC_ID_F') then
  begin
    TimedMessageBox('Этот лицевой счет оператора связи соотнесен с телефоном.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

procedure TRefAccountsForm.qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if  ContainsText(E.Message,'UN_ACCOUNT_NUMBER') then
  begin
    Action := daAbort;
    TimedMessageBox('Такой номер счета уже есть! Укажите другой' , 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
  end;
end;


end.
