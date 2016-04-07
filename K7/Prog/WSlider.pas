unit WSlider;

interface

uses
  Classes, SysUtils, Controls, Windows, Graphics, Messages, Themes, Math,
  StdCtrls, Forms, ExtCtrls;

type
  TValue = type Double;
  TValueType = (vtInteger, vtFloat, vtDate, vtTime, vtDateTime);
  TDragPos = (dpNone, dpMinData, dpMaxData, dpMinFltr, dpMaxFltr, dpArea);
  TGripPos = dpMinData..dpMaxFltr;

  TSliderInfo = record
    AreaRgn: HRGN;
    BarRect: TRect;
    ValueRect: TRect;
    GripRect: array[TGripPos] of TRect;
    GripPos: array[TGripPos] of TPoint;
  end;

  TTabEvent = procedure(ShiftPressed: Boolean) of object;

  TSliderEdit = class(TEdit)
  private
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    GripPos: TDragPos;
    OnTab: TTabEvent;
    ValidChars: TSysCharSet;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  end;

  TAwSlider = class(TCustomControl)
  private
    FBorder: Integer;
    FDecimalCount: Byte;
    FDragPos: TDragPos;
    FDragOffset: Integer;
    FEditor: TSliderEdit;
    FFiltered: Boolean;
    FMaxFilter: TValue;
    FMaxValue: TValue;
    FMaxData: TValue;
    FMinFilter: TValue;
    FMinData: TValue;
    FMinValue: TValue;
    FOldFilter: TValue;
    FOldX: Integer;
    FScale: Single;
    FStep: TValue;
    FValueType: TValueType;
    procedure EditorExit(Sender: TObject);
    function GripText(GripPos: TGripPos): String;
    procedure SelectNextControl(GoBack: Boolean);
    procedure SetDecimalCount(Value: Byte);
    procedure SetFiltered(Value: Boolean);
    procedure SetMaxData(Value: TValue);
    procedure SetMaxFilter(Value: TValue);
    procedure SetMaxValue(Value: TValue);
    procedure SetMinData(Value: TValue);
    procedure SetMinFilter(Value: TValue);
    procedure SetMinValue(Value: TValue);
    procedure SetStep(Value: TValue);
    procedure SetValueType(Value: TValueType);
    procedure ShowEditor(GripPos: TGripPos);
    procedure UpdateScale;
    procedure UpdateSliderInfo;
    function ValidChars: TSysCharSet;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMFontchanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    Info: TSliderInfo;
    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure SetParentBackground(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function StrToValueDef(const S: String; Default: TValue): TValue;
    function ValueToStr(Value: TValue): String;
  published
    property DecimalCount: Byte read FDecimalCount write SetDecimalCount
      default 2;
    property Filtered: Boolean read FFiltered write SetFiltered default True;
    property MaxData: TValue read FMaxData write SetMaxData;
    property MaxFilter: TValue read FMaxFilter write SetMaxFilter;
    property MaxValue: TValue read FMaxValue write SetMaxValue;
    property MinData: TValue read FMinData write SetMinData;
    property MinFilter: TValue read FMinFilter write SetMinFilter;
    property MinValue: TValue read FMinValue write SetMinValue;
    property Step: TValue read FStep write SetStep;
    property ValueType: TValueType read FValueType write SetValueType
      default vtInteger;
  published
    property Anchors;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Font;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property ParentBackground default False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabStop default True;
    property Visible;
  end;

implementation

type
  PTriVertex = ^TTriVertex;
  TTriVertex = packed record
    X: DWORD;
    Y: DWORD;
    Red: WORD;
    Green: WORD;
    Blue: WORD;
    Alpha: WORD;
  end;

  TWinControlAccess = class(TWinControl);

function GradientFill(DC: HDC; Vertex: PTriVertex; NumVertex: ULONG;
  Mesh: Pointer; NumMesh, Mode: ULONG): BOOL; stdcall; overload;
  external msimg32 name 'GradientFill';

function GradientFill(DC: HDC; const ARect: TRect; StartColor,
  EndColor: TColor; Vertical: Boolean): Boolean; overload;
const
  Modes: array[Boolean] of ULONG = (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  Vertices: array[0..1] of TTriVertex;
  GRect: TGradientRect;
begin
  Vertices[0].X := ARect.Left;
  Vertices[0].Y := ARect.Top;
  Vertices[0].Red := GetRValue(ColorToRGB(StartColor)) shl 8;
  Vertices[0].Green := GetGValue(ColorToRGB(StartColor)) shl 8;
  Vertices[0].Blue := GetBValue(ColorToRGB(StartColor)) shl 8;
  Vertices[0].Alpha := 0;
  Vertices[1].X := ARect.Right;
  Vertices[1].Y := ARect.Bottom;
  Vertices[1].Red := GetRValue(ColorToRGB(EndColor)) shl 8;
  Vertices[1].Green := GetGValue(ColorToRGB(EndColor)) shl 8;
  Vertices[1].Blue := GetBValue(ColorToRGB(EndColor)) shl 8;
  Vertices[1].Alpha := 0;
  GRect.UpperLeft := 0;
  GRect.LowerRight := 1;
  Result := GradientFill(DC, @Vertices, 2, @GRect, 1, Modes[Vertical]);
end;

procedure GradientBar(ACanvas: TCanvas; const ARect: TRect; StartColor,
  EndColor: TColor);
var
  H: Integer;
  R: TRect;
begin
  R := ARect;
  H := (R.Bottom - R.Top) div 3;
  R.Bottom := R.Top + H;
  GradientFill(ACanvas.Handle, R, StartColor, EndColor, True);
  R.Top := R.Bottom;
  R.Bottom := ARect.Bottom - H;
  ACanvas.Brush.Color := EndColor;
  ACanvas.FillRect(R);
  R.Top := R.Bottom;
  R.Bottom := ARect.Bottom;
  GradientFill(ACanvas.Handle, R, EndColor, StartColor, True);
end;

function PtInRect(const ARect: TRect; X, Y: Integer): Boolean;
begin
  Result := Windows.PtInRect(ARect, Point(X, Y));
end;

function Round(Value: Extended): Integer; overload;
begin
  Result := System.Round(Value);
end;

function Round(Value, Rounder: Extended): Extended; overload;
begin
  if Rounder = 0 then
    Result := Value
  else
    Result := Round(Value / Rounder) * Rounder;
end;

{ TSliderEdit }

procedure TSliderEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  inherited;
  if Message.Sender <> Self then
    Hide;
end;

procedure TSliderEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  Hide;
end;

procedure TSliderEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_TAB, VK_RETURN] then
  begin
    DoExit;
    Hide;
    if Assigned(OnTab) then
      OnTab(ssShift in Shift);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TSliderEdit.KeyPress(var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    GripPos := dpNone;
    Hide;
  end
  else if not (Key in ValidChars) then
    Key := #0;
  inherited KeyPress(Key);
end;

procedure TSliderEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTTAB;
end;

{ TAwSlider }

const
  clLightGreen = $0090E78E;
  clDarkGreen = $002BD228;
  clLightRed = $008E8EE8;
  clDarkRed = $002828D2;
  GripOffset = 3;
  GripRadius = 5;
  MinBarHeight = 12;
  MinEditorWidth = 24;
  TextMargin = 2;

function TAwSlider.CanResize(var NewWidth, NewHeight: Integer): Boolean;
var
  H: Integer;
begin
  H := -Font.Height + 2 * TextMargin - 1 + GripOffset;
  NewHeight := Max(NewHeight, 2 * H + MinBarHeight);
  Result := inherited CanResize(NewWidth, NewHeight);
end;

procedure TAwSlider.CMFontchanged(var Message: TMessage);
begin
  FEditor.Font.Assign(Font);
  inherited;
end;

constructor TAwSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csOpaque, csDoubleClicks];
  DoubleBuffered := True;
  TabStop := True;
  Height := 56;
  Width := 161;
  if ThemeServices.ThemesEnabled then
    FBorder := 3
  else
    FBorder := 2;
  FDecimalCount := 18;
  FEditor := TSliderEdit.Create(Self);
  FEditor.BorderStyle := bsNone;
  FEditor.OnExit := EditorExit;
  FEditor.OnTab := SelectNextControl;
  FEditor.TabStop := False;
  FEditor.ValidChars := ValidChars;
  FEditor.Visible := False;
  if not (csDesigning in ComponentState) then
    FEditor.Parent := Self;
  FFiltered := True;
  FMaxValue := 100.0;
  FMaxData := 100.0;
  FMaxFilter := 100.0;
end;

destructor TAwSlider.Destroy;
begin
  DeleteObject(Info.AreaRgn);
  inherited Destroy;
end;

procedure TAwSlider.EditorExit(Sender: TObject);
begin
  case FEditor.GripPos of
    dpMinData: MinData := StrToValueDef(FEditor.Text, FMinData);
    dpMaxData: MaxData := StrToValueDef(FEditor.Text, FMaxData);
    dpMinFltr: MinFilter := StrToValueDef(FEditor.Text, FMinFilter);
    dpMaxFltr: MaxFilter := StrToValueDef(FEditor.Text, FMaxFilter);
  end;
end;

function TAwSlider.GripText(GripPos: TGripPos): String;
begin
  case GripPos of
    dpMinData:
      Result := ValueToStr(FMinData);
    dpMaxData:
      Result := ValueToStr(FMaxData);
    dpMinFltr:
      if Filtered then
        Result := ValueToStr(FMinFilter)
      else
        Result := ValueToStr(FMinValue);
    dpMaxFltr:
      if Filtered then
        Result := ValueToStr(FMaxFilter)
      else
        Result := ValueToStr(FMaxValue);
  end;
end;

procedure TAwSlider.Loaded;
begin
  inherited Loaded;
  UpdateScale;
end;

procedure TAwSlider.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then
  begin
    if PtInRect(Info.GripRect[dpMinData], X, Y) then
      FDragPos := dpMinData
    else if PtInRect(Info.GripRect[dpMaxData], X, Y) then
      FDragPos := dpMaxData
    else if Filtered and PtInRect(Info.GripRect[dpMinFltr], X, Y) then
      FDragPos := dpMinFltr
    else if Filtered and PtInRect(Info.GripRect[dpMaxFltr], X, Y) then
      FDragPos := dpMaxFltr
    else if PtInRegion(Info.AreaRgn, X, Y) then
      FDragPos := dpArea;
    if ssDouble in Shift then
    begin
      if FDragPos in [dpMinData..dpMaxFltr] then
        ShowEditor(FDragPos);
      FDragPos := dpNone;
    end
    else
    begin
      FOldX := X;
      if FDragPos in [dpMinData..dpMaxFltr] then
        FDragOffset := FBorder + X - Info.GripPos[FDragPos].X;
      if FDragPos = dpMinData then
        FOldFilter := FMinFilter
      else if FDragPos = dpMaxData then
        FOldFilter := FMaxFilter;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TAwSlider.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Diff: TValue;
begin
  case FDragPos of
    dpMinData:
      MinData := Round(((X - FDragOffset) / FScale) + FMinValue, FStep);
    dpMaxData:
      MaxData := Round(((X - FDragOffset) / FScale) + FMinValue, FStep);
    dpMinFltr:
      MinFilter := Round(((X - FDragOffset) / FScale) + FMinValue, FStep);
    dpMaxFltr:
      MaxFilter := Round(((X - FDragOffset) / FScale) + FMinValue, FStep);
    dpArea:
      begin
        Diff := (X - FOldX) / FScale;
        if (FStep = 0) or (Abs(Diff) >= FStep) then
        begin
          if FStep > 0 then
            Diff := Round(Diff, FStep);
          Diff := Min(FMaxValue - FMaxData, Max(Diff, FMinValue - FMinData));
          FMinData := FMinData + Diff;
          FMaxData := FMaxData + Diff;
          FMinFilter := FMinFilter + Diff;
          FMaxFilter := FMaxFilter + Diff;
          FOldX := X;
          Invalidate;
        end;
      end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TAwSlider.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  FDragPos := dpNone;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TAwSlider.Paint;
var
  Details: TThemedElementDetails;
  R: TRect;
  I: TGripPos;
begin
  Canvas.Font.Assign(Self.Font);
  UpdateSliderInfo;
  with Canvas, Info do
  begin
    if not ParentBackground and (csOpaque in ControlStyle) then
    begin
      Brush.Color := Color;
      FillRect(Rect(0, 0, Width, Height));
    end;
    if ThemeServices.ThemesEnabled then
    begin
      Details := ThemeServices.GetElementDetails(tpBar);
      ThemeServices.DrawElement(Handle, Details, BarRect, nil);
    end
    else
    begin
      R := BarRect;
      Frame3D(Canvas, R, cl3DLight, cl3DDkShadow, FBorder);
    end;
    Pen.Style := psSolid;
    Pen.Color := clBtnShadow;
    Brush.Color := clBtnHighLight;
    for I := Low(TGripPos) to High(TGripPos) do
    begin
      Brush.Style := bsSolid;
      with GripRect[I] do
        RoundRect(Left, Top, Right, Bottom, GripRadius, GripRadius);
      with GripPos[I] do
      begin
        MoveTo(X, Y);
        LineTo(X, Y + GripOffset);
      end;
      Brush.Style := bsClear;
      TextOut(GripRect[I].Left + TextMargin, GripRect[I].Top, GripText(I));
    end;
    GradientBar(Canvas, ValueRect, clLightRed, clDarkRed);
    SelectClipRgn(Handle, AreaRgn);
    GradientBar(Canvas, ValueRect, clLightGreen, clDarkGreen);
  end;
end;

procedure TAwSlider.Resize;
begin
  UpdateScale;
  inherited Resize;
end;

procedure TAwSlider.SelectNextControl(GoBack: Boolean);
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if TabStop then
  begin
    if (FEditor.GripPos = dpMinData) and GoBack and (Form <> nil) then
      TWinControlAccess(Form).SelectNext(Self, False, True)
    else if (FEditor.GripPos = dpMinData) and not GoBack then
      ShowEditor(dpMaxData)
    else if (FEditor.GripPos = dpMaxData) and GoBack then
      ShowEditor(dpMinData)
    else if (FEditor.GripPos = dpMaxData) and not GoBack and Filtered then
      ShowEditor(dpMinFltr)
    else if (FEditor.GripPos = dpMinFltr) and GoBack then
      ShowEditor(dpMaxData)
    else if (FEditor.GripPos = dpMinFltr) and not GoBack then
      ShowEditor(dpMaxFltr)
    else if (FEditor.GripPos = dpMaxFltr) and GoBack then
      ShowEditor(dpMinFltr)
    else if Form <> nil then
      TWinControlAccess(Form).SelectNext(Self, True, True);
  end
  else
    if Form <> nil then
      TWinControlAccess(Form).SelectNext(Self, not GoBack, True);
end;

procedure TAwSlider.SetDecimalCount(Value: Byte);
begin
  if FDecimalCount <> Value then
  begin
    FDecimalCount := Value;
    Invalidate;
  end;
end;

procedure TAwSlider.SetFiltered(Value: Boolean);
begin
  if FFiltered <> Value then
  begin
    FFiltered := Value;
    if not Filtered then
    begin
      FMinFilter := FMinData;
      FMaxFilter := FMaxData;
    end;
    Invalidate;
  end;
end;

procedure TAwSlider.SetMaxData(Value: TValue);
begin
  if FMaxData <> Value then
  begin
    FMaxData := Max(FMinFilter, Min(Value, FMaxValue));
    if not Filtered then
      FMaxFilter := FMaxData
    else if FDragPos = dpMaxData then
      FMaxFilter := Min(FMaxData, Max(FOldFilter, FMaxFilter))
    else
      FMaxFilter := Min(FMaxData, FMaxFilter);
    Invalidate;
  end;
end;

procedure TAwSlider.SetMaxFilter(Value: TValue);
begin
  if Filtered and (FMaxFilter <> Value) then
  begin
    FMaxFilter := Max(FMinFilter, Min(Value, FMaxData));
    Invalidate;
  end;
end;

procedure TAwSlider.SetMaxValue(Value: TValue);
begin
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    FMinData := Min(FMinData, FMaxValue);
    FMaxData := Min(FMaxData, FMaxValue);
    FMinFilter := Min(FMinFilter, FMaxValue);
    FMaxFilter := Min(FMaxFilter, FMaxValue);
    Invalidate;
  end;
end;

procedure TAwSlider.SetMinData(Value: TValue);
begin
  if FMinData <> Value then
  begin
    FMinData := Max(FMinValue, Min(Value, FMaxFilter));
    if not Filtered then
      FMinFilter := FMinData
    else if FDragPos = dpMinData then
      FMinFilter := Max(FMinData, Min(FOldFilter, FMinFilter))
    else
      FMinFilter := Max(FMinData, FMinFilter);
    Invalidate;
  end;
end;

procedure TAwSlider.SetMinFilter(Value: TValue);
begin
  if Filtered and (FMinFilter <> Value) then
  begin
    FMinFilter := Min(FMaxFilter, Max(Value, FMinData));
    Invalidate;
  end;
end;

procedure TAwSlider.SetMinValue(Value: TValue);
begin
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    FMinData := Max(FMinData, FMinValue);
    FMaxData := Max(FMaxData, FMinValue);
    FMinFilter := Max(FMinFilter, FMinValue);
    FMaxFilter := Max(FMaxFilter, FMinValue);
    Invalidate;
  end;
end;

procedure TAwSlider.SetParentBackground(Value: Boolean);
begin
  if ParentBackground <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    inherited SetParentBackground(Value);
  end;
end;

procedure TAwSlider.SetStep(Value: TValue);
begin
  if FStep <> Value then
    FStep := Max(0, Min(Value, FMaxValue / 2));
end;

procedure TAwSlider.SetValueType(Value: TValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    FEditor.ValidChars := ValidChars;
    Invalidate;
  end;
end;

procedure TAwSlider.ShowEditor(GripPos: TGripPos);
begin
  FEditor.BoundsRect := Info.GripRect[GripPos];
  FEditor.Width := Max(MinEditorWidth, FEditor.Width);
  FEditor.Text := GripText(GripPos);
  FEditor.GripPos := GripPos;
  FEditor.Show;
  FEditor.SetFocus;
  FEditor.SelectAll;
end;

function TAwSlider.StrToValueDef(const S: String; Default: TValue): TValue;
begin
  case FValueType of
    vtInteger:
      Result := StrToIntDef(S, Round(Default));
    vtFloat:
      Result := StrToFloatDef(S, Default);
    vtDate:
      Result := StrToDateDef(S, Default);
    vtTime:
      Result := StrToTimeDef(S, Default);
    else
      Result := StrToDateTimeDef(S, Default);
  end;
end;

procedure TAwSlider.UpdateScale;
begin
  FScale := (Width - 2 * FBorder) / (FMaxValue - FMinValue);
end;

procedure TAwSlider.UpdateSliderInfo;
var
  R: TRect;
  GripHeight: Integer;
  Area: array[0..3] of TPoint;
  I: TGripPos;
  W: array[TGripPos] of Integer;
  X: array[TGripPos] of Integer;
begin
  with Info do
  begin
    R := Rect(0, 0, Width, Height);
    GripHeight := Abs(-Font.Height) + 2 * TextMargin - 1;
    Inc(R.Top, GripHeight + GripOffset);
    Dec(R.Bottom, GripHeight + GripOffset);
    BarRect := R;
    InflateRect(R, -FBorder, -FBorder);
    ValueRect := R;
    GripPos[dpMinData].X := FBorder + Round((FMinData - FMinValue) * FScale);
    GripPos[dpMinData].Y := GripHeight;
    GripPos[dpMaxData].X := FBorder + Round((FMaxData - FMinValue) * FScale);
    GripPos[dpMaxData].Y := GripHeight;
    GripPos[dpMinFltr].X := FBorder + Round((FMinFilter - FMinValue) * FScale);
    if FFiltered then
      GripPos[dpMinFltr].Y := BarRect.Bottom
    else
      GripPos[dpMinFltr].Y := Height + 1;
    GripPos[dpMaxFltr].X := FBorder + Round((FMaxFilter - FMinValue) * FScale);
    if FFiltered then
      GripPos[dpMaxFltr].Y := BarRect.Bottom
    else
      GripPos[dpMaxFltr].Y := Height + 1;
    Area[0].X := GripPos[dpMinData].X;
    Area[0].Y := ValueRect.Top;
    Area[1].X := GripPos[dpMaxData].X;
    Area[1].Y := ValueRect.Top;
    Area[2].X := GripPos[dpMaxFltr].X;
    Area[2].Y := ValueRect.Bottom;
    Area[3].X := GripPos[dpMinFltr].X;
    Area[3].Y := ValueRect.Bottom;
    DeleteObject(AreaRgn);
    AreaRgn := CreatePolygonRgn(Area, 4, ALTERNATE);
    for I := Low(TGripPos) to High(TGripPos) do
    begin
      W[I] := Canvas.TextWidth(GripText(I)) + 2 * TextMargin;
      X[I] := GripPos[I].X - W[I] div 2;
    end;
    for I := Low(TGripPos) to High(TGripPos) do
      with GripRect[I] do
      begin
        if I = dpMinData then
          Left := Max(0, Min(X[I], X[dpMaxData] - W[I]))
        else if I = dpMaxData then
          Left := Max(GripRect[dpMinData].Right, Min(X[I], Self.Width - W[I]))
        else if (I = dpMinFltr) and Filtered then
          Left := Max(0, Min(X[I], X[dpMaxFltr] - W[I]))
        else if (I = dpMinFltr) and not Filtered then
          Left := 0
        else if Filtered then
          Left := Max(GripRect[dpMinFltr].Right, Min(X[I], Self.Width - W[I]))
        else
          Left := Self.Width - W[I];
        Right := Left + W[I];
        if I in [dpMinData, dpMaxData] then
          Top := 0
        else
          Top := Self.Height - GripHeight;
        Bottom := Top + GripHeight;
      end;
  end;
end;

function TAwSlider.ValidChars: TSysCharSet;
const
  DefSet = ['0'..'9', #8, #127];
  TimeSet = [' ', 'a', 'A', 'p', 'P', 'm', 'M'];
begin
  case FValueType of
    vtInteger:
      Result := DefSet;
    vtFloat:
      Result := DefSet + [DecimalSeparator, '-'];
    vtDate:
      Result := DefSet + [DateSeparator];
    vtTime:
      Result := DefSet + [TimeSeparator] + TimeSet;
    vtDateTime:
      Result := DefSet + [DateSeparator, TimeSeparator] + TimeSet;
  end;
end;

function TAwSlider.ValueToStr(Value: TValue): String;
begin
  case FValueType of
    vtInteger:
      Result := IntToStr(Round(Value));
    vtFloat:
      Result := FloatToStrF(Value, ffNumber, 18, FDecimalCount);
    vtDate:
      Result := FormatDateTime('ddddd', Value);
    vtTime:
      Result := FormatDateTime('t', Value);
    vtDateTime:
      Result := FormatDateTime('c', Value);
  end;
end;

procedure TAwSlider.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  with Info.BarRect do
    ExcludeClipRect(Message.DC, Left, Top, Right, Bottom);
  try
    if ParentBackground and HasParent then
    begin
      if ThemeServices.ThemesEnabled and not (csOpaque in ControlStyle) then
        ThemeServices.DrawParentBackground(Handle, Message.DC, nil, False)
      else
      begin
        SetWindowOrgEx(Message.DC, Left, Top, nil);
        SendMessage(Parent.Handle, WM_PAINT, Integer(Message.DC), 0);
        SetWindowOrgEx(Message.DC, 0, 0, nil);
      end;
    end
    else
      if not FDoubleBuffered or
        (TMessage(Message).wParam = TMessage(Message).lParam) then
      begin
        FillRect(Message.DC, ClientRect, Brush.Handle);
      end;
    Message.Result := 1;
  finally
    SelectClipRgn(Message.DC, 0);
  end;
end;

procedure TAwSlider.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Hi(GetKeyState(VK_SHIFT)) = 0 then
    ShowEditor(dpMinData)
  else if Filtered then
    ShowEditor(dpMaxFltr)
  else
    ShowEditor(dpMaxData);
end;

end.

