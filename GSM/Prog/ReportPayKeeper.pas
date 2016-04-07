unit ReportPayKeeper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Main, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ActnList;

type
  TPayKeeperFrm = class(TForm)
    p1: TPanel;
    pFilter: TPanel;
    pMain: TPanel;
    dtDateBegin: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    lbl1: TLabel;
    lbl2: TLabel;
    actlstList: TActionList;
    aRefresh: TAction;
    aLoadInExcel: TAction;
    aShowUSerStat: TAction;
    btRefresh: TBitBtn;
    btLoadInExcel: TBitBtn;
    btShowUserStat: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    gPayments: TCRDBGrid;
    gLog: TCRDBGrid;
    qPayments: TOraQuery;
    qLog: TOraQuery;
    dsPayments: TDataSource;
    dsLog: TDataSource;
    qPaymentsACCOUNT_ID: TFloatField;
    qPaymentsCONTRACT_ID: TFloatField;
    qPaymentsDATE_CREATED: TDateTimeField;
    qPaymentsPAYMENT_DATE: TDateTimeField;
    qPaymentsPAYMENT_NUMBER: TStringField;
    qPaymentsPAYMENT_STATUS_IS_VALID: TIntegerField;
    qPaymentsPAYMENT_STATUS_TEXT: TStringField;
    qPaymentsPAYMENT_SUM: TFloatField;
    qPaymentsPHONE_NUMBER: TStringField;
    qPaymentsYEAR_MONTH: TFloatField;
    qPaymentsACCOUNT_NUMBER: TFloatField;
    procedure RefreshPayments;
    procedure RefreshLogs;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUSerStatExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PayKeeperFrm: TPayKeeperFrm;
  procedure DoReportPayKeeper;

implementation

uses IntecExportGrid, ShowUserStat;
{$R *.dfm}

procedure DoReportPayKeeper;
var ReportFrm : TPayKeeperFrm;
begin
  ReportFrm := TPayKeeperFrm.Create(Nil);
  try
    // Отчет
    ReportFrm.dtDateBegin.Date := Date;
    ReportFrm.dtDateEnd.Date := Date;
    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end
;

procedure TPayKeeperFrm.aLoadInExcelExecute(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if pgc1.TabIndex = 0 then
      ExportDBGridToExcel2('Платежи PayKeeper, прошедшие в тарифер за период ' +DateToStr(dtDateBegin.Date) + ' - '+
                            DateToStr(dtDateEnd.Date),'',gPayments, nil, False, True)
    else
      ExportDBGridToExcel2('Лог запросов на добавление платежа PayKeeper за период ' +DateToStr(dtDateBegin.Date) + ' - '+
                            DateToStr(dtDateEnd.Date),'', gLog, nil, False, True);
    ;
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TPayKeeperFrm.aRefreshExecute(Sender: TObject);
begin
  if pgc1.TabIndex = 0 then
    RefreshPayments
  else
    RefreshLogs;
  ;
end;

procedure TPayKeeperFrm.aShowUSerStatExecute(Sender: TObject);
begin
  if pgc1.TabIndex = 0 then
  begin
    if qPayments.Active and (qPayments.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qPayments.FieldByName('PHONE_NUMBER').AsString, 0);
  end
  else
  begin
    if qLog.Active and (qLog.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qLog.FieldByName('CLIENT_ID').AsString, 0);
  end;
end;

procedure TPayKeeperFrm.RefreshPayments;
begin
  qPayments.Close;
  qPayments.ParamByName('pDateBegin').AsDate := dtDateBegin.Date;
  qPayments.ParamByName('pDateEnd').AsDate := dtDateEnd.Date;
  qPayments.Open;
end;

procedure TPayKeeperFrm.RefreshLogs;
begin
  qLog.Close;
  qLog.ParamByName('pDateBegin').AsDate := dtDateBegin.Date;
  qLog.ParamByName('pDateEnd').AsDate := dtDateEnd.Date;
  qLog.Open;
end;

end.
