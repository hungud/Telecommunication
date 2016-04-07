unit ExportGridToExcelPDF;

interface

uses DBGrids, Windows, Messages, SysUtils, VCL.FlexCel.Core, FlexCel.XlsAdapter,
  Forms, FlexCel.Render, FlexCel.Pdf, ToolWin, IOUtils, Ora, Data.DB, Math,  System.StrUtils,
  Variants, Classes, Graphics, Controls, StdCtrls, CRGrid, ShellAPI, dialogs, System.DateUtils,
  TimedMsgBox, Func_Const ;


procedure ExportOraQuery(Caption: string;
                          Note: string;
                          NameFile: string;
                          Query: TOraQuery;
                          FieldNameStr: TColumn_Array;
                          ShowOF: boolean = true;
                          LandscapePageOrientation: boolean = False;
                          AddExcelColNumber: boolean = true);

procedure AddData(const Xls: TExcelFile;
                   Query: TOraQuery;
                   FieldNameStr: TColumn_Array;
                   LandscapePageOrientation: boolean;
                   Caption: string;
                   Note: string;
                   AddExcelColNumber: boolean = true);

procedure ExportOraQuery2(Caption: string;
                          Note: string;
                          NameFile: string;
                          Query: TOraQuery;
                          FieldNameStr: Array of String;
                          ShowOF: boolean = true;
                          LandscapePageOrientation: boolean = False;
                          AddExcelColNumber: boolean = true);

procedure AddData2(const Xls: TExcelFile;
                         Query: TOraQuery;
                         FieldNameStr: Array of String; LandscapePageOrientation: boolean;
                         Caption: string;
                         Note: string;
                         AddExcelColNumber: boolean = true);

procedure ShowOpenDialog(const Xls: TExcelFile;
                         NameFile: string;
                         ShowOF: boolean);

procedure FullContentXls(Xls :TExcelFile; zagolovok : string; Query: TOraQuery);

procedure FullFieldFromExcel(const xls :TExcelFile;
                             const Row, Col: integer;
                             var Fld :TField);


function LoadersBillCreate( Query: TOraQuery; Id : Integer; period : String) : string;

procedure ChangeRowXls(Xls :TExcelFile);

implementation

function LoadersBillCreate(Query: TOraQuery; Id : Integer; period : String) : string;
var
  Curs: TCursor;
  Xls: TExcelFile;
  Pdf: TFlexCelPdfExport;
  PdfStream: TFileStream;
  PdfFileName : string;
begin
  Curs := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  Xls := TXlsFile.Create(true);
  Result := '';
  try
    FullContentXls(Xls, period, Query);
    Pdf := TFlexCelPdfExport.Create(xls, true);
    try
      // в темп пишем, затем удалим после записи в блоб
      PdfFileName := GetSystemPath(TMP) + IntToStr(Id) + '.pdf';
      PdfStream := TFileStream.Create(PdfFileName, fmCreate);
      try
        Pdf.BeginExport(PdfStream);
        Pdf.PageLayout := TPageLayout.Outlines;
        Pdf.ExportAllVisibleSheets(false, 'Cформированный клиенту счет');
        Pdf.EndExport();
      finally
        PdfStream.Free;
      end;
    finally
      Pdf.Free;
    end;
  finally
    Screen.Cursor := Curs;
    FreeAndNil(Xls);
  end;
  Result := PdfFileName;
end;

procedure ChangeRowXls(Xls :TExcelFile);
var
 row : Integer;
begin
  for row := 1 to Xls.RowCount do
  begin
    xls.SetAutoRowHeight(row, false);
  end;
end;

procedure FullContentXls(Xls :TExcelFile; zagolovok : string; Query: TOraQuery);
var
  lblfmt, zag_fmt,
  Column1Fmt, Column2Fmt,
  Column1FmtOdd, Column2FmtOdd,
  Column1ItogFmt, Column2ItogFmt: TFlxFormat;
  row, cnt : Integer;
  RangeName: string;
