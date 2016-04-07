unit OperationFrameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, sLabel, DBCtrls, DB, MemDS, DBAccess, Ora, Buttons, sBitBtn,
  sEdit, DBGridEh, Mask, DBCtrlsEh, DBLookupEh;

type
  TOperationFilterFrame = class(TFrame)
    sLabel1: TsLabel;
    qSubAgents: TOraQuery;
    dsSubAgents: TDataSource;
    qAgents: TOraQuery;
    sLabel2: TsLabel;
    qTariff: TOraQuery;
    sLabel3: TsLabel;
    dsAgents: TDataSource;
    dsTariff: TDataSource;
    qGenerator: TOraQuery;
    sBitBtn1: TsBitBtn;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    eBalanceMin: TsEdit;
    eBalanceMax: TsEdit;
    sLabel6: TsLabel;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    DBLookupComboboxEh3: TDBLookupComboboxEh;
    procedure sBitBtn1Click(Sender: TObject);
  private
    FilterDS:TDataSet;
  public
    procedure Init(DS:TDataSet);
  end;

implementation

{$R *.dfm}

procedure TOperationFilterFrame.Init(DS:TDataSet);
begin
  qSubAgents.Open;
  DBLookupComboBoxEh1.KeyValue := -1;
  qAgents.Open;
  DBLookupComboBoxEh2.KeyValue := -1;
  qTariff.Open;
  DBLookupComboBoxEh3.KeyValue := -1;
  FilterDS:=DS;
end;

procedure TOperationFilterFrame.sBitBtn1Click(Sender: TObject);
var BalanceMin, BalanceMax:double;
begin
  try
    qGenerator.SQL.Clear;
    qGenerator.SQL.Append('select cell_number from sim where status_id<>6');
    if DBLookupComboBoxEh1.KeyValue<>-1 then
      qGenerator.SQL.Append('and agent_id='+IntToStr(DBLookupComboBoxEh1.KeyValue));
    if DBLookupComboBoxEh2.KeyValue<>-1 then
      qGenerator.SQL.Append('and subagent_id='+IntToStr(DBLookupComboBoxEh2.KeyValue));
    if DBLookupComboBoxEh3.KeyValue<>-1 then
      qGenerator.SQL.Append('and tariff_id='+IntToStr(DBLookupComboBoxEh3.KeyValue));
    if length(eBalanceMin.Text)>0 then
    begin
      try
        BalanceMin:=StrToFloat(eBalanceMin.Text);
        qGenerator.SQL.Append('and balance>='+FloatToStr(BalanceMin));
      except
        Application.MessageBox(PChar('Посторонние символы в поле Мин Баланс'), 'Предупреждение', MB_OK+MB_ICONWARNING);
      end;
    end;
    if length(eBalanceMax.Text)>0 then
    begin
      try
        BalanceMax:=StrToFloat(eBalanceMax.Text);
        qGenerator.SQL.Append('and balance<='+FloatToStr(BalanceMax));
      except
        Application.MessageBox(PChar('Посторонние символы в поле Макс Баланс'), 'Предупреждение', MB_OK+MB_ICONWARNING)
      end;
    end;
    qGenerator.Prepare;
    qGenerator.Open;
    qGenerator.Last;
    while not qGenerator.Bof do
    begin
      FilterDS.Insert;
      FilterDS.FieldByName('cellnum').AsString:=qGenerator.FieldByName('cell_number').AsString;
      FilterDS.Post;
      qGenerator.Prior;
    end;
    qGenerator.Close;
  except
    Application.MessageBox(PChar('Исправьте данные для генерации'), 'Предупреждение', MB_OK+MB_ICONWARNING)
  end;
end;

end.
