unit ReportBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora,
  ActnList, StdCtrls, Buttons, IntecExportGrid, ContractsRegistration_Utils,
  sListBox, sCheckListBox, Vcl.ComCtrls, Vcl.Samples.Gauges;

type
  TReportBalanceFrm = class(TForm)
    qReport: TOraQuery;
    DataSource1: TDataSource;
    grData: TCRDBGrid;
    Panel1: TPanel;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    qOperators: TOraQuery;
    cbOperatorNames: TComboBox;
    cbSearch: TCheckBox;
    qAccounts: TOraQuery;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    CLB_Accounts: TsCheckListBox;
    CB_cancel: TCheckBox;
    Timer1: TTimer;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Lb_daterep: TLabel;
    CBRefresh: TCheckBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbOperatorNamesChange(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CB_cancelClick(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure SHOW_Balance;
   procedure SHOW_ProgressBar;
   procedure SHOW_LastDateRep;
  end;

procedure DoReportBalance;

var //SqlAccount : string;
  FAccid : string;
  FAccount : string;
  fShowOne : integer;
  record_count : integer;
  session_id : integer;
  last_date_rep : TDateTime;
  last_session_id : integer;

implementation

{$R *.dfm}

uses ShowUserStat, Main;

procedure DoReportBalance;
var ReportFrm : TReportBalanceFrm;
    Sdvig:INTEGER;
    i: integer;

begin
FAccid:='-2';
  ReportFrm := TReportBalanceFrm.Create(Nil);
  try
    if MainForm.FUseFilialBlockAccess then
    begin
      ReportFrm.qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
       + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
       + 'WHERE V_ABONENT_BALANCES_WITHOUTSORT.ACCOUNT_ID = AC.ACCOUNT_ID)');
      ReportFrm.qAccounts.SQL.Insert(1, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
    end;

    for i:=0 to ReportFrm.grData.Columns.Count-1 do
      if (ReportFrm.grData.Columns[i].FieldName='IS_DISCOUNT')
//          or(ReportFrm.grData.Columns[i].FieldName='ACCOUNT_NUMBER')
      then
        if GetConstantValue('SHOW_CONTRACT_ID_AND_DISCOUNT') = '1' then
          ReportFrm.grData.Columns[i].Visible:=true
        else
          ReportFrm.grData.Columns[i].Visible:=false;

    ReportFrm.cbOperatorNames.Items.Add('Все');
    ReportFrm.qOperators.Open;
    while not ReportFrm.qOperators.EOF do
    begin
      ReportFrm.cbOperatorNames.Items.Add(
        ReportFrm.qOperators.FieldByName('OPERATOR_NAME').AsString
        );
      ReportFrm.qOperators.Next;
    end;
    ReportFrm.qOperators.Close;
    if ReportFrm.cbOperatorNames.Items.Count > 2 then
      ReportFrm.cbOperatorNames.ItemIndex := 2
    else
      if ReportFrm.cbOperatorNames.Items.Count > 0 then
        ReportFrm.cbOperatorNames.ItemIndex := 0;

             ReportFrm.lAccount.Show;
             ReportFrm.CLB_Accounts.Show;
             ReportFrm.qAccounts.Open;
             ReportFrm.CLB_Accounts.Items.AddObject(
          'Все',
          Pointer(-1)
          );
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.CLB_Accounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
    ReportFrm.cbOperatorNamesChange(ReportFrm.cbOperatorNames);

    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;


end;

procedure TReportBalanceFrm.aRefreshExecute(Sender: TObject);
begin
  SHOW_ProgressBar ;
end;

procedure TReportBalanceFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if FAccid <> '-1'  then
      ExportDBGridToExcel('Отчёт о балансе (по действующим договорам) по л/с :'+ Faccount + ' на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        grData, False, True);
    if  FAccid = '-1'  then
      ExportDBGridToExcel('Отчёт о балансе (по действующим договорам) на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        grData, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBalanceFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
  end;
end;

procedure TReportBalanceFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

procedure TReportBalanceFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else
    Account:=0;

  if Account<>0 then
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account
  else
    qReport.ParamByName('ACCOUNT_ID').Clear;
  //  aRefresh.Execute;
end;

procedure TReportBalanceFrm.cbOperatorNamesChange(Sender: TObject);
var
  OperatorName : String;
begin
  if cbOperatorNames.ItemIndex > 0 then
    OperatorName := cbOperatorNames.Items[cbOperatorNames.ItemIndex]
  else
    OperatorName := '';
  qReport.ParamByName('OPERATOR_NAME').AsString := OperatorName;
  //aRefresh.Execute;
end;

procedure TReportBalanceFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportBalanceFrm.CB_cancelClick(Sender: TObject);
var
  i : integer;
begin
  if CB_cancel.Checked=True then
  begin
    for i := 0 to CLB_Accounts.Items.Count - 1 do
    begin
      CLB_ACCOUNTS.Checked[i]:=false;
      FAccid:='-2';
    end;
  end;

end;

procedure TReportBalanceFrm.CLB_AccountsClick(Sender: TObject);
var
  i : integer;
begin

  if (CLB_Accounts.Checked[0]=true) then
  begin
     //for i := 1 to CLB_Accounts.Items.Count - 1 do
    // CLB_Accounts.Checked[i]:=true;
    FAccid:='-1';
  end;

  if (CLB_Accounts.Checked[0]=false) then
    FAccid:='';

  CB_cancel.Checked:=False;

end;

procedure TReportBalanceFrm.CLB_AccountsClickCheck(Sender: TObject);
var
  i,j : integer;
begin

  for i := 1 to CLB_Accounts.Items.Count - 1 do
  begin

    if (CLB_Accounts.Checked[0]=true) and (CLB_Accounts.Checked[i]=false) then
    begin
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

end;

procedure TReportBalanceFrm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
  s : String;
begin

  if FAccid<>'-1' then
  begin
    FAccid:='';
    FAccount:='';
  end;

  for i := 1 to CLB_Accounts.Items.Count - 1 do
    if CLB_Accounts.Checked[i] then
    begin
      FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
      FAccount:=FAccount+CLB_Accounts.Items[CLB_Accounts.ItemIndex]+',';
    end;

  if FAccid<>'-1' then
  begin
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
    FAccount:=copy(FAccount,1,Length(FAccount)-1);
  end;

  if CLB_Accounts.Checked[0] then
  begin
    FAccid:='-1';
    FAccount:='-1';
  end;

end;

procedure TReportBalanceFrm.CLB_AccountsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var xPoint: TPoint;
    xIndex: Integer;
begin
  xPoint.X:=X;
  xPoint.Y:=Y;
  xIndex:=CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then
  begin
    CLB_Accounts.Hint:=CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else
    Application.CancelHint;
end;

procedure TReportBalanceFrm.FormCreate(Sender: TObject);
begin
  FAccid:='-2';
  fShowOne := 1;
  SHOW_LastDateRep;
end;

procedure TReportBalanceFrm.SHOW_Balance;
var
  sql_text   : string;
begin

  if FAccid='-2' then
  begin
    if fShowOne=1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne:=1;
  end
  else
  begin
    qReport.Close;
    try
      qReport.sql.Clear;
       //19610

      sql_text:='SELECT V_ABONENT_BALANCES_WITHOUTSORT.*, t.tariff_code FROM V_ABONENT_BALANCES_WITHOUTSORT, tariffs t ';
      sql_text:=sql_text+' WHERE  ' +#13#10+
      ' V_ABONENT_BALANCES_WITHOUTSORT.tariff_id = t.tariff_Id(+)  AND '+#13#10;
      sql_text:=sql_text+' (:OPERATOR_ID IS NULL  OR V_ABONENT_BALANCES_WITHOUTSORT.OPERATOR_NAME = :OPERATOR_NAME or (:OPERATOR_NAME =''Все''))';
      if FAccid<>'-1'  then
        sql_text:=sql_text+' and ACCOUNT_ID in ('+FAccid+') ';

        if FAccid='-1'  then
          sql_text:=sql_text+' AND ((:ACCOUNT_ID IS NULL)OR(V_ABONENT_BALANCES_WITHOUTSORT.ACCOUNT_ID=:ACCOUNT_ID) or (:ACCOUNT_ID =-1))';

        sql_text:=sql_text+' AND ((:IS_CREDIT IS NULL)OR(NVL(V_ABONENT_BALANCES_WITHOUTSORT.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';
      // MessageDlg('Текст запроса: '+sql_Text, mtError, [mbOK], 0);
       qReport.sql.Add(sql_Text);
       qReport.ExecSQL;
       qReport.Open;

    except
      on e : exception do
        MessageDlg('Ошибка выполнения запроса: '+ qReport.sql.Text, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TReportBalanceFrm.SHOW_LastDateRep;
var
  SqlOra : TOraQuery;
begin

  SqlOra := TOraQuery.Create(nil);
  with SqlOra do
  begin
   //
    Close;
    sql.Clear;
    sql.add(' select distinct a.balance_date, a.session_id, b.comments ');
    sql.add(' from (select max(balance_date) balance_date, max(session_id) session_id  from testbalance_phone1) a, ');
    sql.add(' testbalance_phone1 b, accounts a where b.session_id=a.session_id ');
    sql.add(' and trunc(b.balance_date)=trunc(a.balance_date) ');
    //  MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
    Execute;
    Lb_daterep.Caption:='Дата последнего отчета '+FieldByName('balance_date').AsString;
    session_id:=FieldByName('session_id').Asinteger;
  end;
end;


procedure TReportBalanceFrm.SHOW_ProgressBar;
var
  SqlOra : TOraQuery;
  Rep_Progress : Boolean;
  sql_text : string;
begin

  if FAccid='-2' then
  begin
    if fShowOne = 1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne := 1;
    exit;
  end;

  SqlOra := TOraQuery.Create(nil);

  // вывод отчета на экран по последней дате
  if cbrefresh.Checked=False then
  begin
    StatusBar1.SimpleText:='Процесс вывода данных для отчета';
    //вызов вывода отчета - запроом через кверю
    qReport.Close;
    try
      qReport.sql.Clear;
      //19610

      { sql_text:='SELECT * FROM V_ABONENT_BALANCES_WITHOUTSRT1 '+
                           ' WHERE  session_id='+IntToStr(session_id)+' and  (:OPERATOR_ID IS NULL '+
                           ' OR V_ABONENT_BALANCES_WITHOUTSRT1.OPERATOR_NAME = :OPERATOR_NAME or (:OPERATOR_NAME =''Все''))'+
                           ' AND ((:IS_CREDIT IS NULL)OR(NVL(V_ABONENT_BALANCES_WITHOUTSRT1.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';}

      sql_text:='SELECT  V_ABONENT_BALANCES_WITHOUTSRT1.*, t.tariff_code FROM V_ABONENT_BALANCES_WITHOUTSRT1, tariffs t '+#13#10+
                ' WHERE  session_id=:session_id '+#13#10+
                ' and V_ABONENT_BALANCES_WITHOUTSRT1.tariff_id = t.tariff_Id(+) '+#13#10+
                ' AND ((:IS_CREDIT IS NULL)OR(NVL(V_ABONENT_BALANCES_WITHOUTSRT1.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';

      // MessageDlg('Текст запроса: '+sql_Text, mtError, [mbOK], 0);
      qReport.sql.Add(sql_Text);
      qReport.ParamByName('session_id').Value := session_id;
      //qReport.ExecSQL;
      qReport.Open;

    except
      on e : exception do
        MessageDlg('Ошибка выполнения запроса: '+qReport.sql.Text, mtError, [mbOK], 0);
    end;



  end;

 // формирование отчета с пересбором данных
  if cbrefresh.Checked=True then
  begin

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

    if Rep_Progress = True then
    begin

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

            sql.Text:='begin temp_balphone('+IntToStr(session_id)+','''+FAccid+''',0); end;' ;

            Execute;
          except
            on e : exception do
              MessageDlg('Ошибка выполнения temp_balphone', mtError, [mbOK], 0);
          end;
        end;

        Close;
        sql.Clear;
        sql.Text:='SELECT count(*) as record_count from testbalance_phone1 where session_id='+IntToStr(session_id);
        Execute;
        record_count:=sqlOra.FieldByName('record_count').AsInteger;
        Gauge1.MaxValue:=record_count;

            // запускаем  джобы на заполнение testdelta_balance
        begin
          try
            Close;
            sql.Clear;
            sql.Text:='begin temp_jobsbal('+IntToStr(session_id)+'); end;';
            Execute;
          except
            on e : exception do
              MessageDlg('Ошибка выполнения temp_balphone', mtError, [mbOK], 0);
          end;
        end;

      end;

      Timer1.Enabled:=true; //запуск таймера

    end;
  end;

end;

procedure TReportBalanceFrm.Timer1Timer(Sender: TObject);
var SqlOra : TOraQuery;
   plusPG1 : integer;
   sql_text : string;
begin
  SqlOra := TOraQuery.Create(nil);
  with SqlOra do
  begin
    Close;
    sql.Clear;
    sql.add(' select count(*) ncount from testdelta_balance where session_id='+IntToStr(session_id)+'' );
    Execute;
    plusPG1:=sqlOra.FieldByName('ncount').AsInteger;
    StatusBar1.SimpleText:='Обработано записей '+inttostr(plusPG1)+' из '+inttostr(Gauge1.MaxValue);
    Gauge1.Progress:= plusPG1;
    close;
  end;

  If (Gauge1.Progress=Gauge1.MaxValue) Then
  begin

    Timer1.Enabled:=False;
    Gauge1.Progress:=0;
    StatusBar1.Color:=clMoneyGreen;
    StatusBar1.SimpleText:='Процесс вывода данных для отчета на экран';

    //вызов вывода отчета - запроом через кверю
    qReport.Close;


    try
      qReport.sql.Clear;
      //19610

      //  sql_text:='SELECT * FROM V_ABONENT_BALANCES_WITHOUTSRT1  WHERE  session_id='+IntToStr(session_id);
      sql_text:='SELECT V_ABONENT_BALANCES_WITHOUTSRT1.*, t.tariff_code FROM V_ABONENT_BALANCES_WITHOUTSRT1, tariffs t '+#13#10+
                ' WHERE  session_id = :session_id'+#13#10+
                ' and V_ABONENT_BALANCES_WITHOUTSRT1.tariff_id = t.tariff_Id(+) '+#13#10+
                ' AND ((:IS_CREDIT IS NULL)OR(NVL(V_ABONENT_BALANCES_WITHOUTSRT1.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';


      // MessageDlg('Текст запроса: '+sql_Text, mtError, [mbOK], 0);
      qReport.sql.Add(sql_Text);
      qReport.ParamByName('session_id').Value := session_id;
      //ExecSQL;
      qReport.Open;

    except
      on e : exception do
      MessageDlg('Ошибка выполнения запроса: '+qReport.sql.Text, mtError, [mbOK], 0);
    end;

    StatusBar1.SimpleText:='Отчет сформирован';
    SHOW_LastDateRep;
  end;

  end;

end.
