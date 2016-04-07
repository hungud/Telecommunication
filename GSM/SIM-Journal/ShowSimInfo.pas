unit ShowSimInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, DBGridEh, ComCtrls, ToolWin, sToolBar,
  StdCtrls, sEdit, Mask, DBCtrlsEh, DBLookupEh, DBCtrls, ExtCtrls, sPanel,
  ActnList, sLabel;

type
  TShowSimInfoForm = class(TForm)
    sPanel1: TsPanel;
    qInfo: TOraQuery;
    qInfoSIM_ID: TFloatField;
    qInfoAGENT_NAME: TStringField;
    qInfoSUBAGENT_NAME: TStringField;
    qInfoOPERATOR_NAME: TStringField;
    qInfoDATE_INIT: TDateTimeField;
    qInfoSTATUS_NAME: TStringField;
    qInfoDATE_MOVE: TDateTimeField;
    qInfoACCOUNT: TStringField;
    qInfoCELL_NUMBER: TStringField;
    qInfoTARIFF_NAME: TStringField;
    qInfoSIM_NUMBER: TStringField;
    qInfoABON_PAY: TFloatField;
    qInfoDATE_ACTIVATE: TDateTimeField;
    qInfoDATE_ERASE: TDateTimeField;
    qInfoABONENT_NAME: TStringField;
    qInfoBALANCE: TFloatField;
    qInfoDATE_BALANCE: TDateTimeField;
    qInfoDATE_LAST_ACTIVITY: TDateTimeField;
    qInfoGID_STATUS: TStringField;
    dsInfo: TDataSource;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    DBLookupComboboxEh2: TDBLookupComboboxEh;
    DBLookupComboboxEh3: TDBLookupComboboxEh;
    sToolBar1: TsToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    qSim: TOraQuery;
    dsSim: TDataSource;
    qSimSIM_ID: TFloatField;
    qSimAGENT_ID: TFloatField;
    qSimSUBAGENT_ID: TFloatField;
    qSimOPERATOR_ID: TFloatField;
    qSimDATE_INIT: TDateTimeField;
    qSimSTATUS_ID: TFloatField;
    qSimDATE_MOVE: TDateTimeField;
    qSimACCOUNT: TStringField;
    qSimCELL_NUMBER: TStringField;
    qSimTARIFF_ID: TFloatField;
    qSimSIM_NUMBER: TStringField;
    qSimABON_PAY: TFloatField;
    qSimDATE_ACTIVATE: TDateTimeField;
    qSimDATE_ERASE: TDateTimeField;
    qSimBALANCE: TFloatField;
    qSimDATE_BALANCE: TDateTimeField;
    qSimDATE_LAST_ACTIVITY: TDateTimeField;
    qSimSERVICEGID_STATUS: TIntegerField;
    qSimPHONE_IS_ACTIVE: TStringField;
    ActionList1: TActionList;
    aDeleteNumber: TAction;
    aRefresh: TAction;
    aSetInfo: TAction;
    qAgents: TOraQuery;
    dsAgents: TDataSource;
    qAgentsAGENT_ID: TFloatField;
    qAgentsAGENT_NAME: TStringField;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    DBEditEh1: TDBEditEh;
    qSubAgents: TOraQuery;
    dsSubAgents: TDataSource;
    qTariff: TOraQuery;
    dsTariff: TDataSource;
    qSubAgentsSUB_AGENT_ID: TFloatField;
    qSubAgentsSUB_AGENT_NAME: TStringField;
    qTariffTARIFF_ID: TFloatField;
    qTariffTARIFF_NAME: TStringField;
    DBLookupComboboxEh4: TDBLookupComboboxEh;
    sLabel5: TsLabel;
    qSimStatus: TOraQuery;
    dsSimStatus: TDataSource;
    qSimStatusSIM_STATUS_ID: TFloatField;
    qSimStatusSIM_STATUS_NAME: TStringField;
    sLabel6: TsLabel;
    DBText1: TDBText;
    sLabel7: TsLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    sLabel8: TsLabel;
    DBText2: TDBText;
    sLabel9: TsLabel;
    DBText3: TDBText;
    DBLookupComboboxEh7: TDBLookupComboboxEh;
    sLabel10: TsLabel;
    sLabel11: TsLabel;
    sLabel12: TsLabel;
    DBText4: TDBText;
    DBText5: TDBText;
    qSGStatus: TOraQuery;
    dsSGStatus: TDataSource;
    qSGStatusSIM_SG_STATUS_ID: TFloatField;
    qSGStatusSIM_SG_STATUS_NAME: TStringField;
    sEdit1: TsEdit;
    sLabel13: TsLabel;
    procedure aDeleteNumberExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aSetInfoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsSimDataChange(Sender: TObject; Field: TField);
    procedure dsSimStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoShowSimInfo(CellNum:string);

