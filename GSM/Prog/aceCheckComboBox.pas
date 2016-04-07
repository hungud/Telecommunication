unit aceCheckComboBox;
{//$I sDefs.inc}

interface

uses
  Classes, Messages, Forms, Controls, SysUtils, Windows, ExtCtrls,
  {$IFDEF DELPHI7UP}Types, {$ENDIF}
  sMaskEdit, sCustomComboEdit, sComboEdit, sCheckListBox;


type
  TacCustomCheckComboBox = class;


  TacCustomPopupForm = class(TForm)
  private
    fCheckComboBox: TacCustomCheckComboBox;
    fCheckListBox: TsCheckListBox;
    procedure UpdateCheckList;
    procedure OnClickCheck(Sender: TObject);
    procedure OnDblClick(Sender: TObject);
  protected
    procedure DoExit; override;
    procedure Deactivate; override;
    procedure DoClose(var Action: TCloseAction); override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;


  TCheckListItem = class(TCollectionItem)
  private
    fShortCaption: string;
    fCaption: string;
    fChecked: boolean;
    fGUID: String;
    procedure SetCaption(const Value: string);
    procedure SetChecked(const Value: boolean);
    procedure SetShortCaption(const Value: string);
    procedure SetGUID(const Value: string);
  protected
    FData: TObject;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure AddObject(AObject: TObject);
    function GetObject: TObject;
  published
    property Caption: string read fCaption write SetCaption;
    property ShortCaption: string read fShortCaption write SetShortCaption;
    property Checked: boolean read fChecked write SetChecked;
    property GUID: string read fGUID write SetGUID;
  end;


  TCheckListCollection = class(TOwnedCollection)
  protected
    procedure Update(Item: TCollectionItem); override;
  end;


  TOnCloseUp = procedure(Sender: TacCustomCheckComboBox; Changed: Boolean) of object;
  TOnDblClickItemEvent = procedure(Sender: TacCustomCheckComboBox; ItemIndex: Integer) of object;


  TacCustomCheckComboBox = class(TsComboEdit)
  private
    fItems: TCheckListCollection;
    fTextAllChecked: string;
    fTextEmpty: string;
    FDivider: string;
    fShowShortCaption: boolean;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TOnCloseUp;
    FDropDownCount: integer;
    FSingleItemCheck: Boolean;
    FOnDblClickItem: TOnDblClickItemEvent;
    procedure SetItems(const Value: TCheckListCollection);
    procedure SetTextAllChecked(const Value: string);
    procedure SetTextEmpty(const Value: string);
    function GetAsInteger: integer;
    procedure SetAsInteger(const Value: integer);
    procedure SetDivider(const Value: string);
    procedure SetShowShortCaption(const Value: boolean);
  protected
    HintTimer: TTimer;
    FChanged: Boolean;
    HintWnd: THintWindow;
    procedure PopupWindowShow; override;
    procedure PopupWindowClose; override;
    procedure CreatePopup;
    procedure UpdateDisplayText;
    procedure HideHint;
  public
    FBtnPressed: boolean;
    constructor Create(aOwner:TComponent); override;
    destructor Destroy; override;
    procedure WndProc (var Message: TMessage); override;
    procedure TimerProc(Sender: TObject);
    procedure StartShowHint;
    function CheckedCount: integer;
    function GetCheckedItems: string;

    property Items: TCheckListCollection read FItems write SetItems;
    property DirectInput;
    procedure UpdateCheckList;

    property ShowShortCaption: boolean read fShowShortCaption write SetShowShortCaption default True;
    property Divider: string read fDivider write SetDivider;
    property DropDownCount : integer read FDropDownCount write FDropDownCount default 16;
    property TextEmpty: string read fTextEmpty write SetTextEmpty;
    property TextAllChecked: string read fTextAllChecked write SetTextAllChecked;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property SingleItemCheck: Boolean read FSingleItemCheck write FSingleItemCheck default False;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TOnCloseUp read FOnCloseUp write FOnCloseUp;
    property OnDblClickItem: TOnDblClickItemEvent read FOnDblClickItem write FOnDblClickItem;
  end;


  TacCheckComboBox = class(TacCustomCheckComboBox)
  published
    property Alignment;
    property AsInteger;
    property CharCase;
    property ClickKey;
    property Divider;
    property EditMask;
    property Enabled;
    property Font;
    property HideSelection;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property ImeMode;
    property ImeName;
    property Items;
    property MaxLength;
    property OEMConvert;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowShortCaption;
    property TabOrder;
    property TabStop;
    property Text;
    property TextAllChecked;
    property TextEmpty;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnEndDock;
    property OnStartDock;

    property AutoSelect;
    property HelpContext;
    property PasswordChar;
    property Hint;
    property SingleItemCheck;

    property DragCursor;
    property OnEnter;
    property OnExit;

    property OnDblClickItem;
  end;


implementation


uses
  Math, Graphics,
  sConst, acntUtils, sGraphUtils, sCommonData, sVCLUtils;


type
  TacPopupCheckListBox = class(TsCheckListBox)
  public
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
  end;


procedure TacPopupCheckListBox.CNKeyDown(var Message: TWMKeyDown);
begin
  case Message.CharCode of
    VK_TAB: SendMessage(TacCustomPopupForm(Parent).fCheckComboBox.Handle, Message.Msg, TMessage(Message).WParam, TMessage(Message).LParam);
    VK_RETURN, VK_ESCAPE, VK_CANCEL: TacCustomPopupForm(Parent).Close;
  end;
  Message.Result := 0;
end;


procedure TacCustomPopupForm.AfterConstruction;
begin
  inherited;
  BorderStyle := bsNone;
  FCheckListBox := TacPopupCheckListBox.Create(Self);
  FCheckListBox.Parent := Self;
  FCheckListBox.Align := alClient;
  FCheckListBox.ParentFont := True;
  FCheckListBox.OnClickCheck := OnClickCheck;
  FCheckListBox.OnDblClick := OnDblClick;
  Visible := False;
  if not FCheckListBox.SkinData.Skinned then begin
    Color := clBtnShadow;
    BorderStyle := bsNone;
    BorderWidth := 1;
    FCheckListBox.Ctl3D := False;
    FCheckListBox.BorderStyle := bsNone;
  end;
end;


constructor TacCustomPopupForm.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;


type
  TAccessButton = class(TsEditButton);


procedure TacCustomPopupForm.Deactivate;
begin
  FCheckComboBox.FBtnPressed := TAccessButton(FCheckComboBox.Button).MouseInControl;
  inherited;
  Visible := False;
  if Assigned(FCheckComboBox.OnCloseUp) then
    FCheckComboBox.OnCloseUp(FCheckComboBox, FCheckComboBox.FChanged);
end;


destructor TacCustomPopupForm.Destroy;
begin
  fCheckComboBox.fPopupWindow := nil;
  inherited;
end;


procedure TacCustomPopupForm.DoClose(var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;


procedure TacCustomPopupForm.DoExit;
begin
  inherited;
  Visible := False;
  if Assigned(fCheckComboBox.OnCloseUp) then
    fCheckComboBox.OnCloseUp(FCheckComboBox, FCheckComboBox.FChanged);
end;


procedure TacCustomPopupForm.OnClickCheck(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to fCheckComboBox.fItems.Count - 1 do begin
    if fCheckComboBox.FSingleItemCheck then
      fCheckListBox.Checked[i] := fCheckListBox.Selected[i];

    TCheckListItem(fCheckComboBox.fItems.Items[i]).fChecked := fCheckListBox.Checked[i];
  end;

  fCheckComboBox.UpdateDisplayText;
  fCheckComboBox.FChanged := True;
end;


procedure TacCustomPopupForm.OnDblClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to fCheckComboBox.fItems.Count - 1 do
    if fCheckListBox.Selected[i] then
    begin
      if Assigned(fCheckComboBox.FOnDblClickItem) then
        fCheckComboBox.FOnDblClickItem(fCheckComboBox, i);
      Break
    end;
end;


type
  TsCheckListBoxAccess = class(TsCheckListBox);


procedure TacCustomPopupForm.UpdateCheckList;
var
  i, m, k: Integer;
  vItem: TCheckListItem;
begin
  fCheckListBox.Items.BeginUpdate;
  try
    fCheckListBox.Items.Clear;
    for i := 0 to fCheckComboBox.fItems.Count - 1 do begin
      vItem := TCheckListItem(fCheckComboBox.fItems.Items[i]);
      fCheckListBox.Checked[fCheckListBox.Items.Add(vItem.fCaption)] := vItem.fChecked;
    end;
    Self.ClientHeight := fCheckListBox.ItemHeight * min(fCheckComboBox.DropDownCount, fCheckListBox.Items.Count) + Integer(fCheckComboBox.SkinData.Skinned) * 4;
    m := 0;
    for i := 0 to fCheckListBox.Items.Count - 1 do begin
      k := fCheckListBox.Canvas.TextWidth(fCheckListBox.Items[i]);
      if m < k then
        m := k;
    end;
    Self.ClientWidth := m + TsCheckListBoxAccess(fCheckListBox).GetCheckWidth + 8;
    Self.fCheckComboBox.PopupWidth := Max(Width, Self.fCheckComboBox.Width);
    Self.fCheckComboBox.PopupAlign := sConst.pwaLeft;
  finally
    fCheckListBox.Items.EndUpdate;
  end;
end;


procedure TCheckListItem.AddObject(AObject: TObject);
begin
  FData := AObject;
end;


constructor TCheckListItem.Create(Collection: TCollection);
begin
  inherited;
  FData := nil;
end;


function TCheckListItem.GetDisplayName: string;
begin
  if fCaption <> '' then
    Result := fCaption
  else
    if fShortCaption <> '' then
      Result := fShortCaption
    else
      Result := inherited GetDisplayName
end;


function TCheckListItem.GetObject: TObject;
begin
  Result := FData;
end;


procedure TCheckListItem.SetCaption(const Value: string);
begin
  if fCaption <> Value then begin
    fCaption := Value;
    Changed(False);
  end;
end;


procedure TCheckListItem.SetChecked(const Value: boolean);
begin
  if fChecked <> Value then begin
    fChecked := Value;
    Changed(False);
  end;
end;


procedure TCheckListItem.SetShortCaption(const Value: string);
begin
  if fShortCaption <> Value then begin
    fShortCaption := Value;
    Changed(False);
  end;
end;


procedure TCheckListItem.SetGUID(const Value: string);
begin
  if fGUID <> Value then begin
    fGUID := Value;
    Changed(False);
  end;
end;


constructor TacCustomCheckComboBox.Create(aOwner: TComponent);
begin
  inherited;
  FItems := TCheckListCollection.Create(Self, TCheckListItem);
  HintTimer := nil;
  HintWnd := nil;
  FShowShortCaption := True;
  FBtnPressed := False;
  FDivider := ',';
  DirectInput := False;
  FDropDownCount := 16;
  FSingleItemCheck := False;
end;


procedure TacCustomCheckComboBox.CreatePopup;
var
  vForm: TacCustomPopupForm;
begin
  if not Assigned(fPopupWindow) then begin
    vForm := TacCustomPopupForm.CreateNew(nil);
    vForm.Tag := ExceptTag;
    vForm.Font.Assign(Font);
    vForm.fCheckComboBox := Self;
    SetClassLong(vForm.Handle, GCL_STYLE, GetClassLong(vForm.Handle, GCL_STYLE) or CS_DROPSHADOW);
    fPopupWindow := vForm;
  end;
  TacCustomPopupForm(fPopupWindow).UpdateCheckList;
  FChanged := False;
end;


destructor TacCustomCheckComboBox.Destroy;
begin
  FreeAndNil(fPopupWindow);
  if HintTimer <> nil then
    HintTimer.Free;

  if HintWnd <> nil then
    FreeAndNil(HintWnd);

  fItems.Free;
  inherited;
end;


function TacCustomCheckComboBox.GetAsInteger: integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to fItems.Count - 1 do
    if TCheckListItem(fItems.Items[i]).Checked then
      Result := Result or (1 shl i);
end;


procedure TacCustomCheckComboBox.PopupWindowClose;
begin
  inherited;
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self, FChanged);
end;


procedure TacCustomCheckComboBox.PopupWindowShow;
var
  P: TPoint;
  Y: Integer;
  Form: TCustomForm;
begin
  if CanFocus then
    SetFocus;

  if FBtnPressed then begin
    FBtnPressed := False;
    Exit;
  end;
  if not (ReadOnly or DroppedDown) then begin
    if Assigned(FOnDropDown) then
      FOnDropDown(Self);

    CreatePopup;
    FPopupWindow.Visible := False;
    FPopupWindow.Width := PopupWidth;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;

    if Y + FPopupWindow.Height > Screen.DesktopHeight then
      Y := P.Y - FPopupWindow.Height;

    case PopupAlign of
      pwaRight: begin
        Dec(P.X, FPopupWindow.Width - Width);
        if P.X < Screen.DesktopLeft then
          Inc(P.X, FPopupWindow.Width - Width);
      end;
      pwaLeft:
        if P.X + FPopupWindow.Width > Screen.DesktopWidth then
          Dec(P.X, FPopupWindow.Width - Width);
    end;
    if P.X < Screen.DesktopLeft then
      P.X := Screen.Desktopleft
    else
      if P.X + FPopupWindow.Width > Screen.DesktopWidth then
        P.X := Screen.DesktopWidth - FPopupWindow.Width;

    Form := GetParentForm(Self);
    if Form <> nil then begin
      if (FPopupWindow is TForm) and (TForm(Form).FormStyle = fsStayOnTop) then
        TForm(FPopupWindow).FormStyle := fsStayOnTop;

      SetWindowPos(FPopupWindow.Handle, GetNextWindow(Form.Handle, GW_HWNDPREV), P.X, Y, FPopupWindow.Width, FPopupWindow.Height, SWP_SHOWWINDOW or SWP_NOACTIVATE);
      fPopupWindow.Left := P.X;
      FPopupWindow.Top := Y;//P.Y + Self.Height;
    end;
    FPopupWindow.Visible := True;
    FPopupWindow.SetFocus
  end;
end;


procedure TacCustomCheckComboBox.SetTextAllChecked(const Value: string);
begin
  if fTextAllChecked <> Value then begin
    fTextAllChecked := Value;
    UpdateDisplayText;
  end;
end;


procedure TacCustomCheckComboBox.SetAsInteger(const Value: integer);
var
  i: Integer;
begin
  for i := 0 to fItems.Count - 1 do
    TCheckListItem(fItems.Items[i]).Checked := (Value and (1 shl i)) <> 0;
end;


procedure TacCustomCheckComboBox.SetDivider(const Value: string);
begin
  if fDivider <> Value then begin
    fDivider := Value;
    UpdateDisplayText;
  end;
end;


procedure TacCustomCheckComboBox.SetTextEmpty(const Value: string);
begin
  if fTextEmpty <> Value then begin
    fTextEmpty := Value;
    UpdateDisplayText;
  end;
end;


procedure TacCustomCheckComboBox.SetItems(const Value: TCheckListCollection);
begin
  fItems.Assign(Value);
end;


procedure TacCustomCheckComboBox.SetShowShortCaption(const Value: boolean);
begin
  if fShowShortCaption <> Value then begin
    fShowShortCaption := Value;
    UpdateDisplayText;
  end;
end;


procedure TacCustomCheckComboBox.UpdateCheckList;
begin
  TacCustomPopupForm(fPopupWindow).UpdateCheckList;
end;


procedure TacCustomCheckComboBox.UpdateDisplayText;
var
  s: string;
  c: integer;
begin
  s := GetCheckedItems;

  c := CheckedCount;
  if c = 0 then begin
    if fTextEmpty <> '' then
      s := fTextEmpty;
  end
  else
    if c = fItems.Count then
      if fTextAllChecked <> '' then
        s := fTextAllChecked;

  if Text <> s then begin
    Text := s;
    SkinData.Invalidate;
    if Assigned(OnChange) then
      OnChange(Self);
  end;
end;


procedure TacCustomCheckComboBox.WndProc(var Message: TMessage);
var
  cw: integer;
begin
  inherited;
  case Message.Msg of
    CM_MOUSEENTER: begin
      cw := Width - integer(ShowButton) * Button.Width - 4 * integer(not Ctl3d);
      if SkinData.FCacheBmp = nil then
        InitCacheBmp(SkinData);

      SkinData.FCacheBmp.Canvas.Font.Assign(Font);
      if acTextWidth(SkinData.FCacheBmp.Canvas, Text) > cw then
        StartShowHint;
    end;

    CM_MOUSELEAVE, WM_LBUTTONDOWN:
      HideHint;
  end;
end;


procedure TacCustomCheckComboBox.StartShowHint;
begin
  if HintTimer = nil then
    HintTimer := TTimer.Create(Self);

  HintTimer.Interval := Application.HintPause;
  HintTimer.OnTimer := TimerProc;
  HintTimer.Enabled := True;
end;


procedure TacCustomCheckComboBox.TimerProc(Sender: TObject);
var
  p: TPoint;
begin
 {
  HideHint;
  p := ClientToScreen(Point(0, 0));
  if PtInRect(Rect(p.X, p.Y, p.X + Width, p.Y + Height), acMousePos) then
    if CheckedCount = FItems.Count then
      HintWnd := acShowHintWnd(Self.TextAllChecked + ': ' + GetCheckedItems, acMousePos)
    else
      HintWnd := acShowHintWnd(Text, acMousePos);

  HintTimer.Enabled := False;
  }
end;


procedure TacCustomCheckComboBox.HideHint;
begin
  if HintWnd <> nil then
    FreeAndNil(HintWnd);
end;


function TacCustomCheckComboBox.CheckedCount: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to FItems.Count - 1 do
    if TCheckListItem(fItems.Items[i]).fChecked then
      inc(Result);
end;


function TacCustomCheckComboBox.GetCheckedItems: string;
var
  i: integer;
begin
  for i := 0 to fItems.Count - 1 do
    if TCheckListItem(fItems.Items[i]).fChecked then begin
      if Result <> '' then
        Result := Result + fDivider;

      if fShowShortCaption and (TCheckListItem(fItems.Items[i]).fShortCaption <> '') then
        Result := Result + TCheckListItem(fItems.Items[i]).fShortCaption
      else
        Result := Result + TCheckListItem(fItems.Items[i]).fCaption
    end;
end;


procedure TCheckListCollection.Update(Item: TCollectionItem);
begin
  inherited;
{$IFDEF DELPHI7UP}
  TacCustomCheckComboBox(Owner).UpdateDisplayText;
{$ENDIF}
end;

end.
