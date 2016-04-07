unit ChildFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,   Func_Const, TimedMsgBox,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;



type
  TChildForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure MessageReceiver(var Msg: TMessage); message WM_NOTIFY_GLOSE_GLOBAL;
  private
    fIndex: Integer;
    FormVar: ^TChildForm;
    FFormMode: TFormMode;
    FOnSetFormMode: TNotifyEvent;
    fCapt: string;
    fShM: Boolean;
    fCloseGlobal : Boolean;
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
    destructor Destroy; override;
  published
    property FormMode: TFormMode read GetFormMode write SetFormMode;
    property OnSetFormMode: TNotifyEvent read FOnSetFormMode write FOnSetFormMode;
  end;

var
  ChildForm: TChildForm;

implementation

{$R *.dfm}


constructor TChildForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TChildForm.Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean);
begin
  FormVar := @AFormVar;
  fCapt := Cpt;
  fShM := ShM;
  inherited Create(AOwner);
end;

constructor TChildForm.Create(AOwner: TComponent; Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string);
begin
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
  SendMessage(sndWind, WM_NOTIFY_CLSMDI, 0, DWORD(PChar('Close Form')));
  inherited Destroy;
end;

procedure TChildForm.Loaded;
begin
  inherited;
  Caption := fCapt;
  KeyPreview := True;
  ShowHint := True;
  if not fShM then
    FormStyle := fsMDIChild
  else
  begin
    align := alNone;
    FormStyle := fsNormal;
    WindowState := wsNormal;
  end;
end;

procedure TChildForm.CreateParams(var Params: TCreateParams);
Begin
  Inherited CreateParams(Params);
end;

procedure TChildForm.MessageReceiver(var Msg: TMessage);
begin
  Msg.Result := 1;
  fCloseGlobal := True;
end;

procedure TChildForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Inherited;
end;

procedure TChildForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {
  if (not fShM) then
  begin
    if (not fCloseGlobal) then
    begin
      if (TimedMessageBox('Вы действительно хотите закрыть это окно?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes,mbNo], mbYes, 15, 3) = mrYes) then
        CanClose := True
      else
        CanClose := false;
    end else begin
      CanClose := True;
    end;
  end else begin
    CanClose := True;
  end;
  }
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
  if (FFormMode <> AValue) then
  begin
    FFormMode := AValue;
    if Assigned(FOnSetFormMode) then
      FOnSetFormMode(self);
  end;
end;

function TChildForm.GetFormMode: TFormMode;
begin
  Result := FFormMode;
end;

end.
