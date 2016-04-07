unit RefTariffOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons;

type
  TRefTariffOptionsForm = class(TTemplateForm)
    qOperators: TOraQuery;
    qMainOPERATOR_NAME: TStringField;
    qMainTARIFF_OPTION_ID: TFloatField;
    qMainOPERATOR_ID: TFloatField;
    qMainOPTION_CODE: TStringField;
    qMainOPTION_NAME: TStringField;
    pcOptionsCost: TPageControl;
    Splitter1: TSplitter;
    tOptionCost: TTabSheet;
    gTariffOptionCosts: TCRDBGrid;
    dsTariffOptionCosts: TDataSource;
    qTariffOptionCosts: TOraQuery;
    qTariffs: TOraQuery;
    qGetNewTariffOptionCostId: TOraStoredProc;
    gTariffOptionCostNew: TCRDBGrid;
    Splitter2: TSplitter;
    qTariffOptionNewCost: TOraQuery;
    dsTariffOptionCostNew: TDataSource;
    qTariffOptionNewCostTARIFF_OPTION_NEW_COST_ID: TFloatField;
    qTariffOptionNewCostTARIFF_OPTION_COST_ID: TFloatField;
    qTariffOptionNewCostTURN_ON_COST: TFloatField;
    qTariffOptionNewCostMONTHLY_COST: TFloatField;
    qTariffOptionNewCostUSER_CREATED: TStringField;
    qTariffOptionNewCostDATE_CREATED: TDateTimeField;
    qTariffOptionNewCostUSER_LAST_UPDATED: TStringField;
    qTariffOptionNewCostDATE_LAST_UPDATED: TDateTimeField;
    qTariffOptionCostsTARIFF_OPTION_COST_ID: TFloatField;
    qTariffOptionCostsTARIFF_OPTION_ID: TFloatField;
    qTariffOptionCostsBEGIN_DATE: TDateTimeField;
    qTariffOptionCostsEND_DATE: TDateTimeField;
    qTariffOptionCostsTURN_ON_COST: TFloatField;
    qTariffOptionCostsMONTHLY_COST: TFloatField;
    qTariffOptionCostsUSER_CREATED: TStringField;
    qTariffOptionCostsDATE_CREATED: TDateTimeField;
    qTariffOptionCostsUSER_LAST_UPDATED: TStringField;
    qTariffOptionCostsDATE_LAST_UPDATED: TDateTimeField;
    qTariffOptionCostsOPERATOR_TURN_ON_COST: TFloatField;
    qTariffOptionCostsOPERATOR_MONTHLY_COST: TFloatField;
    qTariffOptionCostsUSER_NAME: TStringField;
    qGetNewTariffOptionNewCostID: TOraStoredProc;
    qTariffOptionNewCostTARIFF_NAME: TStringField;
    qMainKOEF_KOMISS: TFloatField;
    CRDBGrid2: TCRDBGrid;
    qTariffOptNo: TOraQuery;
    dsTariffOptNo: TDataSource;
    qTariffOptionNewCostTURN_ON_COST_FOR_BILLS: TFloatField;
    qTariffOptionNewCostMONTHLY_COST_FOR_BILLS: TFloatField;
    qMainDISCR_SPISANIE: TIntegerField;
    Panel3: TPanel;
    btFindOptions: TBitBtn;
    Panel4: TPanel;
    qTariffOptNoOPTION_CODE: TStringField;
    qTariffOptNoOPTION_NAME: TStringField;
    Splitter3: TSplitter;
    btSaveSpisok: TBitBtn;
    qMainOPTION_NAME_FOR_AB: TStringField;
    qMainCAN_BE_TURNED_BY_OPERATOR: TIntegerField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure qTariffOptionCostsBeforePost(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure dsTariffOptionCostsDataChange(Sender: TObject; Field: TField);
    procedure qTariffOptionNewCostBeforePost(DataSet: TDataSet);
    procedure dsTariffOptionCostNewDataChange(Sender: TObject; Field: TField);
    procedure qTariffOptionCostsBeforeClose(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btFindOptionsClick(Sender: TObject);
    procedure btSaveSpisokClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main, IntecExportGrid;

procedure TRefTariffOptionsForm.aCancelExecute(Sender: TObject);
begin
  if ActiveControl <> gTariffOptionCosts then
    inherited
  else
    qTariffOptionCosts.Cancel;
end;

procedure TRefTariffOptionsForm.aDeleteExecute(Sender: TObject);
begin
  if ActiveControl.name='CRDBGrid1' then inherited
  else if ActiveControl=gTariffOptionCosts then
    begin
    if mrOk = MessageDlg('Удалить текущую запись стоимости ?', mtConfirmation, [mbOK, mbCancel], 0) then
      qTariffOptionCosts.Delete;
    end
  else if ActiveControl=gTariffOptionCostNew then
  begin
    if mrOk = MessageDlg('Удалить тариф из услуги?', mtConfirmation, [mbOK, mbCancel], 0) then
      qTariffOptionNewCost.Delete;
  end
  else
   showmessage('Записи таблицы только для чтения');
end;

procedure TRefTariffOptionsForm.aEditExecute(Sender: TObject);
begin
  if ActiveControl.name='CRDBGrid1' then inherited
  else if ActiveControl=gTariffOptionCosts then qTariffOptionCosts.Edit
  else if ActiveControl=gTariffOptionCostNew then qTariffOptionNewCost.Edit
  else showmessage('Записи таблицы только для чтения');
end;

procedure TRefTariffOptionsForm.aInsertExecute(Sender: TObject);
begin
if ActiveControl.name='CRDBGrid1' then inherited
  else if ActiveControl=gTariffOptionCosts then qTariffOptionCosts.Insert
  else if ActiveControl=gTariffOptionCostNew then qTariffOptionNewCost.Insert
  else showmessage('Записи таблицы только для чтения');
end;

procedure TRefTariffOptionsForm.aPostExecute(Sender: TObject);
begin
if ActiveControl.name='CRDBGrid1' then inherited
  else if ActiveControl=gTariffOptionCosts then qTariffOptionCosts.post
  else if ActiveControl=gTariffOptionCostNew then qTariffOptionNewCost.post
  else showmessage('Записи таблицы только для чтения');
end;

procedure TRefTariffOptionsForm.aRefreshExecute(Sender: TObject);
begin
  if ActiveControl <> gTariffOptionCosts then
    inherited
  else
    qTariffOptionCosts.Refresh;
end;

procedure TRefTariffOptionsForm.btFindOptionsClick(Sender: TObject);
begin
  inherited;
  qTariffOptNo.Close;
  qTariffOptNo.Open;
end;

procedure TRefTariffOptionsForm.btSaveSpisokClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Список неописанных услуг на ' + DateToStr(Date),'', CRDBGrid2, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefTariffOptionsForm.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  qTariffOptionCosts.ParamByName('TARIFF_OPTION_ID').Value := qMain.FieldByName('TARIFF_OPTION_ID').Value;
  qTariffs.ParamByName('OPERATOR_ID').Value := qMain.FieldByName('OPERATOR_ID').Value;
  qTariffOptionCosts.Close;
  qTariffOptionCosts.Open;
{  qTariffOptionNewCost.ParamByName('TARIFF_OPTION_COST_ID').Value:=qTariffOptionCosts.FieldByName('TARIFF_OPTION_COST_ID').Value;
  qTariffOptionNewCost.Close;
  qTariffOptionNewCost.Open;}
end;

procedure TRefTariffOptionsForm.dsTariffOptionCostNewDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  qTariffOptionNewCost.Close;
  qTariffOptionNewCost.Open;
end;

procedure TRefTariffOptionsForm.dsTariffOptionCostsDataChange(Sender: TObject;
  Field: TField);
begin
  qTariffOptionNewCost.ParamByName('TARIFF_OPTION_COST_ID').Value:=qTariffOptionCosts.FieldByName('TARIFF_OPTION_COST_ID').Value;
  qTariffOptionNewCost.Close;
  qTariffOptionNewCost.Open;
  inherited;
end;

procedure TRefTariffOptionsForm.FormCreate(Sender: TObject);
begin
  inherited;
  if MainForm.FUseFilialBlockAccess then
  begin
    qTariffs.SQL.Insert(3, '    AND FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    qTariffOptionNewCost.SQL.Append('    AND TARIFFS.FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    CRDBGrid1.ReadOnly:=true;
    gTariffOptionCosts.ReadOnly:=true;
  end;
  if not(GetConstantValue('SERVER_NAME')='CORP_MOBILE') then
    CRDBGrid1.Columns[2].Destroy;
end;

procedure TRefTariffOptionsForm.FormShow(Sender: TObject);
begin
  inherited;
  //qTariffOptNo.Open;
end;

procedure TRefTariffOptionsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('OPERATOR_ID').IsNull then
  begin
    MessageDlg('Оператор должен быть выбран', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('OPTION_CODE').IsNull then
  begin
    MessageDlg('Код тарифной опции должен быть заполнено', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('OPTION_NAME').IsNull then
  begin
    MessageDlg('Наименование тарифной опции должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

procedure TRefTariffOptionsForm.qTariffOptionCostsBeforeClose(
  DataSet: TDataSet);
begin
  inherited;
  if DataSet.State in [dsEdit, dsInsert] then
    DataSet.Post;

end;

procedure TRefTariffOptionsForm.qTariffOptionCostsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qTariffOptionCosts.Active and (qTariffOptionCosts.State in [dsInsert]) then
  begin
    qGetNewTariffOptionCostId.ExecSQL;
    qTariffOptionCosts.FieldByName('TARIFF_OPTION_COST_ID').Value := qGetNewTariffOptionCostId.ParamByName('RESULT').Value;
    qTariffOptionCosts.FieldByName('TARIFF_OPTION_ID').Value := qMain.FieldByName('TARIFF_OPTION_ID').Value;
  end;
end;

procedure TRefTariffOptionsForm.qTariffOptionNewCostBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if qTariffOptionNewCost.Active and (qTariffOptionNewCost.State in [dsInsert]) then
  begin
    qGetNewTariffOptionNewCostId.ExecSQL;
    qTariffOptionNewCost.FieldByName('TARIFF_OPTION_NEW_COST_ID').Value := qGetNewTariffOptionNewCostId.ParamByName('RESULT').Value;
    qTariffOptionNewCost.FieldByName('TARIFF_OPTION_COST_ID').Value := qTariffOptionCosts.FieldByName('TARIFF_OPTION_COST_ID').Value;
  end;
end;

end.
