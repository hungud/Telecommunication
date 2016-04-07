unit ReportDopStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Grids,
  DBGrids, CRGrid, Data.DB, MemDS, DBAccess, Ora, ActnList, ComCtrls,
  ToolWin, Buttons;

type
  TReportDopStatusForm = class(TForm)
    Panel1: TPanel;
    ACCOUNT_NUM: TLabel;
    PhoneNum: TLabel;
    Status: TLabel;
    DopStatus: TLabel;
    CBAccount_Num: TComboBox;
    CBPhoneNum: TComboBox;
    CBStatus: TComboBox;
    CBDopStatus: TComboBox;
    DS_Status: TDataSource;
    QStatus: TOraQuery;
    CRDBGrid1: TCRDBGrid;
    Label1: TLabel;
    CBBid: TComboBox;
    ActionList1: TActionList;
    aRefresh: TAction;
    aExcel: TAction;
    QStatusyear_month: TStringField;
    QStatuslogin: TStringField;
    QStatusphone_number: TStringField;
    QStatusstatus: TStringField;
    QStatusdop_status_name: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    aShowUserStatInfo: TAction;
    QStatuscontract_id: TStringField;
    CB_OpenContract: TCheckBox;
    QStatusdate_last_updated: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CBAccount_NumChange(Sender: TObject);
    procedure CBBidChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure CBStatusChange(Sender: TObject);
    procedure CBDopStatusChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CRDBGrid1CellClick(Column: TColumn);
    procedure CBPhoneNumExit(Sender: TObject);
     type TID = class
    ID: integer;
  end;
  private
    { Private declarations }
  public
    { Public declarations }
    dopstatusid, accountid, FBid, statusid, contractid : integer;
    vphonenum : String;
    SqlOra : TOraQuery;
    Stat: boolean;
    ID_DS, ID_BID, ID_S, ID_ACC, ID_PH: TID;

   procedure SHOW_Phone;
   procedure SHOW_Report;
  end;

var
  ReportDopStatusForm: TReportDopStatusForm;

implementation

{$R *.dfm}

uses  IntecExportGrid, ShowUserStat,SelectContract;

procedure TReportDopStatusForm.aRefreshExecute(Sender: TObject);
begin
SHOW_Report;
end;

procedure TReportDopStatusForm.BitBtn2Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет о доп.статусах','',
      CRDBGrid1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TReportDopStatusForm.BitBtn3Click(Sender: TObject);
var
  vPhoneNumber : String;
  vContractID : Integer;
begin
  if (vphonenum <> '')  then
    ShowUserStatByPhoneNumber(vphonenum,contractid);
end;

procedure TReportDopStatusForm.CBAccount_NumChange(Sender: TObject);
begin
accountid:=TID(CBAccount_Num.Items.Objects[CBAccount_Num.ItemIndex]).ID;
SHOW_Phone;
end;

procedure TReportDopStatusForm.CBBidChange(Sender: TObject);
begin
FBid:=TID(CBBid.Items.Objects[CBBid.ItemIndex]).ID;
end;

procedure TReportDopStatusForm.CBDopStatusChange(Sender: TObject);
begin
dopstatusid:=TID(CBDopStatus.Items.Objects[CBDopStatus.ItemIndex]).ID;
end;

procedure TReportDopStatusForm.CBPhoneNumExit(Sender: TObject);
begin
if (CBPhoneNum.Text <> '') and (CBPhoneNum.Text <> 'Все') then
    vphonenum:=CBPhoneNum.Text;
end;

procedure TReportDopStatusForm.CBStatusChange(Sender: TObject);
begin
statusid:=CBStatus.ItemIndex;
end;

procedure TReportDopStatusForm.CRDBGrid1CellClick(Column: TColumn);
begin
contractid:=StrToInt(CRDBGrid1.DataSource.DataSet.FieldByName('contract_id').AsString);
vphonenum:=CRDBGrid1.DataSource.DataSet.FieldByName('phone_number').AsString;
end;

