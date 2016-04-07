unit ChildFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

Type
  TFormMode = (fmInactive, fmBrowse, fmInsert, fmEdit);

type
  TChildForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fIndex: Integer;
    FAsChild: Boolean;
    FTempParent: TWinControl;
    FormVar: ^TChildForm;
    FFormMode: TFormMode;
    FOnSetFormMode: TNotifyEvent;
    fCapt: string;
    fShM: Boolean;
  protected
    sndWind: HWND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure SetFormMode(AValue: TFormMode); virtual;
    function GetFormMode: TFormMode; virtual;

  public
    property Index: Integer read fIndex write fIndex;

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean); reintroduce; overload;
    constructor Create(AOwner: TComponent; Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string); reintroduce; overload;
    constructor Create(AOwner: TComponent; AParent: TWinControl; Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string); reintroduce; overload;
    destructor Destroy; override;
  published
    property FormMode: TFormMode read GetFormMode write SetFormMode;
    property OnSetFormMode: TNotifyEvent read FOnSetFormMode write FOnSetFormMode;
  end;

var
  ChildForm: TChildForm;

implementation

{$R *.dfm}

uses Func_Const;

constructor TChildForm.Create(AOwner: TComponent);
begin
  FAsChild := False;
  inherited Create(AOwner);
end;

constructor TChildForm.Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean);
begin
  FAsChild := False;
  FormVar := @AFormVar;
  fCapt := Cpt;
  fShM := ShM;
  inherited Create(AOwner);
end;

constructor TChildForm.Create(AOwner: TComponent; Itm: Integer;
  var AFormVar: TChildForm; dscr: HWND; Cpt: string);
begin
  FAsChild := False;
  Index := Itm;
  FormVar := @AFormVar;
  sndWind := dscr;
  fCapt := Cpt;
  fShM := False;
  inherited Create(AOwner);
end;

constructor TChildForm.Create(AOwner: TComponent; AParent: TWinControl;
  Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string);
begin
  FAsChild := True;
  FTempParent := AParent;
  Index := Itm;
  FormVar := @AFormVar;
  sndWind := dscr;
  fCapt := Cpt;
  fShM := False;
  inherited Create(AOwner);
end;

destructor TChildForm.Destroy;
begin
  FormVar^ := nil;
  // if not FAsChild then
  SendMessage(sndWind, WM_NOTIFY_CLSMDI, 0, DWORD(PChar('Close Form')));
  inherited Destroy;
end;

procedure TChildForm.Loaded;
begin
  inherited;
  Caption := fCapt;
  KeyPreview := True;
  ShowHint := True;
  if FAsChild then
  begin
    align := alClient;
    BorderStyle := bsNone;
    BorderIcons := [];
    Parent := FTempParent;
    Position := poMainFormCenter;
    FormStyle := fsNormal;
  end
  else
  begin
    if not fShM then
      FormStyle := fsMDIChild
    else
    begin
      align := alNone;
      FormStyle := fsNormal;
      WindowState := wsNormal;
      Position := poScreenCenter;
    end;

  end;
end;

procedure TChildForm.CreateParams(var Params: TCreateParams);
Begin
  Inherited CreateParams(Params);
  if FAsChild then
    Params.Style := Params.Style or WS_CHILD;
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Inherited;
end;

procedure TChildForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and ((FFormMode = fmBrowse) or (FFormMode = fmInactive))
  then
    close;
  Inherited;

end;

procedure TChildForm.SetFormMode(AValue: TFormMode);
begin
  FFormMode := AValue;
  if Assigned(FOnSetFormMode) then
    FOnSetFormMode(self);
end;

function TChildForm.GetFormMode: TFormMode;
begin
  Result := FFormMode;
end;

end.
