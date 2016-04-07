unit ExportGridToExcelPDF;

interface

uses DBGrids,Windows, Messages,SysUtils,VCL.FlexCel.Core, FlexCel.XlsAdapter,
Forms,FlexCel.Render, FlexCel.Pdf,ToolWin,IOUtils,  Ora,  Registry, IniFiles,
Variants, Classes, Graphics,Controls, StdCtrls,CRGrid,ShellAPI,dialogs;

type
  TFLst = Array of String;
 Type
  TSystemPath = (Desktop, StartMenu, Programs, Startup, Personal, winroot, winsys, AppData, Cache, TMP);

  procedure ExportDBGrid(Caption : string;
                       Note : string;
                       NameFile : string;
                       Grid : TCRDBGrid;
                       ShowOF : boolean = true;
                       LandscapePageOrientation : Boolean = False);
  procedure ExportDBGridAndShow(Caption : string;
                       Note : string;
                       NameFile : string;
                       Grid : TCRDBGrid;
                       LandscapePageOrientation : Boolean = False);
  procedure ExportOraQuery(Caption : string;
                       Note : string;
                       NameFile : string;
                       Query : TOraQuery;
                       FieldNameStr : Array of String;
                       ShowOF : boolean = true;
                       LandscapePageOrientation : Boolean = False);

   procedure ExportOraQuery2(Caption: string; Note: string; NameFile: string;
                             Query: TOraQuery;FieldNameStr: Array of String; ShowOF: boolean = true;
                             LandscapePageOrientation: boolean = False; AddExcelColNumber: boolean = true);

  procedure AddData(const Xls: TExcelFile;
                    Grid : TCRDBGrid;
                    LandscapePageOrientation : Boolean;
                    Caption  : string;
                    Note : string);
  procedure AddData2(const Xls: TExcelFile;
                     Query : TOraQuery;
                     FieldNameStr : Array of String;
                     LandscapePageOrientation : Boolean;
                     Caption  : string;
                     Note : string;
                AddExcelColNumber: boolean = true);

  procedure ShowOpenDialog(const Xls: TExcelFile;
                           NameFile : string;
                           ShowOF : boolean);
  procedure ShowFile(const Xls: TExcelFile;
                     NameFile : string);
  function GET_EXCEL_FILE_NAME (pFileName : string) :String;

 Function GetSystemPath(SystemPath: TSystemPath): string;

implementation
uses DB, Math;

