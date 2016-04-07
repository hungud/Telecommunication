unit RefContractGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError, StdCtrls,
  Buttons, sRadioButton, sGroupBox;

type
  TRefContractGroupsForm = class(TTemplateForm)
    Oracle1: TMenuItem;
    aShowGroupStat: TAction;
    BitBtn1: TBitBtn;
    ToolButton9: TToolButton;
    qMainGROUP_ID: TFloatField;
    qMainGROUP_NAME: TStringField;
    qMainBALANCE: TFloatField;
    qMainCNT: TFloatField;
    qGROUPS_SIGN: TOraQuery;
    qMainSIGN_NAME: TStringField;
    qMainSIGN_ID: TFloatField;
    sGroupBox2: TsGroupBox;
    RBActive: TsRadioButton;
    RBAll: TsRadioButton;
    qUserCheckAllow: TOraQuery;
    qMainCopy: TOraQuery;
    FloatField1: TFloatField;
    StringField1: TStringField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    StringField2: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aShowGroupStatExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qMainBeforeOpen(DataSet: TDataSet);
    procedure RBActiveClick(Sender: TObject);
    procedure RBAllClick(Sender: TObject);

  private
    { Private declarations }
    pSIGN_ID:integer;
  public
    { Public declarations }
    myOraSession: TOraSession;
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, ShowGroupStat, DMUnit;

procedure TRefContractGroupsForm.aShowGroupStatExecute(Sender: TObject);
begin
  DoShowGroupStat(qMainGROUP_ID.AsInteger,qMainGROUP_NAME.AsString);
end;


procedure TRefContractGroupsForm.FormCreate(Sender: TObject);
begin
 //inherited;
 myOraSession := Dm.OraSession;
 qUserCheckAllow.Close;
 qUserCheckAllow.ParamByName('USER_NAME').AsString := myOraSession.Username;
 qUserCheckAllow.open;
 pSIGN_ID:=qUserCheckAllow.FieldByName('ORGANIZATION_ID').AsInteger;
 if pSIGN_ID = 0 then  // Из-за роли copr_mobile ее нет в таблице user_names
   pSIGN_ID := 3;
end;

procedure TRefContractGroupsForm.qMainBeforeOpen(DataSet: TDataSet);
begin
 if RBActive.Checked = True then
   begin
   if pSIGN_ID <> 3 then
       qMain.SQL.Append('WHERE c_b.group_id = g.group_id and not exists (select 1 from CONTRACT_CANCELS cc where CC.CONTRACT_ID = C_B.CONTRACT_ID) AND G.SIGN_ID = '+inttostr(pSIGN_ID)+' group by g.group_id, g.group_name, G.SIGN_ID')
       else
       qMain.SQL.Append('WHERE c_b.group_id = g.group_id and not exists (select 1 from CONTRACT_CANCELS cc where CC.CONTRACT_ID = C_B.CONTRACT_ID) group by g.group_id, g.group_name, G.SIGN_ID')
   end
   else
   begin
     if pSIGN_ID <> 3 then
       qMain.SQL.Append('WHERE c_b.group_id = g.group_id AND G.SIGN_ID = '+inttostr(pSIGN_ID)+' group by g.group_id, g.group_name, G.SIGN_ID')
       else
       qMain.SQL.Append('WHERE c_b.group_id = g.group_id group by g.group_id, g.group_name, G.SIGN_ID')
 end;
end;

procedure TRefContractGroupsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('GROUP_NAME').IsNull then
  begin
    MessageDlg('Название группы должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  if DataSet.FieldByName('SIGN_ID').IsNull then
  begin
    MessageDlg('Признак юр. лица должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end;
  // генерация нового ID не требуется
  //inherited;
end;

procedure TRefContractGroupsForm.RBActiveClick(Sender: TObject);
begin
  qMain.Close;
  qMain.SQL.Text := qMainCopy.SQL.Text;
  qMain.open;

end;

procedure TRefContractGroupsForm.RBAllClick(Sender: TObject);
begin
  qMain.Close;
  qMain.SQL.Text := qMainCopy.SQL.Text;
  qMain.open;
end;

end.
