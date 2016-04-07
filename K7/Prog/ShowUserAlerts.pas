unit ShowUserAlerts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, ComCtrls, Buttons;

type
  TShowUserAlertForm = class(TForm)
    spGetCreditInfo: TOraStoredProc;
    OraStoredProc1: TOraStoredProc;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lRassrochka: TLabel;
    qRassrochka: TOraQuery;
    qRassrochkaINSTALLMENT_PAYMENT_DATE: TDateTimeField;
    qRassrochkaINSTALLMENT_PAYMENT_SUM: TFloatField;
    qRassrochkaINSTALLMENT_PAYMENT_MONTHS: TFloatField;
    qRassrochkaFULL_INST_PAID: TFloatField;
    btAdvRepayment: TBitBtn;
    dtpAdvRepaymentDate: TDateTimePicker;
    qRassrochkaINSTALLMENT_ADVANCED_REPAYMENT: TDateTimeField;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    DisconSum: TLabel;
    Unblocksum: TLabel;
    numcost: TLabel;
    qRassrochkaCONTRACT_ID: TFloatField;
    qRassrochkaDISCONNECT_LIMIT: TFloatField;
    qRassrochkaCONNECT_LIMIT: TFloatField;
    qRassrochkaGOLD_NUMBER_SUM: TFloatField;
    lblCreditInfo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btAdvRepaymentClick(Sender: TObject);
    procedure qRassrochkaAfterOpen(DataSet: TDataSet);
  private
    procedure ReadRassrInfo;
  public
    FContractID : integer;
    FPhoneNumber: string;
    FCreditInfo: string;
  end;

var
  ShowUserAlertForm: TShowUserAlertForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TShowUserAlertForm.btAdvRepaymentClick(Sender: TObject);
var vRes : Integer;
begin
  qRassrochka.Edit;
  qRassrochkaINSTALLMENT_ADVANCED_REPAYMENT.AsDateTime:= dtpAdvRepaymentDate.Date;
  vRes := MessageDlg('Погасить рассрочку досрочно на ' + DateToStr(dtpAdvRepaymentDate.Date)
    + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if mrYes = vRes then
    qRassrochka.Post;
  ReadRassrInfo;
end;

procedure TShowUserAlertForm.FormShow(Sender: TObject);
begin
  dtpAdvRepaymentDate.DateTime:=Date;
  Caption:=Caption + ' ' + FPhoneNumber;
  if (FContractID<>0)and(GetConstantValue('CREDIT_SYSTEM_ENABLE')='1') then
  begin
    spGetCreditInfo.ParamByName('PCONTRACT_ID').AsInteger:=FContractID;
    spGetCreditInfo.ExecSQL;
    //lCreditInfo.Caption:=spGetCreditInfo.ParamByName('RESULT').AsString;
    lblCreditInfo.Caption:=spGetCreditInfo.ParamByName('RESULT').AsString;
    lblCreditInfo.Show;
    //lCreditInfo.Caption:=FCreditInfo;
  end else
    lblCreditInfo.Hide;
  ReadRassrInfo;
end;

procedure TShowUserAlertForm.qRassrochkaAfterOpen(DataSet: TDataSet);
begin
  if qRassrochkaINSTALLMENT_ADVANCED_REPAYMENT.IsNull
    then dtpAdvRepaymentDate.DateTime:=Date
    else dtpAdvRepaymentDate.DateTime:=qRassrochkaINSTALLMENT_ADVANCED_REPAYMENT.AsDateTime;
end;

procedure TShowUserAlertForm.ReadRassrInfo;
begin
  if (FContractID<>0)and(GetConstantValue('USE_INSTALLMENT_PAYMENT')='1') then
  begin
    qRassrochka.ParamByName('pCONTRACT_ID').AsInteger:=FContractID;
    qRassrochka.Close;
    qRassrochka.Open;
    if qRassrochkaINSTALLMENT_PAYMENT_MONTHS.AsFloat > 0 then
    begin
      lRassrochka.Caption:=StringReplace(lRassrochka.Caption,
        '%date%', qRassrochkaINSTALLMENT_PAYMENT_DATE.AsString, [rfReplaceAll, rfIgnoreCase]);
      lRassrochka.Caption:=StringReplace(lRassrochka.Caption,
        '%sum%', qRassrochkaINSTALLMENT_PAYMENT_SUM.AsString, [rfReplaceAll, rfIgnoreCase]);
      lRassrochka.Caption:=StringReplace(lRassrochka.Caption,
        '%month%', qRassrochkaINSTALLMENT_PAYMENT_MONTHS.AsString, [rfReplaceAll, rfIgnoreCase]);
      lRassrochka.Caption:=StringReplace(lRassrochka.Caption,
        '%rass%', qRassrochkaFULL_INST_PAID.AsString, [rfReplaceAll, rfIgnoreCase]);
      lRassrochka.Caption:=StringReplace(lRassrochka.Caption,
        '%tail%', FloatToStr(qRassrochkaINSTALLMENT_PAYMENT_SUM.AsFloat
           - qRassrochkaFULL_INST_PAID.AsFloat), [rfReplaceAll, rfIgnoreCase]);
      lRassrochka.Show;
      if qRassrochkaINSTALLMENT_PAYMENT_SUM.AsFloat = qRassrochkaFULL_INST_PAID.AsFloat
        then lRassrochka.Font.Color:=clGreen
        else lRassrochka.Font.Color:=clRed;
      btAdvRepayment.Enabled:=
        not(qRassrochkaINSTALLMENT_PAYMENT_SUM.AsFloat = qRassrochkaFULL_INST_PAID.AsFloat);
    end else
    begin
      lRassrochka.Hide;
      btAdvRepayment.Hide;
      dtpAdvRepaymentDate.Hide;
    end;
  end else
          begin
            lRassrochka.Hide;
            btAdvRepayment.Hide;
            dtpAdvRepaymentDate.Hide;
          end;
  if qRassrochkaDISCONNECT_LIMIT.AsFloat <> 0 then
    with DisconSum do begin
      Visible:=True;
      Caption:=StringReplace(Caption,'%dislim%',qRassrochkaDISCONNECT_LIMIT.AsString,[rfReplaceAll,rfIgnoreCase]);
    end else DisconSum.Visible:=False;

  if qRassrochkaCONNECT_LIMIT.AsFloat <> 0 then
    with Unblocksum do begin
      Visible:=True;
      Caption:=StringReplace(Caption,'%conlim%',qRassrochkaCONNECT_LIMIT.AsString,[rfReplaceAll,rfIgnoreCase]);
    end else Unblocksum.Visible:=False;

  if qRassrochkaGOLD_NUMBER_SUM.AsFloat <> 0 then
    with numcost do begin
      Visible:=True;
      Caption:=StringReplace(Caption,'%numcost%',qRassrochkaGOLD_NUMBER_SUM.AsString,[rfReplaceAll,rfIgnoreCase]);
    end else numcost.Visible:=False;

end;

end.
