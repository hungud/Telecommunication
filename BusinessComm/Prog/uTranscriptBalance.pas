unit uTranscriptBalance;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, ExportGridToExcelPDF,
  uDM, ChildFrm, Func_Const, TimedMsgBox,    DbUtilsEh,   DBGridEhFindDlgs,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, System.StrUtils, System.DateUtils,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar,
  Vcl.CategoryButtons, Vcl.ButtonGroup, sLabel, Vcl.CheckLst, sListBox,
  sCheckListBox, sGroupBox, DBGridEhGrouping, GridsEh, DBGridEh, PropFilerEh,
  sEdit, sSpeedButton, PropStorageEh, sComboBox, Vcl.DBCtrls, Vcl.Mask,
  DBCtrlsEh;

const
  сSTART_BALANCE_LAST_TYPE = 2;  //-- тип баланса:  последний за период


type
  TTranscriptBalanceFrm = class(TChildForm)
    sPanel1: TsPanel;
    qRef: TOraQuery;
    dsqRef: TOraDataSource;
    DBGridEh1: TDBGridEh;
    qRefID_BALANCE_VIRT_ACOUNTS: TFloatField;
    qRefPHONE_ON_ACCOUNTS_ID: TFloatField;
    qRefPAYMENT_ID: TFloatField;
    qRefBILL_ID: TFloatField;
    qRefYEAR_MONTH: TFloatField;
    qRefDATE_BALANCE: TDateTimeField;
    qRefSUM_BALANCE: TFloatField;
    qRefSUM_PAY: TFloatField;
    qRefBILL_SUM: TFloatField;
    qRefID_START_BAL: TFloatField;
    qRefUSER_CREATED_FIO: TStringField;
    qRefDATE_CREATED_: TDateTimeField;
    qRefUSER_LAST_UPDATED_FIO: TStringField;
    qRefDATE_LAST_UPDATED_: TDateTimeField;
    qRefCnt: TOraQuery;
    qRefCntCNT: TFloatField;
    qMonthBalance: TOraQuery;
    dsMonthBalance: TOraDataSource;
    qMonthBalanceYEAR_MONTH_NAME: TStringField;
    qMonthBalanceYEAR_MONTH: TFloatField;
    qMonthBalanceDATE_BALANCE: TDateTimeField;
    qMonthBalanceSUM_BALANCE: TFloatField;
    DBGridEh2: TDBGridEh;
    sLabel5: TsLabel;
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
    aInfo: TAction;
    aCheckedAll: TAction;
    aUncheckedAll: TAction;
    aCheckedSel: TAction;
    aTranscriptBalance: TAction;
    pButtonMove: TsPanel;
    sbFirst: TsSpeedButton;
    sbMovePrior: TsSpeedButton;
    sbPrior: TsSpeedButton;
    sbNext: TsSpeedButton;
    sbMoveNext: TsSpeedButton;
    sbLast: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    sSpeedButton6: TsSpeedButton;
    sSpeedButton7: TsSpeedButton;
    Bevel2: TBevel;
    qtmp: TOraQuery;
    qtmp2: TOraQuery;
    FloatField12: TFloatField;
    qRefPHONE_ID: TStringField;
    spCalc_Balance: TOraStoredProc;
    spDeleteRef: TOraStoredProc;
    sSpeedButton8: TsSpeedButton;
    aInsertAuto: TAction;
    spCalcBal: TOraStoredProc;
    qRefVIRTUAL_ACCOUNTS_ID: TFloatField;
    qRefBALANCE_TYPE_NAME: TStringField;
    qRefBALANCE_TYPE_ID: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure qRefBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure qRefCntBeforeOpen(DataSet: TDataSet);
    procedure qRefAfterScroll(DataSet: TDataSet);
    procedure qMonthBalanceBeforeOpen(DataSet: TDataSet);
    procedure DBGridEh2Columns0EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure qMonthBalanceAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure qRefAfterOpen(DataSet: TDataSet);
    procedure aNextExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aDeleteExecute(Sender: TObject);
    procedure aFindExecute(Sender: TObject);
    procedure aFiltrExecute(Sender: TObject);
    procedure aToExcelExecute(Sender: TObject);
    procedure DBGridEh1Columns4EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure DBGridEh1Columns5EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure DBGridEh1ApplyFilter(Sender: TObject);
    procedure clearColFtr;
    procedure aInsertAutoExecute(Sender: TObject);

  private
    ColFtr : TColomnFiltr_Array;
    myCapt: string;
    FieldNameStr: TFLst;
    AllLoaded, AddExcelColNumber: Boolean;
  public
    YearMonth, VirtualAccountsId : Integer;
    VirtualAccountName : string;
    { Public declarations }
  end;

