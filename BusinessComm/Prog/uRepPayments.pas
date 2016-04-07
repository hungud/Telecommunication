unit uRepPayments;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Data.DB, DBAccess, Ora, MemDS, TimedMsgBox,
  Vcl.Menus, Vcl.ActnList, Vcl.ExtCtrls, sBevel, Vcl.StdCtrls, sComboBox, System.StrUtils,
  sGauge, sEdit, sListBox, sCheckListBox, Vcl.Buttons, sSpeedButton, sLabel,
  sPanel, sScrollBox, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, sStatusBar,
  sSplitter;

type
  TRepPayments = class(TRepFrm)
    qReportDATE_PAY: TDateTimeField;
    qReportVIRTUAL_ACCOUNTS_NAME: TStringField;
    qReportINN: TStringField;
    qReportSUM_PAY: TFloatField;
    qReportDOC_NUMBER: TStringField;
    qReportPAYMENT_PURPOSE: TStringField;
    qReportFILE_NAME: TStringField;
    qSQL_TEMP: TOraQuery;
    qReportPAYER_BIK: TFloatField;
    cbPeriodAfter: TsComboBox;
    aChooseData: TAction;
    qReportVIRTUAL_ACCOUNT_ID: TFloatField;
    qReportPAYMENT_ID: TFloatField;
    qDeletePayment: TOraQuery;
    qReportPAYMANT_ID_HIST: TFloatField;
    sbChooseHist: TsSpeedButton;
    aChooseHist: TAction;
    qReportPHONE_ID: TStringField;
    sbChooseData: TsSpeedButton;
    spDeletePlat: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    qReportYEAR_MONTH: TFloatField;
    qReportPAYMENT_FILE_ID: TFloatField;
    qInsertPayment: TOraQuery;
    qReportID_PAYMENTS_TYPE: TFloatField;
    qReportNAME_PAYMENTS_TYPE: TStringField;
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aChooseDataExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure aChooseHistExecute(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepPayments: TRepPayments;

implementation

{$R *.dfm}

uses uShowAnotherVirt_Ac, ChildFrm, uRepPaymentsHist, uInsPayment;



procedure TRepPayments.aChooseDataExecute(Sender: TObject);
var
  spf : TChildForm;
  mr, VAI : Integer;
begin
  inherited;
  spf := TShowAnotherVirt_Ac.Create(nil, spf, 'Смена виртуального оператора', true);
  //spf := TShowAnotherVirt_Ac.Create(nil);
  TShowAnotherVirt_Ac(spf).VIRTUAL_ACCOUNTS_ID_OLD := qReport.FieldByName('VIRTUAL_ACCOUNT_ID').AsInteger;
  TShowAnotherVirt_Ac(spf).VIRTUAL_ACCOUNTS_NAME :=  qReport.FieldByName('VIRTUAL_ACCOUNTS_NAME').AsString;
  try
    mr := spf.ShowModal;
    if (mr = mrOk) then
    begin
      VAI := TShowAnotherVirt_Ac(spf).VIRTUAL_ACCOUNTS_ID_NEW;
      qSQL_TEMP.SQL.Clear;
      qSQL_TEMP.SQL.Add(' UPDATE PAYMENTS SET VIRTUAL_ACCOUNT_ID = :VIRTUAL_ACCOUNT_ID WHERE  PAYMENT_ID = :PAYMENT_ID');
      qSQL_TEMP.ParamByName('VIRTUAL_ACCOUNT_ID').AsInteger := VAI;
      qSQL_TEMP.ParamByName('PAYMENT_ID').AsInteger := qReport.FieldByName('PAYMENT_ID').AsInteger;
      qSQL_TEMP.Prepare;
      qSQL_TEMP.Execute;
      qReport.Refresh;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRepPayments.aChooseHistExecute(Sender: TObject);
var
  spf : TChildForm;
  frmHIst : TRepPaymentsHist;

begin
  inherited;
  frmHIst := TRepPaymentsHist.Create(nil, spf, 'История платежа № '+ qReport.FieldByName('DOC_NUMBER').AsString + ' от ' + qReport.FieldByName('DATE_PAY').AsString, true);
  frmHIst.aCheckedAll2.Execute;
  frmHIst.pPAYMENT_ID := qReport.FieldByName('PAYMENT_ID').Value;
  frmHIst.aRefresh.Execute;
  frmHIst.s_cancel2.Enabled := False;
  frmHIst.spVirtAcc.Enabled := False;
  frmHIst.cbPeriod.Enabled := False;
  frmHIst.cbPeriodAfter.Enabled := False;
  frmHIst.aRefresh.Enabled := False;
  try
    frmHIst.ShowModal;
  finally
    FreeAndNil(frmHIst);
  end;
end;

procedure TRepPayments.aDeleteExecute(Sender: TObject);
begin
  inherited;
  if TimedMessageBox('Вы действительно хотите удалить этот платеж?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3) = mrYes then
  begin
      qDeletePayment.Close;
      qDeletePayment.ParamByName('PAYMENT_ID').AsInteger := qReport.FieldByName('PAYMENT_ID').AsInteger;
      qDeletePayment.Execute;
      qReport.Refresh;
  end;

end;

procedure TRepPayments.aInsertExecute(Sender: TObject);
var
  spf : TChildForm;
  PAYER_BIK, YEAR_MONTH, VIRTUAL_ACCOUNT_ID, mr : Integer;
  VIRTUAL_ACCOUNT_NAME,  PAYMENT_PURPOSE, DOC_NUMBER, INN : string;
  DATE_PAY : TDate;
  myYear, myMonth, myDay : Word;
  SUM_PAY : Currency;
{  i : Integer;
  txt, txt2 : string;
}
begin
  inherited;
  spf := TInsPaymentFrm.Create(self, spf, 'Добавление нового платежа', true); //, self
  try
    mr := spf.ShowModal;
    if (mr = mrOk) then
    begin
      VIRTUAL_ACCOUNT_ID :=  integer(TInsPaymentFrm(spf).cbVirtAccount.Items.Objects[TInsPaymentFrm(spf).cbVirtAccount.ItemIndex]);
      VIRTUAL_ACCOUNT_NAME := TInsPaymentFrm(spf).cbVirtAccount.Text;
      if (TInsPaymentFrm(spf).NEW_VA = True) then
      begin
        qVirt_Acc.Close;
        qVirt_Acc.Open;
      end;

      if qVirt_Acc.Locate('VIRTUAL_ACCOUNTS_ID',VIRTUAL_ACCOUNT_ID, []) then
        INN :=  qVirt_Acc.FieldByName('INN').AsString;
      //INN := TInsPaymentFrm(spf).seINN.Text; возьмём из справочника

      DATE_PAY := TInsPaymentFrm(spf).deDatePayment.Date;
      DecodeDate(DATE_PAY, myYear, myMonth, myDay);
      YEAR_MONTH := strtoint(IntToStr(myYear) + IntToStr(myMonth));
      SUM_PAY := TInsPaymentFrm(spf).sCurrencyEdit.Value;
      DOC_NUMBER := TInsPaymentFrm(spf).seDocNumber.Text;
      PAYMENT_PURPOSE := TInsPaymentFrm(spf).sePAYMENT_PURPOSE.Text;
      PAYER_BIK := StrToIntDef(TInsPaymentFrm(spf).seBIK.text,0);

      qInsertPayment.ParamByName('VIRTUAL_ACCOUNT_ID').AsInteger := VIRTUAL_ACCOUNT_ID;
      if (TInsPaymentFrm(spf).sePhone.Text <> '') then
        qInsertPayment.ParamByName('PHONE_ID').AsInteger := StrToInt64(TInsPaymentFrm(spf).sePhone.Text)
      else
        qInsertPayment.ParamByName('PHONE_ID').Value := null;

      qInsertPayment.ParamByName('INN').AsString                 := INN;
      qInsertPayment.ParamByName('DATE_PAY').AsDateTime          := DATE_PAY;
      qInsertPayment.ParamByName('YEAR_MONTH').AsInteger         := YEAR_MONTH;
      qInsertPayment.ParamByName('SUM_PAY').AsCurrency           := SUM_PAY;
      qInsertPayment.ParamByName('DOC_NUMBER').AsString          := DOC_NUMBER;
      qInsertPayment.ParamByName('PAYMENT_PURPOSE').AsString     := PAYMENT_PURPOSE;
      qInsertPayment.ParamByName('PAYER_BIK').AsInteger          := PAYER_BIK;
      qInsertPayment.ParamByName('PAYMENT_FILE_ID').AsInteger    := -1;
      qInsertPayment.execute;

      if Trim(VIRTUAL_ACCOUNT_NAME) = '' then
        Exit;

      //закомментил выбор счета после добавления платежа
      {
      LockWindowUpdate(CLB_VirtAcc.Handle);


      for i := 0 to CLB_VirtAcc.Items.Count - 1 do
      begin
        txt := UpperCase(CLB_VirtAcc.Items.Strings[i]);
        txt2 := UpperCase(Trim(VIRTUAL_ACCOUNT_NAME));

        if (txt = txt2) then
        begin
          CLB_VirtAcc.Selected[i] := True;
          CLB_VirtAcc.checked[i] := True;
        end
        else
          CLB_VirtAcc.Selected[i] := false;
      end;

      aCheckedSel2.Enabled := CLB_VirtAcc.SelCount > 0;
      LockWindowUpdate(0);

      aCheckedSel2.Execute;
      }
      aRefresh.Execute;
    end;
  finally
    spf.Free;
  end;

end;

procedure TRepPayments.aRefreshExecute(Sender: TObject);
begin
  if (integer(cbPeriodAfter.Items.Objects[cbPeriodAfter.ItemIndex]) < integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])) then
     TimedMessageBox('Неверно выбраны даты периода - ' +chr(10)+chr(13) +  'дата окончания периода должна быть больше или равна дате начала периода!',
      'Пожалуйста, будьте внимательны!', mtConfirmation,[mbOk], mbOK, 10, 3)
  else
    inherited;
  aInsert.Enabled := not qReport.IsEmpty;
  aChooseData.Enabled := not qReport.IsEmpty;
  aDelete.Enabled := not qReport.IsEmpty;

