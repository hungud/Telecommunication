unit ChangeDopStatusArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction;

type
  TChangeDopStatusArrayForm = class(TForm)
    vtChanges: TVirtualTable;
    dsChanges: TDataSource;
    ChangesGrid: TCRDBGrid;
    vtChangesPhoneNumber: TStringField;
    vtChangesContractId: TIntegerField;
    vtChangesContractDate: TDateTimeField;
    vtChangesFIO: TStringField;
    ToolBar: TToolBar;
    tbAddPhones: TToolButton;
    tbCheckContract: TToolButton;
    tbAddChanges: TToolButton;
    ActionList: TActionList;
    aFindContract: TAction;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    lFilial: TLabel;
    aFileOpen: TAction;
    qCheckDopStatus: TOraQuery;
    qAddChange: TOraQuery;
    qCheckContract: TOraQuery;
    qCheckContractCONTRACT_ID: TFloatField;
    qCheckContractCONTRACT_DATE: TDateTimeField;
    qCheckContractFIO: TStringField;
    OpenDialog: TOpenDialog;
    vtChangesItog: TStringField;
    aAddChanges: TAction;
    aExcel: TAction;
    tbImportExcel: TToolButton;
    vtChangesDopStatusName: TStringField;
    vtChangesDopStatusId: TIntegerField;
    tbCheckDopStatus: TToolButton;
    aFindStatus: TAction;
    qCheckDopStatusDOP_STATUS_ID: TFloatField;
    qCheckDopStatusDOP_STATUS_NAME: TStringField;
    ToolButton1: TToolButton;
    aClear: TAction;
    Transaction: TOraTransaction;
    qCheckChanges: TOraQuery;
    qCheckBalance: TOraQuery;
    qCheckBalanceBALANCE: TFloatField;
    qCheckBalancePOROG: TFloatField;
    qCheckContractCURRENT_DOP_STATUS: TStringField;
    vtChangesCurrentDopStatus: TStringField;
    vtChangesCurrentDopStatusId: TIntegerField;
    qCheckContractCURRENT_DOP_STATUS_ID: TFloatField;
    procedure aFileOpenExecute(Sender: TObject);
    procedure aFindContractExecute(Sender: TObject);
    procedure aAddChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExcelExecute(Sender: TObject);
    procedure aFindStatusExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
  private
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  ChangeDopStatusArrayForm: TChangeDopStatusArrayForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main;

procedure TChangeDopStatusArrayForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TChangeDopStatusArrayForm.aAddChangesExecute(Sender: TObject);
var count, i, vRes: integer;
begin
  Transaction.StartTransaction;
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    if Pos('Ошибка:', vtChangesItog.AsString) = 0 then
    begin
      try
        qAddChange.Close;
        qAddChange.ParamByName('CONTRACT_ID').AsInteger:= vtChangesContractId.AsInteger;
        qAddChange.ParamByName('DOP_STATUS').AsInteger:= vtChangesDopStatusId.AsInteger;
        qCheckChanges.Close;
        qCheckChanges.ParamByName('CONTRACT_ID').AsInteger:=
          qAddChange.ParamByName('CONTRACT_ID').AsInteger;
        qCheckChanges.Open;
        if qCheckChanges.FieldByName('DOP_STATUS').asInteger = vtChangesCurrentDopStatusId.AsInteger then
        begin
          qAddChange.ExecSQL;
          vtChanges.Edit;
          vtChangesItog.AsString:='Статус изменен успешно.';
        end else
        begin
          vtChanges.Edit;
          vtChangesItog.AsString:='Ошибка: текущий доп.статус неверен.';
        end;
      except
        vtChanges.Edit;
        vtChangesItog.AsString:='Ошибка.';
      end;
    end;
    vtChanges.Next;
    inc(i);
    SetProgress(i);
  end;
  vRes := MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if vRes=mrYes
    then Transaction.Commit
    else Transaction.Rollback;
  if vtChanges.RecordCount > 0 then
    tbAddChanges.Enabled:=false;
