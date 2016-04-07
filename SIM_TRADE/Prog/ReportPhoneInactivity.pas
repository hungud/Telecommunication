unit ReportPhoneInactivity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, oraerror, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit, sCheckListBox,
  sListBox;

type
  TReportPhoneInactivityForm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    qAllTables: TOraQuery;
    eBeginDate: TsDateEdit;
    eEndDate: TsDateEdit;
    CLB_Accounts: TsCheckListBox;
    qUserCheckAllow: TOraQuery;
    qAccounts_Allow: TOraQuery;
    function UserCheckAllow:boolean;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    BeginDate,EndDate:string;
    FAccountAll:boolean;
    FAccid : string;
  public
    procedure Execute(Modal : Boolean);
  end;

var
  ReportPhoneInactivityForm: TReportPhoneInactivityForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, ShowUserStat, IntecExportGrid, Main;

function TReportPhoneInactivityForm.UserCheckAllow:boolean;
begin
  if not qUserCheckAllow.active then begin
    qUserCheckAllow.ParamByName('USER_NAME').AsString := mainform.OraSession.Username;
    qUserCheckAllow.open;
  end;
  if (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 1) or (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 2) then result:=true else result:=false;
end;

function CheckDate(begin_date,end_date:TDate):boolean;
var
 d,m,y:word;
begin
  result:=false;
  if begin_date > end_date then begin
    MessageDlg('Начальная дата не может быть больше конечной даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then begin
    MessageDlg('Начальная дата не может быть больше текущей даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  decodedate(IncMonth(Now,-2),y,m,d);
  if begin_date < encodedate(y,m,1) then begin
    MessageDlg('Начальная дата не может отличаться от текущей больше чем на 2 месяца!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  result:=true;
end;

procedure TReportPhoneInactivityForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Номера c отсутствующей активностью '+BeginDate+' - '+EndDate,'', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhoneInactivityForm.aRefreshExecute(Sender: TObject);
begin
 if not FAccountAll and (FAccid='') then
 begin
   MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
   exit;
 end;

 BeginDate := eBeginDate.Text;
 EndDate := eEndDate.Text;
 Try
  if (BeginDate = '  .  .    ') or (EndDate = '  .  .    ') then
  begin
    MessageDlg('Укажите начальную и конечную дату!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if not CheckDate(StrToDate(BeginDate),StrToDate(EndDate)) then
    Exit;

  qReport.Close;
  qReport.SQL.Text:='select * from table(GET_PHONE_INACTIVE_TAB(:DATE_BEGIN, :DATE_END)) v';

  if not FAccountAll then
    qReport.SQL.Text:=qReport.SQL.Text+' where V.LOGIN in (select login from accounts where account_id in ('+FAccid+')) '
  else
  if UserCheckAllow then
    qReport.SQL.Text:=qReport.SQL.Text+' where V.LOGIN in ('+
        'SELECT a.LOGIN FROM ACCOUNTS a, user_names u, rights_type_account_allow r'+
        ' WHERE UPPER(u.user_name) = UPPER(:user_name) AND u.rights_type = r.rights_type AND r.account_id = a.account_id)';

  qReport.Prepare;
  if FAccountAll and UserCheckAllow then
    qReport.ParamByName('USER_NAME').AsString := mainform.OraSession.Username;
  qReport.ParamByName('DATE_BEGIN').AsDate:=StrToDate(BeginDate);
  qReport.ParamByName('DATE_END').AsDate:=StrToDate(EndDate);
  qReport.Open;
 Except
   on e: eoraerror do
   MessageDlg('Ошибка при формировании отчета.'#13#10 + e.Message, mtError, [mbOK], 0);
 End;
end;

procedure TReportPhoneInactivityForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
  end;
end;

procedure TReportPhoneInactivityForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhoneInactivityForm.Execute(Modal: Boolean);
begin
  CLB_Accounts.Show;
  CLB_Accounts.Items.AddObject('Все', Pointer(-1));
  if UserCheckAllow then begin
    qAccounts_Allow.ParamByName('USER_NAME').AsString:= mainform.OraSession.Username;
    qAccounts_Allow.Open;
    while not qAccounts_Allow.EOF do
    begin
      CLB_Accounts.Items.AddObject(
        qAccounts_Allow.FieldByName('LOGIN').AsString,
        Pointer(qAccounts_Allow.FieldByName('ACCOUNT_ID').AsInteger)
      );
      qAccounts_Allow.Next;
    end;
    qAccounts_Allow.Close;
  end
  else begin
    qAccounts.Open;
    while not qAccounts.EOF do
    begin
      CLB_Accounts.Items.AddObject(
        qAccounts.FieldByName('LOGIN').AsString,
        Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
      );
      qAccounts.Next;
    end;
    qAccounts.Close;
  end;
  if Modal then
    ShowModal
  else
    FormStyle := fsMDIChild;
end;

procedure TReportPhoneInactivityForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TReportPhoneInactivityForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];

end;

procedure TReportPhoneInactivityForm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
begin
FAccid:='';
if not FAccountAll then
  for i := 1 to CLB_Accounts.Items.Count - 1 do
    if CLB_Accounts.Checked[i] then
      FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';

if not FAccountAll then
  FAccid:=copy(FAccid,1,Length(FAccid)-1);

end;

procedure TReportPhoneInactivityForm.CLB_AccountsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var xPoint: TPoint;
    xIndex: Integer;
begin
  xPoint.X:=X;
  xPoint.Y:=Y;
  xIndex:=CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then begin
    CLB_Accounts.Hint:=CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else Application.CancelHint;

end;

end.
