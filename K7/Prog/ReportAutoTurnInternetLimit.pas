unit ReportAutoTurnInternetLimit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, ShowUserStat, IntecExportGrid, ContractsRegistration_Utils,
  TimedMsgBox, VirtualTable;

type
  TReportAutoTurnInternetLimitForm = class(TReportForm)
    edtInternet: TEdit;
    edtMinutes: TEdit;
    lbMonth: TLabel;
    cbMonth: TComboBox;
    lbInternet: TLabel;
    lbMinutes: TLabel;
    pLimit: TPanel;
    Splitter1: TSplitter;
    pBtnLimit: TPanel;
    gLimit: TCRDBGrid;
    qLimit: TOraQuery;
    dsLimit: TDataSource;
    lbLimit: TLabel;
    bLoadInExcelLim: TSpeedButton;
    bShowUserStatInfoLim: TSpeedButton;
    bDeleteLimit: TSpeedButton;
    aDeleteLimit: TAction;
    Panel1: TPanel;
    bLoadInExcelRep: TSpeedButton;
    bShowUserStatInfoRep: TSpeedButton;
    bAddLimit: TSpeedButton;
    aAddLimit: TAction;
    BitBtn1: TBitBtn;
    aShowLimit: TAction;
    aShowUserStatInfoLim: TAction;
    aLoadInExcelLim: TAction;
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure gReportDblClick(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDeleteLimitExecute(Sender: TObject);
    procedure aAddLimitExecute(Sender: TObject);
    procedure aShowLimitExecute(Sender: TObject);
    procedure aShowUserStatInfoLimExecute(Sender: TObject);
    procedure aLoadInExcelLimExecute(Sender: TObject);
    procedure gLimitDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadDataInExcel(gGrid: TCRDBGrid; pNameTitle: string); //выгрузка данных в excel
    procedure InsertDeletePhoneLimit(qReq: TOraQuery; SQLText: string);
  end;

  procedure DoReportAutoTurnInternetLimit;

var
  ReportAutoTurnInternetLimitForm: TReportAutoTurnInternetLimitForm;

implementation

{$R *.dfm}

procedure DoReportAutoTurnInternetLimit;
var ReportFrm: TReportAutoTurnInternetLimitForm;
var i: integer;
begin
  ReportFrm:=TReportAutoTurnInternetLimitForm.Create(Nil);
  try
    with ReportFrm do
    begin
      cbMonth.ItemIndex := cbMonth.Items.IndexOf('2'); //начальное значение 2 месяц
      edtInternet.Text := '100'; //начальное значение 100 ГБ
      edtMinutes.Text := '30'; //начальное значение 30 минут
      //скрываем поля по трафику интернета и исходящим минутам
      //пробегаем по гриду и скрываем соответстующие столбцы
      for I := 0 to gReport.Columns.Count-1 do
      begin
        if (pos('INTERNET_VOL_', gReport.Columns[i].FieldName) > 0) or
           (pos('CALL_MINUTES_', gReport.Columns[i].FieldName) > 0) or
           (pos('PROFIT_', gReport.Columns[i].FieldName) > 0) then
          gReport.Columns[i].Visible := false;
      end;
      //скрываем ограничения
      pLimit.Visible := false;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

//показываем/скрываем ограничения
procedure TReportAutoTurnInternetLimitForm.aShowLimitExecute(Sender: TObject);
begin
  inherited;
  if pLimit.Visible then
  begin
    pLimit.Visible := false;
    Splitter1.Visible := false;
    aShowLimit.Caption := 'Показать ограничения';
    aShowLimit.Hint := 'Показать ограничения';
  end
  else
    begin
      qLimit.Close;
      qLimit.Open;
      Splitter1.Align := alTop;
      pLimit.Visible := true;
      Splitter1.Align := alBottom;
      Splitter1.Visible := true;
      aShowLimit.Caption := 'Скрыть ограничения';
      aShowLimit.Hint := 'Скрыть ограничения';
    end;
end;

//показываем карточку абонента
procedure TReportAutoTurnInternetLimitForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  inherited;
  if not qReport.IsEmpty then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportAutoTurnInternetLimitForm.gReportDblClick(Sender: TObject);
begin
  inherited;
  aShowUserStatInfo.Execute;
end;

procedure TReportAutoTurnInternetLimitForm.aShowUserStatInfoLimExecute(
  Sender: TObject);
begin
  inherited;
  if not qLimit.IsEmpty then
    ShowUserStatByPhoneNumber(qLimit.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportAutoTurnInternetLimitForm.gLimitDblClick(Sender: TObject);
begin
  inherited;
  aShowUserStatInfoLim.Execute;
end;

//выгрузка данных в excel
procedure TReportAutoTurnInternetLimitForm.LoadDataInExcel(gGrid: TCRDBGrid; pNameTitle: string);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(pNameTitle,'', gGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

//выгрузка в excel номеров, подходящие под ограничения
procedure TReportAutoTurnInternetLimitForm.aLoadInExcelExecute(Sender: TObject);
begin
  LoadDataInExcel(gReport, 'Номера, подходящие под ограничения автоподключения интернет-опций')
end;

//выгрузка ограничений в excel
procedure TReportAutoTurnInternetLimitForm.aLoadInExcelLimExecute(
  Sender: TObject);
begin
  inherited;
  LoadDataInExcel(gLimit, 'Номера с ограничением автоподключения интернет-опций');
end;

//вставка/удаление номера из ограничений
procedure TReportAutoTurnInternetLimitForm.InsertDeletePhoneLimit(qReq: TOraQuery; SQLText: string);
var qS: TOraQuery;
begin
  qS := TOraQuery.Create(nil);
  try
    qS.SQL.Text:= SQLText;
    qS.ParamByName('pPHONE_NUMBER').AsString := qReq.FieldByName('PHONE_NUMBER').AsString;
    qS.ParamByName('pCONTRACT_ID').AsInteger := qReq.FieldByName('CONTRACT_ID').AsInteger;
    qS.ExecSQL;
  finally
    FreeAndNil(qS);
  end;

  qLimit.Close;
  qLimit.Open;
end;

//добавляем номер в ограничения
procedure TReportAutoTurnInternetLimitForm.aAddLimitExecute(Sender: TObject);
begin
  inherited;
  if not qReport.IsEmpty then
  begin
    if MessageDlg('Добавить номер ' + qReport.FieldByName('PHONE_NUMBER').AsString + ' в ограничения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      InsertDeletePhoneLimit(qReport, qLimit.SQLInsert.Text);
  end
  else
   showmessage('Отсутствуют данные для вставки!');
end;

//удаляем номер из ограничений
procedure TReportAutoTurnInternetLimitForm.aDeleteLimitExecute(Sender: TObject);
begin
  inherited;
  if not qLimit.IsEmpty then
  begin
    if MessageDlg('Удалить номер ' + qLimit.FieldByName('PHONE_NUMBER').AsString + ' из ограничений?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      InsertDeletePhoneLimit(qLimit, qLimit.SQLDelete.Text);
  end
  else
    showmessage('Отсутствуют данные для удаления!');
end;

procedure TReportAutoTurnInternetLimitForm.aRefreshExecute(Sender: TObject);
var i, k, l, s:   integer;
    err: boolean;
begin
  //проверяем корректность ввода данных
  err := true;
  if (Length(edtInternet.Text) <> 0) and (Length(edtMinutes.Text) <> 0) then
  begin
    //проверяем на то, чтобы все символы были цифрами (предел интернета)
    for i := 1 to Length(edtInternet.Text) do
      if not (edtInternet.Text[i] in ['0'..'9']) then
      begin
        err := false;
        break;
      end;
    //если по пределу интернета все ок, то проверяем предел минут
    if err then
      for i := 1 to Length(edtMinutes.Text) do
        if not (edtMinutes.Text[i] in ['0'..'9']) then
        begin
          err := false;
          break;
        end;
  end
  else
    err := false;

  if err then
  begin
    //скрываем поля по трафику интернета и исходящим минутам
    //пробегаем по гриду и скрываем соответстующие столбцы
    for I := 0 to gReport.Columns.Count-1 do
    begin
      if (pos('INTERNET_VOL_', gReport.Columns[i].FieldName) > 0) or
         (pos('CALL_MINUTES_', gReport.Columns[i].FieldName) > 0) or
         (pos('PROFIT_', gReport.Columns[i].FieldName) > 0) then
        if gReport.Columns[i].Visible then
         gReport.Columns[i].Visible := false;
    end;

    //показываем столбцы по которым имеются данные
    //столбцы по парядку меньше количества моделируемых месяцев
    k:= 1;
    l:= 1;
    s:= 1;
    for I := 0 to gReport.Columns.Count-1 do
    begin
      if (pos('INTERNET_VOL_', gReport.Columns[i].FieldName) > 0) then
      begin
        if k <= strtoint(cbMonth.Text) then
        begin
          gReport.Columns[i].Title.Caption := 'Интернет за ' + FormatDateTime('mm.yyyy', IncMonth(Now,-k)) + ', МБ';
          gReport.Columns[i].Visible := true;
        end;

        k := k + 1;
      end
      else
        if (pos('CALL_MINUTES_', gReport.Columns[i].FieldName) > 0) then
        begin
          if l <= strtoint(cbMonth.Text) then
          begin
          gReport.Columns[i].Title.Caption := 'Исх. минут за ' + FormatDateTime('mm.yyyy', IncMonth(Now,-l));
          gReport.Columns[i].Visible := true;
          end;

          l := l + 1;
        end
        else
          if (pos('PROFIT_', gReport.Columns[i].FieldName) > 0) then
          begin
            if s <= strtoint(cbMonth.Text) then
            begin
              gReport.Columns[i].Title.Caption := 'Доходность за ' + FormatDateTime('mm.yyyy', IncMonth(Now,-s));
              gReport.Columns[i].Visible := true;
            end;

            s := s + 1;
        end
    end;

    qReport.ParamByName('pMONTH').AsInteger := strtoint(cbMonth.Text);
    qReport.ParamByName('pINTERNET').AsInteger := strtoint(edtInternet.Text);
    qReport.ParamByName('pMINUTES').AsInteger := strtoint(edtMinutes.Text);
    qReport.Close;
    qReport.Open;
  end
  else
    showmessage('Параметры переформирования отчета введены не корректно!');
end;

end.
