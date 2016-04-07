unit RefContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, ExportGridToExcelPDF,
  uDM, ChildFrm, Func_Const, TimedMsgBox, DbUtilsEh,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, System.StrUtils,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar,
  Vcl.CategoryButtons, Vcl.ButtonGroup, sLabel, Vcl.CheckLst, sListBox,
  sCheckListBox, sGroupBox, DBGridEhGrouping, GridsEh, DBGridEh;

type
  TRefContractForm = class(TChildForm)
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N6: TMenuItem;
    actlst1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
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
    TlBr: TsToolBar;
    btnInsert: TToolButton;
    btnEdit: TToolButton;
    btnDelete: TToolButton;
    btn4: TToolButton;
    btnRefresh: TToolButton;
    btnFiltr: TToolButton;
    btnExcel: TToolButton;
    btn1: TToolButton;
    btnFirst: TToolButton;
    btnMovePrev: TToolButton;
    btnPrev: TToolButton;
    btnNext: TToolButton;
    btnMoveNext: TToolButton;
    btnLast: TToolButton;
    pmFiltr: TPopupMenu;
    miF1: TMenuItem;
    miF2: TMenuItem;
    qRef: TOraQuery;
    dsqRef: TOraDataSource;
    qRefCONTRACT_ID: TFloatField;
    qRefCONTRACT_NUM: TFloatField;
    qRefCONTRACT_DATE: TDateTimeField;
    qRefPHONE_NUMBER_TYPE: TFloatField;
    qRefVIRTUAL_ACCOUNTS_NAME: TStringField;
    qRefPHONE_NUMBER: TStringField;
    qRefREGION: TStringField;
    qRefPHONE_FOR_VIEW: TStringField;
    qRefFILIAL_NAME: TStringField;
    qRefTARIFF_NAME: TStringField;
    qRefFIO: TStringField;
    qRefSIM_NUMBER: TStringField;
    qRefSALE_COST: TFloatField;
    qRefSALE_DATE: TDateTimeField;
    qRefCONTRACT_DISCOUNT: TFloatField;
    qRefAGENT_DATE_DISPATCH: TDateTimeField;
    qRefAGENT_NAME: TStringField;
    qRefEMAIL: TStringField;
    qRefPHONE_NUMBER_1: TStringField;
    qRefPHONE_NUMBER_2: TStringField;
    qRefPHONE_NUMBER_3: TStringField;
    qRefPHONE_NUMBER_4: TStringField;
    qRefADDRESS: TStringField;
    qRefOPERATOR_PHONE_STATUSE_NAME: TStringField;
    qRefLOCAL_PHONE_STATUSE_NAME: TStringField;
    qRefOPERATOR_ACCOUNT_NAME: TStringField;
    qRefPROJECT_NAME: TStringField;
    qRefSUB_ACCOUNT_NUMBER: TStringField;
    qRefUSER_CREATED_FIO: TStringField;
    qRefDATE_CREATED_: TDateTimeField;
    qRefUSER_LAST_UPDATED_FIO: TStringField;
    qRefDATE_LAST_UPDATED_: TDateTimeField;
    qRefPAYABLE: TStringField;
    ToolButton2: TToolButton;
    miF3: TMenuItem;
    qtmp: TOraQuery;
    aF1: TAction;
    aF3: TAction;
    aF2: TAction;
    DBGridEh1: TDBGridEh;
    qRefCnt: TOraQuery;
    qRefCntCNT: TFloatField;
    qtmp2: TOraQuery;
    FloatField1: TFloatField;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    aShowGroup: TAction;
    procedure FormCreate(Sender: TObject);
    procedure qRefAfterScroll(DataSet: TDataSet);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aNextExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aToExcelExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetEditingData(aValue: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure clearColFtr;

    procedure Loaded; override;
    procedure aFiltrExecute(Sender: TObject);
    procedure aFindExecute(Sender: TObject);
    procedure CreateEditForm(Id: Integer);
    procedure ToolButton2Click(Sender: TObject);
    procedure LoadFiltr;
    procedure aF1Execute(Sender: TObject);
    procedure aF3Execute(Sender: TObject);
    procedure aF2Execute(Sender: TObject);
    procedure DBGridEh1ApplyFilter(Sender: TObject);
    procedure qRefCntAfterOpen(DataSet: TDataSet);
    procedure aShowGroupExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);

    private
     fEditingData, AllLoaded, AddExcelColNumber: Boolean; //ExistEditFields,
     FieldNameStr: TFLst;
     FiltrS, myCapt: string;
    // EditingFields : Integer;
     ColFtr : TColomnFiltr_Array;
    public
     { Public declarations }
    published
      property EditingData : Boolean read fEditingData write SetEditingData;
  end;

