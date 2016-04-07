unit ReportHotBillingMissing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ActnList, Data.DB, MemDS, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid;

type
  TfrmHotBilling = class(TForm)
    grData: TCRDBGrid;
    DSHotBillDiff: TDataSource;
    QHotBillDiff: TOraQuery;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    qCheckTable: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
  private
    vYear, vMonth : integer;
    procedure GetCurYM;
  public
    procedure QrRefresh;
  end;

procedure DofrmHotBilling;

implementation

Uses ExportGridToExcelPDF;

{$R *.dfm}

procedure TfrmHotBilling.GetCurYM;
var
  YEAR_MONTH : integer;
begin
  if ( cbPeriod.Items.Count > 0 ) then
  begin
    if cbPeriod.ItemIndex >= 0 then
      YEAR_MONTH := integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
    else
    YEAR_MONTH := -1;
    if YEAR_MONTH>0 then
    begin
      vYear  := trunc(YEAR_MONTH/100);
      vMonth := YEAR_MONTH-trunc(YEAR_MONTH/100)*100;
    end
    else
    begin
      vYear  := 0;
      vMonth := 0;
    end;
  end
  else
  begin
    vYear  := 0;
    vMonth := 0;
  end;
end;

procedure TfrmHotBilling.aExcelExecute(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGrid('Отчёт "Пропажи горячего биллинга" за ' + cbPeriod.Text ,'','', grData, True,True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmHotBilling.aRefreshExecute(Sender: TObject);
begin
  QrRefresh;
end;

procedure TfrmHotBilling.cbPeriodChange(Sender: TObject);
begin
  QrRefresh;
end;

procedure TfrmHotBilling.FormCreate(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    qPeriods.Close;
    with qPeriods do
    begin
      qPeriods.SQL.Text:='select '+#13#10+
                         '   distinct '+#13#10+
                         '     YEAR_MONTH, '+#13#10+
                         '     substr(YEAR_MONTH,5,2)||'' - ''||substr(YEAR_MONTH,1,4) as YEAR_MONTH_NAME '+#13#10+
                         'from '+#13#10+
                         '   DB_LOADER_FULL_FINANCE_BILL ul '+#13#10+
                         'order by '+#13#10+
                         '  YEAR_MONTH desc';
      Open; First;
      while not EOF do
      begin
        cbPeriod.Items.AddObject(
           FieldByName('YEAR_MONTH_NAME').AsString,
           TObject(FieldByName('YEAR_MONTH').Asinteger)
        );
        Next;
      end;
      Close;
    end;
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TfrmHotBilling.QrRefresh;
var
  vTbName, vVal : string;
begin
  GetCurYM;
  if ((vYear>0) and (vMonth>0)) then
  begin
    // ПРОВЕРИМ СУЩЕСТВОВАНИЕ ТЕБЛИЦЫ
    qCheckTable.SQL.Text:='select 1 from user_tables t where t.TABLE_NAME=:pTABLE_NAME';
    if vMonth<10 then
    begin
      vTbName := 'CALL_0'+inttostr(vMonth)+'_'+inttostr(vYear);
      vVal := inttostr(vYear)+'0'+inttostr(vMonth);
    end
    else
    begin
      vTbName := 'CALL_'+inttostr(vMonth)+'_'+inttostr(vYear);
      vVal := inttostr(vYear)+inttostr(vMonth);
    end;
    qCheckTable.ParamByName('pTABLE_NAME').AsString := vTbName;
    qCheckTable.Open;
    qCheckTable.First;
    if qCheckTable.Eof then
    begin
      ShowMessage('Нет данных по заданному месяцу.');
      Exit;
    end;
    // собственно запрос
    QHotBillDiff.Close;
    QHotBillDiff.ParamByName('pyear_month').Value := StrToInt(vVal);
    QHotBillDiff.Open;
    QHotBillDiff.First;
  end;
end;

procedure DofrmHotBilling;
var
  frmHotBilling: TfrmHotBilling;
begin
  frmHotBilling := TfrmHotBilling.Create(Application);
  try
    frmHotBilling.QrRefresh;
    frmHotBilling.ShowModal;
  finally
    FreeAndNil(frmHotBilling);
  end;
end;

end.
