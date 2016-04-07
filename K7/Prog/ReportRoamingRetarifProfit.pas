unit ReportRoamingRetarifProfit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, sListBox, sCheckListBox, Vcl.ComCtrls;

type
  TReportRoamingRetarifProfitForm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    dsReport: TDataSource;
    qreport: TOraQuery;
    qreportDAY: TDateTimeField;
    qreportFULL_COST: TFloatField;
    qreportOPTIONS_PROFIT: TFloatField;
    qreportCHARGES_SUM: TFloatField;
    qreportTURNED_ON_COUNT: TFloatField;
    qreportTURNED_OFF_COUNT: TFloatField;
    qreportACTIVE_ABONENT_COUNT: TFloatField;
    qreportSUMMARY_PROFIT: TFloatField;
    dtStart: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    dtEnd: TDateTimePicker;
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;
  public
    { Public declarations }
  end;

var
  ReportRoamingRetarifProfitForm: TReportRoamingRetarifProfitForm;


implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat;


procedure TReportRoamingRetarifProfitForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  if qReport.Active then
  begin
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ExportDBGridToExcel2('Отчет "Выгодность ретарификации роуминга" по состоянию на '+DateToStr(Date),'',
        grData, nil, False, True);
    finally
      Screen.Cursor := cr;
    end;
  end
  else
    MessageDlg('Выборка не содержит данных!', mtWarning, [mbOK], 0);
end;

procedure TReportRoamingRetarifProfitForm.aRefreshExecute(Sender: TObject);
begin
  if dtStart.Date <= dtEnd.Date then
  begin
    qReport.Close;
    qReport.ParamByName('START_DATE').AsDate := dtStart.Date;
    qReport.ParamByName('END_DATE').AsDate := dtEnd.Date;
    qReport.Open;
  end
  else
    MessageDlg('Дата начала должна быть меньше даты окончания!!!!', mtWarning, [mbOK], 0);
end;

procedure TReportRoamingRetarifProfitForm.FormCreate(Sender: TObject);
begin
  dtStart.Date := Date;
  dtEnd.Date := Date;
end;

end.


