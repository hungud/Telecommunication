unit RefPhoneBlocks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, DB, Ora, ActnList, Menus, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefPhoneBlocksForm = class(TTemplateForm)
    qMainPHONE_BLOCK_ID: TFloatField;
    qMainOPERATOR_ID: TFloatField;
    qMainPHONE_NUMBER_BEGIN: TStringField;
    qMainPHONE_NUMBER_END: TStringField;
    qOperators: TOraQuery;
    qMainOPERATOR_NAME: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  TemplateForm1: TTemplateForm1;

implementation

{$R *.dfm}

procedure TRefPhoneBlocksForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PHONE_NUMBER_BEGIN').IsNull then
  begin
    MessageDlg('Начальный номер должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('PHONE_NUMBER_END').IsNull then
  begin
    MessageDlg('Конечный номер должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('OPERATOR_ID').IsNull then
  begin
    MessageDlg('Оператор должен быть выбран', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

end.