var
  TranscriptBalanceFrm: TTranscriptBalanceFrm;

implementation

{$R *.dfm}

uses uInsBalanceVirt;

procedure TTranscriptBalanceFrm.aDeleteExecute(Sender: TObject);
begin
  inherited;
   spDeleteRef.ParamByName('P_ID_BALANCE_VIRT_ACOUNTS').AsInteger :=  qRef.FieldByName('ID_START_BAL').AsInteger;
   spDeleteRef.ExecProc;
   qRef.Refresh;
   DBGridEh1.Columns[3].Footer.Value :=
     FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
   qMonthBalance.RefreshRecord;
end;

procedure TTranscriptBalanceFrm.aEditExecute(Sender: TObject);
var
  spf : TChildForm;
  id, mr : Integer;
  DATE_BALANCE : TDate;
  SUM_BALANCE : Currency;
begin
  inherited;
  spf := TInsBalanceVirtFrm.Create(self, spf, 'Редактирование начального баланса', true); //, self
  TInsBalanceVirtFrm(spf).inserting := false;
  TInsBalanceVirtFrm(spf).DateBalance := qRef.FieldByName('DATE_BALANCE').AsDateTime;
  TInsBalanceVirtFrm(spf).deDateBalance.Date := TInsBalanceVirtFrm(spf).DateBalance;
  TInsBalanceVirtFrm(spf).SumBalance := qRef.FieldByName('SUM_BALANCE').AsCurrency;
  TInsBalanceVirtFrm(spf).sCurrencyEdit.Value := TInsBalanceVirtFrm(spf).SumBalance;
  try
    mr := spf.ShowModal;
    if (mr = mrOk) then
    begin
      DATE_BALANCE := TInsBalanceVirtFrm(spf).deDateBalance.Date;
      SUM_BALANCE := TInsBalanceVirtFrm(spf).sCurrencyEdit.Value;
      id := qRef.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
      spCalc_Balance.ParamByName('P_VIRTUAL_ACCOUNTS_ID').AsInteger := id;
      spCalc_Balance.ParamByName('P_SUM_BALANCE').AsCurrency   := SUM_BALANCE;
      spCalc_Balance.ParamByName('P_DATE_BALANCE').AsDateTime := DATE_BALANCE;
      spCalc_Balance.ExecProc;
      qRef.Refresh;
      DBGridEh1.Columns[3].Footer.Value :=
        FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
      qMonthBalance.RefreshRecord;
  //    qRef.Locate('VIRTUAL_ACCOUNTS_ID',id,[]);
      //aRefresh.Execute;
    end;
  finally
    spf.Free;
  end;
end;

procedure TTranscriptBalanceFrm.aFiltrExecute(Sender: TObject);
begin
  inherited;

  DBGridEh1.STFilter.Visible := aFiltr.Checked;
end;

procedure TTranscriptBalanceFrm.aFindExecute(Sender: TObject);
begin
  inherited;
  ExecuteDBGridEhFindDialogProc(DBGridEh1,'','',nil,DBGridEh1.IsFindDialogShowAsModal);
end;

procedure TTranscriptBalanceFrm.aFirstExecute(Sender: TObject);
begin
  inherited;
  qRef.First;
end;

