unit RefMaskBeauty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefMaskBeautyForm = class(TTemplateForm)
    qMainMASK_BEAUTY_ID: TFloatField;
    qMainPATTERN: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefMaskBeautyForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PATTERN').IsNull then
  begin
    MessageDlg('Маска должна быть заполнена!', mtError, [mbOK], 0);
    Abort;
  end;
  inherited;
end;

end.
