unit ReportBalanceChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus,oraerror;

type
  TReportBalanceChangeForm = class(TForm)
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
    N2: TMenuItem;
    aPayments: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure aRefreshExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aPaymentsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ReportBalanceChangeForm: TReportBalanceChangeForm;


implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main, IntecExportGrid,showpayments;



procedure TReportBalanceChangeForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Изменения балансов','',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBalanceChangeForm.aPaymentsExecute(Sender: TObject);
begin
// if qReport.Active and (qReport.RecordCount > 0) then begin
//   DoShowPayments(qreport.FieldByName('account_id').AsInteger,qreport.FieldByName('date_created').AsDateTime);
// end;
end;

procedure TReportBalanceChangeForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;


procedure TReportBalanceChangeForm.cbAccountsChange(Sender: TObject);
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


procedure TReportBalanceChangeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportBalanceChangeForm.FormShow(Sender: TObject);
begin
    // Заполнение списка "Лиц.счет"
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

end;

end.


