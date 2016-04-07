unit RefFixingBalances;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, ActnList,
  ShowUserStat, Grids, DBGrids, CRGrid, IntecExportGrid, DBTables, Main;

type
  TRefFixingBalancesFrm = class(TForm)
    qAccounts: TOraQuery;
    qFixPeriods: TOraQuery;
    qPeriods: TOraQuery;
    qPhoneBalances: TOraQuery;
    dsAccounts: TDataSource;
    dsPeriods: TDataSource;
    dsFixPeriods: TDataSource;
    dsPhoneBalances: TDataSource;
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbPeriod: TComboBox;
    cbSearch: TCheckBox;
    lAccount: TLabel;
    cbAccount: TComboBox;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    FixBalanceGrid: TCRDBGrid;
    Splitter1: TSplitter;
    Panel2: TPanel;
    btUnFix: TBitBtn;
    btFix: TBitBtn;
    lStatus: TLabel;
    qBalanceRows: TOraQuery;
    dsBalanceRows: TDataSource;
    spCalcBalanceRows: TOraStoredProc;
    pBalanceDetail: TPanel;
    pBalanceCaption: TPanel;
    BalanceRowGrid: TCRDBGrid;
    spGetFixMonthID: TOraStoredProc;
    qInsertFixMonth: TOraQuery;
    spInsertBalanceRow: TOraStoredProc;
    spDeleteFixMonth: TOraStoredProc;
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbAccountChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    function CheckPeriod(Period:integer):Integer;
    procedure dsPhoneBalancesDataChange(Sender: TObject; Field: TField);
    procedure btFixClick(Sender: TObject);
    procedure btUnFixClick(Sender: TObject);
  private
    CurrAccount:integer;
    CurrPeriod:integer;
  public

  end;

procedure DoFixBalance;

{var
  RefFixingBalancesFrm: TRefFixingBalancesFrm;   }

implementation

{$R *.dfm}

