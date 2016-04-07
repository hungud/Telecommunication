unit ShowBalanceChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Vcl.Menus, Vcl.ActnList,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, sListBox, sCheckListBox, ChildFrm,
  sComboBox, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sBevel, sSpeedButton, sLabel,
  sPanel, Vcl.ComCtrls, sStatusBar, sSplitter, DMUnit, Func_Const, TimedMsgBox,
  Data.DB, MemDS, DBAccess, Ora, OraError;

type
  TShowBalanceChangeForm = class(TRepFrm)
    qUpdate: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure aInfoExecute(Sender: TObject);
    procedure aCheckedAllExecute(Sender: TObject);
    procedure aUncheckedAllExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ShowBalanceChangeForm: TShowBalanceChangeForm;

procedure DoShowModalBalanceChange;

implementation

{$R *.dfm}

procedure DoShowModalBalanceChange;
var
  ReportFrm : TChildForm;
begin
  ReportFrm := TShowBalanceChangeForm.Create(nil, ReportFrm, 'Снижение баланса на лицевом счете', True);
  try
    TShowBalanceChangeForm(ReportFrm).ShowModal;
  finally
    TShowBalanceChangeForm(ReportFrm).Free;
  end;
end;

procedure TShowBalanceChangeForm.aCheckedAllExecute(Sender: TObject);
begin
  inherited;
  CLB_AccountsClickCheck(Sender);
end;

procedure TShowBalanceChangeForm.aInfoExecute(Sender: TObject);
begin
  if GlQuery.Active and (GlQuery.RecordCount > 0) then
  begin
    dm.OraSession.StartTransaction;
    Try
     qUpdate.Close;
     qUpdate.ParamByName('account_id').AsInteger := GlQuery.FieldByName('account_id').AsInteger;
     if GlQuery.FieldByName('date_last_updated').IsNull then
       qUpdate.ParamByName('record_date').AsDateTime := GlQuery.FieldByName('date_created').AsDateTime
     else
       qUpdate.ParamByName('record_date').AsDateTime := GlQuery.FieldByName('date_last_updated').AsDateTime;
     qUpdate.Execute;
     dm.OraSession.Commit;
    Except
      on e: eoraerror do
      begin
        dm.OraSession.Rollback;
        MessageDlg('Ошибка проверки л/с.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    End;
  end;
  aRefresh.Execute;
end;

procedure TShowBalanceChangeForm.aUncheckedAllExecute(Sender: TObject);
begin
  inherited;
  CLB_AccountsClickCheck(Sender);
end;

procedure TShowBalanceChangeForm.CLB_AccountsClickCheck(Sender: TObject);
begin
  inherited;
  SQL_Param := 'and b.account_id in (' + FAccid + ')';
  Zagolovok_Excel := 'Отчет по снижению баланса на лицевом счете ' + FAccount;

end;

procedure TShowBalanceChangeForm.FormCreate(Sender: TObject);
begin
  Name_File_Excel := 'Снижение баланса на лицевом счете';
  SQL_Text := 'SELECT a.account_id, a.login, b.balance, b.lag_balance, b.date_created, '+
              ' b.date_last_updated, b.user_last_updated FROM (SELECT ACCOUNT_ID, BALANCE, '+
              ' LAG(balance) OVER (PARTITION BY account_id ORDER BY NVL(date_last_updated,date_created)) lag_balance, '+
              ' date_created, date_last_updated, user_last_updated FROM balance_change) b, accounts a ' +
              ' WHERE a.account_id = b.account_id AND b.user_last_updated IS NULL ';
  SQL_Param := 'and b.account_id = -1 ';
  SQL_Sort := 'ORDER BY a.account_id';
  GlQuery := dm.qReport;
  CLBAccounts := True;
  inherited;

end;

end.
