unit ReportSendSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, MemDS, DBAccess, Ora, ComCtrls, ToolWin, Grids, DBGrids,
  CRGrid, IntecExportGrid, ShowUserStat, StdCtrls, Buttons,
  ExtCtrls;

type
  TReportSendSmsFrm = class(TForm)
    dsSendSms: TDataSource;
    qSendSms: TOraQuery;
    GrData: TCRDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    qAccounts: TOraQuery;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    pAccount: TPanel;
    pPeriod: TPanel;
    pButton: TPanel;
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    Label3: TLabel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure SetPeriodDateValue(DateFrom : TDate; DateTo : TDate);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TReportSendSmsFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TReportSendSmsFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qSendSms.SQL.Insert(9, 'AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TReportSendSmsFrm.FormShow(Sender: TObject);
begin
  if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
  begin
    pAccount.Visible := True;
    qAccounts.Open;
    while not qAccounts.EOF do
    begin
      cbAccounts.Items.AddObject(
        qAccounts.FieldByName('LOGIN').AsString,
        Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
      qAccounts.Next;
    end;
    qAccounts.Close;
    if cbAccounts.Items.Count > 0 then
      cbAccounts.ItemIndex := 0;
    qSendSms.ParamByName('ACCOUNT_ID').asInteger :=
      Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex]);
  end else
  begin
    pAccount.Visible := False;
    qSendSms.ParamByName('ACCOUNT_ID').Clear;
  end;

  if GetConstantValue('REPORTS_USE_PERIODS')='1' then
  begin
    dtFrom.Date := Date;
    dtTo.Date := Date;
    pPeriod.Visible := True;

    SetPeriodDateValue(dtFrom.Date, dtTo.Date);
  end else
  begin
    pPeriod.Visible := False;
    SetPeriodDateValue(0, 0);
  end;
  qSendSms.Open;
end;

procedure TReportSendSmsFrm.SetPeriodDateValue(DateFrom, DateTo: TDate);
begin
  if (DateFrom <> 0) AND (DateTo <> 0) then
  begin
    qSendSms.ParamByName('DATE_FROM').AsDate := DateFrom;
    qSendSms.ParamByName('DATE_TO').AsDate := DateTo;
  end
  else
  begin
    qSendSms.ParamByName('DATE_FROM').Value := Null;
    qSendSms.ParamByName('DATE_TO').Value := Null;
  end;
end;

procedure TReportSendSmsFrm.aRefreshExecute(Sender: TObject);
begin
  qSendSms.Close;

  if pPeriod.Visible then
  begin
    if dtFrom.Date > dtTo.Date then
    begin
      ShowMessage('Начало периода должно быть больше окончания!!!');
      Exit;
    end;
    SetPeriodDateValue(dtFrom.Date, dtTo.Date);
  end
  else
    SetPeriodDateValue(0, 0);
  qSendSms.Open;
end;

procedure TReportSendSmsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qSendSms.Active and (qSendSms.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qSendSms.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportSendSmsFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qSendSMS.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefresh.Execute;
  end;
end;

procedure TReportSendSmsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportSendSmsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Журнал отправленных СМС','', GrData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

end.
