unit RefAutoBlockPhoneNoContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, CRGrid, MemDS, DBAccess, Ora, StdCtrls, Buttons,
  ExtCtrls, ComObj;

type
  TRefAutoBlockPhoneNoContractForm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    cbNigthWork: TCheckBox;
    eBeginHour: TEdit;
    eEndHour: TEdit;
    memoURL: TMemo;
    btAdd: TBitBtn;
    btClear: TBitBtn;
    qBlockNoContractSettings: TOraQuery;
    btSave: TBitBtn;
    CRDBGrid1: TCRDBGrid;
    qPhoneNoAccess: TOraQuery;
    dsPhoneNoAccess: TDataSource;
    qPhoneNoAccessPHONE_NUMBER: TStringField;
    qDeleteList: TOraQuery;
    OpenDialog1: TOpenDialog;
    btRefresh: TBitBtn;
    btChange: TBitBtn;
    qBlockNoContractSettingsCHECK_TIME: TFloatField;
    qBlockNoContractSettingsTIME_END: TFloatField;
    qBlockNoContractSettingsTIME_BEGIN: TFloatField;
    qBlockNoContractSettingsURL_ACCESS_LIST: TStringField;
    qBlockNoContractSettingsPHONE_FOR_NOTICE: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    ePhoneForNotice: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    memoURLBody: TMemo;
    Panel2: TPanel;
    qAutoListNoAccess: TOraQuery;
    Panel3: TPanel;
    Panel4: TPanel;
    qAutoListNoAccessLIST_NO_BLOCK: TMemoField;
    btDel: TBitBtn;
    procedure cbNigthWorkClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btChangeClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoAutoBlockPhoneNoContract;

var
  RefAutoBlockPhoneNoContractForm: TRefAutoBlockPhoneNoContractForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure DoAutoBlockPhoneNoContract;
