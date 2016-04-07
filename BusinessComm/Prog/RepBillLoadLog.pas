unit RepBillLoadLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Data.DB, DBAccess, Ora, MemDS,
  Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, Vcl.Grids,
  Vcl.DBGrids, udm, Func_Const,  TimedMsgBox,  ShellAPI, CRGrid;

type
  TRepBillLoadLogFrm = class(TChildForm)
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    qReport: TOraQuery;
    qReportLOG_BILL_ID: TFloatField;
    qReportPeriod: TStringField;
    qReportAccount_name: TStringField;
    qReportACCOUNT_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportFILE_NAME: TStringField;
    qReportDATA_EXIST: TStringField;
    qReportERROR_LOAD: TStringField;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    qReportDATA_EXIST_: TFloatField;
    dsqReport: TOraDataSource;
    cRGrid: TCRDBGrid;
    qBlob: TOraQuery;
    qBlobFILE_BODY: TBlobField;
    qReportBILL_FILE_STATUS_ID: TFloatField;
    qBillFileStatuses: TOraQuery;
    qBillFileStatusesBILL_FILE_STATUS_ID: TFloatField;
    qBillFileStatusesSTATUS_NAME: TStringField;
    dsqBillFileStatuses: TOraDataSource;
    qReportNAME_STATUS: TStringField;
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure qReportCalcFields(DataSet: TDataSet);
    procedure sBCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qReportAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    LOG_BILL_ID : Integer;
    Account_name, Period : string;
    { Public declarations }
  end;

var
  RepBillLoadLogFrm: TRepBillLoadLogFrm;

implementation

{$R *.dfm}

procedure TRepBillLoadLogFrm.FormCreate(Sender: TObject);
var
  ff : TField;
begin
  inherited;
  try
    ff := qReport.FindField('USER_CREATED_FIO');
    if ff  <> nil then
    begin
      qReport.FieldByName('USER_CREATED_FIO').ReadOnly := True;
      qReport.FieldByName('DATE_CREATED_').ReadOnly := True;
      qReport.FieldByName('USER_CREATED_FIO').Visible := Dm.ShowInfoCreator;
      qReport.FieldByName('DATE_CREATED_').Visible := Dm.ShowInfoCreator;
    end;
    ff := qReport.FindField('USER_LAST_UPDATED_FIO');
    if ff  <> nil then
    begin
      qReport.FieldByName('USER_LAST_UPDATED_FIO').ReadOnly := True;
      qReport.FieldByName('DATE_LAST_UPDATED_').ReadOnly := True;
      qReport.FieldByName('USER_LAST_UPDATED_FIO').Visible := Dm.ShowInfoChanger;
      qReport.FieldByName('DATE_LAST_UPDATED_').Visible := Dm.ShowInfoChanger;
    end;
  except
    //
  end;
 end;

procedure TRepBillLoadLogFrm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := 0 to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, Caption, CRGrid.Columns[i].FieldName,
      IntToStr(CRGrid.Columns[i].Width));
  end;

end;

procedure TRepBillLoadLogFrm.qReportAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FitGrid(TDBGrid(CRGrid), Dm.FileNameIni, Caption);
end;

procedure TRepBillLoadLogFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qReport.ParamByName('LOG_BILL_ID').AsInteger :=  LOG_BILL_ID;

end;

procedure TRepBillLoadLogFrm.qReportCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('Period').AsString := Period;
  DataSet.FieldByName('Account_name').AsString := Account_name;
end;

procedure TRepBillLoadLogFrm.sBCloseClick(Sender: TObject);
begin
  inherited;
    dm.dlgSave.FileName := qReport.FieldByName('FILE_NAME').AsString;
  if dm.dlgSave.Execute then
  begin
    try
      qBlob.Close;
      qBlob.ParamByName('LOG_BILL_ID').AsInteger := qReport.FieldByName('LOG_BILL_ID').AsInteger;
      qBlob.Open;
      if qBlob.IsEmpty then
      begin
        TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
      end
      else
      begin
        SaveBlobFile('', dm.dlgSave.FileName, qBlob, qBlobFILE_BODY);
        ShellExecute(0, 'open', PCHAR(dm.dlgSave.FileName), nil, nil, SW_SHOWNORMAL);
      end;
    except
      TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
    end;
  end;

end;

end.