Function GetSystemPath(SystemPath: TSystemPath): string;
var
  p: pchar;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey
      ('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',
      True);
    case SystemPath of
      Desktop:
        Result := Reg.ReadString('Desktop');
      StartMenu:
        Result := Reg.ReadString('Start Menu');
      Programs:
        Result := Reg.ReadString('Programs');
      Startup:
        Result := Reg.ReadString('Startup');
      Personal:
        Result := Reg.ReadString('Personal');
      AppData:
        Result := Reg.ReadString('AppData');
      Cache:
        Result := Reg.ReadString('Cache');
      winroot:
        begin
          GetMem(p, 255);
          GetWindowsDirectory(p, 254);
          Result := StrPas(p);
          Freemem(p);
          // result := TPath.GetPathRoot;
        end;
      winsys:
        begin
          GetMem(p, 255);
          GetSystemDirectory(p, 254);
          Result := StrPas(p);
          Freemem(p);
        end;
      TMP:
        begin
          GetMem(p, 255);
          GetTempPath(254, p);

          Result := StrPas(p);
          Freemem(p);
          Result := TPath.GetTempPath;
        end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  if (Result <> '') and (Result[length(Result)] <> '\') then
    Result := Result + '\';
end;

function GET_EXCEL_FILE_NAME (pFileName : string) :String;
begin
  Result := pFileName +  ' создан ' + FormatDateTime('dd_mm_yyyy hh nn ss', now);
end;

procedure ExportDBGrid(
  Caption  : string;
  Note : string;
  NameFile : string;
  Grid : TCRDBGrid;
  ShowOF : boolean = true;
  LandscapePageOrientation : Boolean = False);
var
  Curs: TCursor;
  Xls: TExcelFile;
begin
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    Grid.DataSource.DataSet.DisableControls;
    try
      Xls := TXlsFile.Create(true);
      AddData(Xls,Grid,LandscapePageOrientation,Caption,Note);
      ShowOpenDialog(Xls,NameFile,ShowOF);
    //   CreateDocument(Caption,NameFile, Grid, arPrintColumn, LandscapePageOrientation);
    finally
      Screen.Cursor := Curs;
      Grid.DataSource.DataSet.EnableControls;
      FreeAndNil(Xls);
    end
  end;
end;

procedure ExportDBGridAndShow(Caption : string;
                       Note : string;
                       NameFile : string;
                       Grid : TCRDBGrid;
                       LandscapePageOrientation : Boolean = False);
var
  Curs: TCursor;
  Xls: TExcelFile;
begin
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    Grid.DataSource.DataSet.DisableControls;
    try
      Xls := TXlsFile.Create(true);
      AddData(Xls,Grid,LandscapePageOrientation,Caption,Note);
      ShowFile(Xls,NameFile);
    finally
      Screen.Cursor := Curs;
      Grid.DataSource.DataSet.EnableControls;
      FreeAndNil(Xls);
    end
  end;
end;

procedure ExportOraQuery(Caption : string;
                       Note : string;
                       NameFile : string;
                       Query : TOraQuery;
                       FieldNameStr : Array of String;
                       ShowOF : boolean = true;
                       LandscapePageOrientation : Boolean = False);
var
  Curs: TCursor;
  Xls: TExcelFile;
begin
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    Query.DisableControls;
//    Grid.DataSource.DataSet.DisableControls;
    try
      Xls := TXlsFile.Create(true);

      AddData2(Xls, Query,FieldNameStr,LandscapePageOrientation,Caption,Note);
      ShowOpenDialog(Xls,NameFile,ShowOF);
    //   CreateDocument(Caption,NameFile, Grid, arPrintColumn, LandscapePageOrientation);
    finally
      Screen.Cursor := Curs;
      Query.EnableControls;
//      Grid.DataSource.DataSet.EnableControls;
      FreeAndNil(Xls);
    end
  end;
end;

procedure AddData(const Xls: TExcelFile;
                Grid : TCRDBGrid;
                LandscapePageOrientation : Boolean;
                Caption  : string;
                Note : string);
  const
    MaxColumnWidth = 150.0;
    BufferSize = 1000;
  var
    ColNum,ColCount,k,p,i: integer;
    Col: TColumn;
    TempStr: string;
    fmt: TFlxFormat;
    XF, XF2,XF3,XF4: integer;
    CurrentRow: Integer;
    RowNum,cnt: integer;
    Wid: Real;
    DataSet : TDataSet;
    arColIndex: array of integer;
    arRecords: OleVariant;
    f : TField;
begin
	//Create a new file. We could also open an existing file with Xls.Open
	Xls.NewFile(1);
  ColCount:=0;
  CurrentRow := 4; // строка, с которой печатаются данные
  RowNum :=1;
  fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Color := clBlack;
  fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  fmt.FillPattern.FgColor := clGray;
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
	XF := Xls.AddFormat(fmt);
  Xls.SetCellValue(CurrentRow-1, 1, '№ п/п',XF);
  cnt := Grid.Columns.Count-1;
  for i:= 0 to cnt do
      if Grid.Columns[i].Visible then
      begin // Blob поля не распечатывать
      if Grid.Columns[i].Field<>nil then
        if not (Grid.Columns[i].Field.DataType in [ftOraBlob,ftOraClob,ftBlob]) then
        begin
          inc(ColCount);
          SetLength(arColIndex,ColCount);
          arColIndex[ColCount-1] := i;
        end;
    end;

  dec(ColCount);
//  ApplyFormat := TFlxApplyFormat.Create;
//  ApplyFormat.SetAllMembers(false);
//  ApplyFormat.Borders.SetAllMembers(true);  //We will only apply the borders to the existing cell formats

  for ColNum := 0 to ColCount do
    begin
      Col := Grid.Columns[arColIndex[ColNum]];
      Wid := abs(Col.Width/Grid.Font.Size)*1.2;
      if Wid < 0.0 then
        Wid := 0.0;
      if Wid > MaxColumnWidth then
        Wid := MaxColumnWidth;
   //   Xls.SetColWidth(ColNum+2,round(Wid));
    //  Xls.SetCellFormat(CurrentRow-1, ColNum+2, XF);
      Xls.SetCellValue(CurrentRow-1, ColNum+2, StringReplace(Col.Title.Caption, '|', ' ', [rfReplaceAll]), XF);
    end;

    fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
    fmt.Font.Name := 'Times New Roman';
    fmt.Font.Style := [TFlxFontStyles.Bold];
    fmt.HAlignment := THFlxAlignment.center;
    fmt.VAlignment := TVFlxAlignment.center;
    XF2 := Xls.AddFormat(fmt);
  	//Apply a custom format to all the row.
  	Xls.SetRowFormat(1, XF2);
    Xls.MergeCells(1, 1, 1, ColNum+1);
    k := 1;
    TempStr := Caption;
    p := pos(#10,TempStr);
    while p > 0 do
    begin
     p := pos(#10,TempStr);
     TempStr := copy(TempStr,p+2,length(TempStr));
      inc(k);
    end;
    Xls.SetRowHeight(1,Xls.GetRowHeight(1)*k);
    Xls.SetCellValue(1,1,Caption);
    DataSet := Grid.DataSource.DataSet;
    DataSet.First;
    fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
    fmt.Font.Name := 'Times New Roman';
    fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
    fmt.WrapText:=true;
    XF3 := Xls.AddFormat(fmt);
    while not DataSet.Eof do
    begin
        for ColNum := 1 to ColCount+2 do
        begin
//          arRecords[j-1, ColNum] := Grid.Columns[arPrintColumn[ColNum-1]].Field.Value;
          if colnum = 1  then
            Xls.SetCellValue(CurrentRow,ColNum,RowNum)
          else begin
            f := Grid.Columns[arColIndex[ColNum-2]].Field;
            if (f Is TNumericField)
             and not f.IsNull
              and not Assigned(f.OnGetText) then
              Xls.SetCellValue(CurrentRow,ColNum,f.Value)
            else
              Xls.SetCellValue(CurrentRow,ColNum,Copy(f.Text, 1, 900));
          end;
          Xls.SetCellFormat(CurrentRow,ColNum, XF3);
        end;
        inc(CurrentRow);
        inc(RowNum);
        DataSet.Next;
    end;
	//Make the page print in landscape or portrait mode
	Xls.PrintLandscape := LandscapePageOrientation;
  xls.AutofitCol(1,ColCount+2,false,1);
  fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Size20 :=150;
  fmt.WrapText:=true;
  XF4 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(CurrentRow, XF4);
  Xls.MergeCells(CurrentRow, 1, CurrentRow, ColNum-1);
  Xls.SetCellValue(CurrentRow,1,Note);
end;

procedure ExportOraQuery2(Caption: string; Note: string; NameFile: string;
  Query: TOraQuery;FieldNameStr: Array of String; ShowOF: boolean = true;
  LandscapePageOrientation: boolean = False; AddExcelColNumber: boolean = true);
var
  Curs: TCursor;
  Xls: TExcelFile;
  bm: TBookmark;
begin
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    Query.DisableControls;
    bm := Query.GetBookmark;
    try
      Xls := TXlsFile.Create(true);
      AddData2(Xls, Query, FieldNameStr, LandscapePageOrientation, Caption, Note, AddExcelColNumber);
      ShowOpenDialog(Xls, NameFile, ShowOF);
    finally
      Query.GotoBookmark(bm);
      Screen.Cursor := Curs;
      Query.EnableControls;
      Query.FreeBookmark(bm);
      FreeAndNil(Xls);
    end
  end;
end;


procedure AddData2(const Xls: TExcelFile;
                Query : TOraQuery;
                FieldNameStr : Array of String;
                LandscapePageOrientation : Boolean;
                Caption  : string;
                Note : string;
                AddExcelColNumber: boolean = true);
  var
    ColNum,ColCount,k,p: integer;
    Field:TField;
    TempStr: string;
    fmt: TFlxFormat;
    XF, XF2,XF3,XF4: integer;
    CurrentRow : Integer;
    RowNum: integer;
begin
	//Create a new file. We could also open an existing file with Xls.Open
	Xls.NewFile(1);
  CurrentRow := 4; // строка, с которой печатаются данные
  RowNum :=1;
  fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Color := clBlack;
  fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  fmt.FillPattern.FgColor := clSkyBlue;//clGray;
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
	XF := Xls.AddFormat(fmt);
  Xls.SetCellValue(CurrentRow-1, 1, '№ п/п',XF);
  ColCount := length(FieldNameStr)-1;
  for ColNum := 0 to ColCount do
    begin
      Field := Query.FieldByName(FieldNameStr[ColNum]);
      Xls.SetCellValue(CurrentRow-1, ColNum+2, Field.DisplayLabel, XF);
    end;

    fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
    fmt.Font.Name := 'Times New Roman';
    fmt.Font.Style := [TFlxFontStyles.Bold];
    fmt.HAlignment := THFlxAlignment.center;
    fmt.VAlignment := TVFlxAlignment.center;
    XF2 := Xls.AddFormat(fmt);
  	//Apply a custom format to all the row.
  	Xls.SetRowFormat(1, XF2);
    Xls.MergeCells(1, 1, 1, ColNum+1);
    k := 1;
    TempStr := Caption;
    p := pos(#10,TempStr);
    while p > 0 do
    begin
     p := pos(#10,TempStr);
     TempStr := copy(TempStr,p+2,length(TempStr));
      inc(k);
    end;
    Xls.SetRowHeight(1,Xls.GetRowHeight(1)*k);
    Xls.SetCellValue(1,1,Caption);
    Query.First;
    fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
    fmt.Font.Name := 'Times New Roman';
    fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
    fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
    fmt.WrapText:=true;
    XF3 := Xls.AddFormat(fmt);
    while not Query.Eof do
    begin
        for ColNum := 1 to ColCount+2 do
          if colnum = 1  then
            Xls.SetCellValue(CurrentRow,ColNum,RowNum,XF3)
          else
            Xls.SetCellValue(CurrentRow,ColNum, Query.FieldByName(FieldNameStr[ColNum-2]).AsString, XF3);
        inc(CurrentRow);
        inc(RowNum);
        Query.Next;
    end;
	//Make the page print in landscape or portrait mode
	Xls.PrintLandscape := LandscapePageOrientation;
  xls.AutofitCol(1,ColCount+2,false,1);
  fmt := Xls.GetDefaultFormat;  //Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Size20 :=150;
  fmt.WrapText:=true;
  XF4 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(CurrentRow, XF4);
  Xls.MergeCells(CurrentRow, 1, CurrentRow, ColNum-1);
  Xls.SetCellValue(CurrentRow,1,Note);
end;

procedure ShowOpenDialog(const Xls: TExcelFile;NameFile : string; ShowOF : boolean);
Var SaveDialog : dialogs.TSaveDialog;
  PdfStream: TFileStream;
  Pdf: TFlexCelPdfExport;
  st,fn:string;
  m:TXlsMargins;
begin
  if ShowOF then begin
    SaveDialog:=TSaveDialog.Create(nil);
    SaveDialog.Filter:='Excel 2007/ newer|*.xlsx|Excel 5-2003|*.xls|PDF|*.pdf';
    SaveDialog.DefaultExt:='xlsx';
    SaveDialog.FileName:=NameFile;
    SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
//  SaveDialog.Options:=[];
    if SaveDialog.Execute then  begin
      fn:=SaveDialog.FileName;
      FreeAndNil(SaveDialog);
    end
    else begin
      FreeAndNil(SaveDialog);
      exit;
    end;
  end
  else fn := ExtractFilePath(Application.ExeName) + NameFile + '.xls';
  st:=copy(fn,length(fn)-2,3);
  if st='pdf' then begin
    PdfStream := TFileStream.Create(fn, fmCreate);
    try
      Pdf := TFlexCelPdfExport.Create;
      Pdf.AllowOverwritingFiles := true;
      Xls.PrintScale := 65;
      m := TXlsMargins.Create;
      m.Left := 0.2;
      m.Top := 0.1;
      m.Right := 0.1;
      m.Bottom := 0.1;
      m.Footer := 0.1;
      m.Header := 0.1;
      Xls.SetPrintMargins(m);
      if Pdf.Workbook = nil then Pdf.Workbook := Xls;
      Pdf.BeginExport(PdfStream);
      Pdf.PageLayout := TPageLayout.Outlines;  //To how the bookmarks when opening the file.
      Pdf.ExportAllVisibleSheets(false, TPath.GetFileNameWithoutExtension(fn));
      Pdf.EndExport;
    finally
      FreeAndNil(Pdf);
      FreeAndNil(PdfStream);
    end;
  end
  else begin
      Xls.Save(fn); //No need to delete the file first, since AllowOverWriteFiles is true in XlsAdapter.
  end;
 // if ShowOF then
 //   if MessageDlg('Вы хотите открыть созданный файл?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
 //   begin
      ShellExecute(0, 'open', PCHAR(fn), nil, nil, SW_SHOWNORMAL);
 //   end;
end;

procedure ShowFile(const Xls: TExcelFile;
                   NameFile : string);
Var
  fn:string;
begin
  fn := ExtractFilePath(Application.ExeName) + NameFile + '.xls';
  Xls.Save(fn);
  ShellExecute(0, 'open', PCHAR(fn), nil, nil, SW_SHOWNORMAL);
end;

end.
