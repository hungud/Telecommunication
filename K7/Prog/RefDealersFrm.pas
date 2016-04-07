unit RefDealersFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefDealersForm = class(TTemplateForm)
    qMainDEALER_KOD: TFloatField;
    qMainPATTERN: TStringField;
    qMainDEALER_NAME: TStringField;
    qMainREPLACEMENT: TStringField;
    qMainSENDER_NAME: TStringField;
    qMainWELCOME_SMS: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefDealersForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DEALER_KOD').IsNull then
  begin
    MessageDlg('Код дилера должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('PATTERN').IsNull then
  begin
    MessageDlg('Шаблон должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('REPLACEMENT').IsNull then
  begin
    MessageDlg('Замена должна быть заполнена', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('SENDER_NAME').IsNull then
  begin
    MessageDlg('Требуется указать СМС-псевдоним', mtError, [mbOK], 0);
    Abort;
  end;
  inherited;
end;

end.
