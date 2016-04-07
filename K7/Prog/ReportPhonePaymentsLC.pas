unit ReportPhonePaymentsLC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, IntecExportGrid, ActnList, ExecutingForm, sListBox, sCheckListBox;

type
  TReportPhonePaymentsFrmLC = class(TExecutingForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Payments: TCRDBGrid;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    cbSearch: TCheckBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    qReportLOGIN: TStringField;
    qReportCOMPANY_NAME: TStringField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_DATE: TDateTimeField;
    qReportPAYMENT_ACTIVATE_DATE: TDateTimeField;
    qReportPAYMENT_ORIGINAL_AMT: TStringField;
    qReportPAYMENT_CURRENT_AMT: TStringField;
    qReportBANK_PAYMENT_ID: TStringField;
    qReportPAYMENT_STATUS: TStringField;
    qReportPAYMENT_TYPE: TStringField;
    CLB_Accounts: TsCheckListBox;
    qReportTemplate: TOraQuery;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
  private
    FAccountAll:boolean;
    FAccidStr : string;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, Main
    , StrUtils, OraError;


procedure TReportPhonePaymentsFrmLC.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по детализации за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'',
      Payments, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportPhonePaymentsFrmLC.aRefreshExecute(Sender: TObject);
var
  where_statment : string;
  i : Integer;
  list : TStringList;
  Period : Integer;
begin
  Try
    if (not FAccountAll) and (FAccidStr = '') then
    begin
      MessageDlg('Необходимо выбрать хотя бы один счет!!!', mtWarning, [mbOK], 0);
      Exit;
    end;

    qReport.Close;

    qReport.SQL.Clear;
    qReport.SQL.Text := qReportTemplate.SQL.Text;

    where_statment := '';

    if not FAccountAll then
      Try
        list := TStringList.Create;
        list.Delimiter:=',';
        list.DelimitedText := FAccidStr;
        where_statment := where_statment + ' AND p.account_id in (';
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


    if cbPeriod.ItemIndex >= 0 then
      Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    else
      Period := -1;

    qReport.ParamByName('YEAR_MONTH').AsInteger := Period;

    qReport.Open;
  Except
   on e: eoraerror do
     MessageDlg('Ошибка при формировании отчета.'#13#10 + qReport.SQL.Text, mtError, [mbOK], 0);
  End;
end;

procedure TReportPhonePaymentsFrmLC.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportPhonePaymentsFrmLC.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    Payments.OptionsEx:=Payments.OptionsEx+[dgeSearchBar]
  else
    Payments.OptionsEx:=Payments.OptionsEx-[dgeSearchBar];
end;

procedure TReportPhonePaymentsFrmLC.CLB_AccountsClickCheck(Sender: TObject);
var
  i : integer;
begin
  if FAccountAll <> CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:= CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll := CLB_Accounts.Checked[0];
end;

procedure TReportPhonePaymentsFrmLC.CLB_AccountsExit(Sender: TObject);
var
  i : integer;
begin
  FAccidStr := '';
  if not FAccountAll then
    for i := 1 to CLB_Accounts.Items.Count - 1 do
      if CLB_Accounts.Checked[i] then
        FAccidStr := FAccidStr + IntToStr(integer(CLB_Accounts.Items.Objects[i]))+',';

  if not FAccountAll then
    FAccidStr := copy(FAccidStr, 1, Length(FAccidStr)-1);
end;

procedure TReportPhonePaymentsFrmLC.FormCreate(Sender: TObject);
var
  Sdvig : Integer;
begin
  // Период
  qPeriods.Open;
  while not qPeriods.EOF do
  begin
    cbPeriod.Items.AddObject(
      qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
      TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
      );
    qPeriods.Next;
  end;
  qPeriods.Close;
  if cbPeriod.Items.Count > 0 then
    cbPeriod.ItemIndex := 0;

  if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
  begin
    lAccount.Show;
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
  end
  else
  begin
    Sdvig := CLB_Accounts.Left + CLB_Accounts.Width;
    lAccount.Hide;
    CLB_Accounts.Hide;
    BitBtn1.Left:=BitBtn1.Left - Sdvig;
    BitBtn2.Left:=BitBtn2.Left - Sdvig;
    BitBtn3.Left:=BitBtn3.Left - Sdvig;
    cbSearch.Left:=cbSearch.Left - Sdvig;
    Label1.Left:=Label1.Left - Sdvig;
    cbPeriod.Left:=cbPeriod.Left - Sdvig;
  end;
end;

end.
