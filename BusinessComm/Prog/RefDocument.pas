unit RefDocument;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uRepFrm, Data.DB, DBAccess, Ora, MemDS, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls,  ExportGridToExcelPDF,
  sListBox, sCheckListBox, sComboBox, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sBevel, sSpeedButton, sLabel, sPanel, Vcl.ComCtrls, sStatusBar, sSplitter,
  uDm, Func_Const, TimedMsgBox, ChildFrm, Vcl.DBCtrls, sEdit, sGauge,
  Vcl.ToolWin, sToolBar;

type
  TRefDocumentForm = class(TChildForm)
    TlBr: TsToolBar;
    btnInsert: TToolButton;
    actlst1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aPost: TAction;
    aCancel: TAction;
    aRefresh: TAction;
    aFind: TAction;
    aFiltr: TAction;
    aNext: TAction;
    aPrev: TAction;
    aFirst: TAction;
    aLast: TAction;
    aMoveNext: TAction;
    aMovePrev: TAction;
    aToExcel: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    CRGrid: TCRDBGrid;
    qReport: TOraQuery;
    dsqReport: TOraDataSource;
    tmp: TOraQuery;
    qReportACCOUNT_ID: TFloatField;
    qReportTARIFF_ID: TFloatField;
    qReportABONENT_ID: TFloatField;
    qReportFILIAL_ID: TFloatField;
    qReportMOBILE_OPERATOR_NAME_ID: TFloatField;
    qReportVIRTUAL_ACCOUNTS_ID: TFloatField;
    qReportMOBILE_OPERATOR_NAME: TStringField;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportLOGIN: TStringField;
    qReportACCOUNT_NUMBER_LOGIN: TStringField;
    qReportFILIAL_NAME: TStringField;
    qReportPHONE_ID: TFloatField;
    qReportPHONE_NUMBER_CITY: TStringField;
    qReportSURNAME: TStringField;
    qReportVIRTUAL_ACCOUNTS_NAME: TStringField;
    qReportTARIFF_NAME: TStringField;
    qReportCALL_LOCAL: TFloatField;
    qReportCALL_INTERCITY: TFloatField;
    qReportMESSAGE: TFloatField;
    qReportINTERNET: TFloatField;
    qReportOTHERS_SERVISES: TFloatField;
    qReportSUBSCRIPTION_SUM: TFloatField;
    qReportINTERNATIONAL_ROAMING: TFloatField;
    qReportNATIONAL_INTRANET_ROAMING: TFloatField;
    qReportADJUSTMENT: TFloatField;
    qReportPAYMENTS: TFloatField;
    qReportALL_CLIENT_SCHET: TFloatField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportLOG_BILL_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    qReportUSER_LAST_UPDATED_FIO: TStringField;
    qReportDATE_LAST_UPDATED_: TDateTimeField;
    qReportYEAR_MONTH_NAME: TStringField;
    qReportCONTRACT_ID: TFloatField;
    qReportSIM_NUMBER: TStringField;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure aFiltrExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qReportBeforeOpen(DataSet: TDataSet);
    procedure qReportAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aToExcelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aNextExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure MessageReceiverMoveNext(var Msg: TMessage); message WM_NOTIFY_GO_ON_THE;
    procedure qReportAfterScroll(DataSet: TDataSet);
  private
   YEAR_MONTH1, YEAR_MONTH2, FILIAL_ID : Integer;
   PHONE_ID : int64;
   VIRTUAL_ACCOUNTS_NAME : string;
   AddExcelColNumber: Boolean;
   Name_File_Excel, Zagolovok_Excel : string;
   FieldNameStr: TFLst;
   AllLoaded : Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefDocumentForm: TRefDocumentForm;

implementation

{$R *.dfm}

uses FindData;

procedure TRefDocumentForm.MessageReceiverMoveNext(var Msg: TMessage);
begin
  Msg.Result := 0;
end;

procedure TRefDocumentForm.aFiltrExecute(Sender: TObject);
var
  spf : TChildForm;
  st, sqlAdd : string;