var
  RefContractForm: TRefContractForm;

implementation

{$R *.dfm}

uses RefEditContract, FiltrForContract;
  //RefVirtual_Operators, RefPhonesOnAccount, RefTariffs, RefFilial, RefAbonents,
  //RefOperatorPhoneStatuses, RefLocal_Phone_Statuses, RefOperatorAccountNames,
  //RefProjects, RefSubAgent, RefAgent,

procedure TRefContractForm.SetEditingData(aValue: Boolean);
begin
  fEditingData := aValue;
end;


procedure TRefContractForm.ToolButton2Click(Sender: TObject);
begin
  inherited;
  if miF3.Enabled  then
    miF3.Click
  else
    miF1.Click;
end;

procedure TRefContractForm.aDeleteExecute(Sender: TObject);
begin
  if TimedMessageBox('Вы действительно хотите удалить эту запись ?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3) = mrYes then
  begin
    try
      qRef.ReadOnly := False;
      qRef.Delete;
    finally
      qRef.ReadOnly := true;
    end;
  end;
end;

procedure TRefContractForm.aF1Execute(Sender: TObject);
var
  frm : TFiltrForContractFrm;
  //spf : TChildForm;
  cnt : Integer;
  txt,old_filtr : string;
begin
 // CRGrid.ClearFilters;
 // spf := TFiltrForContractFrm.Create(nil, spf, 'Настройка нового фильтра', true);
 // frm := TFiltrForContractFrm(spf);
  frm := TFiltrForContractFrm.Create(nil, TChildForm(frm), 'Настройка нового фильтра', true);;
  frm.new_filtr := true;
  try
    if frm.ShowModal = mrOk then
    begin
      cnt := 0;
      txt := '';
      cnt := cnt + StrToIntDef(frm.SaleDateChk, 0) +
                               frm.id_Region_count +
                               frm.id_Project_count +
                               frm.id_Tariffs_count +
                               frm.id_Status_count;

      if frm.id_Region_count > 0 then
        txt := frm.slRegion.Caption;

      if frm.id_Project_count > 0 then
      begin
        if txt <> '' then
          txt := txt + ', ' + frm.slProject.Caption
        else
          txt := frm.slProject.Caption;
      end;

      if frm.id_Tariffs_count > 0  then
      begin
        if txt <> '' then
          txt := txt + ', ' + frm.slTariffs.Caption
        else
          txt := frm.slTariffs.Caption;
      end;

      if frm.id_Status_count > 0  then
      begin
        if txt <> '' then
          txt := txt + ', ' + frm.slStatus.Caption
        else
          txt := frm.slStatus.Caption;
      end;

      if txt <> '' then
          txt := txt + ', ' + frm.slDate.Caption
      else
          txt := frm.slDate.Caption;

      ToolButton2.Hint := 'Текущий фильтр - ' + txt;
      aF3.Hint := 'Текущий фильтр - ' + txt;
      miF3.Hint := 'Текущий фильтр - ' + txt;

      miF3.Enabled := (cnt > 0);
      miF2.Enabled := miF3.Enabled;

      old_filtr := FiltrS;
      LoadFiltr;
      if old_filtr <> FiltrS then
      begin
        qRef.Close;
        qRef.SQL := qtmp.SQL;
        qRef.SQL.Add(FiltrS);
        qRef.SQL.Add(' order by  CONTRACT_NUM desc');
        qRef.Open;
        qRef.First;
      end;

    end;
  finally
    FreeAndNil(frm);
   // FreeAndNil(spf);

  end;
end;

procedure TRefContractForm.aF2Execute(Sender: TObject);
begin
  inherited;
 WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs_count', IntToStr(0));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs', '');

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status_count', IntToStr(0));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status', '');

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project_count', IntToStr(0));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project', '');

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region_count', IntToStr(0));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region', '');

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk', '0');
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate', '');

  aF3.Enabled := False;
  aF2.Enabled := aF3.Enabled;

  qRef.Filtered := False;
  ToolButton2.Hint := 'Фильтр не установлен';
  aF3.Hint := 'Фильтр не установлен';
  miF3.Hint := 'Фильтр не установлен';
  FiltrS := '';
  begin
    qRef.Close;
    qRef.SQL := qtmp.SQL;
    qRef.SQL.Add(FiltrS);
    qRef.SQL.Add(' order by  CONTRACT_NUM desc');
    qRef.Open;
    qRef.First;
  end;

