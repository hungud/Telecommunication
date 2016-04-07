unit LoadInactivePhoneLessCont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction;

type
  TLoadInactivePhoneLessContForm = class(TForm)
    vtChanges: TVirtualTable;
    dsChanges: TDataSource;
    ChangesGrid: TCRDBGrid;
    vtChangesPhoneNumber: TStringField;
    ToolBar: TToolBar;
    tbAddPhones: TToolButton;
    tbAddChanges: TToolButton;
    ActionList: TActionList;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    aFileOpen: TAction;
    qAddChange: TOraQuery;
    OpenDialog: TOpenDialog;
    aAddChanges: TAction;
    aClear: TAction;
    Transaction: TOraTransaction;
    vtChangesSystem_Billing: TIntegerField;
    vtChangesSim_Number: TStringField;
    vtChangesDop_Info: TStringField;
    vtChangesPaid: TIntegerField;
    vtChangesPrice: TIntegerField;
    vtChangesItog: TStringField;
    tbClear: TToolButton;
    procedure aFileOpenExecute(Sender: TObject);
    procedure aAddChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aClearExecute(Sender: TObject);
  private
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  LoadInactivePhoneLessContForm: TLoadInactivePhoneLessContForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main;

procedure TLoadInactivePhoneLessContForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TLoadInactivePhoneLessContForm.aAddChangesExecute(Sender: TObject);
var i, vRes: integer;
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
        qAddChange.ParamByName('PHONE_NUMBER').AsString:= vtChangesPhoneNumber.AsString;
        qAddChange.ParamByName('SIM_NUMBER').AsFloat:= Strtofloat(vtChangesSim_Number.AsString);
        qAddChange.ParamByName('SYSTEM_BILLING').AsInteger:= vtChangesSystem_Billing.AsInteger;
        qAddChange.ParamByName('DOP_INFO').AsString:= vtChangesDop_Info.AsString;
        qAddChange.ParamByName('PAID').AsInteger:= vtChangesPaid.AsInteger;
        qAddChange.ParamByName('PRICE').AsInteger:= vtChangesPrice.AsInteger;

        qAddChange.ExecSQL;
        vtChanges.Edit;
        vtChangesItog.AsString:='Загружено успешно.';
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

procedure TLoadInactivePhoneLessContForm.aClearExecute(Sender: TObject);
begin
  vtChanges.Clear;
  tbAddPhones.Enabled:=true;
  tbAddChanges.Enabled:=false;
  tbClear.Enabled:=false;
end;

procedure TLoadInactivePhoneLessContForm.aFileOpenExecute(Sender: TObject);
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
      vtChangesPhoneNumber.AsString:=Excel.Cells[i, 1];
      vtChangesSim_Number.AsString:=Excel.Cells[i, 2];
      if uppercase(Excel.Cells[i, 3])='PREPAID' then vtChangesSystem_Billing.AsInteger:=1
      else if uppercase(Excel.Cells[i, 3])='POSTPAID' then vtChangesSystem_Billing.AsInteger:=2
      else if VarToStr(Excel.Cells[i, 3]) <> '' then  vtChangesItog.AsString:='Ошибка: системы расчетов нет в справочнике';
      vtChangesDop_Info.AsString:=Excel.Cells[i, 4];
      vtChangesPaid.AsInteger:=Excel.Cells[i, 5];
      vtChangesPrice.AsInteger:=Excel.Cells[i, 6];
      vtChanges.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbAddPhones.Enabled:=false;
    tbAddChanges.Enabled:=true;
    tbClear.Enabled:=true;
  end;
end;

procedure TLoadInactivePhoneLessContForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

end.
