unit CorpPortal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ExtCtrls, sPanel, GridsEh, DBGridEh, ComCtrls,
  ToolWin, sToolBar, StdCtrls, sLabel, sEdit, DB, DBAccess, Ora, MemDS,
  VirtualTable, ComObj, acProgressBar, Buttons, sBitBtn, sGroupBox;

type
  TCorpPortalForm = class(TForm)
    sToolBar1: TsToolBar;
    tbPrihod: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    tbLoadXLS: TToolButton;
    ToolButton6: TToolButton;
    tbHistory: TToolButton;
    ToolButton1: TToolButton;
    ToolButton9: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton8: TToolButton;
    ToolButton7: TToolButton;
    grMain: TDBGridEh;
    sPanel1: TsPanel;
    sEdit1: TsEdit;
    sLabel1: TsLabel;
    vtTransfers: TVirtualTable;
    dsTransfers: TDataSource;
    vtTransfersAccountFrom: TIntegerField;
    vtTransfersAccountTo: TIntegerField;
    vtTransfersTransferSum: TFloatField;
    spTransfers: TOraStoredProc;
    sPanel2: TsPanel;
    sLabel2: TsLabel;
    sProgressBar1: TsProgressBar;
    ToolButton10: TToolButton;
    qTransComplite: TOraQuery;
    qTransCompliteACCOUNT_FROM: TFloatField;
    qTransCompliteACCOUNT_TO: TFloatField;
    qTransCompliteTRANSFER_SUM: TFloatField;
    sGroupBox1: TsGroupBox;
    sEdit2: TsEdit;
    sLabel3: TsLabel;
    sEdit3: TsEdit;
    sLabel4: TsLabel;
    sBitBtn1: TsBitBtn;
    qSelectNoSound: TOraQuery;
    qSelectNoSoundCELL_NUMBER: TStringField;
    qSelectNoSoundACCOUNT: TStringField;
    qSelectNoSoundBALANCE: TFloatField;
    procedure tbLoadXLSClick(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure tbHistoryClick(Sender: TObject);
    procedure tbPrihodClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure sPanel2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sBitBtn1Click(Sender: TObject);
  private
    CountMax: Integer;
    CountProgress: Integer;
    OperRetMessage: String;
    procedure TransferExecute;
    procedure ShowProgress(Count: Integer);
  public
    { Public declarations }
  end;

var
  CorpPortalForm: TCorpPortalForm;

implementation

uses MainUnit, IntecExportGrid;

{$R *.dfm}

procedure TCorpPortalForm.sPanel2Click(Sender: TObject);
begin
  CountMax := vtTransfers.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
end;

procedure TCorpPortalForm.tbHistoryClick(Sender: TObject);
begin
  vtTransfers.Clear;
end;

procedure TCorpPortalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vtTransfers.Close;
end;

procedure TCorpPortalForm.FormShow(Sender: TObject);
begin
  vtTransfers.Open;
end;

procedure TCorpPortalForm.sBitBtn1Click(Sender: TObject);
var Months, Board:Double;
    Recipient:integer;
    Accept:boolean;
begin
  Accept:=false;
  try
    Months:=StrToFloat(sEdit3.Text);
    Accept:=true;
  finally
    Application.MessageBox(PChar('Посторонние символы в поле Месяцы тишины'),
        'Предупреждение', MB_OK+MB_ICONWARNING);
  end;
  try
    Board:=StrToFloat(sEdit2.Text);
    Accept:=true;
  finally
    Application.MessageBox(PChar('Посторонние символы в поле Снимать до'),
        'Предупреждение', MB_OK+MB_ICONWARNING);
  end;
  try
    Recipient:=StrToInt(sEdit1.Text);
    Accept:=true;
  finally
    Application.MessageBox(PChar('Посторонние символы в поле Счет получателя'),
        'Предупреждение', MB_OK+MB_ICONWARNING);
  end;
  if Accept then
  begin
    qSelectNoSound.ParamByName('pMONTH').AsInteger:=Trunc(Months);
    qSelectNoSound.ParamByName('pDAYS').AsInteger:=Trunc((Months-Trunc(Months))*30);
    qSelectNoSound.Open;
    qSelectNoSound.First;
    while not qSelectNoSound.Eof do
    begin
      vtTransfers.Append;
      vtTransfersAccountFrom.AsInteger:=qSelectNoSoundACCOUNT.AsInteger;
      vtTransfersAccountTo.AsInteger:=Recipient;
      vtTransfersTransferSum.AsFloat:=qSelectNoSoundBALANCE.AsFloat-Board;
      vtTransfers.Post;
      qSelectNoSound.Next;
    end;
    qSelectNoSound.Close;
  end;
end;

procedure TCorpPortalForm.ShowProgress(Count: Integer);
begin
  if CountMax <> 0 then
  begin
    sLabel2.Caption := FloatToStr(Round(10000 * Count / CountMax) / 100) + '% ('
      + IntToStr(Count) + '/' + IntToStr(CountMax) + ')';
    sProgressBar1.Position := Round(100 * Count / CountMax);
  end
  else
    sLabel2.Caption := '(' + IntToStr(Count) + '/' + IntToStr(CountMax) + ')';
  Application.ProcessMessages;
end;

procedure TCorpPortalForm.TransferExecute;
var
  cnt, Count, Index: Integer;
  str, AccountsFrom, AccountsTo, TransSums: String;
begin
  Screen.Cursor := crSQLWait;
  MainForm.StatusBar1.SimpleText := 'Выполняется загрузка данных в базу...';
  str := ';';
  Count := 0;
  vtTransfers.DisableControls;
  vtTransfers.Last;
  cnt := vtTransfers.RecordCount;
  CountMax := vtTransfers.RecordCount;
  CountProgress := 0;
  ShowProgress(CountProgress);
  AccountsFrom:='';
  AccountsTo:='';
  TransSums:='';
  while not vtTransfers.Bof do
  begin
    try
      Index:=0;
      AccountsFrom:='';
      AccountsTo:='';
      TransSums:='';
      while (Index<1)and(not vtTransfers.Bof) do
      begin
        Inc(Index);
        if (vtTransfersAccountFrom.AsString<>'')
            and(vtTransfersAccountTo.AsString<>'')
            and(vtTransfersTransferSum.AsString<>'') then
        begin
          if AccountsFrom<>'' then
            AccountsFrom:=AccountsFrom+';'+IntToStr(vtTransfersAccountFrom.AsInteger)
          else
            AccountsFrom:=IntToStr(vtTransfersAccountFrom.AsInteger);
          if AccountsTo<>'' then
            AccountsTo:=AccountsTo+';'+IntToStr(vtTransfersAccountTo.AsInteger)
          else
            AccountsTo:=IntToStr(vtTransfersAccountTo.AsInteger);
          if TransSums<>'' then
            TransSums:=TransSums+';'+FloatToStr(vtTransfersTransferSum.AsFloat)
          else
            TransSums:=FloatToStr(vtTransfersTransferSum.AsFloat);
        end;
        vtTransfers.Prior;
      end;
      spTransfers.ParamByName('PACCOUNTS_FROM').AsString:=AccountsFrom;
      spTransfers.ParamByName('PACCOUNTS_TO').AsString:=AccountsTo;
      spTransfers.ParamByName('PTRANSFER_SUM').AsString:=TransSums;
      spTransfers.ExecSQL;
      if spTransfers.ParamByName('RESULT').AsString = '' then
        Count := Count + Index;
      CountProgress:=CountProgress+Index;
      ShowProgress(CountProgress);
    except
      vtTransfers.Prior;
    end;
    Application.ProcessMessages;
  end;
  vtTransfers.EnableControls;
    Application.MessageBox(PChar('Успешно отправлено ' + IntToStr(cnt) +
    ' запросов перевода средств.'), 'Уведомление', MB_OK + MB_ICONINFORMATION);
  OperRetMessage := 'Запрошено ' + IntToStr(cnt) + 'переводов средств.';
  Screen.Cursor := crDefault;
  MainForm.StatusBar1.SimpleText := '';
end;

procedure TCorpPortalForm.tbLoadXLSClick(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
  datecheck: string;
begin
  if MainForm.sOpenDialog1.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(MainForm.sOpenDialog1.FileName);
    i := 1;
    while VarToStr(Excel.Cells[i, 1]) <> '' do
    begin
      vtTransfers.Append;
      if VarToStr(Excel.Cells[i, 1]) <> '' then
        vtTransfersAccountFrom.AsInteger :=
          StrToInt(Excel.Cells[i, 1])
      else
        vtTransfersAccountFrom.AsVariant := null;
      if VarToStr(Excel.Cells[i, 2]) <> '' then
        vtTransfersAccountTo.AsInteger :=
          StrToInt(Excel.Cells[i, 2])
      else
        vtTransfersAccountTo.AsVariant := null;
      if VarToStr(Excel.Cells[i, 3]) <> '' then
        vtTransfersTransferSum.AsFloat :=
          StrToFloat(Excel.Cells[i, 3])
      else
        vtTransfersTransferSum.AsVariant := null;
      vtTransfers.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
end;

procedure TCorpPortalForm.tbPrihodClick(Sender: TObject);
begin
  vtTransfers.Insert;
end;

procedure TCorpPortalForm.ToolButton10Click(Sender: TObject);
var CheckComplite:integer;
begin
  vtTransfers.DisableControls;
  qTransComplite.Open;
  vtTransfers.Last;
  while not vtTransfers.Bof do
  begin
    qTransComplite.First;
    CheckComplite:=0;
    while (not qTransComplite.Eof)and(CheckComplite=0)
        and(vtTransfersAccountFrom.AsInteger>=qTransCompliteACCOUNT_FROM.AsInteger) do
      if (vtTransfersAccountFrom.AsInteger=qTransCompliteACCOUNT_FROM.AsInteger)
          and(vtTransfersAccountTo.AsInteger=qTransCompliteACCOUNT_TO.AsInteger)
          and(vtTransfersTransferSum.AsFloat=qTransCompliteTRANSFER_SUM.AsFloat) then
        CheckComplite:=1
      else
        qTransComplite.Next;
    if CheckComplite=1 then
      vtTransfers.Delete
    else
      vtTransfers.Prior;
  end;
  qTransComplite.Close;
  vtTransfers.EnableControls;
end;

procedure TCorpPortalForm.ToolButton2Click(Sender: TObject);
begin
  vtTransfers.Delete;
end;

procedure TCorpPortalForm.ToolButton4Click(Sender: TObject);
var
  oq: TOraQuery;
  dtStart: TDateTime;
begin
  oq := TOraQuery.Create(self);
  try
    //Берем время сервера
    oq.SQL.Text := 'select sysdate q from dual';
    oq.Open;
    dtStart := oq.FieldByName('q').AsDateTime;
    oq.Close;
    //Тело
    TransferExecute;
    //Пишем итог операции
    oq.SQL.Text :=
      'begin insert into sim_operation_history(operation_type, note, date_begin) '
      + 'values(:v_operation_type, :v_note, :v_date_begin); commit; end;';
    oq.ParamByName('v_operation_type').Value := 'Переводы в корпоративном портале';
    oq.ParamByName('v_note').Value := OperRetMessage;
    oq.ParamByName('v_date_begin').Value := dtStart;
    oq.ExecSQL;
  finally
    oq.Free;
  end;
end;

procedure TCorpPortalForm.ToolButton7Click(Sender: TObject);
begin
  Close;
end;

procedure TCorpPortalForm.ToolButton9Click(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  vtTransfers.DisableControls;
  try
    ExportDBGridEhToExcel(Caption, grMain, false);
    Enabled := true;
    Application.MessageBox('Выгрузка в Excel завершена!', 'Уведомление',
      MB_OK + MB_ICONEXCLAMATION);
  finally
    Enabled := true;
    vtTransfers.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

end.
