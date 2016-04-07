unit RefTariff_option;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCGrids, Vcl.ExtCtrls, Data.DB,
  MemDS, DBAccess, Ora, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask,TypInfo;

type
  TTariff_option = class(TForm)
    pnl1: TPanel;
    Ctrl_Options: TDBCtrlGrid;
    qOptions: TOraQuery;
    dsTariff_opt: TDataSource;
    qTarrifs: TOraQuery;
    TARIFF_OPTION_ID: TFloatField;
    OPTION_CODE: TStringField;
    OPTION_NAME: TStringField;
    KOEF_KOMISS_O: TFloatField;
    CALC_UNBLOCK_O: TStringField;
    DISCR_SPISANIE: TStringField;
    OPTION_NAME_FOR_AB: TStringField;
    qOptionsBEGIN_DATE: TDateTimeField;
    qOptionsEND_DATE: TDateTimeField;
    TURN_ON_COST_O: TFloatField;
    MONTHLY_COST_O: TFloatField;
    OPERATOR_TURN_ON_COST: TFloatField;
    OPERATOR_MONTHLY_COST: TFloatField;
    TURN_ON_COST: TFloatField;
    MONTHLY_COST: TFloatField;
    TURN_ON_COST_FOR_BILLS: TFloatField;
    MONTHLY_COST_FOR_BILLS: TFloatField;
    qTarrifsTARIFF_CODE: TStringField;
    qTarrifsTARIFF_NAME: TStringField;
    qTarrifsIS_ACTIVE: TIntegerField;
    qTarrifsSTART_BALANCE: TFloatField;
    qTarrifsCONNECT_PRICE: TFloatField;
    qTarrifsADVANCE_PAYMENT: TFloatField;
    qTarrifsPHONE_NUMBER_TYPE: TIntegerField;
    qTarrifsDAYLY_PAYMENT: TFloatField;
    qTarrifsDAYLY_PAYMENT_LOCKED: TFloatField;
    qTarrifsMONTHLY_PAYMENT: TFloatField;
    qTarrifsMONTHLY_PAYMENT_LOCKED: TFloatField;
    qTarrifsCALC_KOEFF: TFloatField;
    qTarrifsFREE_MONTH_MINUTES_CNT_FOR_RPT: TIntegerField;
    qTarrifsBALANCE_BLOCK: TFloatField;
    qTarrifsBALANCE_UNBLOCK: TFloatField;
    qTarrifsBALANCE_NOTICE: TFloatField;
    qTarrifsTARIFF_ADD_COST: TFloatField;
    qTarrifsBALANCE_BLOCK_CREDIT: TFloatField;
    qTarrifsBALANCE_UNBLOCK_CREDIT: TFloatField;
    qTarrifsBALANCE_NOTICE_CREDIT: TFloatField;
    qTarrifsTARIFF_CODE_CRM: TStringField;
    qTarrifsTARIFF_PRIORITY: TFloatField;
    qTarrifsTARIFF_ABON_DAILY_PAY: TFloatField;
    qTarrifsTARIFF_ACTION_PLUS_SMS: TFloatField;
    qTarrifsOPERATOR_MONTHLY_ABON_BLOCK: TFloatField;
    qTarrifsCALC_KOEFF_DETAL: TFloatField;
    fldTarrifsOPERATOR_MONTHLY_ABON_ACTIV: TFloatField;
    dsTariffs: TDataSource;
    TARIFF_ID: TFloatField;
    lblBEGIN_DATE: TDBText;
    dbtxtCALC_UNBLOCK_O: TDBText;
    dbtxtCALC_UNBLOCK_O1: TDBText;
    dbtxtCALC_UNBLOCK_O2: TDBText;
    dbtxtCALC_UNBLOCK_O8: TDBText;
    lbl1: TLabel;
    lbl2: TLabel;
    dbtxtCALC_UNBLOCK_O9: TDBText;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dbtxtOPTION_NAME_FOR_AB: TDBText;
    lbl7: TLabel;
    Bevel1: TBevel;
    bvl1: TBevel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    dbtxtKOEF_KOMISS_O: TDBText;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    dbtxtTURN_ON_COST: TDBText;
    dbtxtMONTHLY_COST: TDBText;
    dbtxtOPERATOR_TURN_ON_COST: TDBText;
    dbtxtOPERATOR_MONTHLY_COST: TDBText;
    Label1: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    Label2: TLabel;
    dbedtTURN_ON_COST_FOR_BILLS: TDBEdit;
    dbedtMONTHLY_COST_FOR_BILLS: TDBEdit;
    dbedtTURN_ON_COST: TDBEdit;
    dbedtMONTHLY_COST: TDBEdit;
    lbl18: TLabel;
    dbedt1: TDBEdit;
    dbtxtTARIFF_CODE: TDBText;
    dbchkIS_ACTIVE: TDBCheckBox;
    lbl19: TLabel;
    dbedtCONNECT_PRICE: TDBEdit;
    lbl20: TLabel;
    dbedtSTART_BALANCE: TDBEdit;
    dbchkPHONE_NUMBER_TYPE: TDBCheckBox;
    lbl21: TLabel;
    dbedtMONTHLY_PAYMENT: TDBEdit;
    lbl22: TLabel;
    dbedtMONTHLY_PAYMENT_LOCKED: TDBEdit;
    lbl23: TLabel;
    dbedtCALC_KOEFF: TDBEdit;
    lbl24: TLabel;
    dbedtCALC_KOEFF_DETAL: TDBEdit;
    lbl25: TLabel;
    dbedt2: TDBEdit;
    lbl26: TLabel;
    dbedtBALANCE_BLOCK: TDBEdit;
    dbedtBALANCE_UNBLOCK: TDBEdit;
    lbl27: TLabel;
    lbl28: TLabel;
    dbedtBALANCE_NOTICE: TDBEdit;
    lbl29: TLabel;
    dbedtTARIFF_ADD_COST: TDBEdit;
    dbedtBALANCE_BLOCK_CREDIT: TDBEdit;
    lbl30: TLabel;
    lbl31: TLabel;
    dbedtBALANCE_UNBLOCK_CREDIT: TDBEdit;
    Label3: TLabel;
    dbedtBALANCE_NOTICE_CREDIT: TDBEdit;
    dbchkTARIFF_PRIORITY: TDBCheckBox;
    Label4: TLabel;
    dbedtTARIFF_ABON_DAILY_PAY: TDBEdit;
    lbl32: TLabel;
    dbedtTARIFF_ACTION_PLUS_SMS: TDBEdit;
    NVTariff: TDBNavigator;
    TRF_OTP_COST_ID: TFloatField;
    TARIFF_OPTION_COST_ID: TFloatField;
    TARIFF_OPTION_NEW_COST_ID: TFloatField;
    TCN_TARIFF_ID: TFloatField;
    Button1: TButton;
    lblSave: TLabel;
    procedure Ctrl_OptionsPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure dbedtTURN_ON_COSTExit(Sender: TObject);
    procedure dbedtTURN_ON_COSTKeyPress(Sender: TObject; var Key: Char);
    procedure dbedtTURN_ON_COSTEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lblSaveClick(Sender: TObject);
    procedure qOptionsBeforeScroll(DataSet: TDataSet);
    procedure qOptionsUpdateRecord(DataSet: TDataSet; UpdateKind: TUpdateKind;
      var UpdateAction: TUpdateAction);
    procedure qOptionsBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
  STariffID: string;
    { Public declarations }
  end;

