{
// #3321 Загрузка счетов в баланс кредитникам.
// Кочнев Е. v.2 Изменен способ отметки прогрузки счетов и внешний вид
}
unit RefAccountBillLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora,
  Buttons, ActnList, Mask, sMaskEdit, sCustomComboEdit, sTooledit, sComboBox,
  ChildFrm, DMUnit, Func_Const, TimedMsgBox, ExportGridToExcelPDF,
  sBitBtn, sBevel, sPanel, sSplitter, Vcl.DBCtrls, Vcl.DBCGrids, sListBox,
  sCheckListBox, sLabel;
type
  TFLst = Array of String;
type
  TRefAccountBillLoadForm = class(TChildForm)
    qRef: TOraQuery;
    dsRef: TDataSource;
    qPeriods: TOraQuery;
    qRefLOGIN: TStringField;
    qRefDATE_BEGIN: TDateTimeField;
    qRefDATE_END: TDateTimeField;
    qRefLOAD_BILL_IN_BALANCE: TFloatField;
    qRefDATE_CREDIT_END: TDateTimeField;
    qRefUSER_LAST_UPDATE: TStringField;
    qRefDATE_LAST_UPDATE: TDateTimeField;
    qAccNotBalance: TOraQuery;
    dsAccNotBalance: TDataSource;
    qAccNotBalanceLOGIN: TStringField;
    qAccNotBalanceYEAR_MONTH: TStringField;
    qSetupParamYearMonth: TOraQuery;
    qPeriodsYEAR_MONTH: TFloatField;
    qPeriodsYEAR_MONTH_NAME: TStringField;
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
    qRefLoadBillInBalance_: TBooleanField;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    crdbgrd1: TCRDBGrid;
    pnl4: TPanel;
    pnl5: TPanel;
    cbPeriod: TsComboBox;
    sPanel1: TsPanel;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sBitBtn2: TsBitBtn;
    sBitBtn3: TsBitBtn;
    sBitBtn4: TsBitBtn;
    sPanel2: TsPanel;
    sBevel3: TsBevel;
    sBitBtn1: TsBitBtn;
    sBitBtn5: TsBitBtn;
    sPanel3: TsPanel;
    sBevel4: TsBevel;
    sBitBtn6: TsBitBtn;
    sBitBtn7: TsBitBtn;
    pnl6: TPanel;
    cRGrid: TCRDBGrid;
    sSplitter1: TsSplitter;
    sPanel4: TsPanel;
    sBevel5: TsBevel;
    sBevel6: TsBevel;
    sBitBtn8: TsBitBtn;
    sBitBtn9: TsBitBtn;
    sBitBtn10: TsBitBtn;
    sBevel7: TsBevel;
    sBitBtn11: TsBitBtn;
    sBevel8: TsBevel;
    sBitBtn12: TsBitBtn;
    sBevel9: TsBevel;
    sBitBtn13: TsBitBtn;
    sPanel5: TsPanel;
    CLB_Accounts: TsCheckListBox;
    qRefACCOUNT_ID: TFloatField;
    qRefYEAR_MONTH: TFloatField;
    sPanel6: TsPanel;
    sDateEdit1: TsDateEdit;
    sBitBtn14: TsBitBtn;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sBitBtn15: TsBitBtn;
    sBitBtn16: TsBitBtn;
    sPanel7: TsPanel;
    dbedtLOGIN: TDBEdit;
    dbchkLoadBillInBalance_: TDBCheckBox;
    sBitBtn17: TsBitBtn;
    sBitBtn18: TsBitBtn;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sBevel10: TsBevel;
    sBevel11: TsBevel;
    sBevel12: TsBevel;
    sBevel13: TsBevel;
    sBevel14: TsBevel;
    sDateEdit2: TsDateEdit;
    sDateEdit3: TsDateEdit;
    sDateEdit4: TsDateEdit;
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure qRefLoadBillInBalance_GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure aToExcelExecute(Sender: TObject);
    procedure aFindExecute(Sender: TObject);
    procedure aFiltrExecute(Sender: TObject);
    procedure aNextExecute(Sender: TObject);
    procedure aPrevExecute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMoveNextExecute(Sender: TObject);
    procedure aMovePrevExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aCheckedAllExecute(Sender: TObject);
    procedure sBitBtn15Click(Sender: TObject);
    procedure sBitBtn16Click(Sender: TObject);
    procedure qRefBeforeOpen(DataSet: TDataSet);
    procedure sBitBtn17Click(Sender: TObject);
    procedure sBitBtn18Click(Sender: TObject);
  private
   FieldNameStr: TFLst;
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoRefAccountBillLoad;

var
  RefAccountBillLoadForm: TRefAccountBillLoadForm;

implementation

uses Main;

{$R *.dfm}

