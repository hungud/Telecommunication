unit RefTariffOptionBenefits;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Menus,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ExtCtrls, Data.DB, MemDS,
  DBAccess, Ora;

type
  TRefTariffOptionBenefitsForm = class(TForm)
    qTOBenefit: TOraQuery;
    qTOBenefitCosts: TOraQuery;
    dsTOBenefits: TDataSource;
    dsTOBenefitCosts: TDataSource;
    pTOBenefits: TPanel;
    pTOBenefitCosts: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    CRDBGridTOB: TCRDBGrid;
    CRDBGridTOBCost: TCRDBGrid;
    ActionList1: TActionList;
    aTOBInsert: TAction;
    aTOBEdit: TAction;
    aTOBDelete: TAction;
    aTOBRefresh: TAction;
    aTOBPost: TAction;
    aTOBCancel: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    qTOBenefitOPTION_GROUP_NAME: TStringField;
    qTOBenefitIS_ACTIVE: TIntegerField;
    qTOBenefitUSER_CREATED: TStringField;
    qTOBenefitDATE_CREATED: TDateTimeField;
    qTOBenefitUSER_LAST_UPDATED: TStringField;
    qTOBenefitDATE_LAST_UPDATED: TDateTimeField;
    qTOBenefitCostsOPTION_CODE: TStringField;
    qTOBenefitCostsTURN_ON_COST: TFloatField;
    qTOBenefitCostsMONTHLY_COST: TFloatField;
    qTOBenefitCostsBILL_TURN_ON_COST: TFloatField;
    qTOBenefitCostsBILL_MONTHLY_COST: TFloatField;
    qTOBenefitCostsUSER_CREATED: TStringField;
    qTOBenefitCostsDATE_CREATED: TDateTimeField;
    qTOBenefitCostsUSER_LAST_UPDATED: TStringField;
    qTOBenefitCostsDATE_LAST_UPDATED: TDateTimeField;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    qTOBenefitOPTION_GROUP_ID: TFloatField;
    aTOBExcel: TAction;
    Panel1: TPanel;
    aTOBCostInsert: TAction;
    Panel2: TPanel;
    ToolBar2: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Panel4: TPanel;
    Panel5: TPanel;
    ToolBar3: TToolBar;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    Panel6: TPanel;
    spNewOptionGroupId: TOraStoredProc;
    spNewOptionGroupCostId: TOraStoredProc;
    aTOBCostEdit: TAction;
    aTOBCostDelete: TAction;
    aTOBCostPost: TAction;
    aTOBCostCancel: TAction;
    aTOBCostRefresh: TAction;
    aTOBCostExcel: TAction;
    qTOBenefitCostsTARIFF_OPT_GROUP_COST_ID: TFloatField;
    qTOBenefitCostsOPTION_GROUP_ID: TFloatField;
    qTOBCostsDELETE: TOraQuery;
    procedure FormShow(Sender: TObject);
    procedure dsTOBenefitsDataChange(Sender: TObject; Field: TField);
    procedure aTOBInsertExecute(Sender: TObject);
    procedure aTOBEditExecute(Sender: TObject);
    procedure aTOBDeleteExecute(Sender: TObject);
    procedure aTOBRefreshExecute(Sender: TObject);
    procedure aTOBPostExecute(Sender: TObject);
    procedure aTOBCancelExecute(Sender: TObject);
    procedure aTOBExcelExecute(Sender: TObject);
    procedure aTOBCostInsertExecute(Sender: TObject);
    procedure qTOBenefitBeforePost(DataSet: TDataSet);
    procedure aTOBCostEditExecute(Sender: TObject);
    procedure aTOBCostDeleteExecute(Sender: TObject);
    procedure aTOBCostPostExecute(Sender: TObject);
    procedure aTOBCostCancelExecute(Sender: TObject);
    procedure aTOBCostRefreshExecute(Sender: TObject);
    procedure aTOBCostExcelExecute(Sender: TObject);
    procedure qTOBenefitCostsBeforePost(DataSet: TDataSet);
    procedure CRDBGridTOBCostEnter(Sender: TObject);
  private
    protected function CheckPost(qMain : TOraQuery): boolean;
  public
    { Public declarations }
  end;

var
  RefTariffOptionBenefitsForm: TRefTariffOptionBenefitsForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

