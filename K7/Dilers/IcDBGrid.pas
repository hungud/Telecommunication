unit IcDBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DB, DBGrids {, DbugIntf}, Hints, Variants;

const
  // значения цветов по умолчанию (при отрисовке типа dtDraw2), можно переопределить в OnDrawCell 
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
  TFieldCanEditingProc = procedure(Sender : TObject; Field : TField; var Result : Boolean) of object;

  TDrawType = (dtDraw1, dtDraw2);
  TDrawTypes = set of TDrawType;

  TIntecDBGrid = class(TDBGrid)
  private
    FGridID : string;
    FOnFieldCanEditingProc : TFieldCanEditingProc;
    FShowHintAutomatic : Boolean;
    FDrawType : TDrawType;
    procedure DoShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure SetShowHintAutomatic(const Value: boolean);
  protected
    { Protected declarations }
    procedure WndProc(var Message : TMessage); override;
    procedure DrawCell(ACol, ARow : Longint; ARect : TRect; AState : TGridDrawState); override;
    procedure DrawColumnCell(const Rect : TRect; DataCol : Integer;
      Column : TColumn; State : TGridDrawState); override;
    procedure WMPaint(var Message : TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure Scroll(Distance : Integer); override;
    function  CanEditModify: Boolean; override;
  public
    FDrawingCurrentRecord : Boolean; // можно использовать в OnDBGridDrawColumnCell - признак того, что рисуем текущую запись 

    // значения берутся по умолчанию из констант с такими же наименованиями (без приставки "F")
    //   могут быть переопределены в процедуре DBGridDrawColumnCell
    FclGridHighLightActive     : TColor; // цвет заливки выделенной ячейки в активном гриде
    FclGridHighLightInactive   : TColor; // цвет заливки выделенной ячейки в НЕ активном гриде
    FclGridActive              : TColor; // цвет заливки НЕ выделенной ячейки в активном гриде
    FclGridInactive            : TColor; // цвет заливки НЕ выделенной ячейки в НЕ активном гриде

    FclFontHighLightActive     : TColor; // цвет шрифта выделенной ячейки в активном гриде
    FclFontHighLightInactive   : TColor; // цвет шрифта выделенной ячейки в НЕ активном гриде
    FclFontActive              : TColor; // цвет шрифта НЕ выделенной ячейки в активном гриде
    FclFontInactive            : TColor; // цвет шрифта НЕ выделенной ячейки в НЕ активном гриде
    //
    FclFontAll                 : TColor; // цвет шрифта ячейки (выедленной или не выделенной, в активном или не активном гриде)
    //
    FclFontStyleHighLightActive   : TFontStyles; // стиль шрифта выделенной ячейки в активном гриде
    FclFontStyleHighLightInactive : TFontStyles; // стиль шрифта выделенной ячейки в НЕ активном гриде
    FclFontStyleActive            : TFontStyles; // стиль шрифта НЕ выделенной ячейки в активном гриде
    FclFontStyleInactive          : TFontStyles; // стиль шрифта НЕ выделенной ячейки в НЕ активном гриде
    //  

    constructor Create(AOwner : TComponent); override;
    destructor destroy; override;

    procedure DefaultDrawIntecColumnCell(const Rect : TRect; DataCol : Integer;
      Column : TColumn; State : TGridDrawState);
    procedure DefaultDrawHighlightedIntecColumnCell(const FontColor, FontBkColor : TColor;
      Rect : TRect; Column : TColumn);
    procedure DefaultDrawIntecColumnCell_2(const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState; const pOnlyFillRect: boolean = False);
    function GetFindStr(var HintInfo : THintInfo) : string;
    function GetHintRecord(var HintInfo : THintInfo) : integer;
    function GetHintFieldValue(FieldName : string; var HintInfo : THintInfo) : string;
    function GetHint(var HintInfo : THintInfo; var HintCanShow : Boolean) : string;
    function GetRecordFieldValue(FieldName : string;
      const RowCoordY : integer) : Variant;

    function FindColumn(const ColumnName: string): TColumn;
    function FindColumnIndex(const ColumnName: string): Integer;

    function DeleteColumnByName(const ColumnName: string): boolean;

    procedure SelectVisibleColumns;
    function GetTopRecordNumber: integer;

    procedure LoadGridConfiguration(const GridID : string);
    procedure SaveGridConfiguration(const GridDescription : string = '');

  published
    // Обработчик OnFieldCanEditing позволяет встроить дополнительный запрет
    // на редактирование значения поля.
    property OnFieldCanEditing : TFieldCanEditingProc read FOnFieldCanEditingProc write FOnFieldCanEditingProc;
    // Свойство ShowHintAutomatic позволяет включить автоматическое отображение
    // хинта (всплывающей подсказки) для значений полей
    property ShowHintAutomatic : boolean read FShowHintAutomatic write SetShowHintAutomatic;
    // тип отрисовки грида dtDraw1 - как раньше, dtDraw2 - новая отрисовка 
    property DrawType : TDrawType read FDrawType write FDrawType default dtDraw1;
  end;

procedure Register;

implementation

uses DefineColumns, STDCtrls, IntecGridUtils;

procedure Register;
begin
  RegisterComponents('Intec', [TIntecDBGrid]);
end;

procedure TIntecDBGrid.DrawColumnCell(const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState);
begin
  Canvas.Font.Style := Font.Style;

  if DrawType = dtDraw1 then
  begin
    if Assigned(OnDrawColumnCell) then
      OnDrawColumnCell(Self, Rect, DataCol, Column, State)
    else
      Self.DefaultDrawIntecColumnCell(Rect, DataCol, Column, State);
  end
  else
  begin
    // загружаем из констант (эти переменные могут быть переопределены в OnDrawColumnCell)
    FclGridHighLightActive     := clGridHighLightActive;
    FclGridHighLightInactive   := clGridHighLightInactive;
    FclGridActive              := clGridActive;
    FclGridInactive            := clGridInactive;

    FclFontHighLightActive     := clFontHighLightActive;
    FclFontHighLightInactive   := clFontHighLightInactive;
    FclFontActive              := clFontActive;
    FclFontInactive            := clFontInactive;

    FclFontAll := 0;

    FclFontStyleHighLightActive   := clFontStyleHighLightActive;
    FclFontStyleHighLightInactive := clFontStyleHighLightInactive;
    FclFontStyleActive            := clFontStyleActive;
    FclFontStyleInactive          := clFontStyleInactive;

    if Assigned(OnDrawColumnCell) then
      OnDrawColumnCell(Self, Rect, DataCol, Column, State)
    else
      Self.DefaultDrawIntecColumnCell_2(Rect, DataCol, Column, State);
  end;
end;

procedure TIntecDBGrid.DefaultDrawIntecColumnCell(const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState);
begin
  IntecGridUtils.DefaultDrawIntecColumnCell2(Self, Rect, DataCol, Column, State, DataLink, FDrawingCurrentRecord);
end;

procedure TIntecDBGrid.DefaultDrawIntecColumnCell_2(const Rect : TRect; DataCol : Integer;
  Column : TColumn; State : TGridDrawState; const pOnlyFillRect : boolean = false);
begin
  if FclFontAll <> 0 then
  begin
    FclFontHighLightActive     := FclFontAll;
    FclFontHighLightInactive   := FclFontAll;
    FclFontActive              := FclFontAll;
    FclFontInactive            := FclFontAll;
  end;

  DefaultDrawIntecColumnCell3(Self, Rect, DataCol, Column, State, DataLink, FDrawingCurrentRecord,
    // цвета
    FclGridHighLightActive, FclGridHighLightInactive, FclGridActive, FclGridInactive,
    FclFontHighLightActive, FclFontHighLightInactive, FclFontActive, FclFontInactive,
    FclFontStyleHighLightActive, FclFontStyleHighLightInactive, FclFontStyleActive, FclFontStyleInactive, pOnlyFillRect);
end;

procedure DefaultDrawHighlightedIntecColumnCell2(const pGrid : TDBGrid; const FontColor, FontBkColor : TColor;
  Rect : TRect; Column : TColumn);
var
  ColWidth, ColTextWidth, TextShift : Integer;
  OldFontStyle : TFontStyles;
  Text : string;
begin
  with pGrid do
  begin
    Canvas.Brush.Color := FontBkColor;
    Canvas.FillRect(Rect);
    Canvas.Font.Color := FontColor;
    if Assigned(Column.Field) then
    begin
      Text := Column.Field.DisplayText;
      if Column.Alignment = taRightJustify then
      begin
        ColWidth := Rect.Right - Rect.Left;
        ColTextWidth := Canvas.TextWidth(Text);
        TextShift := ColWidth - ColTextWidth;
        if TextShift <= 0 then
          TextShift := 0;
        Canvas.TextOut(Rect.Left - 3 + TextShift, Rect.Top + 2, Text);
      end
      else if Column.Alignment = taLeftJustify then
      begin
        OldFontStyle := Canvas.Font.Style;
        Canvas.Font.Style := [];
        Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Text);
        Canvas.Font.Style := OldFontStyle;
      end else if Column.Alignment = taCenter then
      begin
        ColWidth := Rect.Right - Rect.Left;
        ColTextWidth := Canvas.TextWidth(Text);
        TextShift := (ColWidth - ColTextWidth) div 2;
        if TextShift <= 0 then
          TextShift := 0;
        Canvas.TextOut(Rect.Left - 3 + TextShift, Rect.Top + 2, Text);
      end;
    end;
  end;