begin
  Query.First;
  // прежде всего - создадим новый файл
  xls.NewFile(1, TExcelFileFormat.v2013);
  // параметры принтера
  xls.SetPrintMargins(TXlsMargins.Create(1.2, 0.13, 0.185, 0.11, 0.3, 0.3));
  xls.PrintXResolution := 600;
  xls.PrintYResolution := 600;
  xls.PrintOptions := [];
  xls.PrintPaperSize := TPaperSize.Letter;
  RangeName := TXlsNamedRange.GetInternalName(TInternalNameRange.Print_Area);

  // альбомная ориентация бумаги
  Xls.PrintLandscape := true;

  /// устанавливаем 8 разных форматов
  lblfmt := xls.GetDefaultFormat;
  lblfmt.Font.Size20 := 280;
  lblfmt.Font.Style := [TFlxFontStyles.Bold];
  lblfmt.HAlignment := THFlxAlignment.center;
  lblfmt.VAlignment := TVFlxAlignment.center;

  zag_fmt := xls.GetDefaultFormat;
  zag_fmt.Font.Name := 'Times New Roman';
  zag_fmt.Font.Size20 := 240;
  zag_fmt.Font.Color := TUIColor.FromArgb($00, $00, $00);
  zag_fmt.Font.Style := [TFlxFontStyles.Bold];
  zag_fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  zag_fmt.Borders.Left.Color := TExcelColor.Automatic;
  zag_fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  zag_fmt.Borders.Right.Color := TExcelColor.Automatic;
  zag_fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  zag_fmt.Borders.Top.Color := TExcelColor.Automatic;
  zag_fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  zag_fmt.Borders.Bottom.Color := TExcelColor.Automatic;
  zag_fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  //zag_fmt.FillPattern.FgColor := TUIColor.FromArgb($A6, $CA, $F0);
  zag_fmt.FillPattern.FgColor := TExcelColor.FromTheme(TThemeColor.Accent1, 0.799981688894314);
  zag_fmt.FillPattern.BgColor := TExcelColor.Automatic;
  zag_fmt.HAlignment := THFlxAlignment.center;
  zag_fmt.VAlignment := TVFlxAlignment.center;
  zag_fmt.WrapText := true;

  Column1Fmt := xls.GetDefaultFormat;
  Column1Fmt.Font.Size20 := 240;
  Column1Fmt.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column1Fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column1Fmt.Borders.Left.Color := TExcelColor.Automatic;
  Column1Fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column1Fmt.Borders.Right.Color := TExcelColor.Automatic;
  Column1Fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column1Fmt.Borders.Bottom.Color := TExcelColor.Automatic;
  Column1Fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  Column1Fmt.FillPattern.FgColor := TUIColor.FromArgb($EF, $F0, $FF);
  Column1Fmt.FillPattern.BgColor := TExcelColor.Automatic;
  Column1Fmt.HAlignment := THFlxAlignment.center;
  Column1Fmt.VAlignment := TVFlxAlignment.center;
  Column1Fmt.WrapText := true;

  Column2Fmt := xls.GetDefaultFormat;
  Column2Fmt.Font.Size20 := 240;
  Column2Fmt.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column2Fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column2Fmt.Borders.Left.Color := TExcelColor.Automatic;
  Column2Fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column2Fmt.Borders.Right.Color := TExcelColor.Automatic;
  Column2Fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column2Fmt.Borders.Bottom.Color := TExcelColor.Automatic;
  Column2Fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  Column2Fmt.FillPattern.FgColor := TUIColor.FromArgb($EF, $F0, $FF);
  Column2Fmt.FillPattern.BgColor := TExcelColor.Automatic;
  Column2Fmt.Format := '0.00';
  Column2Fmt.HAlignment := THFlxAlignment.right;
  Column2Fmt.VAlignment := TVFlxAlignment.center;
  Column2Fmt.WrapText := true;

  Column1FmtOdd := xls.GetDefaultFormat;
  Column1FmtOdd.Font.Size20 := 240;
  Column1FmtOdd.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column1FmtOdd.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column1FmtOdd.Borders.Left.Color := TExcelColor.Automatic;
  Column1FmtOdd.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column1FmtOdd.Borders.Right.Color := TExcelColor.Automatic;
  Column1FmtOdd.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column1FmtOdd.Borders.Bottom.Color := TExcelColor.Automatic;
  Column1FmtOdd.FillPattern.Pattern := TFlxPatternStyle.Solid;
  Column1FmtOdd.FillPattern.FgColor := TUIColor.FromArgb($F8, $F8, $F8);
  Column1FmtOdd.FillPattern.BgColor := TExcelColor.Automatic;
  Column1FmtOdd.HAlignment := THFlxAlignment.center;
  Column1FmtOdd.VAlignment := TVFlxAlignment.center;
  Column1FmtOdd.WrapText := true;

  Column2FmtOdd := xls.GetDefaultFormat;
  Column2FmtOdd.Font.Size20 := 240;
  Column2FmtOdd.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column2FmtOdd.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column2FmtOdd.Borders.Left.Color := TExcelColor.Automatic;
  Column2FmtOdd.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column2FmtOdd.Borders.Right.Color := TExcelColor.Automatic;
  Column2FmtOdd.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column2FmtOdd.Borders.Bottom.Color := TExcelColor.Automatic;
  Column2FmtOdd.FillPattern.Pattern := TFlxPatternStyle.Solid;
  Column2FmtOdd.FillPattern.FgColor := TUIColor.FromArgb($F8, $F8, $F8);
  Column2FmtOdd.FillPattern.BgColor := TExcelColor.Automatic;
  Column2FmtOdd.Format := '0.00';
  Column2FmtOdd.HAlignment := THFlxAlignment.right;
  Column2FmtOdd.VAlignment := TVFlxAlignment.center;
  Column2FmtOdd.WrapText := true;

  Column1ItogFmt := xls.GetDefaultFormat;
  Column1ItogFmt.Font.Size20 := 240;
  Column1ItogFmt.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column1ItogFmt.Font.Style := [TFlxFontStyles.Bold];
  Column1ItogFmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column1ItogFmt.Borders.Left.Color := TExcelColor.Automatic;
  Column1ItogFmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column1ItogFmt.Borders.Right.Color := TExcelColor.Automatic;
  Column1ItogFmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column1ItogFmt.Borders.Bottom.Color := TExcelColor.Automatic;
  Column1ItogFmt.HAlignment := THFlxAlignment.right;
  Column1ItogFmt.VAlignment := TVFlxAlignment.center;
  Column1ItogFmt.WrapText := true;

  Column2ItogFmt := xls.GetDefaultFormat;
  Column2ItogFmt.Font.Size20 := 240;
  Column2ItogFmt.Font.Color := TUIColor.FromArgb($00, $00, $00);
  Column2ItogFmt.Font.Style := [TFlxFontStyles.Bold];
  Column2ItogFmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  Column2ItogFmt.Borders.Left.Color := TExcelColor.Automatic;
  Column2ItogFmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  Column2ItogFmt.Borders.Right.Color := TExcelColor.Automatic;
  Column2ItogFmt.Format := '0.00';
  Column2ItogFmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  Column2ItogFmt.Borders.Bottom.Color := TExcelColor.Automatic;
  Column2ItogFmt.HAlignment := THFlxAlignment.right;
  Column2ItogFmt.VAlignment := TVFlxAlignment.center;
  Column2ItogFmt.WrapText := true;
