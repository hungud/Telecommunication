unit RefRoamingProviders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemplateFrm, Ora, Vcl.ActnList,
  Vcl.Menus, Data.DB, MemDS, DBAccess, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TfrmRefRoamingProviders = class(TTemplateForm)
    qMainROAMING_PROVIDER_CODE: TStringField;
    qMainCOUNTRY_CODE: TFloatField;
    qMainDAMPS_PROV_NAME: TStringField;
    qMainROAMING_PROVIDER_ID: TFloatField;
    qRoamingTypes: TOraQuery;
    qMainROAMING_TYPE_ID: TFloatField;
    qMainROAMING_TYPE_NAME: TStringField;
    ToolButton9: TToolButton;
    aExcelExport: TAction;
    qRoamingTypesROAMING_TYPE_ID: TFloatField;
    qRoamingTypesROAMING_TYPE_NAME: TStringField;
    procedure aExcelExportExecute(Sender: TObject);
    procedure qMainBeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses IntecExportGrid;

procedure TfrmRefRoamingProviders.aExcelExportExecute(Sender: TObject);
begin
  inherited;
  ExportDBGridToExcel('Справочник "Роуминг-операторы"', '', CRDBGrid1, False, FALSE);
end;

procedure TfrmRefRoamingProviders.qMainBeforeInsert(DataSet: TDataSet);
begin
  //запрещаем добавление строки вручную
  Abort;
end;

end.
