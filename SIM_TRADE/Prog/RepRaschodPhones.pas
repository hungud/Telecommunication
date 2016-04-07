unit RepRaschodPhones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Ora,
  IntecExportGrid, aceCheckComboBox, Vcl.ActnList, Vcl.ComCtrls;

type
  TfrmRepRaschodPhones = class(TForm)
    grData: TCRDBGrid;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    qReport: TOraQuery;
    DataSource1: TDataSource;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    Panel1: TPanel;
    lPeriod: TLabel;
    cbPeriod: TComboBox;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    btCheckAll: TButton;
    btUnCheckAll: TButton;
    qReportACCOUNT_NUMBER: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportCALLS_COST: TFloatField;
    qReportSMS_COST: TFloatField;
    qReportMMS_COST: TFloatField;
    qReportINTERNET_COST: TFloatField;
    cbAccParam: TComboBox;
    PageControl1: TPageControl;
    tsRepMonths: TTabSheet;
    tsRepDays: TTabSheet;
    Panel2: TPanel;
    lPeriod_call_start: TLabel;
    btLoadInExcel_call: TBitBtn;
    btRefresh_call: TBitBtn;
    btCheckAll_call: TButton;
    btUnCheckAll_call: TButton;
    qReport_call: TOraQuery;
    DataSource2: TDataSource;
    grData_call: TCRDBGrid;
    cbAccParam_call: TComboBox;
    aRefresh_call: TAction;
    dtDateStart: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    lPeriod_call_end: TLabel;
    ActionList2: TActionList;
    qReportCONTRACT_DATE: TDateTimeField;
    qReportTARIFF_NAME: TStringField;
    qReportBALANCE: TFloatField;
    qReportCONTRACT_TYPE: TStringField;
    qReportSTATUS: TStringField;
    qReportBALANCE_BLOCK_HAND_BLOCK: TFloatField;
    qAccountsACCOUNT_ID: TFloatField;
    qAccountsACCOUNT_NUMBER_NAME: TStringField;
    procedure btCheckAllClick(Sender: TObject);
    procedure btUnCheckAllClick(Sender: TObject);
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure btCheckAll_callClick(Sender: TObject);
    procedure btUnCheckAll_callClick(Sender: TObject);
    procedure aRefresh_callExecute(Sender: TObject);
  private
    { Private declarations }
    chcbAccountList : TacCheckComboBox;
    chcbAccountList_call : TacCheckComboBox;
    procedure Init(Session : TOraSession);
    procedure SetItemsState (State : Boolean);
    procedure SetItemsState_call (State : Boolean);
  public
    { Public declarations }
  end;

  procedure DoRepRaschodPhones(Session : TOraSession);

var
  frmRepRaschodPhones: TfrmRepRaschodPhones;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, ExportGridToExcelPDF;

procedure DoRepRaschodPhones(Session : TOraSession);
var ReportFrm : TfrmRepRaschodPhones;
begin
  ReportFrm := TfrmRepRaschodPhones.Create(Nil);
  try
    //Отчет
    ReportFrm.Init(Session);
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

{ TfrmRepRaschodPhones }

