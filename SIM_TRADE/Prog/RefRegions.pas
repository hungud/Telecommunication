unit RefRegions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefRegionsForm = class(TTemplateForm)
    qIsDefault: TOraQuery;
    qCountries: TOraQuery;
    qMainREGION_ID: TFloatField;
    qMainREGION_NAME: TStringField;
    qMainORDER_NUMBER: TFloatField;
    qMainIS_DEFAULT: TIntegerField;
    qMainCOUNTRY_ID: TFloatField;
    qMainIS_DEFAULT_NAME: TStringField;
    qMainCOUNTRY_NAME: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure qMainAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TRefRegionsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('REGION_NAME').IsNull then
  begin
    MessageDlg('Наименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('COUNTRY_ID').IsNull then
  begin
    MessageDlg('Страна должна быть выбрана', mtError, [mbOK], 0);
    Abort;
  end;

  inherited;
end;

procedure TRefRegionsForm.qMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if DataSet.Active then
    DataSet.FieldByName('COUNTRY_ID').Value := GetDefaultCountry;
end;

end.