function TRefTariffOptionBenefitsForm.CheckPost(qMain : TOraQuery): boolean;
var vRes : Integer;
begin
  Result := True;
  if qMain.Active and (qMain.State in [dsEdit, dsInsert]) then
  begin
    vRes := MessageDlg('Сохранить изменения?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mrYes = vRes then
      qMain.Post
    else if mrNo = vRes then
      qMain.Cancel;
    Result := (vRes <> mrCancel);
  end;
end;

procedure TRefTariffOptionBenefitsForm.CRDBGridTOBCostEnter(Sender: TObject);
begin
  if qTOBenefit.State in [dsEdit, dsInsert] then
    Application.MessageBox(Pchar('Сохраните изменения в описании группы '
      + 'перед редактированием услуг, во избежание ошибок.'), 'Уведомление',
      MB_OK + MB_ICONINFORMATION);
end;

procedure TRefTariffOptionBenefitsForm.aTOBExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  inherited;
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Список групп услуг.','',
      CRDBGridTOB, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  inherited;
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Список услуг группы "'
      + qTOBenefit.FieldByName('OPTION_GROUP_NAME').AsString + '"','',
      CRDBGridTOBCost, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCancelExecute(Sender: TObject);
begin
  if qTOBenefit.Active then
    if qTOBenefit.State in [dsEdit, dsInsert] then
      qTOBenefit.Cancel;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostCancelExecute(Sender: TObject);
begin
  if qTOBenefitCosts.Active then
    if qTOBenefitCosts.State in [dsEdit, dsInsert] then
      qTOBenefitCosts.Cancel;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostDeleteExecute(Sender: TObject);
begin
  if qTOBenefitCosts.Active and (qTOBenefitCosts.RecordCount > 0) then
    if CheckPost(qTOBenefitCosts) then
      if mrOk = MessageDlg('Удалить текущую услугу из группы?', mtConfirmation, [mbOK, mbCancel], 0) then
        qTOBenefitCosts.Delete;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostEditExecute(Sender: TObject);
begin
  if qTOBenefitCosts.Active and (qTOBenefitCosts.RecordCount > 0) then
    if CheckPost(qTOBenefitCosts) then
      qTOBenefitCosts.Edit;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostInsertExecute(Sender: TObject);
begin
  if qTOBenefitCosts.Active then
    if CheckPost(qTOBenefitCosts) then
      qTOBenefitCosts.Insert;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostPostExecute(Sender: TObject);
begin
  if qTOBenefitCosts.Active then
    if qTOBenefitCosts.State in [dsEdit, dsInsert] then
      qTOBenefitCosts.Post;
end;

procedure TRefTariffOptionBenefitsForm.aTOBCostRefreshExecute(Sender: TObject);
begin
  if CheckPost(qTOBenefitCosts) then
    if not qTOBenefitCosts.Active
      then qTOBenefitCosts.Open
      else qTOBenefitCosts.Refresh;
end;

procedure TRefTariffOptionBenefitsForm.aTOBDeleteExecute(Sender: TObject);
begin
  if qTOBenefit.Active and (qTOBenefit.RecordCount > 0) then
    if CheckPost(qTOBenefit) then
      if mrOk = MessageDlg('Удалить текущую группу?', mtConfirmation, [mbOK, mbCancel], 0) then
      begin
        qTOBCostsDELETE.ParamByName('pOPTION_GROUP_ID').AsInteger:=
          qTOBenefit.FieldByName('OPTION_GROUP_ID').AsInteger;
        qTOBCostsDELETE.ExecSQL;
        qTOBenefit.Delete;
      end;
end;

procedure TRefTariffOptionBenefitsForm.aTOBEditExecute(Sender: TObject);
begin
  if qTOBenefit.Active and (qTOBenefit.RecordCount > 0) then
    if CheckPost(qTOBenefit) then
      qTOBenefit.Edit;
end;

procedure TRefTariffOptionBenefitsForm.aTOBInsertExecute(Sender: TObject);
begin
  if qTOBenefit.Active then
    if CheckPost(qTOBenefit) then
      qTOBenefit.Insert;
end;

procedure TRefTariffOptionBenefitsForm.aTOBPostExecute(Sender: TObject);
begin
  if qTOBenefit.Active then
    if qTOBenefit.State in [dsEdit, dsInsert] then
      qTOBenefit.Post;
end;

procedure TRefTariffOptionBenefitsForm.aTOBRefreshExecute(Sender: TObject);
begin
  if CheckPost(qTOBenefit) then
    if not qTOBenefit.Active
      then qTOBenefit.Open
      else qTOBenefit.Refresh;
end;

procedure TRefTariffOptionBenefitsForm.dsTOBenefitsDataChange(Sender: TObject; Field: TField);
begin
  qTOBenefitCosts.Close;
  qTOBenefitCosts.ParamByName('pOPTION_GROUP_ID').AsInteger:=
    qTOBenefit.FieldByName('OPTION_GROUP_ID').AsInteger;
  qTOBenefitCosts.Open;
end;

procedure TRefTariffOptionBenefitsForm.FormShow(Sender: TObject);
var vMessage : String;
begin
  try
    aTOBRefresh.Execute;
  except
    on E: exception do
    begin
      vMessage := e.Message;
      MessageDlg(PChar(vMessage), mtError, [mbOK], 0);
      Close;
    end;
  end;
end;

procedure TRefTariffOptionBenefitsForm.qTOBenefitBeforePost(DataSet: TDataSet);
begin
  if qTOBenefit.Active and (qTOBenefit.State in [dsInsert]) then
  begin
    spNewOptionGroupId.ExecSQL;
    qTOBenefit.FieldByName('OPTION_GROUP_ID').Value :=
      spNewOptionGroupId.ParamByName('RESULT').Value;
  end;
end;

procedure TRefTariffOptionBenefitsForm.qTOBenefitCostsBeforePost(
  DataSet: TDataSet);
begin
  if qTOBenefitCosts.Active and (qTOBenefitCosts.State in [dsInsert]) then
  begin
    spNewOptionGroupCostId.ExecSQL;
    qTOBenefitCosts.FieldByName('TARIFF_OPT_GROUP_COST_ID').Value:=
      spNewOptionGroupCostId.ParamByName('RESULT').Value;
    qTOBenefitCosts.FieldByName('OPTION_GROUP_ID').Value:=
      qTOBenefit.FieldByName('OPTION_GROUP_ID').Value;
  end;
end;

end.