//////////
  xls.FormulaReferenceStyle := TReferenceStyle.R1C1;
  xls.ActiveSheet := 1;
  xls.SheetName := 'Отчет по расходам';
  xls.ActiveSheet := 1;


  xls.DefaultColWidth := 2925;
  xls.DefaultRowHeight := 255;

  xls.SetColWidth(1, 1, 3766);  //(13.96 + 0.75) * 256
  xls.SetColWidth(2, 2, 3437);  //(12.68 + 0.75) * 256
  xls.SetColWidth(3, 10, 2669);  //(9.68 + 0.75) * 256

  xls.SetRowHeight(2, 300);  //12.75 * 20
  xls.SetRowHeight(3, 300);  //12.75 * 20
  xls.SetRowHeight(4, 300);  //12.75 * 20
  xls.SetRowHeight(6, 630);  //31.50 * 20

  xls.SetRowHeight(7, 405);  //20.25 * 20
  xls.SetRowHeight(8, 405);  //20.25 * 20
  xls.SetRowHeight(9, 405);  //20.25 * 20
  xls.SetRowHeight(10, 405);  //20.25 * 20
  xls.SetRowHeight(11, 405);  //20.25 * 20
  xls.SetRowHeight(12, 405);  //20.25 * 20
  xls.SetRowHeight(13, 405);  //20.25 * 20
  xls.SetRowHeight(14, 405);  //20.25 * 20
  xls.SetRowHeight(15, 405);  //20.25 * 20
  xls.SetRowHeight(16, 405);  //20.25 * 20

  /// Строки над заголовком
  xls.MergeCells(2, 1, 2, 10);
  xls.MergeCells(3, 1, 3, 10);
  xls.MergeCells(4, 1, 4, 10);
  xls.SetCellFormat(2, 1, xls.AddFormat(lblfmt));
  xls.SetCellValue (2, 1, 'Отчет по расходам за услуги Сети ООО "Интернет Системы"');
  xls.SetCellFormat(3, 1, xls.AddFormat(lblfmt));
  xls.SetCellValue (3, 1, ' за период '+ AnsiLowerCase(zagolovok) + ' года');
  xls.SetCellFormat(4, 1, xls.AddFormat(lblfmt));
  xls.SetCellValue (4, 1, 'для ' + Query.FieldByName('VIRTUAL_ACCOUNTS_name').AsString);

  ////формируем заголовок
  xls.SetRowHeight (6, 630);  //31.50 * 20
  xls.SetCellFormat(6, 1, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 1, 'Номер телефона');
  xls.SetCellFormat(6, 2, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 2, 'Телефония мест.');
  xls.SetCellFormat(6, 3, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 3, 'Телефония МГ, МН');
  xls.SetCellFormat(6, 4, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 4, 'Сообщения');
  xls.SetCellFormat(6, 5, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 5, 'Моб. интернет');
  xls.SetCellFormat(6, 6, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 6, 'Доп. услуги');
  xls.SetCellFormat(6, 7, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 7, 'Абон. плата');
  xls.SetCellFormat(6, 8, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 8, 'Роуминг МН');
  xls.SetCellFormat(6, 9, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 9, 'Роуминг ВН, НАЦ.');
  xls.SetCellFormat(6, 10, xls.AddFormat(zag_fmt));
  xls.SetCellValue (6, 10, 'Счет Клиенту');
  // сформировали заголовок, теперь тело отчета
  /////////////////////////////
  row := 6;
  cnt :=  Query.RecordCount + row;
  Query.First;
  while not Query.eof do
  begin
    row := row + 1;
   /// 1
    if (row = cnt) then
      xls.SetCellFormat(row, 1, xls.AddFormat(Column1ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 1, xls.AddFormat(Column1FmtOdd))
       else
         xls.SetCellFormat(row, 1, xls.AddFormat(Column1Fmt));
    xls.SetCellValue(row, 1, Query.FieldByName('PHONE_ID').AsString);

    /// 2
    if (row = cnt) then
      xls.SetCellFormat(row, 2, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 2, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 2, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 2, Query.FieldByName('CALL_LOCAL').AsCurrency);

    /// 3
    if (row = cnt) then
      xls.SetCellFormat(row, 3, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 3, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 3, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 3, Query.FieldByName('CALL_INTERCITY').AsCurrency); //Query.FieldByName('CALL_INTERCITY').AsCurrency);

    /// 4
    if (row = cnt) then
      xls.SetCellFormat(row, 4, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 4, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 4, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 4, Query.FieldByName('MESSAGE').AsCurrency);

    /// 5
    if (row = cnt) then
      xls.SetCellFormat(row, 5, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 5, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 5, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 5, Query.FieldByName('INTERNET').AsCurrency);

    /// 6
    if (row = cnt) then
      xls.SetCellFormat(row, 6, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 6, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 6, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 6, Query.FieldByName('OTHERS_SERVISES').AsCurrency);

    /// 7
    if (row = cnt) then
      xls.SetCellFormat(row, 7, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 7, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 7, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 7, Query.FieldByName('SUBSCRIPTION_SUM').AsCurrency);

    /// 8
    if (row = cnt) then
      xls.SetCellFormat(row, 8, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 8, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 8, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 8, Query.FieldByName('INTERNATIONAL_ROAMING').AsCurrency);

    /// 9
    if (row = cnt) then
      xls.SetCellFormat(row, 9, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 9, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 9, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 9, Query.FieldByName('NATIONAL_INTRANET_ROAMING').AsCurrency);

    /// 10
    if (row = cnt) then
      xls.SetCellFormat(row, 10, xls.AddFormat(Column2ItogFmt))
    else
      if Odd(row) then
         xls.SetCellFormat(row, 10, xls.AddFormat(Column2FmtOdd))
       else
         xls.SetCellFormat(row, 10, xls.AddFormat(Column2Fmt));
    xls.SetCellValue(row, 10, Query.FieldByName('ALL_CLIENT_SCHET').AsCurrency);


    Query.Next;

    xls.SetRowHeight(row, 405);
    xls.SetAutoRowHeight(row, false);

  end;

end;

procedure ExportOraQuery(Caption: string; Note: string; NameFile: string;
  Query: TOraQuery; FieldNameStr: TColumn_Array; ShowOF: boolean = true;
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
      AddData(Xls, Query, FieldNameStr, LandscapePageOrientation, Caption, Note, AddExcelColNumber);
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

procedure AddData(const Xls: TExcelFile; Query: TOraQuery;
  FieldNameStr: TColumn_Array; LandscapePageOrientation: boolean;
  Caption: string; Note: string; AddExcelColNumber: boolean = true);
var
  dob, r, ColNum, ColCount, k, p: integer;
  str, TempStr: string;
  fmt: TFlxFormat;
  XF, XF2, XF3, XF4, XFDate, XFDateTime: integer;
  CurrentRow: integer;
  RowNum: integer;
  ft :TFieldType;
begin
  // Create a new file. We could also open an existing file with Xls.Open
  Xls.NewFile(1);
  CurrentRow := 4; // строка, с которой печатаются данные
  RowNum := 1;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Color := clBlack;
  fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  fmt.FillPattern.FgColor := clSkyBlue; // clGray;
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
  XF := Xls.AddFormat(fmt);
  if AddExcelColNumber then
  begin
    dob := 2;
    Xls.SetCellValue(CurrentRow - 1, 1, '№ п/п', XF);
  end
  else
    dob := 1;

  ColCount := length(FieldNameStr) - 1;
  r := 0;
  for ColNum := 0 to ColCount do
  begin
    Xls.SetCellValue(CurrentRow - 1, ColNum + dob,
      FieldNameStr[ColNum].DisplayLabel, XF);
    r := ColNum;
  end;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Style := [TFlxFontStyles.Bold];
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
  XF2 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(1, XF2);
  Xls.MergeCells(1, 1, 1, r + dob);
  k := 1;
  TempStr := Caption;
  p := pos(#10, TempStr);
  while p > 0 do
  begin
    p := pos(#10, TempStr);
    TempStr := copy(TempStr, p + 2, length(TempStr));
    inc(k);
  end;
  Xls.SetRowHeight(1, Xls.GetRowHeight(1) * k);
  //Xls.SetCellValue(1, 1, Caption);
  Xls.SetCellValue(1, 1, TempStr);

  Query.First;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.WrapText := true;
  fmt.VAlignment := TVFlxAlignment.center;
  XF3 := Xls.AddFormat(fmt);
  fmt.Format := 'dd/mm/yyyy\ hh:mm:ss';
  XFDateTime := Xls.AddFormat(fmt);
  fmt.Format := 'dd/mm/yyyy';
  XFDate := Xls.AddFormat(fmt);

  while not Query.Eof do
  begin
    for ColNum := 1 to ColCount + dob do
    begin
      if (ColNum = 1) and AddExcelColNumber then
        Xls.SetCellValue(CurrentRow, ColNum, RowNum, XF3)
      else
      begin
        ft := Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).DataType;
        case ft of
          ftSmallint, ftInteger, ftWord:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsInteger, XF3);
          ftFloat:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsFloat, XF3);
          ftCurrency:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsCurrency, XF3);
          ftDate:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsDateTime, XFDate);
          ftTime, ftDateTime:
          begin
            Str := TimeToStr(Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsDateTime);
            if (Str = '0:00:00') then
              Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsDateTime, XFDate)
            else
              Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsDateTime, XFDateTime);
          end;
        else
          Str := Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsString;
          if Str = 'True' then
            Str := 'Да';
          if Str = 'False' then
            Str := 'Нет';
          Xls.SetCellValue(CurrentRow, ColNum, Str, XF3);
        end;
      end;

      {
      if (ColNum = 1) and AddExcelColNumber then
        Xls.SetCellValue(CurrentRow, ColNum, RowNum, XF3)
      else
      begin
        Str := Query.FieldByName(FieldNameStr[ColNum - dob].FieldName).AsString;
        if Str = 'True' then
          Str := 'Да';
        if Str = 'False' then
          Str := 'Нет';

        Xls.SetCellValue(CurrentRow, ColNum, Str, XF3);
      end;
      }


      r := ColNum;
    end;
    inc(CurrentRow);
    inc(RowNum);
    Query.Next;
  end;
  // Make the page print in landscape or portrait mode
  Xls.PrintLandscape := LandscapePageOrientation;
  Xls.AutofitCol(1, ColCount + 2, False, 1);
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Size20 := 150;
  fmt.WrapText := true;
  XF4 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(CurrentRow, XF4);
  Xls.MergeCells(CurrentRow, 1, CurrentRow, r - 1);
  Xls.SetCellValue(CurrentRow, 1, Note);
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