procedure DoRefAccountBillLoad;
var ReportFrm : TChildForm;
begin
  ReportFrm := TRefAccountBillLoadForm.Create(nil, ReportFrm, 'Загрузка счетов в баланс', True);
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TRefAccountBillLoadForm.aCheckedAllExecute(Sender: TObject);
var
  tt : TBookmark;
begin
  sDateEdit1.Date := Date;
  CLB_Accounts.Clear;
  tt := qRef.GetBookmark;
  qRef.DisableControls;
  qRef.First;
  while not qRef.EOF do
  begin
    CLB_Accounts.Items.AddObject(Trim(qRef.FieldByName('LOGIN').AsString), Pointer(qRef.FieldByName('ACCOUNT_ID').AsInteger));
    CLB_Accounts.Checked[CLB_Accounts.Items.IndexOf(qRef.FieldByName('LOGIN').AsString)] := qRef.FieldByName('LoadBillInBalance_').AsBoolean;
    qRef.Next;
  end;
  qRef.GotoBookmark(tt);
  qRef.EnableControls;
  sPanel5.Visible := True;
  sPanel5.Align := alClient;
  pnl6.Align := alNone;
  pnl6.Visible := False;
  crdbgrd1.Enabled := False;
  pnl5.Enabled := False;
  qRef.FreeBookmark(tt);
  sSplitter1.Enabled := false;
end;

procedure TRefAccountBillLoadForm.aEditExecute(Sender: TObject);
begin
  sPanel7.Visible := True;
  pnl6.Enabled := False;
  crdbgrd1.Enabled := False;
  pnl5.Enabled := False;
  sSplitter1.Enabled := false;
  qRef.ReadOnly := false;
  qRef.Edit;
  sDateEdit2.Date := qRef.FieldByName('DATE_BEGIN').AsDateTime;
  sDateEdit3.Date := qRef.FieldByName('DATE_END').AsDateTime;
  sDateEdit4.Date := qRef.FieldByName('DATE_CREDIT_END').AsDateTime;
end;

procedure TRefAccountBillLoadForm.aFiltrExecute(Sender: TObject);
begin
  if aFiltr.checked then
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeFilterBar]
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeFilterBar];

end;

procedure TRefAccountBillLoadForm.aFindExecute(Sender: TObject);
begin
  if aFind.checked then
    CRGrid.OptionsEx := CRGrid.OptionsEx + [dgeSearchBar]
  else
    CRGrid.OptionsEx := CRGrid.OptionsEx - [dgeSearchBar];

end;

procedure TRefAccountBillLoadForm.aFirstExecute(Sender: TObject);
begin
  qRef.First;
end;

procedure TRefAccountBillLoadForm.aLastExecute(Sender: TObject);
begin
  qRef.Last
end;

procedure TRefAccountBillLoadForm.aMoveNextExecute(Sender: TObject);
begin
  qRef.MoveBy(10);
end;

procedure TRefAccountBillLoadForm.aMovePrevExecute(Sender: TObject);
begin
  qRef.MoveBy(-10);
end;

procedure TRefAccountBillLoadForm.aNextExecute(Sender: TObject);
begin
  qRef.Next;
end;

procedure TRefAccountBillLoadForm.aPrevExecute(Sender: TObject);
begin
  qRef.Prior;
end;

procedure TRefAccountBillLoadForm.aToExcelExecute(Sender: TObject);
var
  Name_File_Excel,Zagolovok_Excel : string;
begin
  Name_File_Excel := 'Загрузка счетов в баланс';
  Zagolovok_Excel := 'Загрузка счетов в баланс';
  ExportOraQuery(Name_File_Excel, '', Zagolovok_Excel, qRef, FieldNameStr, false, True)
end;

procedure TRefAccountBillLoadForm.btn1Click(Sender: TObject);
var
  Text: String;
  PACCOUNT_ID, pdkl, otkl,i, Period: integer;

begin
  Period:=Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);

  qSetupParamYearMonth.ParamByName('PYEAR_MONTH').AsInteger := Period;
  qSetupParamYearMonth.ParamByName('PDATE_CREDIT').AsDateTime := sDateEdit1.Date;
  pdkl := 0;
  otkl := 0;
  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    if CLB_Accounts.checked[i] then
      pdkl := pdkl +1
    else
      otkl := otkl +1;
  end;
  Text := 'За месяц '+ cbPeriod.Text + ' будет отмечено в балансе ' +  intToStr(pdkl) + ' счетов, и ' + #10+#13 +
          ' Снято с баланса ' + intToStr(otkl) + ' счетов на ' + sDateEdit1.Text + ' число!' + #10+#13 +
          '     Выполнить действие?';
  if (TimedMessageBox(Text, 'Пожалуйста, будьте внимательны!', mtWarning, [mbYes, mbNo], mbNo, 35, 3) = mrYes) then
  begin
    for i := 0 to CLB_Accounts.Items.Count - 1 do
    begin
      if CLB_Accounts.checked[i] then
        qSetupParamYearMonth.ParamByName('PLOAD').AsInteger := 1
      else
        qSetupParamYearMonth.ParamByName('PLOAD').AsInteger := 0;
      PACCOUNT_ID := Integer(CLB_Accounts.Items.Objects[i]);
      qSetupParamYearMonth.ParamByName('PACCOUNT_ID').AsInteger := PACCOUNT_ID;

      qSetupParamYearMonth.ExecSQL;
    end;
  end;

  aRefresh.Execute;
  sPanel5.Visible := False;
  sPanel5.Align := alNone;
  pnl6.Align := alClient;
  pnl6.Visible := True;
  crdbgrd1.Enabled := True;
  pnl5.Enabled := True;
  sSplitter1.Enabled := True;
