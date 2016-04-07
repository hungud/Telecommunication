unit SettingProg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, uDm, Vcl.StdCtrls, TimedMsgBox,
  Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, sLabel, sCheckBox, Func_Const,
  sBevel, sButton, acImage, Vcl.Imaging.jpeg, Vcl.ComCtrls, sPageControl, sEdit,
  sUpDown;

type
  TSettingProgForm = class(TChildForm)
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sCheckBox1: TsCheckBox;
    sBevel1: TsBevel;
    sCheckBox3: TsCheckBox;
    sBevel2: TsBevel;
    sBevel3: TsBevel;
    sCheckBox2: TsCheckBox;
    sLabel2: TsLabel;
    sImage1: TsImage;
    sLabel1: TsLabel;
    sButton1: TsButton;
    sCheckBox4: TsCheckBox;
    sBevel4: TsBevel;
    sCheckBox5: TsCheckBox;
    sBevel5: TsBevel;
    sUpDown1: TsUpDown;
    sEdit1: TsEdit;
    sLabel3: TsLabel;
    sImage2: TsImage;
    sPanel2: TsPanel;
    procedure FormCreate(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    function CheckDataChange : Boolean;
    procedure sBsaveClick(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
    procedure sCheckBox4Click(Sender: TObject);
    procedure sCheckBox5Click(Sender: TObject);
    procedure sUpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure sEdit1Change(Sender: TObject);
  private
    { Private declarations }
    Loaded, old_ShowInfoChanger, old_ShowInfoCreator, old_UsePictForFon, old_AskExcelFileName, old_ChangeKeyboardLayout : Boolean;
    old_MoveNext : Integer;
  public
    { Public declarations }
  end;

var
  SettingProgForm: TSettingProgForm;

implementation

{$R *.dfm}


function TSettingProgForm.CheckDataChange : Boolean;
begin
  Result := false;
  if Loaded then
  begin
    Result := (old_AskExcelFileName <> Dm.AskExcelFileName);
    if Result then
      Exit;

    Result := (old_MoveNext <> Dm.MoveNext);
    if Result then
    begin
      Exit;
    end;
    Result := (old_ChangeKeyboardLayout <> Dm.ChangeKeyboardLayout);
    if Result then
      Exit;

    Result := (old_ShowInfoCreator <> Dm.ShowInfoCreator);
    if Result then
      Exit;

    Result := (old_ShowInfoChanger <> Dm.ShowInfoChanger);
    if Result then
      Exit;

    Result := (old_UsePictForFon <> Dm.UsePictForFon);

    if old_UsePictForFon then
      Result := (Dm.dlgOpenPic.FileName <> '') and (Dm.dlgOpenPic.FileName <> Dm.FilePict);
  end;
end;

procedure TSettingProgForm.FormCreate(Sender: TObject);
begin
  inherited;

  old_MoveNext  := Dm.MoveNext;
  sEdit1.Text := IntToStr(Dm.MoveNext);
  sUpDown1.Position := Dm.MoveNext;
  old_AskExcelFileName := Dm.AskExcelFileName;
  old_ChangeKeyboardLayout := Dm.ChangeKeyboardLayout;
  sCheckBox1.Checked := Dm.AskExcelFileName;
  sCheckBox2.Checked := Dm.UsePictForFon;
  sCheckBox3.Checked := Dm.ChangeKeyboardLayout;
  sCheckBox4.Checked := Dm.ShowInfoCreator;
  sCheckBox5.Checked := Dm.ShowInfoChanger;
  sButton1.Enabled := sCheckBox2.Checked;
  if not Dm.UsePictForFon then
    sImage1.Picture := nil
  else
  begin
    try
      sImage1.Picture := Dm.ClientImg;
    except
      sImage1.Picture.LoadFromFile(Dm.FilePict);
    end;
  end;
  Loaded := True;
  if dm.MDI_State then
  begin
    sCheckBox2.Enabled := False;
    sButton1.Enabled := False;
    sLabel2.Caption := 'Изменение фона программы возможно только в однооконном режиме';
  end;
end;

procedure TSettingProgForm.sBsaveClick(Sender: TObject);
var
  str_ : string;
//  wnd: hwnd;
//  buff: array [0..127] of char;
//  i : Integer;
begin
  inherited;
  if (old_AskExcelFileName <> Dm.AskExcelFileName) then
  begin
    Dm.AskExcelFileName := old_AskExcelFileName;
    if Dm.AskExcelFileName then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'ASKEXCELFILENAME', str_);
  end;

  if (old_MoveNext <> Dm.MoveNext) then
  begin
    Dm.MoveNext := old_MoveNext;
    str_ := IntToStr(Dm.MoveNext);
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'MOVENEXT', str_);

    SendMessage(Dm.CurrentWnd, WM_NOTIFY_GO_ON_THE, 0, DWORD(PChar(str_)));
    SendMessage(Dm.MainWnd, WM_NOTIFY_GO_ON_THE, 0, DWORD(PChar(str_)));
  end;

  if (old_UsePictForFon <> Dm.UsePictForFon) then
  begin
    Dm.UsePictForFon := old_UsePictForFon;
    if Dm.UsePictForFon then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'USEPICTFORFON', str_);
  end;

  if (old_ChangeKeyboardLayout <> Dm.ChangeKeyboardLayout) then
  begin
    Dm.ChangeKeyboardLayout := old_ChangeKeyboardLayout;
    if Dm.ChangeKeyboardLayout then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'CHANGEKEYBOARDLAYOUT', str_);
  end;

  if (old_ShowInfoCreator <> Dm.ShowInfoCreator) then
  begin
    Dm.ShowInfoCreator := old_ShowInfoCreator;
    if Dm.ShowInfoCreator then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCREATOR', str_);
  end;

  if (old_ShowInfoChanger <> Dm.ShowInfoChanger) then
  begin
    Dm.ShowInfoChanger := old_ShowInfoChanger;
    if Dm.ShowInfoChanger then
      str_ := '1'
    else
      str_ := '0';
    WriteIniAny(Dm.FileNameIni, 'MAIN_WINDOWS', 'SHOWINFOCHANGER', str_);
  end;

  if not Dm.UsePictForFon then
  begin
     sImage1.Picture := nil;
     Dm.ClientImg := nil;
  end
  else
    if Dm.dlgOpenPic.FileName <> '' then
      Dm.ClientImg.LoadFromFile(Dm.dlgOpenPic.FileName);


