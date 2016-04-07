unit RefTariffs_ivideon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefTariffsForm_Ivideon = class(TTemplateForm)
    qMainTARIFF_ID: TFloatField;
    qMainTARIFF_CODE: TStringField;
    qMainTARIFF_NAME: TStringField;
    qMainMONTHLY_COST: TFloatField;
    qMainIS_DAYLY_TARIFF: TFloatField;
    qMainCOST_COEEF: TFloatField;
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

procedure TRefTariffsForm_Ivideon.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('TARIFF_NAME').IsNull then
  begin
    MessageDlg('Наименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('TARIFF_CODE').IsNull then
  begin
    MessageDlg('Код должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('IS_DAYLY_TARIFF').IsNull then
    DataSet.FieldByName('IS_DAYLY_TARIFF').Value := 0;
  if qMain.FieldByName('COST_COEEF').IsNull then
    DataSet.FieldByName('COST_COEEF').Value := 0;
  //
  inherited;
end;

end.
