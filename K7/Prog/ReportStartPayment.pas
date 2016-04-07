unit ReportStartPayment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, sListBox, sCheckListBox, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sTooledit;

type
  TReportStartPaymentForm = class(TReportForm)
    lAccount: TLabel;
    CLB_Accounts: TsCheckListBox;
    qAccounts: TOraQuery;
    grData: TCRDBGrid;
    qAccounts_Allow: TOraQuery;
    Label1: TLabel;
    eBeginDate: TsDateEdit;
    Label2: TLabel;
    eEndDate: TsDateEdit;
    qReportACCOUNT_ID: TFloatField;
    qReportLOGIN: TStringField;
    qReportCOMPANY_NAME: TStringField;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENT_SUM: TFloatField;
    qReportPAYMENT_DATE_TIME: TDateTimeField;
    qReportCONTRACT_DATE: TDateTimeField;
    qReportSTART_BALANCE: TFloatField;
    qReportCONTRACT_CANCEL_DATE: TDateTimeField;
    procedure aRefreshExecute(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);

  private
    { Private declarations }
        FAccountAll:boolean;
        BeginDate,EndDate:string;
        FAccid : string;
  public
    { Public declarations }
  end;

  procedure DoReportStartPayment;
var
  ReportStartPaymentForm: TReportStartPaymentForm;

implementation

{$R *.dfm}

uses main,IntecExportGrid,ShowUserStat;

function CheckDate(begin_date,end_date:TDate):boolean;
var
  d,m,y:word;
begin
  result:=false;
  if begin_date > end_date then
  begin
    MessageDlg('Начальная дата не может быть больше конечной даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then
  begin
    MessageDlg('Начальная дата не может быть больше текущей даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  decodedate(IncMonth(Now,-2),y,m,d);
  //if begin_date < encodedate(y,m,1) then
  //begin
  //  MessageDlg('Начальная дата не может отличаться от текущей больше чем на 2 месяца!', mtConfirmation, [mbOK], 0);
  //  exit;
  //end;
  result:=true;
end;

procedure TReportStartPaymentForm.CLB_AccountsExit(Sender: TObject);
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

procedure TReportStartPaymentForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  inherited;
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];
end;

procedure DoReportStartPayment;
var
  ReportFrm : TReportStartPaymentForm;
begin
  ReportFrm := TReportStartPaymentForm.Create(Nil);
  try
    ReportFrm.eBeginDate.Text:=datetostr(Now-1);
    ReportFrm.eEndDate.Text:=datetostr(Now);
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
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportStartPaymentForm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчет по поступившим стартовым платежам '+BeginDate+' - '+EndDate,'', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportStartPaymentForm.aRefreshExecute(Sender: TObject);
var sql_text: string;
begin
  //qReport.Close;
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;
  BeginDate := eBeginDate.Text;
  EndDate := eEndDate.Text;
  Try
    if (BeginDate = '  .  .    ') or (EndDate = '  .  .    ') then
    begin
      MessageDlg('Укажите начальную и конечную дату!', mtConfirmation, [mbOK], 0);
      exit;
    end;
    if not CheckDate(StrToDate(BeginDate),StrToDate(EndDate)) then
      Exit;

    qReport.Close;
    qReport.SQL.Text:='SELECT * FROM v_RECEIVED_PAYMENTS_type_141';
    if not FAccountAll then
      qReport.SQL.Text:=qReport.SQL.Text+'where account_id in ('+FAccid+') ' +
      ' and (PAYMENT_DATE_TIME>=:DATE_BEGIN  and PAYMENT_DATE_TIME<=:DATE_END)'
    else
      qReport.SQL.Text:=qReport.SQL.Text+'where (PAYMENT_DATE_TIME>=:DATE_BEGIN  and PAYMENT_DATE_TIME<=:DATE_END)';
    qReport.Prepare;
    //if FAccountAll then
    qReport.ParamByName('DATE_BEGIN').AsDate:=StrToDate(BeginDate);
    qReport.ParamByName('DATE_END').AsDate:=StrToDate(EndDate);
    //showmessage(FAccid);
    //Showmessage (qReport.SQL.Text);
    qReport.Open;
  Except
    {on e: eoraerror do
      MessageDlg('Ошибка при формировании отчета.'#13#10 + e.Message, mtError, [mbOK], 0);     }
  End;
end;

procedure TReportStartPaymentForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
end;

procedure TReportStartPaymentForm.CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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
