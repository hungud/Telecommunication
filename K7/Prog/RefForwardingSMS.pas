unit RefForwardingSMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, ComCtrls, ToolWin, DB, MemDS, DBAccess, Ora,
  ActnList;

type
  TRefForwardingSMSForm = class(TForm)
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    dsMain: TDataSource;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    CRDBGrid1: TCRDBGrid;
    qMain: TOraQuery;
    qMainPHONE_NUMBER: TStringField;
    qMainPHONE_NUMBER_RECIPIENT: TStringField;
    qMainFORWARDING_ENABLE: TFloatField;
    qMainSMS_TEXT_ADD: TStringField;
    qMainDATE_LAST_UPDATE: TDateTimeField;
    qMainUSER_LAST_UPDATE: TStringField;
    procedure FormShow(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
  private
  protected
    function CheckPost : boolean;
  public
    { Public declarations }
  end;

var
  RefForwardingSMSForm: TRefForwardingSMSForm;

implementation

{$R *.dfm}

procedure TRefForwardingSMSForm.aCancelExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Cancel;
  end;
end;

procedure TRefForwardingSMSForm.aDeleteExecute(Sender: TObject);
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

procedure TRefForwardingSMSForm.aEditExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if CheckPost then
      qMain.Edit;
  end;
end;

procedure TRefForwardingSMSForm.aInsertExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if CheckPost then
      qMain.Insert;
  end;
end;

procedure TRefForwardingSMSForm.aPostExecute(Sender: TObject);
begin
  if qMain.Active then
  begin
    if qMain.State in [dsEdit, dsInsert] then
      qMain.Post;
  end;
end;

procedure TRefForwardingSMSForm.aRefreshExecute(Sender: TObject);
begin
  if CheckPost then
  begin
    if not qMain.Active then
      qMain.Open
    else
      qMain.Refresh;
  end;
end;

function TRefForwardingSMSForm.CheckPost : boolean;
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

procedure TRefForwardingSMSForm.FormShow(Sender: TObject);
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

end.
