unit ReportTariffViolations;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, IntecExportGrid, ShowUserStat, ActnList, ContractsRegistration_Utils;

type
  TReportTariffViolationsFrm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    TariffViolationsGrid: TCRDBGrid;
    qTariffViolations: TOraQuery;
    dsTariffViolations: TDataSource;
    qPeriods: TOraQuery;
    lPeriod: TLabel;
    cbPeriod: TComboBox;
    alTariffViolations: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qTariffViolationsPHONE_NUMBER: TStringField;
    qTariffViolationsCELL_PLAN_CODE: TStringField;
    qTariffViolationsTARIFF_CODE: TStringField;
    qTariffViolationsYEAR_MONTH: TFloatField;
    qTariffViolationsTARIFF_NAME_FROM_OPERATOR: TStringField;
    qTariffViolationsTARIFF_NAME: TStringField;
    cbSearch: TCheckBox;
    cbAccounts: TComboBox;
    lAccount: TLabel;
    qAccounts: TOraQuery;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TarViolOptionGrid: TCRDBGrid;
    qTarViolOptions: TOraQuery;
    dsTarViolOptions: TDataSource;
    qTarViolOptionsPHONE_NUMBER_FEDERAL: TStringField;
    qTarViolOptionsTARIFF_CODE: TStringField;
    qTarViolOptionsTARIFF_NAME: TStringField;
    qTarViolOptionsOPTION_CODE: TStringField;
    qTarViolOptionsOPTION_NAME: TStringField;
    procedure cbPeriodChange(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoReportTariffViolations;

var
  ReportTariffViolationsFrm: TReportTariffViolationsFrm;

implementation

{$R *.dfm}

procedure DoReportTariffViolations;
var ReportFrm : TReportTariffViolationsFrm;
    Sdvig, i:integer;
begin
  ReportFrm:=TReportTariffViolationsFrm.Create(Nil);
  With  ReportFrm do
  begin
    try
      // Период
      qPeriods.Open;
      while not qPeriods.EOF do
      begin
        cbPeriod.Items.AddObject(
          qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
          TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
          );
        qPeriods.Next;
      end;
      qPeriods.Close;
      if cbPeriod.Items.Count > 0 then
        cbPeriod.ItemIndex := 0;
          if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
      begin
        lAccount.Show;
        cbAccounts.Show;
        qAccounts.Open;
        cbAccounts.Items.AddObject('Все', Pointer(0));
        while not ReportFrm.qAccounts.EOF do
        begin
          cbAccounts.Items.AddObject(
            qAccounts.FieldByName('LOGIN').AsString,
            Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
            );
          qAccounts.Next;
        end;
        qAccounts.Close;
        if cbAccounts.Items.Count > 0 then
          cbAccounts.ItemIndex := 0;
        if Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])<>0 then
          qTariffViolations.ParamByName('ACCOUNT_ID').asInteger :=
            Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
        else qTariffViolations.ParamByName('ACCOUNT_ID').Clear;
      end else
      begin
        Sdvig:=cbAccounts.Left+cbAccounts.Width;
        lAccount.Hide;
        cbAccounts.Hide;
        btLoadInExcel.Left:=btLoadInExcel.Left-Sdvig;
        btRefresh.Left:=btRefresh.Left-Sdvig;
        btInfoAbonent.Left:=btInfoAbonent.Left-Sdvig;
        cbSearch.Left:=cbSearch.Left-Sdvig;
        lPeriod.Left:=lPeriod.Left-Sdvig;
        cbPeriod.Left:=cbPeriod.Left-Sdvig;
        qTariffViolations.ParamByName('ACCOUNT_ID').Clear;
      end;
      // Отчет
      cbPeriodChange(ReportFrm.cbPeriod);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TReportTariffViolationsFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчёт по нарушениям в тарифах за' + cbPeriod.Text
      + ' по состоянию на '+DateToStr(Date),'',
      TariffViolationsGrid, nil, False, True);
    ExportDBGridToExcel2('Отчёт по нарушениям в тарифах по услугам за' + cbPeriod.Text
      + ' по состоянию на '+DateToStr(Date),'',
      TarViolOptionGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportTariffViolationsFrm.aRefreshExecute(Sender: TObject);
begin
  qTariffViolations.Close;
  qTariffViolations.Open;
  qTarViolOptions.Close;
  qTarViolOptions.Open;
end;

procedure TReportTariffViolationsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qTariffViolations.Active and (qTariffViolations.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qTariffViolations.FieldByName('PHONE_NUMBER').AsString, 0);
  if qTarViolOptions.Active and (qTarViolOptions.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qTarViolOptions.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportTariffViolationsFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else Account:=0;
  if Account<>0 then
  begin
    qTariffViolations.ParamByName('ACCOUNT_ID').asInteger := Account;
  //  aRefresh.Execute;
  end else
  begin
    qTariffViolations.ParamByName('ACCOUNT_ID').Clear;
  //  aRefresh.Execute;
  end;
end;

procedure TReportTariffViolationsFrm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qTariffViolations.ParamByName('YEAR_MONTH').AsInteger := Period;
 // aRefresh.Execute;
end;

procedure TReportTariffViolationsFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    TariffViolationsGrid.OptionsEx:=TariffViolationsGrid.OptionsEx+[dgeSearchBar]
  else
    TariffViolationsGrid.OptionsEx:=TariffViolationsGrid.OptionsEx-[dgeSearchBar];
  if cbSearch.Checked then
    TarViolOptionGrid.OptionsEx:=TarViolOptionGrid.OptionsEx+[dgeSearchBar]
  else
    TarViolOptionGrid.OptionsEx:=TarViolOptionGrid.OptionsEx-[dgeSearchBar];
end;

end.
