unit RegisterPaymentsArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction;

type
  TRegisterPaymentsArrayForm = class(TForm)
    vtLoad: TVirtualTable;
    dsLoad: TDataSource;
    ChangesGrid: TCRDBGrid;
    vtLoadPhoneNumber: TStringField;
    vtLoadContractId: TIntegerField;
    vtLoadPaymentDateTime: TDateTimeField;
    vtLoadSumma: TStringField;
    ToolBar: TToolBar;
    tbAddPhones: TToolButton;
    tbCheckContract: TToolButton;
    tbAddChanges: TToolButton;
    ActionList: TActionList;
    aFindContract: TAction;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    aFileOpen: TAction;
    qAddChange: TOraQuery;
    qCheckContract: TOraQuery;
    OpenDialog: TOpenDialog;
    aAddChanges: TAction;
    aExcel: TAction;
    tbImportExcel: TToolButton;
    vtLoadPaymentType: TStringField;
    vtLoadPaymentTypeId: TIntegerField;
    aFindStatus: TAction;
    ToolButton1: TToolButton;
    aClear: TAction;
    Transaction: TOraTransaction;
    vtLoadRemark: TStringField;
    vtLoadReverseSchet: TIntegerField;
    vtLoadItog: TStringField;
    vtLoadContractNum: TIntegerField;
    qCheckContractCONTRACT_ID: TFloatField;
    qCheckContractCONTRACT_NUM: TFloatField;
    qCheckReceivedType: TOraQuery;
    cbFilial: TComboBox;
    Label14: TLabel;
    qFilials: TOraQuery;
    qAddChange_GSM_CORP: TOraQuery;
    procedure aFileOpenExecute(Sender: TObject);
    procedure aFindContractExecute(Sender: TObject);
    procedure aAddChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExcelExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  RegisterPaymentsArrayForm: TRegisterPaymentsArrayForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main, ContractsRegistration_Utils;

procedure TRegisterPaymentsArrayForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TRegisterPaymentsArrayForm.aAddChangesExecute(Sender: TObject);
var count, i, vRes: integer;
begin
  Transaction.StartTransaction;
  vtLoad.First;
  i:=0;
  ProgressBar.Max:= vtLoad.RecordCount;
  while not(vtLoad.Eof) do
  begin
    SetProgress(i);
    if Pos('Ошибка:', vtLoadItog.AsString) = 0 then
    begin
      try
        if (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE') then
        begin
          qAddChange.Close;
          qAddChange.ParamByName('PHONE_NUMBER').AsString:= vtLoadPhoneNumber.AsString;
          qAddChange.ParamByName('PAYMENT_SUM').AsFloat:= vtLoadSumma.AsFloat;
          qAddChange.ParamByName('PAYMENT_DATE_TIME').AsDateTime:= vtLoadPaymentDateTime.AsDateTime;
          qAddChange.ParamByName('RECEIVED_PAYMENT_TYPE_ID').AsInteger:= vtLoadPaymentTypeId.AsInteger;
          qAddChange.ParamByName('CONTRACT_ID').AsInteger:= vtLoadContractId.AsInteger;
          qAddChange.ParamByName('IS_CONTRACT_PAYMENT').AsInteger:= 0;
          qAddChange.ParamByName('FILIAL_ID').AsInteger:= Integer(cbFilial.Items.objects[cbFilial.ItemIndex]);
          qAddChange.ParamByName('REMARK').AsString:= vtLoadRemark.AsString;
          qAddChange.ParamByName('REVERSESCHET').AsInteger:= vtLoadReverseSchet.AsInteger;
          qAddChange.ExecSQL;
        end
        else
        begin
          qAddChange_GSM_CORP.Close;
          qAddChange_GSM_CORP.ParamByName('PHONE_NUMBER').AsString:= vtLoadPhoneNumber.AsString;
          qAddChange_GSM_CORP.ParamByName('PAYMENT_SUM').AsFloat:= vtLoadSumma.AsFloat;
          qAddChange_GSM_CORP.ParamByName('PAYMENT_DATE_TIME').AsDateTime:= vtLoadPaymentDateTime.AsDateTime;
          qAddChange_GSM_CORP.ParamByName('CONTRACT_ID').AsInteger:= vtLoadContractId.AsInteger;
          qAddChange_GSM_CORP.ParamByName('IS_CONTRACT_PAYMENT').AsInteger:= 0;
          qAddChange_GSM_CORP.ParamByName('FILIAL_ID').AsInteger:= Integer(cbFilial.Items.objects[cbFilial.ItemIndex]);
          qAddChange_GSM_CORP.ParamByName('REMARK').AsString:= vtLoadRemark.AsString;
          qAddChange_GSM_CORP.ExecSQL;
        end;

        vtLoad.Edit;
        vtLoadItog.AsString:='Платеж добавлен успешно.';
      except
        vtLoad.Edit;
        vtLoadItog.AsString:='Ошибка.';
      end;
    end;
    vtLoad.Next;
    inc(i);
    SetProgress(i);
  end;
  vRes := MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if vRes=mrYes
    then Transaction.Commit
    else Transaction.Rollback;
  if vtLoad.RecordCount > 0 then
    tbAddChanges.Enabled:=false;
end;

procedure TRegisterPaymentsArrayForm.aClearExecute(Sender: TObject);
begin
  vtLoad.Clear;
  tbAddPhones.Enabled:=true;
  tbCheckContract.Enabled:=false;
  tbAddChanges.Enabled:=false;
end;

procedure TRegisterPaymentsArrayForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Массовая загрузка ручных платежей','',
      ChangesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRegisterPaymentsArrayForm.aFileOpenExecute(Sender: TObject);
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
    vtLoad.Open;
    while VarToStr(Excel.Cells[i, 1]) <> '' do
    begin
      vtLoad.Append;
      if VarToStr(Excel.Cells[i, 1]) <> '' then
        vtLoadPhoneNumber.AsString:=Excel.Cells[i, 1];
        vtLoadPaymentDateTime.AsDateTime:=Excel.Cells[i, 2];
        vtLoadSumma.AsString:=Excel.Cells[i, 3];
        if (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE')  then
          vtLoadPaymentTypeId.AsInteger:=Excel.Cells[i, 4];
        if (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE')  then
          vtLoadRemark.AsString:=Excel.Cells[i, 5]
        else vtLoadRemark.AsString:=Excel.Cells[i, 4];
        if (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE')  then
          vtLoadReverseSchet.AsInteger:=Excel.Cells[i, 6];
      vtLoad.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  if vtLoad.RecordCount > 0 then
  begin
    tbAddPhones.Enabled:=false;
    tbCheckContract.Enabled:=true;
  end;
end;

procedure TRegisterPaymentsArrayForm.aFindContractExecute(Sender: TObject);
var i: integer;
begin
  vtLoad.First;
  i:=0;
  ProgressBar.Max:= vtLoad.RecordCount;
  while not(vtLoad.Eof) do
  begin
    SetProgress(i);
    //Поиск договора
    qCheckContract.Close;
    qCheckContract.ParamByName('PHONE_NUMBER').AsString:=vtLoadPhoneNumber.AsString;
    qCheckContract.ParamByName('PAYMENTDATE').AsDateTime:=vtLoadPaymentDateTime.AsDateTime;
    qCheckContract.Open;
    if (qCheckContract.RecordCount = 1) and (Length(vtLoadItog.AsString) = 0) then
    begin
      vtLoad.Edit;
      vtLoadContractId.AsInteger:=qCheckContractCONTRACT_ID.AsInteger;
      vtLoadContractNum.AsInteger:=qCheckContractCONTRACT_Num.AsInteger;
    end else
    begin
      vtLoad.Edit;
      if Length(vtLoadItog.AsString) = 0 then
        if qCheckContract.RecordCount = 0
          then vtLoadItog.AsString:= 'Ошибка: на этом номере нет открытого договора.'
          else vtLoadItog.AsString:= 'Ошибка: на этот номер несколько открытых договоров.';
      vtLoadContractId.Clear;
      vtLoadContractNum.Clear;
    end;
    if (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE') then
    begin
      //Проверка типа платежа
      qCheckReceivedType.Close;
      qCheckReceivedType.ParamByName('RECEIVED_PAYMENT_TYPE_ID').AsInteger:=vtLoadPaymentTypeId.AsInteger;
      qCheckReceivedType.Open;
      if Length(vtLoadItog.AsString) = 0 then
        if qCheckReceivedType.RecordCount = 0 then
          vtLoadItog.AsString:= 'Ошибка: Несуществующий тип платежа.';
    end;
    vtLoad.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtLoad.RecordCount > 0 then
  begin
    tbCheckContract.Enabled:=false;
    tbAddChanges.Enabled:=true;
  end;
end;

procedure TRegisterPaymentsArrayForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

procedure TRegisterPaymentsArrayForm.FormShow(Sender: TObject);
begin
 if (GetConstantValue('SERVER_NAME') = 'GSM_CORP') or (GetConstantValue('SERVER_NAME') = 'SIM_TRADE') then
 begin
   ChangesGrid.Columns[3].Visible:=false;//PaymentTypeId
   ChangesGrid.Columns[5].Visible:=false;//ReverseSchet
 end;
 //Заполняем выпадающий список Филиал
 try
  qFilials.Close;
  qFilials.Open;
  while not qFilials.EOF do
  begin
    cbFilial.Items.AddObject(
    qFilials.FieldByName('FILIAL_NAME').AsString,
      TObject(qFilials.FieldByName('FILIAL_ID').AsInteger)
    );
    qFilials.Next;
  end;
 finally
  qFilials.Close;
 end;
 if cbFilial.Items.Count > 0 then
   cbFilial.ItemIndex := 0;

end;

end.
