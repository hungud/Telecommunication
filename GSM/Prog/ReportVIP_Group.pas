unit ReportVIP_Group;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS, StrUtils, Main,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons, System.IOUtils,
  Vcl.ExtCtrls, Vcl.ComCtrls, sListBox, sCheckListBox, IntecExportGrid,  VCL.FlexCel.Core, FlexCel.XlsAdapter,
  FlexCel.Render, FlexCel.Pdf,  Registry, IniFiles,  ShellAPI,  ExportGridToExcelPDF,
  sSplitter, sEdit, sSpeedButton;


type
  TReportVipGroupFrm = class(TForm)
    PageControl2: TPageControl;
    ts1: TTabSheet;
    ts1dbgrd1: TCRDBGrid;
    pnl1: TPanel;
    lblAccount: TLabel;
    lblPeriod: TLabel;
    lbl1: TLabel;
    btnaRefresh: TBitBtn;
    btn2: TBitBtn;
    CLB_Accounts: TsCheckListBox;
    cbPeriod: TComboBox;
    ts2: TTabSheet;
    pnl2: TPanel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    btnaRefresh2: TBitBtn;
    btnLoadInExcel2btn: TBitBtn;
    ts2cbPeriod: TComboBox;
    ts2lAccount: TsCheckListBox;
    ts2dbgrd: TCRDBGrid;
    ts3: TTabSheet;
    pnl3: TPanel;
    lbl3: TLabel;
    lbl6: TLabel;
    btnResfresh3Btn: TBitBtn;
    btnaLoadInExcel3: TBitBtn;
    ts3lAccount: TsCheckListBox;
    ts3cbPeriod: TComboBox;
    ts3dbgrd: TCRDBGrid;
    dsReport: TDataSource;
    qAccounts: TOraQuery;
    qReport: TOraQuery;
    dsTs2: TDataSource;
    qAccountContr: TOraQuery;
    dsTS3: TDataSource;
    qTS3: TOraQuery;
    qPeriod: TOraQuery;
    actlstList: TActionList;
    aRefresh: TAction;
    aLoadInExcel: TAction;
    aRefresh2: TAction;
    aLoadInExcel2: TAction;
    aResfresh3: TAction;
    aLoadInExcel3: TAction;
    qTarifs_R: TOraQuery;
    qTarifs_RTARIFF_NAME: TStringField;
    qTarifs_RTARIFF_NAME_CODE: TStringField;
    qTarifs_RTARIFF_ID: TFloatField;
    ChLB_Tarif: TsCheckListBox;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    ChLB_Tarif2: TsCheckListBox;
    CheckBox2: TCheckBox;
    qTarifs_A: TOraQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    eLimOtkl2: TEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    qAccountContrCONTRACT_ID: TFloatField;
    qAccountContrPHONE_NUMBER: TStringField;
    qAccountContrTARIFF_ID: TFloatField;
    qAccountContrTARIFF_NAME: TStringField;
    qAccountContrCONTRACT_DATE: TDateTimeField;
    qAccountContrSTATUS: TStringField;
    qAccountContrLAST_CHANGE_STATUS_DATE: TDateTimeField;
    aLimitOkl1: TAction;
    aLimitOkl2: TAction;
    aLimitOkl3: TAction;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label4: TLabel;
    eLimOtkl1: TEdit;
    BitBtn2: TBitBtn;
    Bevel8: TBevel;
    qTS3CONTRACT_ID: TFloatField;
    qTS3PHONE_NUMBER: TStringField;
    qTS3TARIFF_NAME: TStringField;
    qTS3TARIFF_ID: TFloatField;
    qTS3CONTRACT_DATE: TDateTimeField;
    qTS3ACCOUNT_ID: TFloatField;
    qTS3SUBSCRIBER_PAYMENT_MAIN: TFloatField;
    qTS3BILL_SUM: TFloatField;
    qTS3YEAR_MONTH: TFloatField;
    Bevel9: TBevel;
    Label5: TLabel;
    ChLB_Tarif3: TsCheckListBox;
    CheckBox3: TCheckBox;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Label6: TLabel;
    eLimOtkl3: TEdit;
    BitBtn3: TBitBtn;
    Bevel12: TBevel;
    qReportCONTRACT_ID: TFloatField;
    qReportPHONE_NUMBER: TStringField;
    qReportTARIFF_NAME: TStringField;
    qReportTARIFF_ID: TFloatField;
    qReportCONTRACT_DATE: TDateTimeField;
    qReportACCOUNT_ID: TFloatField;
    qReportYEAR_MONTH: TFloatField;
    qReportMAX_DATE: TDateTimeField;
    qReportDISCONNECT_LIMIT: TFloatField;
    qAccountContrDISCONNECT_LIMIT: TFloatField;
    qTS3DISCONNECT_LIMIT: TFloatField;
    qPeriodYEAR_MONTH: TFloatField;
    qPeriodYEAR_MONTH_NAME: TStringField;
    qTS3Y_M: TStringField;
    qSetDISCONNECT_LIMIT: TOraQuery;
    ts0: TTabSheet;
    ts01: TTabSheet;
    BalloonHint1: TBalloonHint;
    qPARAMS: TOraQuery;
    qPARAMSVALUE: TStringField;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    cbParam1: TComboBox;
    Bevel14: TBevel;
    chbParam1: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    cbParam2: TComboBox;
    Bevel13: TBevel;
    chbParam2: TCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    Bevel15: TBevel;
    chbParam3: TCheckBox;
    Label16: TLabel;
    cbPeriod1: TComboBox;
    udParam3: TUpDown;
    edParam3: TEdit;
    chbParamCloseOrder: TCheckBox;
    Label17: TLabel;
    cbPeriod2: TComboBox;
    Label9: TLabel;
    CLB_Accounts0: TsCheckListBox;
    Label12: TLabel;
    lParam1: TLabel;
    cbParam1_2: TComboBox;
    lParam2: TLabel;
    cbParam2_3: TComboBox;
    lParam3: TLabel;
    SaveParam: TBitBtn;
    Bevel16: TBevel;
    Bevel17: TBevel;
    ChLB_Tarif0: TsCheckListBox;
    LTarifs_cnt: TLabel;
    ChB_Tarif0: TCheckBox;
    Panel3: TPanel;
    Panel4: TPanel;
    eLimOtkl0: TEdit;
    BitBtn7: TBitBtn;
    Label21: TLabel;
    Bevel18: TBevel;
    chbOldRepShow: TCheckBox;
    RichEdit1: TRichEdit;
    BitBtn5: TBitBtn;
    qReportMain: TOraQuery;
    dsqReportMain: TDataSource;
    qReportMainCONTRACT_ID: TFloatField;
    qReportMainPHONE_NUMBER: TStringField;
    qReportMainTARIFF_ID: TFloatField;
    qReportMainCONTRACT_DATE: TDateTimeField;
    qReportMainDISCONNECT_LIMIT: TFloatField;
    qReportMainTARIFF_NAME: TStringField;
    qReportMainACCOUNT_ID: TFloatField;
    qReportMainSTATUS: TStringField;
    qReportMainLAST_CHANGE_STATUS_DATE: TDateTimeField;
    qTarifsMain: TOraQuery;
    qTarifsMainTARIFF_NAME: TStringField;
    qTarifsMainTARIFF_NAME_CODE: TStringField;
    qTarifsMainTARIFF_ID: TFloatField;
    BitBtn6: TBitBtn;
    qReportMainOld: TOraQuery;
    FloatField2: TFloatField;
    StringField3: TStringField;
    FloatField3: TFloatField;
    DateTimeField1: TDateTimeField;
    FloatField4: TFloatField;
    StringField4: TStringField;
    FloatField5: TFloatField;
    StringField5: TStringField;
    DateTimeField2: TDateTimeField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    StringField6: TStringField;
    Panel1: TPanel;
    cdgMain: TCRDBGrid;
    CRDBGrid1: TCRDBGrid;
    sSplitter1: TsSplitter;
    qReportMainDob: TOraQuery;
    dsqReportMainDob: TDataSource;
    qReportMainDobSUBSCRIBER_PAYMENT_MAIN: TFloatField;
    qReportMainDobBILL_SUM: TFloatField;
    qReportMainDobYEAR_MONTH: TFloatField;
    qReportMainDobprd: TStringField;
    qReportMainDobACCOUNT_ID: TFloatField;
    qReportMainDobname_acc: TStringField;
    qReportMainname_acc: TStringField;
    qReportMainDobBALANCE: TFloatField;
    qReportMainDobLAST_UPDATE: TDateTimeField;
    Bevel19: TBevel;
    sbCheckAll_Account: TsSpeedButton;
    sbUnCheckAll_Account: TsSpeedButton;
    seAccountSearch: TsEdit;
    sbCheckSelAccount: TsSpeedButton;
    sbCheckSelected_Account: TsSpeedButton;
    sbCheckAll_Tarifs: TsSpeedButton;
    sbUnCheckAll_Tarifs: TsSpeedButton;
    seTarifsSearch: TsEdit;
    sbCheckSelTarifs: TsSpeedButton;
    sbCheckSelected_Tarifs: TsSpeedButton;
    Label15: TLabel;
    LAccounts_cnt: TLabel;
    LTimeSQl: TLabel;
    MainQueryMove: TPanel;
    sbFirst: TsSpeedButton;
    sbMovePrior: TsSpeedButton;
    sbPrior: TsSpeedButton;
    sbNext: TsSpeedButton;
    sbMoveNext: TsSpeedButton;
    sbLast: TsSpeedButton;
    spMain: TOraStoredProc;
    InitParam: TBitBtn;
    chbParam4: TCheckBox;
    Bevel20: TBevel;
    cbParam3_4: TComboBox;
    lParam4: TLabel;
    qReportMainMES_SPIS: TStringField;
    lBracket1: TLabel;
    lBracket2: TLabel;
    lBracket3: TLabel;
    lBracket4: TLabel;
    lBracket5: TLabel;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aRefresh2Execute(Sender: TObject);
    procedure aLoadInExcel2Execute(Sender: TObject);
    procedure aResfresh3Execute(Sender: TObject);
    procedure aLoadInExcel3Execute(Sender: TObject);
    procedure CLB_AccountsClickCheck(Sender: TObject);
    procedure CLB_AccountsExit(Sender: TObject);
    procedure ts2lAccountClickCheck(Sender: TObject);
    procedure ts3lAccountClickCheck(Sender: TObject);
    procedure ts2lAccountExit(Sender: TObject);
    procedure ts3lAccountExit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ChLB_TarifClickCheck(Sender: TObject);
    procedure ChLB_Tarif2ClickCheck(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure qTS3AfterScroll(DataSet: TDataSet);
    procedure ChLB_Tarif3ClickCheck(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure qAccountContrAfterScroll(DataSet: TDataSet);
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure aLimitOkl1Execute(Sender: TObject);
    procedure aLimitOkl3Execute(Sender: TObject);
    procedure aLimitOkl2Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckChoise;
    procedure CheckAccounts(ids : String);
    procedure CheckTarifs(ids : String);

    procedure chbOldRepShowClick(Sender: TObject);
    procedure CLB_Accounts0ClickCheck(Sender: TObject);
    procedure ChLB_Tarif0ClickCheck(Sender: TObject);
    procedure ChB_Tarif0Click(Sender: TObject);
    procedure chbParam1Click(Sender: TObject);
    procedure chbParam2Click(Sender: TObject);
    procedure chbParam3Click(Sender: TObject);
    procedure SaveParamClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qReportMainAfterScroll(DataSet: TDataSet);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure NotVisibleAll;
    procedure CheckAll;

    procedure qReportMainBeforeOpen(DataSet: TDataSet);
    procedure qReportMainDobBeforeOpen(DataSet: TDataSet);
    procedure qTarifsMainBeforeOpen(DataSet: TDataSet);
    procedure AddParam(var text: String);
    procedure qTarifsMainAfterOpen(DataSet: TDataSet);
    procedure cbParam1_2Change(Sender: TObject);
    procedure cbParam2_3Change(Sender: TObject);
    procedure sbCheckAll_AccountClick(Sender: TObject);
    procedure sbUnCheckAll_AccountClick(Sender: TObject);
    procedure sbCheckSelected_AccountClick(Sender: TObject);
    procedure sbCheckSelAccountClick(Sender: TObject);
    procedure sbCheckAll_TarifsClick(Sender: TObject);
    procedure sbUnCheckAll_TarifsClick(Sender: TObject);
    procedure sbCheckSelected_TarifsClick(Sender: TObject);
    procedure sbCheckSelTarifsClick(Sender: TObject);
    procedure ChLB_Tarif0Click(Sender: TObject);
    procedure CLB_Accounts0Click(Sender: TObject);
    procedure qReportMainAfterOpen(DataSet: TDataSet);
    procedure sbFirstClick(Sender: TObject);
    procedure sbMovePriorClick(Sender: TObject);
    procedure sbPriorClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure sbMoveNextClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure InitParamClick(Sender: TObject);
    procedure qReportMainAfterFetch(DataSet: TCustomDADataSet);
    procedure chbParam4Click(Sender: TObject);

  private
    FieldNameStr: TFLst;
    procedure SetVarParams (ch : TsCheckListBox; var AccIdStr : string; var AccountIdStr : string );
    procedure SetAccountIDList (ch : TsCheckListBox; var AccIdStr : string; var AccountIdStr : string; var Cnt : Integer);
    procedure ExportToExcel (title : string; grid : TCRDBGrid;  AccIdStr : string; AccountIdStr : String);

  public
    fIdTarifs, fId : string;
    FAccid0, FAccid, FAccid2, FAccid3 : string;
    FAccount0, FAccount, FAccount2, FAccount3 : string;
    tarif_Checked_count, fCnt0, fCnt1, fCnt2, fCnt3, fShowOne : integer;
    needScrool, Accounts_changeDone, allInit, mainScrool : Boolean;
    tm : TTime;
    { Public declarations }
  end;
 procedure DoReportVIP_Group;


var
  ReportVipGroupFrm: TReportVipGroupFrm;

implementation
{$R *.dfm}


procedure DoReportVip_Group;
var
  ReportFrm : TReportVipGroupFrm;
begin
  ReportFrm := TReportVipGroupFrm.Create(nil);
  try
    //ReportFrm.FormStyle := fsMDIChild;
    //ReportFrm.Show;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportVipGroupFrm.aLoadInExcel3Execute(Sender: TObject);
begin
  ExportToExcel('Отчет по номерам %TITLE%, по которым был счет от 1000 р сверх абонки за период '+ts3cbPeriod.Items[ts2cbPeriod.ItemIndex]+' на дату %DATE%',
                ts3dbgrd, FAccid3, Faccount3);
end;

procedure TReportVipGroupFrm.aResfresh3Execute(Sender: TObject);
var
 sql_text : string;
begin
  inherited;
  if FAccid3='' then
  begin
    if fShowOne = 1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne := 1;
    exit;
  end;

  qTarifs_A.Close;
  with qTarifs_A do
   begin
     try
       sql.Clear;
      sql_text := 'select distinct T.TARIFF_NAME, '+#13#10+
                  'T.TARIFF_NAME ||'' (''|| T.TARIFF_CODE||'')'' TARIFF_NAME_CODE,'+#13#10+
                  't.TARIFF_ID '+#13#10+
                  'from tariffs t,'+#13#10+
                  'v_contracts v,'+#13#10+
                  'db_loader_bills lb'+#13#10+
                  '             where'+#13#10+
                  'V.TARIFF_ID = T.TARIFF_ID'+#13#10+
                  'and V.PHONE_NUMBER_FEDERAL = lb.phone_number'+#13#10+
                  'and V.CONTRACT_CANCEL_DATE is null'+#13#10+
     'and (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > 1000'+#13#10+
     'and lb.YEAR_MONTH = :PERIOD3';
      if FAccid3 <> '-1'  then
        sql_text := sql_text+' and ACCOUNT_ID in ('+FAccid3+') ';
       sql_text := sql_text+ ' order by TARIFF_NAME';
       sql.Add(sql_Text);
       ParamByName('period3').AsString := IntToStr(Integer(ts3cbPeriod.Items.Objects[ts3cbPeriod.ItemIndex]));
       //ts3cbPeriod.Items[ts3cbPeriod.ItemIndex];
       Open;
     except
       on e : exception do
         MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
     end;
   end;
  qTarifs_A.first;
  ChLB_Tarif3.Items.Clear;
  while not qTarifs_A.eof do
  begin
    ChLB_Tarif3.Items.AddObject(qTarifs_A.fieldByName('TARIFF_NAME_CODE').asString, Pointer(qTarifs_A.fieldByName('TARIFF_ID').asInteger));
    qTarifs_A.Next;
  end;

  qTS3.Close;
  with qTS3 do
  begin
    try
      sql.Clear;
      sql_text := 'select v.CONTRACT_ID,'+#13#10+
                  'lb.phone_number,'+#13#10+
                  'T.TARIFF_NAME,'+#13#10+
                  't.TARIFF_ID,'+#13#10+
                  'v.contract_date,'+#13#10+
                  'lb.account_id,'+#13#10+
                  'lb.SUBSCRIBER_PAYMENT_MAIN,'+#13#10+
                  'lb.bill_sum,'+#13#10+
                  'lb.YEAR_MONTH,'+#13#10+
                  'v.DISCONNECT_LIMIT'+#13#10+
                  'from tariffs t,'+#13#10+
                  'v_contracts v,'+#13#10+
                  'db_loader_bills lb'+#13#10+
                  '             where'+#13#10+
                  'V.TARIFF_ID = T.TARIFF_ID'+#13#10+
                  'and V.PHONE_NUMBER_FEDERAL = lb.phone_number'+#13#10+
                  'and V.CONTRACT_CANCEL_DATE is null'+#13#10+
     'and (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > 1000'+#13#10+
     'and lb.YEAR_MONTH = :PERIOD3';
      if FAccid3 <> '-1'  then
        sql_text := sql_text+' and ACCOUNT_ID in ('+FAccid3+') ';
      sql_text := sql_text+ ' order by phone_number';

      sql.Add(sql_Text);
      ParamByName('period3').AsString := IntToStr(Integer(ts3cbPeriod.Items.Objects[ts3cbPeriod.ItemIndex]));
      //ts3cbPeriod.Items[ts3cbPeriod.ItemIndex];
      Open;
    except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TReportVipGroupFrm.SaveParamClick(Sender: TObject);
var
 stv, st : string;
 i : Integer;
begin
 // ChLB_Tarif0Exit(Sender);
  if  tarif_Checked_count = 0 then
  begin
    MessageDlg('Не выбрано ни одного тарифа', mtError, [mbOK], 0);
    exit;
  end;

  if chbParam1.Checked then
    stv := stv + '1'
  else
    stv := stv + '0';
  stv := stv + Format('%2d',[cbParam1.ItemIndex]);

  if chbParam2.Checked then
    stv := stv + '1'
  else
    stv := stv + '0';
  stv := stv + Format('%2d',[cbParam2.ItemIndex]);

  if chbParam3.Checked then
    stv := stv + '1'
  else
    stv := stv + '0';
  stv := stv + Format('%5d',[StrToInt(edParam3.Text)]);

  if chbParamCloseOrder.Checked then
    stv := stv + '1'
  else
    stv := stv + '0';

  stv := stv + Format('%6d',[Integer(cbPeriod1.Items.Objects[cbPeriod1.ItemIndex])]);
  stv := stv + Format('%6d',[Integer(cbPeriod2.Items.Objects[cbPeriod2.ItemIndex])]);

  if cbParam1_2.Visible then
    stv := stv + Format('%2d',[cbParam1_2.ItemIndex])
  else
    stv := stv + '05';

  if cbParam2_3.Visible then
    stv := stv + Format('%2d',[cbParam2_3.ItemIndex])
  else
    stv := stv + '05';


  if chbParam4.Checked then
    stv := stv + '1'
  else
    stv := stv + '0';

  if cbParam3_4.Visible then
    stv := stv + Format('%2d',[cbParam3_4.ItemIndex])
  else
    stv := stv + '05';

  if lBracket1.Visible then
    stv := stv + '('
  else
    stv := stv + '|';

  if lBracket2.Visible then
    stv := stv + '('
  else
    stv := stv + '|';

  if lBracket5.Visible then
    stv := stv + '('
  else
    stv := stv + '|';

  if lBracket3.Visible then
    stv := stv + ')'
  else
    stv := stv + '|';

  if lBracket4.Visible then
    stv := stv + ')'
  else
    stv := stv + '|';

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('update PARAMS set value  = :value where NAME = ''VIP_GROUP_PARAMS''');
  qPARAMS.ParamByName('value').AsString := stv;
  qPARAMS.Execute;

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('update PARAMS set value  = :value where NAME = ''VIP_GROUP_ACCOUNT''');
  qPARAMS.ParamByName('value').AsString := FAccid0;
  qPARAMS.Execute;

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('delete from ACCOUNT_VIPGROUP');
  qPARAMS.Execute;
  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('insert into ACCOUNT_VIPGROUP (ACCOUNT_ID) values (:ACCOUNT_ID)');

  for i := 0 to CLB_Accounts0.Items.Count - 1 do
    if CLB_Accounts0.Checked[i] then
    begin
      qPARAMS.ParamByName('ACCOUNT_ID').AsInteger := Integer(CLB_Accounts0.Items.Objects[i]);
      qPARAMS.Execute;
    end;
  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('delete from TARIFS_VIPGROUP');
  qPARAMS.Execute;
  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('insert into TARIFS_VIPGROUP (TARIFF_ID) values (:TARIFF_ID)');

  fIdTarifs := '';
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
    if ChLB_Tarif0.Checked[i] then
    begin
      fIdTarifs := fIdTarifs + IntToStr(Integer(ChLB_Tarif0.Items.Objects[i])) + ',';
      qPARAMS.ParamByName('TARIFF_ID').AsInteger := Integer(ChLB_Tarif0.Items.Objects[i]);
      qPARAMS.Execute;
    end;
  fIdTarifs := copy(fIdTarifs, 1, Length(fIdTarifs) - 1);

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('update PARAMS set value  = :value where NAME = ''VIP_GROUP_TARIFS''');
    qPARAMS.ParamByName('value').AsString := fIdTarifs;
  qPARAMS.Execute;
   MessageDlg('Параметры успешно сохранены', mtInformation, [mbOK], 0);
end;

procedure TReportVipGroupFrm.BitBtn5Click(Sender: TObject);
begin
  //ExportToExcel('Отчет по ВИП группе ',  cdgMain, FAccid0, Faccount0);
  needScrool := false;

  ExportOraQuery2('Отчет по ВИП группе ', '', GET_EXCEL_FILE_NAME('Отчет по ВИП группе '), qReportMain, FieldNameStr, false, True, true);
  needScrool := True;

end;

procedure TReportVipGroupFrm.BitBtn6Click(Sender: TObject);
var
  st, i, ln : Integer;
  rzd, lfIdTarifs, rfIdTarifs : string;
begin
  st := 3900;
  if  tarif_Checked_count = 0 then
  begin
    MessageDlg('Не выбрано ни одного тарифа', mtError, [mbOK], 0);
    exit;
  end;
  fIdTarifs := '';
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
    if ChLB_Tarif0.Checked[i] then
    begin
      fIdTarifs := fIdTarifs + IntToStr(Integer(ChLB_Tarif0.Items.Objects[i])) + ',';
    end;
  fIdTarifs := copy(fIdTarifs, 1, Length(fIdTarifs) - 1);

    spMain.StoredProcName := 'delete_TARIFS_VIPGROUP';
    spMain.PrepareSQL;  // receive parameters
    spMain.Execute;
    spMain.StoredProcName := 'INS_TARIFS_VIPGROUP';
    spMain.PrepareSQL;  // receive parameters
    ln := Length(fIdTarifs);
    if Ln <= st then
    begin
      spMain.ParamByName('txtID').AsString := fIdTarifs;
      spMain.Execute;
    end
    else
    begin
      rfIdTarifs := fIdTarifs;
      while Ln > st do
      begin
        Application.ProcessMessages;
        lfIdTarifs := Copy(rfIdTarifs,1,st);
        for i := st downto 0 do
        begin
          rzd := lfIdTarifs[i];
          if rzd = ',' then Break;
        end;
        rzd := Copy(lfIdTarifs,i+1,st);
        lfIdTarifs := Copy(rfIdTarifs,1,i-1);
        rfIdTarifs := rzd + Copy(rfIdTarifs,st+1, Ln - st);
        spMain.ParamByName('txtID').AsString := lfIdTarifs;
        spMain.Execute;
        Ln := Length(rfIdTarifs);
      end;
    end;

  needScrool := False;
  qReportMain.close;
  Application.ProcessMessages;
  qReportMain.Open;
  needScrool := True;
  qReportMainDob.close;
  qReportMainDob.Open;
  BitBtn5.Enabled := qReportMain.RecordCount > 0;
end;

procedure TReportVipGroupFrm.BitBtn7Click(Sender: TObject);
begin
  qSetDISCONNECT_LIMIT.ParamByName('DISCONNECT_LIMIT').AsFloat :=  StrToFloatDef(eLimOtkl0.Text,100);
  qSetDISCONNECT_LIMIT.ParamByName('CONTRACT_ID').AsInteger := qReportMain.FieldByName('CONTRACT_ID').AsInteger;
  qSetDISCONNECT_LIMIT.Execute;
  qReportMain.RefreshRecord;
end;

procedure TReportVipGroupFrm.InitParamClick(Sender: TObject);
begin
   CheckChoise;
   InitParam.Enabled := False;
end;

procedure TReportVipGroupFrm.ChB_Tarif0Click(Sender: TObject);
var
 i : Integer;
begin
  if ChB_Tarif0.Checked then
  begin
    ChLB_Tarif0.Enabled := False;
    fIdTarifs := '';
    for i := 0 to ChLB_Tarif0.Items.Count - 1 do
      if ChLB_Tarif0.checked[i] then
        fIdTarifs := fIdTarifs + IntToStr(Integer(ChLB_Tarif0.Items.Objects[i])) + ',';
    fIdTarifs := copy(fIdTarifs, 1, Length(fIdTarifs) - 1);
  end else begin
    ChLB_Tarif0.Enabled := True;;
  end;
  qReportMain.Close;
  qReportMain.Open;

end;

procedure TReportVipGroupFrm.CheckBox1Click(Sender: TObject);
 var
  i : Integer;
  sql_text : string;
begin
  if CheckBox1.Checked then
  begin
    ChLB_Tarif.Enabled := False;
    fId := '';
    for i := 0 to ChLB_Tarif.Items.Count - 1 do
      if ChLB_Tarif.checked[i] then
        fId := fId + IntToStr(Integer(ChLB_Tarif.Items.Objects[i])) + ',';
    fId := copy(fId, 1, Length(fId) - 1);
    qReport.Close;
    with qReport do
    begin
      try
         sql.Clear;
         sql_text:=' select v.CONTRACT_ID,'+#13#10+
                '        d.phone_number, '+#13#10+
                '        T.TARIFF_NAME, '+#13#10+
                '        t.TARIFF_ID, '+#13#10+
                '        v.contract_date, '+#13#10+
                '        v.DISCONNECT_LIMIT, '+#13#10+
                '        ph.account_id, '+#13#10+
                '        PH.YEAR_MONTH, '+#13#10+
                '        d.max_date '+#13#10+
                '        ,v.DISCONNECT_LIMIT '+#13#10+
                ' from tariffs t, '+#13#10+
                '       v_contracts v, '+#13#10+
                '       db_loader_account_phones ph,'+#13#10+
                '       (select* from ( '+#13#10+
                '                        select '+#13#10+
                '                              phone_number, '+#13#10+
                '                              max(end_date) as max_date '+#13#10+
                '                        from '+#13#10+
                '                          DB_LOADER_ACCOUNT_PHONE_HISTS '+#13#10+
                '                       where '+#13#10+
                '                          PHONE_IS_ACTIVE = 0 '+#13#10+
                '                        group by phone_number '+#13#10+
                '                       ) '+#13#10+
                '                  where '+#13#10+
                '                    trunc(max_date) <= trunc(add_months(sysdate,-:period))) d '+#13#10+
                ' where  V.TARIFF_ID = T.TARIFF_ID '+#13#10+
                ' and d.phone_number = PH.PHONE_NUMBER '+#13#10+
                ' and V.PHONE_NUMBER_FEDERAL = d.phone_number '+#13#10+
                ' and V.CONTRACT_CANCEL_DATE is null '+#13#10+
                ' and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones   ) '+#13#10;
        if FAccid <> '-1'  then
          sql_text := sql_text+' and ph.account_id in ('+FAccid+') ';
        sql_text := sql_text+' and V.TARIFF_ID in ('+fId+') ';
        sql_text := sql_text+' order by phone_number';
        sql.Add(sql_Text);
        ParamByName('period').AsString := cbPeriod.Items[cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;
    end;
  end else begin
    ChLB_Tarif.Enabled := true;
    qReport.Close;
    with qReport do
    begin
      try
         sql.Clear;
         sql_text:=' select v.CONTRACT_ID,'+#13#10+
                '        d.phone_number, '+#13#10+
                '        T.TARIFF_NAME, '+#13#10+
                '        t.TARIFF_ID, '+#13#10+
                '        v.contract_date, '+#13#10+
                '        v.DISCONNECT_LIMIT, '+#13#10+
                '        ph.account_id, '+#13#10+
                '        PH.YEAR_MONTH, '+#13#10+
                '        d.max_date '+#13#10+
                '        ,v.DISCONNECT_LIMIT '+#13#10+
                ' from tariffs t, '+#13#10+
                '       v_contracts v, '+#13#10+
                '       db_loader_account_phones ph,'+#13#10+
                '       (select* from ( '+#13#10+
                '                        select '+#13#10+
                '                              phone_number, '+#13#10+
                '                              max(end_date) as max_date '+#13#10+
                '                        from '+#13#10+
                '                          DB_LOADER_ACCOUNT_PHONE_HISTS '+#13#10+
                '                       where '+#13#10+
                '                          PHONE_IS_ACTIVE = 0 '+#13#10+
                '                        group by phone_number '+#13#10+
                '                       ) '+#13#10+
                '                  where '+#13#10+
                '                    trunc(max_date) <= trunc(add_months(sysdate,-:period))) d '+#13#10+
                ' where  V.TARIFF_ID = T.TARIFF_ID '+#13#10+
                ' and d.phone_number = PH.PHONE_NUMBER '+#13#10+
                ' and V.PHONE_NUMBER_FEDERAL = d.phone_number '+#13#10+
                ' and V.CONTRACT_CANCEL_DATE is null '+#13#10+
                ' and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones   ) '+#13#10;
        if FAccid <> '-1'  then
          sql_text := sql_text+' and ph.account_id in ('+FAccid+') ';

        sql_text := sql_text+' order by phone_number';
        sql.Add(sql_Text);
        ParamByName('period').AsString := cbPeriod.Items[cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TReportVipGroupFrm.CheckBox2Click(Sender: TObject);
 var
  i : Integer;
  fId2, sql_text : string;
begin
  if CheckBox2.Checked then
  begin
    ChLB_Tarif2.Enabled := False;
    fId2 := '';
    for i := 0 to ChLB_Tarif2.Items.Count - 1 do
      if ChLB_Tarif2.checked[i] then
        fId2 := fId2 + IntToStr(Integer(ChLB_Tarif2.Items.Objects[i])) + ',';
    fId2 := copy(fId2, 1, Length(fId2) - 1);
    qAccountContr.Close;
    with qAccountContr do
    begin
      try
        sql.Clear;
        sql_text:='select v.CONTRACT_ID,'+#13#10+
                 '  V.PHONE_NUMBER_FEDERAL PHONE_NUMBER, '+#13#10+
                 '  T.TARIFF_ID, '+#13#10+
                 '  T.TARIFF_NAME, '+#13#10+
                 '  v.contract_date, '+#13#10+
                 '  v.DISCONNECT_LIMIT, '+#13#10+
                 '  case PH.PHONE_IS_ACTIVE '+#13#10+
                 '   when 1 then ''Активен'' '+#13#10+
                 '  else '+#13#10+
                 '   ''Блокирован'' '+#13#10+
                 '  end as status, '+#13#10+
                 '  PH.LAST_CHANGE_STATUS_DATE '+#13#10+
                 ' , v.DISCONNECT_LIMIT '+#13#10+
                 ' from '+#13#10+
                 '   v_contracts v '+#13#10+
                 '     left join tariffs t '+#13#10+
                 '             on V.TARIFF_ID  =   T.TARIFF_ID '+#13#10+
                 '     left join '+#13#10+
                 '               (select  dl.PHONE_IS_ACTIVE, '+#13#10+
                 '                        dl.LAST_CHANGE_STATUS_DATE, '+#13#10+
                 '                        dl.PHONE_NUMBER '+#13#10+
                 '                        from '+#13#10+
                 '                         db_loader_account_phones dl '+#13#10+
                 '                        where '+#13#10+
                 '                         dl.last_check_date_time =(select max(m.last_check_date_time) '+#13#10+
                 '                                                       from DB_LOADER_ACCOUNT_PHONES m '+#13#10+
                 '                                                       where m.phone_number = dl.phone_number and m.year_month=to_char(sysdate,''YYYYMM'') '+#13#10+
                 '                                                  ) '+#13#10+
                 '             )ph '+#13#10+
                 '             on  V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER '+#13#10+
                 ' where '+#13#10+
                 '  V.CONTRACT_DATE <= add_months(sysdate,-:period2) '+#13#10+
                 '  and V.CONTRACT_CANCEL_DATE is null ';

        if FAccid2<>'-1'  then
          sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL) in ('+FAccid2+') '
        else
          sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL)  in '+
                            '         (select ACCOUNT_ID from ACCOUNTS where ACCOUNT_ID <> 225)';
        sql_text := sql_text+' and V.TARIFF_ID in ('+fId2+') ';
        sql_text := sql_text + #13#10+ ' order by PHONE_NUMBER_FEDERAL';
        sql.Add(sql_Text);
        ParamByName('period2').AsString := ts2cbPeriod.Items[ts2cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;

    end;

  end else begin

    ChLB_Tarif2.Enabled := true;
    qAccountContr.Close;
    with qAccountContr do
    begin
      try
        sql.Clear;
        sql_text:='select v.CONTRACT_ID,'+#13#10+
                 '  V.PHONE_NUMBER_FEDERAL PHONE_NUMBER, '+#13#10+
                 '  T.TARIFF_ID, '+#13#10+
                 '  T.TARIFF_NAME, '+#13#10+
                 '  v.contract_date, '+#13#10+
                 '  v.DISCONNECT_LIMIT, '+#13#10+
                 '  case PH.PHONE_IS_ACTIVE '+#13#10+
                 '   when 1 then ''Активен'' '+#13#10+
                 '  else '+#13#10+
                 '   ''Блокирован'' '+#13#10+
                 '  end as status, '+#13#10+
                 '  PH.LAST_CHANGE_STATUS_DATE '+#13#10+
                 '  ,v.DISCONNECT_LIMIT '+#13#10+
                 ' from '+#13#10+
                 '   v_contracts v '+#13#10+
                 '     left join tariffs t '+#13#10+
                 '             on V.TARIFF_ID  =   T.TARIFF_ID '+#13#10+
                 '     left join '+#13#10+
                 '               (select  dl.PHONE_IS_ACTIVE, '+#13#10+
                 '                        dl.LAST_CHANGE_STATUS_DATE, '+#13#10+
                 '                        dl.PHONE_NUMBER '+#13#10+
                 '                        from '+#13#10+
                 '                         db_loader_account_phones dl '+#13#10+
                 '                        where '+#13#10+
                 '                         dl.last_check_date_time =(select max(m.last_check_date_time) '+#13#10+
                 '                                                       from DB_LOADER_ACCOUNT_PHONES m '+#13#10+
                 '                                                       where m.phone_number = dl.phone_number and m.year_month=to_char(sysdate,''YYYYMM'') '+#13#10+
                 '                                                  ) '+#13#10+
                 '             )ph '+#13#10+
                 '             on  V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER '+#13#10+
                 ' where '+#13#10+
                 '  V.CONTRACT_DATE <= add_months(sysdate,-:period2) '+#13#10+
                 '  and V.CONTRACT_CANCEL_DATE is null ';

        if FAccid2<>'-1'  then
          sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL) in ('+FAccid2+') '
        else
          sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL)  in '+
                            '         (select ACCOUNT_ID from ACCOUNTS where ACCOUNT_ID <> 225)';

        sql_text := sql_text + #13#10+ ' order by PHONE_NUMBER_FEDERAL';
        sql.Add(sql_Text);
        ParamByName('period2').AsString := ts2cbPeriod.Items[ts2cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;

    end;
  end;
end;

procedure TReportVipGroupFrm.CheckBox3Click(Sender: TObject);
 var
  i : Integer;
  fId2, sql_text : string;
begin
  if CheckBox3.Checked then
  begin
    ChLB_Tarif3.Enabled := False;
    fId2 := '';

    for i := 0 to ChLB_Tarif3.Items.Count - 1 do
      if ChLB_Tarif3.checked[i] then
        fId2 := fId2 + IntToStr(Integer(ChLB_Tarif3.Items.Objects[i])) + ',';
    fId2 := copy(fId2, 1, Length(fId2) - 1);

    qTS3.Close;
    with qTS3 do
    begin
      try
        sql.Clear;
        sql_text := 'select v.CONTRACT_ID,'+#13#10+
                    'lb.phone_number,'+#13#10+
                    'T.TARIFF_NAME,'+#13#10+
                    't.TARIFF_ID,'+#13#10+
                    'v.contract_date,'+#13#10+
                    'lb.account_id,'+#13#10+
                    'lb.SUBSCRIBER_PAYMENT_MAIN,'+#13#10+
                    'lb.bill_sum,'+#13#10+
                    'lb.YEAR_MONTH,'+#13#10+
                    'v.DISCONNECT_LIMIT'+#13#10+
                    'from tariffs t,'+#13#10+
                    'v_contracts v,'+#13#10+
                    'db_loader_bills lb'+#13#10+
                    '             where'+#13#10+
                    'V.TARIFF_ID = T.TARIFF_ID'+#13#10+
                    'and V.PHONE_NUMBER_FEDERAL = lb.phone_number'+#13#10+
                    'and V.CONTRACT_CANCEL_DATE is null'+#13#10+
       'and (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > 1000'+#13#10+
       'and lb.YEAR_MONTH = :PERIOD3';
        if FAccid3 <> '-1'  then
          sql_text := sql_text+' and ACCOUNT_ID in ('+FAccid3+') ';

        sql_text := sql_text+' and V.TARIFF_ID in ('+fId2+') ';
        sql_text := sql_text+ ' order by phone_number';

        sql.Add(sql_Text);
        ParamByName('period3').AsString := ts3cbPeriod.Items[ts3cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;
    end;
    end else begin
    ChLB_Tarif3.Enabled := true;
    qTS3.Close;
    with qTS3 do
    begin
      try
        sql.Clear;
        sql_text := 'select v.CONTRACT_ID,'+#13#10+
                    'lb.phone_number,'+#13#10+
                    'T.TARIFF_NAME,'+#13#10+
                    't.TARIFF_ID,'+#13#10+
                    'v.contract_date,'+#13#10+
                    'lb.account_id,'+#13#10+
                    'lb.SUBSCRIBER_PAYMENT_MAIN,'+#13#10+
                    'lb.bill_sum,'+#13#10+
                    'lb.YEAR_MONTH,'+#13#10+
                    'v.DISCONNECT_LIMIT'+#13#10+
                    'from tariffs t,'+#13#10+
                    'v_contracts v,'+#13#10+
                    'db_loader_bills lb'+#13#10+
                    '             where'+#13#10+
                    'V.TARIFF_ID = T.TARIFF_ID'+#13#10+
                    'and V.PHONE_NUMBER_FEDERAL = lb.phone_number'+#13#10+
                    'and V.CONTRACT_CANCEL_DATE is null'+#13#10+
       'and (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > 1000'+#13#10+
       'and lb.YEAR_MONTH = :PERIOD3';
        if FAccid3 <> '-1'  then
          sql_text := sql_text+' and ACCOUNT_ID in ('+FAccid3+') ';
        sql_text := sql_text+ ' order by phone_number';

        sql.Add(sql_Text);
        ParamByName('period3').AsString := ts3cbPeriod.Items[ts3cbPeriod.ItemIndex];
        Open;
      except
        on e : exception do
          MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TReportVipGroupFrm.cbParam1_2Change(Sender: TObject);
begin
 InitParam.Enabled := True;//  CheckChoise;
end;

procedure TReportVipGroupFrm.cbParam2_3Change(Sender: TObject);
begin
 InitParam.Enabled := True;// CheckChoise;
end;

procedure TReportVipGroupFrm.chbOldRepShowClick(Sender: TObject);
begin
  ts1.TabVisible := chbOldRepShow.Checked;
  ts2.TabVisible := chbOldRepShow.Checked;
  ts3.TabVisible := chbOldRepShow.Checked;
end;

procedure TReportVipGroupFrm.NotVisibleAll;
begin
  lBracket1.Visible := false;
  lBracket2.Visible := false;
  lParam1.Visible := false;
  cbParam1_2.Visible := false;
  lBracket5.Visible := false;
  lParam2.Visible := false;
  lBracket3.Visible := false;
  cbParam2_3.Visible := false;
  lParam3.Visible := false;
  lBracket4.Visible := false;
  cbParam3_4.Visible := false;
  lParam4.Visible := false;
  //lBracket6.Visible := false;
end;

procedure TReportVipGroupFrm.CheckAll;
begin
  if chbParam1.Checked then
  begin
    lParam1.Visible := True;
    if chbParam2.Checked then
    begin
      cbParam1_2.Visible := true;
      lParam2.Visible := true;
      lBracket3.Visible := chbParam4.Checked;
      lBracket2.Visible := chbParam4.Checked;
    end;
    if chbParam3.Checked then
    begin
      cbParam2_3.Visible := true;
      lParam3.Visible := true;
      lBracket2.Visible := chbParam2.Checked;
      lBracket3.Visible := chbParam2.Checked;
    end;
    if chbParam4.Checked then
    begin
      cbParam3_4.Visible := true;
      lParam4.Visible := true;
      lBracket4.Visible := chbParam3.Checked;
      lBracket1.Visible := chbParam3.Checked;
    end;
  end else begin
    if chbParam2.Checked then
    begin
      lParam2.Visible := true;
    end;
    if chbParam3.Checked then
    begin
      cbParam2_3.Visible := chbParam2.Checked;
      lParam3.Visible := true;
    end;
    if chbParam4.Checked then
    begin
      cbParam3_4.Visible := chbParam2.Checked or chbParam3.Checked;
      lParam4.Visible := true;
      lBracket4.Visible := chbParam2.Checked and  chbParam3.Checked;
      lBracket5.Visible := chbParam2.Checked and chbParam3.Checked;
    end;
  end;
  ////////
  if lBracket5.Visible then
  begin
    lBracket5.Left := 6;
    lParam2.Left := 13;
    cbParam2_3.Left := 65;
    lParam3.Left := 115;
    lBracket4.Left := 159;
    cbParam3_4.Left := 169;
    lParam4.Left := 220;
  end
  else
  begin
    if lBracket2.Visible then
    begin
      if lBracket1.Visible then
        lBracket2.Left := lBracket1.Left + lBracket1.Width + 2
      else
        lBracket2.Left := 6;
    end;

    if lParam1.Visible then
    begin
      if lBracket2.Visible then
        lParam1.Left := lBracket2.Left + lBracket2.Width + 2
      else
       if lBracket1.Visible then
         lParam1.Left := lBracket1.Left + lBracket1.Width + 2
       else
         lParam1.Left := 6;
    end;

    if cbParam1_2.Visible then
      cbParam1_2.Left := lParam1.Left + lParam1.Width + 2;

    if lParam2.Visible then
    begin
      if cbParam1_2.Visible then
        lParam2.Left := cbParam1_2.Left + cbParam1_2.Width + 2
      else
        lParam2.Left := 6;
    end;

    if lBracket3.Visible then
      lBracket3.Left := lParam2.Left + lParam2.Width + 2;

    if cbParam2_3.Visible then
    begin
      if lBracket3.Visible then
        cbParam2_3.Left := lBracket3.Left + lBracket3.Width + 2
      else
        if lParam2.Visible then
          cbParam2_3.Left := lParam2.Left + lParam2.Width + 2
        else
          if lParam1.Visible then
            cbParam2_3.Left := lParam1.Left + lParam1.Width + 2;
    end;

    if lParam3.Visible then
    begin
      if cbParam2_3.Visible then
        lParam3.Left := cbParam2_3.Left + cbParam2_3.Width + 2
      else
        lParam3.Left := 6;
    end;

    if lBracket4.Visible then
    begin
      lBracket4.Left := lParam3.Left + lParam3.Width + 2;
    end;

    if cbParam3_4.Visible then
    begin
      if lBracket4.Visible then
        cbParam3_4.Left := lBracket4.Left + lBracket4.Width + 2
      else
        if lParam3.Visible then
          cbParam3_4.Left := lParam3.Left + lParam3.Width + 2
        else
          if lBracket3.Visible then
            cbParam3_4.Left := lBracket3.Left + lBracket3.Width + 2
          else
            if lParam2.Visible then
              cbParam3_4.Left := lParam2.Left + lParam2.Width + 2
            else
              if lParam1.Visible then
                cbParam3_4.Left := lParam1.Left + lParam1.Width + 2;
    end;

    if lParam4.Visible then
    begin
      if cbParam3_4.Visible then
        lParam4.Left := cbParam3_4.Left + cbParam3_4.Width + 2
      else
       lParam4.Left := 6;
    end;

  end;
  SaveParam.Enabled := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked or chbParam4.Checked;
end;

procedure TReportVipGroupFrm.chbParam1Click(Sender: TObject);
begin
  InitParam.Enabled := True;
  NotVisibleAll;
  CheckAll;
end;

procedure TReportVipGroupFrm.chbParam2Click(Sender: TObject);
begin
  InitParam.Enabled := True; //CheckChoise;
  NotVisibleAll;
  CheckAll;
end;

procedure TReportVipGroupFrm.chbParam3Click(Sender: TObject);
begin
  InitParam.Enabled := True;// CheckChoise;
  NotVisibleAll;
  CheckAll;
end;

procedure TReportVipGroupFrm.chbParam4Click(Sender: TObject);
begin
  NotVisibleAll;
  CheckAll;
 end;

procedure TReportVipGroupFrm.ChLB_Tarif0Click(Sender: TObject);
begin
   LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(tarif_Checked_count);
   sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0) and (ChLB_Tarif0.Count <>tarif_Checked_count);
   sbUnCheckAll_Tarifs.Enabled := tarif_Checked_count >0;
   sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;

end;

procedure TReportVipGroupFrm.ChLB_Tarif0ClickCheck(Sender: TObject);
var
  i : Integer;
begin
    tarif_Checked_count := 0;
    for i := 0 to ChLB_Tarif0.Items.Count - 1 do
      if ChLB_Tarif0.checked[i] then
      begin
        inc(tarif_Checked_count);
      end;
   LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(tarif_Checked_count);
   sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0) and (ChLB_Tarif0.Count <>tarif_Checked_count);
   sbUnCheckAll_Tarifs.Enabled := tarif_Checked_count >0;
   sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;
end;

procedure TReportVipGroupFrm.ChLB_Tarif2ClickCheck(Sender: TObject);
var
  i : Integer;
begin
  CheckBox2.Enabled := false;
  for i := 0 to ChLB_Tarif2.Items.Count - 1 do
    if ChLB_Tarif2.checked[i] then
    begin
      CheckBox2.Enabled := True;
      Exit;
    end;
end;

procedure TReportVipGroupFrm.ChLB_Tarif3ClickCheck(Sender: TObject);
var
  i : Integer;
begin
  CheckBox3.Enabled := false;
  for i := 0 to ChLB_Tarif3.Items.Count - 1 do
    if ChLB_Tarif3.checked[i] then
    begin
      CheckBox3.Enabled := True;
      Exit;
    end;
end;

procedure TReportVipGroupFrm.ChLB_TarifClickCheck(Sender: TObject);
var
  i : Integer;
begin
  CheckBox1.Enabled := false;
  for i := 0 to ChLB_Tarif.Items.Count - 1 do
    if ChLB_Tarif.checked[i] then
    begin
      CheckBox1.Enabled := True;
      Exit;
    end;
end;

procedure TReportVipGroupFrm.CLB_Accounts0Click(Sender: TObject);
begin
  LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено ' + IntToStr(fCnt0);
  sbCheckAll_Account.Enabled := (CLB_Accounts0.Count > 0) and (CLB_Accounts0.Count <>fCnt0);
  sbUnCheckAll_Account.Enabled := fCnt0 >0;
  sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;

end;

procedure TReportVipGroupFrm.CLB_Accounts0ClickCheck(Sender: TObject);
var
 i : Integer;
begin
  if Accounts_changeDone then
  begin
    SetAccountIDList(CLB_Accounts0, FAccid0, FAccount0, fCnt0);

    LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено ' + IntToStr(fCnt0);
    sbCheckAll_Account.Enabled := (CLB_Accounts0.Count > 0) and (CLB_Accounts0.Count <>fCnt0);
    sbUnCheckAll_Account.Enabled := fCnt0 >0;
    sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;

    qPARAMS.Close;
    qPARAMS.SQL.Clear;
    qPARAMS.SQL.Add('delete from ACCOUNT_VIPGROUP');
    qPARAMS.Execute;
    qPARAMS.Close;
    qPARAMS.SQL.Clear;
    qPARAMS.SQL.Add('insert into ACCOUNT_VIPGROUP (ACCOUNT_ID) values (:ACCOUNT_ID)');

    for i := 0 to CLB_Accounts0.Items.Count - 1 do
      if CLB_Accounts0.Checked[i] then
      begin
        qPARAMS.ParamByName('ACCOUNT_ID').AsInteger := Integer(CLB_Accounts0.Items.Objects[i]);
        qPARAMS.Execute;
      end;
    InitParam.Enabled := True;
    allInit := false;
    CheckChoise;
    allInit := true;
    //qTarifsMain.close;
    //qTarifsMain.Open;
  end;
end;

procedure TReportVipGroupFrm.CLB_AccountsClickCheck(Sender: TObject);
begin
  SetVarParams(CLB_Accounts, FAccid, FAccount);
end;

procedure TReportVipGroupFrm.CLB_AccountsExit(Sender: TObject);
begin
  SetAccountIDList(CLB_Accounts, FAccid, FAccount, fCnt1);
end;

procedure TReportVipGroupFrm.ExportToExcel(title: string; grid: TCRDBGrid;
  AccIdStr: string; AccountIdStr : String);
var
  cr : TCursor;
  vTitle : string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  vTitle := AnsiReplaceStr(title, '%DATE%', FormatDateTime('dd.mm.yyyy', Date()));
  try
    if AccIdStr <> '-1'  then
      vTitle := AnsiReplaceStr(vTitle, '%TITLE%', AccountIdStr)
    else
      vTitle := AnsiReplaceStr(vTitle, '%TITLE%', '');

    ExportDBGridToExcel(vTitle, '', grid, False, True);

  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportVipGroupFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportVipGroupFrm.FormCreate(Sender: TObject);
var
  prm, st : string;
  i : Integer;
begin
//
  ts1.TabVisible := false;
  ts2.TabVisible := false;
  ts3.TabVisible := false;
  PageControl2.TabIndex := 0;
  qAccounts.Open;
    while not qAccounts.EOF do
    begin
      CLB_Accounts0.Items.AddObject(qAccounts.FieldByName('LOGIN').AsString, Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
      CLB_Accounts.Items.AddObject(qAccounts.FieldByName('LOGIN').AsString, Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
      if qAccounts.FieldByName('ACCOUNT_ID').AsInteger <> 225 then
        ts2lAccount.Items.AddObject(qAccounts.FieldByName('LOGIN').AsString, Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
      ts3lAccount.Items.AddObject(qAccounts.FieldByName('LOGIN').AsString, Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
      qAccounts.Next;
    end;
    qAccounts.Close;

    qPeriod.Open;
    while not qPeriod.EOF do
    begin
      cbPeriod1.Items.AddObject(qPeriod.FieldByName('YEAR_MONTH_NAME').AsString, TObject(qPeriod.FieldByName('YEAR_MONTH').Asinteger));
      cbPeriod2.Items.AddObject(qPeriod.FieldByName('YEAR_MONTH_NAME').AsString, TObject(qPeriod.FieldByName('YEAR_MONTH').Asinteger));
      ts3cbPeriod.Items.AddObject(qPeriod.FieldByName('YEAR_MONTH_NAME').AsString, TObject(qPeriod.FieldByName('YEAR_MONTH').Asinteger));
      qPeriod.Next;
    end;
    qPeriod.Close;
    if cbPeriod1.Items.Count > 2 then
      cbPeriod1.ItemIndex := 2
    else
      if cbPeriod1.Items.Count > 0 then
        cbPeriod1.ItemIndex := 0;
    cbPeriod2.ItemIndex := 0;

    if ts3cbPeriod.Items.Count > 0 then
      ts3cbPeriod.ItemIndex := 0;
    if ts3cbPeriod.Items.Count > 2 then
      ts3cbPeriod.ItemIndex := 2
    else
      if ts3cbPeriod.Items.Count > 0 then
        ts3cbPeriod.ItemIndex := 0;

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('select value from PARAMS where NAME = ''VIP_GROUP_PARAMS''');
  qPARAMS.Open;

  prm :=  qPARAMS.FieldByName('value').AsString;
  if prm <> '' then
  begin
    st := copy(prm,1,1);
    if st = '0' then
      chbParam1.Checked := False
    else
      chbParam1.Checked := True;

    st := Trim(copy(prm,2,2));
    cbParam1.ItemIndex := StrToIntDef(st,0);

    st := copy(prm,4,1);
    if st = '0' then
      chbParam2.Checked := False
    else
      chbParam2.Checked := True;

    st := Trim(copy(prm,5,2));
    cbParam2.ItemIndex := StrToIntDef(st,0);

    st := copy(prm,7,1);
    if st = '0' then
      chbParam3.Checked := False
    else
      chbParam3.Checked := True;

    st := Trim(copy(prm,8,5));
    edParam3.Text := st;

    udParam3.Position := StrToIntDef(st,1000);

    st := copy(prm,13,1);
    if st = '0' then
      chbParamCloseOrder.Checked := False
    else
      chbParamCloseOrder.Checked := True;

    st := Trim(copy(prm,14,6));
    for i := 0 to cbPeriod1.Items.Count -1  do
      if (st = IntToStr(Integer(cbPeriod1.Items.Objects[i]))) then
        cbPeriod1.ItemIndex := i;

    st := Trim(copy(prm,20,6));
    for i := 0 to cbPeriod2.Items.Count -1  do
      if (st = IntToStr(Integer(cbPeriod2.Items.Objects[i]))) then
        cbPeriod2.ItemIndex := i;

    st := copy(prm,26,2);
    cbParam1_2.ItemIndex := StrToIntDef(st,0);

    st := copy(prm,28,2);
    cbParam2_3.ItemIndex := StrToIntDef(st,0);

    st := copy(prm,30,1);
    if st = '0' then
      chbParam4.Checked := False
    else
      chbParam4.Checked := True;

    st := copy(prm,31,2);
    cbParam3_4.ItemIndex := StrToIntDef(st,0);
  end;

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('select value from PARAMS where NAME = ''VIP_GROUP_ACCOUNT''');
  qPARAMS.Open;
  prm :=  qPARAMS.FieldByName('value').AsString;

  if prm <> '' then
  begin
    FAccid0 := prm;
    i := 1;
    while i <> 0 do
    begin
      i := PosEx(',',prm);
      if i = 0 then
      begin
        st := prm;
        prm := '';
      end else begin
        st := Copy(prm,1,i-1);
        prm := Copy(prm,i+1,length(prm));
      end;
      if st <> '' then
        CheckAccounts(st);
    end;
    SetAccountIDList(CLB_Accounts0, FAccid0, FAccount0, fCnt0);
  end;
   LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(0) + '; отмечено ' + IntToStr(fCnt0);
  sbCheckAll_Account.Enabled := (CLB_Accounts0.Count > 0) and (CLB_Accounts0.Count <>fCnt0);
  sbUnCheckAll_Account.Enabled := fCnt0 >0;
  sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;

  CLB_Accounts0ClickCheck(Sender);

  qTarifsMain.close;
  qTarifsMain.Open;

  qPARAMS.Close;
  qPARAMS.SQL.Clear;
  qPARAMS.SQL.Add('select value from PARAMS where NAME = ''VIP_GROUP_TARIFS''');
  qPARAMS.Open;
  prm :=  qPARAMS.FieldByName('value').AsString;
  tarif_Checked_count := 0;
  if prm <> '' then
  begin
    fIdTarifs := prm;
    i := 1;
    while i <> 0 do
    begin
      i := PosEx(',',prm);
      if i = 0 then
      begin
        st := prm;
        prm := '';
      end else begin
        st := Copy(prm,1,i-1);
        prm := Copy(prm,i+1,length(prm));
      end;
      if st <> '' then
        CheckTarifs(st);
    end;
  end;
  allInit := true;
   LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(0) + '; отмечено ' + IntToStr(tarif_Checked_count);
   sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0) and (ChLB_Tarif0.Count <>tarif_Checked_count);
   sbUnCheckAll_Tarifs.Enabled := tarif_Checked_count >0;
   sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;
   Accounts_changeDone := True;
   InitParam.Enabled := false;

   SetLength(FieldNameStr,7);
   FieldNameStr[0] := 'PHONE_NUMBER';
   FieldNameStr[1] := 'name_acc';
   FieldNameStr[2] := 'TARIFF_NAME';
   FieldNameStr[3] := 'MES_SPIS';
   FieldNameStr[4] := 'CONTRACT_DATE';
   FieldNameStr[5] := 'DISCONNECT_LIMIT';
   FieldNameStr[6] := 'LAST_CHANGE_STATUS_DATE';

  Accounts_changeDone := True;
end;


procedure TReportVipGroupFrm.CheckTarifs(ids : String);
var
 i : Integer;
begin
  for i := 0 to ChLB_Tarif0.Count-1  do
  begin
     if (ids = IntToStr(Integer(ChLB_Tarif0.Items.Objects[i]))) then
     begin
       ChLB_Tarif0.Checked[i] := True;
       tarif_Checked_count := tarif_Checked_count +1;
       Exit;
     end;
  end;
end;

procedure TReportVipGroupFrm.CheckAccounts(ids : String);
var
 i : Integer;
begin
  for i := 0 to CLB_Accounts0.Count-1  do
  begin
     if (ids = IntToStr(Integer(CLB_Accounts0.Items.Objects[i]))) then
     begin
       CLB_Accounts0.Checked[i] := True;
       Exit;
     end;
  end;
end;

procedure TReportVipGroupFrm.CheckChoise;
var
i:Integer;
st, prm : string;
begin
  if allInit then
  begin
    qTarifsMain.Close;
    qTarifsMain.Open;
    qPARAMS.Close;
    qPARAMS.SQL.Clear;
    qPARAMS.SQL.Add('select value from PARAMS where NAME = ''VIP_GROUP_TARIFS''');
    qPARAMS.Open;
    prm :=  qPARAMS.FieldByName('value').AsString;
    tarif_Checked_count := 0;
    if prm <> '' then
    begin
      fIdTarifs := prm;
      i := 1;
      while i <> 0 do
      begin
        i := PosEx(',',prm);
        if i = 0 then
        begin
          st := prm;
          prm := '';
        end else begin
          st := Copy(prm,1,i-1);
          prm := Copy(prm,i+1,length(prm));
        end;
        if st <> '' then
          CheckTarifs(st);
      end;
    end;
  end;
  if chbParam1.Checked then
  begin
    cbParam1.Enabled := False;
    lParam1.Visible := True;
    SaveParam.Enabled := True;
  end else begin
    cbParam1.Enabled := True;
    lParam1.Visible := false;
    SaveParam.Enabled := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked;
  end;
  if chbParam2.Checked then
  begin
    cbParam2.Enabled := False;
    cbParam1_2.Visible := chbParam1.Checked;
    lParam2.Visible := True;
    SaveParam.Enabled := True;
  end else begin
    cbParam2.Enabled := True;
    cbParam1_2.Visible := false;
    lParam2.Visible := false;
    SaveParam.Enabled := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked;
  end;

  if chbParam3.Checked then
  begin
    edParam3.Enabled := False;
    chbParamCloseOrder.Enabled := False;
    cbPeriod1.Enabled := False;
    cbPeriod2.Enabled := False;
    cbParam2_3.Visible := chbParam1.Checked or chbParam2.Checked;
    lParam3.Visible := True;
    SaveParam.Enabled := True;
  end else begin
    edParam3.Enabled := True;
    chbParamCloseOrder.Enabled := True;
    cbPeriod1.Enabled := True;
    cbPeriod2.Enabled := True;
    cbParam2_3.Visible := false;
    lParam3.Visible := false;
    SaveParam.Enabled := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked;
  end;

  if chbParam4.Checked then
  begin
    cbParam3_4.Visible := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked;
    lParam4.Visible := True;
    SaveParam.Enabled := True;
  end else begin
    cbParam3_4.Visible := false;
    lParam4.Visible := false;
    SaveParam.Enabled := chbParam1.Checked or chbParam2.Checked or chbParam3.Checked or chbParam4.Checked;
  end;

   sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0) and (ChLB_Tarif0.Count <>tarif_Checked_count);
   sbUnCheckAll_Tarifs.Enabled := tarif_Checked_count >0;
   sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;
   sbCheckAll_Account.Enabled := (CLB_Accounts0.Count > 0) and (CLB_Accounts0.Count <>fCnt0);
   sbUnCheckAll_Account.Enabled := fCnt0 >0;
   sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;
   LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(tarif_Checked_count);

end;

procedure TReportVipGroupFrm.qAccountContrAfterScroll(DataSet: TDataSet);
begin
  eLimOtkl2.Text := qAccountContr.FieldByName('DISCONNECT_LIMIT').AsString;
end;

procedure TReportVipGroupFrm.qReportAfterScroll(DataSet: TDataSet);
begin
 eLimOtkl1.Text := qReport.FieldByName('DISCONNECT_LIMIT').AsString;
end;

procedure TReportVipGroupFrm.qReportMainAfterFetch(DataSet: TCustomDADataSet);
var
 wHour, wMinute, wSecond, wMilliSeconds : Word;
begin
  DecodeTime((GetTime - tm), wHour, wMinute, wSecond, wMilliSeconds);
  LTimeSQl.Caption := 'Время выполнения запроса - ' + inttostr(wMinute) + ' мин. ' + inttostr(wSecond) + ' сек.';
  LTimeSQl.Font.Color := clBlack;
  Application.ProcessMessages;
end;

procedure TReportVipGroupFrm.qReportMainAfterOpen(DataSet: TDataSet);
var
 wHour, wMinute, wSecond, wMilliSeconds : Word;
begin
  DecodeTime((GetTime - tm), wHour, wMinute, wSecond, wMilliSeconds);
  LTimeSQl.Font.Color := clBlack;
  LTimeSQl.Caption := 'Время выполнения запроса - ' + inttostr(wMinute) + ' мин. ' + inttostr(wSecond) + ' сек.';
  MainQueryMove.Enabled := qReportMain.RecordCount > 0;
end;

procedure TReportVipGroupFrm.qReportMainAfterScroll(DataSet: TDataSet);
begin
  if needScrool then
   begin
     mainScrool := True;
     eLimOtkl0.Text := qReportMain.FieldByName('DISCONNECT_LIMIT').AsString;
     qReportMainDob.Close;
     qReportMainDob.Open;
     mainScrool := false;
   end;
end;

procedure TReportVipGroupFrm.qReportMainBeforeOpen(DataSet: TDataSet);
  var
  txt : string;
begin
  qReportMain.SQL.Clear;
  qReportMain.SQL.Text :=
  'select distinct                                                              '+#13#10+
  '      v.CONTRACT_ID,                                                         '+#13#10+
  '      V.PHONE_NUMBER_FEDERAL PHONE_NUMBER,                                   '+#13#10+
  '      V.TARIFF_ID,                                                           '+#13#10+
  '      v.contract_date,                                                       '+#13#10+
  '      v.DISCONNECT_LIMIT,                                                    '+#13#10+
  '      T.TARIFF_NAME,                                                         '+#13#10+
  '      t.MONTHLY_PAYMENT,                                                     '+#13#10+
  '     case when (NVL(T.DISCR_SPISANIE,0) = 0) and (CHECK_PHONE_DAILY_ABON_PAY(V.PHONE_NUMBER_FEDERAL,''='') = ''0'') then ''Раз в месяц'' else ''Ежедневное'' end MES_SPIS,  '+#13#10+
  '      ph.account_id,                                                         '+#13#10+
  '      case PH.PHONE_IS_ACTIVE  when 1 then ''Активен''                       '+#13#10+
  '                               else ''Блокирован'' end as status,            '+#13#10+
  '      PH.LAST_CHANGE_STATUS_DATE                                             '+#13#10+
  '  from                                                                       '+#13#10+
  '      v_contracts v,                                                         '+#13#10+
  '      tariffs t,                                                             '+#13#10+
  '      db_loader_account_phones ph,                                           '+#13#10+
  '      db_loader_bills lb,                                                    '+#13#10+
  '      IOT_BALANCE_HISTORY IO,                                                '+#13#10+
  '      ACCOUNT_VIPGROUP av,                                                   '+#13#10+
  '      TARIFS_VIPGROUP tv                                                     '+#13#10+
  ' where                                                                       '+#13#10+
  '       V.TARIFF_ID = T.TARIFF_ID                                             '+#13#10+
  '   and V.CONTRACT_CANCEL_DATE is null                                        '+#13#10+
  '   and V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER                              '+#13#10+
  '   and V.PHONE_NUMBER_FEDERAL = lb.phone_number                              '+#13#10+
  '   and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)'+#13#10+
  '   and IO.PHONE_NUMBER = lb.PHONE_NUMBER                                     '+#13#10+
  '   and IO.last_update =                                                      '+#13#10+
  '                       (                                                     '+#13#10+
  '                        select max(last_update)                              '+#13#10+
  '                          from IOT_BALANCE_HISTORY IB                        '+#13#10+
  '                         where IB.PHONE_NUMBER = lb.phone_number             '+#13#10+
  '                           and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH '+#13#10+
  '                       )                                                     '+#13#10+
  '   and ph.account_id = av.account_id                                         '+#13#10 ;
  AddParam(txt);
  qReportMain.SQL.Text := qReportMain.SQL.Text + txt;
  if fIdTarifs <> '' then
  begin
    qReportMain.SQL.Text := qReportMain.SQL.Text +
    ' and V.TARIFF_ID = tv.TARIFF_ID                                            '+#13#10;
  end;
  qReportMain.SQL.Text := qReportMain.SQL.Text + 'order by V.PHONE_NUMBER_FEDERAL';
 //   tm := GetTime;
   tm := GetTime;
    LTimeSQl.Font.Color := clRed;
    LTimeSQl.Caption := 'Время выполнения запроса - 0 мин. 0 сек.';
    Application.ProcessMessages;
    LTimeSQl.Refresh;

end;

procedure TReportVipGroupFrm.qReportMainDobBeforeOpen(DataSet: TDataSet);
  var
  txt : string;
begin
  if (not mainScrool) then
  begin
    qReportMainDob.SQL.Clear;
    qReportMainDob.SQL.Text :=
    'select lb.account_id,                                                      '+#13#10+
    '    lb.SUBSCRIBER_PAYMENT_MAIN,                                            '+#13#10+
    '    lb.bill_sum,                                                           '+#13#10+
    '    NVL(IO.BALANCE,0) BALANCE,                                             '+#13#10+
    '    IO.last_update,                                                        '+#13#10+
    '    lb.YEAR_MONTH                                                          '+#13#10+
    '  from                                                                     '+#13#10+
    '      db_loader_bills lb,                                                  '+#13#10+
    '    IOT_BALANCE_HISTORY IO                                                 '+#13#10+
    ' where lb.phone_number  = :phone_number                                    '+#13#10+
    '   and IO.PHONE_NUMBER = lb.PHONE_NUMBER                                   '+#13#10+
    '   and IO.last_update =                                                    '+#13#10+
    '        (select max(last_update) from IOT_BALANCE_HISTORY IB               '+#13#10+
    '          where IB.PHONE_NUMBER = lb.phone_number                          '+#13#10+
    '            and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH)'+#13#10;
    if chbParam3.Checked then
    begin
     txt :=
      ' and ((lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > ' +
      Format('%5d',[StrToInt(edParam3.Text)]) + ' and                            '+#13#10+
      '        lb.YEAR_MONTH between ' +
      Format('%6d',[Integer(cbPeriod1.Items.Objects[cbPeriod1.ItemIndex])]) +
      ' and ' + Format('%6d',[Integer(cbPeriod2.Items.Objects[cbPeriod2.ItemIndex])]) + ') '+#13#10;
      if chbParamCloseOrder.Checked then
      begin
        txt := txt +
        '               and NVL(IO.BALANCE,0)>=0 AND lb.bill_sum<>0                     ' +#13#10;
      end;
    end else begin
      txt := txt +
      ' and lb.DATE_LAST_UPDATED = (select max(DATE_LAST_UPDATED)                '+#13#10+
      '                               from db_loader_bills s                     '+#13#10+
      '                              where s.phone_number = lb.phone_number)    '+#13#10;

    end;
    qReportMainDob.SQL.Text := qReportMainDob.SQL.Text + txt;
    qReportMainDob.SQL.Text := qReportMainDob.SQL.Text + 'order by YEAR_MONTH';
  //  tm := GetTime;
  //  LTimeSQl.Font.Color := clRed;
  //  LTimeSQl.Caption := 'Время выполнения запроса - 0 мин. 0 сек.';
 //   Application.ProcessMessages;
 //   LTimeSQl.Refresh;
    Application.ProcessMessages;
  end;
  qReportMainDob.ParamByName('phone_number').AsString := qReportMain.FieldByName('PHONE_NUMBER').AsString;
end;

procedure TReportVipGroupFrm.AddParam(var text: String);
var
  txt : string;
begin
  txt := txt + ' and (  -- начало вставки' +  #13#10;

  if lBracket1.Visible then
    txt := txt + '      (   -- первая скобка lBracket1.Visible' +  #13#10;
  if lBracket2.Visible then
    txt := txt + '       (    -- вторая скобка lBracket2.Visible' +  #13#10;

  if chbParam1.Checked then
  begin
    txt := txt +
    '         not exists (select 1 from DB_LOADER_ACCOUNT_PHONE_HISTS -- chbParam1.Checked'+#13#10+
    '                      where PHONE_IS_ACTIVE = 0                  -- chbParam1.Checked'+#13#10 +
    '                        and end_date >= trunc(add_months(sysdate,-'  + IntToStr(cbParam1.ItemIndex + 1) + ')) -- chbParam1.Checked'+#13#10 +
    '                        and phone_number = V.PHONE_NUMBER_FEDERAL) -- chbParam1.Checked'+#13#10;

    if cbParam1_2.Visible then
      if cbParam1_2.ItemIndex = 0 then
        txt := txt + '         and  -- cbParam1_2.Visible'+#13#10
      else
        txt := txt + '         or  -- cbParam1_2.Visible'+#13#10;
  end;

  if lBracket5.Visible then
    txt := txt + '      (   -- lBracket5.Visible' +  #13#10;

  if chbParam2.Checked then
  begin
    txt := txt + '         (V.CONTRACT_DATE <= add_months(sysdate,- ' + IntToStr(cbParam2.ItemIndex + 1) + ')) -- chbParam2.Checked'+#13#10;
  end;
  if lBracket3.Visible then
    txt := txt + '       )  -- lBracket3.Visible' +  #13#10;

  if cbParam2_3.Visible then
    if cbParam2_3.ItemIndex = 0 then
      txt := txt + '        and  -- cbParam2_3.Visible'+#13#10
    else
      txt := txt + '        or   -- cbParam2_3.Visible'+#13#10;

  if chbParam3.Checked then
  begin
    txt := txt +
    '         (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) > ' + Format('%5d',[StrToInt(edParam3.Text)]) + ' -- chbParam3.Checked' + #13#10+
    '         and lb.YEAR_MONTH between ' + Format('%6d',[Integer(cbPeriod1.Items.Objects[cbPeriod1.ItemIndex])]) +
    ' and ' + Format('%6d',[Integer(cbPeriod2.Items.Objects[cbPeriod2.ItemIndex])]) + ' -- chbParam3.Checked' + #13#10;
    if chbParamCloseOrder.Checked then
    begin
      txt := txt +
      '         and NVL(IO.BALANCE,0) >= 0 AND lb.bill_sum <> 0 -- chbParam3.Checked' +#13#10;
    end;
  end;

  if lBracket4.Visible then
    txt := txt + '      ) -- lBracket4.Visible' +  #13#10;

  if cbParam3_4.Visible then
    if cbParam3_4.ItemIndex = 0 then
      txt := txt + '       and -- cbParam3_4.Visible'+#13#10
    else
      txt := txt + '       or -- cbParam3_4.Visible'+#13#10;

  if chbParam4.Checked then
  begin
      txt := txt + '       NVL(T.DISCR_SPISANIE,0) = 0 and --- chbParam4.Checked' +#13#10+
                   '       CHECK_PHONE_DAILY_ABON_PAY(V.PHONE_NUMBER_FEDERAL,''='') = 0  --- chbParam4.Checked'+#13#10;
  end;
  txt := txt + '     )  -- конец вставки' +  #13#10;
  text := text + txt;
end;

procedure TReportVipGroupFrm.qTarifsMainAfterOpen(DataSet: TDataSet);
var
  i : Integer;
 wHour, wMinute, wSecond, wMilliSeconds : Word;
begin
  DecodeTime((GetTime - tm), wHour, wMinute, wSecond, wMilliSeconds);
  LTimeSQl.Caption := 'Время выполнения запроса - ' + inttostr(wMinute) + ' мин. ' + inttostr(wSecond) + ' сек.';
  LTimeSQl.Font.Color := clBlack;
  Application.ProcessMessages;

  i := 0;
  qTarifsMain.first;
  ChLB_Tarif0.Items.Clear;
  sbCheckAll_Tarifs.Enabled := False;
  sbUnCheckAll_Tarifs.Enabled := False;
  sbCheckSelected_Tarifs.Enabled := False;
  sbCheckSelTarifs.Enabled := False;
  while not qTarifsMain.eof do
  begin
    ChLB_Tarif0.Items.AddObject(qTarifsMain.fieldByName('TARIFF_NAME_CODE').asString, Pointer(qTarifsMain.fieldByName('TARIFF_ID').asInteger));
    qTarifsMain.Next;
    inc(i);
  end;
  LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено 0';
  sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0);
  sbCheckSelTarifs.Enabled := (ChLB_Tarif0.Count > 0);

end;

procedure TReportVipGroupFrm.qTarifsMainBeforeOpen(DataSet: TDataSet);
var
  txt : string;
begin
  qTarifsMain.SQL.Clear;
  qTarifsMain.SQL.Text :=
  'select distinct                                                              '+#13#10+
  '      T.TARIFF_NAME,                                                         '+#13#10+
  '      T.TARIFF_NAME ||'' (''|| T.TARIFF_CODE||'')'' TARIFF_NAME_CODE,        '+#13#10+
  '      T.TARIFF_ID                                                            '+#13#10+
  '  from                                                                       '+#13#10+
  '      v_contracts v,                                                         '+#13#10+
  '      tariffs t,                                                             '+#13#10+

  '      db_loader_account_phones ph,                                           '+#13#10+
  '      db_loader_bills lb,                                                    '+#13#10+
  '      IOT_BALANCE_HISTORY IO,                                                '+#13#10+
  '      ACCOUNT_VIPGROUP av                                                    '+#13#10+
  ' where                                                                       '+#13#10+
  '       V.TARIFF_ID = T.TARIFF_ID                                             '+#13#10+
  '   and V.CONTRACT_CANCEL_DATE is null                                        '+#13#10+
  '   and V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER                              '+#13#10+
  '   and V.PHONE_NUMBER_FEDERAL = lb.phone_number                              '+#13#10+
  '   and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)'+#13#10+
  '   and IO.PHONE_NUMBER = lb.PHONE_NUMBER                                     '+#13#10+
  '   and IO.last_update =                                                      '+#13#10+
  '      (select max(last_update)                                               '+#13#10+
  '          from IOT_BALANCE_HISTORY IB                                        '+#13#10+
  '         where IB.PHONE_NUMBER = lb.phone_number                             '+#13#10+
  '           and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH)   '+#13#10+
  '  and ph.account_id = av.account_id                                          '+#13#10 ;
   AddParam(txt);
  qTarifsMain.SQL.Text := qTarifsMain.SQL.Text + txt;

  qTarifsMain.SQL.Text := qTarifsMain.SQL.Text + 'order by T.TARIFF_NAME';
  tm := GetTime;
    LTimeSQl.Font.Color := clRed;
    LTimeSQl.Caption := 'Время выполнения запроса - 0 мин. 0 сек.';
    Application.ProcessMessages;
    LTimeSQl.Refresh;
    Application.ProcessMessages;

end;

procedure TReportVipGroupFrm.qTS3AfterScroll(DataSet: TDataSet);
begin
  eLimOtkl3.Text := qTS3.FieldByName('DISCONNECT_LIMIT').AsString;
end;

procedure TReportVipGroupFrm.sbCheckAll_AccountClick(Sender: TObject);
var
  i,r: Integer;
begin
  Accounts_changeDone := False;
  r := 0;
  for i := 0 to CLB_Accounts0.Items.Count - 1 do
  begin
    CLB_Accounts0.checked[i] := True;
    inc(r);
  end;
  Accounts_changeDone := True;
  CLB_Accounts0ClickCheck(Sender);
  sbUnCheckAll_Account.Enabled := True;
  sbCheckAll_Account.Enabled := false;
  LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено ' + IntToStr(r);

end;

procedure TReportVipGroupFrm.sbCheckAll_TarifsClick(Sender: TObject);
var
  i,r: Integer;
begin
 r := 0;
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
  begin
    ChLB_Tarif0.checked[i] := True;
    Inc(r);
  end;
  sbUnCheckAll_Tarifs.Enabled := True;
  sbCheckAll_Tarifs.Enabled := false;
  LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(r);

end;

procedure TReportVipGroupFrm.sbCheckSelAccountClick(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seAccountSearch.Text) = '' then
    Exit;
  LockWindowUpdate(CLB_Accounts0.Handle);
  for i := 0 to CLB_Accounts0.Items.Count - 1 do
  begin
    txt := UpperCase(CLB_Accounts0.Items.Strings[i]);
    txt2 := UpperCase(Trim(seAccountSearch.Text));
    if AnsiContainsText(txt,txt2) then
      CLB_Accounts0.Selected[i] := True
    else
      CLB_Accounts0.Selected[i] := false;
  end;
  sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;
  LockWindowUpdate(0);
  LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено ' + IntToStr(fCnt0);
end;

procedure TReportVipGroupFrm.sbCheckSelected_AccountClick(Sender: TObject);
var
  i: Integer;
begin
  fCnt0 := 0;
  Accounts_changeDone := False;
  for i := 0 to CLB_Accounts0.Items.Count - 1 do
  begin
    if CLB_Accounts0.Selected[i] then
    begin
      CLB_Accounts0.checked[i] := True;
      inc(fCnt0);
    end
    else
      CLB_Accounts0.checked[i] := false;
  end;
  Accounts_changeDone := True;;
  CLB_Accounts0ClickCheck(Sender);
  LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено ' + IntToStr(fCnt0);

   sbCheckAll_Account.Enabled := (CLB_Accounts0.Count > 0) and (CLB_Accounts0.Count <>fCnt0);
   sbUnCheckAll_Account.Enabled := fCnt0 >0;
   sbCheckSelected_Account.Enabled := CLB_Accounts0.SelCount > 0;

end;

procedure TReportVipGroupFrm.sbCheckSelected_TarifsClick(Sender: TObject);
var
  i: Integer;
begin
 tarif_Checked_count := 0;
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
  begin
    if ChLB_Tarif0.Selected[i] then
    begin
      ChLB_Tarif0.checked[i] := True;
      inc(tarif_Checked_count);
    end
    else
      ChLB_Tarif0.checked[i] := false;
  end;
  LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(tarif_Checked_count);
   sbCheckAll_Tarifs.Enabled := (ChLB_Tarif0.Count > 0) and (ChLB_Tarif0.Count <>tarif_Checked_count);
   sbUnCheckAll_Tarifs.Enabled := tarif_Checked_count >0;
   sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;

end;

procedure TReportVipGroupFrm.sbCheckSelTarifsClick(Sender: TObject);
var
 i : Integer;
 txt, txt2 : string;
begin
  inherited;
  if Trim(seTarifsSearch.Text) = '' then
    Exit;
  LockWindowUpdate(ChLB_Tarif0.Handle);
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
  begin
    txt := UpperCase(ChLB_Tarif0.Items.Strings[i]);
    txt2 := UpperCase(Trim(seTarifsSearch.Text));
    if AnsiContainsText(txt,txt2) then
      ChLB_Tarif0.Selected[i] := True
    else
      ChLB_Tarif0.Selected[i] := false;
  end;
  sbCheckSelected_Tarifs.Enabled := ChLB_Tarif0.SelCount > 0;
  LockWindowUpdate(0);
  LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено ' + IntToStr(tarif_Checked_count);

end;

procedure TReportVipGroupFrm.sbFirstClick(Sender: TObject);
begin
  needScrool := false;
  qReportMain.First;
  needScrool := true;
end;

procedure TReportVipGroupFrm.sbLastClick(Sender: TObject);
begin
  needScrool := false;
  qReportMain.Last;
  needScrool := true;
  qReportMainDob.close;
  qReportMainDob.Open;
end;

procedure TReportVipGroupFrm.sbMoveNextClick(Sender: TObject);
begin
  qReportMain.MoveBy(100);
end;

procedure TReportVipGroupFrm.sbMovePriorClick(Sender: TObject);
begin
   qReportMain.MoveBy(-100);
end;

procedure TReportVipGroupFrm.sbNextClick(Sender: TObject);
begin
  qReportMain.Next;
end;

procedure TReportVipGroupFrm.sbPriorClick(Sender: TObject);
begin
  qReportMain.Prior;
end;

procedure TReportVipGroupFrm.sbUnCheckAll_AccountClick(Sender: TObject);
var
  i: Integer;
begin
  Accounts_changeDone := False;
  for i := 0 to CLB_Accounts0.Items.Count - 1 do
    CLB_Accounts0.checked[i] := false;
  sbUnCheckAll_Account.Enabled := True;
  sbCheckAll_Account.Enabled := false;
  Accounts_changeDone := true;
  CLB_Accounts0ClickCheck(Sender);
  LAccounts_cnt.Caption := 'Лицевые счета: всего '+ IntToStr(CLB_Accounts0.Count) + '; выделено ' + IntToStr(CLB_Accounts0.SelCount) + '; отмечено 0';

end;

procedure TReportVipGroupFrm.sbUnCheckAll_TarifsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ChLB_Tarif0.Items.Count - 1 do
    ChLB_Tarif0.checked[i] := false;
  sbUnCheckAll_Tarifs.Enabled := false;
  sbCheckAll_Tarifs.Enabled := true;
  LTarifs_cnt.Caption := 'Тарифы: всего '+ IntToStr(ChLB_Tarif0.Count) + '; выделено ' + IntToStr(ChLB_Tarif0.SelCount) + '; отмечено 0';
end;

procedure TReportVipGroupFrm.SetAccountIDList(ch: TsCheckListBox; var AccIdStr, AccountIdStr: string; var Cnt : Integer);
var
  i : integer;
begin
  if AccIdStr <> '-1' then
  begin
    AccIdStr := '';
    AccountIdStr := '';
    Cnt := 0;
  end;
  if ch.Items.Count > 0 then
  begin
      for i := 0 to ch.Items.Count - 1 do
        if ch.Checked[i] then
        begin
          AccIdStr := AccIdStr+IntToStr(Integer(ch.Items.Objects[i]))+',';
          AccountIdStr := AccountIdStr + ch.Items[i]+',';
          Inc(Cnt);
        end;
    AccIdStr := copy(AccIdStr, 1, Length(AccIdStr)-1);
    AccountIdStr := copy(AccountIdStr, 1, Length(AccountIdStr)-1);
  end;
end;

procedure TReportVipGroupFrm.SetVarParams(ch: TsCheckListBox; var AccIdStr,
  AccountIdStr: string);
begin

end;

procedure TReportVipGroupFrm.ts2lAccountClickCheck(Sender: TObject);
begin
  SetVarParams(ts2lAccount, FAccid2, FAccount2);
end;

procedure TReportVipGroupFrm.ts2lAccountExit(Sender: TObject);
begin
  SetAccountIDList(ts2lAccount, FAccid2, FAccount2, fCnt2);
end;

procedure TReportVipGroupFrm.ts3lAccountClickCheck(Sender: TObject);
begin
  SetVarParams(ts3lAccount, FAccid3, FAccount3);
end;

procedure TReportVipGroupFrm.ts3lAccountExit(Sender: TObject);
begin
  SetAccountIDList(ts3lAccount, FAccid3, FAccount3, fCnt3);
end;

procedure TReportVipGroupFrm.aLoadInExcelExecute(Sender: TObject);
begin
  ExportToExcel('Отчет по номерам %TITLE%, которые не были в блоке '+cbPeriod.Items[cbPeriod.ItemIndex]+' и более месяцев на дату %DATE%',
                ts1dbgrd1, FAccid, Faccount);
end;

procedure TReportVipGroupFrm.aRefreshExecute(Sender: TObject);
var
 sql_text : string;
begin
  inherited;
  if FAccid = '' then
  begin
    if fShowOne = 1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne := 1;
    exit;
  end;
  qTarifs_R.Close;
  with qTarifs_R  do
  begin
    try
      sql.Clear;
      sql_text:='select distinct T.TARIFF_NAME,'+#13#10+
                'T.TARIFF_NAME ||'' (''|| T.TARIFF_CODE||'')'' TARIFF_NAME_CODE,'+#13#10+
                't.TARIFF_ID'+#13#10+
                ' from tariffs t, '+#13#10+
                '       v_contracts v, '+#13#10+
                '       db_loader_account_phones ph,'+#13#10+
                '       (select* from ( '+#13#10+
                '                        select '+#13#10+
                '                              phone_number, '+#13#10+
                '                              max(end_date) as max_date '+#13#10+
                '                        from '+#13#10+
                '                          DB_LOADER_ACCOUNT_PHONE_HISTS '+#13#10+
                '                       where '+#13#10+
                '                          PHONE_IS_ACTIVE = 0 '+#13#10+
                '                        group by phone_number '+#13#10+
                '                       ) '+#13#10+
                '                  where '+#13#10+
                '                    trunc(max_date) <= trunc(add_months(sysdate,-:period))) d '+#13#10+
                ' where  V.TARIFF_ID = T.TARIFF_ID '+#13#10+
                ' and d.phone_number = PH.PHONE_NUMBER '+#13#10+
                ' and V.PHONE_NUMBER_FEDERAL = d.phone_number '+#13#10+
                ' and V.CONTRACT_CANCEL_DATE is null '+#13#10+
                ' and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones   ) '+#13#10;
      if FAccid <> '-1'  then
      begin
        if (fCnt1 = 1 )then
          sql_text := sql_text+' and ph.account_id = '+FAccid
        else
          sql_text := sql_text+' and ph.account_id in ('+FAccid+') ';
      end;
      sql_text := sql_text+ ' order by TARIFF_NAME';
      sql.Add(sql_Text);
      ParamByName('period').AsString := cbPeriod.Items[cbPeriod.ItemIndex];
      Open;
    except
      on e : exception do
        MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;
  end;
  qTarifs_R.first;
  ChLB_Tarif.Items.Clear;
  while not qTarifs_R.eof do
  begin
    ChLB_Tarif.Items.AddObject(qTarifs_R.fieldByName('TARIFF_NAME_CODE').asString, Pointer(qTarifs_R.fieldByName('TARIFF_ID').asInteger));
    qTarifs_R.Next;
  end;

  qReport.Close;
  with qReport do
  begin
    try
      sql.Clear;
      sql_text:=' select v.CONTRACT_ID,'+#13#10+
                '        d.phone_number, '+#13#10+
                '        T.TARIFF_NAME, '+#13#10+
                '        t.TARIFF_ID, '+#13#10+
                '        v.contract_date, '+#13#10+
                '        v.DISCONNECT_LIMIT, '+#13#10+
                '        ph.account_id, '+#13#10+
                '        PH.YEAR_MONTH, '+#13#10+
                '        d.max_date '+#13#10+
                '        ,v.DISCONNECT_LIMIT '+#13#10+
                ' from tariffs t, '+#13#10+
                '       v_contracts v, '+#13#10+
                '       db_loader_account_phones ph,'+#13#10+
                '       (select* from ( '+#13#10+
                '                        select '+#13#10+
                '                              phone_number, '+#13#10+
                '                              max(end_date) as max_date '+#13#10+
                '                        from '+#13#10+
                '                          DB_LOADER_ACCOUNT_PHONE_HISTS '+#13#10+
                '                       where '+#13#10+
                '                          PHONE_IS_ACTIVE = 0 '+#13#10+
                '                        group by phone_number '+#13#10+
                '                       ) '+#13#10+
                '                  where '+#13#10+
                '                    trunc(max_date) <= trunc(add_months(sysdate,-:period))) d '+#13#10+
                ' where  V.TARIFF_ID = T.TARIFF_ID '+#13#10+
                ' and d.phone_number = PH.PHONE_NUMBER '+#13#10+
                ' and V.PHONE_NUMBER_FEDERAL = d.phone_number '+#13#10+
                ' and V.CONTRACT_CANCEL_DATE is null '+#13#10+
                ' and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones   ) '+#13#10;
      if FAccid <> '-1'  then
      begin
        if (fCnt1 = 1 )then
          sql_text := sql_text+' and ph.account_id = '+FAccid
        else
          sql_text := sql_text+' and ph.account_id in ('+FAccid+') ';
      end;
      sql_text := sql_text+' order by phone_number';
      sql.Add(sql_Text);
      ParamByName('period').AsString := cbPeriod.Items[cbPeriod.ItemIndex];
      Open;
    except
      on e : exception do
        MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TReportVipGroupFrm.aRefresh2Execute(Sender: TObject);
var
 sql_text : string;
begin
  inherited;
  if FAccid2='' then
  begin
    if fShowOne = 1 then
      MessageDlg('Не выбрано ни одного лицевого счета', mtError, [mbOK], 0);
    fShowOne := 1;
    exit;
  end;

  qTarifs_A.Close;
  with qTarifs_A do
   begin
     try
       sql.Clear;
       sql_text:='select distinct T.TARIFF_NAME, '+#13#10+
            'T.TARIFF_NAME ||'' (''|| T.TARIFF_CODE||'')'' TARIFF_NAME_CODE,'+#13#10+
            't.TARIFF_ID '+#13#10+
            'from tariffs t,(select distinct V.TARIFF_ID from v_contracts v'+#13#10+
            '                left join (select  dl.PHONE_IS_ACTIVE,'+#13#10+
            '                                    dl.LAST_CHANGE_STATUS_DATE,'+#13#10+
            '                                    dl.PHONE_NUMBER '+#13#10+
            '                              from db_loader_account_phones dl'+#13#10+
            '                             where dl.last_check_date_time =(select max(m.last_check_date_time)'+#13#10+
            '                                                              from DB_LOADER_ACCOUNT_PHONES m'+#13#10+
            '                                                             where m.phone_number = dl.phone_number'+#13#10+
            '                                                               and m.year_month = to_char(sysdate,''YYYYMM'')))ph'+#13#10+
            '                    on  V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER '+#13#10+
            '                   where V.CONTRACT_DATE <= add_months(sysdate,-:period2)'+#13#10;
       if FAccid2<>'-1'  then
         sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL) in ('+FAccid2+') '
       else
         sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL)  in '+
                            '         (select ACCOUNT_ID from ACCOUNTS where ACCOUNT_ID <> 225)';

       sql_text:=sql_text+ '                   and V.CONTRACT_CANCEL_DATE is null) r'+#13#10+
                           '  where r.TARIFF_ID = T.TARIFF_ID '+#13#10;
        sql_text := sql_text+ ' order by TARIFF_NAME';
        sql.Add(sql_Text);
       ParamByName('period2').AsString := ts2cbPeriod.Items[ts2cbPeriod.ItemIndex];
       Open;
     except
       on e : exception do
         MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
     end;
   end;
  qTarifs_A.first;
  ChLB_Tarif2.Items.Clear;
  while not qTarifs_A.eof do
  begin
    ChLB_Tarif2.Items.AddObject(qTarifs_A.fieldByName('TARIFF_NAME_CODE').asString, Pointer(qTarifs_A.fieldByName('TARIFF_ID').asInteger));
    qTarifs_A.Next;
  end;

  qAccountContr.Close;
  with qAccountContr do
   begin
     try
       sql.Clear;
       sql_text:='select  v.CONTRACT_ID,'+#13#10+
                 '  V.PHONE_NUMBER_FEDERAL PHONE_NUMBER, '+#13#10+
                 '  T.TARIFF_ID, '+#13#10+
                 '  T.TARIFF_NAME, '+#13#10+
                 '  v.contract_date, '+#13#10+
                 '  v.DISCONNECT_LIMIT, '+#13#10+
                 '  case PH.PHONE_IS_ACTIVE '+#13#10+
                 '   when 1 then ''Активен'' '+#13#10+
                 '  else '+#13#10+
                 '   ''Блокирован'' '+#13#10+
                 '  end as status, '+#13#10+
                 '  PH.LAST_CHANGE_STATUS_DATE '+#13#10+
                 '  ,v.DISCONNECT_LIMIT '+#13#10+
                 ' from '+#13#10+
                 '   v_contracts v '+#13#10+
                 '     left join tariffs t '+#13#10+
                 '             on V.TARIFF_ID  =   T.TARIFF_ID '+#13#10+
                 '     left join '+#13#10+
                 '               (select  dl.PHONE_IS_ACTIVE, '+#13#10+
                 '                        dl.LAST_CHANGE_STATUS_DATE, '+#13#10+
                 '                        dl.PHONE_NUMBER '+#13#10+
                 '                        from '+#13#10+
                 '                         db_loader_account_phones dl '+#13#10+
                 '                        where '+#13#10+
                 '                         dl.last_check_date_time =(select max(m.last_check_date_time) '+#13#10+
                 '                                                       from DB_LOADER_ACCOUNT_PHONES m '+#13#10+
                 '                                                       where m.phone_number = dl.phone_number and m.year_month=to_char(sysdate,''YYYYMM'') '+#13#10+
                 '                                                  ) '+#13#10+
                 '             )ph '+#13#10+
                 '             on  V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER '+#13#10+
                 ' where '+#13#10+
                 '  V.CONTRACT_DATE <= add_months(sysdate,-:period2) '+#13#10+
                 '  and V.CONTRACT_CANCEL_DATE is null ';

       if FAccid2<>'-1'  then
         sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL) in ('+FAccid2+') '
       else
         sql_text:=sql_text+' and GET_ACCOUNT_ID_BY_PHONE (V.PHONE_NUMBER_FEDERAL)  in '+
                            '         (select ACCOUNT_ID from ACCOUNTS where ACCOUNT_ID <> 225)';

       sql_text := sql_text + #13#10+ ' order by PHONE_NUMBER_FEDERAL';
       sql.Add(sql_Text);
       ParamByName('period2').AsString := ts2cbPeriod.Items[ts2cbPeriod.ItemIndex];
       Open;
     except
       on e : exception do
         MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
     end;
   end;