procedure AddData2(const Xls: TExcelFile; Query: TOraQuery;
  FieldNameStr: Array of String; LandscapePageOrientation: boolean;
  Caption: string; Note: string; AddExcelColNumber: boolean = true);
var
  dob, r, ColNum, ColCount, k, p: integer;
  str, TempStr: string;
  fmt: TFlxFormat;
  Field: TField;
  XF, XF2, XF3, XF4, XFDate, XFDateTime: integer;
  CurrentRow: integer;
  RowNum: integer;
  ft :TFieldType;
begin
  // Create a new file. We could also open an existing file with Xls.Open
  Xls.NewFile(1);
  CurrentRow := 4; // строка, с которой печатаются данные
  RowNum := 1;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Color := clBlack;
  fmt.FillPattern.Pattern := TFlxPatternStyle.Solid;
  fmt.FillPattern.FgColor := clSkyBlue; // clGray;
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
  XF := Xls.AddFormat(fmt);
  if AddExcelColNumber then
  begin
    dob := 2;
    Xls.SetCellValue(CurrentRow - 1, 1, '№ п/п', XF);
  end
  else
    dob := 1;

  ColCount := length(FieldNameStr) - 1;
  r := 0;
  for ColNum := 0 to ColCount do
  begin
    Field := Query.FieldByName(FieldNameStr[ColNum]);
    Xls.SetCellValue(CurrentRow - 1, ColNum + dob, Field.DisplayLabel, XF);
    //Xls.SetCellValue(CurrentRow - 1, ColNum + dob, FieldNameStr[ColNum].DisplayLabel, XF);
    r := ColNum;
  end;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Style := [TFlxFontStyles.Bold];
  fmt.HAlignment := THFlxAlignment.center;
  fmt.VAlignment := TVFlxAlignment.center;
  XF2 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(1, XF2);
  Xls.MergeCells(1, 1, 1, r + dob);
  k := 1;
  TempStr := Caption;
  p := pos(#10, TempStr);
  while p > 0 do
  begin
    p := pos(#10, TempStr);
    TempStr := copy(TempStr, p + 2, length(TempStr));
    inc(k);
  end;
  Xls.SetRowHeight(1, Xls.GetRowHeight(1) * k);
  //Xls.SetCellValue(1, 1, Caption);
  Xls.SetCellValue(1, 1, TempStr);

  Query.First;
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Borders.Left.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Right.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Top.Style := TFlxBorderStyle.Thin;
  fmt.Borders.Bottom.Style := TFlxBorderStyle.Thin;
  fmt.VAlignment := TVFlxAlignment.center;
  fmt.WrapText := true;
  XF3 := Xls.AddFormat(fmt);
  fmt.Format := 'dd/mm/yyyy\ hh:mm:ss';
  XFDateTime := Xls.AddFormat(fmt);
  fmt.Format := 'dd/mm/yyyy';
  XFDate := Xls.AddFormat(fmt);

  while not Query.Eof do
  begin
    for ColNum := 1 to ColCount + dob do
    begin
      if (ColNum = 1) and AddExcelColNumber then
        Xls.SetCellValue(CurrentRow, ColNum, RowNum, XF3)
      else
      begin
        ft := Query.FieldByName(FieldNameStr[ColNum - dob]).DataType;
        case ft of
          ftSmallint, ftInteger, ftWord:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsInteger, XF3);
          ftFloat:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsFloat, XF3);
          ftCurrency:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsCurrency, XF3);
          ftDate:
            Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsDateTime, XFDate);
          ftTime, ftDateTime:
          begin
            Str := TimeToStr(Query.FieldByName(FieldNameStr[ColNum - dob]).AsDateTime);
            if (Str = '0:00:00') then
              Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsDateTime, XFDate)
            else
              Xls.SetCellValue(CurrentRow, ColNum, Query.FieldByName(FieldNameStr[ColNum - dob]).AsDateTime, XFDateTime);
          end;
        else
          Str := Query.FieldByName(FieldNameStr[ColNum - dob]).AsString;
          if Str = 'True' then
            Str := 'Да';
          if Str = 'False' then
            Str := 'Нет';
          Xls.SetCellValue(CurrentRow, ColNum, Str, XF3);
        end;
      end;

      r := ColNum;
    end;
    inc(CurrentRow);
    inc(RowNum);
    Query.Next;
  end;
  // Make the page print in landscape or portrait mode
  Xls.PrintLandscape := LandscapePageOrientation;
  Xls.AutofitCol(1, ColCount + 2, False, 1);
  fmt := Xls.GetDefaultFormat;
  // Always initialize the record with an existing format.
  fmt.Font.Name := 'Times New Roman';
  fmt.Font.Size20 := 150;
  fmt.WrapText := true;
  XF4 := Xls.AddFormat(fmt);
  Xls.SetRowFormat(CurrentRow, XF4);
  Xls.MergeCells(CurrentRow, 1, CurrentRow, r - 1);
  Xls.SetCellValue(CurrentRow, 1, Note);
