unit ReportPaymentsPromised;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, sListBox, sCheckListBox;

type
  TReportPromisedPaymentsForm = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    Payments: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportPROMISED_SUM: TFloatField;
    qReportPAYMENT_DATE: TDateTimeField;
    qReportPROMISED_DATE: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    lAccount: TLabel;
    CLB_Accounts: TsCheckListBox;
    qAccounts: TOraQuery;
    qReportLOGIN: TStringField;
    qUserCheckAllow: TOraQuery;
    qAccounts_Allow: TOraQuery;
    qReportPRIZNAK: TStringField;
    qReportBALANCE: TFloatField;
    qReportCOMPANY_NAME: TStringField;
    qReportPROMISED_SUM2: TFloatField;
    function UserCheckAllow:boolean;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
//    procedure CLB_AccountsClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    FAccountAll:boolean;
  public
    { Public declarations }
  end;

procedure DoReportPromisedPayments;

var
  ReportPromisedPaymentsForm: TReportPromisedPaymentsForm;
  FAccid : string;
  FAccount : string;

implementation

{$R *.dfm}

uses ShowUserStat, IntecExportGrid, Main, DMUnit;

procedure DoReportPromisedPayments;
var ReportFrm : TReportPromisedPaymentsForm;
    Sdvig:integer;
begin
//  FAccid:='-2';
  ReportFrm := TReportPromisedPaymentsForm.Create(Nil);
  try
    ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    if ReportFrm.UserCheckAllow then begin
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
    else begin
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
    // Обновим.
//    ReportFrm.aRefresh.Execute;
    if ReportFrm.UserCheckAllow then begin
      ReportFrm.qReport.SQL.Text:=ReportFrm.qReport.SQL.Text+' and t2.ACCOUNT_ID in ('+
                          'SELECT a.ACCOUNT_ID FROM ACCOUNTS a, user_names u, rights_type_account_allow r'+
                          ' WHERE UPPER(u.user_name) = UPPER(:user_name) AND u.rights_type = r.rights_type AND r.account_id = a.account_id)';
      ReportFrm.qReport.Prepare;
      ReportFrm.qReport.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
    end;
    ReportFrm.qReport.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportPromisedPaymentsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Обещанные платежи на '+DateToStr(Date),'',
      Payments, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

function TReportPromisedPaymentsForm.UserCheckAllow:boolean;
begin
  if not qUserCheckAllow.active then begin
    qUserCheckAllow.ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
    qUserCheckAllow.open;
  end;
  if (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 1) or (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 2) then result:=true else result:=false;
end;

