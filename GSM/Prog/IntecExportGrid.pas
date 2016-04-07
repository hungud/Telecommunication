unit IntecExportGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CheckLst, DBGrids, Variants, CRGrid
  //, MessageComp
  ;

type
  TSelectPrintColumnsForm = class(TForm)
    pBottom: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    clbColumns: TCheckListBox;
  private

  public

  end;


type
  TAfterCreateReportProc = procedure(const Book : IDispatch) of object;

procedure ExportDBGridToExcel(Caption : string;
NameFile : string;
  Grid : TCRDBGrid;
  ShowColumnsDialog : Boolean = False;
  LandscapePageOrientation : Boolean = False;
  SaveToDisk:boolean=false);

procedure ExportDBGridToExcel2(Caption : string;
NameFile : string;
  Grid : TCRDBGrid;
  AfterCreateReportProc : TAfterCreateReportProc;
  ShowColumnsDialog : Boolean = False;
  LandscapePageOrientation : Boolean = False;
  SaveToDisk:boolean=false);

procedure ExportStringsToExcel(AStrings: TStrings;Caption: string;exple:string);

implementation

{$R *.DFM}

uses DB, Math, Excel2000, OleServer, ComObj, ActiveX;

type
  TPrintColumnArray = array of integer;


Function SelectColumns(var arPrintColumn : TPrintColumnArray; Grid : TCRDBGrid;
  ShowColumnsDialog : Boolean): Boolean;
var
 SelectColForm: TSelectPrintColumnsForm;
 cnt,i,index: integer;
 arColIndex: array of integer;
begin
  SelectColForm := nil;
  cnt := Grid.Columns.Count-1;
  try
    SelectColForm := TSelectPrintColumnsForm.Create(nil);
    for i:= 0 to cnt do
      if Grid.Columns[i].Visible then
      begin // Blob поля не распечатывать
      if Grid.Columns[i].Field<>nil then
        if not (Grid.Columns[i].Field.DataType in [ftOraBlob,ftOraClob,ftBlob]) then
        begin
          index := SelectColForm.clbColumns.Items.Add(Grid.Columns[i].Title.Caption);
          SelectColForm.clbColumns.Checked[index] := True;
          SetLength(arColIndex,index+1);
          arColIndex[index] := i;
        end;
    end;
    SelectColForm.AutoSize := False;
    SelectColForm.ClientHeight := min(SelectColForm.clbColumns.ItemHeight*(Length(arColIndex)+1)
      +SelectColForm.pBottom.Height,Screen.Height-20);
    if ShowColumnsDialog then
      Result := SelectColForm.ShowModal = mrOk
    else
      Result := True;
    if Result then
    begin
      SetLength(arPrintColumn,0);
      index :=1;
      Result := False;
      for i:=0 to SelectColForm.clbColumns.Items.Count-1 do  // проверка на выбор хотя бы одной колонки для печати
      begin
       if SelectColForm.clbColumns.Checked[i] then
       begin
         SetLength(arPrintColumn,index);
         arPrintColumn[index-1]:= arColIndex[i];
         inc(index);
         Result := True;
       end;
      end;
      if not Result then
        //RunMessage('Не выбрано ни одной колонки для печати',mtConfirmation,[mbOk]);
        MessageDlg('Не выбрано ни одной колонки для печати', mtConfirmation, [mbOK], 0);
    end;
  finally
    if Assigned(SelectColForm) then
      SelectColForm.Free;
  end;
end;


procedure CreateDocument(Caption : string;
  NameFile : string;
  Grid : TCRDBGrid;
  AfterCreateReportProc : TAfterCreateReportProc;
  const arPrintColumn : TPrintColumnArray;
  LandscapePageOrientation : Boolean;
  SaveToDisk:boolean=false);