end;

procedure TRefContractForm.aF3Execute(Sender: TObject);
var
  spf : TChildForm;
  //spf : TFiltrForContractFrm;
  cnt : Integer;
  txt, old_filtr : string;
begin
 // CRGrid.ClearFilters;
  spf := TFiltrForContractFrm.Create(nil, spf, 'Настройка существующего фильтра', true);
  TFiltrForContractFrm(spf).new_filtr := False;
  try
    if spf.ShowModal = mrOk then
    begin
      cnt := 0;
      cnt := cnt + StrToIntDef(TFiltrForContractFrm(spf).SaleDateChk, 0) +
                   TFiltrForContractFrm(spf).id_Region_count +
                   TFiltrForContractFrm(spf).id_Project_count +
                   TFiltrForContractFrm(spf).id_Tariffs_count +
                   TFiltrForContractFrm(spf).id_Status_count;
      miF3.Enabled := (cnt > 0);
      miF2.Enabled := miF3.Enabled;
      old_filtr := FiltrS;
      LoadFiltr;

      if TFiltrForContractFrm(spf).id_Region_count > 0 then
        txt := TFiltrForContractFrm(spf).slRegion.Caption;

      if TFiltrForContractFrm(spf).id_Project_count > 0 then
      begin
        if txt <> '' then
          txt := txt + ', ' + TFiltrForContractFrm(spf).slProject.Caption
        else
          txt := TFiltrForContractFrm(spf).slProject.Caption;
      end;

      if TFiltrForContractFrm(spf).id_Tariffs_count > 0  then
      begin
        if txt <> '' then
          txt := txt + ', ' + TFiltrForContractFrm(spf).slTariffs.Caption
        else
          txt := TFiltrForContractFrm(spf).slTariffs.Caption;
      end;

      if TFiltrForContractFrm(spf).id_Status_count > 0  then
      begin
        if txt <> '' then
          txt := txt + ', ' + TFiltrForContractFrm(spf).slStatus.Caption
        else
          txt := TFiltrForContractFrm(spf).slStatus.Caption;
      end;

      if txt <> '' then
          txt := txt + ', ' + TFiltrForContractFrm(spf).slDate.Caption
      else
          txt := TFiltrForContractFrm(spf).slDate.Caption;

      ToolButton2.Hint := 'Текущий фильтр - ' + txt;
      aF3.Hint := 'Текущий фильтр - ' + txt;
      miF3.Hint := 'Текущий фильтр - ' + txt;
      //if old_filtr <> FiltrS then
      begin
        qRef.Close;
        qRef.SQL := qtmp.SQL;
        qRef.SQL.Add(FiltrS);
        qRef.SQL.Add(' order by  CONTRACT_NUM desc');
        qRef.Open;
        qRef.First;
      end;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefContractForm.aFiltrExecute(Sender: TObject);
begin
  inherited;
  if aFiltr.checked then
  begin
    DBGridEh1.STFilter.Visible := True;
  end
  else
  begin
    DBGridEh1.STFilter.Visible := false;
  end;
 end;

procedure TRefContractForm.aFindExecute(Sender: TObject);
begin
  inherited;
  if aFind.checked then
  begin
//    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeSearchBar];
//    if ((dsqRef.State = dsEdit) or (dsqRef.State = dsInsert)) then
//      qRef.Cancel;
  end
  else
  begin
 //   CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeSearchBar];
  end;
end;

procedure TRefContractForm.aFirstExecute(Sender: TObject);
begin
  qRef.First;
end;

procedure TRefContractForm.aInsertExecute(Sender: TObject);
begin
  inherited;
 CreateEditForm(-1);
end;

procedure TRefContractForm.aEditExecute(Sender: TObject);
begin
  inherited;
 CreateEditForm(qRef.FieldByName('CONTRACT_ID').AsInteger);
end;

procedure TRefContractForm.CreateEditForm(Id: Integer);
var
  spf : TChildForm;