procedure TReportPromisedPaymentsForm.aRefreshExecute(Sender: TObject);
var sql_text: string;
begin
  qReport.Close;
  qReport.Open;
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;

  qReport.Close;
  with qReport do
  begin
    try
      sql.Clear;
      sql_text:='SELECT pp.PHONE_NUMBER, ' +#13#10;
      sql_text:=sql_text+'pp.PROMISED_SUM, '+#13#10;
      sql_text:=sql_text+'TRUNC(pp.PAYMENT_DATE) PAYMENT_DATE, '+#13#10;
      sql_text:=sql_text+'TO_CHAR(pp.PROMISED_DATE, ''DD.MM.YYYY HH24:MI:SS'') PROMISED_DATE, '+#13#10;
      sql_text:=sql_text+'pp.DATE_CREATED, '+#13#10;
      sql_text:=sql_text+'pp.USER_CREATED, '+#13#10;
      sql_text:=sql_text+'acc.Login, '+#13#10;
      sql_text:=sql_text+'IOT_CURRENT_BALANCE.BALANCE,'+#13#10;
      sql_text:=sql_text+'case '+
                         '  when pp.promised_date < sysdate then '+
                         '    null '+
                         'else '+
                         '  ''Действующий'''+
                         'end   as priznak,'+#13#10;
      sql_text:=sql_text+ ' ACC.COMPANY_NAME'+#13#10;
      sql_text:=sql_text+' FROM PROMISED_PAYMENTS pp , db_loader_account_phones dbl, accounts acc, IOT_CURRENT_BALANCE  '+#13#10;
      sql_text:=sql_text+'WHERE dbl.year_month=to_CHAR(sysdate,''yyyymm'') and pp.phone_number=dbl.phone_number '+#13#10;
      sql_text:=sql_text+'and acc.account_id=dbl.account_id '+#13#10;
      sql_text:=sql_text+'and pp.phone_number = IOT_CURRENT_BALANCE.phone_number(+) '+#13#10;

      if not FAccountAll then
        sql_text := sql_text+' and dbl.ACCOUNT_ID in ('+FAccid+') '
      else if UserCheckAllow then
        sql_text := sql_text+' and dbl.ACCOUNT_ID in ('+
            'SELECT a.ACCOUNT_ID FROM ACCOUNTS a, user_names u, rights_type_account_allow r'+
            ' WHERE UPPER(u.user_name) = UPPER(:user_name) AND u.rights_type = r.rights_type AND r.account_id = a.account_id)';

        //if FAccid='-1'  then
        //sql_text:=sql_text+' AND ((:ACCOUNT_ID IS NULL)OR(V_ABONENT_BALANCES_WITHOUTSORT.ACCOUNT_ID=:ACCOUNT_ID) or (:ACCOUNT_ID =-1))';                  sql_text:=sql_text+' AND ((:IS_CREDIT IS NULL)OR(NVL(V_ABONENT_BALANCES_WITHOUTSORT.IS_CREDIT_CONTRACT, 0) = :IS_CREDIT))';
   // MessageDlg('Текст запроса: '+sql_Text, mtError, [mbOK], 0);
       sql.Add(sql_Text);
       Prepare;
       if FAccountAll and UserCheckAllow then ParamByName('USER_NAME').AsString := Dm.OraSession.Username;
       ExecSQL;
       Open;

    except
      on e : exception do
      MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;

  end;
end;

procedure TReportPromisedPaymentsForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPromisedPaymentsForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    Payments.OptionsEx:=Payments.OptionsEx+[dgeSearchBar]
  else
    Payments.OptionsEx:=Payments.OptionsEx-[dgeSearchBar];
end;

{
procedure TReportPromisedPaymentsForm.CLB_AccountsClick(Sender: TObject);
var i : integer;
begin
      if (CLB_Accounts.Checked[0]=true) then
      begin
           //for i := 1 to CLB_Accounts.Items.Count - 1 do
           //CLB_Accounts.Checked[i]:=true;
           FAccid:='-1';
      end;

      if (CLB_Accounts.Checked[0]=false) then
      begin
       // for i := 1 to CLB_Accounts.Items.Count - 1 do
           //CLB_Accounts.Checked[i]:=false;
        //ShowMessage('Заглушка');
        FAccid:='';
      end;

end;

procedure TReportPromisedPaymentsForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin

for i := 1 to CLB_Accounts.Items.Count - 1 do  begin

       if (CLB_Accounts.Checked[0]=true) and (CLB_Accounts.Checked[i]=false) then
       begin
        FAccid:='';
        FAccount:='';
       end;
end;
      if clb_Accounts.Selected[0]=TRUE then
      begin
      if (CLB_Accounts.Checked[0]=true) then
      begin
           for i := 1 to CLB_Accounts.Items.Count - 1 do
           CLB_Accounts.Checked[i]:=true;
           FAccid:='-1';
      end;

      if (CLB_Accounts.Checked[0]=false) then
      begin
        for i := 1 to CLB_Accounts.Items.Count - 1 do
           CLB_Accounts.Checked[i]:=false;
        //ShowMessage('Заглушка');
        FAccid:='';
      end;
      end;
end;

procedure TReportPromisedPaymentsForm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
  s : String;
begin

if FAccid<>'-1' then begin FAccid:=''; FAccount:='';   end;

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
if CLB_Accounts.Checked[0]=true then
begin
  FAccid:='-1';
  FAccount:='-1';
end;
end;
}

procedure TReportPromisedPaymentsForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];

end;

procedure TReportPromisedPaymentsForm.CLB_AccountsExit(Sender: TObject);
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

procedure TReportPromisedPaymentsForm.CLB_AccountsMouseMove(Sender: TObject;
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
