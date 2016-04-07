unit CaptchaCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, DBCtrls, ExtCtrls, ImgList, PNGImage,
  StdCtrls, sEdit, Buttons, sBitBtn;

type
  TCapchaCheckForm = class(TForm)
    qCaptcha: TOraQuery;
    dsCaptcha: TDataSource;
    qCaptchaIMAGE_ID: TFloatField;
    qCaptchaDATE_CHECK: TDateTimeField;
    qCaptchaDATE_VERITY: TDateTimeField;
    qCaptchaSTR_VALUE: TStringField;
    qCaptchaIMAGE_BLOB: TBlobField;
    Image: TImage;
    seValue: TsEdit;
    sbtCheck: TsBitBtn;
    procedure FormShow(Sender: TObject);
    procedure sbtCheckClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure seValueKeyPress(Sender: TObject; var Key: Char);
  private
    procedure SetValue;
  public
    procedure Refresh;
  end;

procedure DoCaptchaCheck;

var
  CapchaCheckForm: TCapchaCheckForm;

implementation

{$R *.dfm}

uses MainUnit;

procedure DoCaptchaCheck;
var ReportFrm : TCapchaCheckForm;
    Sdvig:integer;
begin
  ReportFrm:=TCapchaCheckForm.Create(Nil);
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TCapchaCheckForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.FCaptcha:=true;
  Action:=caFree;
end;

procedure TCapchaCheckForm.FormCreate(Sender: TObject);
begin
  MainForm.FCaptcha:=false;
end;

procedure TCapchaCheckForm.FormShow(Sender: TObject);
begin
  Refresh;
end;

procedure TCapchaCheckForm.Refresh;
 var
Stream, st, stl: TStream;
Png: TPngImage;
tb: TBlobField;
begin
  qCaptcha.Close;
  qCaptcha.Open;
  png:= TPngImage.Create;
  seValue.SetFocus;
  if qCaptcha.Active and (qCaptcha.RecordCount > 0) then
    try
    Stream := qCaptcha.CreateBlobStream(qCaptcha.FieldByName('IMAGE_BLOB'), bmRead);
    png.LoadFromStream(Stream);
      Image.Height:=png.Height;
      Image.Width:=png.Width;
      Image.Picture.Assign(PNG);
    finally
      Stream.Free;
    end
  else
  begin
    MainForm.FCaptcha:=true;
    ModalResult := mrOk;
  end;
end;

procedure TCapchaCheckForm.sbtCheckClick(Sender: TObject);
begin
  SetValue;
end;

procedure TCapchaCheckForm.SetValue;
begin
  if qCaptcha.Active and (qCaptcha.RecordCount > 0) then
  begin
    qCaptcha.Edit;
    qCaptchaSTR_VALUE.AsString:=seValue.Text;
    qCaptcha.Post;
  end;
  seValue.Text:='';
  Refresh;
end;

procedure TCapchaCheckForm.seValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SetValue;
end;

end.
