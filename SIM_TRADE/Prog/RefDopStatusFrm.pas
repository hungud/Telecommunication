unit RefDopStatusFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefDopStatusForm = class(TTemplateForm)
    qMainDOP_STATUS_ID: TFloatField;
    qMainDOP_STATUS_NAME: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefDopStatusForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('DOP_STATUS_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  inherited;
end;

end.
