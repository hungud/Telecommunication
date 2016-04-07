unit RefTariff_option;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, DMUnit, Func_Const, TimedMsgBox,
  Vcl.ToolWin, Vcl.ComCtrls, sToolBar, Data.DB, MemDS, DBAccess, Ora,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.DBCGrids,
  sLabel, sGroupBox, sBevel;

type
  TTariff_option = class(TChildForm)
    Ctrl_Options: TDBCtrlGrid;
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
    bvl1: TBevel;
    sLabel13: TsLabel;
    sLabel14: TsLabel;
    sBevel11: TsBevel;
    sBevel12: TsBevel;
    sLabel19: TsLabel;
    sBevel16: TsBevel;
    sLabel20: TsLabel;
    sBevel17: TsBevel;
    sLabel21: TsLabel;
    sBevel18: TsBevel;
    sLabel22: TsLabel;
    sLabel23: TsLabel;
    dbedtOPTION_CODE: TDBEdit;
    dbedtOPTION_NAME: TDBEdit;
    dbedtOPTION_NAME_FOR_AB: TDBEdit;
    dbedtKOEF_KOMISS_O: TDBEdit;
    dbedtDISCR_SPISANIE: TDBEdit;
    dbedtCALC_UNBLOCK_O: TDBEdit;
    bvl2: TBevel;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sLabel3: TsLabel;
    sBevel3: TsBevel;
    sLabel4: TsLabel;
    sBevel4: TsBevel;
    sLabel5: TsLabel;
    sBevel5: TsBevel;
    sLabel6: TsLabel;
    sLabel24: TsLabel;
    dbedtOPTION_CODE1: TDBEdit;
    dbedtOPTION_NAME1: TDBEdit;
    dbedtOPTION_NAME_FOR_AB1: TDBEdit;
    dbedtKOEF_KOMISS_O1: TDBEdit;
    dbedtDISCR_SPISANIE1: TDBEdit;
    dbedtCALC_UNBLOCK_O1: TDBEdit;
    bvl3: TBevel;
    sLabel7: TsLabel;
    sBevel8: TsBevel;
    sLabel10: TsLabel;
    sBevel9: TsBevel;
    sLabel11: TsLabel;
    sBevel10: TsBevel;
    sLabel12: TsLabel;
    sLabel25: TsLabel;
    dbedtTURN_ON_COST_o: TDBEdit;
    dbedtMONTHLY_COST_o: TDBEdit;
    dbedtOPERATOR_TURN_ON_COST: TDBEdit;
    dbedtOPERATOR_MONTHLY_COST: TDBEdit;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    sToolBar1: TsToolBar;
    btnInsert: TToolButton;
    btnEdit: TToolButton;
    btnDelete: TToolButton;
    btn1: TToolButton;
    btnPost: TToolButton;
    btnCancel: TToolButton;
    btn2: TToolButton;
    btnRefresh: TToolButton;
    btn3: TToolButton;
    btnFirst: TToolButton;
    btnMovePrev: TToolButton;
    btnPrev: TToolButton;
    btnNext: TToolButton;
    btnMoveNext: TToolButton;
    btnLast: TToolButton;
    procedure aRefreshExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ctrl_OptionsPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure dbedtOPTION_CODEMouseEnter(Sender: TObject);
    procedure SetGlQ(aValue: TOraQuery);
    procedure SetdsGlQ(aValue: TOraDataSource);
    procedure FormDestroy(Sender: TObject);
    procedure fGlQAfterScroll(DataSet: TDataSet);
    procedure fGlQBeforeOpen(DataSet: TDataSet);
    procedure fGlQBeforePost(DataSet: TDataSet);
    procedure fdsGlQStateChange(Sender: TObject);
    procedure fGlQAfterOpen(DataSet: TDataSet);
    procedure Setbuttons;
    procedure aNextExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure aCancelExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure SetFormMode(aValue: TFormMode); override;
    procedure aInsertExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure SetTarifCode(aValue: String);

  private
    AllLoaded: Boolean;
    fTarifCode : string;
  public
    fGlQ: TOraQuery;
    fdsGlQ: TOraDataSource;
  published
    property GlQuery: TOraQuery read fGlQ write SetGlQ;
    property dsGlQ: TOraDataSource read fdsGlQ write SetdsGlQ;
    property TarifCode : string read fTarifCode write SetTarifCode;
  end;

var
  Tariff_option: TTariff_option;

implementation

{$R *.dfm}

procedure TTariff_option.FormCreate(Sender: TObject);
begin
  inherited;
   GlQuery := Dm.qTarif_Option_New_Cost;
   GlQuery.Open;
   FormMode := fmBrowse;
   AllLoaded := True;
   GlQuery.First;
end;

procedure TTariff_option.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  GlQuery.close;
end;

procedure TTariff_option.FormDestroy(Sender: TObject);
begin
  inherited;
  fGlQ.AfterScroll := nil;
  fGlQ.BeforeOpen := nil;
  fGlQ.BeforePost := nil;
  fGlQ.AfterOpen := nil;
  fdsGlQ.OnStateChange := nil;
