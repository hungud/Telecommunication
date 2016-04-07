unit ReportCallSummaryStat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBAccess, Ora, Data.DB, MemDS,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ExtCtrls, IntecExportGrid, Main, ShowUserStat;

type
  TReportCallSummaryStatFrm = class(TForm)
    pFiltr: TPanel;
    pGrid: TPanel;
    g1: TCRDBGrid;
    dblkcbbPeriodBegin: TDBLookupComboBox;
    dblkcbbPeriodEnd: TDBLookupComboBox;
    lbl3: TLabel;
    lbl4: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    bAbonentInfo: TBitBtn;
    qMain: TOraQuery;
    dsMain: TDataSource;
    qPeriod: TOraQuery;
    dsPeriod: TOraDataSource;
    qPeriod2: TOraQuery;
    dsPeriod2: TOraDataSource;
    spCALC_CALL_SUMMARY_STAT: TOraStoredProc;
    procedure btRefreshClick(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
    procedure bAbonentInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportCallSummaryStatFrm: TReportCallSummaryStatFrm;
  procedure DoReportCallSummaryStat;

implementation

{$R *.dfm}

procedure DoReportCallSummaryStat;
var
  ReportFrm : TReportCallSummaryStatFrm;
begin
  ReportFrm := TReportCallSummaryStatFrm.Create(Nil);
  try
    // Заполнение списка заявок
    with ReportFrm do begin
      //dtBeginPerioYEAR_MONTH.Date := Date;
      qMain.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyField;
      qMain.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyField;

      (*
      // заполняем Список лицевых счетов
      qAccounts.Open;
      qAccounts.First;
      while not qAccounts.EOF do
      begin
        CLB_Accounts.Items.AddObject(
          qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;
      *)


      qPeriod2.Close;
      qPeriod2.Open;
      qPeriod.Close;
      qPeriod.Open;
      //устанавливаем значение для периода
      dblkcbbPeriodBegin.KeyValue := qPeriod.FieldByName('YEAR_MONTH').Value;
      dblkcbbPeriodEnd.KeyValue := qPeriod2.FieldByName('YEAR_MONTH').Value;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportCallSummaryStatFrm.bAbonentInfoClick(Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qMain.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
end;

procedure TReportCallSummaryStatFrm.btLoadInExcelClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет по анализу исходящего голосового трафика, Период: ' +
      qPeriod.FieldByName('MONTH_YEAR_STRING').AsString + ' - ' + qPeriod2.FieldByName('MONTH_YEAR_STRING').AsString, '',
      g1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportCallSummaryStatFrm.btRefreshClick(Sender: TObject);
var
  cr : TCursor;
begin
  try
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try

      // Сначала считаем статистику за текущий период, если текущий период включен в условия
      if (StrToInt(FormatDateTime('yyyymm', Now)) = dblkcbbPeriodEnd.KeyValue)  then
      begin
        spCALC_CALL_SUMMARY_STAT.ParamByName('PYEAR_MONTH').AsInteger := StrToInt(FormatDateTime('yyyymm', Now));
        spCALC_CALL_SUMMARY_STAT.ParamByName('CALC_CUR_CALL').AsInteger := 1; // 1 - пересчитывать статистику за текущий период
        spCALC_CALL_SUMMARY_STAT.ExecProc;
      end;

      qMain.Close;
      qMain.ParamByName('pYEAR_MONTH_BEGIN').AsInteger := dblkcbbPeriodBegin.KeyValue;
      qMain.ParamByName('pYEAR_MONTH_END').AsInteger := dblkcbbPeriodEnd.KeyValue;
      qMain.Open;
      //qMain.Close;
    except
      on e: Exception do
      begin
        MessageDlg('Произошла ошибка при запросе данных.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Screen.Cursor := cr;
  end;
end;

end.
