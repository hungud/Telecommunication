unit ReportPotentialActivity;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sTooledit,  DateUtils, Math, oraerror, sListBox, sCheckListBox;

type
  TReportPotencialActivityFrm = class(TReportForm)
    lbl1: TLabel;
    qReportTemplate: TOraQuery;
    cbAccounts: TComboBox;
    cbYearMonth: TComboBox;
    qYearMonth: TOraQuery;
    CLB_Accounts: TsCheckListBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure btInfoAbonentClick(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    FAccountAll:boolean;
    FAccidStr : string;
  public
    { Public declarations }
  end;

implementation
uses StrUtils, ShowUserStat;

{$R *.dfm}

procedure TReportPotencialActivityFrm.aLoadInExcelExecute(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по потенциальной активности абонентов по ' + cbYearMonth.Text ,'',
        gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPotencialActivityFrm.aRefreshExecute(Sender: TObject);
var
  select_statment, where_statment : string;
  i : Integer;
  name, i_str : string;
  vMonthsBetween : Integer;
  list : TStringList;
begin
  Try
    if (not FAccountAll) and (FAccidStr = '') then
    begin
      MessageDlg('Необходимо выбрать хотя бы один счет!!!', mtWarning, [mbOK], 0);
      Exit;
    end;


    vMonthsBetween := cbYearMonth.ItemIndex;

    qReport.Close;

    qReport.SQL.Clear;
    qReport.SQL.Text := qReportTemplate.SQL.Text;
    //удаление динамических полей из Grid
    for i := 8 to gReport.Columns.Count-1 do
      gReport.Columns.Delete(gReport.Columns.Count-1);

    select_statment := '';
    where_statment := '';
    for i := 0 to vMonthsBetween do
    begin
      name := Copy(cbYearMonth.Items[i], 5, 2) + '_' + Copy(cbYearMonth.Items[i], 1, 4);
      i_str := IntToStr(i);
      select_statment := select_statment +' ,GET_AVG_PAY_ON_CONTRACT_DATE( '+#13#10+
                                           '                       t.phone_number '+#13#10+
                                           '                       ,t.CONTRACT_DATE'+#13#10+
                                           '                       ,nvl2(t.CONTRACT_DATE, null, last_day(ADD_MONTHS(sysdate, '+
                                                                            '-' +i_str +')))' +#13#10+
                                           '                       ,trunc(ADD_MONTHS(sysdate,-' + i_str +'), ''mm'' )' +#13#10+
                                           '                       ,last_day(ADD_MONTHS(sysdate,-' + i_str +')) ) '+
                        'Avg_pay_in_'+ name +  #13#10;

      select_statment := select_statment + ', GET_ACTIVE_BLOCK_COUNT ( '+#13#10+
                                           ' t.phone_number '+#13#10+
                                           ' , ADD_MONTHS(sysdate, -'+i_str +') '+#13#10+
                                           ' , null '+#13#10+
                                           ' , 0 '+#13#10+
                                         ' ) '+
                                         'Block_in_'+ name+  #13#10
                                         ;
    end;

    qReport.SQL.Text := AnsiReplaceStr(qReport.SQL.Text, '%SELECT_STATMENT%', select_statment);

    if not FAccountAll then
      Try
        list := TStringList.Create;
        list.Delimiter:=',';
        list.DelimitedText := FAccidStr;
        where_statment := where_statment + ' AND account_id in (';
        for i:=0 to list.Count-1 do
          if i < list.Count-1 then
            where_statment := where_statment + ':a' + IntToStr(i) + ','
          else
            where_statment := where_statment + ':a' + IntToStr(i) + ')';

        qReport.SQL.Text := AnsiReplaceStr(qReport.SQL.Text, '%WHERE_STATMENT%', where_statment);
        qReport.Prepare;

        for i:=0 to list.Count-1 do
          qReport.ParamByName('a'+IntToStr(i)).AsInteger := StrToInt(list.Strings[i]);
      Finally
        list.Free;
      end
    else
    begin
      qReport.SQL.Text :=  AnsiReplaceStr(qReport.SQL.Text, '%WHERE_STATMENT%', where_statment);
      qReport.Prepare;
    end;


    case cbAccounts.ItemIndex of
      0 : qReport.ParamByName('P_IS_COLLECTOR').Value := NULL;
      1 : qReport.ParamByName('P_IS_COLLECTOR').Value := 1;
      2 : qReport.ParamByName('P_IS_COLLECTOR').Value := 0;
    end;

    qReport.Open;

    for i := 8 to qReport.Fields.Count-1 do
    begin
      gReport.Columns.Add;
      gReport.Columns[i].FieldName := qReport.Fields[i].DisplayName;
      name := qReport.Fields[i].FieldName;

      //присовение имен динамическим полям
      if AnsiPos('PAY', name) > 0   then
        if i > 9 then
          name := Copy(name, 12, length(name)) + '|Ср.платеж'
        else
          name := 'Текущий месяц|Ср.платеж'
      else if AnsiPos ('BLOCK', name) > 0   then
        if i > 9 then
          name := Copy(name, 10, length(name)) +'|Кол-во блок.'
        else
          name := 'Текущий месяц|Кол-во блок.';

      gReport.Columns[i].Title.Caption := name;
    end;

    for i := 0 to gReport.Columns.Count-1 do
      gReport.Columns[i].Width := 100;

  Except
   on e: eoraerror do
     MessageDlg('Ошибка при формировании отчета.'#13#10 + qReport.SQL.Text, mtError, [mbOK], 0);
  End;
end;

procedure TReportPotencialActivityFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPotencialActivityFrm.btInfoAbonentClick(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPotencialActivityFrm.CLB_AccountsClickCheck(Sender: TObject);
var
  i : integer;
begin
  inherited;
  if FAccountAll <> CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:= CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll := CLB_Accounts.Checked[0];
end;

procedure TReportPotencialActivityFrm.CLB_AccountsExit(Sender: TObject);
var
  i : integer;
begin
  inherited;
  FAccidStr := '';
  if not FAccountAll then
    for i := 1 to CLB_Accounts.Items.Count - 1 do
      if CLB_Accounts.Checked[i] then
        FAccidStr := FAccidStr + IntToStr(integer(CLB_Accounts.Items.Objects[i]))+',';

  if not FAccountAll then
    FAccidStr := copy(FAccidStr, 1, Length(FAccidStr)-1);
end;

procedure TReportPotencialActivityFrm.FormCreate(Sender: TObject);
begin
  inherited;

  cbYearMonth.Clear;
  qYearMonth.Open;
  qYearMonth.First;
  while not qYearMonth.Eof do
  begin
    cbYearMonth.Items.Add(qYearMonth.FieldByName('year_month').AsString);
    qYearMonth.Next;
  end;
  qYearMonth.Close;

  if cbYearMonth.Items.Count > 0 then
    cbYearMonth.ItemIndex := 0;

  CLB_Accounts.Show;
  CLB_Accounts.Items.AddObject('Все', Pointer(-1));
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

end.