begin
  spf := TRefEditContractForm.Create(nil, spf, 'Договора', true);
  TRefEditContractForm(spf).CONTRACT_ID := Id;
  try
    if spf.ShowModal = mrOk then
    begin
      if Id = -1 then
      begin
        qRef.Refresh;
        qRef.Locate('CONTRACT_ID',TRefEditContractForm(spf).CONTRACT_ID,[]);
      end
      else
        qRef.RefreshRecord;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefContractForm.aLastExecute(Sender: TObject);
begin
 qRef.Last;
end;

procedure TRefContractForm.aMoveNextExecute(Sender: TObject);
begin
  qRef.MoveBy(dm.MoveNext);
end;

procedure TRefContractForm.aMovePrevExecute(Sender: TObject);
begin
  qRef.MoveBy(-dm.MoveNext);
end;

procedure TRefContractForm.aNextExecute(Sender: TObject);
begin
  qRef.Next;
end;

procedure TRefContractForm.aPrevExecute(Sender: TObject);
begin
  qRef.Prior;
end;

procedure TRefContractForm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  qRef.Refresh;
end;

procedure TRefContractForm.aShowGroupExecute(Sender: TObject);
begin
  inherited;
  if aShowGroup.checked then
  begin
    DBGridEh1.DataGrouping.GroupPanelVisible := True;
    DBGridEh1.DataGrouping.Active := True;
  end
  else
  begin
    DBGridEh1.DataGrouping.GroupPanelVisible := false;
    DBGridEh1.DataGrouping.Active := false;
  end;
end;

procedure TRefContractForm.aToExcelExecute(Sender: TObject);
var
  Name_File_Excel, Zagolovok_Excel : string;
begin
  inherited;
  aToExcel.Checked := True;
  Name_File_Excel := GET_EXCEL_FILE_NAME( 'Договора');
  Zagolovok_Excel := 'Список договоров';
  ExportOraQuery2(Zagolovok_Excel, '', Name_File_Excel, qRef, FieldNameStr, Dm.AskExcelFileName, True, AddExcelColNumber);
  aToExcel.Checked := false;
end;

procedure TRefContractForm.DBGridEh1ApplyFilter(Sender: TObject);
var
 fn, st, st1, st2, st3: string;
 i, int, int1 : Integer;

