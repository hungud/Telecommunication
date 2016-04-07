unit ReportDebitorka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGrids, CRGrid, IntecExportGrid, ShowUserStat;

type
  TReportDebitorkaForm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    alReports: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qReportPHONE_NUMBER: TStringField;
    qReportPAYMENTS_ALL: TFloatField;
    qReportBILLS_ALL: TFloatField;
    qReportDEBITORKA: TFloatField;
    cbOnlyMinus: TCheckBox;
    ReportGrid: TCRDBGrid;
    Panel2: TPanel;
    CRDBGrid2: TCRDBGrid;
    Splitter1: TSplitter;
    qReportRows: TOraQuery;
    dsReportRows: TDataSource;
    qReportRowsPHONE_NUMBER: TStringField;
    qReportRowsDATE_BEGIN: TDateTimeField;
    qReportRowsDATE_CANCEL: TDateTimeField;
    qReportRowsBILLS_SUMM_ALL: TFloatField;
    qReportRowsPAYMENTS_SUMM_ALL: TFloatField;
    qReportRowsBILLS_SUMM_BEELINE: TFloatField;
    qReportRowsPAYMENTS_SUMM_BEELINE: TFloatField;
    qReportRowsDEBITORKA: TFloatField;
    qReportRowsSTAT_COMPLETE: TFloatField;
    qReportCELL_PLAN_CODE: TStringField;
    qReportDEBITORKA_BEELINE: TFloatField;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbOnlyMinusClick(Sender: TObject);
    procedure dsReportDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportDebitorka;

var
  ReportDebitorkaForm: TReportDebitorkaForm;

implementation

{$R *.dfm}

procedure DoReportDebitorka;
var ReportFrm : TReportDebitorkaForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportDebitorkaForm.Create(Nil);
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportDebitorkaForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
    Stroka : string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  Stroka:= 'Дебиторская задолженность по состоянию на ' + DateToStr(Date);
  if cbOnlyMinus.Checked
    then Stroka:=Stroka + ', только номера с отриц. дебиторкой'
    else Stroka:=Stroka + ', все номера';
  try
    ExportDBGridToExcel2('Дебиторская задолженность по состоянию на ' + DateToStr(Date),'',
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportDebitorkaForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  if cbOnlyMinus.Checked
    then qReport.ParamByName('CHECK_MINUS').AsInteger:=1
    else qReport.ParamByName('CHECK_MINUS').AsInteger:=0;
  qReport.Open;
end;

procedure TReportDebitorkaForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportDebitorkaForm.cbSearchClick(Sender: TObject);
begin
//
end;

procedure TReportDebitorkaForm.dsReportDataChange(Sender: TObject;
  Field: TField);
begin
  qReportRows.Close;
  qReportRows.ParamByName('PHONE_NUMBER').AsString:=qReport.FieldByName('PHONE_NUMBER').Value;
  qReportRows.Open;
end;

procedure TReportDebitorkaForm.cbOnlyMinusClick(Sender: TObject);
begin
  aRefresh.Execute;
end;

end.
