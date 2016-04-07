unit ReportSMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Menus;

type
  TReportSMSForm = class(TForm)
    GridSMS_Current: TCRDBGrid;
    sms_current_query1: TOraQuery;
    ds1: TDataSource;
    popupMenuSMSCurrent: TPopupMenu;
    N1: TMenuItem;
    procedure aExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public

  end;

var
  ReportSMSForm: TReportSMSForm;


  procedure DoReportSMS(TypeReport:string);

implementation

{$R *.dfm}

uses Main, ExportGridToExcelPDF;

  procedure DoReportSMS(TypeReport:string);
  var ReportFrm : TReportSMSForm;
  begin
         ReportFrm:=TReportSMSForm.Create(Nil);
         ReportFrm.sms_current_query1.Open;
         ReportFrm.ShowModal();
  end;

procedure TReportSMSForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
      cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGrid(ReportSMSForm.Caption ,'','', GridSMS_Current, True, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportSMSForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
        sms_current_query1.Close;
end;

end.
