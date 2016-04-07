unit RefCopyDatabase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, Ora, ActnList, Menus, DB, MemDS, Grids, DBGrids, CRGrid,
  ExtCtrls, ComCtrls, ToolWin, ContractsRegistration_Utils, StdCtrls, ShowUserStat,
  Vcl.Samples.Gauges, IntecExportGrid;

type
  TRefCopyDataBaseForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    Panel2: TPanel;
    Splitter1: TSplitter;
    CRDBGrid1: TCRDBGrid;
    Panel3: TPanel;
    dgCompareBalRes: TCRDBGrid;
    qMain: TOraQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    Panel4: TPanel;
    spAllTurnOnOff: TOraStoredProc;
    spCopySchema: TOraStoredProc;
    bCompareBalance: TButton;
    qCompareBalance: TOraQuery;
    DataSource2: TDataSource;
    cbAllRecords: TCheckBox;
    qCompareBalancePHONE_NUMBER: TStringField;
    qCompareBalanceID_DATABASE: TFloatField;
    qCompareBalanceSOURCE_BALANCE: TFloatField;
    qCompareBalanceDEST_BALANCE: TFloatField;
    qCompareBalanceDATEBALANCE: TDateTimeField;
    qMainID_DATABASE: TFloatField;
    qMainSCHEMA_NAME: TStringField;
    qMainDATE_CREATED: TDateTimeField;
    qMainCOMMENT_SCHEMA: TStringField;
    qMainUSER_CREATED: TStringField;
    qMainCNT: TFloatField;
    qMainCNT1: TFloatField;
    qExecuteJobCompare: TOraQuery;
    spDropUser: TOraStoredProc;
    ToolButton10: TToolButton;
    aShowUserStatInfo: TAction;
    qCompareBalanceDIFFR: TFloatField;
    StatusBar1: TStatusBar;
    Gauge1: TGauge;
    Timer1: TTimer;
    ToolButton11: TToolButton;
    aExcel: TAction;
    procedure FormCreate(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure bCompareBalanceClick(Sender: TObject);
    procedure cbAllRecordsClick(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure dgCompareBalResDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure SHOW_ProgressBar;
  end;

var
  RefCopyDataBaseForm: TRefCopyDataBaseForm;
  record_count : integer;

implementation

uses Main;

{$R *.dfm}

procedure TRefCopyDataBaseForm.aDeleteExecute(Sender: TObject);
begin
 //qDropUser.
 if qmain.Active and (qmain.RecordCount > 0) then begin
   try
     spDropUser.ParamByName('SCHEMA_NAME').AsString:=qMain.FieldByName('SCHEMA_NAME').AsString;
     spDropUser.ExecSQL;
   except
      on e : exception do
       ShowMessage('Ошибка удаления схемы: '+e.Message);
   end;
   aRefresh.Execute;
 end;
end;

procedure TRefCopyDataBaseForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
    v_bm: Variant;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  v_bm := DataSource2.DataSet.Bookmark ;
  DataSource2.DataSet.DisableControls;
  try
    ExportDBGridToExcel('Сравнение балансов в схеме ' +CRDBGrid1.SelectedField.AsString + ' .','',dgCompareBalRes, False, True);
  finally
    Screen.Cursor := cr;
    DataSource2.DataSet.Bookmark := v_bm;
    DataSource2.DataSet.EnableControls;
  end;
end;

procedure TRefCopyDataBaseForm.aInsertExecute(Sender: TObject);
 var
  SchemaName:string;
begin
 SchemaName:=mainform.OraSession.Schema+'_COPY';
 if InputQuery('Введите имени схемы','Введите имя новой схемы', SchemaName) then
 begin
   spCopySchema.ParamByName('SOURCE_SCHEME').AsString:=mainform.OraSession.Schema;
   spCopySchema.ParamByName('DEST_SCHEME').AsString:=SchemaName;
   try
    spCopySchema.ExecProc;
   except
      on e : exception do
       ShowMessage('Ошибка создания схемы: '+e.Message);
   end;
   qMain.Active:=false;
   qMain.Active:=true;
 end;

end;

procedure TRefCopyDataBaseForm.aRefreshExecute(Sender: TObject);
begin
(* qCompareBalance.Active:=false;
 qCompareBalance.ParamByName('ID_DATABASE').AsString:=qMain.FieldByName('ID_DATABASE').AsString;
 qCompareBalance.Execute;*/
*)
 qMain.Active:=false;
 qCompareBalance.Active:=false;

 if cbAllRecords.Checked then
  qCompareBalance.ParamByName('ALL_RECORDS').AsInteger:=1
 else
  qCompareBalance.ParamByName('ALL_RECORDS').AsInteger:=0;
 qMain.Active:=true;
 qCompareBalance.Active:=true;


end;

procedure TRefCopyDataBaseForm.aShowUserStatInfoExecute(Sender: TObject);
begin
 if qCompareBalance.Active and (qCompareBalance.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qCompareBalance.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TRefCopyDataBaseForm.bCompareBalanceClick(Sender: TObject);
var SqlOra : TOraQuery;
begin

if GetConstantValue('SERVER_NAME')='SIM_TRADE' then   begin
 qExecuteJobCompare.Active:=false;
 qExecuteJobCompare.SQL.Text:='begin DBMS_SCHEDULER.RUN_JOB(''J_CS'+qMain.FieldByName('SCHEMA_NAME').AsString+''',false); end;';
 try
  qExecuteJobCompare.ExecSQL;
 except
    on e : exception do
     ShowMessage('Ошибка запуска задания. Скорее всего задание уже запущено. ' +e.Message);
 end;
// 'begin DBMS_SCHEDULER.RUN_JOB(''J_CS'',false); end;'
{  }
end;

if   (GetConstantValue('SERVER_NAME')='CORP_MOBILE') or
    (GetConstantValue('SERVER_NAME')='GSM_CORP')  then  begin

SqlOra:=TOraQuery.Create(nil);
with SqlOra do
        begin
        Close;
        sql.Clear;
        sql.add('select count(*) as count_jobs from dba_jobs a ');
        sql.add(' where lower(a.WHAT) like ''%temp_compare_balance('+qMain.FieldByName('ID_DATABASE').AsString+'%'' ');
        Execute;
     end;

//если есть запущенные джобы - то говорим, что есть уже запущенные процессы - и надо подождать.
if sqlOra.FieldByName('count_jobs').AsInteger<>0 then  begin
   MessageDlg('Процесс на схеме '+qMain.FieldByName('SCHEMA_NAME').AsString+' уже запущен! Необходимо дождаться окончания процесса!', mtError, [mbOK], 0);
    SHOW_ProgressBar;
    exit;
      end;

with SqlOra do
        begin
        Close;
        sql.Clear;
        sql.add('begin delete from BALANCE_COMPARE_RESULT where id_database='+qMain.FieldByName('ID_DATABASE').AsString+'; commit; end;' );
        Execute;

     end;

with SqlOra do
        begin
                  try
                   Close;
                   sql.Clear;
                   sql.Text:=' begin TEMP_JCOMPARE_BALANCE('+qMain.FieldByName('ID_DATABASE').AsString+'); end;' ;
                   Execute;
                  except
                      on e : exception do
                      MessageDlg('Ошибка выполнения TEMP_JCOMPARE_BALANCE', mtError, [mbOK], 0);
                  end;
            end;

        SHOW_ProgressBar;
    end;
 {qExecuteJobCompare.Active:=false;
 qExecuteJobCompare.SQL.Text:='begin DBMS_SCHEDULER.RUN_JOB(''J_CS'+qMain.FieldByName('SCHEMA_NAME').AsString+''',false); end;';
 try
  qExecuteJobCompare.ExecSQL;
 except
    on e : exception do
     ShowMessage('Ошибка запуска задания. Скорее всего задание уже запущено. ' +e.Message);
 end;  }
// 'begin DBMS_SCHEDULER.RUN_JOB(''J_CS'',false); end;'
{  }
end;

procedure TRefCopyDataBaseForm.cbAllRecordsClick(Sender: TObject);
begin
 aRefresh.Execute;
end;

procedure TRefCopyDataBaseForm.dgCompareBalResDblClick(Sender: TObject);
begin
 aShowUserStatInfo.Execute;
end;

procedure TRefCopyDataBaseForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRefCopyDataBaseForm.FormCreate(Sender: TObject);
begin
  inherited;
  aRefresh.Execute;
  CRDBGrid1.SelectedIndex := 1;
end;

procedure TRefCopyDataBaseForm.Timer1Timer(Sender: TObject);
var SqlOra : TOraQuery;
   plusPG1 : integer;
   sql_text : string;
begin
SqlOra:=TOraQuery.Create(nil);
with SqlOra do
        begin
        Close;
        sql.Clear;
        sql.add(' select count(*) ncount from BALANCE_COMPARE_RESULT where id_database='+qMain.FieldByName('ID_DATABASE').AsString+'' );
        sql.add(' having count(*)<>0');
        Execute;
        plusPG1:=sqlOra.FieldByName('ncount').AsInteger;
        StatusBar1.SimpleText:='Обработано записей '+inttostr(plusPG1)+' из '+inttostr(Gauge1.MaxValue);
        Gauge1.Progress:= plusPG1;
        close;
        end;

        If (Gauge1.Progress=Gauge1.MaxValue) Then
    begin

    Timer1.Enabled:=False;
   // Gauge1.Progress:=0;
    end;

end;

procedure TRefCopyDataBaseForm.SHOW_ProgressBar;
var SqlOra : TOraQuery;
    Rep_Progress : Boolean;

begin
 SqlOra:=TOraQuery.Create(nil);
  with SqlOra do
        begin
   Close;
        sql.Clear;
        sql.add('SELECT count(*) as record_count from temp_compare_phone where id_database='+qMain.FieldByName('ID_DATABASE').AsString);
        Execute;
        record_count:=sqlOra.FieldByName('record_count').AsInteger;
        Gauge1.MaxValue:=record_count;
        end;

        if Timer1.Enabled=false then
        Timer1.Enabled:=true; //запуск таймера

end;

end.