var
  Tariff_option: TTariff_option;
   fieldname:string;
  fieldValue:string;

implementation

{$R *.dfm}

procedure TTariff_option.Button1Click(Sender: TObject);
begin
qOptions.Refresh;
end;

procedure TTariff_option.Ctrl_OptionsPaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
var
r:TRect;
begin

R := Self.ClientRect;

if (not TURN_ON_COST.IsNull)
 or(not MONTHLY_COST.IsNull)
 or(not MONTHLY_COST_FOR_BILLS.IsNull)
 or(not TURN_ON_COST_FOR_BILLS.IsNull)
  then
   if DBCtrlGrid.PanelBorder = gbRaised then
    DBCtrlGrid.Canvas.Brush.Color := RGB(176,210,198)
     else
      DBCtrlGrid.Canvas.Brush.Color := RGB(176,232,198)

  else
    if odd(qOptions.RecNo) then  DBCtrlGrid.Canvas.Brush.Color := RGB(237,218,255)
      else DBCtrlGrid.Canvas.Brush.Color := clBtnFace;
InflateRect(R, -2, -2);
DBCtrlGrid.Canvas.FillRect(R);
end;

procedure TTariff_option.dbedtTURN_ON_COSTEnter(Sender: TObject);
var i:integer;
begin
 fieldname:= (Sender as TDBEdit).Name;
 delete(fieldname,1,5);
 fieldValue:=qOptions.FieldByName(fieldname).AsString;
  if TCN_TARIFF_ID.IsNull then
  begin
  qOptions.Edit;
  TCN_TARIFF_ID.AsString:=TARIFF_ID.AsString;
  TRF_OTP_COST_ID.AsString:=TARIFF_OPTION_COST_ID.AsString;
  end;