end;

procedure TRepPayments.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  CLB_VirtAccs := True;
  cb_Period   := True;

  for I := 0 to cbPeriod.Items.Count - 1 do
  begin
    cbPeriodAfter.Items.AddObject(cbPeriod.Items.Strings[i] , cbPeriod.Items.Objects[i]);
  end;
  if cbPeriodAfter.Items.Count > 0 then
    cbPeriodAfter.ItemIndex := 0
  else
    cbPeriodAfter.ItemIndex := cbPeriod.ItemIndex;

  Name_File_Excel := Caption;
  Zagolovok_Excel := Name_File_Excel;
end;

procedure TRepPayments.FormShow(Sender: TObject);
begin
  inherited;
 // cbPeriod.Left := 443;
end;

procedure TRepPayments.qReportAfterScroll(DataSet: TDataSet);
begin
  inherited;
  aChooseHist.Enabled := (qReport.FieldByName('PAYMANT_ID_HIST').AsString <> '');
end;

procedure TRepPayments.qReportBeforeOpen(DataSet: TDataSet);
begin
  //inherited;
  if FVSchid <> '' then
  begin
    qReport.SQL.Clear;
    qReport.SQL := qSQL_TEMP.SQL;

    qReport.ParamByName('year_month_start').Value := YEAR_MONTH;

    if cbPeriodAfter.ItemIndex >= 0 then
      qReport.ParamByName('year_month_end').Value := integer(cbPeriodAfter.Items.Objects[cbPeriodAfter.ItemIndex])
    else
      qReport.ParamByName('year_month_end').Value := -1;


    if VSch_count <> CLB_VirtAcc.Items.Count  then
    begin
      if (VSch_count = 1) then
      begin
        qReport.SQL.Add(' and VIRTUAL_ACCOUNT_ID = :VIRTUAL_ACCOUNT_ID');
        qReport.ParamByName('VIRTUAL_ACCOUNT_ID').Value := StrToInt(FVSchid);
      end
      else
       qReport.SQL.Add(' and VIRTUAL_ACCOUNT_ID in (' + FVSchid + ')');
    end;

    qReport.SQL.Add(' order by DATE_PAY DESC');
  end
  else
    TimedMessageBox(' Не выбрано ни одного "виртуального" счета!!!', 'Внимание!', mtWarning, [mbOK], mbOK, 15, 3);
end;

end.
