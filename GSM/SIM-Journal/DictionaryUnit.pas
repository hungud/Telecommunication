unit DictionaryUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainUnit, ComCtrls, ToolWin, sToolBar, DBGridEhGrouping, GridsEh,
  DBGridEh, DB, MemDS, DBAccess, Ora;

type
  TDictionaryMode =(dmUndefined, dmAgent, dmSubagent, dmOperator, dmTarif, dmService);

type
  TDictionaryForm = class(TForm)
    sToolBar1: TsToolBar;
    tbPrihod: TToolButton;
    ToolButton2: TToolButton;
    ToolButton6: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    grMain: TDBGridEh;
    qAgent: TOraQuery;
    dsCommon: TDataSource;
    qSubagent: TOraQuery;
    qOperator: TOraQuery;
    qOperatorOPERATOR_ID: TFloatField;
    qOperatorOPERATOR_NAME: TStringField;
    qTariff: TOraQuery;
    qTariffTARIFF_ID: TFloatField;
    qTariffTARIFF_NAME: TStringField;
    qTariffACTIV: TStringField;
    qTariffOPERATOR_NAME: TStringField;
    qTariffSTART_BALANCE: TFloatField;
    qTariffCONNECT_PRICE: TFloatField;
    qTariffPHONE_TYPE: TStringField;
    qTariffDAYLY_PAYMENT: TFloatField;
    qTariffMONTHLY_PAYMENT: TFloatField;
    qService: TOraQuery;
    qAgentAGENT_NAME: TStringField;
    qSubagentSUB_AGENT_NAME: TStringField;
    qServiceOPTION_ID: TFloatField;
    qServiceOPTION_NAME: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbPrihodClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
  private
    { Private declarations }
    fMode: TDictionaryMode;

    procedure InitColumns;

    procedure AgentMode;
    procedure SubagentMode;
    procedure OperatorMode;
    procedure TarifMode;
    procedure ServiceMode;
    procedure UndefinedMode;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AMode: TDictionaryMode); reintroduce;
  end;


implementation

{$R *.dfm}

{ TDictionaryForm }

procedure TDictionaryForm.AgentMode;
begin
  Caption := 'Справочник агентов';
  dsCommon.DataSet := qAgent;

  InitColumns;

  qAgent.Open;
end;

constructor TDictionaryForm.Create(AOwner: TComponent; AMode: TDictionaryMode);
begin
  inherited Create(AOwner);
  fMode := AMode;
  case fMode of
    dmAgent: AgentMode; //Агент
    dmSubagent: SubagentMode; //Субагент
    dmOperator: OperatorMode; //Оператор
    dmTarif: TarifMode; //Тариф
    dmService: ServiceMode; //Услуги Мегафона
    dmUndefined: UndefinedMode;
  end;
end;

procedure TDictionaryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(dsCommon.DataSet) then
    dsCommon.DataSet.Close;
  Action := caFree;
end;

procedure TDictionaryForm.InitColumns;
var
  col: TColumnEh;
  i: integer;
begin
  for i:= 0 to dsCommon.DataSet.FieldCount-1 do
  begin
    col := grMain.Columns.Add;
    col.FieldName := dsCommon.DataSet.Fields[i].FieldName;
    col.Visible := dsCommon.DataSet.Fields[i].Visible;
    col.Width := dsCommon.DataSet.Fields[i].DisplayWidth;
  end;
end;

procedure TDictionaryForm.OperatorMode;
begin
  tbPrihod.Free;
  ToolButton6.Free;
  ToolButton2.Free;
  Caption := 'Справочник операторов(только чтение)';
  dsCommon.DataSet := qOperator;

  InitColumns;
  grMain.Options := grMain.Options - [dgEditing];

  qOperator.Open;
end;

procedure TDictionaryForm.SubagentMode;
begin
  Caption := 'Справочник субагентов';
  dsCommon.DataSet := qSubagent;

  InitColumns;

  qSubagent.Open;
end;

procedure TDictionaryForm.ServiceMode;
begin
  Caption := 'Справочник услуг Мегафона';
  dsCommon.DataSet := qService;

  InitColumns;

  grMain.Columns.Items[0].Width:=50;
  qService.Open;
end;

procedure TDictionaryForm.TarifMode;
begin
  tbPrihod.Free;
  ToolButton6.Free;
  ToolButton2.Free;
  Caption := 'Справочник тарифов(только чтение)';
  dsCommon.DataSet := qTariff;

  InitColumns;
  grMain.Options := grMain.Options - [dgEditing];

  qTariff.Open;
end;

procedure TDictionaryForm.tbPrihodClick(Sender: TObject);
begin
  dsCommon.DataSet.Insert;
end;

procedure TDictionaryForm.ToolButton1Click(Sender: TObject);
begin
  dsCommon.DataSet.DisableControls;
  dsCommon.DataSet.Close;
  dsCommon.DataSet.Open;
  dsCommon.DataSet.EnableControls;
end;

procedure TDictionaryForm.ToolButton2Click(Sender: TObject);
begin
  if (not dsCommon.DataSet.IsEmpty) and (Application.MessageBox('Удалить запись?', 'Подтверждение', MB_YESNO+MB_ICONQUESTION)=idYes) then
    try
      dsCommon.DataSet.Delete;
    except
      on e: exception do Application.MessageBox(PChar('При попытке удаления записи произошла ошибка:'+#13#10+e.Message), 'Ошибка', MB_OK+MB_ICONERROR);
    end;
end;

procedure TDictionaryForm.ToolButton5Click(Sender: TObject);
begin
  Close;
end;

procedure TDictionaryForm.UndefinedMode;
begin
  Application.MessageBox('Не определен тип справочника!', 'Ошибка', MB_OK+MB_ICONERROR);
  tbPrihod.Enabled := false;
  ToolButton2.Enabled := false;
  ToolButton1.Enabled := false;
end;

end.
