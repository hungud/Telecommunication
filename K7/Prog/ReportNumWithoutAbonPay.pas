unit ReportNumWithoutAbonPay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls, sListBox, sCheckListBox,
  oraerror, Vcl.Menus;

type
  TReportNumWithoutAbonPayFrm = class(TForm)
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
    cbSearch: TCheckBox;
    qAccounts: TOraQuery;
    lAccount: TLabel;
    CLB_Accounts: TsCheckListBox;
    qUserCheckAllow: TOraQuery;
    qAccounts_Allow: TOraQuery;
    qGetJobStatus: TOraQuery;
    qGET_PHONE_WITHOUT_TRAFFIC_TAB: TOraQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    BitBtn4: TBitBtn;
    aExclusion: TAction;
    btCreateReport: TBitBtn;
    Timer1: TTimer;
    lReportText: TLabel;
    lbReportDate: TLabel;
    qGetReportData: TOraQuery;
    sProcStartJob: TOraStoredProc;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    function UserCheckAllow:boolean;
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure aExclusionExecute(Sender: TObject);
    procedure btCreateReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;

    function f_start_job : boolean;
    function f_is_job_run : boolean;

    function f_GetState : string;
    procedure GetReportData;
    procedure chkStart;
  public

  end;

procedure DoReportNumWithoutAbonPay;


implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, NumWithoutTrafficExclusion,
  DMUnit;

function TReportNumWithoutAbonPayFrm.f_GetState : string;
var
  v_res : string;
begin
  v_res := '';
  qGetJobStatus.Close;
  qGetJobStatus.Open;
  if qGetJobStatus.FieldByName('ct').AsInteger > 0 then
    v_res := 'RUNNING';
  qGetJobStatus.Close;

  Result := v_res;
end;

function TReportNumWithoutAbonPayFrm.f_is_job_run : boolean;
begin
  Result := f_GetState ='RUNNING';
end;

procedure TReportNumWithoutAbonPayFrm.FormCreate(Sender: TObject);
begin
  chkStart;
  Timer1.Interval := 1000; // интервал 30 секунд
end;

procedure TReportNumWithoutAbonPayFrm.chkStart;
begin
  if not f_is_job_run then
  begin
    GetReportData;
    if Timer1.Enabled then
    begin
      Timer1.Enabled := False;
      ShowMessage('Отчет сформирован!');
    end;
    btCreateReport.Enabled := true;
  end
  else
  begin
    lReportText.Caption := 'Идет формирование отчета';

    if (length (lbReportDate.Caption) > 0) and (length (lbReportDate.Caption) < 3) then
      lbReportDate.Caption := lbReportDate.Caption + '.'
    else
      lbReportDate.Caption := '.';

    if not Timer1.Enabled then
      Timer1.Enabled := true;

    btCreateReport.Enabled := false;
  end;
end;

procedure TReportNumWithoutAbonPayFrm.Timer1Timer(Sender: TObject);
begin  // на 1 запись отводим 3 секунды
  chkStart;
end;

function TReportNumWithoutAbonPayFrm.f_start_job : boolean;
begin
  qReport.Close;
  sProcStartJob.ExecProc;
  Timer1.Enabled := true;
  btCreateReport.Enabled := false;
end;

procedure TReportNumWithoutAbonPayFrm.btCreateReportClick(Sender: TObject);
begin  // запуск отчета
  if not f_is_job_run then
    f_start_job;
  chkStart;
end;


procedure TReportNumWithoutAbonPayFrm.GetReportData;
begin
  lbReportDate.Caption := '';
  lReportText.Caption := 'Дата формирования отчета:';
  qGetReportData.Close;
  qGetReportData.Open;
  lbReportDate.Caption := qGetReportData.FieldByName('max_date_created').AsString;
  qGetReportData.Close;
end;

//флаг проверки доступа пользователя к л/с
function TReportNumWithoutAbonPayFrm.UserCheckAllow:boolean;
begin
  qUserCheckAllow.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
  qUserCheckAllow.Close;
  qUserCheckAllow.Open;
  if (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 1) or
     (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 2) then
    result:=true
  else
    result:=false;
end;

