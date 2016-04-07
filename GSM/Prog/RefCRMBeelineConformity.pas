unit RefCRMBeelineConformity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefCRMBeelineConformityForm = class(TTemplateForm)
    qMainPHONE_NUMBER_TARIFER: TStringField;
    qMainPHONE_NUMBER_CLIENT: TStringField;
    qMainCONFORMITY_ID: TFloatField;
    qMainTYPE_CRM_BEELINE_ID: TFloatField;
    qTYPES_CRM_BEELINE: TOraQuery;
    qTYPES_CRM_BEELINEID: TFloatField;
    qTYPES_CRM_BEELINETYPE_NAME: TStringField;
    qMainTYPE_CRM_BEELINE_NAME: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefCRMBeelineConformityForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PHONE_NUMBER_TARIFER').IsNull then
  begin
    MessageDlg('Поле "Номер Билайн" должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('PHONE_NUMBER_CLIENT').IsNull then
  begin
    MessageDlg('Поле "Действительный номер" должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('TYPE_CRM_BEELINE_ID').IsNull then
  begin
    MessageDlg('Поле "Тип оплаты" должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
end;

end.
