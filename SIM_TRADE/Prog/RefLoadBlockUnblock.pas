unit RefLoadBlockUnblock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, ActnList,
  Grids, DBGrids, CRGrid;

type
  TRefLoadBlockUnblockForm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    dsRef: TDataSource;
    qRef: TOraQuery;
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    cbFilter: TComboBox;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoRefLoadBlockUnblock;

var
  RefLoadBlockUnblockForm: TRefLoadBlockUnblockForm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, IntecExportGrid;

procedure DoRefLoadBlockUnblock;
var RefFrm : TRefLoadBlockUnblockForm;
    Sdvig:integer;
begin
  RefFrm:=TRefLoadBlockUnblockForm.Create(Nil);
  RefFrm.cbFilterChange(Nil);
  try
    // Отчет
    RefFrm.ShowModal;
  finally
    RefFrm.Free;
  end;
end;

procedure TRefLoadBlockUnblockForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Масовая блокировка/разблокировка','', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefLoadBlockUnblockForm.aRefreshExecute(Sender: TObject);
begin
  qRef.Close;
  qRef.Open;
end;

procedure TRefLoadBlockUnblockForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qRef.Active and (qRef.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qRef.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;

procedure TRefLoadBlockUnblockForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TRefLoadBlockUnblockForm.cbFilterChange(Sender: TObject);
begin
  qRef.ParamByName('success').AsInteger:=cbFilter.ItemIndex;
  aRefresh.Execute;
end;

end.