end;

procedure ShowOpenDialog(const Xls: TExcelFile; NameFile: string;
  ShowOF: boolean);
Var
  SaveDialog: dialogs.TSaveDialog;
  PdfStream: TFileStream;
  Pdf: TFlexCelPdfExport;
  st, fn: string;
  m: TXlsMargins;
begin
  if ShowOF then
  begin
    SaveDialog := TSaveDialog.Create(nil);
    SaveDialog.Filter :=
      'Excel 2007/ newer|*.xlsx|Excel 5-2003|*.xls|PDF|*.pdf';
    SaveDialog.DefaultExt := 'xlsx';
    SaveDialog.FileName := NameFile;
    SaveDialog.InitialDir := GetSystemPath(Personal);
    // ExtractFilePath(Application.ExeName);
    SaveDialog.Title := 'Укажите имя файла для сохранения';
    if SaveDialog.Execute then
    begin
      fn := SaveDialog.FileName;
      FreeAndNil(SaveDialog);
    end
    else
    begin
      FreeAndNil(SaveDialog);
      exit;
    end;
  end
  else
    fn := GetSystemPath(Personal) + NameFile + '.xls';

  st := copy(fn, length(fn) - 2, 3);
  if st = 'pdf' then
  begin
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
      if Pdf.Workbook = nil then
        Pdf.Workbook := Xls;
      Pdf.BeginExport(PdfStream);
      Pdf.PageLayout := TPageLayout.Outlines;
      // To how the bookmarks when opening the file.
      Pdf.ExportAllVisibleSheets(False, TPath.GetFileNameWithoutExtension(fn));
      Pdf.EndExport;
    finally
      FreeAndNil(Pdf);
      FreeAndNil(PdfStream);
    end;
  end
  else
  begin
    Xls.Save(fn);
  end;
  ShellExecute(0, 'open', PCHAR(fn), nil, nil, SW_SHOWNORMAL);