procedure TfrmRepRaschodPhones.Init(Session: TOraSession);
var Item : TCheckListItem;
begin
  //создаем CheckComboBox
  chcbAccountList := TacCheckComboBox.Create(nil);
  chcbAccountList.Align := alLeft;
  chcbAccountList.Height := Panel1.Height;
  chcbAccountList.Width := 200;
  chcbAccountList.Visible := True;
  chcbAccountList.Parent := Panel1;
  grData.ReadOnly := True;

  //Инитим сессию для основного запроса
  qReport.Session := Session;
  qReport.Close;

  //инитим сессию для периодов и заполняем ComboBox значениями
  qPeriods.Session := Session;
  qPeriods.Open;
  qPeriods.First;
  while not qPeriods.EOF do
  begin
    cbPeriod.Items.AddObject(qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
                             TObject(qPeriods.FieldByName('YEAR_MONTH').AsInteger));
    qPeriods.Next;
  end;
  qPeriods.Close;
  //проставляем значение периода по умолчанию и заполняем параметр основного запроса
  if cbPeriod.Items.Count > 0 then
    cbPeriod.ItemIndex := 0;

  //инитим сессию для счетов и заполняем CheckComboBox значениями
  qAccounts.Session := Session;

  qAccounts.Open;
  qAccounts.First;
  while not qAccounts.Eof do
  begin
    Item := (chcbAccountList.Items.Add as TCheckListItem);
    Item.Caption := qAccounts.FieldByName('ACCOUNT_NUMBER_NAME').AsString;
    Item.AddObject(TObject(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
    qAccounts.Next;
  end;
  //выбираем все счета по умолчанию
  btCheckAllClick(Self);

  //==================CALL=========================
  //создаем CheckComboBox
  chcbAccountList_call := TacCheckComboBox.Create(nil);
  chcbAccountList_call.Align := alLeft;
  chcbAccountList_call.Height := Panel1.Height;
  chcbAccountList_call.Width := 200;
  chcbAccountList_call.Visible := True;
  chcbAccountList_call.Parent := Panel2;

  qAccounts.First;
  while not qAccounts.Eof do
  begin
    Item := (chcbAccountList_call.Items.Add as TCheckListItem);
    Item.Caption := qAccounts.FieldByName('ACCOUNT_NUMBER_NAME').AsString;
    Item.AddObject(TObject(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
    qAccounts.Next;
  end;
  //выбираем все счета по умолчанию
  btCheckAll_callClick(Self);

  dtDateStart.Date := trunc(now);
  dtDateEnd.Date := trunc(now);
  PageControl1.ActivePage:=tsRepMonths;
end;

procedure TfrmRepRaschodPhones.aExcelExecute(Sender: TObject);
var cr : TCursor;
    ACaption : String;
    ANameFile : string;
    pGrid : TCRDBGrid;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  if PageControl1.ActivePage = tsRepMonths then
  begin
    ACaption := 'Отчет о расходах, не включенных в абон.плату за ' + cbPeriod.Text;
    pGrid := grData;
  end
  else
  if PageControl1.ActivePage = tsRepDays then
  begin
    ACaption := 'Отчет о расходах, не включенных в абон.плату c ' + DateTostr(trunc(dtDateStart.Date)) +
    ' по ' + DateTostr(trunc(dtDateEnd.Date));
    pGrid := grData_call;
  end;

  try
    ExportDBGridToExcel(ACaption, '', pGrid);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfrmRepRaschodPhones.aRefreshExecute(Sender: TObject);
var I, LAccID, LCheckItemCount : Integer;
    Item : TCheckListItem;
    LRes : string;
begin
  LCheckItemCount := 0;
  LRes := '';
  for I := 0 to chcbAccountList.Items.Count - 1 do
  begin
    Item := (chcbAccountList.Items.Items[i] as TCheckListItem);
    if Item.Checked then
    begin
      inc(LCheckItemCount);
      LAccID := Integer(Item.GetObject);
      LRes := LRes + IntToStr(LAccID) + ',';
    end;
  end;
  if LCheckItemCount = 0 then
  begin
    ShowMessage('Не выбран ни один счет!!!');
    chcbAccountList.SetFocus;
    Exit;
  end;
  LRes := ',' + LRes;
  qReport.Close;

  if (chcbAccountList.Items.Count <> LCheckItemCount) then
    qReport.ParamByName('PACCOUNT_ID').AsString := LRes
  else
    qReport.ParamByName('PACCOUNT_ID').Clear;

  case cbAccParam.ItemIndex of
    0 : qReport.ParamByName('pIS_COLLECTOR').Value := null;
    1 : qReport.ParamByName('pIS_COLLECTOR').Value := 1;
    2 : qReport.ParamByName('pIS_COLLECTOR').Value := 0;
  end;

  qReport.ParamByName('PYEAR_MONTH').AsString := IntToStr(Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]));
  qReport.Open;
end;

procedure TfrmRepRaschodPhones.aRefresh_callExecute(Sender: TObject);

  function CheckDateRep(begin_date,end_date:TDate): boolean;
  var dB,mB,yB, dE, mE, yE :word;
      qCall : TOraQuery;
  begin
    Result := true;
    //даты должны принадлежать одному месяцу
    decodedate(begin_date,yB,mB,dB);
    decodedate(end_date,yE,mE,dE);
    if mB <> mE then begin
      MessageDlg('Даты должны принадлежать одному месяцу!', mtConfirmation, [mbOK], 0);
      Result := false;
      exit;
    end;
    //должна имется таблица CALL, и не пустая
    qCall:= TOraQuery.Create(nil);
    try
      qCall.SQL.Text:= 'SELECT DB FROM HOT_BILLING_MONTH WHERE YEAR_MONTH = :pYEAR_MONTH';
      qCall.ParamByName('pYEAR_MONTH').AsString := IntToStr(yB)+FormatFloat('00',mB);
      qCall.Open;
      if qCall.IsEmpty or (qCall.FieldByName('DB').Value <> 1 ) then
      begin
        MessageDlg('Отсутствуют данные для формирования отчета!', mtConfirmation, [mbOK], 0);
        Result := false;
      end;
    finally
      FreeAndNil(qCall);
    end;
  end;

var I , LAccID, LCheckItemCount : Integer;
    Item : TCheckListItem;
    LRes : string;
    d, mm, yyyy : word;
begin
  DecodeDate(dtDateStart.Date, yyyy, mm, d);
  //проверяем даты
  if MainCheckDates(trunc(dtDateStart.Date), trunc(dtDateEnd.Date)) and
     CheckDateRep(trunc(dtDateStart.Date), trunc(dtDateEnd.Date)) then
  begin
    //формируем строку параметров отмеченных л/с
    LCheckItemCount := 0;
    LRes := '';
    for I := 0 to chcbAccountList_call.Items.Count - 1 do
    begin
      Item := (chcbAccountList_call.Items.Items[i] as TCheckListItem);
      if Item.Checked then
      begin
        inc(LCheckItemCount);
        LAccID := Integer(Item.GetObject);
        LRes := LRes + IntToStr(LAccID) + ',';
      end;
    end;
    if LCheckItemCount = 0 then
    begin
      ShowMessage('Не выбран ни один счет!!!');
      chcbAccountList_call.SetFocus;
      Exit;
    end;
    //удаляем последнюю запятую
    Delete(LRes, Length(LRes), 1);

    //формируем и разбираем запрос
    qReport_call.Close;
    qReport_call.sql.Text:=
    'SELECT t.account_id, VC.CONTRACT_DATE, Tar.TARIFF_NAME, ICB.BALANCE, ' +
    '   (CASE  WHEN VC.IS_CREDIT_CONTRACT = 1 THEN ''Кредит''  ELSE ''Аванс'' END) CONTRACT_TYPE, '+
    '   (CASE  WHEN P.PHONE_IS_ACTIVE = 0 THEN ' +
    '    CASE WHEN P.CONSERVATION = 1 THEN ''По сохранению'' ELSE ''По желанию'' END ELSE ''Активный'' END) STATUS, '+
    '   VC.BALANCE_BLOCK_HAND_BLOCK, a.account_number, t.phone_number, t.calls_cost,'+
    '       t.sms_cost, t.mms_cost, t.internet_cost'+
    ' FROM (SELECT get_account_id_by_phone(phone_number) account_id, '+
    '             phone_number, calls_cost, sms_cost, mms_cost, internet_cost'+
    '      FROM (SELECT phone_number, SUM(call_cost) calls_cost, SUM(sms_cost) sms_cost,'+
    '                  SUM(mms_cost) mms_cost, SUM(internet_cost) internet_cost'+
    '           FROM (SELECT c.subscr_no phone_number, '+
    '                        CASE WHEN c.servicetype=''C'''+
    '                          THEN c.call_cost'+
    '                          ELSE 0'+
    '                        END call_cost,'+
    '                        CASE WHEN c.servicetype=''S'''+
    '                          THEN c.call_cost'+
    '                          ELSE 0'+
    '                        END sms_cost,'+
    '                        CASE WHEN c.servicetype=''U'''+
    '                          THEN c.call_cost'+
    '                          ELSE 0'+
    '                        END mms_cost,'+
    '                        CASE WHEN c.servicetype=''G'''+
    '                          THEN c.call_cost'+
    '                          ELSE 0'+
    '                        END internet_cost'+
    '                 FROM CALL_'+FormatFloat('00',mm)+'_'+IntToStr(yyyy)+' c'+
    '                 WHERE c.call_cost <> 0 '+
    '                 and c.call_date >= '''+datetostr(trunc(dtDateStart.Date))+''''+
    '                 and c.call_date <= '''+datetostr(trunc(dtDateEnd.Date))+''')'+
    '          GROUP BY phone_number) ' +
    '       ) t, accounts a, V_CONTRACTS VC, TARIFFS Tar, IOT_CURRENT_BALANCE ICB, DB_LOADER_ACCOUNT_PHONES P '+
    ' WHERE t.account_id = a.account_id(+) '+
    '   AND t.PHONE_NUMBER = VC.PHONE_NUMBER_FEDERAL(+) '+
    '   AND (NVL (vc.contract_date, TO_DATE (''199001'', ''yyyymm'')) <= ' +
    '        ADD_MONTHS (TO_DATE (' + IntToStr(yyyy)+ FormatFloat('00',mm) + ', ''yyyymm''), 1) - 1) ' +
    '   AND NVL (vc.CONTRACT_CANCEL_DATE, TO_DATE (''205012'', ''yyyymm'')) >= ' +
    '            TO_DATE (' + IntToStr(yyyy)+ FormatFloat('00',mm) + ', ''yyyymm'') ' +
    '   AND VC.TARIFF_ID = Tar.TARIFF_ID(+) '+
    '   AND t.PHONE_NUMBER = ICB.PHONE_NUMBER(+) ' +
    '   AND t.PHONE_NUMBER = P.PHONE_NUMBER(+) ' +
    '   AND t.account_id = P.ACCOUNT_ID(+) ' +
    '   AND P.YEAR_MONTH = ' + IntToStr(yyyy)+ FormatFloat('00',mm) +
    '   AND ((NVL(a.is_collector, 0) = :pIs_collector) OR (:pIs_collector is null))';

    if (chcbAccountList.Items.Count <> LCheckItemCount) then
      qReport_call.SQL.Text:=qReport_call.SQL.Text+' AND a.account_id IN('+LRes+')';

    qReport_call.SQL.Text:=qReport_call.SQL.Text+' ORDER BY 1';

    case cbAccParam_call.ItemIndex of
      0 : qReport_call.ParamByName('pIS_COLLECTOR').Value := null;
      1 : qReport_call.ParamByName('pIS_COLLECTOR').Value := 1;
      2 : qReport_call.ParamByName('pIS_COLLECTOR').Value := 0;
    end;

    qReport_call.Open;
  end;
end;

procedure TfrmRepRaschodPhones.btCheckAllClick(Sender: TObject);
begin
  SetItemsState(True);
  chcbAccountList.Text := 'Все счета';
end;

procedure TfrmRepRaschodPhones.btCheckAll_callClick(Sender: TObject);
begin
  SetItemsState_call(True);
  chcbAccountList_call.Text := 'Все счета';
end;

procedure TfrmRepRaschodPhones.btUnCheckAllClick(Sender: TObject);
begin
  SetItemsState(False);
  chcbAccountList.Text := '';
end;

procedure TfrmRepRaschodPhones.btUnCheckAll_callClick(Sender: TObject);
begin
  SetItemsState_call(False);
  chcbAccountList_call.Text := '';
end;

procedure TfrmRepRaschodPhones.SetItemsState(State: Boolean);
var
  i : Integer;
begin
  for i := 0 to chcbAccountList.Items.Count - 1 do
    TCheckListItem(chcbAccountList.Items.Items[i]).Checked := State;
end;

procedure TfrmRepRaschodPhones.SetItemsState_call(State: Boolean);
var
  i : Integer;
begin
  for i := 0 to chcbAccountList_call.Items.Count - 1 do
    TCheckListItem(chcbAccountList_call.Items.Items[i]).Checked := State;
end;

procedure TfrmRepRaschodPhones.cbPeriodChange(Sender: TObject);
var Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qReport.ParamByName('PYEAR_MONTH').AsString := IntToStr(Period);
end;

end.
