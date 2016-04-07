unit BlockPhoneWithDopStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction;

type
  TBlockPhoneWithDopStatusForm = class(TForm)
    vtChanges: TVirtualTable;
    dsChanges: TDataSource;
    ChangesGrid: TCRDBGrid;
    vtChangesPhoneNumber: TStringField;
    ToolBar: TToolBar;
    tbReport: TToolButton;
    tbBlock: TToolButton;
    ActionList: TActionList;
    aRefresh: TAction;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    vtChangesItog: TStringField;
    aExcel: TAction;
    tbImportExcel: TToolButton;
    vtChangesDopStatusName: TStringField;
    vtChangesDopStatusId: TIntegerField;
    tbClear: TToolButton;
    aClear: TAction;
    vtChangesIsActive: TIntegerField;
    vtChangesCommentClient: TStringField;
    aBlock: TAction;
    qReport: TOraQuery;
    LoaderBlockPhone: TOraStoredProc;
    tbStopBlock: TToolButton;
    aStop: TAction;
    LoaderUnlockPhone: TOraStoredProc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExcelExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aBlockExecute(Sender: TObject);
    procedure aStopExecute(Sender: TObject);
  private
    StopBlock: boolean;
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  BlockPhoneWithDopStatusForm: TBlockPhoneWithDopStatusForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main, ContractsRegistration_Utils;

procedure TBlockPhoneWithDopStatusForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TBlockPhoneWithDopStatusForm.aBlockExecute(Sender: TObject);
var
 DetailText:string;
 i:integer;
 qS: TOraQuery;
begin
  StopBlock:=false;
  tbBlock.Enabled:=false;
  tbImportExcel.Enabled:=false;
  tbClear.Enabled:=false;
  tbStopBlock.Enabled:=true;
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    if vtChangesItog.AsString = '' then
    begin
      DetailText:='';
      //Переблокировка, если неактивный номер
      if vtChangesIsActive.AsInteger <> 1 then
      begin
        qS := TOraQuery.Create(nil);
        try
          qS.SQL.Text := 'INSERT INTO QUEUE_PHONE_REBLOCK(PHONE_NUMBER) ' +
          ' VALUES (:PHONE_NUMBER) ';
          qS.ParamByName('PHONE_NUMBER').AsString := vtChangesPhoneNumber.AsString;
          qS.ExecSQL;
          //результат
          vtChanges.Edit;
          vtChangesItog.AsString:='Номер поставлен в очередь на переблок на сохранение';
        finally
          FreeANDNil(qS);
        end;
      end
      else //если номер активный блокируем на сохранение
      if (vtChangesIsActive.AsInteger = 1) then
      begin
        LoaderBlockPhone.ParamByName('pPHONE_NUMBER').AsString := vtChangesPhoneNumber.AsString;
        LoaderBlockPhone.ParamByName('pCODE').AsString := GetParamValue('BEELINE_BLOCK_CODE_FOR_BLOCK_SAVE');
        try
          LoaderBlockPhone.ExecProc;
          DetailText := LoaderBlockPhone.ParamByName('RESULT').AsString;
        except
          on E : Exception do
          begin
            DetailText := 'Ошибка блокировки.'#13#10 + E.Message;
          end;
        end;
        //результат
        vtChanges.Edit;
        if DetailText='' then
          vtChangesItog.AsString:='Операция выполнена успешно'
        else
          vtChangesItog.AsString:=DetailText;
      end;
    end;
    vtChanges.Next;
    inc(i);
    SetProgress(i);
    if StopBlock then break;
  end;
  tbReport.Enabled:=false;
  tbBlock.Enabled:=StopBlock;
  tbImportExcel.Enabled:=true;
  tbClear.Enabled:=true;
  tbStopBlock.Enabled:=false;
end;

procedure TBlockPhoneWithDopStatusForm.aClearExecute(Sender: TObject);
begin
  vtChanges.Clear;
  tbReport.Enabled:=true;
  tbBlock.Enabled:=false;
  tbImportExcel.Enabled:=false;
  SetProgress(0);
end;

procedure TBlockPhoneWithDopStatusForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Блокировка номеров с доп.статусом.','',
      ChangesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TBlockPhoneWithDopStatusForm.aRefreshExecute(Sender: TObject);
var
  i:integer;
begin
  tbReport.Enabled:=false;
  try
    qReport.Open;
    i:=0;
    ProgressBar.Max:=qReport.RecordCount;
    vtChanges.Open;
    while not qReport.Eof do begin
      vtChanges.Append;
      vtChangesPhoneNumber.AsString:=qReport.FieldByName('phone_number').AsString;
      vtChangesDopStatusName.AsString:=qReport.FieldByName('dop_status_name').AsString;
      vtChangesDopStatusId.AsInteger:=qReport.FieldByName('dop_status_id').AsInteger;
      vtChangesCommentClient.AsString:=qReport.FieldByName('comment_clent').AsString;
      vtChangesIsActive.AsInteger:=qReport.FieldByName('PHONE_IS_ACTIVE').AsInteger;
      vtChanges.Post;
      qReport.Next;
      inc(i);
      SetProgress(i);
    end;
  finally
    qReport.Close;
  end;
  tbBlock.Enabled:=true;
  tbImportExcel.Enabled:=true;
  tbClear.Enabled:=true;
end;

procedure TBlockPhoneWithDopStatusForm.aStopExecute(Sender: TObject);
begin
  StopBlock:=true;
end;

procedure TBlockPhoneWithDopStatusForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

end.