var
  CurrentRow, TitleRow : Integer;
  RowNum,cnt: integer;
  Columns,SelectCells: Excel2000.ExcelRange;
  Wid: Real;
  arRecords: OleVariant;
  Cells : Excel2000.ExcelRange;
  ExcelApplication : Excel2000.ExcelApplication;
  Workbook : _Workbook;
  OldSheetsInNewWorkbook : integer;

  procedure BorderCell(const CellVar : OleVariant; const HorAlign : TOleEnum;
    IsBold:Boolean = False; clBackGround:Integer = 2);
  begin
    CellVar.BorderAround(xlContinuous,xlThin,TOleEnum(xlAutomatic),0);
   // CellVar.HorizontalAlignment := HorAlign;
   // CellVar.VerticalAlignment:=TOleEnum(xlCenter);
    CellVar.Font.Bold := IsBold;
    CellVar.WrapText:=True;
    CellVar.Interior.ColorIndex := clBackGround;
  end;

  procedure ResizeColumns;
  const
    MaxColumnWidth = 150.0;
  var
    ColNum,ColCount,k,p: integer;
    Col: TColumn;
    EndAddress, StartAddress : string;
    r : Excel2000.ExcelRange;
    TempStr: string;
    ColumnAlign : TOleEnum;
  begin
    ColCount := Length(arPrintColumn) - 1;
    BorderCell(Cells.Item[CurrentRow-1,1], TOleEnum(xlCenter),True,15);  // серый цвет заливки ячейки
    Columns.Item[1, EmptyParam].ColumnWidth:= 6;
    Cells.Item[CurrentRow-1,1] := '№ п/п';
    for ColNum := 0 to ColCount do
    begin
      Col := Grid.Columns[arPrintColumn[ColNum]];
      Wid := abs(Col.Width/Grid.Font.Size)*1.2;
      if Wid < 0.0 then
        Wid := 0.0;
      if Wid > MaxColumnWidth then
        Wid := MaxColumnWidth;
      Columns.Item[ColNum+2,EmptyParam].ColumnWidth := Wid;
      case Col.Alignment of
        taRightJustify: ColumnAlign := TOleEnum(xlRight);
        taCenter: ColumnAlign := TOleEnum(xlCenter);
        else ColumnAlign := TOleEnum(xlLeft);
      end; // case
