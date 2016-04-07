unit ReportAllSendSms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls, IntecExportGrid;

type
  TReportAllSendSmsFrm = class(TReportForm)
    Label1: TLabel;
    dtFrom: TDateTimePicker;
    dtTo: TDateTimePicker;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    qReportPHONE_NUMBER: TStringField;
    qReportSMS_TEXT: TStringField;
    qReportDATE_SEND: TDateTimeField;
    qReportPROV: TStringField;
    aShowUserStatInfo: TAction;
    cbSearch: TCheckBox;
    qReportGR: TCRDBGrid;
    STATUS: TStringField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
  private
    { Private declarations }

     BeginDate,EndDate:string;
  public
    { Public declarations }
  end;
   procedure DoReportAllSendSms;

var
  ReportAllSendSmsFrm: TReportAllSendSmsFrm;

implementation

{$R *.dfm}
uses main,ShowUserStat;

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



procedure DoReportAllSendSms;
var
ReportFrm : TReportAllSendSmsFrm;
begin
 ReportFrm := TReportAllSendSmsFrm.Create(Nil);
 try
  ReportFrm.DtFrom.Date:=(Now-1);
  ReportFrm.DtTo.Date:=Now;
  ReportFrm.ShowModal;
 finally
  ReportFrm.Free;
 end;
 end;

procedure TReportAllSendSmsFrm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Журнал отправленных SMS  ','', gReport, False, True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TReportAllSendSmsFrm.aRefreshExecute(Sender: TObject);
begin
  BeginDate := datetostr(DtFrom.Date);
  EndDate := datetostr(DtTo.Date);
  TRY
    if (BeginDate = '  .  .    ') or (EndDate = '  .  .    ') then
    begin
      MessageDlg('Укажите начальную и конечную дату!', mtConfirmation, [mbOK], 0);
      exit;
    end;
    if not CheckDate(StrToDate(BeginDate),StrToDate(EndDate)) then
      Exit;

    qReport.Close;
    //  showmessage(qReport.sql.text);
    qReport.Prepare;
    qReport.ParamByName('DATE_BEGIN').AsDate := StrToDate(BeginDate);
    qReport.ParamByName('DATE_END').AsDate := StrToDate(EndDate);
    qReport.Open;
  Except
  END;
end;



procedure TReportAllSendSmsFrm.aShowUserStatInfoExecute(Sender: TObject);
begin
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;



procedure TReportAllSendSmsFrm.cbSearchClick(Sender: TObject);
begin

  if cbSearch.Checked then
    qReportGR.OptionsEx:=qReportGR.OptionsEx+[dgeSearchBar]
  else
    qReportGR.OptionsEx:=qReportGR.OptionsEx-[dgeSearchBar];
end;

end.