end;

procedure FullFieldFromExcel(const xls :TExcelFile; const Row, Col: integer; var Fld :TField);
var
  v: TCellValue;
  CellType, CellValue: String;
  HasDate, HasTime: boolean;
  CellColor: TUIColor;
begin
  v := xls.GetCellValue(Row, Col);
  try

  case v.ValueType of
    TCellValueType.Empty:
    begin
      CellType := 'Пустой тип';
      Fld.AsVariant := null;
      Exit;
    end;
    TCellValueType.Boolean:
    begin
      CellType := 'Логический тип';
      Fld.AsBoolean := v.AsBoolean;
      Exit;
    end;
    TCellValueType.Error:
    begin
      CellType := 'Ошибка';
      Fld.AsVariant := null;
      Exit;
    end;
    TCellValueType.Number:
    begin
      CellColor := TUIColor.Empty;
      CellValue := TFlxNumberFormat.FormatValue(v, xls.GetCellVisibleFormatDef(Row, Col).Format, CellColor, xls, HasDate, HasTime).ToString;
      if HasDate or HasTime then
      begin
        CellType := 'Дата или время';
        Fld.AsDateTime := v.ToDateTime(xls.OptionsDates1904);
      end
      else
      begin
        CellType := 'Цифровой тип';
        Fld.AsFloat := v.AsNumber;
      end;
      exit;
    end;
    TCellValueType.DateTime:  //FlexCel won't currently return DateTime values, as dates are numbers.
    begin
      CellType := 'Дата или время';
      Fld.AsDateTime := v.AsDateTime;
      exit;
    end;
    TCellValueType.StringValue:
    begin
      CellType := 'Строковый тип';
      Fld.AsString := v.AsString;
      Exit;
    end;

  end;
  except
    TimedMessageBox('Структура файла Excel неправильная! В ячейке строка - ' + IntToStr(Row) + ', столбец - ' + IntToStr(Col) +  ' ' + CellType, 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 35, 3);
  end;
  raise Exception.Create('Неопределенное значение в ячейке строка - ' + IntToStr(Row) + ', столбец - '+ IntToStr(Col));
end;

end.
