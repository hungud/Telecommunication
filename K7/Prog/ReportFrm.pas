unit ReportFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, CRGrid, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Ora, Vcl.ActnList,
  ExecutingForm;

type
  TReportForm = class(TExecutingForm)
    pButtons: TPanel;
    pGrid: TPanel;
    gReport: TCRDBGrid;
    btRefresh: TBitBtn;
    btLoadInExcel: TBitBtn;
    qReport: TOraQuery;
    dsReport: TDataSource;
    aList: TActionList;
    aRefresh: TAction;
    aLoadInExcel: TAction;
    aShowUserStatInfo: TAction;
    btnShowUserStatInfo: TBitBtn;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportForm: TReportForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

//выгрузка в Excel
procedure TReportForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.Open;
end;

//обновляем данные
procedure TReportForm.aLoadInExcelExecute(Sender: TObject);
begin
  //выгрузка в Excel
end;

end.
