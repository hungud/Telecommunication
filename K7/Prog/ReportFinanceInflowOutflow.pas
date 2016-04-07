unit ReportFinanceInflowOutflow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  CRGrid;

type
  TReportFinanceInflowOutflowForm = class(TForm)
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    qReport: TOraQuery;
    dsReport: TDataSource;
    GridReport: TCRDBGrid;
    Panel2: TPanel;
    GridInflow: TCRDBGrid;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Panel5: TPanel;
    Splitter2: TSplitter;
    GridOutflow: TCRDBGrid;
    qInflow: TOraQuery;
    qOutflow: TOraQuery;
    dsInflow: TDataSource;
    dsOutflow: TDataSource;
    qReportYEAR_MONTH: TFloatField;
    qReportINFLOW: TFloatField;
    qReportOUTFLOW: TFloatField;
    qReportPREV_YEAR_MONTH: TFloatField;
    qInflowPHONE_NUMBER: TStringField;
    Panel7: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel4: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    qOutflowPHONE_NUMBER: TStringField;
    qOutflowYEAR_MONTH: TFloatField;
    qOutflowBAN: TFloatField;
    qOutflowDATE_INSERT: TDateTimeField;
    qOutflowBALANCE: TFloatField;
    qOutflowPHONE_IS_ACTIVE: TFloatField;
    qOutflowCONTRACT_DATE: TDateTimeField;
    qOutflowDOP_STATUS: TStringField;
    qOutflowDATE_LAST_BLOCK: TDateTimeField;
    qOutflowBILL_PRIROST: TFloatField;
    qOutflowCONTRACT_CANCEL_DATE: TDateTimeField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure dsReportDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportFinanceInflowOutflow;

var
  ReportFinanceInflowOutflowForm: TReportFinanceInflowOutflowForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, ContractsRegistration_Utils;

procedure DoReportFinanceInflowOutflow;
var ReportFrm : TReportFinanceInflowOutflowForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportFinanceInflowOutflowForm.Create(Nil);
  try
    // Отчет
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportFinanceInflowOutflowForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по притоку-оттоку номеров','',
      GridReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceInflowOutflowForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportFinanceInflowOutflowForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
//
end;

procedure TReportFinanceInflowOutflowForm.BitBtn1Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Приток номеров за ' + qReportYEAR_MONTH.AsString,'',
      GridInflow, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceInflowOutflowForm.BitBtn2Click(Sender: TObject);
begin
  qInflow.Close;
  qInflow.Open;
end;

procedure TReportFinanceInflowOutflowForm.BitBtn3Click(Sender: TObject);
begin
  if qInflow.Active and (qInflow.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qInflow.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportFinanceInflowOutflowForm.BitBtn4Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отток номеров за ' + qReportYEAR_MONTH.AsString,'',
      GridOutflow, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportFinanceInflowOutflowForm.BitBtn5Click(Sender: TObject);
begin
  qOutflow.Close;
  qOutflow.Open;
end;

procedure TReportFinanceInflowOutflowForm.BitBtn6Click(Sender: TObject);
begin
  if qOutflow.Active and (qOutflow.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qOutflow.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportFinanceInflowOutflowForm.cbPeriodChange(Sender: TObject);
begin
//
end;

procedure TReportFinanceInflowOutflowForm.dsReportDataChange(Sender: TObject;
  Field: TField);
begin
  qInflow.ParamByName('YEAR_MONTH').AsInteger:=qReportYEAR_MONTH.AsInteger;
  //qInflow.Close;
  //qInflow.Open;
  qOutflow.ParamByName('PREV_YEAR_MONTH').AsInteger:=qReportPREV_YEAR_MONTH.AsInteger;
end;

procedure TReportFinanceInflowOutflowForm.FormShow(Sender: TObject);
begin
  aRefresh.Execute;
end;

end.
