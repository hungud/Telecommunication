unit ReportAbonTarifer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, sListBox, sCheckListBox, IntecExportGrid, ShowUserStat;

type
  TReportAbonTariferFrm = class(TReportForm)
    CLB_Accounts: TsCheckListBox;
    qAccounts: TOraQuery;
    qPeriod: TOraQuery;
    cbbPeriod: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbPrCollector: TComboBox;
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aRefreshExecute(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
procedure DoReportAbonTarifer;
var
  ReportAbonTariferFrm: TReportAbonTariferFrm;
  FAccid : string;
  FAccount : string;
  FAccountAll:boolean;
  fShowOne : integer;
implementation

{$R *.dfm}

procedure DoReportAbonTarifer;
var
  ReportFrm : TReportAbonTariferFrm;
  Sdvig:INTEGER;
  i: integer;
begin
  ReportFrm := TReportAbonTariferFrm.Create(Nil);
  try
    //заполнение номеров счетов
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
    //заполнение периодов
    ReportFrm.qPeriod.Open;
    while not ReportFrm.qPeriod.EOF do
    begin
      ReportFrm.cbbPeriod.Items.AddObject(
        ReportFrm.qPeriod.FieldByName('YEAR_MONTH').AsString,
        TObject(ReportFrm.qPeriod.FieldByName('YEAR_MONTH').AsInteger));
      ReportFrm.qPeriod.Next;
    end;
    ReportFrm.qPeriod.Close;
    ReportFrm.cbbPeriod.ItemIndex := 0;
   //ReportFrm.cbbPeriodChange(ReportFrm.cbbPeriod);
    ReportFrm.cbbPeriod.ItemIndex := 0;
    ReportFrm.cbbPrCollector.ItemIndex := 0;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportAbonTariferFrm.aLoadInExcelExecute(Sender: TObject);
var
  cr : TCursor;
  period: string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчет по абон.платам, выставленным тарифером за период' ,'',
                        gReport, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAbonTariferFrm.aRefreshExecute(Sender: TObject);
var
 SqlOra : TOraQuery;
begin
  inherited;
  if not FAccountAll and (FAccid='') then
  begin
    MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    exit;
  end;
  try
   qReport.Close;
   qReport.SQL.Clear;
   qReport.SQL.Text:= 'select AC.ACCOUNT_NUMBER,  ac.login, '+ #10#13 +
                       ' t.phone_number, t.abon_tp as "Абон. ТП", t.abon_add as "Абон. усл" , '+ #10#13 +
                       'case  '+  #10#13 +
                       ' when AC.IS_COLLECTOR = 1 then ''Коллектор'' '+ #10#13 +
                       ' else ''Не коллектор'' '+ #10#13 +
                       ' end as collector '+  #10#13 +
                       ' from TARIFER_BILL_FOR_CLIENTS t,  db_loader_account_phones d, accounts ac'+  #10#13 +
                       ' where t.year_month = :pYear_month '+ #10#13 +
                       ' and T.PHONE_NUMBER = D.PHONE_NUMBER '+ #10#13 +
                       ' and T.YEAR_MONTH = D.YEAR_MONTH  and D.ACCOUNT_ID = AC.ACCOUNT_ID ';
   if not FAccountAll then
     qReport.SQL.Text:=qReport.SQL.Text+ #10#13 +' AND d.ACCOUNT_ID IN ('+FAccid+') ';
   if  cbbPrCollector.ItemIndex = 1 then
     qReport.SQL.Text:=qReport.SQL.Text+ #10#13 +' and AC.IS_COLLECTOR = 1 ';
   if cbbPrCollector.ItemIndex = 2 then
     qReport.SQL.Text:=qReport.SQL.Text+ #10#13 +' and ( AC.IS_COLLECTOR = 0 or AC.IS_COLLECTOR is null ) ';
   qReport.SQL.Text:=qReport.SQL.Text+ #10#13 +'order by t.phone_number ';
   qReport.ParamByName('pYEAR_MONTH').AsInteger := Integer(cbbPeriod.Items.Objects[cbbPeriod.ItemIndex]);
   qReport.Open
  except
    on e: exception do
      MessageDlg('Ошибка при формировании отчета.'#13#10 + e.Message, mtError, [mbOK], 0);
  end;
end;

//подробно
procedure TReportAbonTariferFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
end;

Procedure TReportAbonTariferFrm.CLB_AccountsClickCheck(Sender: TObject);
var
  i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];
end;

procedure TReportAbonTariferFrm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
  s : String;
begin
  FAccid:='';
  if not FAccountAll then
    for i := 1 to CLB_Accounts.Items.Count - 1 do
      if CLB_Accounts.Checked[i] then
        FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
  if not FAccountAll then
    FAccid:=copy(FAccid,1,Length(FAccid)-1);
end;

procedure TReportAbonTariferFrm.CLB_AccountsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  xPoint: TPoint;
  xIndex: Integer;
begin
  xPoint.X := X;
  xPoint.Y := Y;
  xIndex := CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then
  begin
    CLB_Accounts.Hint := CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else
    Application.CancelHint;
end;

end.
