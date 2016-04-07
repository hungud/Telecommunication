unit RefOperators;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefOperatorsForm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
  private                         
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  RefOperatorsForm: TRefOperatorsForm;

implementation

{$R *.dfm}

procedure TRefOperatorsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('OPERATOR_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

end.
