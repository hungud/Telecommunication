unit IntecGridUtils;

interface

uses Windows, Forms, Classes, Controls, Grids, DBGrids, CRGrid, Graphics;

const
  // значени€ цветов по умолчанию (при отрисовке типа dtDraw2), можно переопределить в OnDrawCell 
  clGridHighLightActive     = $00FFEAE1;
  clGridHighLightInactive   = clWhite;
  clGridActive              = $00C6DADD; //$00E4CFCF;
  clGridInactive            = clWhite;

  clFontHighLightActive     = $006C1002;
  clFontHighLightInactive   = clBlack;
  clFontActive              = $006C1002;
  clFontInactive            = clBlack;

  clFontStyleHighLightActive   : TFontStyles = [fsBold];
  clFontStyleHighLightInactive = [];
  clFontStyleActive            = [];
  clFontStyleInactive          = [];


type
  TSourceElement=record
                     Condition:Boolean;
                     ColorBrush:TColor;
                     ColorFont:TColor;
                     ColorHighLightFont:TColor;
                   end;
  TUserColorArray = array[0..9] of TSourceElement;


// Ќайти колонку в TDBGrid. ≈сли колонка не была найдена, возвращает nil
function FindDBGridColumn(Grid : TCustomDBGrid; const ColumnName: string): TColumn;

// Ќайти колонку в TDBGrid. ≈сли колонка не была найдена, возвращает -1
function FindDBGridColumnIndex(Grid : TCustomDBGrid; const ColumnName: string): Integer;

// ¬осстановить конфигурацию TDBGrid из реестра
procedure LoadGridConfiguration(Grid : TCustomDBGrid; const GridID : string; const pMaxWidth : Integer = 200);

// —охранить конфигурацию TDBGrid в реестр
procedure SaveGridConfiguration(Grid : TCustomDBGrid; const GridID : string; const GridDescription : string = '');

function DBGridGetHint(pGrid : TCustomDBGrid; var HintInfo : THintInfo; var HintCanShow : Boolean) : string;

// процедура отрисовки грида (работате дл€ IntecDBGrid и CRGrid ов)
procedure DefaultDrawIntecColumnCell2(const pGrid : TDBGrid; const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState; const pDataLink : TGridDataLink; FDrawingCurrentRecord : Boolean;
  const pImage : TPicture = nil);

procedure DefaultDrawIntecColumnCell3(const pGrid : TCRDBGrid; const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState; const pDataLink : TGridDataLink; FDrawingCurrentRecord : Boolean;
  const clGridHighLightActive, clGridHighLightInactive, clGridActive, clGridInactive,
        clFontHighLightActive, clFontHighLightInactive, clFontActive, clFontInactive : TColor;
  const clFontStyleHighLightActive, clFontStyleHighLightInactive, clFontStyleActive, clFontStyleInactive : TFontStyles;
  const pOnlyFillRect : boolean);

implementation

uses SysUtils, StdCtrls, Registry, {DefineColumns, }DB {, IntecExportImport};

type
  THintDBGrid = class(TCustomDBGrid);

const
  // константы формы дл€ выбора видимых колонок

  CHECKBOX_FIRST_TOP = 8; // top первого CheckBox-a
  CHECKBOX_LEFT = 8; // Left всех CheckBox - ов
  CHECKBOX_HEIGHT = 16; // ¬ысота каждого CheckBox-а и горизонтальное рассто€ние между ними
  CHECKBOX_WIDTH = 16; // штрина каждого CheckBox-а

  // вводим Label потому что у CheckBox - ов нет AutoSize - дл€ автоматического задани€
  //   ширины формы по максимально широкому названию
  LABEL_FIRST_TOP = 8; // top первого Label-a
  LABEL_LEFT = 24; // Left всех Label-ов
  LABEL_HEIGHT = 16; // ¬ысота каждого Label-а и горизонтальное рассто€ние между ними

  DELTA_FORM_HEIGHT = 67; // добавл€ем к Top-у CheckBox-а который после последнего
    // дл€ получени€ высоты окна
  DELTA_FORM_WIDTH = 35; // добавл€ем к Right-у Label-а который после последнего
    // дл€ получени€ ширины окна (там же место дл€ ScrollBar-а)
  HEIGHT_RATIO = 85; // форма займет не более % высоты экрана


resourcestring
  RegistryGridConfigPrefix = 'Software\Intec\Common\Config\Grids\';

