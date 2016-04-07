unit InitUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainUnit{, VirtualTrees}, ComCtrls, ToolWin, sToolBar, StdCtrls, Mask,
  sMaskEdit, sCustomComboEdit, sTooledit, sComboBox, sLabel, ExtCtrls, sPanel,
  DBGridEhGrouping, GridsEh, DBGridEh, DB, MemDS, VirtualTable, ComObj, DBCtrls,
  DBAccess, Ora, DBCtrlsEh, DBLookupEh;

type
  TInitForm = class(TForm)
    sPanel1: TsPanel;
    Label1: TsLabel;
    Label2: TsLabel;
    sToolBar1: TsToolBar;
    tbPrihod: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    tbLoadXLS: TToolButton;
    ToolButton6: TToolButton;
    tbHistory: TToolButton;
    vtLoad: TVirtualTable;
    vtLoadSubagent: TStringField;
    vtLoadaccount: TStringField;
    vtLoadcellnum: TStringField;
    vtLoadtarif: TStringField;
    vtLoaddateactiv: TDateField;
    vtLoaddatetechactiv: TDateField;
    vtLoaddatemove: TDateField;
    dsLoad: TDataSource;
    grMain: TDBGridEh;
    dsAgent: TDataSource;
    dsOperator: TDataSource;
    qAgent: TOraQuery;
    qOperator: TOraQuery;
    qAgentAGENT_ID: TFloatField;
    qAgentNAME: TStringField;
    qOperatorOPERATOR_ID: TFloatField;
    qOperatorOPERATOR_NAME: TStringField;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    spLoad: TOraStoredProc;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    procedure tbLoadXLSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbHistoryClick(Sender: TObject);
    procedure tbPrihodClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure vtLoadAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TInitForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vtLoad.Close;
  qAgent.Close;
  qOperator.Close;
  Action := caFree;
end;

procedure TInitForm.FormCreate(Sender: TObject);
begin
  vtLoad.Open;
  qAgent.Open;
  DBLookupComboBoxEh1.KeyValue := qAgentAGENT_ID.AsInteger;
  qOperator.Open;
  DBLookupComboBoxEh2.KeyValue := qOperatorOPERATOR_ID.AsInteger;
  tbLoadXLS.Click;
end;

procedure TInitForm.tbHistoryClick(Sender: TObject);
begin
  vtLoad.Clear;
end;

procedure TInitForm.tbLoadXLSClick(Sender: TObject);
var
  Ap: Variant;
  i: integer;

  function MakeDate(tmp: string): Variant;
  var
    res: Variant;
    fs: TFormatSettings;
  begin
    res := '';
    tmp := StringReplace(tmp, ',', '.', [rfReplaceAll]);
    try
      fs.LongDateFormat := 'dd.mm.yyyy';
      fs.ShortDateFormat := 'dd.mm.yyyy';
      fs.DateSeparator := '.';
      res := StrToDate(tmp, fs);
    except

    end;
    Result := res;
  end;

begin
  if MainForm.sOpenDialog1.Execute then
  begin
    Screen.Cursor := crHourGlass;
    MainForm.StatusBar1.SimpleText := 'Загружается файл - ['+MainForm.sOpenDialog1.FileName+']';
    vtLoad.DisableControls;
    try
      Ap := CreateOleObject('Excel.Application');
      Ap.Workbooks.Open(MainForm.sOpenDialog1.FileName);
      Ap.Visible := false;

      i:= 4;
      while (Ap.Workbooks[1].WorkSheets[1].Cells[i,2].Text <> '')or(Ap.Workbooks[1].WorkSheets[1].Cells[i,3].Text <> '') do
      begin
        vtLoad.Append;
        vtLoadSubagent.AsString := Ap.Workbooks[1].WorkSheets[1].Cells[i,1].Text;
        vtLoadaccount.AsString := Ap.Workbooks[1].WorkSheets[1].Cells[i,2].Text;
        vtLoadcellnum.AsString := Ap.Workbooks[1].WorkSheets[1].Cells[i,3].Text;
        vtLoadtarif.AsString := Ap.Workbooks[1].WorkSheets[1].Cells[i,4].Text;
        vtLoaddateactiv.AsString := MakeDate(Ap.Workbooks[1].WorkSheets[1].Cells[i,5].Text);
        vtLoaddatetechactiv.AsString := MakeDate(Ap.Workbooks[1].WorkSheets[1].Cells[i,6].Text);
        vtLoaddatemove.AsString := MakeDate(Ap.Workbooks[1].WorkSheets[1].Cells[i,7].Text);

        inc(i);
      end;

    finally
      Ap.Quit;
      Ap := Unassigned;
      vtLoad.EnableControls;
      Application.MessageBox(PChar('Загрузка завершена!'), 'Уведомление', MB_OK+MB_ICONEXCLAMATION);
      MainForm.StatusBar1.SimpleText := '';
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TInitForm.tbPrihodClick(Sender: TObject);
begin
  vtLoad.Insert;
end;

procedure TInitForm.ToolButton2Click(Sender: TObject);
begin
  if not vtLoad.IsEmpty then
    vtLoad.Delete;
end;

procedure TInitForm.ToolButton4Click(Sender: TObject);
var
  cnt: integer;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  spLoad.ParamByName('vagentid').Value := DBLookupComboBoxEh1.KeyValue;
  spLoad.ParamByName('voperatorid').Value := DBLookupComboBoxEh2.KeyValue;
  vtLoad.DisableControls;
  vtLoad.Last;
  cnt := vtLoad.RecordCount;
  while not vtLoad.Bof do
  begin
    try
      spLoad.ParamByName('vsubagent').Value := vtLoadSubagent.AsVariant;
      spLoad.ParamByName('vaccount').Value := vtLoadaccount.AsVariant;
      spLoad.ParamByName('vcellnumber').Value := vtLoadcellnum.AsVariant;
      spLoad.ParamByName('vdateactiv').Value := vtLoaddateactiv.AsVariant;
      spLoad.ParamByName('vdatemove').Value := vtLoaddatemove.AsVariant;
      spLoad.ParamByName('vdatetechactiv').Value := vtLoaddatetechactiv.AsVariant;
      spLoad.ParamByName('vtarif').Value := vtLoadtarif.AsVariant;
      spLoad.ExecSQL;
      vtLoad.Delete;
    except
      vtLoad.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtLoad.EnableControls;
  if vtLoad.RecordCount > 0 then
    Application.MessageBox(PChar('Загрузка завершена!'+#13#10
                                +'Загружено '+IntToStr(cnt-vtLoad.RecordCount)+' карт.'+#13#10
                                +'Данные в списке не были загружены. Исправьте данные и запустите загрузку снова.'), 'Предупреждение', MB_OK+MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Загрузка завершена!'+#13#10
                                +'Загружено '+IntToStr(cnt-vtLoad.RecordCount)+' карт.'), 'Уведомление', MB_OK+MB_ICONINFORMATION);
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TInitForm.ToolButton7Click(Sender: TObject);
begin
  Close;
end;

procedure TInitForm.vtLoadAfterInsert(DataSet: TDataSet);
begin
  MainForm.StatusBar1.SimpleText := IntToStr(vtLoad.RecordCount)+ ' записей для обработки..';
end;

end.
