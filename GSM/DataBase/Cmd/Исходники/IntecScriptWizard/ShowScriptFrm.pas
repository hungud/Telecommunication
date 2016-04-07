unit ShowScriptFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, ToolWin, ComObj, IntecScriptWizard_TLB, StdCtrls,
  CheckLst, Winapi.ADOInt, ADODB, ActnList, ImgList, SynEdit, SynEditHighlighter,
  SynHighlighterSQL, Db, Menus, shellapi, StdVcl, IntecOraScript;

type
  TScriptItem = record
    Name : string;
    Text : string;
    Comment : string;
    FileName : string;
    CriticalFlag : ScriptCriticalEnum;
    Executed : Boolean;
    ErrorEncountered : Boolean;
  end;
  TScriptItemArray = array of TScriptItem;

  TShowScript = class(TAutoObject, IShowScript)
  private
    FScriptItemArray : TScriptItemArray;
    FConnection : Connection;

  public
    procedure Initialize; override;

//  IShowScript interface
    procedure Clear; safecall;
    procedure Add(const ScriptName: WideString; const ScriptText: WideString;
                      const ScriptComment: WideString;
                      const FileName : Widestring;
                      const CriticalFlag: WideString); safecall;
    procedure Run; safecall;
    function  Get_Connection: IDispatch; safecall;
    procedure Set_Connection(const Value: IDispatch); safecall;
  end;

  TShowScriptForm = class(TForm)
    pToolbar: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    pList: TPanel;
    Splitter1: TSplitter;
    pDetail: TPanel;
    lbItems: TListBox;
    mText: TSynEdit;
    mComment: TMemo;
    imglActions: TImageList;
    ActionList: TActionList;
    aRun: TAction;
    SynSQLSyn: TSynSQLSyn;
    StatusBar: TStatusBar;
//    IntecOraScript: TIntecOraScript;
//    ConnectionDispatcher: TConnectionDispatcher;
    pLog: TPanel;
    mLog: TMemo;
    Splitter2: TSplitter;
    aRunAll: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    aCompileAll: TAction;
//    dsCompile: TIcADODataSet;
//    qInvalidObjects: TIcADODataSet;
    pmExecuteTB: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    pmExecute: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    aOpenFile: TAction;
    aOpenFile1: TMenuItem;
    N6: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    aCreateFileList: TAction;
    aSaveToFile: TAction;
    SaveDialog1: TSaveDialog;
    aSaveToFile1: TMenuItem;
    aCreateFileList1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ADOConnection: TADOConnection;
    qInvalidObjects: TADOQuery;
    dsCompile: TADOCommand;
    procedure lbItemsClick(Sender: TObject);
    procedure aRunExecute(Sender: TObject);
    procedure IntecOraScriptBeforeExecute(Sender: TObject; var SQL: String;
      var Omit: Boolean);
//    procedure IntecOraScriptError(Sender: TObject; E: Exception;
//      SQL: String; var Action: TErrorAction);
    procedure aRunAllExecute(Sender: TObject);
    procedure lbItemsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure aCompileAllExecute(Sender: TObject);
    procedure lbItemsDblClick(Sender: TObject);
    procedure aOpenFileExecute(Sender: TObject);
    procedure aCreateFileListExecute(Sender: TObject);
    procedure aSaveToFileExecute(Sender: TObject);
  private
    FScriptItemArray : TScriptItemArray;
    FExecutingScriptIndex : integer;
    FConnection : Connection;
    FIntecOraScript : TIntecOraScript;
    procedure RunExecute(SelectedOnly: Boolean);
    procedure ItemChanged;
    procedure FillInvalidObjectsList(List : TStrings);
    procedure LogMessage(const Message: string);
    procedure EnsureConnection;
    procedure ScriptError(Sender: TObject;
      E: Exception; SQL: String; var Action: TErrorAction);
  public

  end;

implementation

uses ComServ;

{$R *.DFM}

