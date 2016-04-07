unit ReportControlFlowTraffDraveMon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, ShowUserStat, main, IntecExportGrid;

type
  TReportControlFlowTraffDraveMonForm = class(TReportForm)
    Splitter1: TSplitter;
    gDraveStat: TCRDBGrid;
    pData: TPanel;
    Label1: TLabel;
    qDraveStat: TOraQuery;
    dsDraveStat: TDataSource;
    pDraveLog: TPanel;
    pDraveStat: TPanel;
    Splitter2: TSplitter;
    Label2: TLabel;
    gDraveLog: TCRDBGrid;
    qDraveLog: TOraQuery;
    dsDraveLog: TDataSource;
    BitBtn1: TBitBtn;
    aDetailInfo: TAction;
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure qDraveLogBeforeOpen(DataSet: TDataSet);
    procedure qDraveStatBeforeOpen(DataSet: TDataSet);
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure gReportDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gDraveLogDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gReportDblClick(Sender: TObject);
    procedure gDraveLogDblClick(Sender: TObject);
    procedure gDraveStatDblClick(Sender: TObject);
    procedure aDetailInfoExecute(Sender: TObject);
    procedure qDraveLogAfterScroll(DataSet: TDataSet);
  private
    function Need_Draw(NameColumn :string; qOra :TOraQuery): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportControlFlowTraffDraveMonForm: TReportControlFlowTraffDraveMonForm;

  procedure DoReportControlFlowTraffDraveMon;

implementation

{$R *.dfm}

//подготовка формы и ее показ
procedure DoReportControlFlowTraffDraveMon;
var ReportFrm : TReportControlFlowTraffDraveMonForm;
begin
  //создаем форму
  ReportFrm := TReportControlFlowTraffDraveMonForm.Create(Nil);
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

//обновление данных
procedure TReportControlFlowTraffDraveMonForm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  qReport.Close;
  qReport.Open;
end;

//выгрузка в эксель
procedure TReportControlFlowTraffDraveMonForm.aLoadInExcelExecute(
  Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет по расходу трафика на номерах с тарифом "Драйв"','', gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

//показываем карточку абонента (по двойному щелчку по таблицам тоже показываем)
procedure TReportControlFlowTraffDraveMonForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE').AsString, 0);
end;

procedure TReportControlFlowTraffDraveMonForm.gReportDblClick(Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

procedure TReportControlFlowTraffDraveMonForm.gDraveLogDblClick(
  Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

procedure TReportControlFlowTraffDraveMonForm.gDraveStatDblClick(
  Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

//скрываем/показываем подробную информацию
procedure TReportControlFlowTraffDraveMonForm.aDetailInfoExecute(
  Sender: TObject);
begin
  inherited;
  if not pData.Visible then
  begin
    qDraveLog.Close;
    qDraveLog.Open;
    qDraveStat.Close;
    qDraveStat.Open;
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

function TReportControlFlowTraffDraveMonForm.Need_Draw(NameColumn :string; qOra :TOraQuery): boolean;
begin
  result := false;
  if NameColumn = qOra.FieldByName('LIMIT_SPEED').FieldName then
  begin
   if qOra.FieldByName('LIMIT_SPEED').Value = 1 then
     result := true;
  end
  else
    if NameColumn = qOra.FieldByName('IS_SEND_SMS_ZERO_FIRST').FieldName then
    begin
      if qOra.FieldByName('IS_SEND_SMS_ZERO_FIRST').Value = 1 then
        result := true;
    end
    else
      if NameColumn = qOra.FieldByName('IS_SEND_SMS_ZERO_SECOND').FieldName then
      begin
        if qOra.FieldByName('IS_SEND_SMS_ZERO_SECOND').Value = 1 then
          result := true;
      end
      else
        if NameColumn = qOra.FieldByName('IS_SEND_SMS_PREV_FIRST').FieldName then
        begin
          if qOra.FieldByName('IS_SEND_SMS_PREV_FIRST').Value = 1 then
            result := true;
        end
        else
          if NameColumn = qOra.FieldByName('IS_SEND_SMS_PREV_SECOND').FieldName then
          begin
            if qOra.FieldByName('IS_SEND_SMS_PREV_SECOND').Value = 1 then
              result := true;
          end;
end;

//прорисовываем "плюс" в главной таблице
procedure TReportControlFlowTraffDraveMonForm.gReportDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var Im1: TBitmap;
begin
  inherited;
  if (Column.FieldName = qReport.FieldByName('LIMIT_SPEED').FieldName) or
     (Column.FieldName = qReport.FieldByName('IS_SEND_SMS_ZERO_FIRST').FieldName) or
     (Column.FieldName = qReport.FieldByName('IS_SEND_SMS_ZERO_SECOND').FieldName) or
     (Column.FieldName = qReport.FieldByName('IS_SEND_SMS_PREV_FIRST').FieldName) or
     (Column.FieldName = qReport.FieldByName('IS_SEND_SMS_PREV_SECOND').FieldName) then
    with gReport.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(Rect);

      if Need_Draw(Column.FieldName, qReport) then
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

//прорисовываем "плюс" в таблице логов тарифов
procedure TReportControlFlowTraffDraveMonForm.gDraveLogDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var Im1: TBitmap;
begin
  inherited;
  if (Column.FieldName = qDraveLog.FieldByName('LIMIT_SPEED').FieldName) or
     (Column.FieldName = qDraveLog.FieldByName('IS_SEND_SMS_ZERO_FIRST').FieldName) or
     (Column.FieldName = qDraveLog.FieldByName('IS_SEND_SMS_ZERO_SECOND').FieldName) or
     (Column.FieldName = qDraveLog.FieldByName('IS_SEND_SMS_PREV_FIRST').FieldName) or
     (Column.FieldName = qDraveLog.FieldByName('IS_SEND_SMS_PREV_SECOND').FieldName) then
    with gDraveLog.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(Rect);

      if Need_Draw(Column.FieldName, qDraveLog) then
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
procedure TReportControlFlowTraffDraveMonForm.qReportAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if pData.Visible then
  begin
    qDraveLog.Close;
    qDraveLog.Open;
    qDraveStat.Close;
    qDraveStat.Open;
  end;
end;

procedure TReportControlFlowTraffDraveMonForm.qDraveLogAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  qDraveStat.Close;
  qDraveStat.Open;
end;

procedure TReportControlFlowTraffDraveMonForm.qDraveLogBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  if qReport.RecordCount > 0 then
    qDraveLog.ParamByName('p_PHONE').AsString := qReport.FieldByName('phone').AsString;
end;

procedure TReportControlFlowTraffDraveMonForm.qDraveStatBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  if qReport.RecordCount > 0 then
  begin
    qDraveStat.ParamByName('p_PHONE').AsString := qReport.FieldByName('phone').AsString;
    qDraveStat.ParamByName('pturn_log_id').AsInteger := qDraveLog.FieldByName('DRAVE_LOG_ID').AsInteger;
  end;
end;

end.
