unit ReportCreditNumber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid, sListBox, sCheckListBox, ShowUserStat;

type
  TReportCreditNumberFrm = class(TReportForm)
    cbbPeriod: TComboBox;
    qPeriods: TOraQuery;
    lblPeriod: TLabel;
    lblAccount: TLabel;
    lstCLB_Accounts: TsCheckListBox;
    qAccounts: TOraQuery;
    qcredit_phone: TOraQuery;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure cbbPeriodChange(Sender: TObject);
    procedure lstCLB_AccountsClickCheck(Sender: TObject);
    procedure lstCLB_AccountsExit(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);

  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;
  public
    { Public declarations }
  end;

  procedure  DoReportCreditNumber;

var
  ReportCreditNumberFrm: TReportCreditNumberFrm;

implementation

{$R *.dfm}
uses Main;

procedure  DoReportCreditNumber;
var
  ReportFrm : TReportCreditNumberFrm;
begin
  ReportFrm:=TReportCreditNumberFrm.Create(Nil);
  try
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

    ReportFrm.qAccounts.Open;
    ReportFrm.lstCLB_Accounts.Items.AddObject('Все',Pointer(-1));
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.lstCLB_Accounts.Items.AddObject(
        ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    //показываем форму
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportCreditNumberFrm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт по кредитным номерам после выставления счета'+  ' на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        gReport, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportCreditNumberFrm.lstCLB_AccountsClickCheck(Sender: TObject);
var i: integer;
begin
  if FAccountAll<>lstCLB_Accounts.Checked[0] then
    for i := 1 to lstCLB_Accounts.Count-1 do
      lstCLB_Accounts.Checked[i]:=lstCLB_Accounts.Checked[0]
  else
    lstCLB_Accounts.Checked[0]:=false;

  FAccountAll:=lstCLB_Accounts.Checked[0];
end;

procedure TReportCreditNumberFrm.lstCLB_AccountsExit(Sender: TObject);
var
  i: integer;
  s : String;
begin
  FAccid:='';
  if not FAccountAll then
    for i := 1 to lstCLB_Accounts.Items.Count - 1 do
      if lstCLB_Accounts.Checked[i] then
        FAccid:= FAccid+inttostr(integer(lstCLB_Accounts.Items.Objects[i]))+',';

  if not FAccountAll then
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
end;

procedure TReportCreditNumberFrm.cbbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbbPeriod.ItemIndex >= 0 then
    Period := Integer(cbbPeriod.Items.Objects[cbbPeriod.ItemIndex])
  else
    Period := -1;

  qReport.ParamByName('pYEAR_MONTH').AsInteger := Period;
end;

procedure TReportCreditNumberFrm.aRefreshExecute(Sender: TObject);
begin
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;

  try
    qReport.Close;
    qReport.SQL.Text:= qcredit_phone.SQL.Text;

    if not FAccountAll then
      qReport.SQL.Text:=qReport.SQL.Text+' and A.ACCOUNT_ID in ('+FAccid+') ';

    qReport.Open;
  except
    on e: exception do
      MessageDlg('Ошибка при формировании отчета.'#13#10 + e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TReportCreditNumberFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString,0);
end;

end.
