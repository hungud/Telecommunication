unit FilterFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, sLabel, ComCtrls, ToolWin, sToolBar, MainUnit, DBCtrls, DB,
  MemDS, DBAccess, Ora, sEdit, Mask, sMaskEdit, sCustomComboEdit, sTooledit,
  DBGridEh, DBCtrlsEh, DBLookupEh;

type
  TFilterFrame = class(TFrame)
    sLabelFX2: TsLabelFX;
    sToolBar1: TsToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    sLabel1: TsLabel;
    qAgent: TOraQuery;
    dsAgent: TDataSource;
    qAgentID: TFloatField;
    qAgentNAME: TStringField;
    sLabel2: TsLabel;
    qSubagent: TOraQuery;
    dsSubagent: TDataSource;
    qSubagentID: TFloatField;
    qSubagentNAME: TStringField;
    sLabel3: TsLabel;
    dsOperator: TDataSource;
    qOperator: TOraQuery;
    sLabel4: TsLabel;
    sEdit1: TsEdit;
    sLabel5: TsLabel;
    sDateEdit1: TsDateEdit;
    sLabel6: TsLabel;
    qStatus: TOraQuery;
    dsStatus: TDataSource;
    sLabel7: TsLabel;
    sDateEdit2: TsDateEdit;
    sLabel8: TsLabel;
    sEdit2: TsEdit;
    sLabel9: TsLabel;
    dsTariff: TDataSource;
    qTariff: TOraQuery;
    sLabel10: TsLabel;
    sEdit3: TsEdit;
    sLabel11: TsLabel;
    sEdit4: TsEdit;
    sLabel12: TsLabel;
    sLabel13: TsLabel;
    sDateEdit3: TsDateEdit;
    qOperatorID: TFloatField;
    qOperatorNAME: TStringField;
    qStatusID: TFloatField;
    qStatusNAME: TStringField;
    qTariffID: TFloatField;
    qTariffNAME: TStringField;
    sLabel14: TsLabel;
    sDateEdit4: TsDateEdit;
    sDateEdit5: TsDateEdit;
    sLabel15: TsLabel;
    sLabel16: TsLabel;
    sLabel17: TsLabel;
    sLabel18: TsLabel;
    sLabel19: TsLabel;
    sDateEdit6: TsDateEdit;
    sDateEdit7: TsDateEdit;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    DBLookupComboboxEh3: TDBLookupComboboxEh;
    DBLookupComboboxEh4: TDBLookupComboboxEh;
    DBLookupComboboxEh5: TDBLookupComboboxEh;
    sLabel20: TsLabel;
    sLabel21: TsLabel;
    DBLookupComboboxEh6: TDBLookupComboboxEh;
    DBLookupComboboxEh7: TDBLookupComboboxEh;
    qOptsEnabled: TOraQuery;
    dsOptsEnabled: TDataSource;
    qOptsEnabledID: TFloatField;
    qOptsEnabledNAME: TStringField;
    qOptsDisabled: TOraQuery;
    dsOptsDisabled: TDataSource;
    qOptsDisabledID: TFloatField;
    qOptsDisabledNAME: TStringField;
    sEdit6: TsEdit;
    sEdit5: TsEdit;
    sLabel22: TsLabel;
    sLabel23: TsLabel;
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FilteringDS: TDataSet;
  public
    { Public declarations }
    procedure Init(fDS: TDataSet);
    procedure RefreshFilter;
  end;

implementation

{$R *.dfm}

{ TFilterFrame }

procedure TFilterFrame.DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Return then ToolButton1.Click;
end;

procedure TFilterFrame.Init(fDS: TDataSet);
begin
  FilteringDS := fDS;
  qAgent.Open;
  DBLookupComboBoxEh1.KeyValue := -1;
  qSubagent.Open;
  DBLookupComboBoxEh2.KeyValue := -1;
  qOperator.Open;
  DBLookupComboBoxEh3.KeyValue := -1;
  qStatus.Open;
  DBLookupComboBoxEh4.KeyValue := -1;
  qTariff.Open;
  DBLookupComboBoxEh5.KeyValue := -1;
  qOptsDisabled.Open;
  DBLookupComboBoxEh7.KeyValue := -1;
  qOptsEnabled.Open;
  DBLookupComboBoxEh6.KeyValue := -1;
end;

procedure TFilterFrame.RefreshFilter;
begin
  qAgent.Close;
  qAgent.Open;
  DBLookupComboBoxEh1.KeyValue := qAgentID.AsInteger;
  qSubagent.Close;
  qSubagent.Open;
  DBLookupComboBoxEh2.KeyValue := qSubagentID.AsInteger;
  qOperator.Close;
  qOperator.Open;
  DBLookupComboBoxEh3.KeyValue := qOperatorID.AsInteger;
  qStatus.Close;
  qStatus.Open;
  DBLookupComboBoxEh4.KeyValue := qStatusID.AsInteger;
  qTariff.Close;
  qTariff.Open;
  DBLookupComboBoxEh5.KeyValue := qTariffID.AsInteger;
  qOptsEnabled.Close;
  qOptsEnabled.Open;
  DBLookupComboBoxEh6.KeyValue := qOptsEnabledID.AsInteger;
  qOptsDisabled.Close;
  qOptsDisabled.Open;
  DBLookupComboBoxEh7.KeyValue := qOptsDisabledID.AsInteger;
