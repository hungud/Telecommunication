unit ReportFieldDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora, StdCtrls, Buttons,
  ExtCtrls, Vcl.ComCtrls, Vcl.Mask, sMaskEdit, sCustomComboEdit, sTooledit,dateutils;

type
  TReportFieldDetailsForm = class(TForm)
    qReportJSM: TOraQuery;
    dsMain: TDataSource;
    qReportJSM_CALLING_NO: TStringField;
    grData: TCRDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbPeriod: TComboBox;
    lPeriod: TLabel;
    qPeriods: TOraQuery;
    PageControl1: TPageControl;
    tsMain: TTabSheet;
    tsSearch: TTabSheet;
    eEndDate: TsDateEdit;
    Label2: TLabel;
    eBeginDate: TsDateEdit;
    Label1: TLabel;
    Panel2: TPanel;
    CRDBGrid1: TCRDBGrid;
    dsSearch: TDataSource;
    qSearch: TOraQuery;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    eCalling_no: TEdit;
    qSearchsubscr_no: TStringField;
    qSearchexists_contract: TStringField;
    qAllTables: TOraQuery;
    btInfoAbonent: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btInfoAbonentClick(Sender: TObject);
  private
    { Private declarations }
    function checkAllTables(call:string):boolean;
  public
    { Public declarations }
  end;

procedure DoReportFieldDetails;

var
  ReportFieldDetailsForm: TReportFieldDetailsForm;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, IntecExportGrid;

procedure DoReportFieldDetails;
var ReportFrm : TReportFieldDetailsForm;
    Sdvig:INTEGER;
begin
  ReportFrm := TReportFieldDetailsForm.Create(Nil);
  try
    ReportFrm.PageControl1.ActivePage:=ReportFrm.tsMain;
    ReportFrm.Caption:='Ќомера собеседников';
    ReportFrm.tsMain.Caption:='Ќомера собеседников';
    ReportFrm.tsSearch.tabVisible:=true;
    ReportFrm.dsMain.DataSet:=ReportFrm.qReportJSM;
    //период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
       ReportFrm.cbPeriod.Items.Add(ReportFrm.qPeriods.FieldByName('PERIOD').AsString);
      ReportFrm.qPeriods.Next;
    end;

    ReportFrm.lPeriod.Show;
    ReportFrm.cbPeriod.Show;

    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportFieldDetailsForm.BitBtn1Click(Sender: TObject);
begin
  if cbPeriod.Text = '' then
  begin
    MessageDlg('Ќе задан период!', mtError, [mbOK], 0);
    exit;
  end;
  qReportJSM.Close;
  qReportJSM.SQL.Text:='SELECT DISTINCT calling_no FROM CALL_'+cbPeriod.Text+' WHERE servicetype=''C'' AND at_ft_desc <> ''blackberry.net (up)''';
  qReportJSM.Open;
end;

