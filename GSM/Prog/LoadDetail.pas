unit LoadDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, IntecExportGrid, ShowUserStat, ContractsRegistration_Utils,
  DAScript, OraScript;

type
  TLoadDetailForm = class(TForm)
    Panel1: TPanel;
    grData: TCRDBGrid;
    qBILLBLOB: TOraQuery;
    lAccount: TLabel;
    cbAccounts: TComboBox;
    Label1: TLabel;
    cbPeriod: TComboBox;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    BitBtn7: TBitBtn;
    OpenDialog1: TOpenDialog;
    dsBillBlob: TDataSource;
    qBILLBLOBFILENAME: TStringField;
    qBILLBLOBSMONTH: TStringField;
    qBILLBLOBSLOGIN: TStringField;
    qBILLBLOBSSTATE: TStringField;
    OraStoredProc1: TOraStoredProc;
    OraStoredProc2: TOraStoredProc;
    btRefresh: TBitBtn;
    BitBtn1: TBitBtn;
    OraStoredProc3: TOraStoredProc;
    procedure aExcelExecute(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoLoadDetail;

var
  LoadDetailForm: TLoadDetailForm;
  ReportFrm : TLoadDetailForm;

implementation

{$R *.dfm}
procedure RefreshQ;
begin
   // Период
   ReportFrm.cbPeriod.Clear;
   ReportFrm.cbAccounts.Clear;
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
   // if GetConstantValue('REPORTS_USE_ACCOUNT_THREADS')='1' then
    begin
      ReportFrm.lAccount.Show;
      ReportFrm.cbAccounts.Show;
      ReportFrm.qAccounts.Open;
      ReportFrm.cbAccounts.Items.AddObject('Все', Pointer(-1));
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.cbAccounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('PHONE').AsLargeInt)
          );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
      if ReportFrm.cbAccounts.Items.Count > 0 then
        ReportFrm.cbAccounts.ItemIndex := 0;
   //   if Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])<>0 then
    //    ReportFrm.qReports.ParamByName('PACCOUNT_ID').asInteger :=
  //        Integer(ReportFrm.cbAccounts.Items.objects[ReportFrm.cbAccounts.ItemIndex])
  //    else ReportFrm.qReports.ParamByName('PACCOUNT_ID').Clear;
    end;
end;

procedure DoLoadDetail;
var
    Sdvig,s:integer;
begin
  ReportFrm:=TLoadDetailForm.Create(Nil);
     // Период
     try
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      s:=ReportFrm.cbPeriod.Items.Add(ReportFrm.qPeriods.FieldByName('SMONTH').AsString
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
 //   if ReportFrm.cbPeriod.Items.Count > 0 then
  //    ReportFrm.cbPeriod.ItemIndex := 0;
      ReportFrm.qAccounts.Open;
      while not ReportFrm.qAccounts.EOF do
      begin
       s:=ReportFrm.cbAccounts.Items.Add(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString  );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
 //     if ReportFrm.cbAccounts.Items.Count > 0 then
  //      ReportFrm.cbAccounts.ItemIndex := 0;

       ReportFrm.qBillBlob.Open;



//  try
 //    RefreshQ;
    // Отчет
 //   ReportFrm.cbAccountsChange(ReportFrm.cbAccounts);
 //   ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
    ReportFrm.ShowModal;
  finally
   ReportFrm.Free;
  end;
end;

procedure TLoadDetailForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    //spSaveDetailJ.Execute;
    MessageDlg('Задание на выгрузку детализации добавлено.', mtInformation, [mbOk], 0);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TLoadDetailForm.aRefreshExecute(Sender: TObject);
begin
  RefreshQ;
end;

procedure TLoadDetailForm.BitBtn1Click(Sender: TObject);
begin
if qBILLBLOB.FieldByName('SSTATE').AsString='Ожидает обработки' then   begin
  with OraStoredProc3 do begin
    ParamByName('sf').AsString:= qBILLBLOB.FieldByName('FILENAME').AsString;
    ParamByName('sm').AsString:= qBILLBLOB.FieldByName('SMONTH').AsString;
    ParamByName('sl').AsString:= qBILLBLOB.FieldByName('SLOGIN').AsString;
    Execute;
  end;
 // qDelBB.Session.Commit;
  qBILLBLOB.Close;
  qBILLBLOB.Open;
end
else Showmessage('Данный файл удалить нельзя, он уже выгружается!');
end;

procedure TLoadDetailForm.BitBtn7Click(Sender: TObject);

begin

if (cbAccounts.ItemIndex >= 0) and (cbPeriod.ItemIndex >= 0) then   begin
if OpenDialog1.Execute then begin

        with OraStoredProc1 do begin
     //      StoredProcName := 'DOWNLOAD_BILL_BLOB';
       //    PrepareSQL;  // receive parameters
//          ParamByName('p_ID').AsInteger := 10;
          ParamByName('SFILENAME').AsString := ExtractFileName(OpenDialog1.FileName);
          ParamByName('SSLOGIN').AsString := cbAccounts.Items.Strings[cbAccounts.ItemIndex];
          ParamByName('SSMONTH').AsString := cbPeriod.Items.Strings[cbPeriod.ItemIndex];
          ParamByName('BDATA').ParamType := ptInput;  // to transfer Lob data to Oracle
          ParamByName('BDATA').AsOraBlob.LoadFromFile(OpenDialog1.FileName);
          Execute;
        end;
        with OraStoredProc2 do begin
          ParamByName('SFILENAME').AsString := ExtractFileName(OpenDialog1.FileName);
          ParamByName('SSLOGIN').AsString := cbAccounts.Items.Strings[cbAccounts.ItemIndex];
          ParamByName('SSMONTH').AsString := cbPeriod.Items.Strings[cbPeriod.ItemIndex];
          Execute;
        end;
        qBILLBLOB.Close;
        qBILLBLOB.Open;
    //    OraStoredProc1.Free;
end;
end
else ShowMessage('Для загрузки файла сначала выберите лицевой счет и месяц!');
end;

procedure TLoadDetailForm.btRefreshClick(Sender: TObject);
begin
 qBILLBLOB.Close;
 qBILLBLOB.Open;
end;

procedure TLoadDetailForm.cbAccountsChange(Sender: TObject);
var
  Account : int64;
  p:string;
begin
  if cbAccounts.ItemIndex >= 0 then
  p:=cbAccounts.Items.Strings[cbAccounts.ItemIndex]
  // Account := Int64(cbAccounts.Items.Strings[cbAccounts.ItemIndex])
  else p:='';
  if  p<>'' then
  begin
   OraStoredProc1.ParamByName('SSLOGIN').AsString := p;
   // aRefresh.Execute;
  end else
  begin
    OraStoredProc1.ParamByName('SSLOGIN').Clear;
   // aRefresh.Execute;
  end;
end;

procedure TLoadDetailForm.cbPeriodChange(Sender: TObject);
var  S:String;
begin
  if cbPeriod.ItemIndex >= 0 then
    s:=cbPeriod.Items.Strings[cbPeriod.ItemIndex]
    else s:='';
  if  s<>'' then
  begin
   OraStoredProc1.ParamByName('SSMONTH').AsString := s;
   // aRefresh.Execute;
  end else
  begin
    OraStoredProc1.ParamByName('SSMONTH').Clear;
   // aRefresh.Execute;
  end;
end;

end.
