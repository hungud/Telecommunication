unit RefAllLogs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.Buttons, ActnList, Vcl.Mask;

type
  TRefAllLogsForm = class(TForm)
    RGLoadLogTypes: TRadioGroup;
    DsRadioGroup: TOraDataSource;
    qLoadLogTypes: TOraQuery;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    CRDBGrid1: TCRDBGrid;
    qLogs: TOraQuery;
    DsLogs: TOraDataSource;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    eSearchPhone: TMaskEdit;
    qLogsSMS: TStringField;
    qLogsSMS_TEXT: TStringField;
    qLogsDATE_ON: TDateTimeField;
    Label1: TLabel;
    Label2: TLabel;
    CBBid: TComboBox;
    Label3: TLabel;
    RB_ALLPH: TRadioButton;
    qLogsPHONE_NUMBER: TStringField;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure RB_ALLPHClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CRDBGrid1CellClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    type TID = class
    ID: integer;
  end;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RGLoadLogTypesClick(Sender: TObject);
    procedure eSearchPhoneChange(Sender: TObject);
    procedure CBBidChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FPhoneNumber, wSql, wh, report_name :string;
    FBid,param, contractid    : integer;
    procedure SHOW_LOG;
    procedure SHOW_BILL;

  end;

var
  RefAllLogsForm: TRefAllLogsForm;

implementation

{$R *.dfm}

uses  IntecExportGrid, ShowUserStat,SelectContract;

procedure TRefAllLogsForm.BitBtn1Click(Sender: TObject);
begin
//19610
 FPhoneNumber:=eSearchPhone.Text;
 SHOW_LOG;

end;