end;

procedure TSettingProgForm.sButton1Click(Sender: TObject);
var
 fS : integer;
begin
  inherited;
  if Dm.dlgOpenPic.Execute then
  begin
    try
      fS := GetFileSize(Dm.dlgOpenPic.FileName) div 1024 ;
      Dm.PictExt  := ExtractFileExt(Dm.dlgOpenPic.FileName);
      Dm.FilePict := Dm.PersonalPath + 'img'+ Dm.PictExt;
      if fS > 300 then
       TimedMessageBox('   Размер выбранного рисунка - ' + IntToStr(fS) + ' кб.' + #10+#13 + 'Если размер рисунка больше 300 мб, программа будет работать медленней!' + #10+#13 + 'Попробуйте выбрать другой рисунок!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
      sImage1.Picture.LoadFromFile(Dm.dlgOpenPic.FileName);
      sBsave.Enabled := True;
    except
      TimedMessageBox('  Невозможно загрузить этот рисунок' + #10+#13 + 'Возможно, его структура не соответствует расширению!' + #10+#13 + 'Попробуйте выбрать другой рисунок!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    end;
    sBsave.Enabled := CheckDataChange;
  end;
end;

procedure TSettingProgForm.sCheckBox1Click(Sender: TObject);
begin
  inherited;
  old_AskExcelFileName := sCheckBox1.Checked;
  sBsave.Enabled := CheckDataChange;
end;

procedure TSettingProgForm.sCheckBox2Click(Sender: TObject);
begin
  inherited;
  old_UsePictForFon := sCheckBox2.Checked;
  sButton1.Enabled := sCheckBox2.Checked;
  sBsave.Enabled := CheckDataChange;
end;

procedure TSettingProgForm.sCheckBox3Click(Sender: TObject);
begin
  inherited;
  old_ChangeKeyboardLayout := sCheckBox3.Checked;
  sBsave.Enabled := CheckDataChange;

end;

procedure TSettingProgForm.sCheckBox4Click(Sender: TObject);
begin
  inherited;
  old_ShowInfoCreator := sCheckBox4.Checked;
  sBsave.Enabled := CheckDataChange;
end;

procedure TSettingProgForm.sCheckBox5Click(Sender: TObject);
begin
  inherited;
  old_ShowInfoChanger := sCheckBox5.Checked;
  sBsave.Enabled := CheckDataChange;
end;

procedure TSettingProgForm.sEdit1Change(Sender: TObject);
begin
  inherited;
   old_MoveNext := sUpDown1.Position;
  sBsave.Enabled := CheckDataChange;

end;

procedure TSettingProgForm.sUpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  inherited;
   old_MoveNext := sUpDown1.Position;
  sBsave.Enabled := CheckDataChange;
end;

end.
