unit ReportCurrentQueueSMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons;

type
  TfReportCurrentQueueSMS = class(TForm)
    GridSMS_Current: TCRDBGrid;
    qMain: TOraQuery;
    ds1: TDataSource;
    popupMenuSMSCurrent: TPopupMenu;
    N1: TMenuItem;
    btRefreshData: TBitBtn;
    procedure aExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btRefreshDataClick(Sender: TObject);
  private
    procedure RefreshData;
  public
    procedure Execute (const Session : TOraSession);
  end;

var
  fReportCurrentQueueSMS: TfReportCurrentQueueSMS;

implementation

{$R *.dfm}

uses ExportGridToExcelPDF;

procedure TfReportCurrentQueueSMS.aExcelExecute(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGrid(Caption, '', '', GridSMS_Current, True, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfReportCurrentQueueSMS.btRefreshDataClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TfReportCurrentQueueSMS.Execute(const Session : TOraSession);
begin
  qMain.Session := Session;
  RefreshData;
  ShowModal();
end;

procedure TfReportCurrentQueueSMS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  qMain.Close;
end;

procedure TfReportCurrentQueueSMS.RefreshData;
begin
  qMain.Close;
  qMain.Open;
end;

end.
