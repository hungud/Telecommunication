unit RefTurnTariffOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons,
  OraTransaction;

type
  TRefTurnTariffOptionsForm = class(TForm)
    ActionList1: TActionList;
    qGetNewId: TOraStoredProc;
    qMain: TOraQuery;
    CRDBGrid1: TCRDBGrid;
    qMainDELAYED_TURN_TO_ID: TFloatField;
    qMainPHONE_NUMBER: TStringField;
    qMainTASK_DATE: TDateTimeField;
    qMainUSER_NAME: TStringField;
    qTarffOptions: TOraQuery;
    qActionType: TOraQuery;
    qMainOPTION_CODE: TStringField;
    qMainOPTION_NAME: TStringField;
    qCheck: TOraQuery;
    qEdit: TOraQuery;
    Transaction: TOraTransaction;
    qDelete: TOraQuery;
    qMainACTION_TYPE: TIntegerField;
    qMainACTION_DATE: TDateTimeField;
    qMainDATE_LAST_UPDATED: TDateTimeField;
    qMainUSER_LAST_UPDATED: TStringField;
    aExcelExport: TAction;
    aLoadOptFromFile: TAction;
    qMainACTION_TYPE_NAME: TStringField;
    aAdd: TAction;
    aEdit: TAction;
    aDelete: TAction;
    ToolBar2: TToolBar;
    tbAdd: TToolButton;
    tbEdit: TToolButton;
    tbDelete: TToolButton;
    ToolButton19: TToolButton;
    tbRefresh: TToolButton;
    DataSource1: TDataSource;
    tbExcelExport: TToolButton;
    tbLoadFromFile: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure aExcelExportExecute(Sender: TObject);
    procedure aLoadOptFromFileExecute(Sender: TObject);
    procedure aAddExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
  end;

procedure DoTurnTariffOptions(const pPhoneNumber : String);

implementation

{$R *.dfm}

uses LoadTurnTariffOptArray, IntecExportGrid, uAddEditTurnTariffOpt;

procedure DoTurnTariffOptions(const pPhoneNumber : String);
var
  TurnTariffOptionsForm: TRefTurnTariffOptionsForm;
begin
  TurnTariffOptionsForm := TRefTurnTariffOptionsForm.Create(nil);
  Try
    TurnTariffOptionsForm.qMain.Open;
    //TurnTariffOptionsForm.qMain.insert;
    //TurnTariffOptionsForm.qMainPHONE_NUMBER.AsString:=pPhoneNumber;
    TurnTariffOptionsForm.ShowModal;
  Finally
    TurnTariffOptionsForm.Free;
  End;
end;

procedure TRefTurnTariffOptionsForm.aAddExecute(Sender: TObject);
begin
  if DoAddEditTurnTariffOpt('', '', -1, Now, -1) then
    qMain.Refresh;
end;

procedure TRefTurnTariffOptionsForm.aDeleteExecute(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    if mrOk = MessageDlg('Удалить текущую запись ?', mtConfirmation, [mbOK, mbCancel], 0) then
    begin
      Transaction.StartTransaction;
      qMain.Delete;
      Transaction.Commit;
    end;
  end;
end;

procedure TRefTurnTariffOptionsForm.aEditExecute(Sender: TObject);
begin
  if DoAddEditTurnTariffOpt(qMain.FieldByName('phone_number').AsString,
                            qMain.FieldByName('option_code').AsString,
                            qMain.FieldByName('ACTION_TYPE').AsInteger,
                            qMain.FieldByName('ACTION_DATE').AsDateTime,
                            qMain.FieldByName('DELAYED_TURN_TO_ID').AsInteger
                           ) then
    qMain.Refresh;
end;

procedure TRefTurnTariffOptionsForm.aExcelExportExecute(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Массовая загрузка заданий на отложеное подключение/отключение услуг.','',
      CRDBGrid1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefTurnTariffOptionsForm.aLoadOptFromFileExecute(Sender: TObject);
var
  RefForm : TLoadTurnTariffOptArrayForm;
begin
  RefForm := TLoadTurnTariffOptArrayForm.Create(Application);
  try
    RefForm.ShowModal;
  finally
    RefForm.Free;
  end;
  aRefreshExecute(nil);
end;

procedure TRefTurnTariffOptionsForm.aRefreshExecute(Sender: TObject);
begin
  if not qMain.Active then
    qMain.Open
  else
    qMain.Refresh;
end;

procedure TRefTurnTariffOptionsForm.FormShow(Sender: TObject);
begin
  if not (qMain.State in [dsInsert]) then
    if not qMain.Active then
      qMain.Open
    else
      qMain.Refresh;
end;

end.