begin
  inherited;
  st := GetExpressionAsFilterString((Sender as TCustomDBGridEh ),GetOneExpressionAsSQLWhereString, nil, true );
  clearColFtr;
  for I := 0 to DBGridEh1.Columns.Count-1  do
  begin
    if DBGridEh1.Columns[i].Visible then
    begin
      fn := DBGridEh1.Columns[i].FieldName;
      //ColFtr[i].FieldName := fn;
      int := PosEx(fn, st);
      if int > 0  then
      begin
        int := PosEx('''', st, int);
        int1 := PosEx('''', st, int+2);
        st1 := Copy(st, 1, int-2);
        st2 := Copy(st, int, (int1 - int +2));
        ColFtr[i].FieldFiltrValue := Copy(st2,2,Length(st2)- 3) ;
        st3 := Copy(st, int1+2, (Length(st) - int1));
        if DBGridEh1.Columns[i].Field.DataType = ftString then
        begin
          st := st1 + ' UPPER(' + st2 + ')' + st3;
          st := AnsiReplaceStr(st, fn, 'UPPER('+fn+')');
        end;

        if (DBGridEh1.Columns[i].Field.DataType = ftDateTime) or (DBGridEh1.Columns[i].Field.DataType = ftDate) then
        begin
            if PosEx(':', st2) > 0 then
              st := st1 + ' TO_DATE( ' + st2 + ', ''DD.MM.YYYY HH24:MI:SS'')' + st3
            else
            begin
              st := st1 + ' TO_DATE( ' + st2 + ', ''DD.MM.YYYY'')' + st3;
              st := AnsiReplaceStr(st, fn, 'TRUNC('+fn+')');
            end;
        end;
      end;
    end;
  end;
  qRef.Close;
  qRef.SQL := qtmp.SQL;
  if st <> '' then
    qRef.SQL.Add( ' where ' + st);
  qRef.SQL.Add(' order by  CONTRACT_NUM desc');

  qRefCnt.Close;
  qRefCnt.SQL := qtmp2.SQL;
  if st <> '' then
    qRefCnt.SQL.Add( ' where ' + st);
  qRefCnt.SQL.Add(' order by  CONTRACT_NUM desc');
  qRefCnt.Open;
  qRef.Open;
  qRef.First;
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if DBGridEh1.Columns[i].Visible then
      DBGridEh1.Columns[i].STFilter.ExpressionStr := ColFtr[i].FieldFiltrValue;
  end;
end;

procedure TRefContractForm.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if not sPanel1.Visible then
    aEdit.Execute
  else
  begin
   if ((dsqRef.State = dsEdit) or (dsqRef.State = dsInsert)) then
      qRef.Cancel;
   sBsave.Click;
   end;

end;

procedure TRefContractForm.LoadFiltr;
var
  SaleDate, st  : string;
  id_Region_count, id_Project_count, id_Status_count, id_Tariffs_count, cnt : Integer;
begin
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate', SaleDate);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk', st);
    cnt := StrToIntDef(st, 0);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs_count', st);
    id_Tariffs_count := StrToIntDef(st, 0);
    cnt := cnt + id_Tariffs_count;
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status_count', st);
    id_Status_count := StrToIntDef(st, 0);
    cnt := cnt +  id_Status_count;
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project_count', st);
    id_Project_count := StrToIntDef(st, 0);
    cnt := cnt + id_Project_count;
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region_count', st);
    id_Region_count := StrToIntDef(st, 0);
    cnt := cnt + id_Region_count;
    FiltrS := '';
    if (cnt > 0) then
    begin
      aF3.Enabled := True;
      aF2.Enabled := True;
      if id_Tariffs_count >0 then
      begin
        ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs', st);
        if FiltrS = ''  then
          FiltrS := ' where ';
        if id_Tariffs_count > 1 then
          FiltrS := FiltrS + ' TARIFF_ID in (' + st + ') '
        else
          FiltrS := FiltrS + ' TARIFF_ID = ' + st;
      end;
      if id_Status_count > 0  then
      begin
        ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status', st);
        if FiltrS = ''  then
          FiltrS := ' where '
        else
          FiltrS := FiltrS +  #10 + ' and ';
        if id_Status_count > 1 then
          FiltrS := FiltrS + ' LOCAL_PHONE_STATUSE_ID in (' + st + ')'
        else
          FiltrS := FiltrS + ' LOCAL_PHONE_STATUSE_ID = ' + st;
      end;

      if id_Project_count > 0 then
      begin
        ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project', st);
        if FiltrS = ''  then
          FiltrS := ' where '
        else
          FiltrS := FiltrS +  #10 + ' and ';
        if id_Project_count > 1 then
          FiltrS := FiltrS + ' PROJECT_ID in (' + st + ')'
        else
          FiltrS := FiltrS + ' PROJECT_ID = ' + st;
      end;
      if id_Region_count > 0 then
      begin
        ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region', st);
        if FiltrS = ''  then
          FiltrS := ' where '
        else
          FiltrS := FiltrS +  #10 + ' and ';
        if id_Region_count > 1 then
          FiltrS := FiltrS + ' REGION in (''' + st + ''')  '
        else
          FiltrS := FiltrS + ' REGION = ''' + st +  '''';
      end;
      if SaleDate <> '' then
      begin
        if FiltrS = ''  then
          FiltrS := ' where '
        else
          FiltrS := FiltrS +  #10 + ' and ';
        FiltrS := FiltrS + SaleDate;
      end;
    end
    else
    begin
      aF3.Enabled := false;
      aF2.Enabled := false;
    end;
end;

procedure TRefContractForm.Loaded;
var
  st  : string;
begin
  inherited;
  /// процедура выполняется до события FormCreate
  /// если нижна доп. инициализвция чего - либо - писать здесь
  if FormStyle = fsMDIChild then
  begin
    ReadIniAny(Dm.FileNameIni, name, 'WindowState', st);
    if st = ''  then
      WindowState := wsNormal;
    if st = '1' then
      WindowState := wsNormal;
    if st = '3' then
      WindowState := wsMaximized;
    if st = '2' then
      WindowState := wsMinimized;

    ReadIniAny(Dm.FileNameIni, name, 'Left', st);
    self.Left := StrToIntDef(st, Left);

    ReadIniAny(Dm.FileNameIni, name, 'Top', st);
    self.Top := StrToIntDef(st, Top);

    ReadIniAny(Dm.FileNameIni, name, 'Height', st);
    self.Height := StrToIntDef(st, Height);

    ReadIniAny(Dm.FileNameIni, name, 'Width', st);
    self.Width := StrToIntDef(st, Width);
  end;
  LoadFiltr;
end;

procedure TRefContractForm.FormCreate(Sender: TObject);
var
 i,r,k : integer;
 st : string;
begin
  inherited;
  SetLength(ColFtr, 0);
  aMoveNext.Caption := Dm.MoveNextHint;
  aMoveNext.Hint := aMoveNext.Caption;
  aMovePrev.Caption := Dm.MovePrevHint;
  aMovePrev.Hint := aMovePrev.Caption;
  fEditingData := true;

  Dm.applMainForm.OnKeyDown := FormKeyDown;
  myCapt := Caption;
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption + ' - ' + Caption;
  if (FormStyle = fsNormal) and (BorderStyle <> bsNone) then
    sPanel1.Visible := True;
  AddExcelColNumber := True;
  SetLength(FieldNameStr,0);
  r := 0;
  for i := 0 to DBGridEh1.Columns.Count -1 do
  begin
    if DBGridEh1.Columns[i].FieldName = 'USER_CREATED_FIO' then
      DBGridEh1.Columns[i].Visible := Dm.ShowInfoCreator;
    if DBGridEh1.Columns[i].FieldName = 'DATE_CREATED_' then
      DBGridEh1.Columns[i].Visible := Dm.ShowInfoCreator;
    if DBGridEh1.Columns[i].FieldName = 'USER_LAST_UPDATED_FIO' then
      DBGridEh1.Columns[i].Visible := Dm.ShowInfoChanger;
    if DBGridEh1.Columns[i].FieldName = 'DATE_LAST_UPDATED_' then
      DBGridEh1.Columns[i].Visible := Dm.ShowInfoChanger;
    if DBGridEh1.Columns[i].Visible then
    begin
      if DBGridEh1.Columns[i].FieldName <> '' then
      begin
        SetLength(FieldNameStr, Length(FieldNameStr) + 1);
        FieldNameStr[r] := DBGridEh1.Columns[i].FieldName;
        r := r +1;
      end;
    end;
    ReadIniAny(Dm.FileNameIni, myCapt, DBGridEh1.Columns[i].FieldName, st);
    if (st <> '') then
    begin
        k := StrToIntDef(st, 0);
        if (k <> 0) then
        begin
          DBGridEh1.Columns[i].Width := k;
        end;
    end;
    SetLength(ColFtr, i + 1); // Length(aColumn_Array) + 1);
    ColFtr[i].FieldName := DBGridEh1.Columns[i].FieldName;
  end;

  AllLoaded := True;
  ToolButton2.Hint := 'Фильтр не установлен';
  miF3.Hint := 'Фильтр не установлен';
  qRef.Close;
  qRef.SQL := qtmp.SQL;
  qRef.SQL.Add(' order by  CONTRACT_NUM desc');
  qRef.Open;
  qRef.First;
  qRefCnt.Open;
end;


procedure TRefContractForm.clearColFtr;
var
  i,r: Integer;
begin
  r := Length(ColFtr);
  for i := 0 to r-1 do
  begin
     ColFtr[i].FieldFiltrValue := '';
   end;
end;

procedure TRefContractForm.FormDestroy(Sender: TObject);
var
  i: Integer;
  st : string;
begin
  inherited;
  SetLength(ColFtr, 0);
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, myCapt, DBGridEh1.Columns[i].FieldName,IntToStr(DBGridEh1.Columns[i].Width));
  end;
  if WindowState = wsNormal then
    st := '1';
  if  WindowState = wsMaximized then
    st := '3';
  if WindowState = wsMinimized then
    st := '2';

  WriteIniAny(Dm.FileNameIni, name, 'WindowState' ,st);
  WriteIniAny(Dm.FileNameIni, name, 'Left' ,IntToStr(left));
  WriteIniAny(Dm.FileNameIni, name, 'Top' ,IntToStr(Top));
  WriteIniAny(Dm.FileNameIni, name, 'Height' ,IntToStr(Height));
  WriteIniAny(Dm.FileNameIni, name, 'Width' ,IntToStr(Width));

  st := '';
  if (FormStyle = fsNormal) and (BorderStyle = bsNone) then
    Dm.applMainForm.Caption := Dm.MainCaption;
  Dm.applMainForm.OnKeyDown := nil;
  Dm.applMainForm.OnKeyPress := nil;
end;

procedure TRefContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_F5) and aRefresh.Enabled) then
    aRefresh.Execute;
   inherited;
end;

procedure TRefContractForm.qRefAfterScroll(DataSet: TDataSet);
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
  DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
end;

procedure TRefContractForm.qRefCntAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
end;

end.
