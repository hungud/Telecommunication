unit RefServices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefServicesForm = class(TTemplateForm)
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  RefServicesForm: TRefServicesForm;

implementation

{$R *.dfm}

procedure TRefServicesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('SERVICE_NAME').IsNull then
  begin
    MessageDlg('Наименование должено быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('PRICE').IsNull then
  begin
    MessageDlg('Цена должна быть заполнена', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

end.