const
  IMAGEINDEX_CHECKED = 9;
  IMAGEINDEX_UNCHECKED = 8;
  IMAGEINDEX_EXECUTED = 12;
  IMAGEINDEX_ERROR = 14;

{ TShowScript }

procedure TShowScript.Add(const ScriptName, ScriptText, ScriptComment,
  FileName, CriticalFlag: WideString);
const
  CommentStart = 'COMMENT ';
var
  L : integer;
  NativeCriticalFlag : ScriptCriticalEnum;
begin

  L := Length(FScriptItemArray);
  // Несколько идущих подряд пунктов "COMMENT" объединяем в один пункт
  if (L > 0)
    and (StrLIComp(PChar(String(ScriptText)), CommentStart, Length(CommentStart)) = 0)
    and (StrLIComp(PChar(FScriptItemArray[L-1].Text), CommentStart, Length(CommentStart)) = 0) then
  begin
    FScriptItemArray[L-1].Text := FScriptItemArray[L-1].Text + #13#10 + ScriptText;
  end
  else
  begin
    SetLength(FScriptItemArray, L+1);
    FScriptItemArray[L].Name := ScriptName;
    FScriptItemArray[L].Text := ScriptText;
    FScriptItemArray[L].Comment := ScriptComment;
    FScriptItemArray[L].FileName := FileName;
    FScriptItemArray[L].Executed := False;
    if (CriticalFlag = '') or (CriticalFlag = '0') or (SameText(CriticalFlag, 'Ordinary')) then
      NativeCriticalFlag := scOrdinary
    else if (CriticalFlag = '1') or (SameText(CriticalFlag, 'Important')) then
      NativeCriticalFlag := scImportant
    else if (CriticalFlag = '2') or (SameText(CriticalFlag, 'Critical')) then
      NativeCriticalFlag := scCritical
    else
      Raise Exception.Create('Переданное значение CriticalFlag не поддерживается');
    FScriptItemArray[L].CriticalFlag := NativeCriticalFlag;
  end;
end;

procedure TShowScript.Clear;
begin
  SetLength(FScriptItemArray, 0);
end;

procedure TShowScript.Initialize;
begin
  inherited;
end;

procedure TShowScript.Set_Connection(const Value: IDispatch);
begin
  FConnection := Value As Connection;
end;

function TShowScript.Get_Connection: IDispatch;
begin
  Result := FConnection;
end;

//procedure TShowScriptForm.EnsureConnection;
//var
//  IntecConnection : IDataListConnection;
//begin
//  if not Assigned(ConnectionDispatcher.Connection) then
//  begin
//    if Assigned(FConnection) then
//    begin
//      try
//        IntecConnection := IUnknown(CreateOleObject('IntecDB.IntecConnection')) As IDataListConnection;
//      except
//        on E : Exception do
//          Raise Exception.Create('Ошибка создания объекта IntecDB.IntecConnection. Возможно, Вам необходимо зарегистрировать библиотеку IntecDB.'#13#10#13#10'Текст ошибки: '+E.Message);
//      end;
//      IntecConnection.AdoConnection := FConnection;
//      ConnectionDispatcher.Connection := IntecConnection As IIntecConnection;
//    end;
//  end;
//  if not Assigned(ConnectionDispatcher.Connection) then
//    Raise Exception.Create('Соединение с БД не установлено');
//end;
//
procedure TShowScript.Run;
var
  Form : TShowScriptForm;
  i : integer;
begin
  Form := TShowScriptForm.Create(nil);
  try
    Form.FConnection := FConnection;
    Form.FScriptItemArray := FScriptItemArray;
    Form.lbItems.Clear;
    for i := 0 to Length(FScriptItemArray)-1 do
    begin
      Form.lbItems.Items.Add(FScriptItemArray[i].Name);
    end;
    if Length(FScriptItemArray) > 0 then
    begin
      Form.lbItems.ItemIndex := 0;
      Form.lbItems.Selected[0] := True;
      Form.lbItemsClick(nil);
    end;
    Form.ShowModal;
  finally
    Form.Free;
  end;
