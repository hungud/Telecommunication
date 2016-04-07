unit ShowBalanceChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus,oraerror;

type
  TShowBalanceChangeForm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    cbAccounts: TComboBox;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    qAccounts: TOraQuery;
    dsReport: TDataSource;
    qreport: TOraQuery;
    PopupMenu1: TPopupMenu;
    aCheck: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    qUpdate: TOraQuery;
    BitBtn1: TBitBtn;
    aPayments: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure aRefreshExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aCheckExecute(Sender: TObject);
    procedure aPaymentsExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ShowBalanceChangeForm: TShowBalanceChangeForm;

procedure DoShowBalanceChange;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main, IntecExportGrid,showpayments;

procedure DoShowBalanceChange;
var ReportFrm : TShowBalanceChangeForm;
    Sdvig:integer;
begin
  //Отключаем таймер проверки выставление счетов (уменьшения баланса) на время работы с данными
  mainform.Timer1.Enabled:=false;
  ReportFrm:=TShowBalanceChangeForm.Create(Nil);
  try
    // Заполнение списка "Лиц.счет"
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(0));
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.cbAccounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
      if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
        ReportFrm.qReport.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
      else ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;

    ReportFrm.qReport.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
    //включаем таймер проверки выставление счетов (уменьшения баланса)
    mainform.Timer1.Enabled:=true;
    mainform.Timer1Timer(nil);
  end;
end;


procedure TShowBalanceChangeForm.aCheckExecute(Sender: TObject);
begin
  //Проставляем признак проверки
  if qReport.Active and (qReport.RecordCount > 0) then begin
    MainForm.OraSession.StartTransaction;
    Try
     qUpdate.Close;
     qUpdate.ParamByName('account_id').AsInteger:=qreport.FieldByName('account_id').AsInteger;
     if qreport.FieldByName('date_last_updated').IsNull then
       qUpdate.ParamByName('record_date').AsDateTime:=qreport.FieldByName('date_created').AsDateTime
     else qUpdate.ParamByName('record_date').AsDateTime:=qreport.FieldByName('date_last_updated').AsDateTime;
     qUpdate.Execute;
     MainForm.OraSession.Commit;
    Except
      on e: eoraerror do begin
        MainForm.OraSession.Rollback;
        MessageDlg('Ошибка проверки л/с.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    End;
  end;
  qReport.Close;
  qReport.Open;

end;

procedure TShowBalanceChangeForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Снижения балансов на лицевых счетах','',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowBalanceChangeForm.aPaymentsExecute(Sender: TObject);
begin
 if qReport.Active and (qReport.RecordCount > 0) then begin
   DoShowPayments(qreport.FieldByName('account_id').AsInteger,qreport.FieldByName('date_created').AsDateTime);
 end;
end;

procedure TShowBalanceChangeForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;


procedure TShowBalanceChangeForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
  end else
  begin
    qReport.ParamByName('ACCOUNT_ID').Clear;
  end;
end;


end.


