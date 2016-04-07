unit ChangeTariffArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction;

type
  TChangeTariffArrayForm = class(TForm)
    vtChanges: TVirtualTable;
    dsChanges: TDataSource;
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
    cbFilial: TComboBox;
    qCheckTariff: TOraQuery;
    qFilials: TOraQuery;
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
    vtChangesTariffName: TStringField;
    vtChangesTariffId: TIntegerField;
    vtChangesChangeDate: TDateField;
    vtChangesChangePayment: TFloatField;
    tbCheckTariff: TToolButton;
    aFindTariff: TAction;
    qCheckTariffTARIFF_ID: TFloatField;
    qCheckTariffTARIFF_NAME: TStringField;
    ToolButton1: TToolButton;
    aClear: TAction;
    Transaction: TOraTransaction;
    qCheckChanges: TOraQuery;
    tbCheckBalance: TToolButton;
    qCheckBalance: TOraQuery;
    aFindBalance: TAction;
    qCheckBalanceBALANCE: TFloatField;
    qCheckBalancePOROG: TFloatField;
    vtChangesChangePaymentReverseschet: TFloatField;
    qAddReversePayment: TOraQuery;
    qCheckActive: TOraQuery;
    spSendSms: TOraStoredProc;
    ChangesGrid: TCRDBGrid;
    procedure aFileOpenExecute(Sender: TObject);
    procedure aFindContractExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aAddChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExcelExecute(Sender: TObject);
    procedure aFindTariffExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aFindBalanceExecute(Sender: TObject);
  private
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  ChangeTariffArrayForm: TChangeTariffArrayForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main, ContractsRegistration_Utils;

procedure TChangeTariffArrayForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TChangeTariffArrayForm.aAddChangesExecute(Sender: TObject);
var count, i, vRes: integer;
begin
  Transaction.StartTransaction;
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  qAddChange.ParamByName('FILIAL_ID').AsInteger:=
    Integer(cbFilial.Items.objects[cbFilial.ItemIndex]);
  qcheckChanges.ParamByName('FILIAL_ID').AsInteger:=
    qAddChange.ParamByName('FILIAL_ID').AsInteger;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    if Pos('Ошибка:', vtChangesItog.AsString) = 0 then
    begin
      try
     // INSERT INTO CONTRACT_CHANGES(CONTRACT_ID, FILIAL_ID, CONTRACT_CHANGE_DATE, SUM_GET, TARIFF_ID, DOCUM_TYPE_ID)
     // VALUES(:CONTRACT_ID, :FILIAL_ID, TRUNC(:DATE_CHANGE), :SUM_GET, :NEW_TARIFF_ID, 4)
        qAddChange.ParamByName('CONTRACT_ID').AsInteger:= vtChangesContractId.AsInteger;
        qAddChange.ParamByName('DATE_CHANGE').AsDateTime:= vtChangesChangeDate.AsDateTime;
        qAddChange.ParamByName('SUM_GET').AsFloat:= vtChangesChangePayment.AsFloat;
        qAddChange.ParamByName('NEW_TARIFF_ID').AsInteger:= vtChangesTariffId.AsInteger;
        qCheckChanges.ParamByName('CONTRACT_ID').AsInteger:=
          qAddChange.ParamByName('CONTRACT_ID').AsInteger;
        qCheckChanges.ParamByName('DATE_CHANGE').AsDateTime:=
          qAddChange.ParamByName('DATE_CHANGE').AsDateTime;
        qCheckChanges.ParamByName('SUM_GET').AsFloat:=
          qAddChange.ParamByName('SUM_GET').AsFloat;
        qCheckChanges.ParamByName('NEW_TARIFF_ID').AsInteger:=
          qAddChange.ParamByName('NEW_TARIFF_ID').AsInteger;

        qCheckChanges.Close;
        qCheckChanges.Open;
        if qCheckChanges.RecordCount = 0 then
        begin
          qAddChange.ExecSQL;
          vtChanges.Edit;
          vtChangesItog.AsString:='ТП изменен успешно.';
        end else
        begin
          vtChanges.Edit;
          vtChangesItog.AsString:='Ошибка: данная смена тарифа уже оформлена.';
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
  begin
    tbAddChanges.Enabled:=false;
    tbCheckBalance.Enabled:=true;
  end;