procedure TReportDopStatusForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TReportDopStatusForm.FormCreate(Sender: TObject);

begin
CB_OpenContract.Checked:=true;
//Период
  CBBid.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBBid.Clear;
  ID_BID := TID.Create;
  ID_BID.ID := 2000;
  CBBid.AddItem('Все периоды', ID_BID);
        with SqlOra do
        begin

       sql.Text:='select distinct a.year_month from db_loader_account_phones a order by a.year_month desc';

        Execute;
        First;
                  while not Eof do
                    begin   // 201
                      ID_BID := TID.Create;
                      ID_BID.ID := FieldByName('year_month').AsInteger;
                      CBBid.AddItem(FieldByName('year_month').AsString, ID_BID);

                      Next;
                    end;  //201

        end;

        // Доп.статусы
  CBDopStatus.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBDopStatus.Clear;
  ID_DS := TID.Create;
  ID_DS.ID := 2000;
  CBDopStatus.AddItem('Все', ID_DS);

  with SqlOra do
        begin

       sql.Text:='select a.dop_status_id, a.dop_status_name from contract_dop_statuses a order by a.dop_status_id';

        Execute;
        First;
                  while not Eof do
                    begin   // 201
                      ID_DS := TID.Create;
                      ID_DS.ID := FieldByName('dop_status_id').AsInteger;
                      CBDopStatus.AddItem(FieldByName('dop_status_name').AsString, ID_DS);
                      Next;
                    end;  //201
        end;

        // абоненты
  CBAccount_Num.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBAccount_Num.Clear;
  ID_ACC := TID.Create;
  ID_ACC.ID := 2000;
  CBAccount_Num.AddItem('Все', ID_ACC);

    with SqlOra do
        begin

       sql.Text:='select a.account_id, a.login from accounts a';

        Execute;
        First;
                  while not Eof do
                    begin   // 201
                      ID_ACC := TID.Create;
                      ID_ACC.ID := FieldByName('account_id').AsInteger;
                      CBAccount_Num.AddItem(FieldByName('login').AsString, ID_ACC);
                      Next;
                    end;  //201

        end;
        CBAccount_Num.ItemIndex:=0;

   // Cтатусы
  CBStatus.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBStatus.Clear;

  ID_S := TID.Create;
  ID_S.ID := 0;
  CBStatus.AddItem('Все', ID_S);
  ID_S.ID := 1;
  CBStatus.AddItem('Активные', ID_S);
  ID_S.ID := 2;
  CBStatus.AddItem('Блок по желанию', ID_S);
  ID_S.ID := 3;
  CBStatus.AddItem('Блок по сохранению', ID_S);

          SHOW_Phone;
end;

procedure TReportDopStatusForm.SHOW_Phone;
var wSql : string;
begin
  // Номера телефонов
  CBPhoneNum.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBPhoneNum.Clear;
  ID_PH := TID.Create;
  ID_PH.ID := 2000;
  CBPhoneNum.AddItem('Все', ID_PH);

   if ID_ACC.ID<>2000 then begin

    with SqlOra do
        begin
     wSql:= 'select phone_number from db_loader_account_phones a ';
     if (CBAccount_Num.Text<>'Все') and (CBAccount_Num.Text<>'') then
      wSql:=wSql+' where YEAR_MONTH='+Inttostr(FBid)+' and account_id='+IntToStr(accountid)
            else
       wSql:=wSql+ ' where  account_id='+IntToStr(accountid); ;
//       Showmessage(wSql);

        sql.Text:=wSql;

        Execute;
        First;
                  while not Eof do
                    begin   // 201
                      ID_PH := TID.Create;
                      CBPhoneNum.AddItem(FieldByName('phone_number').AsString, ID_PH);
                      Next;
                    end;  //201

        end;

   end;
end;

