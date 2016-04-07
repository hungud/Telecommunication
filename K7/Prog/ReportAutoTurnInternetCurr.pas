unit ReportAutoTurnInternetCurr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Buttons,
  Vcl.ExtCtrls, IntecExportGrid;

type
  TrepAutoTurnInternetCurr = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    grData: TCRDBGrid;
    EditPhone: TEdit;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure EditPhoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure DoReportAutoTurnInternetCurr;

var
  repAutoTurnInternetCurr: TrepAutoTurnInternetCurr;

implementation

{$R *.dfm}

procedure DoReportAutoTurnInternetCurr;
  var ReportFrm: TrepAutoTurnInternetCurr;
begin
  ReportFrm:=TrepAutoTurnInternetCurr.Create(Nil);
  try
    with ReportFrm do begin
//      qReport.Open;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TrepAutoTurnInternetCurr.aExcelExecute(Sender: TObject);
var cr : TCursor;
    v_bm: Variant;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  v_bm := DataSource1.DataSet.Bookmark ;
  DataSource1.DataSet.DisableControls;
  try
    ExportDBGridToExcel(Caption + ' за текущий мес€ц.','', grData, False, True);
  finally
    Screen.Cursor := cr;
    DataSource1.DataSet.Bookmark := v_bm;
    DataSource1.DataSet.EnableControls;
  end;
end;

procedure TrepAutoTurnInternetCurr.aRefreshExecute(Sender: TObject);
begin
  if bitbtn2.Caption <>'ќбновить' then bitbtn2.Caption := 'ќбновить';
  if qreport.Active then qreport.Active := false;
  qReport.ParamByName('phone').Text := EditPhone.Text;
  qreport.Active := true;
end;

procedure TrepAutoTurnInternetCurr.EditPhoneKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then aRefreshExecute(self);
end;

end.
