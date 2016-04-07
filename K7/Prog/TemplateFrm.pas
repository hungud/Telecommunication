unit TemplateFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid,
  DBCtrls, OraError, ActnList, Menus, Main, ComCtrls,
  ToolWin, IntecGridUtils, ExecutingForm;

type
  TTemplateForm = class(TExecutingForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CRDBGrid1: TCRDBGrid;
    qMain: TOraQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    qGetNewId: TOraStoredProc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure CRDBGrid1DblClick(Sender: TObject);
    procedure CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  protected
    function CheckPost : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TTemplateForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CheckPost then
    Action := caFree
  else
    Action := caNone;
end;

procedure TTemplateForm.FormShow(Sender: TObject);
var vMessage : String;
begin
  try
    aRefresh.Execute;
  except
    on E: exception do
    begin
      vMessage := e.Message;
      MessageDlg(PChar(vMessage), mtError, [mbOK], 0);
      Close;
    end;
  end;
end;

function TTemplateForm.CheckPost : boolean;
var vRes : Integer;
begin
  Result := True;
  if qMain.Active and (qMain.State in [dsEdit, dsInsert]) then
  begin
    vRes := MessageDlg('Сохранить изменения ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mrYes = vRes then
      qMain.Post
    else if mrNo = vRes then
      qMain.Cancel;

    Result := (vRes <> mrCancel);
  end;
end;

procedure TTemplateForm.aInsertExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if CheckPost then
      qMain.Insert;
  end;
end;

procedure TTemplateForm.aEditExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if CheckPost then
      qMain.Edit;
  end;
end;

procedure TTemplateForm.aDeleteExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if CheckPost then
    begin
      if mrOk = MessageDlg('Удалить текущую запись ?', mtConfirmation, [mbOK, mbCancel], 0) then
        qMain.Delete;
    end;
  end;
end;

procedure TTemplateForm.aRefreshExecute(Sender: TObject);
begin
  if CheckPost then
  begin
    if not qMain.Active then
      qMain.Open
    else
      qMain.Refresh;
  end;
end;

procedure TTemplateForm.aPostExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Post;
  end;
end;

procedure TTemplateForm.aCancelExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Cancel;
  end;
end;

procedure TTemplateForm.DataSource1StateChange(Sender: TObject);
var vEnabled : boolean;
  vWriteEnabled : Boolean;
begin
  vEnabled := qMain.Active and (qMain.RecordCount > 0);
  vWriteEnabled := not CRDBGrid1.ReadOnly;

  aInsert.Enabled := vWriteEnabled and qMain.Active and not (qMain.State in [dsEdit, dsInsert]);
  aEdit.Enabled := vWriteEnabled and vEnabled and not (qMain.State in [dsEdit, dsInsert]);
  aDelete.Enabled := vWriteEnabled and vEnabled and not (qMain.State in [dsEdit, dsInsert]);
  aRefresh.Enabled := True;
  aPost.Enabled := vWriteEnabled and qMain.Active and (qMain.State in [dsEdit, dsInsert]);
  aCancel.Enabled := vWriteEnabled and qMain.Active and (qMain.State in [dsEdit, dsInsert]);
end;

procedure TTemplateForm.qMainBeforePost(DataSet: TDataSet);
begin
  if qMain.Active and (qMain.State in [dsInsert]) then
  begin
    qGetNewId.ExecSQL;
    if qMain.KeyFields <> '' then
      qMain.FieldByName(qMain.KeyFields).Value := qGetNewId.ParamByName('RESULT').Value;
  end;
end;

procedure TTemplateForm.CRDBGrid1DblClick(Sender: TObject);
begin
  if aEdit.Enabled then
    aEdit.Execute;
end;

procedure TTemplateForm.CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if aEdit.Enabled then
      aEdit.Execute;
  end;
end;

end.
