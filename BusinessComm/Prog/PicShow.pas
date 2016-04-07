unit PicShow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, DBCtrls, JPEG, PSEffect;

const
  PS_THREADTERMINATED = WM_USER + 1;

type

  TPercent = 0 .. 100;

  TShowStyle = 0 .. High(PSEffects);

  TBackgroundMode = (bmNone, bmTiled, bmStretched, bmCentered);

  TCustomDrawEvent = procedure(Sender: TObject; Picture, Screen: TBitmap)
    of object;

  TAbout = class(TObject);

  { TCustomPicShow }

  TCustomPicShow = class(TCustomControl)
  private
    // fAbout: TAbout;
    fPicture: TPicture;
    fBgPicture: TPicture;
    fBgMode: TBackgroundMode;
    fAutoSize: Boolean;
    fCenter: Boolean;
    fStretch: Boolean;
    fStretchFine: Boolean;
    fOverDraw: Boolean;
    fThreaded: Boolean;
    fThreadPriority: TThreadPriority;
    fManual: Boolean;
    fStyle: TShowStyle;
    fStep: Word;
    fDelay: Word;
    fProgress: TPercent;
    fReverse: Boolean;
    fBusy: Boolean;
    fOnChange: TNotifyEvent;
    fOnProgress: TNotifyEvent;
    fOnComplete: TNotifyEvent;
    fOnCustomDraw: TCustomDrawEvent;
    fOnMouseEnter: TNotifyEvent;
    fOnMouseLeave: TNotifyEvent;
    fOnBeforeNewFrame: TCustomDrawEvent;
    fOnAfterNewFrame: TCustomDrawEvent;
    fOnStart: TCustomDrawEvent;
    fOnStop: TNotifyEvent;
    Media: TBitmap;
    PicRect: TRect;
    Thread: TThread;
    Drawing: Boolean;
    OffScreen: TBitmap;
    Stopping: Boolean;
    NeverDrawn: Boolean;
    OldPic: TBitmap;
    Pic: TBitmap;
    PicWidth: Integer;
    PicHeight: Integer;
    CS: TRTLCriticalSection;
    UpdateEvent: THandle;
    procedure SetAutoSize_(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetBgPicture(Value: TPicture);
    procedure SetBgMode(Value: TBackgroundMode);
    procedure SetCenter(Value: Boolean);
    procedure SetStretch(Value: Boolean);
    procedure SetStretchFine(Value: Boolean);
    procedure SetStep(Value: Word);
    procedure SetProgress(Value: TPercent);
    procedure SetManual(Value: Boolean);
    procedure SetStyle(Value: TShowStyle);
    procedure SetStyleName(const Value: String);
    function GetStyleName: String;
    function GetEmpty: Boolean;
    procedure PictureChange(Sender: TObject);
    procedure BgPictureChange(Sender: TObject);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMDestroy(var Msg: TMessage); message WM_DESTROY;
    procedure ThreadTerminated(var Msg: TMessage); message PS_THREADTERMINATED;
  protected
    procedure PaintBackground(Canvas: TCanvas; const Rect: TRect); virtual;
    procedure Paint; override;
    procedure Prepare;
    procedure Unprepare;
    procedure Animate;
    procedure UpdateMedia;
    procedure AdjustClientSize;
    procedure CalculatePicRect;
    procedure InvalidateArea(Area: TRect);
    function WaitForThread: Boolean;
    procedure DoChange; virtual;
    procedure DoProgress; virtual;
    procedure DoCustomDraw(Picture, Screen: TBitmap); virtual;
    procedure DoBeforeNewFrame(Picture, Screen: TBitmap); virtual;
    procedure DoAfterNewFrame(Picture, Screen: TBitmap); virtual;
    procedure DoComplete; virtual;

    procedure DoStart(NewPicture, OldPicture: TBitmap); virtual;
    procedure DoStop; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    procedure Stop; virtual;
    procedure Clear; virtual;
    property Busy: Boolean read fBusy;
    property Empty: Boolean read GetEmpty;
    property Progress: TPercent read fProgress write SetProgress;
  protected
    property AutoSize: Boolean read fAutoSize write SetAutoSize_ default True;
    property BgMode: TBackgroundMode read fBgMode write SetBgMode
      default bmTiled;
    property BgPicture: TPicture read fBgPicture write SetBgPicture;
    property Center: Boolean read fCenter write SetCenter default False;
    property Delay: Word read fDelay write fDelay default 40;
    property Manual: Boolean read fManual write SetManual default False;
    property OverDraw: Boolean read fOverDraw write fOverDraw default True;
    property Picture: TPicture read fPicture write SetPicture;
    property Reverse: Boolean read fReverse write fReverse default False;
    property Stretch: Boolean read fStretch write SetStretch default False;
    property StretchFine: Boolean read fStretchFine write SetStretchFine
      default False;
    property Step: Word read fStep write SetStep default 4;
    property Style: TShowStyle read fStyle write SetStyle default 51;
    property StyleName: String read GetStyleName write SetStyleName
      stored False;
    property Threaded: Boolean read fThreaded write fThreaded default True;
    property ThreadPriority: TThreadPriority read fThreadPriority
      write fThreadPriority default tpNormal;
    property OnAfterNewFrame: TCustomDrawEvent read fOnAfterNewFrame
      write fOnAfterNewFrame;
    property OnBeforeNewFrame: TCustomDrawEvent read fOnBeforeNewFrame
      write fOnBeforeNewFrame;
    property OnCustomDraw: TCustomDrawEvent read fOnCustomDraw
      write fOnCustomDraw;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property OnComplete: TNotifyEvent read fOnComplete write fOnComplete;
    property OnMouseEnter: TNotifyEvent read fOnMouseEnter write fOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read fOnMouseLeave write fOnMouseLeave;
    property OnProgress: TNotifyEvent read fOnProgress write fOnProgress;
    property OnStart: TCustomDrawEvent read fOnStart write fOnStart;
    property OnStop: TNotifyEvent read fOnStop write fOnStop;
  published
    // property About: TAbout read fAbout write fAbout stored False;
  end;

  { TPicShow }

  TPicShow = class(TCustomPicShow)
  published
    property Align;
{$IFDEF DELPHI4_UP}
    property Anchors;
{$ENDIF}
    property AutoSize;
    property BgMode;
    property BgPicture;
    property Center;
    property Color;
    property Delay;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Height;
    property Manual;
    property OverDraw;
    property ParentColor;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property ShowHint;
    property Reverse;
    property Stretch;
    property StretchFine;
    property Step;
    property Style;
    property StyleName;
    property TabOrder;
    property TabStop;
    property Threaded;
    property ThreadPriority;
    property Visible;
    property Width;
    property OnAfterNewFrame;
    property OnBeforeNewFrame;
    property OnClick;
    property OnChange;
    property OnComplete;
    property OnCustomDraw;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnProgress;
    property OnStart;
    property OnStartDrag;
    property OnStop;
  end;

  { TDBPicShow }

  TGetGraphicClassEvent = procedure(Sender: TObject;
    var GraphicClass: TGraphicClass) of object;

  TDBPicShow = class(TCustomPicShow)
  private
    fOnAfterLoadPicture: TNotifyEvent;
    fOnBeforeLoadPicture: TNotifyEvent;
    fOnGetGraphicClass: TGetGraphicClassEvent;
    fDataLink: TFieldDataLink;
    fAutoDisplay: Boolean;
    fModified: Boolean;
    fLoaded: Boolean;
    fSkipLoading: Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DoChange; override;
    function FindGraphicClass(Stream: TMemoryStream): TGraphicClass; virtual;
    procedure LoadPictureFromStream(Stream: TMemoryStream;
      GraphicClass: TGraphicClass); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadPicture;
    property Field: TField read GetField;
    property Picture;
  published
    property AutoDisplay: Boolean read fAutoDisplay write SetAutoDisplay
      default True;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Align;
{$IFDEF DELPHI4_UP}
    property Anchors;
{$ENDIF}
    property AutoSize;
    property BgMode;
    property BgPicture;
    property Center;
    property Color;
    property Delay;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Height;
    property Manual;
    property OverDraw;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Reverse;
    property Stretch;
    property StretchFine;
    property Step;
    property Style;
    property StyleName;
    property TabOrder;
    property TabStop;
    property Threaded;
    property ThreadPriority;
    property Visible;
    property Width;
    property OnAfterNewFrame;
    property OnBeforeNewFrame;
    property OnClick;
    property OnComplete;
    property OnCustomDraw;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnProgress;
    property OnStart;
    property OnStartDrag;
    property OnStop;
    property OnAfterLoadPicture: TNotifyEvent read fOnAfterLoadPicture
      write fOnAfterLoadPicture;
    property OnBeforeLoadPicture: TNotifyEvent read fOnBeforeLoadPicture
      write fOnBeforeLoadPicture;
    property OnGetGraphicClass: TGetGraphicClassEvent read fOnGetGraphicClass
      write fOnGetGraphicClass;
  end;

implementation

{ Graphic Format Signatures }

type
  TGraphicSign = record
    GraphicClass: TGraphicClass;
    Offset, Length: DWORD;
    Signature: PChar;
  end;

const
  GraphicSigns: array [1 .. 4] of TGraphicSign = ((GraphicClass: TBitmap;
    Offset: 0; Length: 2; Signature: #$42#$4D), // BMP
    (GraphicClass: TJPEGImage; Offset: 6; Length: 4;
    Signature: #$4A#$46#$49#$46), // JPG
    (GraphicClass: TMetafile; Offset: 0; Length: 4;
    Signature: #$D7#$CD#$C6#$9A), // WMF
    (GraphicClass: TMetafile; Offset: 41; Length: 3; Signature: #$45#$4D#$46)
    // EMF
    );

  { Helper Functions }

function ScaleImageToRect(const IR, R: TRect): TRect;
var
  iW, iH: Integer;
  rW, rH: Integer;
begin
  iW := IR.Right - IR.Left;
  if iW = 0 then
    iW := 1;
  iH := IR.Bottom - IR.Top;
  if iH = 0 then
    iH := 1;
  rW := R.Right - R.Left;
  rH := R.Bottom - R.Top;
  if (rW / iW) < (rH / iH) then
  begin
    iH := MulDiv(iH, rW, iW);
    iW := rW;
  end
  else
  begin
    iW := MulDiv(iW, rH, iH);
    iH := rH;
  end;
  SetRect(Result, 0, 0, iW, iH);
  OffsetRect(Result, R.Left + (rW - iW) div 2, R.Top + (rH - iH) div 2);
end;

procedure DrawTiledImage(Canvas: TCanvas; const Rect: TRect; G: TGraphic);
var
  R, Rows, C, Cols: Integer;
begin
  if (G <> nil) and (not G.Empty) then
  begin
    Rows := ((Rect.Bottom - Rect.Top) div G.Height) + 1;
    Cols := ((Rect.Right - Rect.Left) div G.Width) + 1;
    for R := 1 to Rows do
      for C := 1 to Cols do
        Canvas.Draw(Rect.Left + (C - 1) * G.Width,
          Rect.Top + (R - 1) * G.Height, G)
  end;
end;

{$IFNDEF DELPHI5_UP}

procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;
  P.Free;
end;
{$ENDIF}
{ TAnimateThread }

type
  TAnimateThread = class(TThread)
  private
    fExecuted: Boolean;
    PicShow: TCustomPicShow;
    procedure UpdateProgress;
  protected
    constructor Create(APicShow: TCustomPicShow);
    procedure Execute; override;
    property Executed: Boolean read fExecuted;
  end;

constructor TAnimateThread.Create(APicShow: TCustomPicShow);
begin
  inherited Create(True);
  PicShow := APicShow;
  Priority := PicShow.ThreadPriority;
  Resume;
end;

procedure TAnimateThread.Execute;
var
  StartTime: DWORD;
  Delay: Integer;
begin
  fExecuted := True;
  try
    while not Terminated do
    begin
      StartTime := GetTickCount;
      UpdateProgress;
      if not Terminated then
      begin
        Delay := PicShow.Delay - Integer(GetTickCount - StartTime);
        if Delay >= 0 then
          Sleep(Delay);
      end;
    end;
  finally
    PostMessage(PicShow.Handle, PS_THREADTERMINATED, 0, 0);
  end;
end;

procedure TAnimateThread.UpdateProgress;
begin
  with PicShow do
  begin
    WaitForSingleObject(UpdateEvent, INFINITE);
    if not Terminated then
    begin
      ResetEvent(UpdateEvent);
      if Reverse then
        if Progress > Step then
          Progress := Progress - Step
        else
          Progress := 0
      else if Progress < 100 - Step then
        Progress := Progress + Step
      else
        Progress := 100;
      if (Reverse and (Progress = 0)) or (not Reverse and (Progress = 100)) then
        Terminate;
    end;
  end;
end;

{ TCustomPicShow }

constructor TCustomPicShow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  InitializeCriticalSection(CS);
  UpdateEvent := CreateEvent(nil, True, True, nil);
  Media := TBitmap.Create;
  fStep := 4;
  fDelay := 40;
  fStyle := 51;
  fReverse := False;
  fCenter := False;
  fStretch := False;
  fStretchFine := False;
  fAutoSize := True;
  fThreaded := True;
  fThreadPriority := tpNormal;
  fManual := False;
  fOverDraw := True;
  fProgress := 0;
  fBusy := False;
  fPicture := TPicture.Create;
  fPicture.OnChange := PictureChange;
  fBgPicture := TPicture.Create;
  fBgPicture.OnChange := BgPictureChange;
  fBgMode := bmTiled;
  NeverDrawn := True;
  OffScreen := TBitmap.Create;
  Width := 100;
  Height := 100;
  Thread := nil;
  Stopping := False;
  Drawing := False;
end;

destructor TCustomPicShow.Destroy;
begin
  Stop;
  Media.Free;
  Picture.Free;
  BgPicture.Free;
  OffScreen.Free;
  CloseHandle(UpdateEvent);
  DeleteCriticalSection(CS);
  inherited Destroy;
end;

procedure TCustomPicShow.SetPicture(Value: TPicture);
begin
  if Assigned(Value) then
    Picture.Assign(Value)
  else
    Picture.Graphic := nil;
end;

procedure TCustomPicShow.SetBgPicture(Value: TPicture);
begin
  if Assigned(Value) then
    BgPicture.Assign(Value)
  else
    BgPicture.Graphic := nil;
end;

procedure TCustomPicShow.SetBgMode(Value: TBackgroundMode);
begin
  if BgMode <> Value then
  begin
    fBgMode := Value;
    if (BgPicture.Graphic <> nil) and not Drawing then
      Invalidate;
  end;
end;

procedure TCustomPicShow.SetCenter(Value: Boolean);
begin
  if Center <> Value then
  begin
    fCenter := Value;
    if (Picture.Graphic <> nil) then
    begin
      CalculatePicRect;
      if not(Media.Empty or Drawing) then
        Invalidate;
    end;
  end;
end;

procedure TCustomPicShow.SetStretch(Value: Boolean);
begin
  if Stretch <> Value then
  begin
    fStretch := Value;
    if not(Media.Empty or Drawing) then
      Invalidate;
  end;
end;

procedure TCustomPicShow.SetStretchFine(Value: Boolean);
begin
  if StretchFine <> Value then
  begin
    fStretchFine := Value;
    if not(Media.Empty or Drawing) then
      Invalidate;
  end;
end;

procedure TCustomPicShow.SetStep(Value: Word);
begin
  if Value = 0 then
    fStep := 1;
  if Value > 100 then
    fStep := 100
  else
    fStep := Value;
end;

procedure TCustomPicShow.SetStyle(Value: TShowStyle);
begin
  if (Style <> Value) and (Value in [Low(TShowStyle) .. High(TShowStyle)]) then
  begin
    if Busy then
    begin
      if (Value in Bmp32Styles) and not(Style in Bmp32Styles) then
      begin
        Pic.Canvas.Lock;
        try
          Pic.PixelFormat := pf32bit;
        finally
          Pic.Canvas.Unlock;
        end;
        Media.Canvas.Lock;
        try
          Media.PixelFormat := pf32bit;
        finally
          Media.Canvas.Unlock;
        end;
      end;
    end;
    fStyle := Value;
  end;
end;

procedure TCustomPicShow.SetStyleName(const Value: String);
var
  TheStyle: TShowStyle;
begin
  if AnsiCompareText(CustomEffectName, Value) = 0 then
    Style := 0
  else
    for TheStyle := Low(PSEffects) to High(PSEffects) do
      if AnsiCompareText(PSEffects[TheStyle].Name, Value) = 0 then
      begin
        Style := TheStyle;
        Break;
      end;
end;

function TCustomPicShow.GetStyleName: String;
begin
  if Style = 0 then
    Result := CustomEffectName
  else
    Result := PSEffects[Style].Name;
end;

function TCustomPicShow.GetEmpty: Boolean;
begin
  Result := (Picture.Graphic = nil) or Picture.Graphic.Empty;
end;

procedure TCustomPicShow.PictureChange(Sender: TObject);
begin
  if not(csDestroying in ComponentState) then
  begin
    if (Picture.Graphic <> nil) and AutoSize then
      AdjustClientSize;
    DoChange;
  end;
end;

procedure TCustomPicShow.BgPictureChange(Sender: TObject);
begin
  if (BgMode <> bmNone) and not Drawing then
    Invalidate;
end;

function GetUpdateRectPS(hWnd: hWnd; lpRect: PRect; bErase: BOOL): BOOL;
  stdcall; external user32 name 'GetUpdateRect';

procedure TCustomPicShow.SetProgress(Value: TPercent);
begin
  if Value < 0 then
    Value := 0
  else if Value > 100 then
    Value := 100;
  if Busy and (Progress <> Value) then
  begin
    EnterCriticalSection(CS);
    try
      fProgress := Value;
      UpdateMedia;
    finally
      LeaveCriticalSection(CS);
    end;
    if GetUpdateRectPS(WindowHandle, nil, False) then
      Update
    else
      SetEvent(UpdateEvent);
    DoProgress;
  end;
end;

procedure TCustomPicShow.SetManual(Value: Boolean);
begin
  if Manual <> Value then
  begin
    fManual := Value;
    WaitForThread;
    if not Busy then
      if Reverse then
        fProgress := 100
      else
        fProgress := 0
    else if not Manual then
      Animate;
  end;
end;

procedure TCustomPicShow.SetAutoSize_(Value: Boolean);
begin
  if AutoSize <> Value then
  begin
    fAutoSize := Value;
    if AutoSize then
      AdjustClientSize;
  end;
end;

function TCustomPicShow.WaitForThread: Boolean;
var
  Msg: TMsg;
begin
  Result := False;
  if Thread <> nil then
  begin
    Thread.Terminate;
    SetEvent(UpdateEvent);
    Thread.WaitFor;
    if TAnimateThread(Thread).Executed then
      repeat
        if PeekMessage(Msg, Handle, PS_THREADTERMINATED, PS_THREADTERMINATED,
          PM_REMOVE) then
          DispatchMessage(Msg);
      until Thread = nil
    else
    begin
      SendMessage(Handle, PS_THREADTERMINATED, 0, 0);
    end;
    Result := True;
  end;
end;

procedure TCustomPicShow.ThreadTerminated(var Msg: TMessage);
begin
  FreeAndNil(Thread);
  if Stopping or not Manual then
    Unprepare;
end;

procedure TCustomPicShow.WMDestroy(var Msg: TMessage);
begin
  Stop;
  inherited;
end;

procedure TCustomPicShow.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TCustomPicShow.WMPaint(var Msg: TWMPaint);
begin
  if not Drawing then
  begin
    Drawing := True;
    try
      inherited;
    finally
      SetEvent(UpdateEvent);
      Drawing := False;
    end;
  end;
end;

procedure TCustomPicShow.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  if Assigned(fOnMouseEnter) then
    fOnMouseEnter(Self);
end;

procedure TCustomPicShow.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  if Assigned(fOnMouseLeave) then
    fOnMouseLeave(Self);
end;

procedure TCustomPicShow.WMSize(var Msg: TWMSize);
begin
  inherited;
  OffScreen.Width := ClientWidth;
  OffScreen.Height := ClientHeight;
  if Picture.Graphic <> nil then
  begin
    CalculatePicRect;
    if not(Media.Empty or Drawing) then
      Invalidate;
  end;
end;

procedure TCustomPicShow.PaintBackground(Canvas: TCanvas; const Rect: TRect);
begin
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect);
  if BgPicture.Graphic <> nil then
  begin
    case BgMode of
      bmTiled:
        DrawTiledImage(Canvas, Rect, BgPicture.Graphic);
      bmStretched:
        Canvas.StretchDraw(Rect, BgPicture.Graphic);
      bmCentered:
        Canvas.Draw((Rect.Right - Rect.Left - BgPicture.Width) div 2,
          (Rect.Bottom - Rect.Top - BgPicture.Height) div 2, BgPicture.Graphic);
    end;
  end;
end;

procedure TCustomPicShow.Paint;
var
  R: TRect;
  C: TCanvas;
begin
  R := ClientRect;
  C := OffScreen.Canvas;
  C.Lock;
  try
    PaintBackground(C, R);
    Media.Canvas.Lock;
    try
      if not Media.Empty then
      begin
        if Stretch then
          if StretchFine then
            C.StretchDraw(ScaleImageToRect(PicRect, R), Media)
          else
            C.StretchDraw(R, Media)
        else
          C.Draw(PicRect.Left, PicRect.Top, Media);
      end;
    finally
      Media.Canvas.Unlock;
    end;
    if csDesigning in ComponentState then
    begin
      C.Pen.Style := psDash;
      C.Brush.Style := bsClear;
      C.Rectangle(0, 0, Width, Height);
    end;
    Canvas.Draw(0, 0, OffScreen);
  finally
    C.Unlock;
  end;
  NeverDrawn := False;
end;

procedure TCustomPicShow.AdjustClientSize;
begin
  if (Picture.Graphic <> nil) and (Align <> alClient) then
  begin
    if not(Align in [alTop, alBottom]) then
      ClientWidth := Picture.Width;
    if not(Align in [alLeft, alRight]) then
      ClientHeight := Picture.Height;
  end;
end;

procedure TCustomPicShow.CalculatePicRect;
begin
  if not Media.Empty then
  begin
    SetRect(PicRect, 0, 0, Media.Width, Media.Height);
    if Center then
      OffsetRect(PicRect, (ClientWidth - Media.Width) div 2,
        (ClientHeight - Media.Height) div 2);
  end;
end;

procedure TCustomPicShow.InvalidateArea(Area: TRect);
var
  R: TRect;
begin
  if Stretch then
  begin
    if StretchFine then
      R := ScaleImageToRect(PicRect, ClientRect)
    else
      R := ClientRect;
    Area.Left := R.Left + MulDiv(Area.Left, R.Right - R.Left,
      PicRect.Right - PicRect.Left);
    Area.Right := R.Left + MulDiv(Area.Right, R.Right - R.Left,
      PicRect.Right - PicRect.Left);
    Area.Top := R.Top + MulDiv(Area.Top, R.Bottom - R.Top,
      PicRect.Bottom - PicRect.Top);
    Area.Bottom := R.Top + MulDiv(Area.Bottom, R.Bottom - R.Top,
      PicRect.Bottom - PicRect.Top);
  end
  else
  begin
    if Center then
      OffsetRect(Area, PicRect.Left, PicRect.Top);
    if Area.Left < PicRect.Left then
      Area.Left := PicRect.Left;
    if Area.Right > PicRect.Right then
      Area.Right := PicRect.Right;
    if Area.Top < PicRect.Top then
      Area.Top := PicRect.Top;
    if Area.Bottom > PicRect.Bottom then
      Area.Bottom := PicRect.Bottom;
  end;
  if WindowHandle <> 0 then
    InvalidateRect(WindowHandle, @Area, False);
end;

procedure TCustomPicShow.DoChange;
begin
  if Assigned(fOnChange) then
    fOnChange(Self);
end;

procedure TCustomPicShow.DoProgress;
begin
  if Assigned(fOnProgress) then
    fOnProgress(Self);
end;

procedure TCustomPicShow.DoCustomDraw(Picture, Screen: TBitmap);
begin
  if Assigned(fOnCustomDraw) then
    fOnCustomDraw(Self, Picture, Screen);
end;

procedure TCustomPicShow.DoBeforeNewFrame(Picture, Screen: TBitmap);
begin
  if Assigned(fOnBeforeNewFrame) then
    fOnBeforeNewFrame(Self, Picture, Screen);
end;

procedure TCustomPicShow.DoAfterNewFrame(Picture, Screen: TBitmap);
begin
  if Assigned(fOnAfterNewFrame) then
    fOnAfterNewFrame(Self, Picture, Screen);
end;

procedure TCustomPicShow.DoComplete;
begin
  if Assigned(fOnComplete) then
    fOnComplete(Self);
end;

procedure TCustomPicShow.DoStart(NewPicture, OldPicture: TBitmap);
begin
  if Assigned(fOnStart) then
    fOnStart(Self, NewPicture, OldPicture);
end;

procedure TCustomPicShow.DoStop;
begin
  if Assigned(fOnStop) then
    fOnStop(Self);
end;

Procedure TCustomPicShow.Clear;
begin
  if not(Busy or Media.Empty) then
  begin
    Media.Free;
    Media := TBitmap.Create;
    Invalidate;
  end;
end;

procedure TCustomPicShow.Stop;
begin
  if Busy and not Stopping then
  begin
    Stopping := True;
    try
      if Manual or not WaitForThread then
        Unprepare;
    finally
      Stopping := False;
    end;
  end;
end;

procedure TCustomPicShow.Execute;
begin
  if (Picture.Graphic <> nil) and not Busy then
  begin
    fBusy := True;
    try
      HandleNeeded;
      Prepare;
      if not(Manual or Stopping) then
        Animate;
    except
      if Pic <> nil then
        FreeAndNil(Pic);
      if OldPic <> nil then
        FreeAndNil(OldPic);
      fBusy := False;
      raise;
    end;
  end;
end;

procedure TCustomPicShow.Animate;
var
  StartTime: DWORD;
  Done: Boolean;
begin
  if Threaded then
    Thread := TAnimateThread.Create(Self)
  else
  begin
    Done := False;
    repeat
      StartTime := GetTickCount;
      if Reverse then
        if Progress > Step then
          Progress := Progress - Step
        else
          Progress := 0
      else if Progress < 100 - Step then
        Progress := Progress + Step
      else
        Progress := 100;
      if (Reverse and (Progress = 0)) or (not Reverse and (Progress = 100)) then
        Done := not fManual
      else
        repeat
          Application.ProcessMessages;
        until ((GetTickCount - StartTime) > Delay) or Manual or Stopping;
    until Done or Manual or Stopping;
    if Stopping or not Manual then
      Unprepare;
  end;
end;

procedure TCustomPicShow.Prepare;
var
  OldPicRect: TRect;
begin
  PicWidth := Picture.Width;
  PicHeight := Picture.Height;
  Media.Width := PicWidth;
  Media.Height := PicHeight;
  CalculatePicRect;
  if Stretch then
    if StretchFine then
      OldPicRect := ScaleImageToRect(PicRect, ClientRect)
    else
      OldPicRect := ClientRect
  else
    OldPicRect := PicRect;
  OldPic := TBitmap.Create;
  OldPic.Canvas.Brush.Color := Color;
  OldPic.Width := PicWidth;
  OldPic.Height := PicHeight;
  if NeverDrawn or not OverDraw then
    PaintBackground(OffScreen.Canvas, ClientRect);
  SetStretchBltMode(OldPic.Canvas.Handle, COLORONCOLOR);
  OldPic.Canvas.CopyRect(Rect(0, 0, PicWidth, PicHeight), OffScreen.Canvas,
    OldPicRect);
  Pic := TBitmap.Create;
  try
    Pic.Assign(Picture.Graphic);
  except
    Pic.Width := PicWidth;
    Pic.Height := PicHeight;
    Pic.Canvas.Draw(0, 0, Picture.Graphic);
  end;
  if Style in Bmp32Styles then
  begin
    Pic.PixelFormat := pf32bit;
    Media.PixelFormat := pf32bit;
  end
  else
    Media.HandleType := bmDDB;
  if Reverse then
    fProgress := 100
  else
    fProgress := 0;
  DoStart(Pic, OldPic);
end;

procedure TCustomPicShow.Unprepare;
begin
  fBusy := False;
  if Pic <> nil then
    FreeAndNil(Pic);
  if OldPic <> nil then
    FreeAndNil(OldPic);
  if not(csDestroying in ComponentState) then
  begin
    if not Stopping then
      DoComplete;
    DoStop;
  end;
end;

procedure TCustomPicShow.UpdateMedia;
var
  R: TRect;
begin
  Pic.Canvas.Lock;
  Media.Canvas.Lock;
  try
    OldPic.Canvas.Lock;
    try
      Media.Canvas.Draw(0, 0, OldPic);
    finally
      OldPic.Canvas.Unlock;
    end;
    if Assigned(fOnBeforeNewFrame) then
      fOnBeforeNewFrame(Self, Pic, Media);
    SetRect(R, 0, 0, PicWidth, PicHeight);
    if Progress = 100 then
      Media.Canvas.Draw(0, 0, Pic)
    else if Progress <> 0 then
    begin
      if Style = 0 then
        DoCustomDraw(Pic, Media)
      else
        PSEffects[Style].Proc(Media, Pic, R, Step, Progress);
    end;
    InvalidateArea(R);
    if Assigned(fOnAfterNewFrame) then
      fOnAfterNewFrame(Self, Pic, Media);
  finally
    Media.Canvas.Unlock;
    Pic.Canvas.Unlock;
  end;
end;

{ TDBPicShow }

constructor TDBPicShow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fAutoDisplay := True;
  fDataLink := TFieldDataLink.Create;
  fDataLink.Control := Self;
  fDataLink.OnDataChange := DataChange;
  fDataLink.OnUpdateData := UpdateData;
  fDataLink.OnEditingChange := EditingChange;
end;

destructor TDBPicShow.Destroy;
begin
  fDataLink.Free;
  fDataLink := nil;
  inherited Destroy;
end;

function TDBPicShow.GetDataSource: TDataSource;
begin
  Result := fDataLink.DataSource;
end;

procedure TDBPicShow.SetDataSource(Value: TDataSource);
begin
  if not(fDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    fDataLink.DataSource := Value;
  if fDataLink.DataSource <> nil then
    fDataLink.DataSource.FreeNotification(Self);
end;

function TDBPicShow.GetDataField: string;
begin
  Result := fDataLink.FieldName;
end;

procedure TDBPicShow.SetDataField(const Value: string);
begin
  fDataLink.FieldName := Value;
end;

function TDBPicShow.GetReadOnly: Boolean;
begin
  Result := fDataLink.ReadOnly;
end;

procedure TDBPicShow.SetReadOnly(Value: Boolean);
begin
  fDataLink.ReadOnly := Value;
end;

function TDBPicShow.GetField: TField;
begin
  Result := fDataLink.Field;
end;

procedure TDBPicShow.SetAutoDisplay(Value: Boolean);
begin
  if AutoDisplay <> Value then
  begin
    fAutoDisplay := Value;
    if AutoDisplay and not fDataLink.Editing then
      LoadPicture;
  end;
end;

procedure TDBPicShow.DoChange;
begin
  inherited DoChange;
  if fLoaded and fDataLink.Editing then
  begin
    fDataLink.Modified;
    fModified := True;
    if Busy then
      Stop;
    if (Picture.Graphic = nil) or Picture.Graphic.Empty then
      Clear
    else
      Execute;
  end;
end;

procedure TDBPicShow.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (fDataLink <> nil) and (AComponent = DataSource)
  then
    DataSource := nil;
end;

function TDBPicShow.FindGraphicClass(Stream: TMemoryStream): TGraphicClass;
var
  I: Integer;
begin
  Result := nil;
  for I := Low(GraphicSigns) to High(GraphicSigns) do
    with GraphicSigns[I] do
      if (DWORD(Stream.Size) >= (Offset + Length)) and
        CompareMem(Pointer(DWORD(Stream.Memory) + Offset), Signature, Length)
      then
      begin
        Result := GraphicClass;
        Break;
      end;
  if Assigned(fOnGetGraphicClass) then
    fOnGetGraphicClass(Self, Result);
end;

procedure TDBPicShow.LoadPictureFromStream(Stream: TMemoryStream;
  GraphicClass: TGraphicClass);
var
  Graphic: TGraphic;
begin
  if GraphicClass = nil then
  begin
    Picture.Graphic := nil;
    raise EInvalidGraphic.Create('Неизвестный формат картинки');
  end
  else if GraphicClass = TBitmap then
    Picture.Bitmap.LoadFromStream(Stream)
  else if GraphicClass = TMetafile then
    Picture.Metafile.LoadFromStream(Stream)
  else if GraphicClass = TIcon then
    Picture.Icon.LoadFromStream(Stream)
  else
  begin
    Graphic := GraphicClass.Create;
    try
      Graphic.LoadFromStream(Stream);
      Picture.Assign(Graphic);
    finally
      Graphic.Free;
    end;
  end;
end;

procedure TDBPicShow.LoadPicture;
var
  Stream: TMemoryStream;
begin
  if not fLoaded and (fDataLink.Field <> nil) and (fDataLink.Field is TBlobField)
  then
  begin
    if Busy then
      Stop;
    try
      if not fDataLink.Field.IsNull then
      begin
        if Assigned(fOnBeforeLoadPicture) then
          fOnBeforeLoadPicture(Self);
        Stream := TMemoryStream.Create;
        try
          TBlobField(fDataLink.Field).SaveToStream(Stream);
          if Stream.Size > 0 then
          begin
            Stream.Position := 0;
            LoadPictureFromStream(Stream, FindGraphicClass(Stream));
          end;
        finally
          Stream.Free;
        end;
        if Assigned(fOnAfterLoadPicture) then
          fOnAfterLoadPicture(Self);
      end;
    finally
      fLoaded := True;
      if (Picture.Graphic = nil) or Picture.Graphic.Empty then
        Clear
      else
        Execute;
    end;
  end;
end;

procedure TDBPicShow.DataChange(Sender: TObject);
begin
  if not fSkipLoading then
  begin
    fLoaded := False;
    fModified := False;
    Picture.Graphic := nil;
    if AutoDisplay then
      LoadPicture;
  end;
  fSkipLoading := False;
end;

procedure TDBPicShow.EditingChange(Sender: TObject);
begin
  if fDataLink.Editing then
    fSkipLoading := (fDataLink.DataSet.State <> dsInsert)
  else
    fSkipLoading := not fModified;
end;

procedure TDBPicShow.UpdateData(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  fModified := False;
  fDataLink.Field.Clear;
  if (Picture.Graphic <> nil) and not Picture.Graphic.Empty and
    (fDataLink.Field is TBlobField) then
  begin
    Stream := TMemoryStream.Create;
    try
      Picture.Graphic.SaveToStream(Stream);
      Stream.Seek(0, soFromBeginning);
      TBlobField(fDataLink.Field).LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TDBPicShow.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(fDataLink);
end;

end.
