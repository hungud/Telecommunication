unit ReportReplaceSIM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, DB, MemDS, DBAccess, Ora, ComCtrls, ToolWin, Grids, DBGrids,
  CRGrid, IntecExportGrid, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, Mask;

type
  TReportReplaceSIMFrm = class(TForm)
    dsReplaceSIM: TDataSource;
    qReplaceSIM: TOraQuery;
    GrData: TCRDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    Panel2: TPanel;
    qReplaceSIMOLD_SIM: TStringField;
    qReplaceSIMNEW_SIM: TStringField;
    qReplaceSIMREP_USER: TStringField;
    qReplaceSIMREP_DATE: TDateTimeField;
    qReplaceSIMERROR: TStringField;
    qReplaceSIMSOAP_REQUEST: TStringField;
    qReplaceSIMANSWER: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    DBTQuery: TDBEdit;
    DBTAnswer: TDBEdit;
    qReplaceSIMLOG_TYPE: TStringField;
    procedure FormShow(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
  private
    { Private declarations }
  public

  end;
    procedure ExecuteRRS(const pPhoneNumber : String; adm :boolean);
implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

procedure TReportReplaceSIMFrm.FormShow(Sender: TObject);
var Sdvig:integer;
begin
//  if GetConstantValue('SHOW_REPORT_ACCOUNT_STAT_NOW')='1' then

//   Grdata.Columns.Items[0].Width:=150;

  //показываем/скрываем столбец типа лога
  VisibleColumnByFieldName(GrData, qReplaceSIMLOG_TYPE.FieldName, (GetConstantValue('SERVER_NAME') = 'CORP_MOBILE'));
end;

procedure ExecuteRRS(const pPhoneNumber : String; adm : boolean);
var ReportFrm : TReportReplaceSIMFrm;
begin
  ReportFrm:=TReportReplaceSIMFrm.Create(Nil);
  ReportFrm.qReplaceSIM.ParamByName('PPHONE').AsString:=pPhoneNumber;
  if adm then  ReportFrm.Panel2.Height:=38
  else ReportFrm.Panel2.Height:=0;
  try
    ReportFrm.qReplaceSIM.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportReplaceSIMFrm.aRefreshExecute(Sender: TObject);
begin
  qReplaceSIM.Close;
  qReplaceSIM.Open;
end;

procedure TReportReplaceSIMFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
//  if qKolNom.Active and (qKolNom.RecordCount > 0) then
//  begin
//    ShowUserStatByPhoneNumber(qKolNom.FieldByName('PHONE_NUMBER').AsString, 0);
//  end;
end;

procedure TReportReplaceSIMFrm.cbAccountsChange(Sender: TObject);
var
  Account : integer;
  ACC:string;
begin
end;

procedure TReportReplaceSIMFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Замены SIM.','', GrData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

end.