end;

procedure TIntecDBGrid.DefaultDrawHighlightedIntecColumnCell(const FontColor, FontBkColor : TColor;
  Rect : TRect; Column : TColumn);
begin
  DefaultDrawHighlightedIntecColumnCell2(Self, FontColor, FontBkColor, Rect, Column);
end;

procedure TIntecDBGrid.DrawCell(ACol, ARow : Longint; ARect : TRect; AState : TGridDrawState);

{  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      SelectedRows.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;
 }
  function RowIsSelected : Boolean;
  begin
    if Assigned(DataLink) and DataLink.Active then
    begin
      Result := (ARow = Self.Row);
{      if dgTitles in Options then
        Result := ((ARow-1) = DataLink.ActiveRecord)
      else
        Result := (ARow = DataLink.ActiveRecord);}
    end
    else
      Result := False;
  end;

{var
  OldActive : Integer;
  Indicator : Integer;
  Highlight : Boolean;
  Value : string;
  DrawColumn : TColumn;
  FrameOffs : Byte;
  MultiSelected : Boolean;
  FIndicatorOffset, FTitleOffset : Byte;
  Tmp : Integer;}
begin
{  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  FIndicatorOffset := 0;
  if dgIndicator in Options then
    Inc(FIndicatorOffset);

  FTitleOffset := 0;
  if dgTitles in Options then FTitleOffset := 1;

  Dec(ARow, FTitleOffset);
  Dec(ACol, FIndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end
  else
    FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect(ARect);
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := DataLink.ActiveRecord;
        try
          Datalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          Datalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = DataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if DataLink.DataSet <> nil then
          case DataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> Datalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        FIndicators.BkColor := FixedColor;
        FIndicators.Draw(Canvas, ARect.Right - FIndicators.Width - FrameOffs,
          (ARect.Top + ARect.Bottom - FIndicators.Height) shr 1, Indicator);
        if ARow = Datalink.ActiveRecord then
          FSelRow := ARow + FTitleOffset;
      end;
    end;
  end
  else with Canvas do
  begin
    DrawColumn := Columns[ACol];
    if gdFixed in AState then
    begin
      Font := DrawColumn.Title.Font;
      Brush.Color := DrawColumn.Title.Color;
    end
    else
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    if ARow < 0 then with DrawColumn.Title do
      WriteText(Canvas, ARect, FrameOffs, FrameOffs, Caption, Alignment)
    else if (FDataLink = nil) or not FDataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := FDataLink.ActiveRecord;
      try
        FDataLink.ActiveRecord := ARow;
        if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end;
        if FDefaultDrawing then
          WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment);
        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        FDataLink.ActiveRecord := OldActive;
      end;
      if FDefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self) then
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =
    [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, 1, 1);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
  end;}

  BeginUpdate;
  try
    FDrawingCurrentRecord := RowIsSelected;

    inherited DrawCell(ACol, ARow, ARect, AState);
  finally
    EndUpdate;
  end;

  if DefaultDrawing and (gdSelected in AState)
