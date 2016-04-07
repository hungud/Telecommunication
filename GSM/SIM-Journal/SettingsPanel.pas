unit SettingsPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, sPanel, DB, DBAccess, Ora, MemDS, StdCtrls, sLabel, Mask,
  DBCtrlsEh, Buttons, sBitBtn, sEdit;

type
  TSettingsPanelForm = class(TForm)
    sPanel1: TsPanel;
    GroupBox1: TGroupBox;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBEditEh3: TDBEditEh;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    GroupBox2: TGroupBox;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    DBEditEh4: TDBEditEh;
    DBEditEh5: TDBEditEh;
    GroupBox3: TGroupBox;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    DBEditEh6: TDBEditEh;
    DBEditEh7: TDBEditEh;
    qSettings: TOraQuery;
    qSettingsMASTER_PASSWORD: TStringField;
    dsSettings: TOraDataSource;
    qSettingsSETTINGS_ID: TFloatField;
    qSettingsLOADER_DB_CONNECTION: TStringField;
    qSettingsLOADER_DB_USER_NAME: TStringField;
    qSettingsLOADER_DB_PASSWORD: TStringField;
    qSettingsCORP_PORTAL_LOGIN: TStringField;
    qSettingsCORP_PORTAL_PASSWORD: TStringField;
    qSettingsSERVICE_GID_PASSWORD: TStringField;
    qSettingsLOADER_NAME: TStringField;
    qSettingsSETTINGS_NAME: TStringField;
    GroupBox4: TGroupBox;
    sLabel8: TsLabel;
    sLabel9: TsLabel;
    sLabel10: TsLabel;
    sEdit2: TsEdit;
    sEdit1: TsEdit;
    sEdit3: TsEdit;
    sLabel11: TsLabel;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qSettingsAfterOpen(DataSet: TDataSet);
    procedure sEdit2Change(Sender: TObject);
    procedure sEdit3Change(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn3Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
  private
    MasterPassword:string;
  public
    { Public declarations }
  end;

var
  SettingsPanelForm: TSettingsPanelForm;

implementation

{$R *.dfm}

procedure TSettingsPanelForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qSettings.Close;
end;

procedure TSettingsPanelForm.FormShow(Sender: TObject);
begin
  qSettings.Open;
end;

procedure TSettingsPanelForm.qSettingsAfterOpen(DataSet: TDataSet);
begin
  MasterPassword:=qSettingsMASTER_PASSWORD.AsString;
end;

procedure TSettingsPanelForm.sBitBtn1Click(Sender: TObject);
begin
  if sEdit1.Text=MasterPassword then
    if sEdit2.Text=sEdit3.Text then
    begin
      qSettingsMASTER_PASSWORD.AsString:=sEdit2.Text;
      qSettings.Post;
      qSettings.Close;
      Close;
    end else
      Application.MessageBox(PChar('Пароль и подтверждение не совпадают.'),
        'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Пароль неверен.'), 'Предупреждение',
      MB_OK + MB_ICONWARNING);
end;

procedure TSettingsPanelForm.sBitBtn2Click(Sender: TObject);
begin
  qSettings.Close;
  Close;
end;

procedure TSettingsPanelForm.sBitBtn3Click(Sender: TObject);
begin
  if sEdit1.Text=MasterPassword then
    if sEdit2.Text=sEdit3.Text then
    begin
      if Length(sEdit2.Text)>0 then
      begin
        if qSettings.State=dsBrowse then
          qSettings.Edit;
        qSettingsMASTER_PASSWORD.AsString:=sEdit2.Text;
      end;
      if qSettings.State=dsEdit then
        qSettings.Post;
      qSettings.Close;
      qSettings.Open;
      sEdit1.Text:='';
      sEdit2.Text:='';
      sEdit2.Color:=clWhite;
      sEdit3.Text:='';
      sEdit3.Color:=clWhite;
    end else
      Application.MessageBox(PChar('Пароль и подтверждение не совпадают.'),
        'Предупреждение', MB_OK + MB_ICONWARNING)
  else
    Application.MessageBox(PChar('Пароль неверен.'), 'Предупреждение',
      MB_OK + MB_ICONWARNING);
end;

procedure TSettingsPanelForm.sEdit2Change(Sender: TObject);
begin
  if Length(sEdit2.Text)>=7 then
    sEdit2.Color:=clGreen
  else
    sEdit2.Color:=clRed;
end;

procedure TSettingsPanelForm.sEdit3Change(Sender: TObject);
begin
  if sEdit2.Text=sEdit3.Text then
    sEdit3.Color:=clGreen
  else
    sEdit3.Color:=clRed;
end;

end.
