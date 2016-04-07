unit ReportMobPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, StdCtrls, Buttons, ExtCtrls, MemDS, DBAccess, Ora,
  Grids, DBGrids, CRGrid,PhoneNumberInputFrm;

type
  TReportMobPaymentsForm = class(TForm)
    dsReport: TDataSource;
    ReportGrid: TCRDBGrid;
    qReport: TOraQuery;
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    alReport: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReportMSISDN: TStringField;
    qReportUSSD_DATE: TDateTimeField;
    qReportTEXT_RES: TStringField;
    qReportCOUNTMPLPHONE: TFloatField;
    SS: TFloatField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pMOBPAYDEL: TOraStoredProc;
    pMOBPAY: TOraStoredProc;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FPhoneNumberInputFrm : TPhoneNumberInputForm;
  end;

procedure DoReportMobPay;

var
  ReportMobPaymentsForm: TReportMobPaymentsForm;

implementation

{$R *.dfm}

uses IntecExportGrid, ShowUserStat, Main;

procedure DoReportMobPay;
var ReportFrm : TReportMobPaymentsForm;
begin
  ReportFrm:=TReportMobPaymentsForm.Create(Nil);
  try
    // Отчет
    ReportFrm.aRefresh.Execute;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportMobPaymentsForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(ReportMobPaymentsForm.Caption,'',
      ReportGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportMobPaymentsForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

procedure TReportMobPaymentsForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('MSISDN').AsString, 0);
end;


procedure TReportMobPaymentsForm.BitBtn1Click(Sender: TObject);
begin
 if not Assigned(FPhoneNumberInputFrm) then
      FPhoneNumberInputFrm := TPhoneNumberInputForm.Create(Application);
 if (mrOk = FPhoneNumberInputFrm.ShowModal) then
    begin
       pMOBPAYDEL.ParamByName('PPHONEA').AsString:=FPhoneNumberInputFrm.eSearch.EditText;
       pMOBPAYDEL.ExecProc;
       ShowMessage(pMOBPAYDEL.ParamByName('RESULT').AsString);
    end;
end;

procedure TReportMobPaymentsForm.BitBtn2Click(Sender: TObject);
begin
 if not Assigned(FPhoneNumberInputFrm) then
      FPhoneNumberInputFrm := TPhoneNumberInputForm.Create(Application);
 if (mrOk = FPhoneNumberInputFrm.ShowModal) then
    begin
       pMOBPAY.ParamByName('PPHONEA').AsString:=FPhoneNumberInputFrm.eSearch.EditText;
       pMOBPAY.ExecProc;
       ShowMessage(pMOBPAY.ParamByName('RESULT').AsString);
    end;
end;

end.
