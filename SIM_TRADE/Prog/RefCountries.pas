unit RefCountries;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefCountriesForm = class(TTemplateForm)
    qMainCOUNTRY_NAME: TStringField;
    qMainIS_DEFAULT: TIntegerField;
    qMainCOUNTRY_ID: TFloatField;
    qIsDefault: TOraQuery;
    qMainIS_DEFAULT_NAME: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefCountriesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('COUNTRY_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;

  inherited;
end;

end.
