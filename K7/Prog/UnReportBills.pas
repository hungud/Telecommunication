unit UnReportBills;

interface

uses ComObj, ActiveX,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, MemDS, DBAccess, Ora, Vcl.ActnList,
  Vcl.Grids, Vcl.DBGrids, CRGrid, IntecExportGrid, VirtualTable, sListBox,
  sCheckListBox, Vcl.ExtDlgs ;

type
  TfrmReportBills = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    ActionList1: TActionList;
    aRefresh: TAction;
    qRef: TOraQuery;
    dsqRef: TDataSource;
    CRDBGrid2: TCRDBGrid;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    cbPeriod2: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    qPeriods2: TOraQuery;
    dsQ2: TDataSource;
    aRefresh2: TAction;
    vtReport: TVirtualTable;
    vtReportPHONE_NUMBER: TStringField;
    vtReportBILL_SUM_ORIGIN: TFloatField;
    vtReportBILL_SUM: TFloatField;
    vtReportDISCOUNT_VALUE: TFloatField;
    vtReportDILER_PAYMENT: TFloatField;
    vtReportDILER_PAYMENT_FULL: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_NEW: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_OLD: TFloatField;
    vtReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField;
    vtReportOPTION_COST_DILER: TFloatField;
    vtReportOPTION_COST_FULL: TFloatField;
    vtReportTARIFF_NAME: TStringField;
    vtReportOPTION_COST_DILER_BEELINE: TFloatField;
    vtReportTAIL: TFloatField;
    vtReportDILER_FULL_SUM: TFloatField;
    vtReportBEELINE_FULL_SUM: TFloatField;
    vtReportDILER_ITOG_SUM: TFloatField;
    vtReportCHECK_LONG_PLUS_BALANCE2: TStringField;
    vtReportINSTALLMENT_PAYMENT_SUM: TFloatField;
    vtReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField;
    dsReport: TDataSource;
    grData: TCRDBGrid;
    qReport: TOraQuery;
    qReportPHONE_NUMBER: TStringField;
    qReportBILL_SUM_ORIGIN: TFloatField;
    qReportBILL_SUM: TFloatField;
    qReportDISCOUNT_VALUE: TFloatField;
    qReportDILER_PAYMENT: TFloatField;
    qReportDILER_PAYMENT_FULL: TFloatField;
    qReportSUBSCRIBER_PAYMENT_NEW: TFloatField;
    qReportSUBSCRIBER_PAYMENT_OLD: TFloatField;
    qReportSUBSCRIBER_PAYMENT_ADD_OLD: TFloatField;
    qReportOPTION_COST_DILER: TFloatField;
    qReportOPTION_COST_FULL: TFloatField;
    qReportTARIFF_NAME: TStringField;
    qReportOPTION_COST_DILER_BEELINE: TFloatField;
    qReportTAIL: TFloatField;
    qReportDILER_FULL_SUM: TFloatField;
    qReportBEELINE_FULL_SUM: TFloatField;
    qReportDILER_ITOG_SUM: TFloatField;
    qReportCHECK_LONG_PLUS_BALANCE2: TStringField;
    qReportINSTALLMENT_PAYMENT_SUM: TFloatField;
    qReportDILER_SUMM_OLD_MONTH_IN_MINUS: TFloatField;
    vtReportMARJA_ABONKI: TFloatField;
    qReportMARJA_ABONKI: TFloatField;
    Label3: TLabel;
    BitBtn5: TBitBtn;
    Label4: TLabel;
    BitBtn6: TBitBtn;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    Memo2: TMemo;
    q2: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure aRefresh2Execute(Sender: TObject);
    procedure cbPeriod2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure pLoadExcelToCheckList (PMemo:TMemo);
    function fGetNumbersList (PMemo:TMemo):ansistring;
  end;

procedure DoShowReportBills;

implementation

{$R *.dfm}

procedure DoShowReportBills;
var frmReportBills: TfrmReportBills;
begin
  frmReportBills:=TfrmReportBills.Create(Nil);
  try
    frmReportBills.ShowModal;
  finally
    FreeAndNil(frmReportBills);
  end;
