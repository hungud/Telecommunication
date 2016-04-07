unit ReportGuarantContribut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls,IntecExportGrid, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sTooledit, sListBox, sCheckListBox;

type
  TReportGuarantContributForm = class(TReportForm)
    CLB_Accounts: TsCheckListBox;
    Label1: TLabel;
    qAccounts: TOraQuery;
    qReportPHONE_NUMBER: TStringField;
    qReportSTATUS_GUARANT_FEE: TStringField;
    qReportSUM_GUARANT_FEE: TFloatField;
    qReportPAID: TFloatField;
    qReportRETURNED: TFloatField;
    qReportWITHDRAWN: TFloatField;
    qReportNOT_PAID: TFloatField;
    qReportDATA_CREATED: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportDATA_UPDATE: TDateTimeField;
    qReportUSER_UPDATE: TStringField;
    btInfoAbonent: TBitBtn;
    aShowUserStatInfo: TAction;
    cbPeriod: TComboBox;
    qReportYEAR_MONTH: TFloatField;
    qDistYear: TOraQuery;
    Label2: TLabel;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportBILL_NUMBER: TStringField;
    BitBtn1: TBitBtn;
    spLOAD_DEPOSITS_FROM_SITE: TOraStoredProc;
    aLoadFromSite: TAction;
    qReportLOGIN: TStringField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aLoadFromSiteExecute(Sender: TObject);

  private
    { Private declarations }

    FAccountAll:boolean;
    BeginDate,EndDate, Period:string;
    FAccid : string;
  public
    { Public declarations }
  end;
 procedure DoReportGuarantContributForm;


var
  ReportGuarantContributForm: TReportGuarantContributForm;

implementation

{$R *.dfm}
uses main, ShowUserStat;


procedure DoReportGuarantContributForm;
var
  ReportFrm : TReportGuarantContributForm;
begin
  ReportFrm:=TReportGuarantContributForm.Create(Nil);
  try
    //заполнение лицевых счетов
    // ReportFrm.CLB_Accounts.Show;
    ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
    ReportFrm.qAccounts.Open;
    while not ReportFrm.qAccounts.EOF do
    begin
      ReportFrm.CLB_Accounts.Items.AddObject(
       ReportFrm.qAccounts.FieldByName('LOGIN').AsString +'/ '+ ReportFrm.qAccounts.FieldByName('ACCOUNT_NUMBER').AsString,
        Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
      );
      ReportFrm.qAccounts.Next;
    end;
    ReportFrm.qAccounts.Close;
    //период
    ReportFrm.qDistYear.Open;
    while not ReportFrm.qDistYear.EOF do
    begin
      ReportFrm.cbPeriod.Items.Add(inttostr(ReportFrm.qDistYear.FieldByName('YEAR_MONTH').Asinteger));
      ReportFrm.qDistYear.Next;
    end;

    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex:=0;

    ReportFrm.qDistYear.Close;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;


procedure TReportGuarantContributForm.aLoadFromSiteExecute(Sender: TObject);
begin
  inherited;
  spLOAD_DEPOSITS_FROM_SITE.ExecProc;
  aRefreshExecute(Sender);
  MessageBox(Handle, PChar(Caption), 'Данные обновлены' , MB_ICONINFORMATION + MB_OK);
end;

procedure TReportGuarantContributForm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчет по гарантийному взносу ','', gReport, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportGuarantContributForm.aRefreshExecute(Sender: TObject);
begin
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;

  Period:= cbPeriod.Text;
  TRY
    qReport.Close;
    qReport.SQL.Text:='SELECT  '+#13#10 +
                      '  ACCOUNT_ID,'+#13#10 +
                      '  to_char(BILL_NUMBER) BILL_NUMBER,'+#13#10 +   //преобразуем в строку для корректной выгрузки в Excel
                      '  DATE_CREATED,'+#13#10 +
                      '  DATE_UPDATE,'+#13#10 +
                      '  GUARANTEE_FEES_ID,'+#13#10 +
                      '  NOT_PAID,'+#13#10 +
                      '  PAID,'+#13#10 +
                      '  PHONE_NUMBER,  '+#13#10 +
                      '  RETURNED,'+#13#10 +
                      '  STATUS_GUARANT_FEE,'+#13#10 +
                      '  SUM_GUARANT_FEE,             '+#13#10 +
                      '  USER_CREATED,'+#13#10 +
                      '  USER_UPDATE,'+#13#10 +
                      '  WITHDRAWN,'+#13#10 +
                      '  YEAR_MONTH,'+#13#10 +
                      '  ACCOUNT_NUMBER,'+#13#10 +
                      '  Login'+#13#10 +
                      ' FROM'+#13#10 +
                      ' V_GUARANTEE_FEES'+#13#10 +
                      ' where YEAR_MONTH = :Period';
    if not FAccountAll then
     //если выбраны все или несколько л.с
      qReport.SQL.Text:=qReport.SQL.Text+'and account_id in ('+FAccid+')'
    else
      qReport.Prepare;

    qReport.ParamByName('Period').Asinteger := StrToInt(Period);
    qReport.Open;
  Except
    on E:Exception do
      MessageBox(Handle, 'Ошибка при попытке выполнить запрос!!!', PCHAR(E.Message), MB_ICONERROR + MB_OK);
  END;
end;



procedure TReportGuarantContributForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportGuarantContributForm.CLB_AccountsClickCheck(Sender: TObject);
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

procedure TReportGuarantContributForm.CLB_AccountsExit(Sender: TObject);
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
procedure TReportGuarantContributForm.CLB_AccountsMouseMove(Sender: TObject;
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