begin
  inherited;
  aFiltr.Checked := True;
  spf := TFindDataForm.Create(nil, spf, 'Поиск документов', true);
  try
    if spf.ShowModal = mrOk then
    begin
      // прочитаем параметры
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'YEAR_MONTH1', st);
      YEAR_MONTH1 := StrToIntDef(st,0);
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'YEAR_MONTH2', st);
      YEAR_MONTH2 := StrToIntDef(st,0);
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'FILIAL_ID', st);
      FILIAL_ID := StrToIntDef(st,0);
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'PHONE_ID', st);
      PHONE_ID := StrToInt64Def(st,0);
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'VIRTUAL_ACCOUNTS_NAME', VIRTUAL_ACCOUNTS_NAME);
      ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'SRB', st);


      // добавим параметры


      sqlAdd := TFindDataForm(spf).addSQL;
      qReport.Close;
      qReport.SQL.Clear;
      qReport.SQL := tmp.sql;
      qReport.SQL.Add(sqlAdd);
      qReport.Open;
    end;
  finally
    spf.Free;
    aFiltr.Checked := false;
  end;

end;

procedure TRefDocumentForm.aFirstExecute(Sender: TObject);
begin
  inherited;
  qReport.First;
end;

procedure TRefDocumentForm.aLastExecute(Sender: TObject);
begin
  inherited;
   qReport.Last
end;

procedure TRefDocumentForm.aMoveNextExecute(Sender: TObject);
begin
  inherited;
   qReport.MoveBy(dm.MoveNext);
end;

procedure TRefDocumentForm.aMovePrevExecute(Sender: TObject);
begin
  inherited;
   qReport.MoveBy(-dm.MoveNext);
end;

procedure TRefDocumentForm.aNextExecute(Sender: TObject);
begin
  inherited;
  qReport.Next;
end;

procedure TRefDocumentForm.aPrevExecute(Sender: TObject);
begin
  inherited;
    qReport.Prior;
end;