end;

function TfrmReportBills.fGetNumbersList (PMemo:TMemo):ansistring;
var vRes : ansistring; i:integer;
begin
  vRes := '';
  for I := 0 to PMemo.Lines.Count-1 do
    if i=0 then
      vRes := ''''+PMemo.Lines[i]+''''
    else
      vRes := vRes+','''+PMemo.Lines[i]+'''';
  Result:=vRes;
end;

procedure TfrmReportBills.pLoadExcelToCheckList (PMemo:TMemo);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i: Integer;
  datecheck: string;
begin
  if OpenDialog1.Execute then
  begin
  //  PMemo.Enabled:=True;
    PMemo.Visible:=False;
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(OpenDialog1.FileName);
    i := 1;
    while (VarToStr(Excel.Cells[i, 1]) <> '') do
    begin
      PMemo.Lines.Append( VarToStr(Excel.Cells[i, 1]) );
      Inc(i);
    end;
    Excel.Quit;
    Excel := Unassigned;
    PMemo.SelStart:=1;
    PMemo.Visible:=True;
  //  PMemo.Enabled:=False;
  end;
end;

procedure TfrmReportBills.aRefresh2Execute(Sender: TObject);
var Period : Integer; vAccStr, vSQLstr :ansistring;
const cSQL = 'select q.*,  '+
        '   (case when (( q.start_balance > q.prev_abon_sum ) and '+
        '               MONTHS_BETWEEN(to_date(q.year_month,''yyyymm''),q.contract_date)<=q.tariff_srok) '+
        '   then '+
        '     ( q.SUBSCRIBER_PAYMENT_NEW - q.start_balance ) '+
        '   else '+
        '     ( q.SUBSCRIBER_PAYMENT_NEW ) '+
        '   end) as abonMstart, '+
        '   (case when (( q.start_balance > q.prev_abon_sum ) and '+
        '               MONTHS_BETWEEN(to_date(q.year_month,''yyyymm''),q.contract_date)<=q.tariff_srok) '+
        '   then   '+
        '     ''Соответствует периодам выплат''   '+
        '   else   '+
        '     ''Закончены периоды выплат''  '+
        '   end) as abonMstartSTR  '+
        '   from   '+
        '   ( select tt.* ,  '+
        '     nvl((select sum(SUBSCRIBER_PAYMENT_NEW) from V_BILL_FOR_DILER_V1 t1 where t1.PHONE_NUMBER=tt.PHONE_NUMBER     '+
        '              and t1.year_month >= to_number(to_char(tt.contract_date, ''yyyymm''))   '+
        '              and t1.year_month <= to_number(to_char(add_months(tt.contract_date, tt.tariff_srok), ''yyyymm''))  '+
        '              and t1.year_month <= to_number(to_char(ADD_MONTHS(to_date(tt.year_month,''YYYYMM''),-1),''YYYYMM''),''999999'') '+
        '         ), 0) as prev_abon_sum  '+
        '     from   '+
        '   ( select t.*,  '+
        '       (DILER_PAYMENT+SUBSCRIBER_PAYMENT_OLD+OPTION_COST_DILER_BEELINE) as CLC_FLD1, '+
        '       (SUBSCRIBER_PAYMENT_NEW-SUBSCRIBER_PAYMENT_OLD) as MARJA_ABONKI, '+
        '        case when  '+
        '          nvl((select tar.tariff_code from v_contracts c, tariffs tar '+
        '            where c.phone_number_federal=t.phone_number and c.CONTRACT_CANCEL_DATE is  null and c.TARIFF_ID=tar.tariff_id '+
        '            and c.contract_date=( Select max(c1.contract_date)  '+
        '                        from v_contracts c1 where c1.phone_number_federal= c.phone_number_federal  '+
        '                        and c1.CONTRACT_CANCEL_DATE is  null group by c1.phone_number_federal) '+
        '            ),'''') like ''FIVIP%'' then 6  else 4 end as tariff_srok  ,  '+
        '        (select c.contract_date from v_contracts c  '+
        '            where c.phone_number_federal=t.phone_number and c.CONTRACT_CANCEL_DATE is  null  '+
        '            and c.contract_date=( Select max(c1.contract_date) '+
        '                        from v_contracts c1 where c1.phone_number_federal= c.phone_number_federal '+
        '                        and c1.CONTRACT_CANCEL_DATE is  null group by c1.phone_number_federal)  '+
        '            ) as contract_date , '+
        '        (select c.start_balance from v_contracts c  '+
        '            where c.phone_number_federal=t.phone_number and c.CONTRACT_CANCEL_DATE is  null  '+
        '            and c.contract_date=( Select max(c1.contract_date) '+
        '                        from v_contracts c1 where c1.phone_number_federal= c.phone_number_federal  '+
        '                        and c1.CONTRACT_CANCEL_DATE is  null group by c1.phone_number_federal)  '+
        '            ) as start_balance '+
        '       from V_BILL_FOR_DILER_V1 t  '+
        '       where year_month=####  '+
    '  ) tt  ) q ';
