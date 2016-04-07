unit RepCalcBalance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, sListBox,
  sCheckListBox, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, CRGrid,    IntecExportGrid,
  Vcl.ActnList, Data.DB, MemDS, DBAccess, Ora, Vcl.Samples.Gauges, Vcl.ComCtrls;

type
  TRepCalcBalanceFRM = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    cbPeriod: TComboBox;
    CB_cancel: TCheckBox;
    Label1: TLabel;
    CLB_Accounts: TsCheckListBox;
    lAccount: TLabel;
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    DSCalcBaance: TDataSource;
    QCalcBalance: TOraQuery;
    CB_Credit: TCheckBox;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    CBRefresh: TCheckBox;
    Lb_daterep: TLabel;
    Timer2: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CB_cancelClick(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    procedure CalcBalance;
    procedure SHOW_ProgressBar;
    procedure SHOW_LastDateRep;
    procedure SHOW_Report;
  end;


  procedure DoRepCalcBalance;




var
  RepCalcBalanceFRM: TRepCalcBalanceFRM;
  record_count : integer;
session_id : integer;
last_date_rep : TDateTime;
last_session_id : integer;

FAccid : string;
FAccount : string;
fShowOne : integer;

implementation
uses DMUnit, ShowUserStat, ContractsRegistration_Utils, ExportGridToExcelPDF;

{$R *.dfm}

procedure DoRepCalcBalance;
        var ReportFrm  : TRepCalcBalanceFRM;

begin
  ReportFrm := TRepCalcBalanceFRM.Create(Nil);
  DM.qPeriods.Close;
 with DM.qPeriods do
 begin
                try
                  sql.Clear;
                   //19610
                  sql.Add (' select distinct YEAR_MONTH, substr(YEAR_MONTH,5,2)||'' - ''||substr(YEAR_MONTH,1,4) as YEAR_MONTH_NAME');
                  sql.Add (' from db_loader_account_phones ul order by YEAR_MONTH desc');
                   ExecSQL;
                   Open;

                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.text, mtError, [mbOK], 0);
                end;
        end;

    while not DM.qPeriods.EOF do
    begin

      ReportFrm.cbPeriod.Items.AddObject(
      DM.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
      TObject(DM.qPeriods.FieldByName('YEAR_MONTH').Asinteger)
        );
      DM.qPeriods.Next;
    end;
    DM.qPeriods.Close;

 if ReportFrm.cbPeriod.Items.Count > 0       then
      ReportFrm.cbPeriod.ItemIndex := 0;
       ReportFrm.lAccount.Show;
             ReportFrm.CLB_Accounts.Show;
             DM.qAccounts.Open;
             ReportFrm.CLB_Accounts.Items.AddObject(
          'Все',
          Pointer(-1)
          );
      while not DM.qAccounts.EOF do
      begin
        ReportFrm.CLB_Accounts.Items.AddObject(
          DM.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(DM.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        DM.qAccounts.Next;
      end;
      DM.qAccounts.Close;
end;

procedure TRepCalcBalanceFRM.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
  if    FAccid<>'-1'  then
//    ExportDBGridToExcel('Отчёт виртуальных балансов ' + cbPeriod.Text+' по л/с :'+ Faccount ,'', grData, False);
      ExportDBGrid('Отчёт виртуальных балансов ' + cbPeriod.Text+' по л/с :'+ Faccount ,'','Виртуальные балансы '+cbPeriod.Text, grData, True,True);
  if    FAccid='-1'  then
//   ExportDBGridToExcel('Отчёт виртуальных балансов ' + cbPeriod.Text,'', grData, False);
     ExportDBGrid('Отчёт виртуальных балансов ' + cbPeriod.Text,'','Виртуальные балансы '+cbPeriod.Text, grData, True,True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TRepCalcBalanceFRM.aRefreshExecute(Sender: TObject);
begin
//CalcBalance;
 SHOW_ProgressBar;
end;

procedure TRepCalcBalanceFRM.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qCalcBalance.Active and (qCalcBalance.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qCalcBalance.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TRepCalcBalanceFRM.cbPeriodChange(Sender: TObject);
var
  Period : integer;
begin
if cbPeriod.ItemIndex >= 0 then
    Period := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
end;

procedure TRepCalcBalanceFRM.CB_cancelClick(Sender: TObject);
var i : integer;
begin
if CB_cancel.Checked=True then
begin
    for i := 0 to CLB_Accounts.Items.Count - 1 do  begin
    CLB_ACCOUNTS.Checked[i]:=false;
    FAccid:='-2';
    end;
end;
end;

procedure TRepCalcBalanceFRM.CLB_AccountsClick(Sender: TObject);
var i : integer;
begin
      if (CLB_Accounts.Checked[0]=true) then begin
       //for i := 1 to CLB_Accounts.Items.Count - 1 do
       //CLB_Accounts.Checked[i]:=true;
       FAccid:='-1';
      end;
      if (CLB_Accounts.Checked[0]=false) then FAccid:='';
      CB_cancel.Checked:=False;
end;

procedure TRepCalcBalanceFRM.CLB_AccountsClickCheck(Sender: TObject);
var i,j : integer;
begin
  for i := 1 to CLB_Accounts.Items.Count - 1 do
  begin
    if (CLB_Accounts.Checked[0]=true) and (CLB_Accounts.Checked[i]=false) then begin
      FAccid:='';
      FAccount:='';
    end;
    if clb_Accounts.Selected[0]=TRUE then
    begin
      if (CLB_Accounts.Checked[0]=true) then
      begin
        for j := 1 to CLB_Accounts.Items.Count - 1 do
          CLB_Accounts.Checked[j]:=true;
        FAccid:='-1';
      end;
      if (CLB_Accounts.Checked[0]=false) then
      begin
        for j := 1 to CLB_Accounts.Items.Count - 1 do
          CLB_Accounts.Checked[j]:=false;
        //ShowMessage('Заглушка');
        FAccid:='';
      end;
    end;
  end;
      {FAccount:=FAccount+CLB_Accounts.Items[CLB_Accounts.ItemIndex];  }
end;

procedure TRepCalcBalanceFRM.CLB_AccountsExit(Sender: TObject);
var i: integer;
    s : String;
    CheckAll : boolean;
begin
  FAccid:='';
  FAccount:='';
  CheckAll:=true;
  for i := 1 to CLB_Accounts.Items.Count - 1 do
    if CLB_Accounts.Checked[i] then
    begin
      FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
     // FAccount:=FAccount+CLB_Accounts.Items[CLB_Accounts.ItemIndex]+',';
      FAccount:=FAccount+CLB_Accounts.Items[i]+',';
    end else
      CheckAll:=false;
  if FAccid<>'-1' then
  begin
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
    FAccount:=copy(FAccount,1,Length(FAccount)-1);
  end;
  if (CLB_Accounts.Checked[0]=true) and CheckAll then
  begin
    FAccid:='-1';
    FAccount:='-1';
  end;
end;

procedure TRepCalcBalanceFRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRepCalcBalanceFRM.FormCreate(Sender: TObject);
begin
FAccid:='-2';
fShowOne:=0;
CB_Credit.Visible:=(GetConstantValue('SERVER_NAME')='CORP_MOBILE');
SHOW_LastDateRep;
end;

procedure TRepCalcBalanceFRM.CalcBalance;
var sql_text   : string;
    YEAR_MONTH : integer;
begin
if FAccid='-2' then
begin

if fShowOne=1 then
   MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
 fShowOne:=1;
 exit;
end;

if cbPeriod.ItemIndex >= 0 then
    YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    YEAR_MONTH := -1;

qCalcBalance.Close;
 with qCalcBalance do
              begin
                try
                  sql.Clear;
                   if CB_Credit.Checked=true then
                  sql.Add (' select t1.phone_number,nvl(v.IS_CREDIT_CONTRACT,0) as kr_av, ');
                   if (CB_Credit.Checked=false) then
                   begin
                   if (ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE')  then
                    sql.Add (' select t1.phone_number,0 as kr_av, ')
                   else   sql.Add (' select t1.phone_number, ')
                   end;


                  sql.Add (' t1.pcharges, t1.pabon, t1.pusl, t1.pbills, t1.pbill_ab, t1.pbill_usl, t1.pbalance, t1.pabon_be,  ');
                  sql.Add (' t1.pbill_ab_be, t1.pabon_bl_be, (nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0)) ,');
                  if CB_Credit.Checked=true then
                  sql.Add (' nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0) - nvl(v.IS_CREDIT_CONTRACT,0) * (nvl(t1.pbill_ab,0) - nvl(t1.pbill_usl,0)) ');
                   if CB_Credit.Checked=false then
                  sql.Add (' nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0) - 0 * (nvl(t1.pbill_ab,0) - nvl(t1.pbill_usl,0)) ');
                  sql.Add ('  from (select fb.phone_number,t.pcharges,t.pabon,t.pusl,t.pbills,t.pbill_ab,t.pbill_usl,t.pbalance, ');
                  sql.Add ('  t.pabon_be,t.pbill_ab_be,t.pabon_bl_be');
                  sql.Add (' from db_loader_full_finance_bill fb,');
                  sql.Add (' TABLE(Balance.CALC_BALANCE_STAT_BY_YM(fb.phone_number,');
                  sql.Add (' last_day(to_date(fb.YEAR_MONTH,');
                  sql.Add ('   ''yyyymm'')),');
                  sql.Add (' fb.YEAR_MONTH)) t');
                  if FAccid<>'-1' then
                  sql.Add (' where fb.ACCOUNT_ID in( '+FAccid+') ');
                  if FAccid='-1' then
                  sql.Add (' where 1=1 ');
                  sql.Add (' and fb.YEAR_MONTH = '''+IntToStr(YEAR_MONTH)+'''');
                  sql.Add (' and fb.COMPLETE_BILL = 1) t1 ');

             if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE'   then
             begin
                  if CB_Credit.Checked=true then
                  begin
                  sql.Add (' , v_contracts v');
                  sql.Add (' where  v.PHONE_NUMBER_FEDERAL(+)=t1.phone_number');
                  sql.Add (' and (v.CONTRACT_CANCEL_DATE is null or trunc(v.CONTRACT_CANCEL_DATE)>=(to_date('''+IntToStr(YEAR_MONTH)+'01'',''yyyymmdd''))  )');
                  sql.Add (' and nvl(v.IS_CREDIT_CONTRACT,0)=1');
                  end;
             end;

               ExecSQL;
                        Open;
                       // MessageDlg('Текст запроса: '+sql.Text, mtError, [mbOK], 0);
                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
                end;
        end;

        if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE' then  begin
        grData.Columns[0].Title.caption:='Номер телефона';
        grData.Columns[1].Title.caption:='Кредит/аванс';
        grData.Columns[2].Title.caption:='Начисления за период';
        grData.Columns[3].Title.caption:='Абон.плата за период';
        grData.Columns[4].Title.caption:='Услуги за период';
        grData.Columns[5].Title.caption:='Сумма начисления за период из счета';
        grData.Columns[6].Title.caption:='Абон.плата за период из счета';
        grData.Columns[7].Title.caption:='Услуги за период из счета';
        grData.Columns[8].Title.caption:='Баланс';
        grData.Columns[9].Title.caption:='Абон.плата по версии Билайна';
        grData.Columns[10].Title.caption:='Абон.плата из счета';
        grData.Columns[11].Title.caption:='Абон.пл.Билайна за заблок.период';
        grData.Columns[12].Title.caption:='Баланс со счетом';
        grData.Columns[13].Title.caption:='Баланс после выставления, но пока действует кред.';
        end;

        if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')<>'CORP_MOBILE' then  begin
        grData.Columns[0].Title.caption:='Номер телефона';
        grData.Columns[1].Title.caption:='Начисления за период';
        grData.Columns[2].Title.caption:='Абон.плата за период';
        grData.Columns[3].Title.caption:='Услуги за период';
        grData.Columns[4].Title.caption:='Сумма начисления за период из счета';
        grData.Columns[5].Title.caption:='Абон.плата за период из счета';
        grData.Columns[6].Title.caption:='Услуги за период из счета';
        grData.Columns[7].Title.caption:='Баланс';
        grData.Columns[8].Title.caption:='Абон.плата по версии Билайна';
        grData.Columns[9].Title.caption:='Абон.плата из счета';
        grData.Columns[10].Title.caption:='Абон.пл.Билайна за заблок.период';
        grData.Columns[11].Title.caption:='Баланс со счетом';

        end;

end;


procedure TRepCalcBalanceFRM.SHOW_ProgressBar;
var SqlOra : TOraQuery;
    Rep_Progress : Boolean;
    sql_text : string;
    YEAR_MONTH : integer;
begin

if cbPeriod.ItemIndex >= 0 then
    YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    YEAR_MONTH := -1;

  if FAccid='-2' then
begin
  if fShowOne=1 then
   MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
 fShowOne:=1;
 exit;
end;

  SqlOra:=TOraQuery.Create(nil);

// вывод отчета на экран по последней дате
if cbrefresh.Checked=False then
 begin
    StatusBar1.SimpleText:='Процесс вывода данных для отчета';
    //вызов вывода отчета - запроcом через кверю
    SHOW_Report;

end;

 // формирование отчета с пересбором данных
if cbrefresh.Checked=True then  begin

StatusBar1.Color:=clBtnFace;
Rep_Progress:=True;
with SqlOra do
    begin
     // определим сколько джобов запущено по данному процессу
     Close;
     sql.Clear;
     sql.add('select sum(count_jod_work) as count_jod_work, sum(const_job) as const_job from');
     sql.add(' (select count(*) count_jod_work, 0 as const_job from dba_jobs a where a.LOG_USER='''+GetConstantValue('SERVER_NAME')+''' ');
     sql.add(' union all select 0 as count_jod_work, to_number(ms_constants.GET_CONSTANT_VALUE(''TEMP_JOBSBALANCE'')) as const_job  from dual)');

   //  MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
     Execute;

     if round(FieldByName('count_jod_work').AsInteger/FieldByName('const_job').AsInteger+0.5)=2 then
     begin
     Rep_Progress:=False;
     MessageDlg('В данный момент запущено формирование отчета двумя пользователями, попробуйте сформировать отчет позже. ', mtConfirmation, [mbOK], 0);
     end;

    end;

     if Rep_Progress=True then begin

StatusBar1.SimpleText:='Процесс формирования данных для отчета';

with SqlOra do
    begin
      // назначение номера сессии формирования отчета
     Close;
     sql.Clear;
     sql.Text:='select s_session_balnow.nextval as sessionid from dual';
     Execute;
     session_id:=sqlOra.FieldByName('sessionid').AsInteger;
        begin
                  try
                   Close;
                   sql.Clear;
                   if cb_Credit.Checked then
                   sql.Text:='begin balance.virtual_balphone2('+IntToStr(YEAR_MONTH)+','+IntToStr(session_id)+','''+FAccid+''',1); end;'
                   else
                   sql.Text:='begin balance.virtual_balphone2('+IntToStr(YEAR_MONTH)+','+IntToStr(session_id)+','''+FAccid+''',0); end;';

                   Execute;
                  except
                      on e : exception do
                      MessageDlg('Ошибка выполнения balance.virtual_balphone', mtError, [mbOK], 0);
                  end;
            end;

        Close;
        sql.Clear;
        sql.Text:='SELECT count(*) as record_count from virtual_balance_phone where session_id='+IntToStr(session_id);
        Execute;
        record_count:=sqlOra.FieldByName('record_count').AsInteger;
        Gauge1.MaxValue:=record_count;

            // запускаем  джобы на заполнение testdelta_balance
          begin
                  try
                   Close;
                   sql.Clear;
                   sql.Text:='begin balance.virtual_balance_jobs('+IntToStr(session_id)+'); end;';
                   Execute;
                  except
                      on e : exception do
                      MessageDlg('Ошибка выполнения balance.virtual_balance_jobs', mtError, [mbOK], 0);
                  end;
            end;

        end;

        Timer2.Enabled:=true; //запуск таймера

     end;
end;
end;


procedure TRepCalcBalanceFRM.Timer2Timer(Sender: TObject);
var SqlOra : TOraQuery;
   plusPG1 : integer;
   sql_text : string;
begin

SqlOra:=TOraQuery.Create(nil);
with SqlOra do
        begin
        Close;
        sql.Clear;
        sql.add(' select count(*) ncount from virtual_balance where session_id='+IntToStr(session_id)+'' );
        Execute;
        plusPG1:=sqlOra.FieldByName('ncount').AsInteger;
        StatusBar1.SimpleText:='Обработано записей '+inttostr(plusPG1)+' из '+inttostr(Gauge1.MaxValue);
        Gauge1.Progress:= plusPG1;
        close;
        end;

    If (Gauge1.Progress=Gauge1.MaxValue) Then
    begin

    Timer2.Enabled:=False;
    Gauge1.Progress:=0;
    StatusBar1.Color:=clMoneyGreen;
    StatusBar1.SimpleText:='Процесс вывода данных для отчета на экран';

    //вызов вывода отчета - запроом через кверю
         SHOW_Report;

    StatusBar1.SimpleText:='Отчет сформирован';
    SHOW_LastDateRep;
    end;
end;

procedure TRepCalcBalanceFRM.SHOW_LastDateRep;
var SqlOra : TOraQuery;
begin
  SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
    begin
     //
     Close;
     sql.Clear;
     sql.add(' select distinct a.balance_date, a.session_id ');
     sql.add(' from (select max(DATE_REPORT) balance_date, max(session_id) session_id  from virtual_balance) a, ');
     sql.add(' virtual_balance b where b.session_id=a.session_id ');
     sql.add(' and trunc(b.DATE_REPORT)=trunc(a.balance_date) ');
     //  MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
     Execute;
     Lb_daterep.Caption:='Дата последнего отчета '+FieldByName('balance_date').AsString;
     session_id:=FieldByName('session_id').Asinteger;
    end;
end;

procedure TRepCalcBalanceFRM.SHOW_Report;
var SqlOra : TOraQuery;
   YEAR_MONTH : integer;
begin
  if cbPeriod.ItemIndex >= 0
    then YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    else YEAR_MONTH := -1;

  with qCalcBalance do
  begin
    try
      Close;
      sql.Clear;
      if CB_Credit.Checked=true then
        sql.Add (' select to_number(t1.phone_number) as phone_number,nvl(v.IS_CREDIT_CONTRACT,0) as kr_av, ');
      if (CB_Credit.Checked=false) then
      begin
        if (ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE')
          then sql.Add (' select to_number(t1.phone_number) as phone_number,0 as kr_av, ')
          else sql.Add (' select to_number(t1.phone_number) as phone_number, ')
      end;
      sql.Add(' t1.pcharges, t1.pabon, t1.pusl, t1.pbills, t1.pbill_ab, t1.pbill_usl, t1.pbalance, t1.pabon_be,  ');
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE'
        then sql.Add(' t1.pbill_ab_be, t1.pabon_bl_be, '
              +' (nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0)) - t1.PAYMENT_TILL_BILL ')
        else sql.Add(' t1.pbill_ab_be, t1.pabon_bl_be, '
              +' (nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0)) ');
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE' then
      begin
        if CB_Credit.Checked=true then
          sql.Add(', nvl(t1.pbalance,0)-nvl(t1.pcharges,0)+nvl(t1.pbills,0)-t1.PAYMENT_TILL_BILL'
            + ' - nvl(v.IS_CREDIT_CONTRACT,0) * (nvl(t1.pbill_ab,0) - nvl(t1.pbill_usl,0)) ');
        if CB_Credit.Checked=false then
          sql.Add(', nvl(t1.pbalance,0)-nvl(t1.pcharges,0)+nvl(t1.pbills,0)-t1.PAYMENT_TILL_BILL'
            + ' - 0 * (nvl(t1.pbill_ab,0) - nvl(t1.pbill_usl,0)) ');
      end;
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')<>'CORP_MOBILE'   then
        sql.Add (',nvl(t1.pbalance,0)-(nvl(t1.pbalance,0) - nvl(t1.pcharges,0) + nvl(t1.pbills,0)) ');
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE' then
      begin
          sql.Add (', t1.PAYMENT_TILL_BILL, t1.SINGLE_CHANGE_TP, T1.SINGLE_OTHER, t1.IS_ACTIVE ');
          sql.Add (', t1.BILL_CALLS, t1.DETAIL_CALLS, t1.OPTION_CODES, t1.TARIFF_NAME ');
      end;
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')<>'CORP_MOBILE' then
          sql.Add (', t1.IS_ACTIVE, T1.IS_CONTRACT ');

      sql.Add ('  from  virtual_balance t1');
      if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE'   then
      begin
        if CB_Credit.Checked=true then
        begin
          sql.Add (' , v_contracts v');
          sql.Add (' where  v.PHONE_NUMBER_FEDERAL(+)=t1.phone_number');
          sql.Add (' and t1.YEAR_MONTH = '+IntToStr(YEAR_MONTH)+'');
          sql.Add (' and t1.SESSION_ID = '+IntToStr(session_id)+'');
          sql.Add (' and (v.CONTRACT_CANCEL_DATE is null or trunc(v.CONTRACT_CANCEL_DATE)>=(to_date('''+IntToStr(YEAR_MONTH)+'01'',''yyyymmdd''))  )');
          sql.Add (' and nvl(v.IS_CREDIT_CONTRACT,0)=1');
        end;
      end;
      if CB_Credit.Checked=false then
      begin
      sql.Add (' where 1=1 ');
      sql.Add (' and t1.YEAR_MONTH = '+IntToStr(YEAR_MONTH)+'');
      sql.Add (' and t1.SESSION_ID = '+IntToStr(session_id)+'');
      end;
      ExecSQL;
      Open;
      //   MessageDlg('Текст запроса: '+sql.Text, mtError, [mbOK], 0);
    except
      on e : exception do
      MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;
  end;

  if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')='CORP_MOBILE' then
  begin
    grData.Columns[0].Title.caption:='Номер телефона';
    grData.Columns[1].Title.caption:='Кредит/аванс';
    grData.Columns[2].Title.caption:='Начисления за период';
    grData.Columns[3].Title.caption:='Абон.плата за период';
    grData.Columns[4].Title.caption:='Услуги за период';
    grData.Columns[5].Title.caption:='Сумма начисления за период из счета';
    grData.Columns[6].Title.caption:='Абон.плата за период из счета';
    grData.Columns[7].Title.caption:='Услуги за период из счета';
    grData.Columns[8].Title.caption:='Баланс';
    grData.Columns[9].Title.caption:='Абон.плата по версии Билайна';
    grData.Columns[10].Title.caption:='Абон.плата из счета';
    grData.Columns[11].Title.caption:='Абон.пл.Билайна за заблок.период';
    grData.Columns[12].Title.caption:='Баланс со счетом';
    grData.Columns[13].Title.caption:='Баланс после выставления, но пока действует кред.';
    grData.Columns[14].Title.caption:='Платежи до счета';
    grData.Columns[15].Title.caption:='Смена ТП';
    grData.Columns[16].Title.caption:='Прочие выплаты';
    grData.Columns[17].Title.caption:='Акт/Бл.';
    grData.Columns[18].Title.caption:='Звонки по счету';
    grData.Columns[19].Title.caption:='Звонки по расш.';
    grData.Columns[20].Title.caption:='Коды услуг';
    grData.Columns[20].Width:=200;
    grData.Columns[21].Title.caption:='Коды ТП';
    grData.Columns[21].Width:=200;
  end;

  if ContractsRegistration_Utils.GetConstantValue('SERVER_NAME')<>'CORP_MOBILE' then
  begin
    grData.Columns[0].Title.caption:='Номер телефона';
    grData.Columns[1].Title.caption:='Начисления за период из расш.баланса';
    grData.Columns[2].Title.caption:='Абон.плата за период из расш.баланса';
    grData.Columns[3].Title.caption:='Услуги за период из расш.баланса';
    grData.Columns[4].Title.caption:='Сумма начисления за период из счета';
    grData.Columns[5].Title.caption:='Абон.плата за период из счета';
    grData.Columns[6].Title.caption:='Услуги за период из счета';
    grData.Columns[7].Title.caption:='Баланс';
    grData.Columns[8].Title.caption:='Абон.плата по версии Билайна';
    grData.Columns[9].Title.caption:='Абон.плата из счета';
    grData.Columns[10].Title.caption:='Абон.пл.Билайна за заблок.период';
    grData.Columns[11].Title.caption:='Баланс со счетом';
    grData.Columns[12].Title.caption:='Разница Балансов';
    grData.Columns[13].Title.caption:='Акт/Бл.';
    grData.Columns[14].Title.caption:='Наличие контракта';
  end;

end;

end.