procedure DoFixBalance;
var ReportFrm : TRefFixingBalancesFrm;
begin
  ReportFrm := TRefFixingBalancesFrm.Create(Nil);
  try
    ReportFrm.cbAccount.Clear;
    ReportFrm.qAccounts.Open;
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.cbAccount.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        TObject(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    if ReportFrm.cbAccount.Items.Count > 0 then
      ReportFrm.cbAccount.ItemIndex := 0;
    ReportFrm.CurrAccount:=
      Integer(ReportFrm.cbAccount.Items.Objects[ReportFrm.cbAccount.ItemIndex]);
    ReportFrm.cbAccountChange(ReportFrm.cbAccount);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TRefFixingBalancesFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(Caption + ' за ' + cbPeriod.Text, '',
      FixBalanceGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefFixingBalancesFrm.aRefreshExecute(Sender: TObject);
begin
  qPhoneBalances.Close;
  qPhoneBalances.ParamByName('ACCOUNT_ID').AsInteger:=CurrAccount;
  qPhoneBalances.ParamByName('YEAR_MONTH').AsInteger:=CurrPeriod;
  qPhoneBalances.Open;
end;

procedure TRefFixingBalancesFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qPhoneBalances.Active and (qPhoneBalances.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qPhoneBalances.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;

procedure TRefFixingBalancesFrm.btFixClick(Sender: TObject);
begin
  try
    dsBalanceRows.Enabled:=false;
    MainForm.OraSession.StartTransaction;
    qInsertFixMonth.ParamByName('ACCOUNT_ID').AsInteger:=CurrAccount;
    qInsertFixMonth.ParamByName('FIX_YEAR_MONTH').AsInteger:=CurrPeriod;
    qInsertFixMonth.ExecSQL;
    dsPhoneBalances.DataSet.First;
    spInsertBalanceRow.Prepared:=true;
    spGetFixMonthID.ParamByName('PACCOUNT_ID').AsInteger:=CurrAccount;
    spGetFixMonthID.ParamByName('PFIX_YEAR_MONTH').AsInteger:=CurrPeriod;
    spGetFixMonthID.ExecSQL;
    spInsertBalanceRow.ParamByName('PFIX_YEAR_MONTH_ID').AsInteger:=
      spGetFixMonthID.ParamByName('RESULT').AsInteger;
    if spInsertBalanceRow.ParamByName('PFIX_YEAR_MONTH_ID').AsInteger>0 then begin
      spInsertBalanceRow.ParamByName('PBALANCE_DATE').AsDateTime:=
        dsPhoneBalances.DataSet.FieldByName('BALANCE_DATE').AsDateTime;
      while not(dsPhoneBalances.DataSet.Eof) do
      begin
        spInsertBalanceRow.ParamByName('PPHONE_NUMBER').AsString:=
          dsPhoneBalances.DataSet.FieldByName('PHONE_NUMBER').AsString;
        spInsertBalanceRow.ParamByName('PFIX_BALANCE').AsFloat:=
          dsPhoneBalances.DataSet.FieldByName('FIX_BALANCE').AsFloat;
        spInsertBalanceRow.ExecSQL;
        dsPhoneBalances.DataSet.Next;
      end;
      MainForm.OraSession.Commit;
    end
    else begin
      MainForm.OraSession.Rollback;
    end;
    dsBalanceRows.Enabled:=true;
    cbPeriodChange(cbPeriod);
  Except
    on E : Exception do
    begin
      MainForm.OraSession.Rollback;
      dsBalanceRows.Enabled:=true;
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TRefFixingBalancesFrm.btUnFixClick(Sender: TObject);
begin
  try
    MainForm.OraSession.StartTransaction;
    spDeleteFixMonth.Prepared:=true;
    spGetFixMonthID.ParamByName('PACCOUNT_ID').AsInteger:=CurrAccount;
    spGetFixMonthID.ParamByName('PFIX_YEAR_MONTH').AsInteger:=CurrPeriod;
    spGetFixMonthID.ExecSQL;
    spDeleteFixMonth.ParamByName('PACCOUNT_ID').AsInteger:=CurrAccount;
    spDeleteFixMonth.ParamByName('PFIX_YEAR_MONTH_ID').AsInteger:=
      spGetFixMonthID.ParamByName('RESULT').AsInteger;
    if spDeleteFixMonth.ParamByName('PFIX_YEAR_MONTH_ID').AsInteger>0 then begin
      spDeleteFixMonth.ExecSQL;
      MainForm.OraSession.Commit;
    end
    else begin
      MainForm.OraSession.Rollback;
    end;
    cbPeriodChange(cbPeriod);
  Except
    MainForm.OraSession.Rollback;
  end;
end;

procedure TRefFixingBalancesFrm.cbAccountChange(Sender: TObject);
var
  Account:integer;
begin
  if cbAccount.ItemIndex >= 0 then
    Account:=Integer(cbAccount.Items.Objects[cbAccount.ItemIndex])
  else
    Account:=-1;
  if qPeriods.ParamByName('ACCOUNT_ID').AsInteger <> Account then
  begin
    CurrAccount:=Account;
    qPeriods.ParamByName('ACCOUNT_ID').AsInteger:=CurrAccount;
    qPeriods.Open;
    while not qPeriods.EOF do
    begin
      cbPeriod.Items.AddObject(
        qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      qPeriods.Next;
    end;
    if cbPeriod.Items.Count > 0 then
      cbPeriod.ItemIndex := 0;
    CurrPeriod:=Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qPeriods.Close;
  end;
  cbPeriodChange(cbPeriod);
end;

procedure TRefFixingBalancesFrm.cbPeriodChange(Sender: TObject);
begin
  if cbPeriod.ItemIndex >= 0 then
    CurrPeriod:= Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    CurrPeriod:= -1;
  case CheckPeriod(CurrPeriod) of
    0:begin
        btFix.Enabled:=true;
        btUnFix.Enabled:=false;
        lStatus.Caption:='Период открыт';
      end;
    1:begin
        btFix.Enabled:=false;
        btUnFix.Enabled:=true;
        lStatus.Caption:='Период закрыт';
      end;
    2:begin
        btFix.Enabled:=false;
        btUnFix.Enabled:=false;
        lStatus.Caption:='Есть более поздние закрытые';
      end;
    else begin
           btFix.Enabled:=false;
           btUnFix.Enabled:=false;
         end;
  end;
  aRefresh.Execute;
end;

procedure TRefFixingBalancesFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    FixBalanceGrid.OptionsEx:=FixBalanceGrid.OptionsEx+[dgeSearchBar]
  else
    FixBalanceGrid.OptionsEx:=FixBalanceGrid.OptionsEx-[dgeSearchBar];
end;

function TRefFixingBalancesFrm.CheckPeriod(Period:integer):Integer;
var
  Check, Max:Integer;
begin
{ 0 - Открытый
  1 - Закрытый
  2 - Есть более поздний закрытый}
  Check:=-1;
  max:=-1;
  qFixPeriods.ParamByName('ACCOUNT_ID').AsInteger:=CurrAccount;
  qFixPeriods.Open;
  try
    while not qFixPeriods.EOF do
    begin
      if qFixPeriods.FieldByName('FIX_YEAR_MONTH').AsInteger=Period then
        Check:=1;
      if qFixPeriods.FieldByName('FIX_YEAR_MONTH').AsInteger>Max then
        Max:=qFixPeriods.FieldByName('FIX_YEAR_MONTH').AsInteger;
      qFixPeriods.Next;
    end;
  finally
    qFixPeriods.Close;
  end;
  if Max>Period then
      Check:=2
    else
      if Check=-1 then
        Check:=0;
  Result:=Check;
end;

procedure TRefFixingBalancesFrm.dsPhoneBalancesDataChange(Sender: TObject;
  Field: TField);
begin
  if dsBalanceRows.Enabled then
  begin
    qBalanceRows.Close;
    pBalanceCaption.Caption:='Расшифровка баланса номера '
      + qPhoneBalances.Fields.FieldByName('PHONE_NUMBER').AsString;
    spCalcBalanceRows.ParamByName('PPHONE_NUMBER').AsString:=
      qPhoneBalances.Fields.FieldByName('PHONE_NUMBER').AsString;
    spCalcBalanceRows.ParamByName('PBALANCE_DATE').AsDate:=
      qPhoneBalances.Fields.FieldByName('BALANCE_DATE').AsDateTime;
    spCalcBalanceRows.ExecProc;
    qBalanceRows.Open;
  end;
end;

end.