procedure TReportFieldDetailsForm.BitBtn2Click(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Ќомера собеседников';
  try
    ExportDBGridToExcel(ACaption,'',
      grData, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

 //проверка существовани€ таблиц в заданном интервале дат
function TReportFieldDetailsForm.checkAllTables(call:string):boolean;
begin
 try
  qAllTables.Close;
  qAllTables.ParamByName('CALL').AsString:=call;
  qAllTables.Open;
  checkAllTables:=(qAllTables.RecordCount > 0);
 finally
   qAllTables.Close;
 end;
end;
procedure TReportFieldDetailsForm.BitBtn3Click(Sender: TObject);
var
y,yy,m,mm,d,dd:word;
  I: Word;
  inc_date:TDateTime;
begin
  if (eCalling_no.Text = '') then begin
    MessageDlg('Ќе задан номер собеседника!', mtError, [mbOK], 0);
    exit;
  end;
  if (eBeginDate.Text = '  .  .    ') then begin
    MessageDlg('Ќе задана начальна€ дата поиска!', mtError, [mbOK], 0);
    exit;
  end;
  if (eEndDate.Text = '  .  .    ') then begin
    MessageDlg('Ќе задана конечна€ дата поиска!', mtError, [mbOK], 0);
    exit;
  end;
  if StrToDate(eBeginDate.Text) > StrToDate(eEndDate.Text) then begin
    MessageDlg('Ќачальна€ дата больше конечной!', mtError, [mbOK], 0);
    exit;
  end;
  qSearch.Close;
  DecodeDate(StrToDate(eBeginDate.Text),y,m,d);
  DecodeDate(StrToDate(eEndDate.Text),yy,mm,dd);

  if (m = mm) and (y = yy)  then begin
    if not checkAllTables('CALL_'+FormatFloat('00',m)+'_'+IntToStr(y)) then begin
      MessageDlg('ќтсутствует таблица детализации дл€ заданного временного интервала!', mtError, [mbOK], 0);
      exit;
    end;
    qSearch.SQL.Text:='SELECT DISTINCT subscr_no, CASE WHEN phone_number_federal IS NOT NULL THEN ''+'' ELSE ''-'' END exists_contract'+
                      ' FROM call_'+FormatFloat('00',m)+'_'+IntToStr(y)+
                      ' , (SELECT distinct phone_number_federal FROM contracts)'+
                      ' WHERE servicetype=''C'' AND calling_no <> subscr_no AND subscr_no = phone_number_federal(+)'+
                      '  AND at_ft_desc <> ''blackberry.net (up)'''+
                      '  AND calling_no = :CALLING_NO AND start_time BETWEEN :BEGIN_DATE AND :END_DATE';
  end
  else begin
    if not checkAllTables('CALL_'+FormatFloat('00',m)+'_'+IntToStr(y)) then begin
      MessageDlg('ќтсутствует таблица детализации дл€ заданного временного интервала!', mtError, [mbOK], 0);
      exit;
    end;
    qSearch.SQL.Text:='SELECT DISTINCT subscr_no, CASE WHEN phone_number_federal IS NOT NULL THEN ''+'' ELSE ''-'' END exists_contract'+
                      ' FROM ('+
                      ' SELECT subscr_no'+
                      ' FROM call_'+FormatFloat('00',m)+'_'+IntToStr(y)+
                      ' WHERE servicetype=''C'' AND calling_no <> subscr_no AND at_ft_desc <> ''blackberry.net (up)'''+
                      '  AND calling_no = :CALLING_NO AND start_time >= :BEGIN_DATE ';
    inc_date:=incmonth(StrToDate(eBeginDate.Text));
    DecodeDate(inc_date,y,m,d);
    while (m <> mm) or (y <> yy) do begin
      if not checkAllTables('CALL_'+FormatFloat('00',m)+'_'+IntToStr(y)) then begin
        MessageDlg('ќтсутствует таблица детализации дл€ заданного временного интервала!', mtError, [mbOK], 0);
        exit;
      end;
      qSearch.SQL.Text:=qSearch.SQL.Text+' UNION ALL '+
                      'SELECT subscr_no'+
                      ' FROM call_'+FormatFloat('00',m)+'_'+IntToStr(y)+
                      ' WHERE servicetype=''C'' AND calling_no <> subscr_no AND at_ft_desc <> ''blackberry.net (up)'''+
                      '  AND calling_no = :CALLING_NO';
      inc_date:=incmonth(inc_date);
      DecodeDate(inc_date,y,m,d);
    end;
    if not checkAllTables('CALL_'+FormatFloat('00',mm)+'_'+IntToStr(yy)) then begin
      MessageDlg('ќтсутствует таблица детализации дл€ заданного временного интервала!', mtError, [mbOK], 0);
      exit;
    end;
    qSearch.SQL.Text:=qSearch.SQL.Text+' UNION ALL '+
                      'SELECT subscr_no'+
                      ' FROM call_'+FormatFloat('00',mm)+'_'+IntToStr(yy)+
                      ' WHERE servicetype=''C'' AND calling_no <> subscr_no AND at_ft_desc <> ''blackberry.net (up)'''+
                      ' AND calling_no = :CALLING_NO AND start_time <= :END_DATE '+
                      '), (SELECT distinct phone_number_federal FROM contracts)'+
                      ' WHERE subscr_no = phone_number_federal(+)';
  end;
  qSearch.Prepare;
  qSearch.ParamByName('CALLING_NO').AsString:=eCalling_no.Text;
  qSearch.ParamByName('BEGIN_DATE').AsDate:=StrToDate(eBeginDate.Text);
  qSearch.ParamByName('END_DATE').AsDate:=StrToDate(eEndDate.Text);
  qSearch.Open;
end;

procedure TReportFieldDetailsForm.btInfoAbonentClick(Sender: TObject);
begin
  if qSearch.Active and (qSearch.RecordCount > 0) then
    if qSearch.FieldByName('exists_contract').AsString = '+' then
      ShowUserStatByPhoneNumber(qSearch.FieldByName('subscr_no').AsString, 0);
end;

end.
