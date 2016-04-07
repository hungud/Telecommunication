unit RefContractCancelTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefContractCancelTypesForm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  RefContractCancelTypesForm: TRefContractCancelTypesForm;

implementation

{$R *.dfm}

procedure TRefContractCancelTypesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('CONTRACT_CANCEL_TYPE_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

end.
