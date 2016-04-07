unit uReportPhoneState;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid;

type
  TfrmReportPhoneState = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    btRefresh: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    dtStartDate: TDateTimePicker;
    gSost: TCRDBGrid;
    dsPhoneState: TDataSource;
    qPhoneState: TOraQuery;
    qPhoneStatePHONE_NUMBER: TStringField;
    qPhoneStatePHONE_IS_ACTIVE: TStringField;
    qPhoneStateACCOUNT_NUMBER: TFloatField;
    qPhoneStateCOMPANY_NAME: TStringField;
    qPhoneStateSTATUS_CODE: TStringField;
    qPhoneStateCOMMENT_BEELINE: TStringField;
    qPhoneStateLAST_CHANGE_STATUS_DATE: TDateTimeField;
    qPhoneStateBEGIN_DATE: TDateTimeField;
    qPhoneStateEND_DATE: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure dtStartDateChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
  private
    procedure Refresh(pDate : TDateTime);
  public
    { Public declarations }
  end;
  procedure DoReportPhoneState;
var
  frmReportPhoneState: TfrmReportPhoneState;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat;
procedure DoReportPhoneState;
var
  ReportFrm : TfrmReportPhoneState;
begin
  ReportFrm := TfrmReportPhoneState.Create(Nil);
  try
    ReportFrm.ShowModal;
  finally
    FreeAndNil(ReportFrm);
  end;

end;

procedure TfrmReportPhoneState.BitBtn1Click(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт о состоянии номеров на ' + DateToStr(dtStartDate.Date),'',
      gSost, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmReportPhoneState.BitBtn3Click(Sender: TObject);
begin
  if qPhoneState.Active and (qPhoneState.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qPhoneState.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TfrmReportPhoneState.btRefreshClick(Sender: TObject);
begin
  Refresh(dtStartDate.Date);
end;

procedure TfrmReportPhoneState.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    gSost.OptionsEx := gSost.OptionsEx+[dgeSearchBar]
  else
    gSost.OptionsEx := gSost.OptionsEx-[dgeSearchBar];
end;

procedure TfrmReportPhoneState.dtStartDateChange(Sender: TObject);
begin
  Refresh(dtStartDate.Date);
end;

procedure TfrmReportPhoneState.FormCreate(Sender: TObject);
begin
  dtStartDate.Date := Date;
end;

procedure TfrmReportPhoneState.Refresh(pDate: TDateTime);
begin
  qPhoneState.Close;
  qPhoneState.ParamByName('pDateStart').Value := pDate;
  qPhoneState.Open;
end;

end.