begin
  q2.DisableControls;
  try
    q2.Close;
    q2.SQL.Clear;
    q2.Params.Clear;
    if cbPeriod2.ItemIndex >= 0 then
      Period := Integer(cbPeriod2.Items.Objects[cbPeriod2.ItemIndex])
    else
      Period := -1;
    if Memo2.Lines.Count=0 then
    begin
      vSQLstr := StringReplace(cSQL,'####',''''+inttostr(Period)+'''',[rfReplaceAll, rfIgnoreCase]);
    end else begin
      vAccStr:=fGetNumbersList(Memo2);
      vSQLstr := StringReplace(cSQL,'####',''''+inttostr(Period)+''' and (t.PHONE_NUMBER) in ('+vAccStr+') ',[rfReplaceAll, rfIgnoreCase]);
    end;
    vSQLstr := StringReplace(vSQLstr,'    ',' ',[rfReplaceAll, rfIgnoreCase]);
    vSQLstr := StringReplace(vSQLstr,'   ',' ',[rfReplaceAll, rfIgnoreCase]);
    q2.SQL.Text := StringReplace(vSQLstr,'  ',' ',[rfReplaceAll, rfIgnoreCase]);
    q2.Open;
    q2.First;
    if q2.Eof then ;
  finally
    q2.EnableControls;
  end;
end;

{
var BillSumMax: double;
begin
  BillSumMax:=0;
  qReport.Close;
  qReport.Open;
  qReport.First;
  vtReport.Clear;
  vtReport.Open;
  while not qReport.Eof do
  begin
    if qReportPHONE_NUMBER.AsString=vtReportPHONE_NUMBER.AsString then
    begin
      vtReport.Edit;
      vtReportBILL_SUM_ORIGIN.AsFloat:=
        vtReportBILL_SUM_ORIGIN.AsFloat+qReportBILL_SUM_ORIGIN.AsFloat;
      if BillSumMax<qReportBILL_SUM_ORIGIN.AsFloat then
        BillSumMax:=qReportBILL_SUM_ORIGIN.AsFloat;
      vtReportBILL_SUM.AsFloat:=vtReportBILL_SUM.AsFloat+qReportBILL_SUM.AsFloat;
      vtReportDISCOUNT_VALUE.AsFloat:=
        vtReportDISCOUNT_VALUE.AsFloat+qReportDISCOUNT_VALUE.AsFloat;
      vtReportDILER_PAYMENT.AsFloat:=
        vtReportDILER_PAYMENT.AsFloat+qReportDILER_PAYMENT.AsFloat;
      vtReportDILER_PAYMENT_FULL.AsFloat:=
        vtReportDILER_PAYMENT_FULL.AsFloat+qReportDILER_PAYMENT_FULL.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat+qReportSUBSCRIBER_PAYMENT_NEW.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat+qReportSUBSCRIBER_PAYMENT_OLD.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat:=
        vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat+qReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat;
      vtReportOPTION_COST_DILER.AsFloat:=
        vtReportOPTION_COST_DILER.AsFloat+qReportOPTION_COST_DILER.AsFloat;
      vtReportOPTION_COST_FULL.AsFloat:=
        vtReportOPTION_COST_FULL.AsFloat+qReportOPTION_COST_FULL.AsFloat;
      if BillSumMax=qReportBILL_SUM_ORIGIN.AsFloat then
        vtReportTARIFF_NAME.AsString:=qReportTARIFF_NAME.AsString;
      vtReportOPTION_COST_DILER_BEELINE.AsFloat:=
        vtReportOPTION_COST_DILER_BEELINE.AsFloat+qReportOPTION_COST_DILER_BEELINE.AsFloat;
      vtReportTAIL.AsFloat:=vtReportTAIL.AsFloat+qReportTAIL.AsFloat;
      vtReportDILER_FULL_SUM.AsFloat:=
        vtReportDILER_FULL_SUM.AsFloat+qReportDILER_FULL_SUM.AsFloat;
      vtReportBEELINE_FULL_SUM.AsFloat:=
        vtReportBEELINE_FULL_SUM.AsFloat+qReportBEELINE_FULL_SUM.AsFloat;
      vtReportDILER_ITOG_SUM.AsFloat:=
        vtReportDILER_ITOG_SUM.AsFloat+qReportDILER_ITOG_SUM.AsFloat;
      if (vtReportCHECK_LONG_PLUS_BALANCE2.AsString='+')
          or (qReportCHECK_LONG_PLUS_BALANCE2.AsString='+') then
        vtReportCHECK_LONG_PLUS_BALANCE2.AsString:='+'
      else
        vtReportCHECK_LONG_PLUS_BALANCE2.AsString:='-';
      vtReportINSTALLMENT_PAYMENT_SUM.AsFloat:=
        vtReportINSTALLMENT_PAYMENT_SUM.AsFloat+qReportINSTALLMENT_PAYMENT_SUM.AsFloat;
      vtReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat:= qReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat;
      vtReportMARJA_ABONKI.AsFloat:=qReportMARJA_ABONKI.AsFloat;
      vtReport.Post;
    end
    else
    begin
      vtReport.Append;
      vtReportPHONE_NUMBER.AsString:= qReportPHONE_NUMBER.AsString;
      vtReportBILL_SUM_ORIGIN.AsFloat:= qReportBILL_SUM_ORIGIN.AsFloat;
      BillSumMax:=qReportBILL_SUM_ORIGIN.AsFloat;
      vtReportBILL_SUM.AsFloat:= qReportBILL_SUM.AsFloat;
      vtReportDISCOUNT_VALUE.AsFloat:= qReportDISCOUNT_VALUE.AsFloat;
      vtReportDILER_PAYMENT.AsFloat:= qReportDILER_PAYMENT.AsFloat;
      vtReportDILER_PAYMENT_FULL.AsFloat:= qReportDILER_PAYMENT_FULL.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_NEW.AsFloat:= qReportSUBSCRIBER_PAYMENT_NEW.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_OLD.AsFloat:= qReportSUBSCRIBER_PAYMENT_OLD.AsFloat;
      vtReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat:= qReportSUBSCRIBER_PAYMENT_ADD_OLD.AsFloat;
      vtReportOPTION_COST_DILER.AsFloat:= qReportOPTION_COST_DILER.AsFloat;
      vtReportOPTION_COST_FULL.AsFloat:= qReportOPTION_COST_FULL.AsFloat;
      vtReportTARIFF_NAME.AsString:= qReportTARIFF_NAME.AsString;
      vtReportOPTION_COST_DILER_BEELINE.AsFloat:= qReportOPTION_COST_DILER_BEELINE.AsFloat;
      vtReportTAIL.AsFloat:= qReportTAIL.AsFloat;
      vtReportDILER_FULL_SUM.AsFloat:= qReportDILER_FULL_SUM.AsFloat;
      vtReportBEELINE_FULL_SUM.AsFloat:= qReportBEELINE_FULL_SUM.AsFloat;
      vtReportDILER_ITOG_SUM.AsFloat:= qReportDILER_ITOG_SUM.AsFloat;
      vtReportCHECK_LONG_PLUS_BALANCE2.AsString:= qReportCHECK_LONG_PLUS_BALANCE2.AsString;
      vtReportINSTALLMENT_PAYMENT_SUM.AsFloat:=qReportINSTALLMENT_PAYMENT_SUM.AsFloat;
      vtReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat:= qReportDILER_SUMM_OLD_MONTH_IN_MINUS.AsFloat;
      vtReportMARJA_ABONKI.AsFloat:=qReportMARJA_ABONKI.AsFloat;
      vtReport.Post;
    end;
    qReport.Next;
  end;
end;  }

procedure TfrmReportBills.aRefreshExecute(Sender: TObject);
var Period : Integer; vAccStr:ansistring;
const cSQL = 'SELECT year_month, phone_number, bill_summ, abon_tp, abon_add, '
                  + 'discount, single_payments, single_change_tariff, '
                  + 'single_correction, calls, calls_country, calls_sity, '
                  + 'calls_local, calls_sms_mms, calls_gprs, calls_rus_rpp, '
                  + 'calls_all, rouming_national, rouming_international, '
                  + 'date_created, user_created, date_last_updated, user_last_updated,'
                  + 'BEGIN_YEAR_MONTH, COUNT_FIVIP, SUM_PREV_BILL, bill_summ_without_start_bal'
             + ' FROM V_BILL_TARIFER_FOR_DILER t '
             + 'WHERE T.year_month = ';
begin
  qRef.DisableControls;
  try
    qRef.Close;
    qRef.SQL.Clear;
    if cbPeriod.ItemIndex >= 0 then
      Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    else
      Period := -1;
    if Memo1.Lines.Count=0 then
    begin
      qRef.SQL.Text := cSQL+''''+inttostr(Period)+'''';
    end else begin
      vAccStr:=fGetNumbersList(Memo1);
      qRef.SQL.Text := cSQL+''''+inttostr(Period)+''' and (t.phone_number) in ('+vAccStr+')';
    end;
 //   qRef.Params.CreateParam(ftInteger,'p_year_month',ptInput);
 //   qRef.ParamByName('p_year_month').AsInteger := Period;
    qRef.Open;
  finally
    qRef.EnableControls;
  end;
end;

procedure TfrmReportBills.BitBtn1Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет по дилерам в "Связной" за ' + cbPeriod2.Text ,'',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmReportBills.BitBtn2Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Начисления на основе счета Тарифера за ' + cbPeriod.Text ,'',
      CRDBGrid2, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmReportBills.BitBtn5Click(Sender: TObject);
begin
  pLoadExcelToCheckList(Memo1);
end;

procedure TfrmReportBills.BitBtn6Click(Sender: TObject);
begin
  pLoadExcelToCheckList(Memo2);
end;

procedure TfrmReportBills.cbPeriod2Change(Sender: TObject);
begin
//  aRefresh2.Execute;
end;

procedure TfrmReportBills.cbPeriodChange(Sender: TObject);
begin
//  aRefresh.Execute;
end;

procedure TfrmReportBills.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
  // Период
  qPeriods.Open;
  while not qPeriods.EOF do
  begin
    cbPeriod.Items.AddObject(
      qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
      TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
      );
    qPeriods.Next;
  end;
  qPeriods.Close;
  cbPeriod.ItemIndex := 0;

  qPeriods2.Open;
  while not qPeriods2.EOF do
  begin
    cbPeriod2.Items.AddObject(
      qPeriods2.FieldByName('YEAR_MONTH_NAME').AsString,
      TObject(qPeriods2.FieldByName('YEAR_MONTH').AsInteger)
      );
    qPeriods2.Next;
  end;
  qPeriods2.Close;
  cbPeriod2.ItemIndex := 0;         //
  //
end;

end.