end;

procedure TChangeTariffArrayForm.aClearExecute(Sender: TObject);
begin
  vtChanges.Clear;
  tbAddPhones.Enabled:=true;
  tbCheckTariff.Enabled:=false;
  tbCheckContract.Enabled:=false;
  tbAddChanges.Enabled:=false;
end;

procedure TChangeTariffArrayForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Массовая смена ТП','',
      ChangesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TChangeTariffArrayForm.aFileOpenExecute(Sender: TObject);
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
        vtChangesTariffName.AsString:=Excel.Cells[i, 2];
        vtChangesChangeDate.AsString:=Excel.Cells[i, 3];
        if Length(Excel.Cells[i, 4]) > 0
          then vtChangesChangePayment.AsFloat:=StrToFloat(Excel.Cells[i, 4])
          else vtChangesChangePayment.AsFloat:=0;
        if Length(Excel.Cells[i, 5]) > 0
          then vtChangesChangePaymentReverseschet.AsFloat:=StrToFloat(Excel.Cells[i, 5])
          else vtChangesChangePaymentReverseschet.AsFloat:=0;
      vtChanges.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbAddPhones.Enabled:=false;
    tbCheckTariff.Enabled:=true;
  end;
end;

procedure TChangeTariffArrayForm.aFindBalanceExecute(Sender: TObject);
var i: integer;
begin
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    qCheckBalance.Close;
    qCheckBalance.ParamByName('PHONE_NUMBER').AsString:=vtChangesPhoneNumber.AsString;
    qCheckBalance.Open;
    if (qCheckBalance.RecordCount = 1) and (vtChangesItog.AsString='ТП изменен успешно.') then
    begin
      vtChanges.Edit;
      if qCheckBalanceBALANCE.AsFloat > qCheckBalancePOROG.AsFloat
        then vtChangesItog.AsString:=vtChangesItog.AsString + ' + .'
        else vtChangesItog.AsString:=vtChangesItog.AsString + ' - .';
    end;
    vtChanges.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtChanges.RecordCount > 0 then
    tbCheckBalance.Enabled:=false;
end;

procedure TChangeTariffArrayForm.aFindContractExecute(Sender: TObject);
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

procedure TChangeTariffArrayForm.aFindTariffExecute(Sender: TObject);
var i: integer;
begin
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    qCheckTariff.Close;
    qCheckTariff.ParamByName('pTARIFF_NAME').AsString:=vtChangesTariffName.AsString;
    qCheckTariff.Open;
    if (qCheckTariff.RecordCount = 1) and (Length(vtChangesItog.AsString) = 0) then
    begin
      vtChanges.Edit;
      vtChangesTariffId.AsInteger:=qCheckTariffTARIFF_ID.AsInteger;
    end else
    begin
      vtChanges.Edit;
      if Length(vtChangesItog.AsString) = 0 then
        if qCheckTariff.RecordCount = 0
          then vtChangesItog.AsString:= 'Ошибка: этого тарифа не существует.'
          else vtChangesItog.AsString:= 'Ошибка: для этого тарифа несколько записей в справочнике.';
      vtChangesTariffId.Clear;
    end;
    vtChanges.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbCheckTariff.Enabled:=false;
    tbCheckContract.Enabled:=true;
  end;
end;

procedure TChangeTariffArrayForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

procedure TChangeTariffArrayForm.FormShow(Sender: TObject);
begin
  qFilials.Open;
  while not qFilials.EOF do
  begin
    cbFilial.Items.AddObject(
      qFilials.FieldByName('FILIAL_NAME').AsString,
      TObject(qFilials.FieldByName('FILIAL_ID').AsInteger)
      );
    qFilials.Next;
  end;
  qFilials.Close;
  if cbFilial.Items.Count > 0 then
    cbFilial.ItemIndex := 0;
end;


end.