//        and ((dgAlwaysShowSelection in Options) or Focused)
  and not (csDesigning in ComponentState)
    and not (dgRowSelect in Options)
    and (UpdateLock = 0) (*
        and (ValidParentForm(Self).ActiveControl = Self) *)then
    Windows.DrawFocusRect(Handle, ARect);
end;

function TIntecDBGrid.GetFindStr(var HintInfo : THintInfo) : string;
var
  y : integer;
  r : TRect;
  OldActive : integer;
  Row : Integer;
begin
  y := MouseCoord(0, HintInfo.CursorPos.y).y;
  Row := y;
  if dgTitles in Options then
    Dec(Row);
  if Row >= 0 then
  begin
    OldActive := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := Row;
      if dgTitles in Options then
        DataLink.ActiveRecord := y - 1;
      Result := DataLink.Fields[0].AsString;
    finally
      DataLink.ActiveRecord := OldActive;
    end;
    r := CellRect(0, y);
    HintInfo.CursorRect.Top := r.Top;
    HintInfo.CursorRect.Bottom := r.Bottom + 1;
  end;
end;

function TIntecDBGrid.GetHintRecord(var HintInfo : THintInfo) : integer;
var
  y : integer;
  r : TRect;
  OldActive : integer;
  Row : Integer;