procedure TRefDocumentForm.aToExcelExecute(Sender: TObject);
begin
  inherited;
  aToExcel.Checked := True;
  Name_File_Excel := GET_EXCEL_FILE_NAME( 'Основной отчет');
  Zagolovok_Excel := 'Список документов';
  if (Name_File_Excel = '') then
    TimedMessageBox('Не назазначен Name_File_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
  else
    if (Zagolovok_Excel = '') then
      TimedMessageBox('Не назазначен Zagolovok_Excel!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3)
    else
      if (qReport <> nil) then
        ExportOraQuery2(Zagolovok_Excel, '', Name_File_Excel, qReport, FieldNameStr, Dm.AskExcelFileName, True, AddExcelColNumber)

      else
        TimedMessageBox('Не назазначен GlQuery!', 'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
  aToExcel.Checked := false;
end;

procedure TRefDocumentForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
i : Integer;
begin
  inherited;
  for i := 0  to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', CRGrid.Columns[i].FieldName,
      IntToStr(CRGrid.Columns[i].Width));
  end;

end;

procedure TRefDocumentForm.FormCreate(Sender: TObject);
var
 st1, addSQL : string;
 i,r : Integer;
begin
  inherited;
  aMoveNext.Caption := Dm.MoveNextHint;
  aMoveNext.Hint := aMoveNext.Caption;
  aMovePrev.Caption := Dm.MovePrevHint;
  aMovePrev.Hint := aMovePrev.Caption;

  qReport.SQL.Clear;
  qReport.SQL := tmp.sql;
  st1 := FormatDateTime('yyyymm', date);
  addSQL := ' and dlb.YEAR_MONTH = :YEAR_MONTH1';
  qReport.SQL.Add(addSQL);
  aFiltr.Enabled := true;
  AddExcelColNumber := True;
  SetLength(FieldNameStr,0);
  if FormStyle = fsMDIChild then
  begin
    ReadIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Left', st1);
    Left := StrToIntDef(st1,0);
    ReadIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Top', st1);
    Top := StrToIntDef(st1,0);
    ReadIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Height', st1);
    Height := StrToIntDef(st1,365);
    ReadIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Width', st1);
    Width := StrToIntDef(st1,480);
   end;

  r := 0;
  for i := 0 to CRGrid.Columns.Count -1 do
  begin
    if CRGrid.Columns[i].FieldName = 'USER_CREATED_FIO' then
      CRGrid.Columns[i].Visible := Dm.ShowInfoCreator;
    if CRGrid.Columns[i].FieldName = 'DATE_CREATED_' then
      CRGrid.Columns[i].Visible := Dm.ShowInfoCreator;
    if CRGrid.Columns[i].FieldName = 'USER_LAST_UPDATED_FIO' then
      CRGrid.Columns[i].Visible := Dm.ShowInfoChanger;
    if CRGrid.Columns[i].FieldName = 'DATE_LAST_UPDATED_' then
      CRGrid.Columns[i].Visible := Dm.ShowInfoChanger;
    if CRGrid.Columns[i].Visible then
    begin
      if CRGrid.Columns[i].FieldName <> '' then
      begin
        SetLength(FieldNameStr, Length(FieldNameStr) + 1);
        FieldNameStr[r] := CRGrid.Columns[i].FieldName;
        r := r +1;
      end;
    end;
  end;

  YEAR_MONTH1 := Dm.month_year_withLastData;
    for i := 0 to CRGrid.Columns.Count - 1 do
    begin
      ReadIniAny(Dm.FileNameIni, 'RefDocumentForm', CRGrid.Columns[i].FieldName, st1);
      if (st1 <> '') then
      begin
        r := StrToIntDef(st1, 0);
        if (r <> 0) then
        begin
          CRGrid.Columns[i].Width := r;
        end;
      end;
    end;

  qReport.Open;
  AllLoaded := True;
  qReport.First;
end;

procedure TRefDocumentForm.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  SetLength(FieldNameStr, 0);
  for i := 0 to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', CRGrid.Columns[i].FieldName, IntToStr(CRGrid.Columns[i].Width));
  end;
  WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Left' ,IntToStr(left));
  WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Top' ,IntToStr(Top));
  WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Height' ,IntToStr(Height));
  WriteIniAny(Dm.FileNameIni, 'RefDocumentForm', 'Width' ,IntToStr(Width));


end;

procedure TRefDocumentForm.qReportAfterOpen(DataSet: TDataSet);
begin
  inherited;
  aToExcel.Enabled := not qReport.IsEmpty;
end;

procedure TRefDocumentForm.qReportAfterScroll(DataSet: TDataSet);
begin
  inherited;
 if AllLoaded then
  begin
    aNext.Enabled := not DataSet.Eof;
    aMoveNext.Enabled := not DataSet.Eof;
    aLast.Enabled := not DataSet.Eof;
    aPrev.Enabled := not DataSet.Bof;
    aMovePrev.Enabled := not DataSet.Bof;
    aFirst.Enabled := not DataSet.Bof;
  end;

end;

procedure TRefDocumentForm.qReportBeforeOpen(DataSet: TDataSet);
var
 i : Integer;
begin
  inherited;
  for i := 0 to qReport.ParamCount-1 do
  begin
    if UpperCase(qReport.Params[i].Name) = 'YEAR_MONTH1' then
      qReport.Params[i].AsInteger := YEAR_MONTH1;
    if UpperCase(qReport.Params[i].Name) = 'YEAR_MONTH2' then
      qReport.Params[i].AsInteger := YEAR_MONTH2;
    if UpperCase(qReport.Params[i].Name) = 'FILIAL_ID' then
      qReport.Params[i].AsInteger := FILIAL_ID;
    if UpperCase(qReport.Params[i].Name) = 'PHONE_ID' then
      qReport.Params[i].AsLargeInt := PHONE_ID;
    if UpperCase(qReport.Params[i].Name) = 'VIRTUAL_ACCOUNTS_NAME' then
      qReport.Params[i].Asstring := VIRTUAL_ACCOUNTS_NAME;
  end;
end;

end.
