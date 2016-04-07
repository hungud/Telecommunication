unit PhoneNumberBlockInSave;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus,
  Vcl.ActnList, Data.DB, MemDS, DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TPhoneNumberBlockInSaveFrm = class(TForm)
    ToolBar1: TToolBar;
    btnaInsert: TToolButton;
    btnaEdit: TToolButton;
    btnaDelete: TToolButton;
    ToolButton7: TToolButton;
    btnaPost: TToolButton;
    btnaCancel: TToolButton;
    ToolButton8: TToolButton;
    btnaRefresh: TToolButton;
    ts1dbgrd: TCRDBGrid;
    DataSource1: TDataSource;
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    LoadInExcel: TBitBtn;
    aExcel: TAction;
    qReport: TOraQuery;
    qReportPHONE_NUMBER: TStringField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    procedure aExcelExecute(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qReportBeforePost(DataSet: TDataSet);
  private

  public
    { Public declarations }

  end;
  procedure DoPhoneNumberBlockInSave;

var
  PhoneNumberBlockInSaveFrm: TPhoneNumberBlockInSaveFrm;

implementation

{$R *.dfm}
uses IntecExportGrid, Main;


procedure DoPhoneNumberBlockInSave;
var
  ReportFrm : TPhoneNumberBlockInSaveFrm;
begin
  ReportFrm:=TPhoneNumberBlockInSaveFrm.Create(Nil);
  ReportFrm.qReport.Open;
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TPhoneNumberBlockInSaveFrm.aCancelExecute(Sender: TObject);
begin
  qReport.Cancel;
end;

procedure TPhoneNumberBlockInSaveFrm.aDeleteExecute(Sender: TObject);
begin
  qReport.Delete;
end;

procedure TPhoneNumberBlockInSaveFrm.aEditExecute(Sender: TObject);
begin
  qReport.Edit;
end;

procedure TPhoneNumberBlockInSaveFrm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  if qReport.Active then
  begin
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ExportDBGridToExcel2('Список номеров, заблокированных по сохранению.','',ts1dbgrd, nil, False, True);
     //ExportDBGrid(ReportBillsForm.Caption + ' за ' + cbPeriod.Text + ' по состоянию на '+DateToStr(Date),'','Счета_'+cbPeriod.Text, grData, True, True);
    finally
      Screen.Cursor := cr;
    end;
  end
  else
    ShowMessage('Нет данных для выгрузки!!!');

end;

procedure TPhoneNumberBlockInSaveFrm.aInsertExecute(Sender: TObject);
begin
  qReport.Insert;
end;

procedure TPhoneNumberBlockInSaveFrm.aPostExecute(Sender: TObject);
begin
  if qReport.FieldByName('PHONE_NUMBER').IsNull then
    MessageDlg('Поле "Номер телефона" должно быть заполнено', mtWarning, [mbOK], 0)
  else
    qReport.Post;
end;

procedure TPhoneNumberBlockInSaveFrm.aRefreshExecute(Sender: TObject);
begin
  qReport.Refresh;
end;


procedure TPhoneNumberBlockInSaveFrm.FormCreate(Sender: TObject);
var
  IsAdmin,      FIsAdmin: boolean;
begin
  MainForm.CheckAdminPrivs(IsAdmin);
  FIsAdmin:= IsAdmin;
  if not IsAdmin then
    btnaDelete.visible:=False;
end;


procedure TPhoneNumberBlockInSaveFrm.qReportBeforePost(DataSet: TDataSet);
begin
  if qReport.FieldByName('PHONE_NUMBER').IsNull then
  begin
    MessageDlg('Поле "Номер телефона" должно быть заполнено', mtWarning, [mbOK], 0);
    abort;
  end;
end;

end.
