unit RepAllPhones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  sListBox, sCheckListBox, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList,IntecExportGrid,
  CRGrid;

type
  TRepAllPhonesFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    CLB_Accounts: TsCheckListBox;
    CB_cancel: TCheckBox;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    GRData: TCRDBGrid;
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CB_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure SHOW_AllPhones;
  end;

  procedure DoRepAllPhones;

var
  RepAllPhonesFrm: TRepAllPhonesFrm;

implementation

uses DMUnit, ShowUserStat;

var
FAccid : string;
fShowOne : integer;
FAccount : string;
{$R *.dfm}

procedure DoRepAllPhones;
var ReportFrm  : TRepAllPhonesFrm;
begin
ReportFrm := TRepAllPhonesFrm.Create(Nil);
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

      ReportFrm.panel1.visible:=true;

end;

procedure TRepAllPhonesFrm.BitBtn1Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   if    FAccid<>'-1'  then
    ExportDBGridToExcel('Отчёт о всех номерах по л/с :'+ Faccount + ' на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        grData, False, True);

    if    FAccid='-1'  then
    ExportDBGridToExcel('Отчёт о всех номерах на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        grData, False, True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TRepAllPhonesFrm.BitBtn2Click(Sender: TObject);
begin
SHOW_AllPhones;
end;

procedure TRepAllPhonesFrm.BitBtn3Click(Sender: TObject);
begin
  if dm.qReport.Active and (dm.qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(dm.qReport.FieldByName('PHONE_NUMBER').AsString, 0);
   end;
end;

procedure TRepAllPhonesFrm.cbPeriodChange(Sender: TObject);
var
  Period : integer;
begin
if cbPeriod.ItemIndex >= 0 then
    Period := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;

 //SHOW_AllPhones;

end;

procedure TRepAllPhonesFrm.CB_cancelClick(Sender: TObject);
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

procedure TRepAllPhonesFrm.CLB_AccountsClick(Sender: TObject);
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

procedure TRepAllPhonesFrm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin

for i := 1 to CLB_Accounts.Items.Count - 1 do  begin

       if (CLB_Accounts.Checked[0]=true) and (CLB_Accounts.Checked[i]=false) then begin
       FAccid:='';
       FAccount:='';
       end;
end;

end;


procedure TRepAllPhonesFrm.CLB_AccountsExit(Sender: TObject);
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

procedure TRepAllPhonesFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 dm.qReport.Close;
 Action:=caFree;
end;

procedure TRepAllPhonesFrm.SHOW_AllPhones;
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

dm.qReport.Close;
 with dm.qReport do
              begin
                try
                  sql.Clear;

                  //MessageDlg(IntToStr(YEAR_MONTH), mtError, [mbOK], 0);
                  //MessageDlg(FAccid, mtError, [mbOK], 0);
                  sql.Add (' select a.account_number, db.year_month, db.phone_number,  ');
                  //sql.Add ('CASE WHEN db.phone_is_active = 0');
                 // sql.Add (' THEN CASE WHEN db.CONSERVATION=1 THEN ''Блок.'' ELSE ''Сохр.''  END ELSE ''Акт.'' END AS Status,');
                  sql.Add (' decode(nvl(db.phone_is_active,0),1,''Да'',''Нет'') as Status, ');
                  sql.Add ( 'db.last_check_date_time,' );
                  sql.Add (' NVL (t.tariff_name, db.cell_plan_code) AS tariff_name, ');
                  sql.Add (' decode(nvl(db.CONSERVATION,0),1,''Да'',''Нет'') as CONSERVATION, ');
                  sql.Add (' decode(nvl(db.system_block,0),1,''Да'',''Нет'') as system_block,  ');
                  sql.Add (' decode(nvl(vc.CONTRACT_ID,0),0,''Нет'',''Да'') is_contract,  ');
                  sql.Add (' case when vc.CONTRACT_CANCEL_DATE<=last_day(to_date('+IntToStr(YEAR_MONTH)+',''YYYYDD'')) then ''Закрыт'' else  ');
                  sql.Add (' decode(nvl(vc.CONTRACT_ID,0),0,'''',''Действует'' ) end as status_contract, ');
                  sql.Add (' vc.CONTRACT_CANCEL_DATE ');
                  sql.Add (' from ACCOUNTS a, db_loader_account_phones db, tariffs t, v_contracts vc  ');

                  sql.Add (' where db.year_month='+IntToStr(YEAR_MONTH)+'');

                  if FAccid<>'-1'  then

                  sql.Add (' and db.account_id in ('+FAccid+')') ;
                  sql.Add (' and a.account_id=db.account_id ');
                  sql.Add (' AND t.tariff_id(+) = ');
                  sql.Add ('      get_phone_tariff_id( ');
                  sql.Add ('        db.phone_number, ');
                  sql.Add ('        db.cell_plan_code, ');
                  sql.Add ('        db.last_check_date_time) ');
                  sql.Add (' and db.phone_number=vc.PHONE_NUMBER_FEDERAL(+) ');
                  //      MessageDlg(sql.text, mtError, [mbOK], 0);
                  ExecSQL;
                   Open;

                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.text, mtError, [mbOK], 0);
                end;

        grData.Columns[0].Title.caption:='Счет';
        grData.Columns[1].Title.caption:='Месяц';
        grData.Columns[2].Title.caption:='Номер телефона';
        grData.Columns[3].Title.caption:='Активность';
        grData.Columns[4].Title.caption:='Дата статуса';
        grData.Columns[5].Title.caption:='Текущий тарифный план';
        grData.Columns[6].Title.caption:='На сохранении ли';
        grData.Columns[7].Title.caption:='Системная блокировка';
        grData.Columns[8].Title.caption:='Наличие контракта';
        grData.Columns[9].Title.caption:='Статус контракта ';
        grData.Columns[10].Title.caption:='Дата отмены контр.';

        grData.Columns[2].Width:=150;
        grData.Columns[5].Width:=260;

        end;

end;

end.
