unit ReportReceivables;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TReportReceivablesForm = class(TReportForm)
    lAccount: TLabel;
    cbAccounts: TComboBox;
    Label1: TLabel;
    cbPeriod: TComboBox;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    qFastPeriods: TOraQuery;
    qReportACCOUNT_ID: TFloatField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportCOMPANY_NAME: TStringField;
    qReportPHONE_NUMBER: TStringField;
    qReportDEBIT_VAL: TFloatField;
    qReportBALANCE: TFloatField;
    qReportCOMMENT_CLENT: TStringField;
    procedure cbSearchClick(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportReceivablesForm: TReportReceivablesForm;

procedure DoReportReceivables;

implementation

{$R *.dfm}

uses ShowUserStat, IntecExportGrid;

procedure DoReportReceivables;
var ReportFrm : TReportReceivablesForm;
    Sdvig:integer;
begin
  ReportFrm := TReportReceivablesForm.Create(Nil);
  try
    with ReportFrm do begin
      //заполняем периоды
      qFastPeriods.Open;
      while not ReportFrm.qFastPeriods.EOF do
      begin
        cbPeriod.Items.AddObject(
          qFastPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
          TObject(qFastPeriods.FieldByName('YEAR_MONTH').AsInteger)
          );
        qFastPeriods.Next;
      end;
      qFastPeriods.Close;

      if cbPeriod.Items.Count > 0 then
        cbPeriod.ItemIndex := 0;

      //заполняем лиц. счета
      qAccounts.Open;
      cbAccounts.Items.AddObject('Все', Pointer(0));
      while not qAccounts.EOF do
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

      cbAccountsChange(cbAccounts);
      cbPeriodChange(cbPeriod);
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportReceivablesForm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Информация о дебиторской задолженности','',
      gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportReceivablesForm.aShowUserStatInfoExecute(Sender: TObject);
begin
  inherited;
  if qReport.Active and (qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;

procedure TReportReceivablesForm.cbAccountsChange(Sender: TObject);
var Account: integer;
begin
  inherited;
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else
    Account:=0;

  if Account<>0 then
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account
  else
    qReport.ParamByName('ACCOUNT_ID').Clear;
end;

procedure TReportReceivablesForm.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;

  qReport.ParamByName('pYEAR_MONTH').AsInteger := Period;
end;

procedure TReportReceivablesForm.cbSearchClick(Sender: TObject);
begin
  inherited;
  if cbSearch.Checked then
    gReport.OptionsEx := gReport.OptionsEx+[dgeSearchBar]
  else
    gReport.OptionsEx := gReport.OptionsEx-[dgeSearchBar];
end;

end.