procedure TTranscriptBalanceFrm.aInsertAutoExecute(Sender: TObject);
begin
  inherited;
 // if aDelete.Enabled then
 // begin
 //   spDeleteRef.ParamByName('P_ID_BALANCE_VIRT_ACOUNTS').AsInteger :=  qRef.FieldByName('ID_START_BAL').AsInteger;
 //   spDeleteRef.ExecProc;
 // end;
  spCalcBal.ParamByName('P_VIRTUAL_ACCOUNTS_ID').AsInteger := VirtualAccountsId;
  spCalcBal.ParamByName('P_YEAR_MONTH').AsInteger := qMonthBalance.FieldByName('YEAR_MONTH').AsInteger;
  spCalcBal.ExecProc;
  qRef.Refresh;
  DBGridEh1.Columns[3].Footer.Value :=
    FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
  qMonthBalance.Refresh;
end;

procedure TTranscriptBalanceFrm.aInsertExecute(Sender: TObject);
var
  spf : TChildForm;
  mr : Integer;
  DATE_BALANCE : TDate;
  SUM_BALANCE : Currency;
  year,month,day : Word;
begin
  inherited;
  spf := TInsBalanceVirtFrm.Create(self, spf, 'Добавление начального баланса', true); //, self
  TInsBalanceVirtFrm(spf).inserting := True;

  if qRef.IsEmpty then
  begin
    DecodeDate(now,year,month,day);
  end
  else
  begin
    year := StrToInt(Copy(qRef.FieldByName('YEAR_MONTH').AsString,1,4));
    month := StrToInt(Copy(qRef.FieldByName('YEAR_MONTH').AsString,5,2));
  end;

  TInsBalanceVirtFrm(spf).DateBalance := EncodeDate(year,month,1); //StartOfTheDay(now);
  TInsBalanceVirtFrm(spf).deDateBalance.Date := TInsBalanceVirtFrm(spf).DateBalance;
  TInsBalanceVirtFrm(spf).SumBalance := 0;

  try
    mr := spf.ShowModal;
    if (mr = mrOk) then
    begin
      DATE_BALANCE := TInsBalanceVirtFrm(spf).deDateBalance.Date;
      SUM_BALANCE := TInsBalanceVirtFrm(spf).sCurrencyEdit.Value;

      spCalc_Balance.ParamByName('P_VIRTUAL_ACCOUNTS_ID').AsInteger := VirtualAccountsId;
      spCalc_Balance.ParamByName('P_SUM_BALANCE').AsCurrency := SUM_BALANCE;
      spCalc_Balance.ParamByName('P_DATE_BALANCE').AsDateTime := DATE_BALANCE;
      spCalc_Balance.ExecProc;
      qRef.Refresh;
      DBGridEh1.Columns[3].Footer.Value :=
        FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
      qMonthBalance.RefreshRecord;
      //qRef.Locate('VIRTUAL_ACCOUNTS_ID',id,[]);
      //aRefresh.Execute;
    end;
  finally
    spf.Free;
  end;
end;

procedure TTranscriptBalanceFrm.aLastExecute(Sender: TObject);
begin
  inherited;
  qRef.Last;
end;

procedure TTranscriptBalanceFrm.aMoveNextExecute(Sender: TObject);
begin
  inherited;
  qRef.MoveBy(dm.MoveNext)
end;

procedure TTranscriptBalanceFrm.aMovePrevExecute(Sender: TObject);
begin
  inherited;
  qRef.MoveBy(-dm.MoveNext);
end;

procedure TTranscriptBalanceFrm.aNextExecute(Sender: TObject);
begin
  inherited;
  qRef.Next;
end;

procedure TTranscriptBalanceFrm.aPrevExecute(Sender: TObject);
begin
  inherited;
  qRef.Prior;
end;

procedure TTranscriptBalanceFrm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  qRef.Refresh;
end;

procedure TTranscriptBalanceFrm.aToExcelExecute(Sender: TObject);
var
  Name_File_Excel, Zagolovok_Excel : string;
