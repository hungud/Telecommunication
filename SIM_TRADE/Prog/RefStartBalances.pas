unit RefStartBalances;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefStartBalancesForm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Main;

{$R *.dfm}

procedure TRefStartBalancesForm.FormCreate(Sender: TObject);
begin
  inherited;
  if MainForm.FUseFilialBlockAccess then
    qMain.SQL.Append('where GET_FILIAL_ID_BY_PHONE(PHONE_NUMBER) = ' + IntToStr(MainForm.FFilial));
end;

procedure TRefStartBalancesForm.qMainBeforePost(DataSet: TDataSet);
var
  YY, MM, DD : Word;
begin
  if DataSet.FieldByName('PHONE_NUMBER').IsNull then
  begin
    MessageDlg('Номер телефона должен быть заполнен.', mtError, [mbOK], 0);
    Abort;
  end;

  if DataSet.FieldByName('BALANCE_DATE').IsNull then
  begin
    MessageDlg('Дата баланса должна быть заполнена.', mtError, [mbOK], 0);
    Abort;
  end;

  DecodeDate(DataSet.FieldByName('BALANCE_DATE').AsDateTime, YY, MM, DD);
  if DD <> 1 then
  begin
    MessageDlg('Дату баланса можно вводить только на первое число месяца.', mtError, [mbOK], 0);
    Abort;
  end;

  if DataSet.FieldByName('BALANCE_VALUE').IsNull then
  begin
    MessageDlg('Сумма баланса должна быть заполнена.', mtError, [mbOK], 0);
    Abort;
  end;

  inherited;
end;

end.