procedure TRefAllLogsForm.BitBtn2Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try

    ExportDBGridToExcel2(report_name,'',
      CRDBGrid1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TRefAllLogsForm.BitBtn3Click(Sender: TObject);
begin
  if (FPhoneNumber <> '')  then
    ShowUserStatByPhoneNumber(FPhoneNumber,contractid);
end;

procedure TRefAllLogsForm.CBBidChange(Sender: TObject);
begin
FBid:=TID(CBBid.Items.Objects[CBBid.ItemIndex]).ID; // "индекс" из комбобокса

SHOW_LOG;

end;

procedure TRefAllLogsForm.CRDBGrid1CellClick(Column: TColumn);
begin
//contractid:=StrToInt(CRDBGrid1.DataSource.DataSet.FieldByName('contract_id').AsString);
//contractid:=null;
FPhoneNumber:=CRDBGrid1.DataSource.DataSet.FieldByName('phone_number').AsString;
end;

procedure TRefAllLogsForm.eSearchPhoneChange(Sender: TObject);
var SqlOra : TOraQuery;
    Stat: boolean;
    ID: TID;
begin
RB_ALLPH.Checked:=False;
if  (Length(eSearchPhone.Text)=10) then
  begin

    RB_ALLPH.Checked:=False;
    FPhoneNumber:=eSearchPhone.Text;
    wh:=' WHERE DB_LOADER_PHONE_STAT.PHONE_NUMBER='''+FPhoneNumber+'''  order by YEAR_MONTH desc';

    SHOW_BILL;

  end;

end;

procedure TRefAllLogsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRefAllLogsForm.FormCreate(Sender: TObject);

begin
qLoadLogTypes.Open;
  DsRadioGroup.DataSet.First;
  while Not (DsRadioGroup.DataSet.Eof) do
  begin
    RGLoadLogTypes.Items.AddObject(
      qLoadLogTypes.FieldByName('NOTE').AsString,
      TObject(qLoadLogTypes.FieldByName('LOG_SOURCE_ID').AsInteger)
      );
    DsRadioGroup.DataSet.next;
  end;

  RGLoadLogTypes.ItemIndex:=0;
  qLoadLogTypes.Close;

end;

procedure TRefAllLogsForm.RB_ALLPHClick(Sender: TObject);
begin
eSearchPhone.Text:='';
SHOW_BILL;
end;

procedure TRefAllLogsForm.RGLoadLogTypesClick(Sender: TObject);
begin
inherited;
  param:=Integer(RGLoadLogTypes.Items.Objects[RGLoadLogTypes.ItemIndex]);
  report_name:=RGLoadLogTypes.items[RGLoadLogTypes.itemindex];
  SHOW_LOG;
end;

procedure TRefAllLogsForm.SHOW_BILL;
var SqlOra : TOraQuery;
    Stat: boolean;
    ID: TID;

begin

 if (Length(eSearchPhone.Text)=10) then
      begin
        RB_ALLPH.Checked:=False;
        FPhoneNumber:=eSearchPhone.Text;
        wh:=' WHERE DB_LOADER_PHONE_STAT.year_month is not null and DB_LOADER_PHONE_STAT.PHONE_NUMBER='''+FPhoneNumber+'''  order by YEAR_MONTH desc';
        Label3.Caption:=eSearchPhone.Text;

     end;

  if RB_ALLPH.Checked=True then
      begin
        FPhoneNumber:='';
        wh:=' where DB_LOADER_PHONE_STAT.year_month is not null order by YEAR_MONTH desc';
        Label3.Caption:='Все телефоны';

      end;

  CBBid.Items.Clear;
  SqlOra:=TOraQuery.Create(nil);
  CBBid.Clear;
  ID := TID.Create;
  ID.ID := 2000;
  CBBid.AddItem('Все периоды', ID);
        with SqlOra do
        begin

       sql.Text:='SELECT distinct YEAR_MONTH as YEAR_MONTH, '+
            ' to_char(to_date(year_month,''yyyymm''), ''MM'')||'' - ''||to_char(to_date(year_month,''yyyymm''), ''YYYY'') as YEARMONTH'+
            ' FROM  DB_LOADER_PHONE_STAT '+wh;

        Execute;
        First;
                  while not Eof do
                    begin   // 201
                      ID := TID.Create;
                      ID.ID := FieldByName('YEAR_MONTH').AsInteger;
                      CBBid.AddItem(FieldByName('YEARMONTH').AsString, ID);

                      Next;
                    end;  //201

        end;

        CBBid.ItemIndex:=1;

        if ID.ID<>2000 then
                FBid:=TID(CBBid.Items.Objects[CBBid.ItemIndex]).ID // "индекс" из комбобокса
                ;

 Label3.Visible:=true;
 SHOW_LOG;

 CBBid.SetFocus;
end;

procedure TRefAllLogsForm.SHOW_LOG;
begin
qLogs.Close;
 with qLogs do
              begin
                try
                  sql.Clear;
                   //19610
                  sql.Add ('select nvl(PHONE_NUMBER,'''') PHONE_NUMBER, date_on ,  ');
                  sql.Add ('CASE  ');
                  sql.Add (' WHEN LOG_SOURCE_ID=1 THEN ''MAIL'' ');
                  sql.Add (' WHEN LOG_SOURCE_ID=2 THEN ''SMS'' ');
                  sql.Add (' WHEN LOG_SOURCE_ID=5 THEN case when nvl(text_messages,''-1'')=''-1'' then ''+'' else ''-'' end ');
                  sql.Add (' WHEN LOG_SOURCE_ID=6 THEN '''' ');
                  sql.Add (' WHEN LOG_SOURCE_ID=10 THEN NOTE ');
                  sql.Add (' WHEN LOG_SOURCE_ID=-1 THEN NOTE ');    //все   записи по тел.
                  sql.Add (' WHEN LOG_SOURCE_ID=8 THEN case when type_cod=1 then ''1'' ');
                  sql.Add ('                                when type_cod=2 then ''2'' ');
                  sql.Add ('                                when type_cod=3 then ''3''  ELSE '''' end  ');
                  sql.Add (' ELSE '''' ');
                  sql.Add (' END as SMS,');
                  sql.Add (' CASE  ');
                  sql.Add (' WHEN LOG_SOURCE_ID=1 THEN text_messages||'' ''||note ');
                  sql.Add (' WHEN LOG_SOURCE_ID=2 THEN text_messages ');
                  sql.Add (' WHEN LOG_SOURCE_ID=5 THEN text_messages ');
                  sql.Add (' WHEN LOG_SOURCE_ID=11 THEN text_messages ');
                  sql.Add (' WHEN LOG_SOURCE_ID=12 THEN text_messages ');
                  sql.Add (' WHEN LOG_SOURCE_ID=-1 THEN text_messages ');    //все записи по тел.
                  sql.Add (' WHEN LOG_SOURCE_ID=10 THEN ''Пользователь ''||login_session||'' : ''||text_messages  ');
                  sql.Add (' WHEN LOG_SOURCE_ID=6 THEN case when type_cod=1 then ''1-один'' ');
                  sql.Add ('                                when type_cod=2 then ''2-два''  ');
                  sql.Add ('                                when type_cod=3 then ''3-три''  ELSE '''' end');
                  sql.Add (' WHEN LOG_SOURCE_ID=8 THEN login_session||'' : ''||(select messages_text from messages_ref mr where log_source_id=8 and ');
                  sql.Add (' mr.messages_id=a.type_cod   )');
                  sql.Add (' ELSE '''' ');
                  sql.Add (' END as sms_text ');
                  sql.Add (' from many_logs a ');
                  if (RB_ALLPH.Checked=False) and (inttostr(param)<>'-1')then
                  sql.Add (' where  PHONE_NUMBER='''+FPhoneNumber+''' and LOG_SOURCE_ID ='+inttostr(param)+' ');
                  if (RB_ALLPH.Checked=False) and (inttostr(param)='-1')then
                  sql.Add (' where  PHONE_NUMBER='''+FPhoneNumber+''' and 1=1');
                  if (RB_ALLPH.Checked=True) and (inttostr(param)<>'-1') then
                  sql.Add (' where  LOG_SOURCE_ID ='+inttostr(param)+' ');

                        if (CBBID.ItemIndex<>0) and (inttostr(param)<>'-1') then
                        sql.Add (' and trunc(date_on,''mm'')=to_date(''01''||to_char('+Inttostr(FBid)+'),''ddyyyymm'') order by PHONE_NUMBER, date_on desc ')
                        else
                        sql.Add (' order by PHONE_NUMBER, date_on desc ');
                        ExecSQL;
                        Open;

                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
                end;

        end;
end;

end.