var
  ShowSimInfoForm: TShowSimInfoForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure DoShowSimInfo(CellNum:string);
var InfoForm: TShowSimInfoForm;
begin
  InfoForm:=TShowSimInfoForm.Create(Nil);
  InfoForm.qInfo.ParamByName('CELL_NUM').AsString:=CellNum;
  InfoForm.qInfo.Open;
  InfoForm.qSim.ParamByName('CELL_NUM').AsString:=CellNum;
  InfoForm.qSim.Open;
  InfoForm.qAgents.Open;
  InfoForm.qSubAgents.Open;
  InfoForm.qTariff.Open;
  InfoForm.qSimStatus.Open;
  InfoForm.Caption:=InfoForm.Caption + ' ' + InfoForm.qSimCELL_NUMBER.AsString;
  InfoForm.qSGStatus.Open;
  InfoForm.sEdit1.Text:=CellNum;
  InfoForm.DBText4.Font.Color:=clRed;
  try
    InfoForm.ShowModal;
  finally
    InfoForm.qAgents.Close;
    InfoForm.qInfo.Close;
    InfoForm.qSim.Close;
    InfoForm.qSubAgents.Close;
    InfoForm.qTariff.Close;
    InfoForm.qSimStatus.Close;
    InfoForm.qSGStatus.Close;
    InfoForm.Free;
  end;
end;

procedure TShowSimInfoForm.aDeleteNumberExecute(Sender: TObject);
begin
  if qSim.Active and (qSim.RecordCount > 0) then
    if mrOk = MessageDlg('Удалить текущую запись ?', mtConfirmation, [mbOK, mbCancel], 0) then
      qSim.Delete;
  Close;
end;

procedure TShowSimInfoForm.aRefreshExecute(Sender: TObject);
begin
  qAgents.Close;
  qInfo.Close;
  qSim.Close;
  qSubAgents.Close;
  qTariff.Close;
  qSimStatus.Close;
  qSGStatus.Close;
  qAgents.Open;
  qInfo.Open;
  qSim.Open;
  qSubAgents.Open;
  qTariff.Open;
  qSimStatus.Open;
  qSGStatus.Open;
end;

procedure TShowSimInfoForm.aSetInfoExecute(Sender: TObject);
var vRes:Integer;
begin
  if qSim.Active and (qSim.State in [dsEdit]) then
  begin
    vRes:=MessageDlg('Сохранить изменения ?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mrYes = vRes then
      qSim.Post
    else if mrNo = vRes then
      qSim.Cancel;
  end;
end;

procedure TShowSimInfoForm.dsSimDataChange(Sender: TObject; Field: TField);
begin
  if qSimPHONE_IS_ACTIVE.AsString='Активен' then
    DBText1.Font.Color:=clGreen
  else
    DBText1.Font.Color:=clRed;
  if qSimBALANCE.AsFloat>=3 then
    DBText4.Font.Color:=clGreen
  else
    DBText4.Font.Color:=clRed;
end;

procedure TShowSimInfoForm.dsSimStateChange(Sender: TObject);
begin
  if dsSim.State in [dsEdit] then
    ToolButton1.Enabled:=true
  else
    ToolButton1.Enabled:=false;
end;

procedure TShowSimInfoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qAgents.Close;
  qInfo.Close;
  qSim.Close;
  qSubAgents.Close;
  qTariff.Close;
  qSimStatus.Close;
  qSGStatus.Close;
  Action:=caFree;
  MainForm.acRefresh.Execute;
end;

end.
