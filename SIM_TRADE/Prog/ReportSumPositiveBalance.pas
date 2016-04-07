unit ReportSumPositiveBalance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, sListBox,
  sCheckListBox, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ActnList, Data.DB, MemDS, DBAccess, Ora;

type
  TReportSumPositiveBalanceForm = class(TForm)
    Panel1: TPanel;
    btRefresh: TBitBtn;
    btLoadInExcel_Accounts: TBitBtn;
    cbPeriod: TComboBox;
    Label1: TLabel;
    clbAccounts: TsCheckListBox;
    lAccount: TLabel;
    qPeriods: TOraQuery;
    btInfoAbonent: TBitBtn;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    GridReport_Phones: TCRDBGrid;
    qAccounts: TOraQuery;
    cbWithoutContracts: TCheckBox;
    qReport_Accounts_Cont: TOraQuery;
    qReport_Phones_Cont: TOraQuery;
    Panel4: TPanel;
    Panel5: TPanel;
    dsReport_Phones: TDataSource;
    dsReport_Accounts: TDataSource;
    qReport_Accounts_ContLOGIN: TStringField;
    qReport_Accounts_ContBALANCE_ACTIVE: TFloatField;
    qReport_Accounts_ContBALANCE_NO_ACTIVE: TFloatField;
    qReport_Accounts_ContACCOUNT_ID: TFloatField;
    qReport_Accounts: TOraQuery;
    qReport_AccountsACCOUNT_ID: TFloatField;
    qReport_AccountsLOGIN: TStringField;
    qReport_AccountsBALANCE_ACTIVE: TFloatField;
    qReport_AccountsBALANCE_NO_ACTIVE: TFloatField;
    qReport_Phones_ContPHONE_NUMBER: TStringField;
    qReport_Phones_ContBALANCE_ACTIVE: TFloatField;
    qReport_Phones_ContBALANCE_NO_ACTIVE: TFloatField;
    qReport_Phones: TOraQuery;
    qReport_PhonesPHONE_NUMBER: TStringField;
    qReport_PhonesBALANCE_ACTIVE: TFloatField;
    qReport_PhonesBALANCE_NO_ACTIVE: TFloatField;
    btLoadInExcel_Phones: TBitBtn;
    GridReport_Accounts: TCRDBGrid;
    procedure clbAccountsClickCheck(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btLoadInExcel_PhonesClick(Sender: TObject);
    procedure btLoadInExcel_AccountsClick(Sender: TObject);
    procedure btInfoAbonentClick(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FDefaultSQL_Cont,FDefaultSQL:string;
  public
    { Public declarations }
  end;

  procedure DoReportSumPositiveBalance;

var
  ReportSumPositiveBalanceForm: TReportSumPositiveBalanceForm;


implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat;

procedure DoReportSumPositiveBalance;
var
  ReportFrm  : TReportSumPositiveBalanceForm;
begin
  ReportFrm := TReportSumPositiveBalanceForm.Create(Nil);

  try
    // Период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;

     ReportFrm.FDefaultSQL_Cont:=ReportFrm.qReport_Accounts_Cont.SQL.Text;
     ReportFrm.FDefaultSQL:=ReportFrm.qReport_Accounts.SQL.Text;
    //Л/с
    ReportFrm.qAccounts.Open;
    try
      ReportFrm.clbAccounts.Items.AddObject('Все',Pointer(-1));
      while not ReportFrm.qAccounts.Eof do
      begin
        ReportFrm.clbAccounts.Items.AddObject(
              ReportFrm.qAccounts.FieldByName('login').AsString+' ('+ReportFrm.qAccounts.FieldByName('company_name').AsString+')',
              Pointer(ReportFrm.qAccounts.FieldByName('account_id').AsInteger));
        ReportFrm.qAccounts.Next;
      end;
    finally
      ReportFrm.qAccounts.Close;
    end;
    ReportFrm.FAccountAll:=false;
    ReportFrm.ShowModal;

  finally
    ReportFrm.Free;
  end;
end;

procedure TReportSumPositiveBalanceForm.btLoadInExcel_AccountsClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Cуммы счетов и платежей по л/с за  ' + cbPeriod.Text,'',
      GridReport_Accounts, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportSumPositiveBalanceForm.btLoadInExcel_PhonesClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Cуммы счетов и платежей по номерам за  ' + cbPeriod.Text,'',
      GridReport_Phones, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportSumPositiveBalanceForm.btInfoAbonentClick(Sender: TObject);
begin
  if qReport_Phones.Active and (qReport_Phones.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport_Phones.FieldByName('PHONE_NUMBER').AsString, 0)
  else if qReport_Phones_Cont.Active and (qReport_Phones_Cont.RecordCount > 0) then
         ShowUserStatByPhoneNumber(qReport_Phones_Cont.FieldByName('PHONE_NUMBER').AsString, 0)
end;

procedure TReportSumPositiveBalanceForm.btRefreshClick(Sender: TObject);
var
 i: integer;
 s:string;
begin
  if clbAccounts.Checked[0] then
    s:=''
  else begin
    s:='(';
    for i := 1 to clbAccounts.Count-1 do
     if clbAccounts.Checked[i] then
       if s='(' then
         s:=s+':a'+inttostr(i)
       else
         s:=s+',:a'+inttostr(i);
    if s='(' then begin
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
      Exit;
    end;
    s:=' AND a.account_id IN '+s+')';
  end;

  qReport_Phones.Close;
  qReport_Phones_Cont.Close;
  qReport_Accounts_Cont.Close;
  qReport_Accounts.Close;
  if cbWithoutContracts.Checked then begin
    qReport_Accounts.SQL.Text:=FDefaultSQL+s+' ORDER BY a.login';
    qReport_Accounts.Prepare;
    if not clbAccounts.Checked[0] then
      for I := 1 to clbAccounts.Count-1 do
       if clbAccounts.Checked[i] then
         qReport_Accounts.ParamByName('a'+inttostr(i)).AsInteger:=integer(clbAccounts.Items.Objects[i]);
    qReport_Accounts.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    dsReport_Accounts.DataSet:=qReport_Accounts;
    qReport_Accounts.Open;
    dsReport_Phones.DataSet:=qReport_Phones;
    qReport_Phones.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport_Phones.Open;
  end
  else begin
    qReport_Accounts_Cont.SQL.Text:=FDefaultSQL_Cont+s+' ORDER BY a.login';
    qReport_Accounts_Cont.Prepare;
    if not clbAccounts.Checked[0] then
      for I := 1 to clbAccounts.Count-1 do
       if clbAccounts.Checked[i] then
         qReport_Accounts_Cont.ParamByName('a'+inttostr(i)).AsInteger:=integer(clbAccounts.Items.Objects[i]);
    qReport_Accounts_Cont.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    dsReport_Accounts.DataSet:=qReport_Accounts_Cont;
    qReport_Accounts_Cont.Open;
    dsReport_Phones.DataSet:=qReport_Phones_Cont;
    qReport_Phones_Cont.ParamByName('YEAR_MONTH').AsInteger := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
    qReport_Phones_Cont.Open;
  end;

end;

procedure TReportSumPositiveBalanceForm.clbAccountsClickCheck(Sender: TObject);
var
 i:integer;
begin
  if FAccountAll<>clbAccounts.Checked[0] then
    for i := 1 to clbAccounts.Count-1 do
      clbAccounts.Checked[i]:=clbAccounts.Checked[0]
  else
    clbAccounts.Checked[0]:=false;
  FAccountAll:=clbAccounts.Checked[0];

end;

end.
