unit uRepPaymentsHist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Data.DB, DBAccess, Ora, MemDS,
  Vcl.Menus, Vcl.ActnList, Vcl.ExtCtrls, sBevel, Vcl.StdCtrls, sComboBox,
  sGauge, sEdit, sListBox, sCheckListBox, Vcl.Buttons, sSpeedButton, sLabel,   TimedMsgBox,
  sPanel, sScrollBox, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, sStatusBar,
  sSplitter, sBitBtn;

type
  TRepPaymentsHist = class(TRepFrm)
    qSQL_TEMP: TOraQuery;
    DateTimeField1: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    cbPeriodAfter: TsComboBox;
    qSQL_TEMPPAYER_BIK: TFloatField;
    qSQL_TEMPVIRTUAL_ACCOUNT_ID: TFloatField;
    qReportPAYMENT_ID: TFloatField;
    qReportVIRTUAL_ACCOUNT_ID: TFloatField;
    qReportINN: TStringField;
    qReportDATE_PAY: TDateTimeField;
    qReportSUM_PAY: TFloatField;
    qReportDOC_NUMBER: TStringField;
    qReportPAYMENT_PURPOSE: TStringField;
    qReportUSER_CREATED: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportPAYMENT_FILE_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportPAYER_BIK: TFloatField;
    qReportPAYMANT_ID_HIST: TFloatField;
    qReportSTATE: TStringField;
    qReportVIRTUAL_ACCOUNTS_NAME: TStringField;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    qReportUSER_LAST_UPDATED_FIO: TStringField;
    qReportDATE_LAST_UPDATED_: TDateTimeField;
    qReportFILE_NAME: TStringField;
    OQ: TOraQuery;
    qReportHIST_DATE_CREATED: TDateTimeField;
    qReportPHONE_ID: TStringField;
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
    pPAYMENT_ID : Variant;
  end;

var
  RepPaymentsHist: TRepPaymentsHist;

implementation

{$R *.dfm}

uses uShowAnotherVirt_Ac, ChildFrm;



procedure TRepPaymentsHist.aRefreshExecute(Sender: TObject);
var
  cbPeriodAfterItemIndex : Integer;
  cbPeriodItemIndex : Integer;
begin

  //делаем проверку на случай незаданных индексов
  if cbPeriodAfter.ItemIndex > -1 then
    cbPeriodAfterItemIndex := integer(cbPeriodAfter.Items.Objects[cbPeriodAfter.ItemIndex])
  else
    cbPeriodAfterItemIndex := -1;

  if cbPeriod.ItemIndex > -1 then
    cbPeriodItemIndex := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    cbPeriodItemIndex := -1;


  if cbPeriodAfterItemIndex < cbPeriodItemIndex then
     TimedMessageBox('Неверно выбраны даты периода - ' +chr(10)+chr(13) +  'дата окончания периода должна быть больше или равна дате начала периода!',
      'Пожалуйста, будьте внимательны!', mtConfirmation,[mbOk], mbOK, 10, 3)
  else
    inherited;
end;

procedure TRepPaymentsHist.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  CLB_VirtAccs := True;
  cb_Period   := True;
  pPAYMENT_ID := null;
  //VIRTUAL_ACCOUNTS_NAME
  CRGrid.Columns[3].Width := 150;
  //PAYMENT_PURPOSE
  CRGrid.Columns[9].Width := 150;

  for I := 0 to cbPeriod.Items.Count - 1 do
    cbPeriodAfter.Items.AddObject(cbPeriod.Items.Strings[i] , cbPeriod.Items.Objects[i]);

  OQ.Close;
  OQ.SQL.Clear;
  OQ.SQL.Text := 'SELECT YEAR_MONTH_NAME from V_PERIODS where YEAR_MONTH =(select min(ph.YEAR_MONTH) FROM PAYMANTS_HIST ph)';
  OQ.Open;

  if Trim(OQ.FieldByName('YEAR_MONTH_NAME').AsString)<> '' then
    cbPeriod.ItemIndex := cbPeriod.Items.IndexOf(Trim(OQ.FieldByName('YEAR_MONTH_NAME').AsString))
  else
    cbPeriod.ItemIndex :=  cbPeriod.Items.Count - 1;



  OQ.Close;
  OQ.SQL.Clear;
  OQ.SQL.Text := 'SELECT YEAR_MONTH_NAME from V_PERIODS where YEAR_MONTH =(select max(ph.YEAR_MONTH) FROM PAYMANTS_HIST ph)';
  OQ.Open;
  cbPeriodAfter.ItemIndex := cbPeriodAfter.Items.IndexOf(Trim(OQ.FieldByName('YEAR_MONTH_NAME').AsString));

  Name_File_Excel := Caption;
  Zagolovok_Excel := Name_File_Excel;
end;

procedure TRepPaymentsHist.FormShow(Sender: TObject);
begin
  inherited;
  cbPeriod.Left := 434;
end;

procedure TRepPaymentsHist.qReportBeforeOpen(DataSet: TDataSet);
begin
  //inherited;
  if FVSchid <> '' then
  begin
    qReport.SQL.Clear;
    qReport.SQL := qSQL_TEMP.SQL;

    qReport.ParamByName('PAYMENT_ID').Value :=  pPAYMENT_ID;
    qReport.ParamByName('year_month_start').Value := YEAR_MONTH;

    if cbPeriodAfter.ItemIndex >= 0 then
      qReport.ParamByName('year_month_end').Value := integer(cbPeriodAfter.Items.Objects[cbPeriodAfter.ItemIndex])
    else
      qReport.ParamByName('year_month_end').Value := -1;


    if VSch_count <> CLB_VirtAcc.Items.Count  then
    begin
      if (VSch_count = 1) then
      begin
        qReport.SQL.Add(' and ph.VIRTUAL_ACCOUNT_ID = :VIRTUAL_ACCOUNT_ID');
        qReport.ParamByName('VIRTUAL_ACCOUNT_ID').Value := StrToInt(FVSchid);
      end
      else
       qReport.SQL.Add(' and ph.VIRTUAL_ACCOUNT_ID in (' + FVSchid + ')');
    end;

    qReport.SQL.Add(' order by ph.HIST_DATE_CREATED ASC');
  end
  else
    TimedMessageBox(' Не выбрано ни одного "виртуального" счета!!!', 'Внимание!', mtWarning, [mbOK], mbOK, 15, 3);
end;

end.