begin
  Result := -1;
  y := MouseCoord(0, HintInfo.CursorPos.y).y;
  Row := y;
  if dgTitles in Options then
    Dec(Row);
  if Row >= 0 then
  begin
    OldActive := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := Row;
      //Result := DataLink.Fields[0].AsString;
      Result := DataLink.DataSet.RecNo;
    finally
      DataLink.ActiveRecord := OldActive;
    end;
    r := CellRect(0, y);
    HintInfo.CursorRect.Top := r.Top;
    HintInfo.CursorRect.Bottom := r.Bottom + 1;
  end;
end;

function TIntecDBGrid.GetHintFieldValue(FieldName : string; var HintInfo : THintInfo) : string;
var
  GridCoord : TGridCoord;
  r : TRect;
  OldActive : integer;
  Row : Integer;
  Field : TField;
begin
  Result := '';
  GridCoord := MouseCoord(HintInfo.CursorPos.x, HintInfo.CursorPos.y);
  Row := GridCoord.y;
  if dgTitles in Options then
    Dec(Row);
  if (Row >= 0) and (GridCoord.x >= FixedCols) then
  begin
    OldActive := DataLink.ActiveRecord;
    try
      DataLink.ActiveRecord := Row;
      if FieldName <> '' then
        Result := DataLink.DataSet.FieldByName(FieldName).Text
      else
      begin
        Field := Columns[GridCoord.x - FixedCols].Field;
        if Assigned(Field) then
          Result := Field.Text;
      end;
    finally
      DataLink.ActiveRecord := OldActive;
    end;
    r := CellRect(GridCoord.x, GridCoord.y);
    HintInfo.CursorRect.Top := r.Top;
    HintInfo.CursorRect.Bottom := r.Bottom + 1;
    if FieldName = '' then
    begin
      HintInfo.CursorRect.Left := r.Left;
      HintInfo.CursorRect.Right := r.Right + 1;
    end;
  end;
end;

function TIntecDBGrid.GetRecordFieldValue(FieldName : string; const RowCoordY : integer) : Variant;
var
  y : integer;
  OldActive : integer;
  Row : Integer;
begin
  Result := Null;
  y := MouseCoord(0, RowCoordY).y;
  Row := y;
  if dgTitles in Options then
    Dec(Row);
  if Row >= 0 then
  begin
    OldActive := DataLink.ActiveRecord;
    DataLink.ActiveRecord := Row;
    try
      Result := DataLink.DataSet.FieldValues[FieldName];
    finally
      DataLink.ActiveRecord := OldActive;
    end;
  end;
end;

function TIntecDBGrid.GetTopRecordNumber : integer;
var
  OldActive : integer;
begin
    OldActive := DataLink.ActiveRecord;
    DataLink.ActiveRecord := 0;
    try
      Result := DataLink.DataSet.RecNo;
    finally
      DataLink.ActiveRecord := OldActive;
    end;
end;

procedure TIntecDBGrid.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
begin
//  if Button = mbLeft then
  Windows.SetFocus(Handle);
  inherited;
end;

procedure TIntecDBGrid.WMPaint(var Message : TWMPaint);
var
  SaveParent : TWinControl;
  SaveTabOrder : integer;
  IsActive : Boolean;
begin
  DoubleBuffered := True;

// Устанавливаем ParentWindow. Нужен для Resize и установки фокуса.
  if (Parent <> nil) and (ParentWindow <> Parent.Handle) then
  begin
    SaveParent := Parent;
    SaveTabOrder := TabOrder;
    IsActive := (Self.HAndle = Windows.GetFocus);
    Parent := nil;
    ParentWindow := SaveParent.Handle;
    Parent := SaveParent;
    TabOrder := SaveTabOrder;
    if IsActive then
    begin
//      ParentForm.ActiveControl := Self;
      Windows.SetFocus(Self.Handle);
    end;
  end;
//  SendDebug('Paint. Handle='+IntTOHex(Integer(Handle), 4));
  inherited;