end;

procedure TTariff_option.dbedtTURN_ON_COSTExit(Sender: TObject);
var
//Active_ctrl:TWinControl;
Sender_data:string;
begin
// if not (Sender as TDBEdit).Focused then  begin
//  Active_ctrl:=Screen.ActiveControl;
//  (Sender as TDBEdit).SetFocus;
// end;

 if fieldValue<>(Sender as TDBEdit).Text then lblSave.Visible:=true;

 //Active_ctrl.SetFocus;

 end;



procedure TTariff_option.dbedtTURN_ON_COSTKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (key in ['0'..'9',',','.',#8]) then key:=#0;
end;

procedure TTariff_option.FormShow(Sender: TObject);
begin
if STariffID<>'' then begin
  qTarrifs.ParamByName('STariffID').AsString:= STariffID;
  qOptions.ParamByName('STariffID').AsString:= STariffID;
if not qTarrifs.Active then qTarrifs.Open;
if not qOptions.Active then qOptions.Open;
end
else
begin
MessageDlg('Тариф не сохранен в системе.',  mtError, [mbOK], 0);
if  qTarrifs.Active then qTarrifs.close;
if qOptions.Active then qOptions.close;
ModalResult:=mrCancel;
end;
end;

procedure TTariff_option.lblSaveClick(Sender: TObject);
begin
      if ( TURN_ON_COST.IsNull)
 and( MONTHLY_COST.IsNull)
 and( MONTHLY_COST_FOR_BILLS.IsNull)
 and( TURN_ON_COST_FOR_BILLS.IsNull) then
    case MessageDlg('Удалить индивидульные расценки услуги для этого тарифа?',  mtConfirmation, [mbYes,
          mbNo], 0) of
         mrYes:begin
                qOptions.Delete;
                qoptions.Refresh;
              end;
         mrNo:qOptions.Cancel;
       end
  else

  case MessageDlg('Сохранить изменения поля?',  mtConfirmation, [mbYes,
    mbNo], 0) of
         mrYes:if (qOptions.State=dsEdit) or (qOptions.State=dsInsert) then qOptions.Post;
         mrNo:qOptions.Cancel;
       end;
lblSave.Visible:=false;
end;

procedure TTariff_option.qOptionsBeforePost(DataSet: TDataSet);
begin
if (not lblsave.Visible) and (DataSet.State in [dsEdit,dsInsert])
then
begin
DataSet.Cancel;
qoptions.Refresh;
end;
end;

procedure TTariff_option.qOptionsBeforeScroll(DataSet: TDataSet);
begin
qOptions.Cancel;
lblSave.Visible:=false;
end;

procedure TTariff_option.qOptionsUpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
if not lblSave.Visible  then DataSet.Cancel;

end;

end.