//Columns.Item[ColNum+2, EmptyParam].HorizontalAlignment := ColumnAlign;
      BorderCell(Cells.Item[CurrentRow-1,ColNum+2],TOleEnum(xlCenter),True,15);
      Cells.Item[CurrentRow-1,ColNum+2] := StringReplace(Col.Title.Caption, '|', ' ', [rfReplaceAll]);
    end;
    StartAddress := Cells.Item[1, 1].Address;
    EndAddress := Cells.Item[1,ColCount+2].Address;
    r := Cells.Range[StartAddress+':'+EndAddress, EmptyParam];
    r.HorizontalAlignment := TOleEnum(xlCenter);
    r.VerticalAlignment:=TOleEnum(xlCenter);
    r.MergeCells := True;
    k := 1;
    TempStr := Caption;
    p := pos(#10,TempStr);
    while p > 0 do
    begin
     p := pos(#10,TempStr);
     TempStr := copy(TempStr,p+2,length(TempStr));
      inc(k);
    end;
    r.RowHeight := r.RowHeight*k;
  end;

  procedure FillDocumentRows;
  const
    BufferSize = 1000;
  var
    Borders : Variant;
    ColNum,j,StartRow: integer;
    EndAddress, StartAddress : string;
    DataSet : TDataSet;
    f : TField;
  begin

    DataSet := Grid.DataSource.DataSet;
    DataSet.First;
    while not DataSet.Eof do
    begin
      arRecords := VarArrayCreate([0, BufferSize, 0, cnt], varVariant);
      StartRow := CurrentRow;
      for j:= 1 to BufferSize do
      begin
        arRecords[j-1, 0] := RowNum;
        for ColNum := 1 to cnt do
        begin
//          arRecords[j-1, ColNum] := Grid.Columns[arPrintColumn[ColNum-1]].Field.Value;
          f := Grid.Columns[arPrintColumn[ColNum-1]].Field;
          if (f Is TNumericField)
            and not f.IsNull
            and not Assigned(f.OnGetText) then
            arRecords[j-1, ColNum] := f.Value
          else if (UpperCase(f.FieldName) = 'CALLDURATION') OR (UpperCase(f.FieldName) = 'DATAVOLUME') then
            arRecords[j-1, ColNum] := Copy(f.Text, 1, 900)
          else if (f.DataType = TFieldType.ftDateTime) OR (f.DataType = TFieldType.ftFloat) then
            arRecords[j-1, ColNum] := f.Value //Copy(f.Text, 1, 900)

          else
            arRecords[j-1, ColNum] := Copy('''' + f.Text, 1, 900);  // 900 - установлено экспериментальным способом
        end;
        inc(CurrentRow);
        inc(RowNum);
        DataSet.Next;
        if DataSet.EOf then
          Break;
      end;
      if not VarIsEmpty(arRecords) then
      begin
        StartAddress := Cells.Item[StartRow, 1].Address;
        EndAddress := Cells.Item[CurrentRow-1,cnt+1].Address;
        SelectCells := nil;
        SelectCells := Cells.Range[StartAddress+':'+EndAddress, EmptyParam];
        SelectCells.Value := arRecords;
        SelectCells.WrapText := True;
        SelectCells.BorderAround(xlContinuous,xlThin,TOleEnum(xlAutomatic),0);


      end;
    end;
  end;

var
  PageSetup : Excel2000.PageSetup;
  Orientation : Excel2000.XlPageOrientation;
  TemplateFileName : string;
  NTemplateFileName : string;
  TemplateFileNameX : string;
  NTemplateFileNameX : string;
  ver:string;
  LCID: integer;
begin
  if NameFile <>'' then
  begin
    TemplateFileName := ExtractFilePath(Application.ExeName) + 'TemplateName.xlt';
    TemplateFileNameX := ExtractFilePath(Application.ExeName) + 'TemplateName.xltx';
    if not FileExists(TemplateFileName) then
      Raise Exception.Create('Файл шаблона "'+TemplateFileName+'" не установлен');
    if not FileExists(TemplateFileNameX) then
      Raise Exception.Create('Файл шаблона "'+TemplateFileNameX+'" не установлен');

    NTemplateFileName := ExtractFilePath(Application.ExeName)+NameFile+'.xlt';
    renamefile(TemplateFileName, NTemplateFileName);

    NTemplateFileNameX := ExtractFilePath(Application.ExeName)+NameFile+'.xltx';
    renamefile(TemplateFileNameX, NTemplateFileNameX);
  end;
  cnt := Length(arPrintColumn);
  try
    try
      ExcelApplication := IDispatch(GetActiveOleObject('Excel.Application')) As Excel2000.ExcelApplication;
    except
      ExcelApplication := CoExcelApplication.Create;
    end;
    LCID:=GetUserDefaultLCID;
    ver:=ExcelApplication.Version[LCID];
    OldSheetsInNewWorkbook := ExcelApplication.SheetsInNewWorkbook[0];
    try
      ExcelApplication.SheetsInNewWorkbook[0] := 1;
      if (ver='12.0') or (ver='14.0') or (ver='16.0') then
        Workbook := ExcelApplication.Workbooks.Add(NTemplateFileNameX,0)
      else  Workbook := ExcelApplication.Workbooks.Add(NTemplateFileName,0);
      //EmptyParam
    finally
      if NameFile <>'' then
      begin
        renamefile(NTemplateFileName,TemplateFileName);
        renamefile(NTemplateFileNameX,TemplateFileNameX);
      end;
      ExcelApplication.SheetsInNewWorkbook[0] := OldSheetsInNewWorkbook;
    end;

    PageSetup := (Workbook.ActiveSheet as _WorkSheet).PageSetup;
    if LandscapePageOrientation then
      Orientation := xlLandscape
    else
      Orientation := xlPortrait;
    try
      PageSetup.Orientation := Orientation;
      PageSetup.LeftFooter := 'Напечатано: &D &T ';
      PageSetup.CenterFooter := '';
      PageSetup.RightFooter := 'Страница &P из &N';
      PageSetup.LeftMargin := ExcelApplication.InchesToPoints(0.6, 0);
      PageSetup.RightMargin := ExcelApplication.InchesToPoints(0.6, 0);
      PageSetup.TopMargin := ExcelApplication.InchesToPoints(0.56, 0);
      PageSetup.BottomMargin := ExcelApplication.InchesToPoints(0.66, 0);
      PageSetup.HeaderMargin := ExcelApplication.InchesToPoints(0.45, 0);
      PageSetup.FooterMargin := ExcelApplication.InchesToPoints(0.41, 0);
    except
      // Если принтер по умолчанию отсутствует, то возникает ошибка
      // при настройке свойств печати. Гасим ее
    end;
    if SaveToDisk then
     ExcelApplication.Visible[0]:=false
    else
     ExcelApplication.Visible[0]:=True;

    Columns := (Workbook.ActiveSheet as _WorkSheet).Columns;
    Cells := (Workbook.ActiveSheet as _WorkSheet).Cells;
    (Workbook.ActiveSheet as _WorkSheet).Rows.AutoFit;
    //заполняем данными
    CurrentRow := 4; // строка, с которой печатаются данные
    TitleRow := CurrentRow - 1;
    RowNum :=1;
    ResizeColumns;
    Cells.Item[1,1].Font.Bold := True;
    Cells.Item[1,1].Value := Caption;
{    Cells.Item[2,1].Font.Bold := True;
    Cells.Item[2,1].Value := 'Дата печати:  '+ DateToStr(date);}
    FillDocumentRows;  // экспорт данных таблицы
    //рисование сетки таблицы

      with Cells.Range[Cells.Item[4, 1].Address+':'+Cells.Item[CurrentRow-1, cnt+1].Address, EmptyParam].Borders[xlInsideVertical] do
        begin
          LineStyle := xlContinuous ;
          Weight := xlThin;
          ColorIndex := TOleEnum(xlAutomatic);
        end;

     //   if CurrentRow - StartRow > 1 then
          with Cells.Range[Cells.Item[4, 1].Address+':'+Cells.Item[CurrentRow-1, cnt+1].Address, EmptyParam].Borders[xlInsideHorizontal] do
          begin
           LineStyle := xlContinuous ;
           Weight := xlThin;
           ColorIndex := TOleEnum(xlAutomatic);
       end;


    // печать заголовков на каждой странице
    try
      (Workbook.ActiveSheet as _WorkSheet).PageSetup.PrintTitleRows := '$1:$'+trim(InttoStr(TitleRow));
    except
      //Если принтер не установлен
    end;
    if Assigned(AfterCreateReportProc) then
      AfterCreateReportProc(Workbook);
    ExcelApplication.Visible[0]:=True;
    if SaveToDisk then begin
     //NameFile:='c:\temp\'+NameFile+'.xls';
     ExcelApplication.DisplayAlerts[0] := False;
     ExcelApplication.ActiveWorkbook.SaveCopyAs(NTemplateFileNameX,0);
     ExcelApplication.ActiveWorkbook.Close(0,NTemplateFileNameX,0,0); // xlDontSaveChanges
     //ExcelApplication.Application.EnableEvents:= false;
     //ExcelApplication.ActiveWorkbook.SaveAs('D:\2.xls','xls','','',false,false,0,'',false,'','',0);
    end
    else
     ExcelApplication.ActiveWindow.Activate;
  finally
  end;
end;

procedure ExportDBGridToExcel(Caption : string;
  NameFile : string;
  Grid : TCRDBGrid;
  ShowColumnsDialog : Boolean = False;
  LandscapePageOrientation : Boolean = False;
  SaveToDisk:boolean=false);
begin
  ExportDBGridToExcel2(Caption,NameFile, Grid, nil, ShowColumnsDialog, LandscapePageOrientation, savetodisk);
end;

procedure ExportDBGridToExcel2(
  Caption  : string;
  NameFile : string;
  Grid : TCRDBGrid;
  AfterCreateReportProc : TAfterCreateReportProc;
  ShowColumnsDialog : Boolean = False;
  LandscapePageOrientation : Boolean = False;
  SaveToDisk:boolean=false);
var
  arPrintColumn: TPrintColumnArray;
  Curs: TCursor;
begin
  if SelectColumns(arPrintColumn, Grid, ShowColumnsDialog) then
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    Grid.DataSource.DataSet.DisableControls;
    try
      CreateDocument(Caption,NameFile, Grid, AfterCreateReportProc, arPrintColumn, LandscapePageOrientation, SaveToDisk);
    finally
      Screen.Cursor := Curs;
      Grid.DataSource.DataSet.EnableControls;
    end
  end;
  ;
end;

 function RefToCell(ARow, ACol: Integer): string;
 begin
   Result := Chr(Ord('A') + ACol - 1) + IntToStr(ARow);
 end;

function GetNumStr(st:string; expl:string):integer;
Var p,i:integer;
Begin
  while (pos(expl,st)=1) and (length(st)>0) do
    delete(st,1,1);
  p:=pos(expl,st);
  i:=1;
  while p<>0 do
  begin
    inc(i);
    st:=copy(st,p+1,Length(st)-p);
    while (pos(expl,st)=1) and (length(st)>0) do
      delete(st,1,1);
    p:=pos(expl,st);
  end;
  result:=i;
End;

function GetSubStr(st:string; expl:string ;n:integer):string;
Var p,i:integer;
Begin
  for i:= 1 to n-1 do
  begin
    p:=pos(expl,st);
    st:=copy(st,p+1,Length(st)-p);
    while (pos(expl,st)=1) and (length(st)>0) do
      delete(st,1,1);
  end;
  p:=pos(expl,st);
  if p<>0 then result:=copy(st,1,p-1)
  else result:=st;
End;

procedure ExportStringsToExcel(AStrings: TStrings;Caption: string;exple:string);
   const
xlWBATChart = $FFFFEFF3;
xlWBATExcel4IntlMacroSheet = $00000004;
xlWBATExcel4MacroSheet = $00000003;
xlWBATWorksheet = $FFFFEFB9;
 var
 Sheet, Data: OLEVariant;
   i,maxcol,j: Integer;
     Workbook : _Workbook;
  ExcelApplication : Excel2000.ExcelApplication;
  OldSheetsInNewWorkbook : integer;
  s:string;
 begin
 maxcol:=1;
  for i := 0 to AStrings.Count - 1 do begin
       s:= AStrings[i];
       if GetNumStr(s,exple)>maxcol then maxcol:=GetNumStr(s,exple);
   end;

   // Prepare Data
  Data := VarArrayCreate([1, AStrings.Count+1,1,maxcol], varVariant);
      Data[1,1] :=Caption;
   for i := 0 to AStrings.Count do   begin
     s:= AStrings[i];
     for j := 1 to maxcol do begin
        Data[i + 1, j] := GetSubStr(s,exple,j);
     end;
   end;
    try
      ExcelApplication := IDispatch(GetActiveOleObject('Excel.Application')) As Excel2000.ExcelApplication;
    except
      ExcelApplication := CoExcelApplication.Create;
    end;
    OldSheetsInNewWorkbook := ExcelApplication.SheetsInNewWorkbook[0];
    try
      ExcelApplication.SheetsInNewWorkbook[0] := 1;
    finally
       ExcelApplication.SheetsInNewWorkbook[0] := OldSheetsInNewWorkbook;
    end;
  Workbook:=ExcelApplication.Workbooks.Add(xlWBATWorksheet, 0);
     Sheet := Workbook.ActiveSheet;
    Sheet.Range[RefToCell(1, 1), RefToCell(AStrings.Count+1,maxcol)].Value := Data;
        ExcelApplication.Visible[0]:=True;
    ExcelApplication.ActiveWindow.Activate;
 end;



end.