var ReportFrm: TRefAutoBlockPhoneNoContractForm;
begin
  ReportFrm:=TRefAutoBlockPhoneNoContractForm.Create(Nil);
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TRefAutoBlockPhoneNoContractForm.btAddClick(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
  datecheck: string;
begin
  if OpenDialog1.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(OpenDialog1.FileName);
    i := 1;
    while (VarToStr(Excel.Cells[i, 1]) <> '')
            and(Length(VarToStr(Excel.Cells[i, 1])) = 10) do
    begin
      qPhoneNoAccess.Append;
      qPhoneNoAccessPHONE_NUMBER.AsString:=Excel.Cells[i, 1];
      qPhoneNoAccess.Post;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  qPhoneNoAccess.Close;
  qPhoneNoAccess.Open;
end;

procedure TRefAutoBlockPhoneNoContractForm.btChangeClick(Sender: TObject);
begin
  cbNigthWork.Enabled:=true;
  if cbNigthWork.Checked then
  begin
    eBeginHour.Enabled:=true;
    eEndHour.Enabled:=true;
  end else
  begin
    eBeginHour.Enabled:=false;
    eEndHour.Enabled:=false;
  end;
  ePhoneForNotice.Enabled:=true;
  memoURL.Enabled:=true;
  btChange.Enabled:=false;
  btSave.Enabled:=true;
end;

procedure TRefAutoBlockPhoneNoContractForm.btClearClick(Sender: TObject);
var vRes : Integer;
begin
  vRes := MessageDlg('Очистить список?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if mrYes = vRes then
  begin
    qDeleteList.ParamByName('ALL_PHONE').AsInteger:=1;
    qDeleteList.ExecSQL;
  end;
  qPhoneNoAccess.Close;
  qPhoneNoAccess.Open;
end;

procedure TRefAutoBlockPhoneNoContractForm.btDelClick(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
  datecheck: string;
begin
  if OpenDialog1.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(OpenDialog1.FileName);
    i := 1;
    qDeleteList.ParamByName('ALL_PHONE').AsInteger:=0;
    while (VarToStr(Excel.Cells[i, 1]) <> '')
            and(Length(VarToStr(Excel.Cells[i, 1])) = 10) do
    begin
      qDeleteList.ParamByName('PHONE').AsString:=Excel.Cells[i, 1];
      qDeleteList.ExecSQL;
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
  end;
  qPhoneNoAccess.Close;
  qPhoneNoAccess.Open;
end;

procedure TRefAutoBlockPhoneNoContractForm.btRefreshClick(Sender: TObject);
begin
  qPhoneNoAccess.Close;
  qPhoneNoAccess.Open;
  qAutoListNoAccess.Open;
  memoURLBody.Lines.Clear;
  memoURLBody.Lines.Append(qAutoListNoAccessLIST_NO_BLOCK.AsString);
  qAutoListNoAccess.Close;
end;

procedure TRefAutoBlockPhoneNoContractForm.btSaveClick(Sender: TObject);
var i, vRes:integer;
    s:string;
begin
  vRes := MessageDlg('Сохранить настройки?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if mrYes = vRes then
    try
      qBlockNoContractSettings.Open;
      qBlockNoContractSettings.Edit;
      qBlockNoContractSettingsTIME_BEGIN.AsFloat:=StrToFloat(eBeginHour.Text);
      qBlockNoContractSettingsTIME_END.AsFloat:=StrToFloat(eEndHour.Text);
      if cbNigthWork.Checked then
        qBlockNoContractSettingsCHECK_TIME.AsInteger:=1
      else
        qBlockNoContractSettingsCHECK_TIME.AsInteger:=0;
      qBlockNoContractSettingsPHONE_FOR_NOTICE.AsString:=ePhoneForNotice.Text;
      s:='';
      for i:=0 to memoURL.Lines.Count-1 do
        s:=s+memoURL.Lines[i];
      qBlockNoContractSettingsURL_ACCESS_LIST.AsString:=s;
      qBlockNoContractSettings.Post;
      qBlockNoContractSettings.Close;
      eBeginHour.Enabled:=false;
      eEndHour.Enabled:=false;
      ePhoneForNotice.Enabled:=false;
      memoURL.Enabled:=false;
      cbNigthWork.Enabled:=false;
      btSave.Enabled:=false;
      btChange.Enabled:=true;
    except
      Application.MessageBox(PChar('Введите корректные данные'), 'Уведомление',
        MB_OK + MB_ICONINFORMATION);
    end;
end;

procedure TRefAutoBlockPhoneNoContractForm.cbNigthWorkClick(Sender: TObject);
begin
  if cbNigthWork.Checked then
  begin
    eBeginHour.Enabled:=true;
    eEndHour.Enabled:=true;
  end else
  begin
    eBeginHour.Enabled:=false;
    eEndHour.Enabled:=false;
  end;
end;

procedure TRefAutoBlockPhoneNoContractForm.FormShow(Sender: TObject);
var t: string;
begin
  qPhoneNoAccess.Open;
  qBlockNoContractSettings.Open;
  eBeginHour.Text:=FloatToStr(qBlockNoContractSettingsTIME_BEGIN.AsFloat);
  eEndHour.Text:=FloatToStr(qBlockNoContractSettingsTIME_END.AsFloat);
  if qBlockNoContractSettingsCHECK_TIME.AsInteger = 1 then
    cbNigthWork.Checked:=true
  else
    cbNigthWork.Checked:=false;
  ePhoneForNotice.Text:=qBlockNoContractSettingsPHONE_FOR_NOTICE.AsString;
  memoURL.Lines.Clear;
  memoURL.Lines.Append(qBlockNoContractSettingsURL_ACCESS_LIST.AsString);
  qBlockNoContractSettings.Close;
  eBeginHour.Enabled:=false;
  eEndHour.Enabled:=false;
  ePhoneForNotice.Enabled:=false;
  memoURL.Enabled:=false;
  cbNigthWork.Enabled:=false;
  btSave.Enabled:=false;
  qAutoListNoAccess.Open;
  memoURLBody.Lines.Clear;
  memoURLBody.Lines.Append(qAutoListNoAccessLIST_NO_BLOCK.AsString);
  qAutoListNoAccess.Close;
  if (GetConstantValue('SERVER_NAME') = 'SIM_TRADE') then
  begin
    GroupBox1.Hide;
    GroupBox2.Top:=8;
    Panel3.Hide;
  end;
end;

end.
