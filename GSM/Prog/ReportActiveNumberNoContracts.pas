unit ReportActiveNumberNoContracts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, main,
  ActnList, StdCtrls, Buttons, IntecExportGrid, ContractsRegistration_Utils,
  sCheckListBox, ShowUserStat, sListBox;

type
  TReportActiveNumberNoContractsFrm = class(TForm)
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
    cbSearch: TCheckBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    CLB_Accounts: TsCheckListBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure grDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;
  public
    { Public declarations }
  end;

procedure DoReportActiveNumberNoContracts;

implementation

{$R *.dfm}

procedure DoReportActiveNumberNoContracts;
var ReportFrm : TReportActiveNumberNoContractsFrm;
    Sdvig:integer;
begin
  ReportFrm := TReportActiveNumberNoContractsFrm.Create(Nil);
 // begin
    ReportFrm.lAccount.Show;
   // ReportFrm.cbAccounts.Show;
    ReportFrm.qAccounts.Open;
    //ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
    ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.CLB_Accounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
      );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;

  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportActiveNumberNoContractsFrm.aRefreshExecute(Sender: TObject);
begin
  if not FAccountAll and (FAccid='') then
    begin
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
      exit;
    end;
  qReport.Close;
  qReport.SQL.Text:='SELECT  '#13#10+
  'V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER, '#13#10+
  'GET_ABONENT_BALANCE(V_ACTIVE_NUMBERS_OUT_CONTRACTS.PHONE_NUMBER) BALANCE,'#13#10+
  'V_ACTIVE_NUMBERS_OUT_CONTRACTS.company_name,'#13#10+
  'V_ACTIVE_NUMBERS_OUT_CONTRACTS.login'#13#10+
  'FROM '#13#10+
  'V_ACTIVE_NUMBERS_OUT_CONTRACTS' ;

  if not FAccountAll then
    qReport.SQL.Text:=qReport.SQL.Text+' where ACCOUNT_ID in ('+FAccid+') ';
  qReport.Open;
end;

procedure TReportActiveNumberNoContractsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Активные номера без контрактов','', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportActiveNumberNoContractsFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportActiveNumberNoContractsFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  {if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;  }
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end else
  begin
    qReport.ParamByName('ACCOUNT_ID').Clear;
    aRefresh.Execute;
  end;
end;

procedure TReportActiveNumberNoContractsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportActiveNumberNoContractsFrm.CLB_AccountsClickCheck(
  Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];

end;

procedure TReportActiveNumberNoContractsFrm.CLB_AccountsExit(Sender: TObject);
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

procedure TReportActiveNumberNoContractsFrm.CLB_AccountsMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
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

procedure TReportActiveNumberNoContractsFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qReport.SQL.Append('AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE V_ACTIVE_NUMBERS_OUT_CONTRACTS.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TReportActiveNumberNoContractsFrm.grDataKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) then
    aShowUserStatInfo.Execute();
end;

end.
