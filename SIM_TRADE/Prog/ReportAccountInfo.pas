unit ReportAccountInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus, oraerror, Vcl.ComCtrls;

type
  TReportAccountInfoForm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    cbAccounts: TComboBox;
    grData: TCRDBGrid;
    qAccounts: TOraQuery;
    dsReport: TDataSource;
    qreport: TOraQuery;
    qreportCOMPANY_NAME: TStringField;
    qreportACCOUNT_NUMBER: TFloatField;
    qreportBALANCE: TFloatField;
    qreportCOUNT_PHONE: TFloatField;
    qreportDATE_LAST_UPDATED: TDateTimeField;
    qreportPAYMENT_SUM_PREV: TFloatField;
    qreportPAYMENT_SUM_NOW: TFloatField;
    qreportLOGIN: TStringField;
    qAccounts_History: TOraQuery;
    qAccounts_HistoryID_ACCOUNT_INFO_HISTORY: TFloatField;
    qAccounts_HistoryACCOUNT_ID: TFloatField;
    qAccounts_HistoryBALANCE: TFloatField;
    qAccounts_HistoryCOUNT_PHONE: TFloatField;
    qAccounts_HistoryUSER_UPDATE: TStringField;
    qAccounts_HistoryDATE_UPDATE: TDateTimeField;
    pAccount_History: TPanel;
    spl1: TSplitter;
    dsAccount_History: TDataSource;
    gAccount_History: TCRDBGrid;
    qReportACCOUNT_ID: TFloatField;
    bLoadHistoryInExcel: TBitBtn;
    lbl1: TLabel;
    qAccounts_HistoryLOGIN: TStringField;
    lbl2: TLabel;
    dtDate: TDateTimePicker;
    procedure aRefreshExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure qAccounts_HistoryBeforeOpen(DataSet: TDataSet);
    procedure qreportAfterScroll(DataSet: TDataSet);
    procedure dtDateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ReportAccountInfoForm: TReportAccountInfoForm;

procedure DoReportAccountInfo;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid;

procedure DoReportAccountInfo;
var ReportFrm : TReportAccountInfoForm;
begin
  ReportFrm:=TReportAccountInfoForm.Create(Nil);
  try
    // Заполнение списка "Лиц.счет"
    with ReportFrm do begin
      lAccount.Show;
      cbAccounts.Show;
      qAccounts.Open;
      cbAccounts.Items.AddObject('Все', Pointer(0));
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
      if Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])<>0 then
        qReport.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
      else qReport.ParamByName('ACCOUNT_ID').Clear;

      qReport.Open;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;


procedure TReportAccountInfoForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
   if Sender = btLoadInExcel then
    ExportDBGridToExcel2('Информация о счетах','',
      grData, nil, False, True)
   else
   if Sender = bLoadHistoryInExcel then
    ExportDBGridToExcel2('Информация об истории изменения счета','',
      gAccount_History, nil, False, True)
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAccountInfoForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;


procedure TReportAccountInfoForm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account;
    aRefreshExecute(nil);
  end else
  begin
    qReport.ParamByName('ACCOUNT_ID').Clear;
    aRefreshExecute(nil);
  end;
end;

procedure TReportAccountInfoForm.dtDateChange(Sender: TObject);
begin
  if dtDate.Checked then begin
   qReport.SQL.Text:= qReport.SQLUpdate.Text;
   qReport.ParamByName('pDate_Update').AsDateTime:= dtDate.DateTime;
  end
  else
   qReport.SQL.Text:= qReport.SQLInsert.Text;

  //обновляем историю
  qReport.Close;
  qReport.Open;
end;

procedure TReportAccountInfoForm.FormShow(Sender: TObject);
begin
  dtDate.Date:= Now;
  dtDate.Checked:= False;
end;

procedure TReportAccountInfoForm.qAccounts_HistoryBeforeOpen(DataSet: TDataSet);
begin
  qAccounts_History.ParamByName('pACCOUNT_ID').AsInteger:=
    qReportACCOUNT_ID.AsInteger;
end;

procedure TReportAccountInfoForm.qreportAfterScroll(DataSet: TDataSet);
begin
  qAccounts_History.Close;
  qAccounts_History.Open;
end;

end.