begin
  inherited;
  qRef.DisableControls;
  aToExcel.Checked := True;
  Name_File_Excel := GET_EXCEL_FILE_NAME('Баланс по счету ' + VirtualAccountName + ' за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring);
  Zagolovok_Excel := 'Баланс по счету ' + VirtualAccountName + ' за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;
  ExportOraQuery2(Zagolovok_Excel, '', Name_File_Excel, qRef, FieldNameStr, Dm.AskExcelFileName, True, AddExcelColNumber);
  aToExcel.Checked := false;
  qRef.EnableControls;
end;


procedure TTranscriptBalanceFrm.clearColFtr;
var
  i,r: Integer;
begin
  r := Length(ColFtr);
  for i := 0 to r-1 do
  begin
     ColFtr[i].FieldFiltrValue := '';
   end;
end;

procedure TTranscriptBalanceFrm.DBGridEh1ApplyFilter(Sender: TObject);
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
    qRef.SQL.Add( ' and ' + st);
  //qRef.SQL.Add('   order by bva.BALANCE_TYPE_ID desc, bva.ID_BALANCE_VIRT_ACOUNTS asc ');
  qRef.SQL.Add('   order by bva.DATE_BALANCE desc');
  qRefCnt.Close;
  qRefCnt.SQL := qtmp2.SQL;
  if st <> '' then
    qRefCnt.SQL.Add( ' and ' + st);
 // qRefCnt.SQL.Add(' order by  CONTRACT_NUM desc');
  qRefCnt.Open;
  qRef.Open;
  qRef.First;

  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if DBGridEh1.Columns[i].Visible then
      DBGridEh1.Columns[i].STFilter.ExpressionStr := ColFtr[i].FieldFiltrValue;
  end;
end;

procedure TTranscriptBalanceFrm.DBGridEh1Columns4EditButtons0Click(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
  TimedMessageBox('Просмотр платежа','', mtInformation, [mbOK], mbOK, 15, 3);
end;

procedure TTranscriptBalanceFrm.DBGridEh1Columns5EditButtons0Click(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
   TimedMessageBox('Просмотр квитанции - счета','', mtInformation, [mbOK], mbOK, 15, 3);

end;

procedure TTranscriptBalanceFrm.DBGridEh2CellClick(Column: TColumnEh);
begin
  inherited;
    YearMonth := qMonthBalance.FieldByName('YEAR_MONTH').AsInteger;
    qRef.DisableControls;
    qRef.Close;
    qRefCnt.Close;
    qRef.open;
    DBGridEh1.Columns[3].Footer.Value :=
      FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
    qRefCnt.open;
    qRef.EnableControls;
    DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
    sLabel5.Caption := 'Баланс за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;
end;

procedure TTranscriptBalanceFrm.DBGridEh2Columns0EditButtons0Click(
  Sender: TObject; var Handled: Boolean);
  var
  mr : integer;
begin
  inherited;
  mr := TimedMessageBox('Показать расшифровку баланса за период - ' + qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring + '?', 'Внимание!',  mtConfirmation, [mbYes, mbNo], mbYes, 15, 3);
  if (mr = mrYes )then
  begin
    YearMonth := qMonthBalance.FieldByName('YEAR_MONTH').AsInteger;
    qRef.Close;
    qRefCnt.Close;
    qRef.open;
    qRefCnt.open;
    DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
    sLabel5.Caption := 'Баланс за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;
  end;
end;

procedure TTranscriptBalanceFrm.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
    YearMonth := qMonthBalance.FieldByName('YEAR_MONTH').AsInteger;
    qRef.DisableControls;
    qRef.Close;
    qRefCnt.Close;
    qRef.open;
    DBGridEh1.Columns[3].Footer.Value :=
      FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);

    qRefCnt.open;
    qRef.EnableControls;
    DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
    sLabel5.Caption := 'Баланс за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;
end;

procedure TTranscriptBalanceFrm.FormCreate(Sender: TObject);
var
  r, k, i : Integer;
  st : string;
begin
  inherited;
  r := 0;
  myCapt := Caption;
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
        SetLength(ColFtr, Length(ColFtr) + 1);
        ColFtr[i].FieldName := DBGridEh1.Columns[i].FieldName;
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
          DBGridEh1.Columns[i].Width := k;

    end;
  end;
  myCapt := Caption;
  AddExcelColNumber := True;
  Dm.applMainForm.OnKeyDown := FormKeyDown;
end;

procedure TTranscriptBalanceFrm.FormDestroy(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  SetLength(ColFtr, 0);
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, myCapt, DBGridEh1.Columns[i].FieldName,IntToStr(DBGridEh1.Columns[i].Width));
  end;

end;

procedure TTranscriptBalanceFrm.FormShow(Sender: TObject);
begin
  inherited;
   qMonthBalance.Open;
   qMonthBalance.first;
   YearMonth := qMonthBalance.FieldByName('YEAR_MONTH').AsInteger;
   sLabel5.Caption := 'Баланс за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;
    qRef.DisableControls;
    qRef.open;
    DBGridEh1.Columns[3].Footer.Value :=
      FloatToStrF(StrToFloat(VarToStrDef(qRef.Lookup('BALANCE_TYPE_ID', сSTART_BALANCE_LAST_TYPE, 'SUM_BALANCE'),'0')), ffFixed, 15,2);
    qRefCnt.open;
    qRef.EnableControls;
    DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
    sLabel5.Caption := 'Баланс за период  ' +  qMonthBalance.FieldByName('YEAR_MONTH_NAME').Asstring;

   DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
end;

procedure TTranscriptBalanceFrm.qMonthBalanceAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //qMonthBalance.Locate('YEAR_MONTH',YearMonth,[]);
end;

procedure TTranscriptBalanceFrm.qMonthBalanceBeforeOpen(DataSet: TDataSet);
begin
  inherited;
    qMonthBalance.ParamByName('VIRTUAL_ACCOUNTS_ID').AsInteger := VirtualAccountsId;
end;

procedure TTranscriptBalanceFrm.qRefAfterOpen(DataSet: TDataSet);
begin
  inherited;
  aInsert.Enabled := false;
  aEdit.Enabled := false;
  aDelete.Enabled := True;
  aRefresh.Enabled := True;
  aFind.Enabled := True;
  aFiltr.Enabled := True;
  aNext.Enabled := True;
  aPrev.Enabled := True;
  aFirst.Enabled := True;
  aLast.Enabled := True;
  aMoveNext.Enabled := True;
  aMovePrev.Enabled := True;
  aToExcel.Enabled := True;
  sSpeedButton4.Enabled := True;
  aTranscriptBalance.Enabled := True;
  DBGridEh1.SetFocus;
  AllLoaded := True;
  qRef.First;

end;

procedure TTranscriptBalanceFrm.qRefAfterScroll(DataSet: TDataSet);
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
    aInsert.Enabled := (qRef.FieldByName('ID_START_BAL').AsInteger = 0);
    aEdit.Enabled :=   (qRef.FieldByName('ID_START_BAL').AsInteger > 0);
    aDelete.Enabled  := aEdit.Enabled;

        //aInsert.Enabled := (qRef.FieldByName('ID_START_BAL').AsInteger = 0);
    //aEdit.Enabled :=   (qRef.FieldByName('ID_START_BAL').AsInteger > 0);
    //aDelete.Enabled  := aEdit.Enabled;

  end;
  DBGridEh1.Columns[0].Footer.Value := 'Запись № ' + IntToStr(qRef.RecNo) + ' из ' + qRefCnt.FieldByName('cnt').AsString;
end;

procedure TTranscriptBalanceFrm.qRefBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qRef.ParamByName('YEAR_MONTH').AsInteger := YearMonth;
  qRef.ParamByName('Virtual_accounts_id').AsInteger := VirtualAccountsId;
end;

procedure TTranscriptBalanceFrm.qRefCntBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qRefCnt.ParamByName('YEAR_MONTH').AsInteger := YearMonth;
  qRefCnt.ParamByName('Virtual_accounts_id').AsInteger := VirtualAccountsId;

end;

end.

