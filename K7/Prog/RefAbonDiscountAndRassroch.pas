unit RefAbonDiscountAndRassroch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, ActnList,
  Grids, DBGrids, CRGrid;

type
  TRefAbonDiscountAndRassrochForm = class(TForm)
    Panel1: TPanel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    dsRef: TDataSource;
    qRef: TOraQuery;
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qRefCONTRACT_NUM: TFloatField;
    qRefCONTRACT_DATE: TDateTimeField;
    qRefPHONE_NUMBER_FEDERAL: TStringField;
    qRefABON_TP_DISCOUNT: TFloatField;
    qRefINSTALLMENT_PAYMENT_DATE: TDateTimeField;
    qRefINSTALLMENT_PAYMENT_SUM: TFloatField;
    qRefINSTALLMENT_PAYMENT_MONTHS: TFloatField;
    cbFilter: TComboBox;
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoRefAbonDiscountAndRassroch;

var
  RefAbonDiscountAndRassrochForm: TRefAbonDiscountAndRassrochForm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, IntecExportGrid;

procedure DoRefAbonDiscountAndRassroch;
var RefFrm : TRefAbonDiscountAndRassrochForm;
    Sdvig:integer;
begin
  RefFrm:=TRefAbonDiscountAndRassrochForm.Create(Nil);
  RefFrm.cbFilterChange(Nil);
  try
    // Отчет
    RefFrm.ShowModal;
  finally
    RefFrm.Free;
  end;
end;

procedure TRefAbonDiscountAndRassrochForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Рассрочки и абон. скидки','', grData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefAbonDiscountAndRassrochForm.aRefreshExecute(Sender: TObject);
begin
  qRef.Close;
  qRef.Open;
end;

procedure TRefAbonDiscountAndRassrochForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qRef.Active and (qRef.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qRef.FieldByName('PHONE_NUMBER_FEDERAL').AsString,0);
  end;
end;

procedure TRefAbonDiscountAndRassrochForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TRefAbonDiscountAndRassrochForm.cbFilterChange(Sender: TObject);
begin
  qRef.ParamByName('SHOW_MOD').AsInteger:=cbFilter.ItemIndex;
  aRefresh.Execute;
end;

end.