end;

procedure TChangeDopStatusArrayForm.aClearExecute(Sender: TObject);
begin
  vtChanges.Clear;
  tbAddPhones.Enabled:=true;
  tbCheckDopStatus.Enabled:=false;
  tbCheckContract.Enabled:=false;
  tbAddChanges.Enabled:=false;
end;

procedure TChangeDopStatusArrayForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Массовая смена доп.статусов','',
      ChangesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TChangeDopStatusArrayForm.aFileOpenExecute(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
begin
  if OpenDialog.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(OpenDialog.FileName);
    i := 1;
    vtChanges.Open;
    while VarToStr(Excel.Cells[i, 1]) <> '' do
    begin
      vtChanges.Append;
      if VarToStr(Excel.Cells[i, 1]) <> '' then
        vtChangesPhoneNumber.AsString:=Excel.Cells[i, 1];
        vtChangesDopStatusName.AsString:=Excel.Cells[i, 2];
      vtChanges.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbAddPhones.Enabled:=false;
    tbCheckDopStatus.Enabled:=true;
  end;
end;

procedure TChangeDopStatusArrayForm.aFindContractExecute(Sender: TObject);
var i: integer;
begin
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    qCheckContract.Close;
    qCheckContract.ParamByName('PHONE_NUMBER').AsString:=vtChangesPhoneNumber.AsString;
    qCheckContract.Open;
    if (qCheckContract.RecordCount = 1) and (Length(vtChangesItog.AsString) = 0) then
    begin
      vtChanges.Edit;
      vtChangesContractId.AsInteger:=qCheckContractCONTRACT_ID.AsInteger;
      vtChangesContractDate.AsDateTime:=qCheckContractCONTRACT_DATE.AsDateTime;
      vtChangesCurrentDopStatus.asString:=qCheckContractCurrent_dop_status.AsString;
      vtChangesCurrentDopStatusId.asInteger:=qCheckContractCurrent_dop_status_id.AsInteger;
      vtChangesFIO.AsString:=qCheckContractFIO.AsString;
    end else
    begin
      vtChanges.Edit;
      if Length(vtChangesItog.AsString) = 0 then
        if qCheckContract.RecordCount = 0
          then vtChangesItog.AsString:= 'Ошибка: на этот номер нет договора.'
          else vtChangesItog.AsString:= 'Ошибка: на этот номер несколько открытых договоров.';
      vtChangesContractId.Clear;
      vtChangesContractDate.Clear;
      vtChangesFIO.Clear;
    end;
    vtChanges.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbCheckContract.Enabled:=false;
    tbAddChanges.Enabled:=true;
  end;
end;

procedure TChangeDopStatusArrayForm.aFindStatusExecute(Sender: TObject);
var i: integer;
begin
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    qCheckDopStatus.Close;
    qCheckDopStatus.ParamByName('pDOP_STATUS_NAME').AsString:=vtChangesDopStatusName.AsString;
    qCheckDopStatus.Open;
    if (qCheckDopStatus.RecordCount = 1) and (Length(vtChangesItog.AsString) = 0) then
    begin
      vtChanges.Edit;
      vtChangesDopStatusId.AsInteger:=qCheckDopStatusDOP_STATUS_ID.AsInteger;
    end else
    begin
      vtChanges.Edit;
      if Length(vtChangesItog.AsString) = 0 then
        if qCheckDopStatus.RecordCount = 0
          then vtChangesItog.AsString:= 'Ошибка: этого статуса не существует.'
          else vtChangesItog.AsString:= 'Ошибка: для этого статуса несколько записей в справочнике.';
      vtChangesDopStatusId.Clear;
    end;
    vtChanges.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbCheckDopStatus.Enabled:=false;
    tbCheckContract.Enabled:=true;
  end;
end;

procedure TChangeDopStatusArrayForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

end.
