unit AddPeriod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.StdCtrls, sLabel,
  Vcl.ComCtrls, sUpDown, sCheckBox, sEdit, sComboBox, Vcl.Buttons, sBitBtn,
  Vcl.ExtCtrls, uDm, sPanel;

type
  TAddPeriodForm = class(TChildForm)
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    sComboBox1: TsComboBox;
    sEdit1: TsEdit;
    sCheckBox1: TsCheckBox;
    sUpDown1: TsUpDown;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure CheckData;
    procedure sComboBox1Change(Sender: TObject);
    procedure sUpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure sEdit1Change(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);

  private
   Init : Boolean;
    { Private declarations }
  public
   ye, mnth : string;
   p_active : Integer;
    { Public declarations }
  end;

var
  AddPeriodForm: TAddPeriodForm;

implementation

{$R *.dfm}


procedure TAddPeriodForm.FormCreate(Sender: TObject);
begin
  inherited;
  dm.LastPeriod.Close;
  dm.LastPeriod.Open;
  if (dm.LastPeriod.FieldByName('MONTHS').AsInteger = 12) then
  begin
    sUpDown1.Position := dm.LastPeriod.FieldByName('YEARS').AsInteger + 1;
    sComboBox1.ItemIndex := 0;
  end else begin
    sUpDown1.Position := dm.LastPeriod.FieldByName('YEARS').AsInteger;
    sComboBox1.ItemIndex := dm.LastPeriod.FieldByName('MONTHS').AsInteger;
  end;
  dm.LastPeriod.Close;
  if not dm.qPeriods.Active then
    dm.qPeriods.Open;
  ye := sEdit1.Text;
  if sComboBox1.ItemIndex > 8 then
    mnth := IntToStr(sComboBox1.ItemIndex+1)
  else
    mnth := '0'+IntToStr(sComboBox1.ItemIndex+1);
  if sCheckBox1.Checked then
    p_active := 1
  else
    p_active := 0;
  Init := True;
end;

procedure TAddPeriodForm.sCheckBox1Click(Sender: TObject);
begin
  inherited;
  CheckData;
end;

procedure TAddPeriodForm.sComboBox1Change(Sender: TObject);
begin
  inherited;
  CheckData;
end;

procedure TAddPeriodForm.sEdit1Change(Sender: TObject);
begin
  inherited;
  CheckData;
end;

procedure TAddPeriodForm.sUpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  inherited;
  CheckData;
end;

procedure TAddPeriodForm.CheckData;
var
res : Variant;
begin
  if Init then
  begin
    res := dm.qPeriods.Lookup('YEARS; MONTHS', VarArrayOf([ sUpDown1.Position, sComboBox1.ItemIndex+1]), 'YEAR_MONTH');
    if Res <> Null then
      sBsave.Enabled := false
    else
      sBsave.Enabled := True;
    ye := sEdit1.Text;
    if sComboBox1.ItemIndex > 8 then
      mnth := IntToStr(sComboBox1.ItemIndex+1)
    else
      mnth := '0'+IntToStr(sComboBox1.ItemIndex+1);
    if sCheckBox1.Checked then
      p_active := 1
    else
      p_active := 0;
  end;
end;

end.
