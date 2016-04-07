unit ReportAbonLK;

interface

uses ComObj, ActiveX,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, MemDS, DBAccess, Ora, Vcl.ActnList,
  Vcl.Grids, Vcl.DBGrids, CRGrid, IntecExportGrid, VirtualTable, sListBox,
  sCheckListBox, Vcl.ExtDlgs, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit ;

type
  TfrmReportAbonLK = class(TForm)
    qReport_1: TOraQuery;
    dsqReport_1: TDataSource;
    dsReport_2: TDataSource;
    qReport_2: TOraQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CRDBGrid2: TCRDBGrid;
    Panel1: TPanel;
    BitBtn3: TBitBtn;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    eBeginDate: TsDateEdit;
    eEndDate: TsDateEdit;
    grData: TCRDBGrid;
    BitBtn2: TBitBtn;
    ActionList1: TActionList;
    aRefresh: TAction;
    aRefresh2: TAction;
    Label1: TLabel;
    Label4: TLabel;
    qKOL: TOraQuery;
    procedure FormCreate(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure aRefresh2Execute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    BeginDate,EndDate:string;
  public
  end;

procedure DoShowReportAbonLK;

implementation

{$R *.dfm}

procedure DoShowReportAbonLK;
var frmReportAbonLK: TfrmReportAbonLK;
begin
  frmReportAbonLK:=TfrmReportAbonLK.Create(Nil);
  try
    frmReportAbonLK.ShowModal;
  finally
    FreeAndNil(frmReportAbonLK);
  end;
end;

function CheckDate(begin_date,end_date:TDate):boolean;
var
 d,m,y:word;
begin
  result:=false;
  if begin_date > end_date then begin
    MessageDlg('Начальная дата не может быть больше конечной даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then begin
    MessageDlg('Начальная дата не может быть больше текущей даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  decodedate(IncMonth(Now,-2),y,m,d);
  result:=true;
end;


procedure TfrmReportAbonLK.aRefresh2Execute(Sender: TObject);
begin
 BeginDate := eBeginDate.Text;
 EndDate := eEndDate.Text;
  if (BeginDate = '  .  .    ') or (EndDate = '  .  .    ') then
  begin
    MessageDlg('Укажите начальную и конечную дату!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if not CheckDate(StrToDate(BeginDate),StrToDate(EndDate)) then
    Exit;
  qReport_2.Close;
  qReport_2.ParamByName('DATE_BEGIN').AsDate:=StrToDate(BeginDate);
  qReport_2.ParamByName('DATE_END').AsDate:=StrToDate(EndDate);
  qReport_2.Open;
  qKOl.Close;
  qKOl.ParamByName('DATE_BEGIN').AsDate:=StrToDate(BeginDate);
  qKOl.ParamByName('DATE_END').AsDate:=StrToDate(EndDate);
  qKOl.Open;
  Label1.Caption := 'Всего пользователей = ' + qKOl.FieldByName('KOL_2').AsString;
  Label4.Caption := 'Активных пользователей c '+BeginDate+' по '+EndDate+' = '+qKOl.FieldByName('KOL_1').AsString;
end;

procedure TfrmReportAbonLK.aRefreshExecute(Sender: TObject);
begin
  qReport_1.Close;
  qReport_1.Open;
end;

procedure TfrmReportAbonLK.BitBtn1Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отче по авторизациям в ЛК с' + eBeginDate.Text +
    ' по ' + eEndDate.Text ,'',grData);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmReportAbonLK.BitBtn2Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчет по кол-ву пользователей ЛК','',CRDBGrid2);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmReportAbonLK.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage := TabSheet1;
end;

end.
