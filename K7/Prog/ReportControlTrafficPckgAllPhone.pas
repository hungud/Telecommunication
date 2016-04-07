unit ReportControlTrafficPckgAllPhone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, ShowUserStat, main, IntecExportGrid;

type
  TReportControlTrafficPckgAllPhoneForm = class(TReportForm)
    pData: TPanel;
    Splitter1: TSplitter;
    pPckgLog: TPanel;
    Splitter2: TSplitter;
    pPckgStat: TPanel;
    gPckgLog: TCRDBGrid;
    gPckgStat: TCRDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    qPckgLog: TOraQuery;
    qPckgStat: TOraQuery;
    dsPckgLog: TDataSource;
    dsPckgStat: TDataSource;
    aDetailInfo: TAction;
    BitBtn1: TBitBtn;
    procedure aDetailInfoExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure qPckgLogBeforeOpen(DataSet: TDataSet);
    procedure qPckgStatBeforeOpen(DataSet: TDataSet);
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure qPckgLogAfterScroll(DataSet: TDataSet);
    procedure gReportDblClick(Sender: TObject);
    procedure gPckgLogDblClick(Sender: TObject);
    procedure gPckgStatDblClick(Sender: TObject);
    procedure gPckgLogDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    function Need_Draw(NameColumn :string; qOra :TOraQuery): boolean;
  public
    { Public declarations }
  end;

var
  ReportControlTrafficPckgAllPhoneForm: TReportControlTrafficPckgAllPhoneForm;

  procedure DoReportControlTrafficPckgAllPhone;

implementation

{$R *.dfm}

//подготовка формы и ее показ
procedure DoReportControlTrafficPckgAllPhone;
var ReportFrm : TReportControlTrafficPckgAllPhoneForm;
begin
  //создаем форму
  ReportFrm := TReportControlTrafficPckgAllPhoneForm.Create(Nil);
  try
    //скрываем подробную информацию
    ReportFrm.pData.Visible := false;
    ReportFrm.Splitter1.Visible := false;

    //получаем данные
    ReportFrm.qReport.Close;
    ReportFrm.qReport.Open;
    //показываем форму
    ReportFrm.ShowModal;
  finally
    //уничтожаем форму
    ReportFrm.Free;
  end;
end;

//выгрузка в эксель
procedure TReportControlTrafficPckgAllPhoneForm.aLoadInExcelExecute(
  Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет расхода трафика на пакетах по всем номерам','', gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

//показываем карточку абонента (по двойному щелчку по таблицам тоже показываем)
procedure TReportControlTrafficPckgAllPhoneForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
end;

procedure TReportControlTrafficPckgAllPhoneForm.gPckgLogDblClick(
  Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

procedure TReportControlTrafficPckgAllPhoneForm.gPckgStatDblClick(
  Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

procedure TReportControlTrafficPckgAllPhoneForm.gReportDblClick(
  Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

//скрываем/показываем подробную информацию
procedure TReportControlTrafficPckgAllPhoneForm.aDetailInfoExecute(
  Sender: TObject);
begin
  inherited;
  if not pData.Visible then
  begin
    qPckgLog.Close;
    qPckgLog.Open;
    qPckgStat.Close;
    qPckgStat.Open;
    pData.Visible := true;
    Splitter1.Visible := true;
    aDetailInfo.Caption := 'Скрыть подробную информацию';
  end
  else
    begin
      pData.Visible := false;
      Splitter1.Visible := false;
      aDetailInfo.Caption := 'Показать подробную информацию';
    end;
end;

function TReportControlTrafficPckgAllPhoneForm.Need_Draw(NameColumn :string; qOra :TOraQuery): boolean;
begin
  result := false;
  if NameColumn = qOra.FieldByName('IS_SEND_SMS_ZERO').FieldName then
  begin
   if qOra.FieldByName('IS_SEND_SMS_ZERO').Value = 1 then
     result := true;
  end
  else
    if NameColumn = qOra.FieldByName('IS_SEND_SMS_PREV').FieldName then
    begin
      if qOra.FieldByName('IS_SEND_SMS_PREV').Value = 1 then
        result := true;
    end
    else
      if NameColumn = qOra.FieldByName('DO_NOT_REST').FieldName  then
      begin
        if qOra.FieldByName('DO_NOT_REST').Value = 1 then
          result := true;
      end;
end;

//прорисовываем "плюс" в таблице логов пакетов
procedure TReportControlTrafficPckgAllPhoneForm.gPckgLogDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var Im1: TBitmap;
begin
  inherited;
  if (Column.FieldName = qPckgLog.FieldByName('IS_SEND_SMS_ZERO').FieldName) or
     (Column.FieldName = qPckgLog.FieldByName('DO_NOT_REST').FieldName) or
     (Column.FieldName = qPckgLog.FieldByName('IS_SEND_SMS_PREV').FieldName) then
    with gPckgLog.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(Rect);

      if Need_Draw(Column.FieldName, qPckgLog) then
      begin
        Im1 := TBitmap.Create;//создание
        try
          MainForm.ImageList16.GetBitmap(4,Im1);
          Draw(round((Rect.Left+Rect.Right-Im1.Width)/2),Rect.Top,Im1);
        finally
          Im1.Free;
        end;
      end;
    end;
end;

//получаем подробную информацию
procedure TReportControlTrafficPckgAllPhoneForm.qReportAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if pData.Visible then
  begin
    qPckgLog.Close;
    qPckgLog.Open;
    qPckgStat.Close;
    qPckgStat.Open;
  end;
end;

procedure TReportControlTrafficPckgAllPhoneForm.qPckgLogAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  qPckgStat.Close;
  qPckgStat.Open;
end;

procedure TReportControlTrafficPckgAllPhoneForm.qPckgLogBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  if qReport.RecordCount > 0 then
    qPckgLog.ParamByName('p_PHONE').AsString := qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
end;

procedure TReportControlTrafficPckgAllPhoneForm.qPckgStatBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  if qReport.RecordCount > 0 then
  begin
    qPckgStat.ParamByName('p_PHONE').AsString := qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
    qPckgStat.ParamByName('pturn_log_id').AsInteger := qPckgLog.FieldByName('ALL_PHONE_LOG_ID').AsInteger;
  end;
end;

end.
