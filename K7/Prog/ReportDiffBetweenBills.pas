unit ReportDiffBetweenBills;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid, sListBox, sCheckListBox, ShowUserStat;

type
  TReportDiffBetweenBillsFrm = class(TReportForm)
    CLB_Accounts: TsCheckListBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    cbbPeriod: TComboBox;
    lblPeriod: TLabel;
    qPeriods: TOraQuery;
    rgFilter: TRadioGroup;
    procedure CLB_AccountsClick(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure cbbPeriodChange(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
 procedure DoRepDiffBetweenBills;
var
  ReportDiffBetweenBillsFrm: TReportDiffBetweenBillsFrm;
  FAccid : string;
  FAccount : string;
  fShowOne : integer;
  record_count : integer;
  session_id : integer;
  last_date_rep : TDateTime;
  last_session_id : integer;

implementation

{$R *.dfm}

procedure DoRepDiffBetweenBills;
var
  ReportFrm  : TReportDiffBetweenBillsFrm;
begin
  try
    ReportFrm := TReportDiffBetweenBillsFrm.Create(Nil);
    ReportFrm.lAccount.Show;
    ReportFrm.CLB_Accounts.Show;
    //Период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger));

      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    ReportFrm.cbbPeriod.ItemIndex := 0;
    ReportFrm.cbbPeriodChange(ReportFrm.cbbPeriod);
    //л/с
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
    //показываем форму
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportDiffBetweenBillsFrm.aLoadInExcelExecute(Sender: TObject);
var
cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if FAccid <> '-1'  then
      ExportDBGridToExcel('Отчет "Сравнение выставленных счетов" по л/с :'+ Faccount + ' на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        gReport, False, True);
    if  FAccid = '-1'  then
      ExportDBGridToExcel('Отчет "Сравнение выставленных счетов" '+ FormatDateTime('dd.mm.yyyy', Date()),'',
                        gReport, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportDiffBetweenBillsFrm.aRefreshExecute(Sender: TObject);
var
  SqlOra : TOraQuery;
  Rep_Progress : Boolean;
  sql_text : string;
  YEAR_MONTH : integer;
  grFilerIdx : Integer;
begin
  if FAccid='' then
  begin
    if fShowOne = 1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne := 1;
    exit;
  end;
  if cbbPeriod.ItemIndex >= 0 then
    YEAR_MONTH := integer(cbbPeriod.Items.Objects[cbbPeriod.ItemIndex])
  else
    YEAR_MONTH := -1;
  grFilerIdx := rgFilter.ItemIndex;
  SqlOra := TOraQuery.Create(nil);
  qReport.Close;
  with qReport do
  begin
    try
      sql.Clear;
      sql_text:=' Select * from (select '+#13#10+
                '   D.ACCOUNT_ID, '+#13#10+
                '   t.phone_number, '+#13#10+
                '    round(d.bill_sum, 2) beeline_bill, '+#13#10+
                '    round(t.bill_summ, 2) tarifer_bill, '+#13#10+
                '    round((d.bill_sum  - t.bill_summ), 2) as razn_bill, ' +#13#10+
                '    round(D.CALLS, 2) beeline_call, '+#13#10+
                '    round(T.CALLS, 2) tarifer_call, '+#13#10+
                '    round((D.CALLS  - T.CALLS), 2) as razn_call ' +#13#10+
                ' from  '+#13#10+
                '    TARIFER_BILL_FOR_CLIENTS t, '+#13#10+
                '    db_loader_full_finance_bill d '+#13#10+
                ' where '+#13#10+
                '   T.PHONE_NUMBER = D.PHONE_NUMBER(+) '+#13#10+
                '   and T.YEAR_MONTH = D.YEAR_MONTH(+) '+#13#10+
                '  and T.YEAR_MONTH = :pYear_month' ;
      if FAccid <> '-1' then
        sql_text := sql_text +  ' and d.ACCOUNT_ID in ('+FAccid+')'+#13#10 ;

      sql_text := sql_text + ')'+#13#10;

      case rgFilter.ItemIndex of
        1 :  sql_text := sql_text + ' where (razn_bill > 0 OR razn_call > 0)';  //Больше нуля
        2 :  sql_text := sql_text + ' where (razn_bill <= 0 OR razn_call <= 0)'; //Меньше или равно нулю
      end;

      Params.CreateParam(ftInteger, 'pYear_month', ptInput);
      ParamByName('pYear_month').Value := YEAR_MONTH;
      sql.Add(sql_Text);
      Open;
    except
      on e : exception do
        MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TReportDiffBetweenBillsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
end;

procedure TReportDiffBetweenBillsFrm.cbbPeriodChange(Sender: TObject);
begin
  aRefreshExecute(Sender);
end;

procedure TReportDiffBetweenBillsFrm.CLB_AccountsClick(Sender: TObject);
var
  i : integer;
begin
  if (CLB_Accounts.Checked[0]=true) then
    FAccid:='-1'
  else if (CLB_Accounts.Checked[0]=false) then
    FAccid:='';
end;

procedure TReportDiffBetweenBillsFrm.CLB_AccountsClickCheck(Sender: TObject);
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

procedure TReportDiffBetweenBillsFrm.CLB_AccountsExit(Sender: TObject);
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
  if CLB_Accounts.Checked[0]=true then
  begin
    FAccid:='-1';
    FAccount:='-1';
  end;
end;

procedure TReportDiffBetweenBillsFrm.CLB_AccountsMouseMove(Sender: TObject;
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

end.
