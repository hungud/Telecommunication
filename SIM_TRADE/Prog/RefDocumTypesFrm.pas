unit RefDocumTypesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefDocumTypesForm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefDocumTypesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DOCUM_TYPE_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  inherited;
end;

end.
