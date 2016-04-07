unit ReportUSSDSend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, DBCtrls, sListBox, sCheckListBox;

type
  TReportUSSDSendFrm = class(TForm)
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
    qPeriods: TOraQuery;
    dsPeriods: TDataSource;
    Label1: TLabel;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    CLB_Accounts: TsCheckListBox;
    CB_cancel: TCheckBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CB_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
             procedure SHOW_USSD;
  end;


procedure DoReportUSSDSend;

var //SqlAccount : string;
FAccid : string;
fShowOne : integer;

implementation


{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils;

procedure DoReportUSSDSend;
var ReportFrm  : TReportUSSDSendFrm;
    Sdvig, accid:integer;

begin

  ReportFrm := TReportUSSDSendFrm.Create(Nil);
  try
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').Asinteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;

      if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin

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




    end;
   // ReportFrm.CLB_Accounts.Items.Objects(ReportFrm.CLB_Accounts.Items[0]);

{    if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.cbAccounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex]);
    end else }
    begin
 //19610     Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      Sdvig:=0;
 //19610     ReportFrm.lAccount.Hide;
//19610      ReportFrm.cbAccounts.Hide;
      ReportFrm.BitBtn1.Left:=ReportFrm.BitBtn1.Left-Sdvig;
      ReportFrm.BitBtn2.Left:=ReportFrm.BitBtn2.Left-Sdvig;
      ReportFrm.BitBtn3.Left:=ReportFrm.BitBtn3.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.Label1.Left:=ReportFrm.Label1.Left-Sdvig;
      ReportFrm.cbPeriod.Left:=ReportFrm.cbPeriod.Left-Sdvig;
  //    ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;
    end;
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportUSSDSendFrm.aRefreshExecute(Sender: TObject);
begin
 { qReport.Close;
  qReport.Open;  }
  SHOW_USSD;
end;

procedure TReportUSSDSendFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт об отправленных USSD за ' + cbPeriod.Text,'', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportUSSDSendFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('MSISDN').AsString,0);
  end;
end;

procedure TReportUSSDSendFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end;
end;

procedure TReportUSSDSendFrm.cbPeriodChange(Sender: TObject);
var
  Period : integer;
begin
if cbPeriod.ItemIndex >= 0 then
    Period := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  //qReport.ParamByName('YEAR_MONTH').Asinteger := Period;
 // aRefresh.Execute;
 SHOW_USSD;
end;

procedure TReportUSSDSendFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportUSSDSendFrm.CB_cancelClick(Sender: TObject);
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

procedure TReportUSSDSendFrm.CLB_AccountsClick(Sender: TObject);
var i : integer;
begin
      if (CLB_Accounts.Checked[0]=true) then begin
       for i := 1 to CLB_Accounts.Items.Count - 1 do
       CLB_Accounts.Checked[i]:=true;
       FAccid:='-1';
      end;

      if (CLB_Accounts.Checked[0]=false) then FAccid:='';

      CB_cancel.Checked:=False;

end;

procedure TReportUSSDSendFrm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin

for i := 1 to CLB_Accounts.Items.Count - 1 do  begin

       if (CLB_Accounts.Checked[0]=true) and (CLB_Accounts.Checked[i]=false) then begin
       FAccid:='';

       end;
end;

end;

procedure TReportUSSDSendFrm.CLB_AccountsExit(Sender: TObject);
   var
  i: integer;
  s : String;

begin
   if FAccid<>'-1' then  FAccid:='';

 for i := 1 to CLB_Accounts.Items.Count - 1 do

    {if CLB_Accounts.Checked[i] then
    begin
    s:= s+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
    end;
      s:=copy(s,1,Length(s)-1);
      ShowMessage('s = '+s);  }
      if CLB_Accounts.Checked[i] then
    begin
    FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
    end;

    if FAccid<>'-1' then FAccid:=copy(FAccid,1,Length(FAccid)-1);

    if CLB_Accounts.Checked[0]=true then  FAccid:='-1';

   //   ShowMessage('FAccid = '+FAccid);


end;


procedure TReportUSSDSendFrm.FormCreate(Sender: TObject);
begin
FAccid:='-2';
fShowOne:=0;
end;

procedure TReportUSSDSendFrm.grDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;


procedure TReportUSSDSendFrm.SHOW_USSD;
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

qReport.Close;
 with qReport do
              begin
                try
                  sql.Clear;
                   //19610
                  sql_text:='select ul.msisdn,ul.ussd_date,ul.ussd,nvl(ul.text_res,ul.error_text)  from ussd_log ul where ul.type_log = 1 ';
                  sql_text:=sql_text+' and ((trunc(ul.ussd_date, ''mm'') = to_date(to_char('''+IntToStr(YEAR_MONTH)+'''), ''yyyymm'')) or (-1 = '''+IntToStr(YEAR_MONTH)+'''))  ';

                  sql.Add ('select ul.msisdn,ul.ussd_date,ul.ussd,nvl(ul.text_res,ul.error_text)  from ussd_log ul where ul.type_log = 1 ');
                  sql.Add (' and ((trunc(ul.ussd_date, ''mm'') = to_date(to_char('''+IntToStr(YEAR_MONTH)+'''), ''yyyymm'')) or (-1 = '+IntToStr(YEAR_MONTH)+'))  ');
                  if FAccid<>'-1'  then
                  sql.Add(' and (GET_ACCOUNT_ID_BY_PHONE(ul.msisdn) in ('+FAccid+'))');
                  sql_text:=sql_text+ ' and (GET_ACCOUNT_ID_BY_PHONE(ul.msisdn) in ('+FAccid+'))';
                    ExecSQL;
                   Open;

                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql_text, mtError, [mbOK], 0);
                end;

        end;
end;



end.