procedure TReportDopStatusForm.SHOW_Report;
begin
  qStatus.Close;
  with qStatus do
  begin
   try
     sql.Clear;
                   //19610
     sql.Add (' select to_char(z.year_month) year_month, z.account_id, z.login, z.phone_number, ');
     sql.Add (' decode(z.status,0,''Все'',1,''Активные'',2,''Блок по желанию'',3,''Блок по сохранению'') status, z.dop_status_name, to_char(z.contract_id) contract_id, ');
     sql.Add ('  to_char(z.date_last_updated,''DD.MM.YYYY HH24:ss:mi'') date_last_updated from ');
     sql.Add (' (select a.year_month, a.phone_number, a.account_id, acc.login,  a.phone_is_active, ');
     sql.Add (' a.conservation,  c.dop_status,   cd.dop_status_name, c.contract_id, lds.date_last_updated, ');
     sql.Add (' CASE ');
     sql.Add (' WHEN a.phone_is_active=1 THEN 1 ');
     sql.Add (' WHEN a.phone_is_active=0 THEN  case when a.conservation=0 then 2 ');
     sql.Add ('                                     when a.conservation=1 then 3 ');
     sql.Add ('                                         else 0   ');
     sql.Add (' end END as status ');
     sql.Add (' from db_loader_account_phones a, v_contracts c, ');
     sql.Add (' (select dop_status_id, dop_status_name from   contract_dop_statuses  union all  select -1, ''''  from   dual) cd, accounts acc, log_dop_status lds  ');
     sql.Add (' where ');
     sql.Add (' a.phone_number=c.phone_number_federal ');

//endutkin 2014_05_22
//     sql.Add (' and lds.phone_number=a.phone_number  and a.year_month=to_char(trunc(lds.date_last_updated),''YYYYMM'')      ');
     sql.Add (' and lds.phone_number=a.phone_number  and a.year_month>=to_char(trunc(lds.date_last_updated),''YYYYMM'')      ');
     sql.Add ('and lds.date_last_updated in                                        ');
     sql.Add ('( select max(date_last_updated) from log_dop_status                 ');
     sql.Add ('where phone_number = a.phone_number and                             ');
     sql.Add ('to_char(trunc(date_last_updated),''YYYYMM'') <= a.year_month)       ');

     sql.Add (' and nvl(nvl(c.dop_status, lds.dop_status_id_new),-1)=cd.dop_status_id ');
     sql.Add (' and a.account_id=acc.account_id ');

     if (CBBid.Text<>'Все периоды') and (CBBid.Text<>'') then
     sql.Add (' and a.year_month='+Inttostr(FBid)+' ');

     if CB_OpenContract.Checked=true then
     sql.Add (' and nvl(c.CONTRACT_CANCEL_DATE, to_date(''31.01.3000'',''dd.mm.yyyy''))=to_date(''31.01.3000'',''dd.mm.yyyy'') and a.year_month>=to_char(c.CONTRACT_DATE,''yyyymm'')')
     else
     sql.Add (' and nvl(c.CONTRACT_CANCEL_DATE, to_date(''31.01.3000'',''dd.mm.yyyy''))<>to_date(''31.01.3000'',''dd.mm.yyyy'') and a.year_month <=to_char(c.CONTRACT_CANCEL_DATE,''yyyymm'')');

     if (CBPhoneNum.Text<>'Все') and (CBPhoneNum.Text<>'') then
     sql.Add (' and a.phone_number='+CBPhoneNum.Text);

     if (CBAccount_Num.Text<>'Все') and (CBAccount_Num.Text<>'') then
     sql.Add (' and a.account_id='+Inttostr(accountid));

     if (CBDopStatus.Text<>'Все') and (CBDopStatus.Text<>'') then
     sql.Add (' and c.dop_status='+Inttostr(dopstatusid));
     sql.Add (' ) z');

     if (CBStatus.Text<>'Все') and (CBStatus.Text<>'') then
     sql.Add (' where z.status ='+Inttostr(statusid));

     ExecSQL;
     Open;

   except
     on e : exception do
     MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
   end;
  end;

end;

end.
