unit LoadTurnTariffOptArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList, ToolWin, DB, Grids, DBGrids,
  CRGrid, MemDS, VirtualTable, DBAccess, Ora, ComObj, OraTransaction,
  VCL.FlexCel.Core, FlexCel.XlsAdapter;

type
  TLoadTurnTariffOptArrayForm = class(TForm)
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
    vtChangesItog: TStringField;
    aAddChanges: TAction;
    aExcel: TAction;
    tbImportExcel: TToolButton;
    tbCheckTariffOpt: TToolButton;
    aFindTariffOpt: TAction;
    ToolButton1: TToolButton;
    aClear: TAction;
    Transaction: TOraTransaction;
    vtChangesOption_code: TStringField;
    vtChangesACTION_TYPE: TIntegerField;
    qFindTariffOpt: TOraQuery;
    vtChangesOption_name: TStringField;
    qCheck: TOraQuery;
    qEditChange: TOraQuery;
    vtChangesACTION_DATE: TDateTimeField;
    procedure aFileOpenExecute(Sender: TObject);
    procedure aAddChangesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aExcelExecute(Sender: TObject);
    procedure aFindTariffOptExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
  private
    procedure SetProgress(i: integer);
  public
    { Public declarations }
  end;

var
  LoadTurnTariffOptArrayForm: TLoadTurnTariffOptArrayForm;

implementation

{$R *.dfm}

uses IntecExportGrid, Main;