end;

procedure TRefAccountBillLoadForm.cbPeriodChange(Sender: TObject);
begin
  aRefresh.Execute;
end;

procedure TRefAccountBillLoadForm.aRefreshExecute(Sender: TObject);
begin
  qRef.Close;
  qRef.Open;
end;

procedure TRefAccountBillLoadForm.FormCreate(Sender: TObject);
var
 r, i : Integer;
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qRef.SQL.Add('    AND ACCOUNTS.FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    qAccNotBalance.SQL.add('    AND A.FILIAL_ID = ' + IntToStr(MainForm.FFilial));
    aEdit.Visible := False;
    aCheckedAll.Visible := False;
  end;
  qRef.SQL.Add('ORDER BY AB.ACCOUNT_ID ASC');
  qAccNotBalance.SQL.Add('ORDER BY T.ACCOUNT_ID, T.YEAR_MONTH DESC');

  SetLength(FieldNameStr,0);
  r := 0;
  for i := 0 to qRef.Fields.Count - 1 do
    if qRef.Fields[i].Visible then
    begin
      SetLength(FieldNameStr, Length(FieldNameStr) + 1);
      FieldNameStr[r] := qRef.Fields[i].FieldName;
      r := r + 1;
    end;
  pnl6.Align := alClient;
  pnl6.Visible := True;
  sPanel5.Visible := False;

  qPeriods.Open;
  while not qPeriods.EOF do
  begin
    cbPeriod.Items.AddObject(
                              qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
                              TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger)
                            );
    qPeriods.Next;
  end;
  qPeriods.Close;
  if cbPeriod.Items.Count > 0 then
    cbPeriod.ItemIndex := 0;
  cbPeriodChange(cbPeriod);
  qAccNotBalance.Close;
  qAccNotBalance.Open;

end;

procedure TRefAccountBillLoadForm.qRefBeforeOpen(DataSet: TDataSet);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qRef.ParamByName('YEAR_MONTH').AsInteger := Period;
end;

procedure TRefAccountBillLoadForm.qRefLoadBillInBalance_GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.Value then
    Text := 'Да'
  else
    Text := 'Нет';
end;

procedure TRefAccountBillLoadForm.sBitBtn15Click(Sender: TObject);
begin
  qAccNotBalance.Close;
  qAccNotBalance.Open;
end;

procedure TRefAccountBillLoadForm.sBitBtn16Click(Sender: TObject);
begin
  sPanel5.Visible := False;
  sPanel5.Align := alNone;
  pnl6.Align := alClient;
  pnl6.Visible := True;
  crdbgrd1.Enabled := True;
  pnl5.Enabled := True;
  sSplitter1.Enabled := True;
end;

procedure TRefAccountBillLoadForm.sBitBtn17Click(Sender: TObject);
var
  tt : TBookmark;
begin
  if qRef.FieldByName('DATE_BEGIN').AsDateTime <> sDateEdit2.Date then
    qRef.FieldByName('DATE_BEGIN').AsDateTime := sDateEdit2.Date;
  if qRef.FieldByName('DATE_END').AsDateTime <> sDateEdit3.Date then
    qRef.FieldByName('DATE_END').AsDateTime := sDateEdit3.Date;
  if qRef.FieldByName('DATE_CREDIT_END').AsDateTime <> sDateEdit4.Date then
    qRef.FieldByName('DATE_CREDIT_END').AsDateTime := sDateEdit4.Date;

  qRef.Post;
  sPanel7.Visible := False;
  pnl6.Enabled := True;
  crdbgrd1.Enabled := True;
  pnl5.Enabled := True;
  sSplitter1.Enabled := True;
  qRef.ReadOnly := True;
  tt := qRef.GetBookmark;
  aRefresh.Execute;
  qRef.GotoBookmark(tt);
  qRef.FreeBookmark(tt);
end;

procedure TRefAccountBillLoadForm.sBitBtn18Click(Sender: TObject);
begin
  qRef.Cancel;
  sPanel7.Visible := False;
  pnl6.Enabled := True;
  crdbgrd1.Enabled := True;
  pnl5.Enabled := True;
  sSplitter1.Enabled := True;
  qRef.ReadOnly := True;
end;

end.
