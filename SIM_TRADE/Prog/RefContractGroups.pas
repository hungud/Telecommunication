unit RefContractGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError, StdCtrls,
  Buttons;

type
  TRefContractGroupsForm = class(TTemplateForm)
    Oracle1: TMenuItem;
    aShowGroupStat: TAction;
    qMainGROUP_ID: TFloatField;
    qMainGROUP_NAME: TStringField;
    BitBtn1: TBitBtn;
    ToolButton9: TToolButton;
    qMainBALANCE: TFloatField;
    qMainCNT: TFloatField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aShowGroupStatExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, ShowGroupStat;

procedure TRefContractGroupsForm.aShowGroupStatExecute(Sender: TObject);
begin
  DoShowGroupStat(qMainGROUP_ID.AsInteger,qMainGROUP_NAME.AsString);
end;


procedure TRefContractGroupsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('GROUP_NAME').IsNull then
  begin
    MessageDlg('Название группы должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  // генерация нового ID не требуется
  //inherited;
end;

end.