end;

Procedure TTariff_option.SetTarifCode(aValue: String);
begin
  inherited;
  pnl2.Caption := aValue;
end;

procedure TTariff_option.SetGlQ(aValue: TOraQuery);
var
  i: Integer;
begin
  fGlQ := aValue;
  fGlQ.Session := Dm.OraSession;
  fGlQ.AfterScroll := fGlQAfterScroll;
  fGlQ.BeforeOpen := fGlQBeforeOpen;
  fGlQ.BeforePost := fGlQBeforePost;
  fGlQ.AfterOpen := fGlQAfterOpen;
  fGlQ.Options.TemporaryLobUpdate := True;
  fGlQ.ReadOnly := True;
  for i := 0 to Dm.ComponentCount - 1 do
  begin
    if (Dm.Components[i].ClassName = 'TOraDataSource') or
      (Dm.Components[i].ClassName = 'TDataSource') then
    begin
      if ((Dm.Components[i] as TDataSource).DataSet = aValue) then
        dsGlQ := (Dm.Components[i] as TOraDataSource);
    end;
  end;
  if (dsGlQ = nil) then
    TimedMessageBox('К OraQuery - ' + fGlQ.Name + ' не установлен DATASOURCE!',
      'Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
end;

procedure TTariff_option.SetdsGlQ(aValue: TOraDataSource);
begin
  fdsGlQ := aValue;
  fdsGlQ.OnStateChange := fdsGlQStateChange;
  Ctrl_Options.DataSource := fdsGlQ;
end;

procedure TTariff_option.fGlQBeforeOpen(DataSet: TDataSet);
var
  i: Integer;
  ss: string;
begin
  inherited;
  if Dm.DebugMode then
  begin
    {
    ss := '';
    for i := 0 to DataSet.FieldCount -1  do
      if (DataSet.Fields[i].FieldName = (DataSet.Fields[i].DisplayLabel)) then
        ss := ss + DataSet.Fields[i].DisplayLabel + ', ';
    if ss <> '' then
    begin
      ss := Copy(ss, 1, Length(ss) - 2);
      TimedMessageBox('  У следующих полей не заполнены значения DisplayLabel '
        + ' - ' + #10 + #13 + ss, 'Внимание! Это видно только в дебаг режиме',
        mtWarning, [mbOK], mbOK, 15, 3);
    end;
    }
  end;
end;

procedure TTariff_option.fGlQBeforePost(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to fGlQ.FieldCount - 1 do
  begin
    if fGlQ.Fields[i].Required then
    begin
      if (fGlQ.Fields[i].DataType = ftSmallint) or (fGlQ.Fields[i].DataType = ftInteger) or (fGlQ.Fields[i].DataType = ftFloat) then
        if (fGlQ.Fields[i].IsNull) then
        begin
          TimedMessageBox('Ошибка' + ' - ' + 'значение' + ' ' + fGlQ.Fields[i].DisplayLabel + ' ' + 'не заполнено', 'Внимание!', mtError, [mbAbort], mbAbort, 15, 3);
          raise EAbort.Create('');
        end;
      if (fGlQ.Fields[i].DataType = ftString) then
        if (fGlQ.Fields[i].IsNull) or (Trim(fGlQ.Fields[i].Asstring) = '') then
        begin
          TimedMessageBox('Ошибка' + ' - ' + 'значение' + ' ' + fGlQ.Fields[i].DisplayLabel + ' ' + 'не заполнено', 'Внимание!', mtError, [mbAbort], mbAbort, 15, 3);
          raise EAbort.Create('');
        end;
    end;
  end;
  inherited;
end;

procedure TTariff_option.fGlQAfterOpen(DataSet: TDataSet);
begin
//
end;

procedure TTariff_option.fdsGlQStateChange(Sender: TObject);
begin
  if (fdsGlQ.State = dsBrowse) then
    FormMode := fmBrowse;
  if (fdsGlQ.State = dsInsert) then
    FormMode := fmInsert;
  if (fdsGlQ.State = dsEdit) then
    FormMode := fmEdit;
  if (fdsGlQ.State = dsInactive) then
    FormMode := fmInactive;
  if (fdsGlQ.State = dsOpening) then
    FormMode := fmInactive;
end;

procedure TTariff_option.fGlQAfterScroll(DataSet: TDataSet);
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

procedure TTariff_option.aCancelExecute(Sender: TObject);
begin
  inherited;
   fGlQ.Cancel;
  fGlQ.ReadOnly := True;
end;

procedure TTariff_option.aDeleteExecute(Sender: TObject);
begin
  inherited;
  if TimedMessageBox('Вы действительно хотите удалить эту запись ?', 'Пожалуйста, будьте внимательны!', mtConfirmation, [mbYes, mbNo], mbNo, 15, 3) = 6 then
  begin
    fGlQ.ReadOnly := False;
    fGlQ.Delete;
    fGlQ.ReadOnly := True;
  end;

end;

procedure TTariff_option.aEditExecute(Sender: TObject);
begin
  inherited;
  fGlQ.ReadOnly := False;
  fGlQ.Edit;
end;

procedure TTariff_option.aFirstExecute(Sender: TObject);
begin
  inherited;
  fGlQ.First;
end;

procedure TTariff_option.aInsertExecute(Sender: TObject);
begin
  inherited;
  fGlQ.ReadOnly := False;
  fGlQ.Insert;

end;

procedure TTariff_option.aLastExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Last;
end;

procedure TTariff_option.aMoveNextExecute(Sender: TObject);
begin
  inherited;
  fGlQ.MoveBy(50);
end;

procedure TTariff_option.aMovePrevExecute(Sender: TObject);
begin
  inherited;
    fGlQ.MoveBy(-50);
end;

procedure TTariff_option.aNextExecute(Sender: TObject);
begin
  inherited;
   fGlQ.Next;
end;

procedure TTariff_option.aPostExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Post;
  fGlQ.ReadOnly := True;
end;

procedure TTariff_option.aPrevExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Prior;
end;

procedure TTariff_option.aRefreshExecute(Sender: TObject);
begin
  inherited;
  fGlQ.Refresh;
end;

procedure TTariff_option.Ctrl_OptionsPaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
var
  r:TRect;
  dset : TDataSet;
begin
  dset := DBCtrlGrid.DataSource.DataSet;
  R := Self.ClientRect;
  if (not dset.FieldByName('TURN_ON_COST').IsNull) or
     (not dset.FieldByName('MONTHLY_COST').IsNull) or
     (not dset.FieldByName('MONTHLY_COST_FOR_BILLS').IsNull) or
     (not dset.FieldByName('TURN_ON_COST_FOR_BILLS').IsNull) then
    if DBCtrlGrid.PanelBorder = gbRaised then
      DBCtrlGrid.Canvas.Brush.Color := RGB(176,210,198)
    else
      DBCtrlGrid.Canvas.Brush.Color := RGB(176,232,198)
  else
    if odd(dset.RecNo) then
      DBCtrlGrid.Canvas.Brush.Color := RGB(237,218,255)
    else
      DBCtrlGrid.Canvas.Brush.Color := clBtnFace;
   sLabel13.Color := DBCtrlGrid.Canvas.Brush.Color;
   sLabel1.Color := DBCtrlGrid.Canvas.Brush.Color;
   sLabel7.Color := DBCtrlGrid.Canvas.Brush.Color;
  InflateRect(R, -2, -2);
  DBCtrlGrid.Canvas.FillRect(R);

end;

procedure TTariff_option.dbedtOPTION_CODEMouseEnter(Sender: TObject);
begin
  inherited;
 (Sender as TDBedit).Hint := (Sender as TDBedit).Text;
end;

procedure TTariff_option.SetFormMode(aValue: TFormMode);
begin
  inherited SetFormMode(aValue);
  if ((aValue = fmInsert) or (aValue = fmEdit)) then
    SendMessage(sndWind, WM_NOTIFY_CHGMODE, 0, DWORD(PChar('SetEdit')));
  if ((aValue = fmBrowse) or (aValue = fmInactive)) then
    SendMessage(sndWind, WM_NOTIFY_CHMODE, 0, DWORD(PChar('Setbrowse')));
  Setbuttons;
  //SetStatusBar;
end;

procedure TTariff_option.Setbuttons;
  procedure SetBrowseButtons;
  begin
    aPost.Enabled := False;
    aRefresh.Enabled := True;
    aCancel.Enabled := False;
    aInsert.Enabled := True;
    aDelete.Enabled := True;
    aEdit.Enabled := True;
    aFind.Enabled := True;
    aFiltr.Enabled := True;
    aNext.Enabled := True;
    aPrev.Enabled := True;
    aFirst.Enabled := True;
    aLast.Enabled := True;
    aMoveNext.Enabled := True;
    aMovePrev.Enabled := True;
    aToExcel.Enabled := True;
    Ctrl_Options.Enabled := True;
  end;

  procedure SetInsertButtons;
  begin
    aPost.Enabled := True;
    aRefresh.Enabled := False;
    aCancel.Enabled := True;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
  end;

  procedure SetEditButtons;
  begin
    aPost.Enabled := True;
    aRefresh.Enabled := False;
    aCancel.Enabled := True;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
  end;

  procedure SetInactiveButtons;
  begin
    aPost.Enabled := False;
    aRefresh.Enabled := False;
    aCancel.Enabled := False;
    aInsert.Enabled := False;
    aDelete.Enabled := False;
    aEdit.Enabled := False;
    aFind.Enabled := False;
    aFiltr.Enabled := False;
    aNext.Enabled := False;
    aPrev.Enabled := False;
    aFirst.Enabled := False;
    aLast.Enabled := False;
    aMoveNext.Enabled := False;
    aMovePrev.Enabled := False;
    aToExcel.Enabled := False;
    Ctrl_Options.Enabled := False;
  end;

begin
  case FormMode of
    fmBrowse:
      SetBrowseButtons;
    fmInsert:
      SetInsertButtons;
    fmEdit:
      SetEditButtons;
    fmInactive:
      SetInactiveButtons;
  end; { case }

end;

end.
