unit ReportKolNom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, MemDS, DBAccess, Ora, ComCtrls, ToolWin, Grids, DBGrids,
  CRGrid, IntecExportGrid, ShowUserStat, StdCtrls, Buttons,
  ExtCtrls;

type
  TReportKolNomFrm = class(TForm)
    dsKolNom: TDataSource;
    qKolNom: TOraQuery;
    GrData: TCRDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbSearch: TCheckBox;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    procedure FormShow(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TReportKolNomFrm.FormShow(Sender: TObject);
var Sdvig:integer;
begin
//  if GetConstantValue('SHOW_REPORT_ACCOUNT_STAT_NOW')='1' then
   qKolNom.Open;
   Grdata.Columns.Items[0].Width:=150;
end;

procedure TReportKolNomFrm.aRefreshExecute(Sender: TObject);
begin
  qKolNom.Close;
  qKolNom.Open;
end;

procedure TReportKolNomFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
//  if qKolNom.Active and (qKolNom.RecordCount > 0) then
//  begin
//    ShowUserStatByPhoneNumber(qKolNom.FieldByName('PHONE_NUMBER').AsString, 0);
//  end;
end;

procedure TReportKolNomFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
  ACC:string;
begin
end;

procedure TReportKolNomFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportKolNomFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Количество номеров на счёте.','', GrData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

end.
