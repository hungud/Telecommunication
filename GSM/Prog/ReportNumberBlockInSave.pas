unit ReportNumberBlockInSave;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  CRGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, Data.DB, MemDS,
  DBAccess, Ora;

type
  TReportNumberBlockInSaveFrm = class(TForm)
    DataSource1: TDataSource;
    ToolBar1: TToolBar;
    btnaExcel: TBitBtn;
    ts1dbgrd: TCRDBGrid;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    aExcel: TAction;
    qReport: TOraQuery;
    qReportPHONE_NUMBER: TStringField;
    qReportTARIFF_ID: TFloatField;
    qReportTARIFF_NAME: TStringField;
    qReportLAST_CHANGE_STATUS_DATE: TDateTimeField;
    procedure BitBtn1Click(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure DoReportNumberBlockInSave;

var
  ReportNumberBlockInSaveFrm: TReportNumberBlockInSaveFrm;

implementation

{$R *.dfm}
uses PhoneNumberBlockInSave, IntecExportGrid, Main;

procedure TReportNumberBlockInSaveFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  if qReport.Active then
  begin
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ExportDBGridToExcel2('Список номеров, заблокированных по сохранению.','',ts1dbgrd, nil, False, True);
     //ExportDBGrid(ReportBillsForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'','Счета_'+cbPeriod.Text, grData, True, True);
    finally
      Screen.Cursor := cr;
    end;
  end
  else
    ShowMessage('Нет данных для выгрузки!!!');

end;

procedure TReportNumberBlockInSaveFrm.BitBtn1Click(Sender: TObject);
begin
  DoPhoneNumberBlockInSave;
end;

procedure DoReportNumberBlockInSave;
var
  ReportFrm : TReportNumberBlockInSaveFrm;
begin
  ReportFrm:=TReportNumberBlockInSaveFrm.Create(Nil);
  ReportFrm.qReport.Open;
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;
end.
