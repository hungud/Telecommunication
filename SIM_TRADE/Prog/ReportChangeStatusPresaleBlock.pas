unit ReportChangeStatusPresaleBlock;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, CRGrid,
  MemDS, DBAccess, Ora, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls,
  ShowUserStat, IntecExportGrid;

type
  TReportChangeStatusPresaleBlockFrm = class(TForm)
    pFilter: TPanel;
    dtStart: TDateTimePicker;
    dtEnd: TDateTimePicker;
    lbl1: TLabel;
    lbl2: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    b1: TBitBtn;
    qReportChangeStatusPresaleBlock: TOraQuery;
    p1: TPanel;
    g1: TCRDBGrid;
    dsReportChangeStatusPresaleBlock: TDataSource;
    procedure b1Click(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
  private
    procedure RefreshData;
  public
    { Public declarations }
  end;

var
  ReportChangeStatusPresaleBlockFrm: TReportChangeStatusPresaleBlockFrm;
  procedure DoReportChangeStatusPresaleBlock;

implementation

{$R *.dfm}
procedure DoReportChangeStatusPresaleBlock;
var
  ReportFrm : TReportChangeStatusPresaleBlockFrm;
begin
  ReportFrm := TReportChangeStatusPresaleBlockFrm.Create(Nil);
  try
    // Заполнение списка заявок
    with ReportFrm do
    begin
      dtStart.Date := Date;
      dtEnd.Date := Date;
      RefreshData;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;


procedure TReportChangeStatusPresaleBlockFrm.b1Click(Sender: TObject);
begin
 if qReportChangeStatusPresaleBlock.Active and (qReportChangeStatusPresaleBlock.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReportChangeStatusPresaleBlock.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportChangeStatusPresaleBlockFrm.btLoadInExcelClick(
  Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportChangeStatusPresaleBlockFrm.Caption + ' за период ' + DateToStr(dtStart.Date) + ' по ' + DateToStr(dtEnd.Date) +
                       '  по состоянию на '+DateToStr(Date),'',
      g1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportChangeStatusPresaleBlockFrm.btRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TReportChangeStatusPresaleBlockFrm.RefreshData;
begin
  if dtEnd.Date >= dtStart.Date then
  begin
    qReportChangeStatusPresaleBlock.ParamByName('pDATE_BEGIN').AsDate := dtStart.Date;
    qReportChangeStatusPresaleBlock.ParamByName('pDATE_END').AsDate := dtEnd.Date;

    qReportChangeStatusPresaleBlock.Close;
    qReportChangeStatusPresaleBlock.Open;
  end
  else
    MessageBox(Handle, 'Дата начала должна быть меньше даты окончания периода!!!', '', MB_ICONWARNING + MB_OK);
end;

end.
