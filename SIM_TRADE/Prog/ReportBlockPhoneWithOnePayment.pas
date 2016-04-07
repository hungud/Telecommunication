unit ReportBlockPhoneWithOnePayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, sListBox, sCheckListBox;

type
  TReportBlockPhoneWithOnePaymentFrm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qReport: TOraQuery;
    dsReport: TDataSource;
    CLB_Accounts: TsCheckListBox;
    cbAccParam_call: TComboBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;
  public
    { Public declarations }
  end;

var
  ReportBlockPhoneWithOnePaymentFrm: TReportBlockPhoneWithOnePaymentFrm;

procedure DoReportBlockPhoneWithOnePayment;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat, Main;

procedure DoReportBlockPhoneWithOnePayment;
var ReportFrm : TReportBlockPhoneWithOnePaymentFrm;
    Sdvig:integer;
begin
  ReportFrm:=TReportBlockPhoneWithOnePaymentFrm.Create(Nil);
  try
    ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    ReportFrm.qAccounts.Open;
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.CLB_Accounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
      );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    // Отчет
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportBlockPhoneWithOnePaymentFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет по выговорившим первый платеж по состоянию на '+DateToStr(Date),'',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBlockPhoneWithOnePaymentFrm.aRefreshExecute(Sender: TObject);
var
  s:TStringList;
  i:integer;
begin
  if not FAccountAll and (FAccid='') then
    begin
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
      exit;
    end;
  qReport.Close;
  qReport.SQL.Text:='SELECT * FROM V_BLOCKPHONE_WITH_ONEPAYMENT'+
                    ' WHERE (nvl(is_collector, 0) = :pIs_collector) OR (:pIs_collector is null)';

  if not FAccountAll then
    Try
     s:=TStringList.Create;
     s.Delimiter:=',';
     s.DelimitedText:=FAccid;
     qReport.SQL.Text:=qReport.SQL.Text + ' AND account_id in (';
     for i:=0 to s.Count-1 do
       if i < s.Count-1 then
         qReport.SQL.Text:=qReport.SQL.Text + ':a' + IntToStr(i) + ','
       else
        qReport.SQL.Text:=qReport.SQL.Text + ':a' + IntToStr(i) + ')';
     qReport.Prepare;
     for i:=0 to s.Count-1 do
       qReport.ParamByName('a'+IntToStr(i)).AsInteger:=StrToInt(s.Strings[i]);
    Finally
      s.Free;
    end;

  case cbAccParam_call.ItemIndex of
    0 : qReport.ParamByName('pIS_COLLECTOR').Value := null;
    1 : qReport.ParamByName('pIS_COLLECTOR').Value := 1;
    2 : qReport.ParamByName('pIS_COLLECTOR').Value := 0;
  end;

  qReport.SQL.Text:=qReport.SQL.Text + ' ORDER BY account_id, phone_number';
  qReport.Open;
end;

procedure TReportBlockPhoneWithOnePaymentFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;


procedure TReportBlockPhoneWithOnePaymentFrm.CLB_AccountsClickCheck(
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

procedure TReportBlockPhoneWithOnePaymentFrm.CLB_AccountsExit(Sender: TObject);
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

procedure TReportBlockPhoneWithOnePaymentFrm.CLB_AccountsMouseMove(
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

end.