end;

procedure TIntecDBGrid.SelectVisibleColumns;
begin
  IntecGridUtils.SelectVisibleColumns(Self);
end;

procedure TIntecDBGrid.WndProc(var Message : TMessage);
begin
  {Mouse wheel behaves strangely with dgbgrids - this proc sorts this out}
  if Message.Msg = WM_MOUSEWHEEL then
  begin
    Message.Msg := WM_KEYDOWN;
    Message.LParam := 0;
    if (Message.WParam and $80000000) = 0 then
      Message.WParam := VK_UP
    else
      Message.WParam := VK_DOWN;
  end;
  inherited;
end;

procedure TIntecDBGrid.Scroll(Distance : Integer);
begin
  inherited;
  Invalidate;
end;

constructor TIntecDBGrid.Create(AOwner : TComponent);
begin
  inherited;
  DoubleBuffered := True;
  if (csDesigning in ComponentState) then
    DrawType := dtDraw1;
end;

type
  TNewHintWindowClass = class(THintWindow)
  private
    FDBGrid : TCustomDBGrid;
    FColumn : TColumn;
  protected
    procedure Paint; override;
  public
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
  end;

{ TNewHintWindowClass }

procedure TNewHintWindowClass.ActivateHintData(Rect: TRect;
  const AHint: string; AData: Pointer);
begin
  inherited;
  FDBGrid := nil;
  try
    if Assigned(AData) then
      if TObject(AData) Is TColumn then
      begin
        FColumn := TColumn(AData);
        FDBGrid := (FColumn.Collection As TDBGridColumns).Grid;
        Canvas.Font := FColumn.Font;
      end
  except
  end;
end;

procedure TNewHintWindowClass.Paint;
var
  R: TRect;
begin
  if Assigned(FDBGrid) then
  begin
    R := ClientRect;
    Inc(R.Left, 2);
    Inc(R.Top, 2);
    Canvas.Font.Color := clInfoText;

    DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
      DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
  end
  else
    inherited;
end;

function TIntecDBGrid.FindColumn(const ColumnName: string): TColumn;
begin
  Result := IntecGridUtils.FindDBGridColumn(Self, ColumnName);
end;

function TIntecDBGrid.FindColumnIndex(const ColumnName: string): Integer;
begin
  Result := IntecGridUtils.FindDBGridColumnIndex(Self, ColumnName);
end;

function TIntecDBGrid.DeleteColumnByName(const ColumnName: string): boolean;
var vColumnIndex : Integer;
begin
  Result := False;
  vColumnIndex := FindColumnIndex(ColumnName);
  if vColumnIndex >= 0 then
  begin
    Columns.Delete(vColumnIndex);
    Result := True;
  end;
end;

procedure TIntecDBGrid.LoadGridConfiguration(const GridID : string);
begin
  FGridID := GridID;
  IntecGridUtils.LoadGridConfiguration(Self, GridID);
end;

procedure TIntecDBGrid.SaveGridConfiguration;
begin
  if FGridID <> '' then
    IntecGridUtils.SaveGridConfiguration(Self, FGridID, GridDescription);
end;

procedure TIntecDBGrid.DoShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo );
begin
  if HintInfo.HintControl = Self then
    HintStr := GetHint(HintInfo, CanShow);
end;

destructor TIntecDBGrid.destroy;
begin
  ShowHintAutomatic := False;

  inherited;
end;

procedure TIntecDBGrid.SetShowHintAutomatic(const Value: boolean);
begin
  FShowHintAutomatic := Value;
  if not (csDesigning in ComponentState) then
  begin
    if Value then
      RegisterHintEvent(DoShowHint, Self)
    else
      UnregisterHintEvent(Self);
  end;
end;

procedure TIntecDBGrid.WMKillFocus(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TIntecDBGrid.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

function TIntecDBGrid.GetHint(var HintInfo: THintInfo;
  var HintCanShow: Boolean): string;
begin
  Result := DBGridGetHint(Self, HintInfo, HintCanShow);
end;

function TIntecDBGrid.CanEditModify: Boolean;
var
  Field : TField;
begin
  Result:= inherited CanEditModify;
  if Result then
  begin
    if Assigned(FOnFieldCanEditingProc) then
    begin
      Field := Columns[SelectedIndex].Field;
      if Field <> nil then
        FOnFieldCanEditingProc(Self, Field, Result);
    end;
  end;
end;

initialization
  HintWindowClass := TNewHintWindowClass;

end.