end;

procedure TFilterFrame.ToolButton1Click(Sender: TObject);
var
  fStr: String;
  BalanceMin, BalanceMax:Double;
begin
  fStr:= '1=1';
  if DBLookupComboBoxEh1.KeyValue <> -1 then
    fStr := fStr+ ' and agent_name = ''' + DBLookupComboBoxEh1.Text+'''';
  if DBLookupComboBoxEh2.KeyValue <> -1 then
    fStr := fStr+ ' and subagent_name = ''' + DBLookupComboBoxEh2.Text+'''';
  if DBLookupComboBoxEh3.KeyValue <> -1 then
    fStr := fStr+ ' and operator_name = ''' + DBLookupComboBoxEh3.Text+'''';
  if sEdit1.Text <> '' then
    fStr := fStr+ ' and cell_number like ''%' + sEdit1.Text+'%''';
  if sDateEdit1.Text <> '  .  .    ' then
    fStr := fStr+ ' and date_init = ''' + sDateEdit1.Text+'''';
  if DBLookupComboBoxEh4.KeyValue <> -1 then
    fStr := fStr+ ' and phone_is_active = ''' + DBLookupComboBoxEh4.Text+'''';
  if (sDateEdit2.Text <> '  .  .    '){and(sDateEdit3.Text = '  .  .    ')} then
    fStr := fStr+ ' and date_move >= ''' + sDateEdit2.Text+'''';
  if {(sDateEdit2.Text = '  .  .    ')and}(sDateEdit3.Text <> '  .  .    ') then
    fStr := fStr+ ' and date_move <= ''' + sDateEdit3.Text+'''';
//  if (sDateEdit2.Text <> '  .  .    ')and(sDateEdit3.Text <> '  .  .    ') then
//    fStr := fStr+ ' and date_move between '''+sDateEdit2.Text+''' and ''' + sDateEdit3.Text+'''';
  if sEdit2.Text <> '' then
    fStr := fStr+ ' and account like ''%' + sEdit2.Text+'%''';
  if DBLookupComboBoxEh5.KeyValue <> -1 then
    fStr := fStr+ ' and tariff_name = ''' + DBLookupComboBoxEh5.Text+'''';
  if sEdit3.Text <> '' then
    fStr := fStr+ ' and sim_number like ''%' + sEdit3.Text+'%''';
  if sEdit4.Text <> '' then
    fStr := fStr+ ' and abonent_name like ''%' + AnsiUpperCase(sEdit4.Text)+'%''';
  if (sDateEdit4.Text <> '  .  .    ') then
    fStr := fStr+ ' and date_activate >= ''' + sDateEdit4.Text+'''';
  if (sDateEdit5.Text <> '  .  .    ') then
    fStr := fStr+ ' and date_activate <= ''' + sDateEdit5.Text+'''';
  if (sDateEdit6.Text <> '  .  .    ') then
    fStr := fStr+ ' and DATE_LAST_ACTIVITY >= ''' + sDateEdit6.Text+'''';
  if (sDateEdit7.Text <> '  .  .    ') then
    fStr := fStr+ ' and DATE_LAST_ACTIVITY <= ''' + sDateEdit7.Text+'''';
  if DBLookupComboBoxEh6.KeyValue <> -1 then
    fStr := fStr+ ' and opts like ''%,' + VarToStr(DBLookupComboBoxEh6.KeyValue) +',%''';
  if DBLookupComboBoxEh7.KeyValue <> -1 then
    fStr := fStr+ ' and not (opts like ''%,' + VarToStr(DBLookupComboBoxEh7.KeyValue) +',%'')';
  if length(sEdit5.Text)>0 then
    begin
      try
        BalanceMin:=StrToFloat(sEdit5.Text);
        fStr:=fStr+('and balance>='+FloatToStr(BalanceMin));
      except
        Application.MessageBox(PChar('Посторонние символы в поле Мин Баланс'),
            'Предупреждение', MB_OK+MB_ICONWARNING);
      end;
    end;
    if length(sEdit6.Text)>0 then
    begin
      try
        BalanceMax:=StrToFloat(sEdit6.Text);
        fStr:=fStr+('and balance<='+FloatToStr(BalanceMax));
      except
        Application.MessageBox(PChar('Посторонние символы в поле Макс Баланс'),
            'Предупреждение', MB_OK+MB_ICONWARNING)
      end;
    end;
  FilteringDS.Filter := fStr;
  FilteringDS.Filtered := true;
end;

procedure TFilterFrame.ToolButton2Click(Sender: TObject);
begin
  DBLookupComboBoxEh1.KeyValue := -1;
  DBLookupComboBoxEh2.KeyValue := -1;
  DBLookupComboBoxEh3.KeyValue := -1;
  DBLookupComboBoxEh4.KeyValue := -1;
  DBLookupComboBoxEh5.KeyValue := -1;
  DBLookupComboBoxEh6.KeyValue := -1;
  DBLookupComboBoxEh7.KeyValue := -1;
  FilteringDS.Filtered := false;
end;

end.