procedure DoCheck(Condition : Boolean; const ErrorText : string);
begin
  if not Condition then
    Raise Exception.Create(ErrorText);
end;

function FindDBGridColumn(Grid : TCustomDBGrid; const ColumnName: string): TColumn;
var
  i : integer;
  Columns : TDBGridColumns;
begin
  Result := nil;
  Columns := TDBGrid(Grid).Columns;
  for i := 0 to Columns.Count-1 do
    if CompareText(Columns[i].FieldName, ColumnName) = 0 then
    begin
      Result := Columns[i];
      Break;
    end;
end;

function FindDBGridColumnIndex(Grid : TCustomDBGrid; const ColumnName: string): Integer;
var
  i : integer;
  Columns : TDBGridColumns;
begin
  Result := -1;
  Columns := TDBGrid(Grid).Columns;
  for i := 0 to Columns.Count-1 do
    if CompareText(Columns[i].FieldName, ColumnName) = 0 then
    begin
      Result := i;
      Break;
    end;
end;

procedure LoadGridConfiguration(Grid : TCustomDBGrid; const GridID : string; const pMaxWidth : Integer = 200);
var
  Reg : TRegistry;
  i : integer;
  ColumnsCount : integer;
  Column : TColumn;
  OrderedList : TList;
  ColumnIndex : integer;
  ColumnWidth : integer;
  Columns : TDBGridColumns;
