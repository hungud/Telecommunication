unit ReportContractHandBlock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, sListBox, sCheckListBox;

type
  TReportContractHandBlockForm = class(TForm)
    Panel1: TPanel;
    lAccount: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btInfoAbonent: TBitBtn;
    cbSearch: TCheckBox;
    grData: TCRDBGrid;
    ActionList: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qAccounts: TOraQuery;
    dsReport: TDataSource;
    cbHandBlock: TCheckBox;
    qreport: TOraQuery;
    CLB_Accounts: TsCheckListBox;
    procedure aRefreshExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure grDataGetCellParams(Sender: TObject; Field: TField; AFont: TFont;
      var Background: TColor; State: TGridDrawState; StateEx: TGridDrawStateEx);
    procedure CLB_AccountsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
  private
    { Private declarations }
    FAccountAll:boolean;
    FAccid : string;
  public
    { Public declarations }
  end;

var
  ReportContractHandBlockForm: TReportContractHandBlockForm;

procedure DoContractHandBlock;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid, ShowUserStat;

procedure DoContractHandBlock;
var ReportFrm : TReportContractHandBlockForm;
    Sdvig:integer;
begin
  ReportFrm:=TReportContractHandBlockForm.Create(Nil);
  try
    // Заполнение списка "Лиц.счет"
    if GetConstantValue('REPORT_CONTRACTS_HAND_BLOCK')='1' then
    begin
      ReportFrm.CLB_Accounts.Show;
      ReportFrm.CLB_Accounts.Items.AddObject('Все', Pointer(-1));
      ReportFrm.qAccounts.Open;
      while not ReportFrm.qAccounts.EOF do
      begin
        ReportFrm.CLB_Accounts.Items.AddObject(
          ReportFrm.qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
        );
        ReportFrm.qAccounts.Next;
      end;
      ReportFrm.qAccounts.Close;
    end else
    begin
    {  Sdvig:=ReportFrm.cbAccounts.Left+ReportFrm.cbAccounts.Width;
      ReportFrm.lAccount.Hide;
      ReportFrm.cbAccounts.Hide;
      ReportFrm.btLoadInExcel.Left:=ReportFrm.btLoadInExcel.Left-Sdvig;
      ReportFrm.btRefresh.Left:=ReportFrm.btRefresh.Left-Sdvig;
      ReportFrm.btInfoAbonent.Left:=ReportFrm.btInfoAbonent.Left-Sdvig;
      ReportFrm.cbSearch.Left:=ReportFrm.cbSearch.Left-Sdvig;
      ReportFrm.qReport.ParamByName('ACCOUNT_ID').Clear;}
    end;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportContractHandBlockForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Договора с ручной блокировкой по состоянию на '+DateToStr(Date),'',
      grData, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportContractHandBlockForm.aRefreshExecute(Sender: TObject);
begin
  qReport.Close;
  qReport.SQL.Text:=
  'SELECT v.PHONE_NUMBER, v.CONTRACT_NUM,  v.CONTRACT_DATE,'+
         ' CASE'+
         '  WHEN v.HAND_BLOCK=1 THEN ''Блок.'''+
         '  ELSE '''''+
         ' END HAND_BLOCK,'+
         '  v.CONTRACT_CANCEL_DATE,'+
         '  v.CURRENT_BALANCE,'+
         ' CASE'+
         '   WHEN v.HAND_BLOCK = 1 THEN'+
         '      v.USER_LAST_UPDATED||'+
         '     (SELECT '' (''||USER_FIO||'')'''+
         '      FROM USER_NAMES'+
         '      WHERE v.USER_LAST_UPDATED = UPPER(USER_NAME))'+
         '   ELSE NULL'+
         ' END USER_NAME,'+
         ' COMMENTS, FIO'+
  ' FROM v_contracts_hand_block v'+
  ' WHERE ((:HAND_BLOCK IS NULL)OR(v.HAND_BLOCK = :HAND_BLOCK))';
  if not FAccountAll then
    if Trim(FAccid) <> '' then
      qReport.SQL.Text:=qReport.SQL.Text+' AND ACCOUNT_ID IN ('+FAccid+') ORDER BY v.PHONE_NUMBER'
    else
    begin
      MessageDlg('Не выбрано ни одного счета!!!', mtWarning, [mbOK], 0);
      exit;
    end
  else
    qReport.SQL.Text:=qReport.SQL.Text+' ORDER BY v.PHONE_NUMBER';
  if cbHandBlock.Checked then
  begin
    qReport.ParamByName('HAND_BLOCK').asInteger := 1;
  end else
  begin
    qReport.ParamByName('HAND_BLOCK').Clear;
  end;
  qReport.Open;
end;

procedure TReportContractHandBlockForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

procedure TReportContractHandBlockForm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    grData.OptionsEx:=grData.OptionsEx+[dgeSearchBar]
  else
    grData.OptionsEx:=grData.OptionsEx-[dgeSearchBar];
end;

procedure TReportContractHandBlockForm.CLB_AccountsClickCheck(Sender: TObject);
var i : integer;
begin
  if FAccountAll<>CLB_Accounts.Checked[0] then
    for i := 1 to CLB_Accounts.Count-1 do
      CLB_Accounts.Checked[i]:=CLB_Accounts.Checked[0]
  else
    CLB_Accounts.Checked[0]:=false;
  FAccountAll:=CLB_Accounts.Checked[0];
end;

procedure TReportContractHandBlockForm.CLB_AccountsExit(Sender: TObject);
var
  i: integer;
begin
FAccid:='';
if not FAccountAll then
  for i := 1 to CLB_Accounts.Items.Count - 1 do
    if CLB_Accounts.Checked[i] then
      FAccid:= FAccid+inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';

if not FAccountAll then
  FAccid:=copy(FAccid,1,Length(FAccid)-1);
end;

procedure TReportContractHandBlockForm.CLB_AccountsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var xPoint: TPoint;
    xIndex: Integer;
begin
  xPoint.X:=X;
  xPoint.Y:=Y;
  xIndex:=CLB_Accounts.ItemAtPos(xPoint,True);
  if xIndex<>-1 then begin
    CLB_Accounts.Hint:=CLB_Accounts.Items[xIndex];
    Application.ActivateHint(xPoint);
  end
  else Application.CancelHint;
end;

procedure TReportContractHandBlockForm.grDataGetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
begin
   //Подсветка ручных блокировок
  if (Field.FieldName='HAND_BLOCK')and(Field.AsString='Блок.')
  then AFont.Color := clRed;
end;

end.


