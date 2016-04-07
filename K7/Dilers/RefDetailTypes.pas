unit RefDetailTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, ComCtrls, ToolWin,
  Menus, ActnList;

type
  TRefDetailTypesForm = class(TForm)
    ActionList: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    PopupMenu1: TPopupMenu;
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
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    grData: TCRDBGrid;
    dsMain: TDataSource;
    qMain: TOraQuery;
    qMainTYPE_CONNECTION: TStringField;
    qMainTYPE_CALL: TStringField;
    qMainCOMMENT_CALL: TStringField;
    qMainDILER_PAY: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure dsMainStateChange(Sender: TObject);
    procedure grDataDblClick(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function CheckPost: boolean;
  public
    { Public declarations }
  end;

var
  RefDetailTypesForm: TRefDetailTypesForm;

implementation

{$R *.dfm}

procedure TRefDetailTypesForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CheckPost then
    Action := caFree
  else
    Action := caNone;
end;

procedure TRefDetailTypesForm.FormShow(Sender: TObject);
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

function TRefDetailTypesForm.CheckPost : boolean;
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

procedure TRefDetailTypesForm.aInsertExecute(Sender: TObject);
begin
{  if qMain.Active then
  begin
    if CheckPost then
      qMain.Insert;
  end;  }
end;

procedure TRefDetailTypesForm.aEditExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if CheckPost then
      qMain.Edit;
  end;
end;

procedure TRefDetailTypesForm.aDeleteExecute(Sender: TObject);
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

procedure TRefDetailTypesForm.aRefreshExecute(Sender: TObject);
begin
  if CheckPost then
  begin
    if not qMain.Active then
      qMain.Open
    else
      qMain.Refresh;
  end;
end;

procedure TRefDetailTypesForm.aPostExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Post;
  end;
end;

procedure TRefDetailTypesForm.aCancelExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Cancel;
  end;
end;

procedure TRefDetailTypesForm.dsMainStateChange(Sender: TObject);
var vEnabled : boolean;
  vWriteEnabled : Boolean;
begin
  vEnabled := qMain.Active and (qMain.RecordCount > 0);
  vWriteEnabled := not grData.ReadOnly;

  aInsert.Enabled := vWriteEnabled and qMain.Active and not (qMain.State in [dsEdit, dsInsert]);
  aEdit.Enabled := vWriteEnabled and vEnabled and not (qMain.State in [dsEdit, dsInsert]);
  aDelete.Enabled := vWriteEnabled and vEnabled and not (qMain.State in [dsEdit, dsInsert]);
  aRefresh.Enabled := True;
  aPost.Enabled := vWriteEnabled and qMain.Active and (qMain.State in [dsEdit, dsInsert]);
  aCancel.Enabled := vWriteEnabled and qMain.Active and (qMain.State in [dsEdit, dsInsert]);
end;

procedure TRefDetailTypesForm.grDataDblClick(Sender: TObject);
begin
  if aEdit.Enabled then
    aEdit.Execute;
end;

procedure TRefDetailTypesForm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if aEdit.Enabled then
      aEdit.Execute;
  end;
end;

end.
