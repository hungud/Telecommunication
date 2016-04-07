unit ReportAutoTurnInternetPrev;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Data.DB, MemDS, DBAccess, Ora,
  Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid;

type
  TrepAutoTurnInternetPrev = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EditPhone: TEdit;
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    MaskEdit_year_month: TMaskEdit;
    lYearMonth: TLabel;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure EditPhoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure DoReportAutoTurnInternetPrev;

var
  repAutoTurnInternetPrev: TrepAutoTurnInternetPrev;

implementation

{$R *.dfm}

procedure DoReportAutoTurnInternetPrev;
  var ReportFrm: TrepAutoTurnInternetPrev;
begin
  ReportFrm:=TrepAutoTurnInternetPrev.Create(Nil);
  try
    with ReportFrm do begin
//      qReport.Open;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TrepAutoTurnInternetPrev.aExcelExecute(Sender: TObject);
var cr : TCursor;
    v_bm: Variant;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  v_bm := DataSource1.DataSet.Bookmark ;
  DataSource1.DataSet.DisableControls;
  try
    ExportDBGridToExcel(Caption + ' за '+copy(MaskEdit_year_month.Text,1,4)+'-'+copy(MaskEdit_year_month.Text,5,2)+' .','', grData, False, True);
  finally
    Screen.Cursor := cr;
    DataSource1.DataSet.Bookmark := v_bm;
    DataSource1.DataSet.EnableControls;
  end;
end;

procedure TrepAutoTurnInternetPrev.aRefreshExecute(Sender: TObject);
begin
  if bitbtn2.Caption <>'Обновить' then bitbtn2.Caption := 'Обновить';
  if qreport.Active then qreport.Active := false;
  qReport.ParamByName('phone').Text := EditPhone.Text;
  qReport.ParamByName('year_month').Text := MaskEdit_year_month.Text;
  qreport.Active := true;
end;

procedure TrepAutoTurnInternetPrev.EditPhoneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then aRefreshExecute(self);
end;

procedure TrepAutoTurnInternetPrev.FormCreate(Sender: TObject);
begin
  MaskEdit_year_month.Text := formatdatetime('yyyymm',incmonth(now,-1));
end;

end.
