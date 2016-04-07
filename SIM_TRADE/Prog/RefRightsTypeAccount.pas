unit RefRightsTypeAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError, StdCtrls;

type
  TRefRightsTypeAccountForm = class(TTemplateForm)
    qMainID: TFloatField;
    qMainRIGHTS_TYPE: TFloatField;
    qAccount: TOraTable;
    qRightNames: TOraQuery;
    qMainRIGHT_NAME: TStringField;
    Panel3: TPanel;
    Label1: TLabel;
    cbRightNames: TComboBox;
    qMainACCOUNT_ID: TFloatField;
    qMainLOGIN: TStringField;
    procedure FormShow(Sender: TObject);
    procedure cbRightNamesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


procedure TRefRightsTypeAccountForm.cbRightNamesChange(Sender: TObject);
var
  RightName:integer;
begin
//  inherited;
  if cbRightNames.ItemIndex >= 0 then
    RightName := Integer(cbRightNames.Items.objects[cbRightNames.ItemIndex])
  else RightName:=0;
  if RightName<>0 then
  begin
    qMain.ParamByName('RIGHTS_TYPE').asInteger := RightName;
  end else
  begin
    qMain.ParamByName('RIGHTS_TYPE').Clear;
  end;
  qMain.close;
  qMain.open;
end;

procedure TRefRightsTypeAccountForm.FormShow(Sender: TObject);
begin
  inherited;
  qrightnames.open;
  cbRightNames.Items.AddObject('Все', Pointer(0));
  while not qRightNames.EOF do
    begin
      cbRightNames.Items.AddObject(
       qRightNames.FieldByName('RIGHT_NAME').AsString,
       Pointer(qRightNames.FieldByName('RIGHT_ID').AsInteger)
      );
      qRightNames.Next;
    end;
//  qRightNames.Close;
end;

end.