end;

procedure TReportVipGroupFrm.aLimitOkl1Execute(Sender: TObject);
begin
  qSetDISCONNECT_LIMIT.ParamByName('DISCONNECT_LIMIT').AsFloat :=  StrToFloatDef(eLimOtkl1.Text,100);
  qSetDISCONNECT_LIMIT.ParamByName('CONTRACT_ID').AsInteger := qReport.FieldByName('CONTRACT_ID').AsInteger;
  qSetDISCONNECT_LIMIT.Execute;
  qReport.RefreshRecord;
end;

procedure TReportVipGroupFrm.aLimitOkl2Execute(Sender: TObject);
begin
  qSetDISCONNECT_LIMIT.ParamByName('DISCONNECT_LIMIT').AsFloat :=  StrToFloatDef(eLimOtkl2.Text,100);
  qSetDISCONNECT_LIMIT.ParamByName('CONTRACT_ID').AsInteger := qAccountContr.FieldByName('CONTRACT_ID').AsInteger;
  qSetDISCONNECT_LIMIT.Execute;
  qAccountContr.RefreshRecord;

end;

procedure TReportVipGroupFrm.aLimitOkl3Execute(Sender: TObject);
begin
  qSetDISCONNECT_LIMIT.ParamByName('DISCONNECT_LIMIT').AsFloat :=  StrToFloatDef(eLimOtkl3.Text,100);
  qSetDISCONNECT_LIMIT.ParamByName('CONTRACT_ID').AsInteger := qTS3.FieldByName('CONTRACT_ID').AsInteger;
  qSetDISCONNECT_LIMIT.Execute;
  qTS3.RefreshRecord;

end;

procedure TReportVipGroupFrm.aLoadInExcel2Execute(Sender: TObject);
begin
  ExportToExcel('Отчет по номерам билайн %TITLE%, на которые заведены договоры '+ts2cbPeriod.Items[ts2cbPeriod.ItemIndex]+' и более месяцев на дату %DATE%',
                ts2dbgrd, FAccid2, Faccount2);
end;
end.