end;

procedure TShowScriptForm.EnsureConnection;
begin
  AdoConnection.ConnectionObject := FConnection;
end;

procedure TShowScriptForm.lbItemsClick(Sender: TObject);
begin
  ItemChanged;
end;

procedure TShowScriptForm.ItemChanged;
var
  Index : integer;
begin
  Index := lbItems.ItemIndex;
  if Index >= 0 then
  begin
    mComment.Text :=
      'Файл: '+FScriptItemArray[Index].FileName+#13#10+
      FScriptItemArray[Index].Comment;
    mText.Text := FScriptItemArray[Index].Text;
  end;
  StatusBar.Panels[0].Text := Format('Выбрано: %d', [lbItems.SelCount]);
end;

procedure TShowScriptForm.aRunAllExecute(Sender: TObject);
begin
  if MessageDlg('Запустить всё?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then
    RunExecute(False);
end;

procedure TShowScriptForm.aRunExecute(Sender: TObject);
begin
  RunExecute(True);
end;

procedure TShowScriptForm.RunExecute(SelectedOnly : Boolean);
var
  i : integer;
  SelCount : integer;
begin
  EnsureConnection;
  SelCount := lbItems.SelCount;
  FIntecOraScript := TIntecOraScript.Create(Self);
  FIntecOraScript.OnError := ScriptError;
  FIntecOraScript.Connection := ADOConnection;
  for i := 0 to lbItems.Items.Count-1 do
  begin
    if (not SelectedOnly or lbItems.Selected[i]) and
      not (FScriptItemArray[i].Executed) then
    begin
      FScriptItemArray[i].Executed := True;
      FExecutingScriptIndex := i;
      lbItems.ItemIndex := i;
      lbItems.Selected[i] := False;
      ItemChanged;
      Update;
      FIntecOraScript.SQL.Text := FScriptItemArray[i].Text;
      FIntecOraScript.Execute;
      Update;
    end;
  end;
  if SelectedOnly and (SelCount = 1) and (lbItems.ItemIndex < lbItems.Items.Count-1) then
  begin
    lbItems.ItemIndex := lbItems.ItemIndex+1;
    lbItems.Selected[lbItems.ItemIndex] := True;
    ItemChanged;
  end;
end;

procedure TShowScriptForm.IntecOraScriptBeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
//  ShowMessage(SQL);
end;

procedure TShowScriptForm.LogMessage(const Message : string);
begin
  mLog.Lines.Add(FormatDateTime(#13#10#13#10'hh:nn:ss - ', Time)+Message);
end;

procedure TShowScriptForm.ScriptError(Sender: TObject;
  E: Exception; SQL: String; var Action: TErrorAction);
var
  SQLFirstLine : string;
  Message : string;
  p : integer;
begin
  // Текущий индекс находится в FExecutingScriptIndex
  SQLFirstLine := SQL;
  p := Pos(#13, SQLFirstLine);
  if p > 0 then
    SQLFirstLine := Copy(SQLFirstLine, 1, p-1);
  Message := Format('Ошибка (файл %s, запрос %s)'#13#10'%s',
    [FScriptItemArray[FExecutingScriptIndex].FileName,
    SQLFirstLine, E.Message]);
  LogMessage(Message);
  FScriptItemArray[FExecutingScriptIndex].ErrorEncountered := True;
  FScriptItemArray[FExecutingScriptIndex].Executed := False;
  Action := eaContinue;
end;

procedure TShowScriptForm.lbItemsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  r : TRect;
begin
  r := Rect;
  r.Right := r.Left + imglActions.Width;
  lbItems.Canvas.Brush.Color := lbItems.Color;
  lbItems.Canvas.FillRect(r);
  if FScriptItemArray[Index].ErrorEncountered then
    imglActions.Draw(lbItems.Canvas, Rect.Left, Rect.Top, IMAGEINDEX_ERROR)
  else if FScriptItemArray[Index].Executed then
    imglActions.Draw(lbItems.Canvas, Rect.Left, Rect.Top, IMAGEINDEX_EXECUTED);
  r := Rect;
  r.Left := r.Left + imglActions.Width;
  if odSelected in State then
    lbItems.Canvas.Brush.Color := clHighLight
  else
    lbItems.Canvas.Brush.Color := lbItems.Color;
    lbItems.Canvas.FillRect(r);

  if odSelected in State then
    lbItems.Canvas.Font.Color := clCaptionText
  else
    lbItems.Canvas.Font.Color := lbItems.Font.Color;
  r := Rect;
  Inc(r.Left, imglActions.Width);
  lbItems.Canvas.TextRect(r, r.Left, r.Top, lbItems.Items[Index]);
end;

procedure TShowScriptForm.FillInvalidObjectsList(List : TStrings);
begin
  EnsureConnection;
  List.Clear;
  qInvalidObjects.Open;
  try
    while not qInvalidObjects.EOF do
    begin
      List.Add(qInvalidObjects.FieldByName('NAME').AsString);
//    Result := qInvalidObjects.FieldByName('C').AsInteger;
      qInvalidObjects.Next;
    end;
  finally
    qInvalidObjects.Close;
  end;
end;

procedure TShowScriptForm.aCompileAllExecute(Sender: TObject);
var
  InvalidCount, InvalidCount2 : integer;
  InvalidObjects : TStringList;
begin
  EnsureConnection;
  InvalidObjects := TStringList.Create;
  try
    FillInvalidObjectsList(InvalidObjects);
    InvalidCount2 := InvalidObjects.Count;
    repeat
      InvalidCount := InvalidCount2;
//      dsCompile.ParamByName('COMPILED_COUNT').AsInteger := 0;
      dsCompile.Execute;
      FillInvalidObjectsList(InvalidObjects);
      InvalidCount2 := InvalidObjects.Count;
    until InvalidCount2 >= InvalidCount;
    LogMessage(Format('Осталось %d инвалидных объектов:'#13#10'%s', [InvalidCount2, InvalidObjects.Text]));
  finally
    InvalidObjects.Free;
  end;
end;

procedure TShowScriptForm.lbItemsDblClick(Sender: TObject);
begin
  RunExecute(True);
end;

procedure TShowScriptForm.aOpenFileExecute(Sender: TObject);
var index: integer;
begin
  Index := lbItems.ItemIndex;
  if Index >= 0 then
  begin
    ShellExecute(0,nil,pChar('notepad'),pchar(FScriptItemArray[Index].FileName),nil,SW_NORMAL );
  end;
end;

procedure TShowScriptForm.aCreateFileListExecute(Sender: TObject);
var i : integer; lst: tstringlist;
begin
  lst:= tstringlist.Create;
  lst.Sorted:=true;
  lst.Duplicates:=dupIgnore;
  for i:=0 to lbItems.Items.Count-1 do begin
    lst.Add(FScriptItemArray[i].FileName);
  end;
  mLog.Lines.Add('');
  mLog.Lines.AddStrings(lst);
  lst.Free;
end;

procedure TShowScriptForm.aSaveToFileExecute(Sender: TObject);
begin
{  if mText.Focused then SaveDialog1.Title:='Выбор файла для сохранения скрипта:'
  else}
//  if mLog.Focused then
  SaveDialog1.Title:='Выбор файла для сохранения лога:';
  if SaveDialog1.Execute then begin
//    if mLog.Focused then
    mLog.Lines.SaveToFile(SaveDialog1.FileName)
{    else
    if mText.Focused then
    mText.Lines.SaveToFile(SaveDialog1.FileName);}
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TShowScript,
    Class_ShowScript, ciMultiInstance, tmSingle);
end.