begin
  Columns := TDBGrid(Grid).Columns;
  try
    Reg := TRegistry.Create(KEY_READ);
    try
      OrderedList := TList.Create;
      try
        ColumnsCount := Columns.Count;
        OrderedList.Count := ColumnsCount;
        Reg.RootKey := HKEY_LOCAL_MACHINE;
        for i := 0 to ColumnsCount-1 do
        begin
          Column := Columns[i];
          if Reg.OpenKeyReadOnly(RegistryGridConfigPrefix+GridID+'\Columns\'+Column.FieldName) then
          begin
            try
              if Reg.ValueExists('Visible') then
                Column.Visible := (Reg.ReadString('Visible') = '1');
              // ≈сли указан индекс колонки, то заносим указатель на эту колонку в список
              if Reg.ValueExists('ColumnIndex') then
              begin
                ColumnIndex := StrToIntDef(Reg.ReadString('ColumnIndex'), -1);
                if (ColumnIndex >= 0) and (ColumnIndex<ColumnsCount) then
                  OrderedList[ColumnIndex] := Column;
              end;
              if Reg.ValueExists('ColumnWidth') then
              begin
                ColumnWidth := StrToIntDef(Reg.ReadString('ColumnWidth'), -1);
                if (ColumnWidth >= 0) then
                  Column.Width := ColumnWidth;
                if Column.Width > pMaxWidth then
                  Column.Width := pMaxWidth;
              end;
            finally
              Reg.CloseKey;
            end;
          end;
        end;
        // –асставл€ем колонки по пор€дку
        for i := 0 to ColumnsCount-1 do
        begin
          Column := TColumn(OrderedList[i]);
          if Assigned(Column) then
            Column.Index := i;
        end;
  {  // ѕока нет возможности указать активную сотрировку
        if Reg.OpenKey(RegistryGridConfigPrefix+GridID+'\ActiveColumn', False) then
        begin
          try
            if Reg.ValueExists('ColumnName') then
            begin
              ColumnName := Reg.ReadString('ColumnName');
              Column := FindColumn(ColumnName);
              if Assigned(Column) then
                FSortColumnName := ColumnName;
            end;
          finally
            Reg.CloseKey
          end;
        end;}
      finally
        OrderedList.Free;
      end;
    finally
      Reg.Free
    end;
  except
    on ERegistryException do
  end;
end;

procedure SaveGridConfiguration(Grid : TCustomDBGrid; const GridID : string; const GridDescription : string = '');
const
  StringBooleanArray : array[False..True] of string = ('0', '1');
var
  Reg : TRegistry;
  i : integer;
  ColumnsCount : integer;
  Column : TColumn;
  Columns : TDBGridColumns;
  TheGridDescription : string;
  Form : TCustomForm;
begin
  Columns := TDBGrid(Grid).Columns;
  try
    Reg := TRegistry.Create(KEY_READ);
    try
      ColumnsCount := Columns.Count;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.Access := KEY_WRITE;
      TheGridDescription := GridDescription;
      if TheGridDescription = '' then
      begin
        TheGridDescription := Grid.Name;
        Form := GetParentForm(Grid);
        if Assigned(Form) then
          TheGridDescription := Format('%s.%s', [Form.Caption, TheGridDescription]);
      end;
      if Reg.OpenKey(RegistryGridConfigPrefix+GridID, True) then
      begin
        try
          Reg.WriteString('', TheGridDescription);
        finally
          Reg.CloseKey;
        end;
      end;
      for i := 0 to ColumnsCount-1 do
      begin
        Column := Columns[i];
        if Reg.OpenKey(RegistryGridConfigPrefix+GridID+'\Columns\'+Column.FieldName, True) then
        begin
          try
            Reg.WriteString('Visible', StringBooleanArray[Column.Visible]);
            Reg.WriteString('ColumnIndex', IntToStr(Column.Index));
            Reg.WriteString('ColumnWidth', IntToStr(Column.Width));
          finally
            Reg.CloseKey;
          end;
        end;
      end;
  {  // ѕока нет возможности указать активную сотрировку
      if Reg.OpenKey(RegistryConfigActiveColumnKeyName, True) then
      begin
        try
          Reg.WriteString('ColumnName', FSortColumnName);
        finally
          Reg.CloseKey;
        end;
      end;}
    finally
      Reg.Free
    end;
  except
    on ERegistryException do
  end;
end;

{
procedure SelectVisibleColumns(Grid : TCustomDBGrid; const pMaxWidth : integer = 100);   
var
  Form : TDefineColumnsForm;
  procedure SetVisibleSateState(Form : TDefineColumnsForm);
  var
    i : integer;
    MaxWidth : integer;
    CurrentCheckBoxTop : integer;
    CurrentLabelTop : integer;
    cb : TCheckBox;
    l : TLabel;
    ScreenRect : TRect;
    Columns : TDBGridColumns;
  begin
    Columns := TDBGrid(Grid).Columns;
    CurrentCheckBoxTop := CHECKBOX_FIRST_TOP;
    CurrentLabelTop := LABEL_FIRST_TOP;
    MaxWidth := 0;
    for i := 0 to Columns.Count - 1 do
    begin
      cb := TCheckBox.Create(Form);
      cb.Parent := Form.ScrollBox;
      cb.Tag := i;
      cb.Name := 'CB' + IntToStr(i);
      cb.Caption := '';
      cb.Top := CurrentCheckBoxTop;
      cb.Left := CHECKBOX_LEFT;
      cb.Width := CHECKBOX_WIDTH;
      cb.Height := CHECKBOX_HEIGHT;
      cb.Checked := Columns[i].Visible;

      l := TLabel.Create(Form);
      l.Parent := Form.ScrollBox;
      l.Tag := i;
      l.AutoSize := true;
      l.Name := 'l' + IntToStr(i);
      l.Caption := Columns[i].Title.Caption;
      l.Top := CurrentLabelTop;
      l.Left := LABEL_LEFT;
      l.Height := LABEL_HEIGHT;
      if l.Width > MaxWidth then
        MaxWidth := l.Width;

      CurrentCheckBoxTop := CurrentCheckBoxTop + CHECKBOX_HEIGHT;
      CurrentLabelTop := CurrentLabelTop + LABEL_HEIGHT;
    end;

    // ѕолучаем размеры рабочей области Desktop
    SystemParametersInfo(SPI_GETWORKAREA, 0, @ScreenRect, 0);

    // устанавливаем размеры окна
    if ((ScreenRect.Bottom - ScreenRect.Top) * HEIGHT_RATIO div 100) < (CurrentCheckBoxTop + DELTA_FORM_HEIGHT) then
      Form.Height := ((ScreenRect.Bottom - ScreenRect.Top) * HEIGHT_RATIO div 100)
    else
      Form.Height := CurrentCheckBoxTop + DELTA_FORM_HEIGHT;
    Form.Width := LABEL_LEFT + MaxWidth + DELTA_FORM_WIDTH;
  end;

  procedure GetVisibleSateState(Form : TDefineColumnsForm);
  var
    i : integer;
    Columns : TDBGridColumns;
    vOldColumnVisible : boolean;
  begin
    Columns := TDBGrid(Grid).Columns;
    for i := 0 to Form.ComponentCount - 1 do
    begin
      if Form.Components[i] is TCheckBox then
      begin
        vOldColumnVisible := Columns[Form.Components[i].Tag].Visible;

        Columns[Form.Components[i].Tag].Visible := (Form.Components[i] as TCheckBox).Checked;

        // если колонка стала видимой
        if (not vOldColumnVisible) and Columns[Form.Components[i].Tag].Visible
          and (Columns[Form.Components[i].Tag].Width > pMaxWidth) then
           Columns[Form.Components[i].Tag].Width := pMaxWidth;
      end;
    end;
  end;
begin
  Form := TDefineColumnsForm.Create(nil);
  try
    SetVisibleSateState(Form);
    if mrOK = Form.ShowModal then
      GetVisibleSateState(Form);
  finally
    Form.Free;
  end;
end;

function ExportGridToTSV(Grid : TCustomDBGrid) : string;
var
  Columns : TDBGridColumns;
  i : integer;
  ds : TDataSet;
  Column : TColumn;
  bm : TBookmark;
var
  Exporter : TTableExporter;
begin

  DoCheck(Assigned(Grid), 'Grid=nil');
  DoCheck(Assigned(Grid.DataSource), '—войство Grid.DataSource не заполнено');
  ds := Grid.DataSource.DataSet;
  DoCheck(Assigned(ds), '—войство Grid.DataSource.DataSet не заполнено');
  DoCheck(ds.Active, 'Grid.DataSource.DataSet не активен');
  Columns := TDBGrid(Grid).Columns;
  Exporter := TTabDelimitedTableExporter.Create;
  try
    // «аголовок
    Exporter.StartHeader;
    for i := 0 to Columns.Count-1 do
      if Columns[i].Visible then
        Exporter.AppendField(Columns[i].Title.Caption);
    Exporter.EndHeader;

    // ƒанные
    if not ds.IsEmpty then
    begin
      ds.DisableControls;
      try
        bm := ds.GetBookmark;
        try
          ds.First;
          while not ds.EOF do
          begin
            Exporter.StartRow;
            for i := 0 to Columns.Count-1 do
            begin
              Column := Columns[i];
              if Column.Visible and Assigned(Column.Field) then
              begin
                Exporter.AddFieldValue(Column.Field.AsString);
              end;
            end;
            Exporter.EndRow;
            ds.Next;
          end;
        finally
          ds.GotoBookmark(bm);
          ds.FreeBookmark(bm);
        end;
      finally
        ds.EnableControls;
      end;
    end;
    Result := Exporter.GetResult;
  finally
    Exporter.Free;
  end;
end;
}

function DBGridGetHint(pGrid : TCustomDBGrid; var HintInfo : THintInfo; var HintCanShow : Boolean) : string;
var
  Coord : TGridCoord;
  OldActive : Integer;
  ColWidth : Integer;
  Coord_X : integer;
  Grid : THintDBGrid;
begin
  Grid := THintDBGrid(pGrid);
  
  Result := '';
  HintCanShow := False;
  HintInfo.HintMaxWidth := Screen.Width;
  ColWidth := 0;
  Coord := Grid.MouseCoord(HintInfo.CursorPos.X, HintInfo.CursorPos.Y);
  if (dgIndicator in Grid.Options) then
    Coord_X := Coord.X - 1
  else
    Coord_X := Coord.X;
  if (Coord_X = -1) then // указатель записи
    Exit;
  if Coord.Y = 0 then
  begin // заголовок
   // показываем hint-ы дл€ заголовков
    // если есть поиск, то заголовок выделен жирным шрифтом
    if (fsBold in Grid.Columns[Coord_X].Title.Font.Style) then
    begin
      if Grid.Columns[Coord_X].Title.Color <> clBtnFace then
        Result := 'јктивна€ сортировка'
      else
        Result := 'ўелкните здесь, чтобы отсортировать данные по этому столбцу';
    end else
      Result := 'Ќет сортировки';
  end; {If Coord.Y=0}
  if Coord.Y >= Grid.FixedRows then
  begin
    OldActive := Grid.DataLink.ActiveRecord;
    try
      Grid.DataLink.ActiveRecord := Coord.Y - Grid.FixedRows;
      if (Grid.Fields[Coord_X] <> Nil) and
         (Grid.DataLink.DataSet.FindField(Grid.Fields[Coord_X].FieldName) <> Nil) then
      begin
        if not (Grid.DataLink.DataSet.FieldByName(Grid.Fields[Coord_X].FieldName) is TBooleanField) then
        begin
          Result := Grid.DataLink.DataSet.FieldByName(Grid.Fields[Coord_X].FieldName).Text;
  //        HintInfo.HintMaxWidth := Canvas.TextWidth(Result);
        end; {If not BooleanField}
      end;
    finally
      Grid.DataLink.ActiveRecord := OldActive;
    end;
    ColWidth := Grid.Columns[Coord_X].Width;
    HintInfo.HintData := Grid.Columns[Coord_X];
  end; {If Coord.Y >= FixedRows}
  if Result <> '' then
  begin
    HintInfo.CursorRect := Grid.CellRect(Coord.X, Coord.Y);
    HintInfo.HideTimeout := 60000; // ѕоказываем 1 минуту

    HintInfo.HintPos.x := HintInfo.CursorRect.Left-1;
    HintInfo.HintPos.y := HintInfo.CursorRect.Top-1;
    HintInfo.HintPos := Grid.ClientToScreen(HintInfo.HintPos);
  end; {If}
  HintCanShow := (Result <> '') and (HintInfo.HintMaxWidth > ColWidth);

end;

procedure DrawPictureAllign(Picture: TPicture; Rect: TRect; Canvas: TCanvas);
var
  st, vt: Integer;
begin
  vt := ((Rect.Bottom + Rect.Top) - Picture.Height) div 2;
  st := ((Rect.Right + Rect.Left) - Picture.Width) div 2;
  Canvas.Draw(st, vt, Picture.Graphic);
end;

//-------------------------------------------------------------------

procedure DefaultDrawIntecColumnCell2(const pGrid : TDBGrid; const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState; const pDataLink : TGridDataLink; FDrawingCurrentRecord : Boolean;
  const pImage : TPicture = nil);

  function RowIsMultiSelected(const pOptions : TDBGridOptions;
    const pDataLink : TGridDataLink; const pSelectedRows : TBookmarkList): Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in pOptions) and
      pDatalink.Active and
      pSelectedRows.Find(pDatalink.Datasource.Dataset.Bookmark, Index);
  end;
var
  ColWidth, ColTextWidth, TextShift : Integer;
  Text : string;
begin
  with pGrid do
  begin
    if (
        (gdSelected in State) // or RowIsMultiSelected
        or
        ((dgRowSelect in Options) and FDrawingCurrentRecord
        )
        or
        RowIsMultiSelected(Options, pDataLink, SelectedRows)
       )
       and (not (gdFixed in State))
    then
    begin
      if Focused then
      begin
        Canvas.Brush.Color := clHighLight;
        Canvas.FillRect(Rect);
        // иначе одинарные €чейки не считаютс€ HighLight
        if (Canvas.Font.Color = clBlack) or (Canvas.Font.Color = clWindowText) then
          Canvas.Font.Color := clHighlightText;
      end
      else
      begin
        Canvas.Brush.Color := clMenu;
        Canvas.FillRect(Rect);
        Canvas.Pen.Color := clWhite;
        if not (dgRowSelect in Options) then
          Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom)
        else
        begin
          Canvas.MoveTo(Rect.Right, Rect.Top);
          Canvas.LineTo(Rect.Right, Rect.Bottom+1);
        end;
        if (dgAlwaysShowSelection in Options) or RowIsMultiSelected(Options, pDataLink, SelectedRows) then // отрисовывает как HighLight
          Canvas.Font.Color := clWindowText;
      end;

      if Assigned(pImage) then
      begin
        Canvas.Draw(Round((Rect.Left+Rect.Right - pImage.Width)/2),Rect.Top,pImage.Bitmap);
      end
      else if Assigned(Column.Field) then
      begin
        Text := Column.Field.DisplayText;
        if Column.Alignment = taRightJustify then
        begin
          ColWidth := Rect.Right - Rect.Left;
          ColTextWidth := Canvas.TextWidth(Text);
          TextShift := ColWidth - ColTextWidth;
          if TextShift <= 0 then
            TextShift := 0;
          Canvas.brush.Style := bsClear;
          try
            Canvas.TextRect(Rect, Rect.Left - 3 + TextShift, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end
        else if Column.Alignment = taLeftJustify then
        begin
          Canvas.Font.Style := [];
          Canvas.brush.Style := bsClear;
          try
          Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end else if Column.Alignment = taCenter then
        begin
          ColWidth := Rect.Right - Rect.Left;
          ColTextWidth := Canvas.TextWidth(Text);
          TextShift := (ColWidth - ColTextWidth) div 2;
          if TextShift <= 0 then
            TextShift := 0;
          Canvas.brush.Style := bsClear;
          try
          Canvas.TextRect(Rect, Rect.Left + TextShift, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end;
      end;
    end
    else
    begin
  //      Canvas.Font.Style := Font.Style;
      if Assigned(pImage) then
      begin
        Canvas.FillRect(Rect);
        Canvas.Draw(Round((Rect.Left+Rect.Right - pImage.Width)/2),Rect.Top,pImage.Bitmap);
      end
      else
        DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure DefaultDrawIntecColumnCell3(const pGrid : TCRDBGrid; const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState; const pDataLink : TGridDataLink; FDrawingCurrentRecord : Boolean;
  const clGridHighLightActive, clGridHighLightInactive, clGridActive, clGridInactive,
        clFontHighLightActive, clFontHighLightInactive, clFontActive, clFontInactive : TColor;
  const clFontStyleHighLightActive, clFontStyleHighLightInactive, clFontStyleActive, clFontStyleInactive : TFontStyles;
  const pOnlyFillRect : boolean);

  function RowIsMultiSelected(const pOptions : TDBGridOptions;
    const pDataLink : TGridDataLink; const pSelectedRows : TBookmarkList): Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in pOptions) and
      pDatalink.Active and
      pSelectedRows.Find(pDatalink.Datasource.Dataset.Bookmark, Index);
  end;

  function CellActive : boolean;
  begin
    Result :=
       (
        (gdSelected in State) // or RowIsMultiSelected
        or
        ((dgRowSelect in pGrid.Options) and FDrawingCurrentRecord
        )
        or
        RowIsMultiSelected(pGrid.Options, pDataLink, pGrid.SelectedRows)
       )
       and (not (gdFixed in State));
  end;

var
  ColWidth, ColTextWidth, TextShift : Integer;
  Text : string;
begin
  with pGrid do
  begin
    if CellActive then
    begin
      if Focused then
      begin
        Canvas.Font.Style := clFontStyleHighLightActive;
        Canvas.Font.Color := clFontHighLightActive;
        Canvas.Brush.Color := clGridHighLightActive;
        Canvas.FillRect(Rect);
      end
      else
      begin
        Canvas.Font.Style := clFontStyleActive;
        Canvas.Font.Color := clFontActive;
        Canvas.Brush.Color := clGridActive;
        Canvas.FillRect(Rect);
        Canvas.Pen.Color := clWhite;
        if not (dgRowSelect in Options) then
          Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom)
        else
        begin
          Canvas.MoveTo(Rect.Right, Rect.Top);
          Canvas.LineTo(Rect.Right, Rect.Bottom+1);
        end;
      end;

      if Assigned(Column.Field) and (not pOnlyFillRect) then
      begin
        Text := Column.Field.DisplayText;
        if Column.Alignment = taRightJustify then
        begin
          ColWidth := Rect.Right - Rect.Left;
          ColTextWidth := Canvas.TextWidth(Text);
          TextShift := ColWidth - ColTextWidth;
          if TextShift <= 0 then
            TextShift := 0;
          Canvas.brush.Style := bsClear;
          try
            Canvas.TextRect(Rect, Rect.Left - 3 + TextShift, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end
        else if Column.Alignment = taLeftJustify then
        begin
          Canvas.brush.Style := bsClear;
          try
            Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end
        else if Column.Alignment = taCenter then
        begin
          ColWidth := Rect.Right - Rect.Left;
          ColTextWidth := Canvas.TextWidth(Text);
          TextShift := (ColWidth - ColTextWidth) div 2;
          if TextShift <= 0 then
            TextShift := 0;
          Canvas.brush.Style := bsClear;
          try
            Canvas.TextRect(Rect, Rect.Left + TextShift, Rect.Top + 2, Text);
          finally
            Canvas.brush.Style := bsSolid;
          end;
        end;
      end;
    end
    else
    begin
      if Focused then
      begin
        Canvas.Font.Style := clFontStyleHighLightInactive;
        Canvas.Font.Color := clFontHighLightInactive;
        Canvas.Brush.Color := clGridHighLightInactive;
      end
      else
      begin
        Canvas.Font.Style := clFontStyleInactive;
        Canvas.Font.Color := clFontInactive;
        Canvas.Brush.Color := clGridInactive;
      end;

      if pOnlyFillRect then
        Canvas.FillRect(Rect)
      else
        DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;


end.
