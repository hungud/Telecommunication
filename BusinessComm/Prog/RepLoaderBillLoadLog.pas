unit RepLoaderBillLoadLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Data.DB, DBAccess, Ora, MemDS,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls,
  sListBox, sCheckListBox, sComboBox, Vcl.ExtCtrls, sBevel, Vcl.Buttons,
  udm, Func_Const,  TimedMsgBox,  ShellAPI,
  sLabel, sPanel, Vcl.ComCtrls, sStatusBar, sSplitter, Vcl.DBCtrls,
  sSpeedButton, sBitBtn, sEdit, sGauge, sScrollBox;

type
  TRepLoaderBillLoadLogFrm = class(TRepFrm)
    qReportLOG_BILL_ID: TFloatField;
    qReportACCOUNT_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportFILE_NAME: TStringField;
    qReportERROR_LOAD: TStringField;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    qSQL_TEMP: TOraQuery;
    qReportDATA_EXIST: TStringField;
    qReportAccount_name: TStringField;
    qReportPeriod: TStringField;
    qReportDATA_EXIST_: TFloatField;
    aBlobToFile: TAction;
    qBlob: TOraQuery;
    qBlobFILE_BODY: TBlobField;
    aFileToBlob: TAction;
    qBlob2: TOraQuery;
    dsqBlob2: TOraDataSource;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    dblkcbbYEAR_MONTH: TDBLookupComboBox;
    dsqMonthYearforRepFrm: TOraDataSource;
    sLabel3: TsLabel;
    qAccount2: TOraQuery;
    dsqAccount2: TOraDataSource;
    dblkcbbACCOUNT_ID: TDBLookupComboBox;
    qAccount2ACCOUNT_ID: TFloatField;
    qAccount2NNMM: TStringField;
    sLabel4: TsLabel;
    qReportBILL_FILE_STATUS_ID: TFloatField;
    qBillFileStatuses: TOraQuery;
    dsqBillFileStatuses: TOraDataSource;
    qBillFileStatusesBILL_FILE_STATUS_ID: TFloatField;
    qBillFileStatusesSTATUS_NAME: TStringField;
    qReportNAME_STATUS: TStringField;
    qBlob2LOG_BILL_ID: TFloatField;
    qBlob2ACCOUNT_ID: TFloatField;
    qBlob2YEAR_MONTH: TFloatField;
    qBlob2FILE_NAME: TStringField;
    qBlob2ERROR_LOAD: TStringField;
    sBevel11: TsBevel;
    sBevel12: TsBevel;
    sBitBtn1: TsBitBtn;
    qReportCNT: TFloatField;
    qReportLENGTH_BL: TFloatField;
    sbBlobToFile: TsSpeedButton;
    sbFileToBlob: TsSpeedButton;
    sbDelete: TsSpeedButton;
    sBevel10: TsBevel;
    sBevel13: TsBevel;
    procedure FormCreate(Sender: TObject);
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure aBlobToFileExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aFileToBlobExecute(Sender: TObject);
    procedure sBsaveClick(Sender: TObject);
    procedure sBCloseClick(Sender: TObject);
    procedure dblkcbbYEAR_MONTHClick(Sender: TObject);
    procedure dblkcbbACCOUNT_IDClick(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
  private
  send_file_name : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RepLoaderBillLoadLogFrm: TRepLoaderBillLoadLogFrm;

implementation

{$R *.dfm}

uses ChildFrm, RefPeriods;

procedure TRepLoaderBillLoadLogFrm.aBlobToFileExecute(Sender: TObject);
begin
  inherited;
  dm.dlgSave.FileName := qReport.FieldByName('FILE_NAME').AsString;
  if dm.dlgSave.Execute then
  begin
    try
      qBlob.Close;
      qBlob.ParamByName('LOG_BILL_ID').AsInteger := qReport.FieldByName('LOG_BILL_ID').AsInteger;
      qBlob.Open;
      if qBlob.IsEmpty then
      begin
        TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
      end
      else
      begin
        SaveBlobFile('', dm.dlgSave.FileName, qBlob, qBlobFILE_BODY);
        ShellExecute(0, 'open', PCHAR(dm.dlgSave.FileName), nil, nil, SW_SHOWNORMAL);
      end;
    except
      TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
    end;
  end;
end;

procedure TRepLoaderBillLoadLogFrm.aDeleteExecute(Sender: TObject);
var
 txt : string;
begin
  inherited;
  if qReport.FieldByName('CNT').AsInteger > 0 then
    txt := 'По этому файлу получено ' + qReport.FieldByName('CNT').AsString + ' номеров. При удалении файла все эти номера из отчета удалятся! Выполнить удаление?'
  else
    txt := 'Вы действительно хотите удалить эту запись?';
  begin
    if (TimedMessageBox(txt, 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 25, 3) = mrYes) then
    begin
      Dm.spTemp.StoredProcName := 'DEL_DB_LOADER_BILL_LOAD_LOG';
      Dm.spTemp.Prepare;
      Dm.spTemp.ParamByName('p_LOG_BILL_ID').AsInteger := qReport.FieldByName('LOG_BILL_ID').AsInteger;
      Dm.spTemp.Execute;
      qReport.Refresh;
      aDelete.Enabled := not qReport.IsEmpty;
    end;
  end;
end;

procedure TRepLoaderBillLoadLogFrm.aFileToBlobExecute(Sender: TObject);
var
  Ext, Filter: string;
begin
  inherited;
  Ext := Dm.dlgOpen.DefaultExt;
  Filter := Dm.dlgOpen.Filter;
  Dm.dlgOpen.DefaultExt := '';
  Dm.dlgOpen.Filter := '';
    if Dm.dlgOpen.Execute then
    begin
      try
        send_file_name := Dm.dlgOpen.FileName;
        qAccount2.Open;
        qBlob2.Open;
        qBlob2.Insert;
      finally
        Dm.dlgOpen.DefaultExt := Ext;
        Dm.dlgOpen.Filter := Filter;
      end;
      sPanel4.Left := (Width div 2) - 244;
      sPanel4.Visible := True;
      sPanel4.Top :=  (Height div 2) - 65;
    end;
end;

procedure TRepLoaderBillLoadLogFrm.aRefreshExecute(Sender: TObject);
begin
  if (account_check_count = 0) then
  begin
    TimedMessageBox('Не выбрано ни одного лицевого счета!','Пожалуйста, будьте внимательны!',mtWarning,[mbOK],mbOK,5);
    exit;
  end;
  inherited;

  aBlobToFile.Enabled := qReport.Active and (not qReport.IsEmpty);
  if aBlobToFile.Enabled then
  begin
    if (qReport.FieldByName('DATA_EXIST_').AsInteger = 1) then
      aBlobToFile.Enabled := true
    else
      aBlobToFile.Enabled := false;
  end;
end;

procedure TRepLoaderBillLoadLogFrm.dblkcbbACCOUNT_IDClick(Sender: TObject);
begin
  inherited;
  sBsave.Enabled := (dblkcbbYEAR_MONTH.Text <> '') and (dblkcbbACCOUNT_ID.Text <> '');

end;

procedure TRepLoaderBillLoadLogFrm.dblkcbbYEAR_MONTHClick(Sender: TObject);
begin
  inherited;
  sBsave.Enabled := (dblkcbbYEAR_MONTH.Text <> '') and (dblkcbbACCOUNT_ID.Text <> '');
end;

procedure TRepLoaderBillLoadLogFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Name_File_Excel := Caption;
  Zagolovok_Excel := 'Журнал загрузки файлов счетов';
  cb_Mob_Oper := True;
  cb_Period   := True;
  aCheckedAll1.Execute;
  CLBAccounts := true;


//  aCheckedAll2.Execute;
  sbBlobToFile.Action := aBlobToFile;
  sbBlobToFile.ImageIndex := 24;
  sBevel2.Visible := True;
end;

procedure TRepLoaderBillLoadLogFrm.qReportAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (DataSet.FieldByName('DATA_EXIST_').AsInteger = 1) then
    aBlobToFile.Enabled := true
  else
    aBlobToFile.Enabled := false;
end;

procedure TRepLoaderBillLoadLogFrm.qReportBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qReport.SQL.Clear;
  qReport.SQL := qSQL_TEMP.SQL;
  qReport.SQL.Add(' and BLL.YEAR_MONTH = :YEAR_MONTH');
  if (account_check_count = 1) then
    qReport.SQL.Add(' and BLL.ACCOUNT_ID = :ACCOUNT_ID')
  else
    if not((account_check_count = account_count) or (account_check_count = CLB_Accounts.Count)) then
    begin
      if (account_check_count > 1000) then
        qReport.SQL.Add(' and exists (select 1 from T_ACCOUNTS t where t.ACCOUNT_ID = BLL.ACCOUNT_ID)')
      else
        qReport.SQL.Add(' and BLL.ACCOUNT_ID in (' + FAccid + ')');
    end;
  qReport.SQL.Add(' order by BLL.DATE_CREATED');
  if (account_check_count = 1) then
    qReport.ParamByName('ACCOUNT_ID').AsString :=  FAccid;
  qReport.ParamByName('YEAR_MONTH').AsInteger :=  YEAR_MONTH;
end;

procedure TRepLoaderBillLoadLogFrm.sBCloseClick(Sender: TObject);
begin
  inherited;
  qBlob2.Cancel;
  qBlob2.Close;
  sPanel4.Visible := False;
end;

procedure TRepLoaderBillLoadLogFrm.sBitBtn1Click(Sender: TObject);
 var
  spf : TChildForm;
begin
  spf := TRefPeriodsForm.Create(nil, spf, 'Рабочие периоды', true);
  try
    if spf.ShowModal = mrOk then
    begin
      qMonthYearforRepFrm.Refresh;
      qBlob2.FieldByName('YEAR_MONTH').AsInteger := TRefPeriodsForm(spf).qRef.fieldbyname('YEAR_MONTH').AsInteger;
    end;
  finally
    spf.Free;
  end;

end;

procedure TRepLoaderBillLoadLogFrm.sBsaveClick(Sender: TObject);
var
  OraStoredProc : TOraStoredProc;
begin
  inherited;
      OraStoredProc := TOraStoredProc.Create(self);
      OraStoredProc.Session := Dm.OraSession;
      OraStoredProc.StoredProcName := 'DOWNLOAD_FILE';
      OraStoredProc.PrepareSQL;  // receive parameters
      OraStoredProc.ParamByName('pFILE_NAME').AsString := ExtractFileName(send_file_name);
      OraStoredProc.ParamByName('paccount_id').Asinteger := qBlob2.FieldByName('ACCOUNT_ID').AsInteger;
      OraStoredProc.ParamByName('pyear_month').Asinteger := qBlob2.FieldByName('YEAR_MONTH').AsInteger;
      OraStoredProc.ParamByName('pFILE_BODY').ParamType := ptInput;  // to transfer Lob data to Oracle
      OraStoredProc.ParamByName('pFILE_BODY').AsOraBlob.LoadFromFile(send_file_name);
      OraStoredProc.Execute;
      OraStoredProc.Free;
    send_file_name := '';
  qBlob2.Close;
  qReport.Close;
  aCheckedAll1.Execute;
  aCheckedAll.Execute;
  aRefresh.Execute;
  sPanel4.Visible := False;
end;

end.