procedure DoReportNumWithoutAbonPay;
var ReportFrm : TReportNumWithoutAbonPayFrm;
begin
  ReportFrm := TReportNumWithoutAbonPayFrm.Create(Nil);
  try
    ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    if ReportFrm.UserCheckAllow then
    begin
      ReportFrm.qAccounts_Allow.ParamByName('USER_NAME').AsString:= Dm.OraSession.Username;
      ReportFrm.qAccounts_Allow.Open;
      while not ReportFrm.qAccounts_Allow.EOF do
      begin
        ReportFrm.CLB_Accounts.Items.AddObject(
          ReportFrm.qAccounts_Allow.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts_Allow.FieldByName('ACCOUNT_ID').AsInteger)
        );
        ReportFrm.qAccounts_Allow.Next;
      end;
      ReportFrm.qAccounts_Allow.Close;
    end
    else
    begin
      ReportFrm.qAccounts.Open;
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.CLB_Accounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
    end;
    //показываем форму
    ReportFrm.ShowModal
  finally
    ReportFrm.Free;
  end;
end;

//обновление
procedure TReportNumWithoutAbonPayFrm.aExclusionExecute(Sender: TObject);
begin
  TNumWithoutTrafficExclusionFrm.ShowReport;
end;

procedure TReportNumWithoutAbonPayFrm.aRefreshExecute(Sender: TObject);
begin
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;

  try
    qReport.Close;
    qReport.SQL.Text:= qGET_PHONE_WITHOUT_TRAFFIC_TAB.SQL.Text;

    if not FAccountAll then
      qReport.SQL.Text:=qReport.SQL.Text+' and V.LOGIN in (select login from accounts where account_id in ('+FAccid+')) '
    else
    if UserCheckAllow then
      qReport.SQL.Text:=qReport.SQL.Text+' and V.LOGIN in ('+
        'SELECT a.LOGIN FROM ACCOUNTS a, user_names u, rights_type_account_allow r'+
        ' WHERE UPPER(u.user_name) = UPPER(:user_name) AND u.rights_type = r.rights_type AND r.account_id = a.account_id)';

    qReport.Prepare;
    if FAccountAll and UserCheckAllow then
      qReport.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;

    qReport.Open;
  except
    on e: eoraerror do
    MessageDlg('Ошибка при формировании отчета.'#13#10 + e.Message, mtError, [mbOK], 0);
  end;
end;

//выгрузка в excel
procedure TReportNumWithoutAbonPayFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт о номерах без трафика','', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

//информация по абоненту
procedure TReportNumWithoutAbonPayFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('phone_number_federal').AsString,0);
  end;
end;

//поиск
procedure TReportNumWithoutAbonPayFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportNumWithoutAbonPayFrm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];
end;

procedure TReportNumWithoutAbonPayFrm.CLB_AccountsExit(Sender: TObject);
var i: integer;
begin
  FAccid:='';
  if not FAccountAll then
    for i := 1 to CLB_Accounts.Items.Count - 1 do
      if CLB_Accounts.Checked[i] then
        FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';

  if not FAccountAll then
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
end;

procedure TReportNumWithoutAbonPayFrm.CLB_AccountsMouseMove(Sender: TObject;
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

//закрыть форму и освобождаем всю связанную с ней память
procedure TReportNumWithoutAbonPayFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=False;
  Action:=caFree;
end;

procedure TReportNumWithoutAbonPayFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

procedure TReportNumWithoutAbonPayFrm.N1Click(Sender: TObject);
var
  OraQuery:TOraQuery;
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  Try
    OraQuery:=TOraQuery.Create(self);
    //проверка
    OraQuery.SQL.Text:='SELECT * FROM num_without_traffic_exclusion WHERE phone_number = :phone_number';
    OraQuery.ParamByName('phone_number').AsString:=qReport.FieldByName('phone_number_federal').AsString;
    OraQuery.Open;
    if OraQuery.RecordCount = 0 then
    begin
      Dm.OraSession.StartTransaction;
      try
        OraQuery.Close;
        OraQuery.SQL.Text:='INSERT INTO num_without_traffic_exclusion (phone_number) VALUES (:phone_number)';
        OraQuery.ParamByName('phone_number').AsString:=qReport.FieldByName('phone_number_federal').AsString;
        OraQuery.ExecSQL;
        Dm.OraSession.Commit;
        MessageDlg('Номер успешно добавлен в исключения.', mtInformation, [mbOK], 0);
      except
        on e: eoraerror do
        begin
          MessageDlg('Ошибка при исключении номера из отчета.'#13#10 + e.Message, mtError, [mbOK], 0);
          Dm.OraSession.Rollback;
        end;
      end;
    end
    else
      MessageDlg('Номер уже исключен из отчета.', mtInformation, [mbOK], 0);
  Finally
    OraQuery.Free;
  End;
end;

end.
