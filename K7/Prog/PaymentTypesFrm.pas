unit PaymentTypesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TPaymentTypesForm = class(TTemplateForm)
    qPROFIT_INCLUDING: TOraQuery;
    qMainPROFIT_INCLUDING_NAME: TStringField;
    qMainRECEIVED_PAYMENT_TYPE_ID: TFloatField;
    qMainRECEIVED_PAYMENT_TYPE_NAME: TStringField;
    qMainPROFIT_INCLUDING: TIntegerField;
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TPaymentTypesForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('RECEIVED_PAYMENT_TYPE_NAME').IsNull then
  begin
    MessageDlg('Ќаименование должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('PROFIT_INCLUDING').IsNull then
     DataSet.FieldByName('PROFIT_INCLUDING').AsFloat := 0;
  inherited;
end;

end.
