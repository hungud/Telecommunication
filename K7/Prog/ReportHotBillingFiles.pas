unit ReportHotBillingFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Vcl.ComCtrls;

type
  TReportHotBillingFilesForm = class(TForm)
    Panel1: TPanel;
    lPeriod: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    cbPeriod: TComboBox;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    qPeriods: TOraQuery;
    qReport_Files: TOraQuery;
    dsReport_Files: TDataSource;
    qReport_Prev: TOraQuery;
    dsReport_Prev: TDataSource;
    PageControl1: TPageControl;
    tsFiles: TTabSheet;
    tsPrev: TTabSheet;
    grData_Files: TCRDBGrid;
    grData_Prev: TCRDBGrid;
    qReport_FilesFILE_NAME: TStringField;
    qReport_FilesLOAD_SDATE: TDateTimeField;
    qReport_FilesLOAD_EDATE: TDateTimeField;
    qReport_FilesCNT: TFloatField;
    qReport_PrevSTART_DATE: TStringField;
    qReport_PrevINTERVAL_TIME: TStringField;
    qReport_PrevCNT: TFloatField;
    qReport_PrevCNT_PREV: TFloatField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportHotBillingFilesForm: TReportHotBillingFilesForm;

procedure DoReportHotBillingFiles;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat, Main;

procedure DoReportHotBillingFiles;
var ReportFrm : TReportHotBillingFilesForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportHotBillingFilesForm.Create(Nil);
  try
    //период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.Add(ReportFrm.qPeriods.FieldByName('PERIOD').AsString);
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.cbPeriod.ItemIndex:=0;
    // ќтчет
    ReportFrm.PageControl1.ActivePage:=ReportFrm.tsFiles;
    ReportFrm.aRefreshExecute(nil);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportHotBillingFilesForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if PageControl1.ActivePage = tsFiles then
      ExportDBGridToExcel2('ќтчет о загруженных файлах гор€чего биллинга за ' + cbPeriod.Text + ' по состо€нию на '+DateToStr(Date),'',
        grData_Files, nil, False, True);
    if PageControl1.ActivePage = tsPrev then
      ExportDBGridToExcel2('ќтчет о загрузках гор€чего биллинга за ' + cbPeriod.Text + ' по состо€нию на '+DateToStr(Date),'',
        grData_Prev, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportHotBillingFilesForm.aRefreshExecute(Sender: TObject);
begin
  //ќтчет о загруженных файлах гор€чего биллинга
  if PageControl1.ActivePage = tsFiles then begin
    qReport_Files.Close;
    qReport_Files.SQL.Text:='select f.FILE_NAME, f.LOAD_SDATE, f.LOAD_EDATE, f.HBF_ID, count(*) cnt'+
                            ' from hot_billing_files f, call_'+cbPeriod.Text+' c'+
                            ' where f.hbf_id=c.dbf_id (+)'+
                            ' group by f.FILE_NAME, f.LOAD_SDATE, f.LOAD_EDATE, f.HBF_ID'+
                            ' order by hbf_id desc';
    qReport_Files.Open;
  end;

  //ќтчет о загрузках гор€чего биллинга по часам
  if PageControl1.ActivePage = tsPrev then begin
    qReport_Prev.Close;
    qReport_Prev.SQL.Text:='WITH'+
                           ' T AS (SELECT trunc(start_time, ''hh'') t_current,'+
                           '              trunc(start_time-1, ''hh'') t_prev, count(*) CNT'+
                           '       FROM call_'+cbPeriod.Text+' c'+
                           '       GROUP BY trunc(start_time, ''hh''), trunc(start_time-1, ''hh'')'+
                           '      )'+
                           ' select to_char(t1.t_current,''dd.mm.yyyy'') start_date,'+
                           '        to_char(t1.t_current,''hh24.mi'')||''-''||to_char(t1.t_current+1/24,''hh24.mi'') interval_time,'+
                           '        t1.cnt, t2.cnt cnt_prev'+
                           ' from t t1, t t2'+
                           ' where t2.t_current(+) = t1.t_prev'+
                           ' order by 1 desc, 2 desc';
    qReport_Prev.Open;
  end;

end;

end.
