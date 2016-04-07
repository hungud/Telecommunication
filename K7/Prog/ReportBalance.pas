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
    cbCredit: TCheckBox;
    CLB_Accounts: TsCheckListBox;
    Timer1: TTimer;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Lb_daterep: TLabel;
    CBRefresh: TCheckBox;
    btUncheckAll: TButton;
    qReportPHONE_NUMBER_FEDERAL: TStringField;
    qReportOPERATOR_NAME: TStringField;
    qReportSURNAME: TStringField;
    qReportNAME: TStringField;
    qReportPATRONYMIC: TStringField;
    qReportBDATE: TDateTimeField;
    qReportCONTACT_INFO: TStringField;
    qReportBALANCE: TFloatField;
    qReportDISCONNECT_LIMIT: TFloatField;
    qReportCONNECT_LIMIT: TFloatField;
    qReportIS_VIP: TStringField;
    qReportPHONE_IS_ACTIVE_CODE: TFloatField;
    qReportACCOUNT_ID: TFloatField;
    qReportSTATUS_DATE: TDateTimeField;
    qReportTARIFF_NAME: TStringField;
    qReportTARIFF_ID: TFloatField;
    qReportLOADER_SCRIPT_NAME: TStringField;
    qReportHAND_BLOCK: TFloatField;
    qReportIS_CREDIT_CONTRACT: TIntegerField;
    qReportHAND_BLOCK_DATE_END: TDateTimeField;
    qReportCONTRACT_DATE: TDateTimeField;
    qReportTYPE_PAYMENT: TStringField;
    qReportPHONE_IS_ACTIVE: TStringField;
    qReportLIMIT_EXCEED_SUM: TFloatField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportCOMPANY_NAME: TStringField;
    qReportIS_DISCOUNT: TStringField;
    qReportCOLOR: TFloatField;
    qReportDESCRIPTION: TStringField;
    qReportDOP_STATUS: TStringField;
    qReportSESSION_ID: TFloatField;
    qReportTYPE_ABON: TStringField;
    qReportBALANCE_BLOCK_HAND_BLOCK: TFloatField;
    qReportLOGIN: TStringField;
    qReportDATE_LAST_UPDATE: TStringField;
    qReportTARIFF_CODE: TStringField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grDataGetCellParams(Sender: TObject; Field: TField; AFont: TFont;
      var Background: TColor; State: TGridDrawState; StateEx: TGridDrawStateEx);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btUncheckAllClick(Sender: TObject);
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
var
  ReportFrm : TReportBalanceFrm;
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
       + 'WHERE V_ABONENT_BALANCES_WITHOUTSRT1.ACCOUNT_ID = AC.ACCOUNT_ID)');
      ReportFrm.qAccounts.SQL.Insert(1, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
    end;
    if GetConstantValue('CREDIT_SYSTEM_ENABLE') = '1' then
      ReportFrm.cbCredit.Show
    else
      ReportFrm.cbCredit.Hide;
    for i:=0 to ReportFrm.grData.Columns.Count-1 do
      if (ReportFrm.grData.Columns[i].FieldName='IS_DISCOUNT') then
        if GetConstantValue('SHOW_CONTRACT_ID_AND_DISCOUNT') = '1' then
          ReportFrm.grData.Columns[i].Visible:=true
        else
          ReportFrm.grData.Columns[i].Visible:=false;
    for i:=0 to ReportFrm.grData.Columns.Count-1 do
      if (ReportFrm.grData.Columns[i].FieldName='COMPANY_NAME') then
        if GetConstantValue('SHOW_COMPANY_NAME') = '1' then
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

    begin
      Sdvig:=0;

      ReportFrm.BitBtn1.Left:=ReportFrm.BitBtn1.Left-Sdvig;
      ReportFrm.BitBtn2.Left:=ReportFrm.BitBtn2.Left-Sdvig;
      ReportFrm.BitBtn3.Left:=ReportFrm.BitBtn3.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.Label1.Left:=ReportFrm.Label1.Left-Sdvig;
      ReportFrm.cbOperatorNames.Left:=ReportFrm.cbOperatorNames.Left-Sdvig;
     // ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;
//    ReportFrm.cbOperatorNamesChange(ReportFrm.cbOperatorNames);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBalanceFrm.aRefreshExecute(Sender: TObject);
begin
  SHOW_ProgressBar;
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

procedure TReportBalanceFrm.btUncheckAllClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
    CLB_ACCOUNTS.Checked[i] := false;
  FAccid:='-2';
end;

procedure TReportBalanceFrm.grDataGetCellParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
begin
  if GetConstantValue('DRAW_REPORT_BALANCE') = '1' then
  begin
    if (Field.FieldName='PHONE_IS_ACTIVE') then
      if (Field.AsString='Блок.') then
        AFont.Color := clRed;
    if (Field.FieldName='IS_DISCOUNT') then
      if (qReport.FieldByName('IS_DISCOUNT').AsString='Нет')
          or ((qReport.FieldByName('IS_DISCOUNT').AsString='Да')
               and (qReport.FieldByName('COLOR').AsInteger=1)) then
        AFont.Color := clRed;
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
end;

procedure TReportBalanceFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportBalanceFrm.CLB_AccountsClick(Sender: TObject);
begin
  if (CLB_Accounts.Checked[0]=true) then
    FAccid := '-1'
  else
    FAccid := '';
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
        FAccid:='';
      end;
    end;
  end;

end;

procedure TReportBalanceFrm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
begin
  if FAccid<>'-1' then
  begin
    FAccid:='';
    FAccount:='';
  end;

  for i := 1 to CLB_Accounts.Items.Count - 1 do
  if CLB_Accounts.Checked[i] then
  begin
    FAccid := FAccid + inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
    FAccount := FAccount + CLB_Accounts.Items[CLB_Accounts.ItemIndex]+',';
  end;

  if FAccid<>'-1' then
  begin
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
    FAccount:=copy(FAccount,1,Length(FAccount)-1);
  end;

  if CLB_Accounts.Checked[0]=true then
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
  xPoint.X := X;
  xPoint.Y := Y;
  xIndex := CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then
  begin
    CLB_Accounts.Hint := CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else
    Application.CancelHint;
end;

procedure TReportBalanceFrm.FormCreate(Sender: TObject);
begin
  FAccid:='-2';
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
    exit;
  end;

  StatusBar1.SimpleText:='Процесс вывода данных для отчета';
  //вызов вывода отчета - запроом через кверю
  qReport.Close;

  try
    qReport.sql.Clear;


    sql_text :=  'SELECT '+#13#10+
                 '   v.*, '+#13#10+
                 '   ac.login, '+#13#10+
                 '  DAT.DATE_LAST_UPDATE, '+#13#10+
                 '  t.tariff_code '+#13#10+
                 'FROM '+#13#10+
                 '  V_ABONENT_BALANCES_WITHOUTSRT1 v, accounts ac, '+#13#10+
                 ' ( '+#13#10+
                 '     select '+#13#10+
                 '       log.phone_number, '+#13#10+
                 '       CASE '+#13#10+
                 '         WHEN log.dop_status_id_new IS NULL THEN '+#13#10+
                 '           ''-'' '+#13#10+
                 '       ELSE '+#13#10+
                 '         ''+'' '+#13#10+
                 '       END '+#13#10+
                 '       || TO_CHAR(log.date_last_updated,''dd.mm.yyyy'') date_last_update '+#13#10+
                 '     from LOG_DOP_STATUS log '+#13#10+
                 '     where date_last_updated = ( '+#13#10+
                 '                                 select '+#13#10+
                 '                                   max(date_last_updated) '+#13#10+
                 '                                 from '+#13#10+
                 '                                   LOG_DOP_STATUS WHERE PHONE_NUMBER = log.phone_number '+#13#10+
                 '                               ) '+#13#10+
                 ' ) dat, '+#13#10+
                 ' tariffs t '+#13#10+
                 'WHERE '+#13#10+
                 ' session_id= :SESSION_ID '+#13#10+
                 '  and v.account_id = ac.account_id '+#13#10+
                 ' and v.PHONE_NUMBER_FEDERAL = DAT.PHONE_NUMBER(+) '+#13#10+
                 ' and v.tariff_id = t.tariff_id (+) ';


    if cbOperatorNames.ItemIndex > 0 then
      sql_text := sql_text+' AND v.OPERATOR_NAME = :OPERATOR_NAME';

    if FAccid <> '-1'  then
      sql_text := sql_text+' and v.ACCOUNT_ID in ('+FAccid+') ';

    sql_text := sql_text+' AND ((:IS_CREDIT IS NULL)OR(NVL(v.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';

    sql_text := sql_text+' order by v.PHONE_NUMBER_FEDERAL ' +#13#10;

    qReport.sql.Add(sql_Text);

    qReport.ParamByName('SESSION_ID').Value := session_id;

    if cbOperatorNames.ItemIndex > 0 then
      qReport.ParamByName('OPERATOR_NAME').Value := cbOperatorNames.Items[cbOperatorNames.ItemIndex];


    if cbCredit.Checked then
      qReport.ParamByName('IS_CREDIT').AsInteger:=1
    else
      qReport.ParamByName('IS_CREDIT').Clear;

    qReport.Open;
    grData.Columns[3].Width := 80;
  except
    on e : exception do
      MessageDlg('Ошибка выполнения запроса: '+ qReport.sql.Text, mtError, [mbOK], 0);
  end;
end;

procedure TReportBalanceFrm.SHOW_LastDateRep;
var
  SqlOra : TOraQuery;
begin
  SqlOra := TOraQuery.Create(nil);
  try
    SqlOra.Close;
    SqlOra.sql.Clear;
    SqlOra.sql.add(' select max(balance_date) balance_date, max(session_id) session_id  from testbalance_phone1');
    SqlOra.Execute;
    Lb_daterep.Caption:='Дата последнего отчета '+SqlOra.FieldByName('balance_date').AsString;
    session_id := SqlOra.FieldByName('session_id').Asinteger;
  finally
    FreeAndNil(SqlOra);
  end;
end;


procedure TReportBalanceFrm.SHOW_ProgressBar;
var
  SqlOra : TOraQuery;
  Rep_Progress : Boolean;
begin

  // вывод отчета на экран по последней дате
  if not cbrefresh.Checked then
    SHOW_Balance
  else
  begin
    // формирование отчета с пересбором данных
    StatusBar1.Color := clBtnFace;
    Rep_Progress := True;

    SqlOra := TOraQuery.Create(nil);
    try
      SqlOra.Close;
      SqlOra.sql.Clear;
      SqlOra.sql.add('select sum(count_jod_work) as count_jod_work, sum(const_job) as const_job from');
      SqlOra.sql.add(' (select count(*) count_jod_work, 0 as const_job from dba_jobs a where a.LOG_USER=:logUser ');
      SqlOra.sql.add(' union all select 0 as count_jod_work, to_number(ms_constants.GET_CONSTANT_VALUE(''TEMP_JOBSBALANCE'')) as const_job  from dual)');
      SqlOra.ParamByName('logUser').Value := GetConstantValue('SERVER_NAME');


      //  MessageDlg('sql.Text= '+sql.Text, mtConfirmation, [mbOK], 0);
      SqlOra.Execute;

      if round(SqlOra.FieldByName('count_jod_work').AsInteger/SqlOra.FieldByName('const_job').AsInteger+0.5) = 2 then
      begin
        Rep_Progress := False;
        MessageDlg('В данный момент запущено формирование отчета двумя пользователями, попробуйте сформировать отчет позже. ', mtConfirmation, [mbOK], 0);
      end;

      if Rep_Progress = True then
      begin

        StatusBar1.SimpleText := 'Процесс формирования данных для отчета';

        // назначение номера сессии формирования отчета
        SqlOra.Close;
        SqlOra.sql.Clear;
        SqlOra.sql.Text:='select s_session_balnow.nextval as sessionid from dual';
        SqlOra.Execute;
        session_id := sqlOra.FieldByName('sessionid').AsInteger;
        begin
          try
            SqlOra.Close;
            SqlOra.sql.Clear;

            if cbCredit.Checked then
              SqlOra.sql.Text := 'begin temp_balphone('+IntToStr(session_id)+','''+FAccid+''',1); end;'
            else
              SqlOra.sql.Text := 'begin temp_balphone('+IntToStr(session_id)+','''+FAccid+''',0); end;' ;

            SqlOra.Execute;
          except
            on e : exception do
              MessageDlg('Ошибка выполнения temp_balphone', mtError, [mbOK], 0);
          end;
        end;

        SqlOra.Close;
        SqlOra.sql.Clear;
        SqlOra.sql.Text := 'SELECT count(*) as record_count from testbalance_phone1 where session_id='+IntToStr(session_id);
        SqlOra.Execute;
        record_count := sqlOra.FieldByName('record_count').AsInteger;
        Gauge1.MaxValue := record_count;
        try
          SqlOra.Close;
          SqlOra.sql.Clear;
          SqlOra.sql.Text:='begin temp_jobsbal('+IntToStr(session_id)+'); end;';
          SqlOra.Execute;
        except
          on e : exception do
            MessageDlg('Ошибка выполнения temp_balphone', mtError, [mbOK], 0);
        end;

        Timer1.Enabled := true; //запуск таймера
      end;
    finally
      FreeAndNil(SqlOra);
    end;
  end;
end;

procedure TReportBalanceFrm.Timer1Timer(Sender: TObject);
var
  SqlOra : TOraQuery;
  plusPG1 : integer;
begin
  SqlOra:=TOraQuery.Create(nil);
  try
    SqlOra.Close;
    SqlOra.sql.Clear;
    SqlOra.sql.add(' select count(*) ncount from testdelta_balance where session_id='+IntToStr(session_id)+'' );
    SqlOra.Execute;
    plusPG1 := sqlOra.FieldByName('ncount').AsInteger;
    StatusBar1.SimpleText := 'Обработано записей '+IntToStr(plusPG1)+' из '+IntToStr(Gauge1.MaxValue);
    Gauge1.Progress := plusPG1;
    SqlOra.close;
  finally
    FreeAndNil(SqlOra);
  end;

  If (Gauge1.Progress = Gauge1.MaxValue) Then
  begin
    Timer1.Enabled := False;
    Gauge1.Progress := 0;
    StatusBar1.Color := clMoneyGreen;
    SHOW_Balance;
    StatusBar1.SimpleText := 'Отчет сформирован';
    SHOW_LastDateRep;
  end;
end;

end.
