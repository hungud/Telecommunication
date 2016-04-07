unit ReportSendSmsEndMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, CRGrid, ActnList, IntecExportGrid, ShowUserStat;

type
  TReportSendSmsEndMonthFrm = class(TForm)
    GrData: TCRDBGrid;
    Panel1: TPanel;
    qSendSms: TOraQuery;
    dsSendSms: TDataSource;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cbSearch: TCheckBox;
    qAccounts: TOraQuery;
    procedure FormShow(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//procedure
var
  ReportSendSmsEndMonthFrm: TReportSendSmsEndMonthFrm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure TReportSendSmsEndMonthFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TReportSendSmsEndMonthFrm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qSendSms.SQL.Insert(9, 'AND ' + IntToStr(MainForm.FFilial)
     + ' = (SELECT AC.FILIAL_ID FROM ACCOUNTS AC '
     + 'WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID = AC.ACCOUNT_ID)');
    qAccounts.SQL.Insert(2, 'WHERE FILIAL_ID=' + IntToStr(MainForm.FFilial));
  end;
end;

procedure TReportSendSmsEndMonthFrm.FormShow(Sender: TObject);
begin
  qSendSms.Open;
end;

procedure TReportSendSmsEndMonthFrm.aRefreshExecute(Sender: TObject);
begin
  qSendSms.Close;
  qSendSms.Open;
end;

procedure TReportSendSmsEndMonthFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
  if qSendSms.Active and (qSendSms.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qSendSms.FieldByName('PHONE_NUMBER').AsString, 0);
  end;
end;

procedure TReportSendSmsEndMonthFrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TReportSendSmsEndMonthFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Журнал отправленных СМС','', GrData, False);
  finally
    Screen.Cursor := cr;
  end;
end;

end.