procedure TLoadTurnTariffOptArrayForm.SetProgress(I: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

procedure TLoadTurnTariffOptArrayForm.aAddChangesExecute(Sender: TObject);
var
  count, i, vRes: integer;
  HaveDouble : Boolean;
begin
  Transaction.StartTransaction;
  HaveDouble := False;
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    if Pos('Ошибка:', vtChangesItog.AsString) = 0 then
    begin
      try
        //Проверка на дубль задания
        qCheck.Close;
        qCheck.ParamByName('phone_number').AsString := vtChangesPhoneNumber.AsString;
        qCheck.ParamByName('option_code').AsString := vtChangesOption_code.AsString;
        qCheck.ParamByName('ACTION_TYPE').AsString := vtChangesACTION_TYPE.AsString;
        qCheck.Open;
        if qCheck.RecordCount = 0 then
        begin
          qAddChange.Close;
          qAddChange.ParamByName('PHONE_NUMBER').AsString:= vtChangesPhoneNumber.AsString;
          qAddChange.ParamByName('OPTION_CODE').AsString:= vtChangesOption_code.AsString;
          qAddChange.ParamByName('ACTION_TYPE').AsInteger:= vtChangesACTION_TYPE.AsInteger;
          if not vtChangesACTION_DATE.IsNull then
            qAddChange.ParamByName('ACTION_DATE').AsDateTime:= vtChangesACTION_DATE.AsDateTime;
          qAddChange.ExecSQL;
          vtChanges.Edit;
          vtChangesItog.AsString:='Задание добавлено успешно.';
        end
        else
        begin
          qEditChange.ParamByName('ACTION_TYPE').AsInteger:= vtChangesACTION_TYPE.AsInteger;
          if not vtChangesACTION_DATE.IsNull then
            qEditChange.ParamByName('ACTION_DATE').AsDateTime:= vtChangesACTION_DATE.AsDateTime;
          qEditChange.ParamByName('DELAYED_TURN_TO_ID').AsInteger:= qCheck.FieldByName('DELAYED_TURN_TO_ID').AsInteger;
          qEditChange.ExecSQL;
          vtChanges.Edit;
          HaveDouble := True;
          vtChangesItog.AsString:='Для данного номера уже существует задание на подключение/отключение этой услуги.' +
                                  ' Задание изменено.';
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
  if HaveDouble then
    vRes := MessageDlg('Обнаружено дублирование записей!!!'+#13#10+'Принять последние изменения?', mtWarning, [mbYes, mbNo], 0)
  else
    vRes := MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0);

  if vRes = mrYes then
    Transaction.Commit
  else
    Transaction.Rollback;
  if vtChanges.RecordCount > 0 then
  begin
    tbAddChanges.Enabled:=false;
    tbImportExcel.Enabled:=true;
  end;
end;

procedure TLoadTurnTariffOptArrayForm.aClearExecute(Sender: TObject);
begin
  vtChanges.Clear;
  tbAddPhones.Enabled:=true;
  tbCheckTariffOpt.Enabled:=false;
  tbAddChanges.Enabled:=false;
end;

procedure TLoadTurnTariffOptArrayForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Массовая загрузка заданий на отложеное подключение и отключение услуг.','',
      ChangesGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TLoadTurnTariffOptArrayForm.aFileOpenExecute(Sender: TObject);
const
  ColCount = 4;
var
  i, j, c : integer;
  err: string;
  Xls : TExcelFile;
  str : string;
  vActionDAte : TDateTime;
  v: TCellValue;
begin
  if OpenDialog.Execute then
  begin
    Xls := TXlsFile.Create(false);
    try
      xls.Open(OpenDialog.FileName);
      xls.ActiveSheet := 1;


      //начинаем со второй строки, т.к. в первой заголовок
      //i := 2;
      vtChanges.Open;
      i := Xls.RowCount;
      for i := 2 to Xls.RowCount do
      begin
        if Trim(Xls.GetStringFromCell(i, 1)) = '' then
          Exit;
        vtChanges.Append;
        for j := 1 to ColCount do
        begin
          err:='';
          c := Xls.ColFromIndex(i, j);
          if j <> 4 then
            str := (Xls.GetCellValue(i, c)).ToString
          else
          begin
            vActionDAte := (Xls.GetCellValue(i, c)).ToDateTime(false);
            str := FormatDateTime('dd.mm.yyyy hh:nn:ss', vActionDAte);
          end;


          case j of
            1 :
              begin
                if str <> '' then
                  vtChangesPhoneNumber.AsString := str
                else
                  err := ' Номер телефона обязателен для заполнения.';
              end;
            2 :
              begin
                if str <> '' then
                  vtChangesOption_code.AsString := str
                else
                  err:=err + ' Код опции обязателен для заполнения.';
              end;
            3 :
              begin
                if str <> '' then
                begin
                  vtChangesACTION_TYPE.AsString := str;
                  if (str <> '1') and  (str <> '0') then
                    err := err + ' Неверный тип операции.'
                end
                else
                  err := err + ' Тип операции обязателен для заполнения.';
              end;
            4 :
              begin
                Try
                  if str <> '' then
                    vtChangesACTION_Date.Value := vActionDAte
                  else
                    err := err + ' Дата выполнения обязательна для заполнения.';
                Except
                  on E : EConvertError do
                     err:= err + ' Неверный формат даты.';
                  on E : Exception do
                     err:= err + ' ' + E.Message;
                End;
              end;
          end;
          if err <> '' then
            vtChangesItog.AsString:='Ошибка:' + err;
        end;
        vtChanges.Post;
      end;
    finally
      FreeAndNil(Xls);
    end;
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbAddPhones.Enabled:=false;
    tbCheckTariffOpt.Enabled:=true;
  end;
end;


procedure TLoadTurnTariffOptArrayForm.aFindTariffOptExecute(Sender: TObject);
var i: integer;
begin
  vtChanges.First;
  i:=0;
  ProgressBar.Max:= vtChanges.RecordCount;
  while not(vtChanges.Eof) do
  begin
    SetProgress(i);
    if vtChangesItog.AsString = '' then
    begin
      qFindTariffOpt.Close;
      qFindTariffOpt.ParamByName('option_code').AsString:=vtChangesOption_code.AsString;
      qFindTariffOpt.Open;
      if qFindTariffOpt.RecordCount <> 1 then
      begin
        vtChanges.Edit;
        if qFindTariffOpt.RecordCount = 0
        then vtChangesItog.AsString:= 'Ошибка: этой тарифной опции не существует.'
        else vtChangesItog.AsString:= 'Ошибка: для этой тарифной опции несколько записей в справочнике.';
      end
      else
      begin
        vtChanges.Edit;
        vtChangesOption_name.AsString:=qFindTariffOpt.FieldByName('option_name').AsString;
      end;
    end;
    vtChanges.Next;
    Inc(i);
    SetProgress(i);
  end;
  if vtChanges.RecordCount > 0 then
  begin
    tbCheckTariffOpt.Enabled:=false;
    tbAddChanges.Enabled:=true;
  end;
end;

procedure TLoadTurnTariffOptArrayForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrOk;
end;

end.
