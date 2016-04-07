unit ShowGroupStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, CRGrid, DB,
  MemDS, DBAccess, Ora, Menus, ActnList, frxClass, frxExportPDF, frxDBSet,
  frxGradient,dateutils,strutils, Vcl.Imaging.jpeg, acImage, Vcl.ExtDlgs,
VirtualTable,SyncObjs, Math,oraclasses, idSMTP, idMessage, IdAttachmentFile, Vcl.Oleauto,
  Vcl.DBCtrls,wslider, Vcl.Mask;


type

 ThreadSMTP = class(TThread)
     SMTP_FROMTXT,SMTP_SRV,SMTP_LOG,SMTP_PASS,SMTP_ADDR,SMTP_TITLE:string;
     SMTP_ATT_FILE:String;
     //SMTP_ATT_FILE:TMemoryStream;

  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  TShowGroupStatForm = class(TForm)
    Panel1: TPanel;
    btnClose: TBitBtn;
    PageControl1: TPageControl;
    tsGroup: TTabSheet;
    tsPayments: TTabSheet;
    Panel2: TPanel;
    grGroup: TCRDBGrid;
    qContractGroup: TOraQuery;
    dsContractGroup: TDataSource;
    Label1: TLabel;
    lBalance: TLabel;
    lGroup: TLabel;
    qGroupBalance: TOraQuery;
    qContractGroupCONTRACT_NUM: TFloatField;
    qContractGroupPHONE_NUMBER_FEDERAL: TStringField;
    qContractGroupCONTRACT_ID: TFloatField;
    PageControl2: TPageControl;
    tsPaymentsReal: TTabSheet;
    Panel3: TPanel;
    grPayments: TCRDBGrid;
    qPayments: TOraQuery;
    dsPayments: TDataSource;
    btAdd: TBitBtn;
    btRemove: TBitBtn;
    ActionList1: TActionList;
    aAddContract: TAction;
    aRemoveContract: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    EditContractGroup: TOraStoredProc;
    qGroups: TOraQuery;
    btInfoAbonent: TBitBtn;
    aInfoAbonent: TAction;
    N3: TMenuItem;
    qContractGroupACCOUNT_NUMBER: TFloatField;
    tsBills: TTabSheet;
    Panel4: TPanel;
    grBills: TCRDBGrid;
    dsBills: TDataSource;
    qBills: TOraQuery;
    qBillsYEAR_MONTH: TFloatField;
    qBillsBILL_SUM_NEW: TFloatField;
    Splitter1: TSplitter;
    grBillsDetail: TCRDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    qBillsDetail: TOraQuery;
    dsBillsDetail: TDataSource;
    btPaymentsInExcel: TBitBtn;
    btBillsInExcel: TBitBtn;
    btExport: TBitBtn;
    cbPeriod: TComboBox;
    Label2: TLabel;
    SavePdf: TSaveDialog;
    dsAbonPeriodList: TfrxDBDataset;
    dsOptsHistory: TfrxDBDataset;
    dsBillsFrx: TfrxDBDataset;
    qOptsHistory: TOraQuery;
    qAbonPeriodList: TOraQuery;
    qBillsFrx: TOraQuery;
    dsBillMnRouming: TfrxDBDataset;
    qBillMnRouming: TOraQuery;
    qPeriods: TOraQuery;
    frxPDFExport1: TfrxPDFExport;
    frxReport1: TfrxReport;
    qTitle: TOraQuery;
    dsTitle: TfrxDBDataset;
    Label3: TLabel;
    Edit_Bill: TEdit;
    tsParams: TTabSheet;
    sgParamsContacts: TStringGrid;
    mParamsBankDet: TMemo;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Panel7: TPanel;
    Panel8: TPanel;
    pPaymentsToolBar: TPanel;
    qGroupParams: TOraQuery;
    btPostParams: TBitBtn;
    EditGroupParams: TOraStoredProc;
    aPostParams: TAction;
    BitBtn1: TBitBtn;
    aRefreshParams: TAction;
    ImageLogo: TsImage;
    Panel10: TPanel;
    tsBillsBeeline: TTabSheet;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Splitter2: TSplitter;
    Panel14: TPanel;
    grBillsBeeline: TCRDBGrid;
    grBillsBeelineDetail: TCRDBGrid;
    qBillsBeeline: TOraQuery;
    qBillsBeelineDetail: TOraQuery;
    dsBillsBeeline: TDataSource;
    dsBillsBeelineDetail: TDataSource;
    btBillsBeelineInExcel: TBitBtn;
    qBillsBeelineYEAR_MONTH: TFloatField;
    qBillsBeelineBILL_SUM_NDS: TFloatField;
    qBillsBeelineBILL_SUM: TFloatField;
    qBillsBeelineABONKA: TFloatField;
    qBillsBeelineCALLS: TFloatField;
    qBillsBeelineDISCOUNTS: TFloatField;
    qBillsBeelineSINGLE_PAYMENTS: TFloatField;
    qBillsBeelineABON_MAIN: TFloatField;
    qBillsBeelineABON_ADD: TFloatField;
    qBillsBeelineABON_OTHER: TFloatField;
    qBillsBeelineDISCOUNT_YEAR: TFloatField;
    qBillsBeelineDISCOUNT_SMS_PLUS: TFloatField;
    qBillsBeelineDISCOUNT_CALL: TFloatField;
    qBillsBeelineDISCOUNT_COUNT_ON_PHONES: TFloatField;
    qBillsBeelineDISCOUNT_OTHERS: TFloatField;
    qBillsBeelineSINGLE_MAIN: TFloatField;
    qBillsBeelineSINGLE_ADD: TFloatField;
    qBillsBeelineSINGLE_TURN_ON_SERV: TFloatField;
    qBillsBeelineSINGLE_CORRECTION_ROUMING: TFloatField;
    qBillsBeelineSINGLE_CHANGE_TARIFF: TFloatField;
    qBillsBeelineSINGLE_INTRA_WEB: TFloatField;
    qBillsBeelineSINGLE_VIEW_BLACK_LIST: TFloatField;
    qBillsBeelineSINGLE_PENALTI: TFloatField;
    qBillsBeelineSINGLE_OTHER: TFloatField;
    qBillsBeelineCALLS_COUNTRY: TFloatField;
    qBillsBeelineCALLS_SITY: TFloatField;
    qBillsBeelineCALLS_LOCAL: TFloatField;
    qBillsBeelineCALLS_SMS_MMS: TFloatField;
    qBillsBeelineCALLS_GPRS: TFloatField;
    qBillsBeelineCALLS_RUS_RPP: TFloatField;
    qBillsBeelineCALLS_ALL: TFloatField;
    qBillsBeelineROUMING_NATIONAL: TFloatField;
    qBillsBeelineROUMING_INTERNATIONAL: TFloatField;

    qBillsBeelineDetailPHONE_NUMBER: TStringField;
    qBillsBeelineDetailBILL_SUM_NDS: TFloatField;
    qBillsBeelineDetailBILL_SUM: TFloatField;
    qBillsBeelineDetailABONKA: TFloatField;
    qBillsBeelineDetailCALLS: TFloatField;
    qBillsBeelineDetailDISCOUNTS: TFloatField;
    qBillsBeelineDetailSINGLE_PAYMENTS: TFloatField;
    qBillsBeelineDetailABON_MAIN: TFloatField;
    qBillsBeelineDetailABON_ADD: TFloatField;
    qBillsBeelineDetailABON_OTHER: TFloatField;
    qBillsBeelineDetailDISCOUNT_YEAR: TFloatField;
    qBillsBeelineDetailDISCOUNT_SMS_PLUS: TFloatField;
    qBillsBeelineDetailDISCOUNT_CALL: TFloatField;
    qBillsBeelineDetailDISCOUNT_COUNT_ON_PHONES: TFloatField;
    qBillsBeelineDetailDISCOUNT_OTHERS: TFloatField;
    qBillsBeelineDetailSINGLE_MAIN: TFloatField;
    qBillsBeelineDetailSINGLE_ADD: TFloatField;
    qBillsBeelineDetailSINGLE_TURN_ON_SERV: TFloatField;
    qBillsBeelineDetailSINGLE_CORRECTION_ROUMING: TFloatField;
    qBillsBeelineDetailSINGLE_CHANGE_TARIFF: TFloatField;
    qBillsBeelineDetailSINGLE_INTRA_WEB: TFloatField;
    qBillsBeelineDetailSINGLE_VIEW_BLACK_LIST: TFloatField;
    qBillsBeelineDetailSINGLE_PENALTI: TFloatField;
    qBillsBeelineDetailSINGLE_OTHER: TFloatField;
    qBillsBeelineDetailCALLS_COUNTRY: TFloatField;
    qBillsBeelineDetailCALLS_SITY: TFloatField;
    qBillsBeelineDetailCALLS_LOCAL: TFloatField;
    qBillsBeelineDetailCALLS_SMS_MMS: TFloatField;
    qBillsBeelineDetailCALLS_GPRS: TFloatField;
    qBillsBeelineDetailCALLS_RUS_RPP: TFloatField;
    qBillsBeelineDetailCALLS_ALL: TFloatField;
    qBillsBeelineDetailROUMING_NATIONAL: TFloatField;
    qBillsBeelineDetailROUMING_INTERNATIONAL: TFloatField;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    OpenImage: TOpenPictureDialog;
    btnAdd: TBitBtn;
    tsDetail: TTabSheet;
    Panel9: TPanel;
    Splitter3: TSplitter;
    Panel15: TPanel;
    dsDetail: TDataSource;
    vtDetailFile: TVirtualTable;
    vtDetailFileSELF_NUMBER: TStringField;
    vtDetailFileSERVICE_DATE: TDateField;
    vtDetailFileSERVICE_TIME: TTimeField;
    vtDetailFileSERVICE_TYPE: TStringField;
    vtDetailFileSERVICE_DIRECTION: TStringField;
    vtDetailFileOTHER_NUMBER: TStringField;
    vtDetailFileDURATION: TFloatField;
    vtDetailFileDURATION_MIN: TIntegerField;
    vtDetailFileSERVICE_COST: TFloatField;
    vtDetailFileIS_ROAMING: TStringField;
    vtDetailFileROAMING_ZONE: TStringField;
    vtDetailFileADD_INFO: TStringField;
    vtDetailFileBASE_STATION_CODE: TStringField;
    vtDetailFileCOST_NO_VAT: TFloatField;
    vtDetailFileBS_PLACE: TStringField;
    dbgDetail: TCRDBGrid;
    CRDBGrid1: TCRDBGrid;
    dsDetPeriods: TDataSource;
    qDetPeriods: TOraQuery;
    btDetailSendMail: TBitBtn;
    spGetPhoneBillDetail: TOraStoredProc;
    mDetailText: TMemo;
    qServiceCodes: TOraQuery;
    qBaseZone: TOraQuery;
    btDetailRefresh: TBitBtn;
    send_mail_detail: TOraStoredProc;
    PanelProcess: TPanel;
    pbProcess: TProgressBar;
    lblProcess: TLabel;
    btDetailSendExcel: TBitBtn;
    qSendMailParams: TOraQuery;
    cbPhoneNumber: TComboBox;
    Label7: TLabel;
    btExportGroupListExcel: TBitBtn;
    grpDopParams: TGroupBox;
    Label6: TLabel;
    lbl1: TLabel;
    NewDateEnd: TMaskEdit;
    chkUssd_bal: TCheckBox;
    eParamsDetMail: TEdit;
    chkHand_block: TCheckBox;
    lbl2: TLabel;
    Hand_block_summ: TMaskEdit;
    qContractGroupBALANCE: TFloatField;
    qContractGroupIS_ACTIVE: TStringField;
    qContractGroupDOP_STATUS: TStringField;
    qContractGroupDISCONNECT_LIMIT: TFloatField;
    qContractGroupCREDIT: TStringField;
    qContractGroupIS_CREDIT_CONTRACT: TIntegerField;
    qContractGroupTARIFF_NAME: TStringField;
    qBillMgRouming: TOraQuery;
    dsBillMgRouming: TfrxDBDataset;


    procedure tsGroupShow(Sender: TObject);
    procedure tsPaymentsShow(Sender: TObject);
    procedure aAddContractExecute(Sender: TObject);
    procedure aRemoveContractExecute(Sender: TObject);
    procedure aInfoAbonentExecute(Sender: TObject);
    procedure tsBillsShow(Sender: TObject);
    procedure btPaymentsInExcelClick(Sender: TObject);
    procedure btBillsInExcelClick(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure tsParamsShow(Sender: TObject);
    procedure aPostParamsExecute(Sender: TObject);
    procedure sgParamsContactsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tsBillsBeelineShow(Sender: TObject);
    procedure btBillsBeelineInExcelClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure grPaymentsDblClick(Sender: TObject);
    procedure btDetailSendMailClick(Sender: TObject);
    procedure dsDetPeriodsDataChange(Sender: TObject; Field: TField);
    procedure tsDetailShow(Sender: TObject);
    procedure btDetailRefreshClick(Sender: TObject);
    procedure btDetailSendExcelClick(Sender: TObject);
    procedure cbPhoneNumberChange(Sender: TObject);
    procedure btExportGroupListExcelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Hand_block_summKeyPress(Sender: TObject; var Key: Char);

  private
    FGroupId :integer;
    FGroupName : string;
    FManualPaymentManagement : Boolean;
    FYear : Integer;
    FMonth : Integer;
    FStringStream: TStringStream;
    FStream: TStream;
    smstime: TAwSlider;
    function DecodeServiceType(const Code: String): String;
    procedure LoadBillDetailText(const pPhone_Number:string; const pYear,pMonth:integer; var pDetailText:string);
    procedure PrepareDetail(const pDetailText:string);
    procedure PrepareDetailForSendMail(const pDetailText:string);
    procedure PrepareDetailExcel(const pDetailText:string; const sheet:integer; var Excel: OleVariant);
  public
    procedure Execute(const pGroupId : integer; const pGroupName : string);
  end;

  procedure DoShowGroupStat(const pGroupId : integer; const pGroupName:string);

implementation

{$R *.dfm}
uses ContractsRegistration_Utils, SelectContract, showuserstat, IntecExportGrid, main, RegisterPaymentGroup,CRStrUtils;

{ TShowGroupStatForm }

procedure DoShowGroupStat(const pGroupId:integer; const pGroupName:string);
var
  ShowGroupStatForm: TShowGroupStatForm;
begin
  ShowGroupStatForm := TShowGroupStatForm.Create(nil);
  try
    if pGroupName <> '' then begin
      ShowGroupStatForm.lGroup.Caption:=pGroupName;
      ShowGroupStatForm.Caption:=ShowGroupStatForm.Caption+' - ('+pGroupName+')';
    end;
    // Период
    ShowGroupStatForm.qPeriods.Open;
    while not ShowGroupStatForm.qPeriods.EOF do
    begin
      ShowGroupStatForm.cbPeriod.Items.AddObject(
        ShowGroupStatForm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ShowGroupStatForm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ShowGroupStatForm.qPeriods.Next;
    end;
    ShowGroupStatForm.qPeriods.Close;
    if ShowGroupStatForm.cbPeriod.Items.Count > 0 then
      ShowGroupStatForm.cbPeriod.ItemIndex := 0;

    ShowGroupStatForm.Execute(pGroupId,pGroupName);
  finally
    ShowGroupStatForm.Free;
  end;
end;

procedure TShowGroupStatForm.aAddContractExecute(Sender: TObject);
var
  vPhoneNumber : String;
  vContractID : Integer;
begin
  SelectPhoneNumber(vPhoneNumber, vContractID);
  if vContractID = 0 then
    MessageDlg('Для данного номера не существует договора.', mtError, [mbOK], 0)
  else
  try
    qGroups.ParamByName('contract_id').AsInteger:=vContractID;
    qGroups.Open;
    if qGroups.RecordCount > 0 then
      MessageDlg('Данный договор уже находится в группе - '+qGroups.FieldByName('group_name').AsString, mtError, [mbOK], 0)
    else begin
      EditContractGroup.ParamByName('p_ContractId').AsInteger:=vContractID;
      EditContractGroup.ParamByName('p_GroupId').AsInteger:=FGroupId;
      EditContractGroup.ExecProc;
      //обновление
      qContractGroup.Close;
      qContractGroup.Open;
      qGroupBalance.Close;
      qGroupBalance.Open;
      lBalance.Caption:=FloatToStrF(qGroupBalance.FieldByName('group_balance').AsFloat,ffNumber,15,2);
    end;
  finally
    qGroups.Close;
  end;

end;

procedure TShowGroupStatForm.aInfoAbonentExecute(Sender: TObject);
begin
  if qContractGroup.Active and (qContractGroup.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qContractGroupPHONE_NUMBER_FEDERAL.AsString, qContractGroupCONTRACT_ID.AsInteger);
end;

procedure TShowGroupStatForm.aPostParamsExecute(Sender: TObject);
var
  ParamsContacts:string;
  i,j:integer;
  empty_flag:boolean;
  stream:TmemoryStream;
begin
  EditGroupParams.ParamByName('p_GroupId').AsInteger:=FGroupId;
  EditGroupParams.ParamByName('P_PARAMDISABLE_SMS').AsString:=FloatToStrF(smstime.MinData,ffnumber,8,8)+';'+FloatToStrF(smstime.MaxData,ffNumber,8,8)+';';
  empty_flag:=false;
  for i := 0 to sgParamsContacts.ColCount-1 do
    for j := 0 to sgParamsContacts.RowCount-1 do
      if sgParamsContacts.Cells[i,j]<>'' then begin
        ParamsContacts:=ParamsContacts+sgParamsContacts.Cells[i,j]+'/';
        empty_flag:=true;
      end
      else ParamsContacts:=ParamsContacts+'empty/';
  if empty_flag then
    EditGroupParams.ParamByName('p_ParamPDF_Contacts').AsString:=ParamsContacts
  else EditGroupParams.ParamByName('p_ParamPDF_Contacts').Clear;
  EditGroupParams.ParamByName('p_ParamPDF_BankDet').AsString:=mParamsBankDet.Text;
  if not ImageLogo.Picture.Graphic.Empty then
    try
      stream:=TMemoryStream.Create;
      ImageLogo.Picture.Graphic.SaveToStream(stream);
      stream.Position := 0;
      EditGroupParams.ParamByName('p_ParamPDF_Logo').ParamType:=ptInput;
      EditGroupParams.ParamByName('p_ParamPDF_Logo').AsOraBlob.LoadFromStream(stream);
    finally
      stream.Free;
    end
   else  EditGroupParams.ParamByName('p_ParamPDF_Logo').Clear;
   EditGroupParams.ParamByName('p_ParamDet_Mail').AsString:=eParamsDetMail.Text;
  if chkUssd_bal.Checked then
      EditGroupParams.ParamByName('p_PARAMUSSD_GR_BAL').AsString:='1'
  else EditGroupParams.ParamByName('p_PARAMUSSD_GR_BAL').AsString:='';
  if chkHand_block.Checked then
    begin
      EditGroupParams.ParamByName('p_paramhand_block').AsString:='1';
      EditGroupParams.ParamByName('P_PARAM_TIME_BLOCK_END').AsString:=NewDateEnd.Text;
      EditGroupParams.ParamByName('p_param_hand_block_summ').AsString:=Hand_block_summ.text;
    end
  else
    begin
      EditGroupParams.ParamByName('p_paramhand_block').AsString:='';
      EditGroupParams.ParamByName('P_PARAM_TIME_BLOCK_END').AsString:='';
      EditGroupParams.ParamByName('p_param_hand_block_summ').AsString:='';
    end;


   EditGroupParams.ExecProc;
end;

procedure TShowGroupStatForm.aRemoveContractExecute(Sender: TObject);
begin
  if qContractGroupCONTRACT_ID.AsInteger <> 0 then  begin
    EditContractGroup.ParamByName('p_ContractId').AsInteger:=qContractGroupCONTRACT_ID.AsInteger;
    EditContractGroup.ParamByName('p_GroupId').Clear;
    EditContractGroup.ExecProc;
    //обновление
    qContractGroup.Close;
    qContractGroup.Open;
    qGroupBalance.Close;
    qGroupBalance.Open;
    lBalance.Caption:=FloatToStrF(qGroupBalance.FieldByName('group_balance').AsFloat,ffNumber,15,2);
  end;

end;

procedure TShowGroupStatForm.BitBtn2Click(Sender: TObject);
begin
  if OpenImage.Execute then
    ImageLogo.Picture.LoadFromFile(OpenImage.FileName);
end;

procedure TShowGroupStatForm.BitBtn3Click(Sender: TObject);
begin
  ImageLogo.Picture:=nil;
end;

procedure TShowGroupStatForm.btDetailSendExcelClick(Sender: TObject);
type
  THeader = array[0..14] of string;
const
  Header : THeader = ('Свой номер','Дата','Время','Тип услуги','Направление','Собеседник','Длительность','Длительность (мин)',
                      'Стоимость','Роуминг','Зона роуминга','Доп.информация','Базовая станция','Сумма без НДС','Зона БС');
  ColCount:integer=14;
var
 i,j:integer;
 s, DetailText, Detail_mail : string;
 Excel : OleVariant;
begin
  //Чтение адреса, на который отправлять детализацию
  qGroupParams.Close;
  qGroupParams.ParamByName('group_id').AsInteger:=FGroupId;
  qGroupParams.open;
  Detail_mail:=qGroupParams.FieldByName('ParamDet_Mail').AsString;
  qGroupParams.Close;
  if Detail_mail = '' then begin
     MessageDlg('В параметрах не задан адрес почты, на который необходимо отправлять детализации.', mtError, [mbOK], 0);
     Exit;
  end;
  btDetailSendExcel.Enabled:=false;
  Try
    //Получение Excel
    Excel := CreateOleObject('Excel.Application');
    try
      Excel.WorkBooks.Add;
      //Excel.Application.DisplayAlerts:=False;
      if qContractGroup.Active then
      begin
        pbProcess.Position:=0;
        pbProcess.Max:=qContractGroup.RecordCount;
        lblProcess.Caption:='Начало обработки';
        PanelProcess.Show;
        i:=0;
        qContractGroup.First;
        while not qContractGroup.Eof do
        begin
          lblProcess.Caption:='Обработка номера: ' + qContractGroup.FieldByName('phone_number_federal').AsString;
          application.ProcessMessages;
          inc(i);
          if i > Excel.WorkBooks[1].WorkSheets.Count then
            Excel.WorkBooks[1].WorkSheets.Add(After := Excel.WorkBooks[1].WorkSheets[i-1]);
          Excel.WorkBooks[1].WorkSheets[i].Name:=qContractGroup.FieldByName('phone_number_federal').AsString;
          //заголовки столбцов
          for j := 0 to ColCount do
          begin
            Excel.WorkBooks[1].WorkSheets[i].cells[1,j+1].value:=Header[j];
            Excel.WorkBooks[1].WorkSheets[i].cells[1,j+1].Font.Bold:=true;
            Excel.WorkBooks[1].WorkSheets[i].cells[1,j+1].HorizontalAlignment:=3;
            Excel.WorkBooks[1].WorkSheets[i].cells[1,j+1].Interior.Color:=clSilver;
            Excel.WorkBooks[1].WorkSheets[i].cells[1,j+1].Borders[9].LineStyle := 1;
          end;
          //Получение детализации номера
          LoadBillDetailText(qContractGroup.FieldByName('phone_number_federal').AsString, fyear, fmonth, DetailText);
          //Обработка детализации
          PrepareDetailExcel(DetailText, i, Excel);
          //автоподбор ширины
          for j := 0 to ColCount do
            Excel.WorkBooks[1].WorkSheets[i].Columns[j+1].AutoFit;
          pbProcess.StepIt;
          application.ProcessMessages;
          qContractGroup.Next;
        end;
      end;
      //stream:=OleVariantToMemoryStream(Excel)
      lblProcess.Caption:='Сохранение...';
      application.ProcessMessages;
      DateTimeToString(s,'yyyymmddhhnnss',now);
      Excel.WorkBooks[1].SaveAs(ExtractFilePath(application.ExeName)+'Detail_'+s+'.xls');
      Excel.WorkBooks.Close;
      //Excel.Application.DisplayAlerts:=True;
    finally
      Excel.quit;
      Excel:=UnAssigned;
      //Excel.Visible := True;
      //Excel.WindowState := 3;
    end;

    lblProcess.Caption:='Отправка...';
    application.ProcessMessages;
    //Задание параметров и отправка письма с прикрепленным файлом
    qSendMailParams.Open;
    try
     with ThreadSMTP.Create(true) do
     begin
      SMTP_SRV := qSendMailParams.FieldByName('SMTP_SERVER').AsString;
      SMTP_LOG := qSendMailParams.FieldByName('USER_LOGIN').AsString;
      SMTP_PASS:=qSendMailParams.FieldByName('USER_PASSWORD').AsString;
      SMTP_ADDR := Detail_mail;
      SMTP_TITLE := 'Детализация группы договоров "'+FGroupName+'" за '+IntToStr(FYear)+' - '+IntToStr(FMonth);
      SMTP_FROMTXT := GetParamValue('SMTP_FROMTEXT');
      //SMTP_ATT_FILE:=stream;
      SMTP_ATT_FILE := ExtractFilePath(application.ExeName)+'Detail_'+s+'.xls';
      Resume;
    end;
    finally
       qSendMailParams.Close;
    end;
  Finally
    btDetailSendExcel.Enabled:=true;
    PanelProcess.Hide;
  End;

end;

procedure ThreadSMTP.Execute;
var
c:integer;
idSmtp:TIdSMTP;
idMsg:TIdMessage;
//IdAttachment:TIdAttachmentMemory;
begin
 idSmtp:=TIdSMTP.Create();
 with idSmtp do begin
   Host := SMTP_SRV;
   Username :=SMTP_LOG;
   Password:=SMTP_PASS;
 end;

 idMsg:=TIdMessage.Create();
 with idMsg do begin
  Date := Now;
  From.Text := SMTP_FROMTXT;
  Recipients.EMailAddresses := SMTP_ADDR;
  Subject := SMTP_TITLE;
  From.Name := 'Агентство связи';
  From.Address := SMTP_LOG;
  ContentTransferEncoding:='8bit';
  ContentType := 'text/plain';
  CharSet := 'Windows-1251';
 end;
{ IdAttachment:=TIdAttachmentMemory.Create(idMsg.MessageParts);
 IdAttachment.FileName:='Detail_';
 IdAttachment.DataStream:=SMTP_ATT_FILE;}
 TIdAttachmentFile.Create( idMsg.MessageParts, SMTP_ATT_FILE);
 try
   idSmtp.Connect;
    try
      IdSmtp.Send(idMsg);
    finally
      idSmtp.Disconnect;
      MessageDlg(SMTP_TITLE+': отправлено!', mtInformation, [mbOK], 0);
    end;
 finally
   FreeAndNil(idSmtp);
   FreeAndNil(idMsg);
   if FileExists(SMTP_ATT_FILE) then
      DeleteFile(SMTP_ATT_FILE)
 end;
end;

procedure TShowGroupStatForm.LoadBillDetailText(const pPhone_Number:string; const pYear, pMonth:integer; var pDetailText:string);
var
  DetailText : String;
begin
    spGetPhoneBillDetail.ParamByName('pYEAR').AsInteger := pYear;
    spGetPhoneBillDetail.ParamByName('pMONTH').AsInteger := pMonth;
    spGetPhoneBillDetail.ParamByName('pPHONE_NUMBER').AsString := pPhone_Number;
    try
      spGetPhoneBillDetail.ExecProc;
      DetailText := spGetPhoneBillDetail.ParamByName('RESULT').AsString;
      pDetailText := DetailText;
    except
      on E : Exception do
      begin
//        DetailText := 'Ошибка .'#13#10 + E.Message;
        MessageDlg('Ошибка получения детализации номера ' + pPhone_Number + #13#10 + E.Message , mtError, [mbOK], 0);
        pDetailText := '';
      end;
    end;
//    mDetailText.Lines.Add(DetailText);
end;

procedure TShowGroupStatForm.PrepareDetail(const pDetailText:string);
var
  i : Integer;
  sl : TStringList;
  s : String;
  Line : String;
  CostNoVatStr: string;
  duration:double;
  Service_type:String;
begin
  try
  sl := TStringList.Create;
  vtDetailFile.DisableControls;
  try
    sl.Text := pDetailText;
    if not vtDetailFile.Active then
      vtDetailFile.Open;
    for i := 0 to sl.Count-1 do
    begin
      Line := sl[i];
      if GetTokenCount(Line) >= 11 then
      begin
        vtDetailFile.Append;
        vtDetailFile.FieldByName('SELF_NUMBER').AsString := Copy(GetToken(Line, 1), 1, 20);
        vtDetailFile.FieldByName('SERVICE_DATE').AsDateTime := StrToDate(GetToken(Line, 2));
        vtDetailFile.FieldByName('SERVICE_TIME').AsDateTime := StrToTime(GetToken(Line, 3));
        Service_type:=GetToken(Line, 4);
        vtDetailFile.FieldByName('SERVICE_TYPE').AsString := DecodeServiceType(Service_type);
        s := GetToken(Line, 5);
        if s = '1' then
          s := 'Исходящий'
        else if s = '2' then
          s := 'Входящий'
        else if s = '3' then
          s := 'переадресация'
        else
          s := 'Неопределено';
        vtDetailFile.FieldByName('SERVICE_DIRECTION').AsString := s;
        vtDetailFile.FieldByName('OTHER_NUMBER').AsString := Copy(GetToken(Line, 6), 1, 20);
        duration:=StrToFloat2(GetToken(Line, 7));
        vtDetailFile.FieldByName('DURATION').AsFloat := duration;
        //Округляем до минут длительность, только для типа услуги - "Звонок"
        if Service_type='C' then
          //Первые две секунды не тарифицируются
          if duration<=2 then
            vtDetailFile.FieldByName('DURATION_MIN').AsInteger := 0
          else
            vtDetailFile.FieldByName('DURATION_MIN').AsInteger := Ceil(duration/60);

        vtDetailFile.FieldByName('SERVICE_COST').AsFloat := StrToFloat2(GetToken(Line, 8));
        if GetToken(Line, 9) = '1' then
          s := 'Да'
        else
          s := '';
        vtDetailFile.FieldByName('IS_ROAMING').AsString := s;
        vtDetailFile.FieldByName('ROAMING_ZONE').AsString := Copy(GetToken(Line, 10), 1, 50);
        vtDetailFile.FieldByName('ADD_INFO').AsString := Copy(GetToken(Line, 11), 1, 100);
        vtDetailFile.FieldByName('BASE_STATION_CODE').AsString := Copy(GetToken(Line, 12), 1, 10);
        // Стоимость без НДС берём готовую, а если её нет, то рассчитываем
        CostNoVatStr := GetToken(Line, 13);
        if CostNoVATStr = '' then
          CostNoVatStr := FloatToStr(vtDetailFile.FieldByName('SERVICE_COST').AsFloat / 1.18);
        vtDetailFile.FieldByName('COST_NO_VAT').AsFloat := StrToFloat2(CostNoVatStr);
        s:=Copy(GetToken(Line, 14), 1, 50);
        if s='' then
          if Copy(GetToken(Line, 12), 1, 10)<>'' then  begin
            qBaseZone.ParamByName('bzone').AsInteger := strtoint(Copy(GetToken(Line, 12), 1, 10));
            qBaseZone.ExecSQL;
            s:=qBaseZone.FieldByName('ZONE_NAME').AsString ;
//            qBaseZone.Close;
          end;
        vtDetailFile.FieldByName('BS_PLACE').AsString := s;

        vtDetailFile.Post;
      end;
    end;
    vtDetailFile.First;
  finally
    vtDetailFile.EnableControls;
    FreeAndNil(sl);
  end;
  except
    on E : Exception do
      MessageDlg('Ошибка обработки детализации.'#13#10 + E.Message , mtError, [mbOK], 0);
  end;
end;

function Rpad(S: string; L: Integer; C: string = ' '): string;
begin
  Result := S;
  while Length(Result) < L do
    Result := Result + C;
end;

function Td(S: string): string;
begin
  Result:='<td>'+S+'</td>';
end;


procedure TShowGroupStatForm.PrepareDetailForSendMail(const pDetailText:string);
var
  i : Integer;
  sl : TStringList;
  s : String;
  Line : String;
  CostNoVatStr: string;
  duration:double;
  Service_type:String;
begin
  try
  sl := TStringList.Create;
  try
    sl.Text := pDetailText;
    for i := 0 to sl.Count-1 do
    begin
      Line := sl[i];
      if GetTokenCount(Line) >= 11 then
      begin
        FStringStream.WriteString('<tr>');
        FStringStream.WriteString(Td(Copy(GetToken(Line, 1), 1, 20)));//SELF_NUMBER
        FStringStream.WriteString(Td(GetToken(Line, 2)));//SERVICE_DATE
        FStringStream.WriteString(Td(GetToken(Line, 3)));//SERVICE_TIME
        Service_type:=GetToken(Line, 4);
        FStringStream.WriteString(Td(DecodeServiceType(Service_type)));//SERVICE_TYPE
        s := GetToken(Line, 5);
        if s = '1' then
          s := 'Исходящий'
        else if s = '2' then
          s := 'Входящий'
        else if s = '3' then
          s := 'переадресация'
        else
          s := 'Неопределено';
        FStringStream.WriteString(Td(s));//SERVICE_DIRECTION
        FStringStream.WriteString(Td(Copy(GetToken(Line, 6), 1, 20)));//OTHER_NUMBER
        duration:=StrToFloat2(GetToken(Line, 7));
        FStringStream.WriteString(Td(GetToken(Line, 7)));//DURATION
        //Округляем до минут длительность, только для типа услуги - "Звонок"
        if Service_type='C' then
          //Первые две секунды не тарифицируются
          if duration<=2 then
            FStringStream.WriteString(Td('0'))//DURATION_MIN
          else
            FStringStream.WriteString(Td(InttoStr(Ceil(duration/60))));//DURATION_MIN

        FStringStream.WriteString(Td(Trim(GetToken(Line, 8))));//SERVICE_COST
        if GetToken(Line, 9) = '1' then
          s := 'Да'
        else
          s := '';
        FStringStream.WriteString(Td(s));//IS_ROAMING
        FStringStream.WriteString(Td(Copy(GetToken(Line, 10), 1, 50)));//ROAMING_ZONE
        FStringStream.WriteString(Td(Copy(GetToken(Line, 11), 1, 50)));//ADD_INFO
        FStringStream.WriteString(Td(Copy(GetToken(Line, 12), 1, 10)));//BASE_STATION_CODE
        // Стоимость без НДС берём готовую, а если её нет, то рассчитываем
        CostNoVatStr := GetToken(Line, 13);
        if CostNoVATStr = '' then
          CostNoVatStr := FloatToStr(StrToFloat2(GetToken(Line, 8)) / 1.18);
        FStringStream.WriteString(Td(CostNoVatStr));//COST_NO_VAT
        s:=Copy(GetToken(Line, 14), 1, 50);

        if s='' then
          if Copy(GetToken(Line, 12), 1, 10)<>'' then  begin
            qBaseZone.ParamByName('bzone').AsInteger := strtoint(Copy(GetToken(Line, 12), 1, 10));
            qBaseZone.ExecSQL;
            s:=qBaseZone.FieldByName('ZONE_NAME').AsString ;
          end;
        FStringStream.WriteString(Td(s));//BS_PLACE
        FStringStream.WriteString('</tr>');
      end;
    end;
  finally
    FreeAndNil(sl);
  end;
  except
    on E : Exception do
      MessageDlg('Ошибка обработки детализации.'#13#10 + E.Message , mtError, [mbOK], 0);
  end;
end;

procedure TShowGroupStatForm.PrepareDetailExcel(const pDetailText:string; const sheet:integer; var Excel: OleVariant);
var
  i : Integer;
  sl : TStringList;
  s : String;
  Line : String;
  CostNoVatStr: string;
  duration:double;
  Service_type:String;
begin
  try
  sl := TStringList.Create;
  try
    sl.Text := pDetailText;
    for i := 0 to sl.Count-1 do
    begin
      Line := sl[i];
      if GetTokenCount(Line) >= 11 then
      begin
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,1].value:=Copy(GetToken(Line, 1), 1, 20);//SELF_NUMBER
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,2].value:=GetToken(Line, 2);//SERVICE_DATE
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,3].value:=GetToken(Line, 3);//SERVICE_TIME
        Service_type:=GetToken(Line, 4);
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,4].value:=DecodeServiceType(Service_type);//SERVICE_TYPE
        s := GetToken(Line, 5);
        if s = '1' then
          s := 'Исходящий'
        else if s = '2' then
          s := 'Входящий'
        else if s = '3' then
          s := 'переадресация'
        else
          s := 'Неопределено';
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,5].value:=s;//SERVICE_DIRECTION
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,6].value:=Copy(GetToken(Line, 6), 1, 20);//OTHER_NUMBER
        duration:=StrToFloat2(GetToken(Line, 7));
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,7].value:=GetToken(Line, 7);//DURATION
        //Округляем до минут длительность, только для типа услуги - "Звонок"
        if Service_type='C' then
          //Первые две секунды не тарифицируются
          if duration<=2 then
            Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,8].value:='0'//DURATION_MIN
          else
            Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,8].value:=InttoStr(Ceil(duration/60));//DURATION_MIN

        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,9].value:=Trim(GetToken(Line, 8));//SERVICE_COST
        if GetToken(Line, 9) = '1' then
          s := 'Да'
        else
          s := '';
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,10].value:=s;//IS_ROAMING
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,11].value:=Copy(GetToken(Line, 10), 1, 50);//ROAMING_ZONE
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,12].value:=Copy(GetToken(Line, 11), 1, 50);//ADD_INFO
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,13].value:=Copy(GetToken(Line, 12), 1, 10);//BASE_STATION_CODE
        // Стоимость без НДС берём готовую, а если её нет, то рассчитываем
        CostNoVatStr := GetToken(Line, 13);
        if CostNoVATStr = '' then
          CostNoVatStr := FloatToStr(StrToFloat2(GetToken(Line, 8)) / 1.18);
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,14].value:=CostNoVatStr;//COST_NO_VAT
        s:=Copy(GetToken(Line, 14), 1, 50);

        if s='' then
          if Copy(GetToken(Line, 12), 1, 10)<>'' then  begin
            qBaseZone.ParamByName('bzone').AsInteger := strtoint(Copy(GetToken(Line, 12), 1, 10));
            qBaseZone.ExecSQL;
            s:=qBaseZone.FieldByName('ZONE_NAME').AsString ;
          end;
        Excel.WorkBooks[1].WorkSheets[sheet].cells[i+2,15].value:=s;//BS_PLACE
      end;
    end;
  finally
    FreeAndNil(sl);
  end;
  except
    on E : Exception do
      MessageDlg('Ошибка обработки детализации.'#13#10 + E.Message , mtError, [mbOK], 0);
  end;
end;

function TShowGroupStatForm.DecodeServiceType(const Code : String) : String;
begin
  if not qServiceCodes.Active then
    qServiceCodes.Open;
  if qServiceCodes.Locate('SERVICE_CODE', Code, []) then
    Result := qServiceCodes.FieldByName('SERVICE_NAME').AsString
  else
    Result := Code;
end;

procedure TShowGroupStatForm.btDetailSendMailClick(Sender: TObject);
var
  DetailText, Detail_mail, s:string;
begin
  qGroupParams.Close;
  qGroupParams.ParamByName('group_id').AsInteger:=FGroupId;
  qGroupParams.open;
  Detail_mail:=qGroupParams.FieldByName('ParamDet_Mail').AsString;
  qGroupParams.Close;
  if Detail_mail = '' then begin
     MessageDlg('В параметрах не задан адрес почты, на который необходимо отправлять детализации.', mtError, [mbOK], 0);
     Exit;
  end;
  btDetailSendMail.Enabled:=false;
  if qContractGroup.Active then
  begin
   FStringStream:=TStringStream.Create;
   FStringStream.Position:=0;
   FStringStream.WriteString('<html><body>');
   FStringStream.WriteString('<h1>Детализация группы договоров "'+FGroupName+'" за '+IntToStr(FYear)+' - '+IntToStr(FMonth)+'</h1>');
   //Формирование заголовков столбцов
   FStringStream.WriteString('<table cellpadding="10" cellspacing="0" style="border:#666666 1px solid;">');
   FStringStream.WriteString('<tr style="font-weight: bold">');
   FStringStream.WriteString(Td('Номер'));
   FStringStream.WriteString(Td('Дата'));
   FStringStream.WriteString(Td('Время'));
   FStringStream.WriteString(Td('Тип услуги'));
   FStringStream.WriteString(Td('Направление'));
   FStringStream.WriteString(Td('Собеседник'));
   FStringStream.WriteString(Td('Длительность'));
   FStringStream.WriteString(Td('Длительность(мин)'));
   FStringStream.WriteString(Td('Стоимость'));
   FStringStream.WriteString(Td('Роуминг'));
   FStringStream.WriteString(Td('Зона роуминга'));
   FStringStream.WriteString(Td('Дополнительная информация'));
   FStringStream.WriteString(Td('Базовая станция'));
   FStringStream.WriteString(Td('Сумма без НДС'));
   FStringStream.WriteString(Td('Зона БС')+'</tr>');

   pbProcess.Position:=0;
   pbProcess.Max:=qContractGroup.RecordCount;
   lblProcess.Caption:='Начало обработки';
   PanelProcess.Show;
   try
     qContractGroup.First;
     while not qContractGroup.Eof do
     begin
       lblProcess.Caption:='Обработка номера: ' + qContractGroup.FieldByName('phone_number_federal').AsString;
       application.ProcessMessages;
       //Получение детализации номера
       LoadBillDetailText(qContractGroup.FieldByName('phone_number_federal').AsString, fyear, fmonth, DetailText);
       //Обработка детализации
       PrepareDetailForSendMail(DetailText);
       pbProcess.StepIt;
       application.ProcessMessages;
       qContractGroup.Next;
     end;
     FStringStream.WriteString('</table></body></html>');
     lblProcess.Caption:='Отправка...';
     application.ProcessMessages;
     send_mail_detail.ParamByName('RECIPIENT').AsString:=Detail_mail;
     DateTimeToString(s,'hh:nn:ss dd.mm.yyyy',now);
     send_mail_detail.ParamByName('MESSAGE_TITLE').AsString:='Детализация группы: '+FGroupName+' '+s;
     FStringStream.Position := 0;
     send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.OCISvcCtx := MainForm.OraSession.OCISvcCtx;
     send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.CreateTemporary(ltClob);
     send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.LoadFromStream(FStringStream);
     send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.WriteLob;
     try
       send_mail_detail.ExecSQL;
     except
       on E : Exception do
         MessageDlg('Ошибка при отправке детализации.'#13#10 + E.Message , mtError, [mbOK], 0);
     end;
     send_mail_detail.ParamByName('MAIL_TEXT').AsOraClob.FreeLob;
   finally
     btDetailSendMail.Enabled:=true;
     PanelProcess.Hide;
     FStringStream.Free;
     qBaseZone.Close;
     qServiceCodes.Close;
   end;
  end;

end;

procedure TShowGroupStatForm.btDetailRefreshClick(Sender: TObject);
var
  DetailText:string;
begin
  btDetailRefresh.Enabled:=false;
  if qContractGroup.Active then
  begin
   vtDetailFile.Clear;
   cbPhoneNumber.Clear;
   pbProcess.Position:=0;
   lblProcess.Caption:='Начало обработки';
   pbProcess.Max:=qContractGroup.RecordCount;
   PanelProcess.Show;
   try
     qContractGroup.First;
     while not qContractGroup.Eof do
     begin
       lblProcess.Caption:='Обработка номера: ' + qContractGroup.FieldByName('phone_number_federal').AsString;
       application.ProcessMessages;
       //Получение детализации номера
       LoadBillDetailText(qContractGroup.FieldByName('phone_number_federal').AsString, fyear, fmonth, DetailText);
       //Обработка детализации
       PrepareDetail(DetailText);
       //Добавление номера в список
       cbPhoneNumber.Items.Add(qContractGroup.FieldByName('phone_number_federal').AsString);
       pbProcess.StepIt;
       application.ProcessMessages;
      qContractGroup.Next;
     end;
     if cbPhoneNumber.Items.Count > 0 then
       cbPhoneNumber.ItemIndex := 0;
   finally
     btDetailRefresh.Enabled:=true;
     PanelProcess.Hide;
     qBaseZone.Close;
     qServiceCodes.Close;
   end;
  end;
end;

procedure TShowGroupStatForm.btPaymentsInExcelClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Платежи группы договоров '+FGroupName;
  try
    ExportDBGridToExcel(ACaption,'',
      grPayments, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowGroupStatForm.Button1Click(Sender: TObject);
begin
ShowMessage(FloatToStr(smstime.MaxData)+' '+FloatToStr(smstime.MinData));
end;

function OleVariantToMemoryStream(OV: OleVariant): TMemoryStream;
var
 Data: PByteArray;
 Size: integer;
begin
 Result := TMemoryStream.Create;
 try
//   Size := VarArrayHighBound(OV, 1);
//   Size := Size - VarArrayLowBound(OV, 1) + 1;
   Data := VarArrayLock(OV);
   try
     Result.Position := 0;
     Result.WriteBuffer(Data^, VarArrayHighBound(OV, 1){Size});
   finally
     VarArrayUnlock(OV);
   end;
 except
   Result.Free;
   Result := nil;
 end;
end;

procedure TShowGroupStatForm.cbPhoneNumberChange(Sender: TObject);
begin
 vtDetailFile.Filtered:=false;
 vtDetailFile.Filter:='self_number='+QuotedStr(cbPhoneNumber.Text);
 vtDetailFile.Filtered:=true;
end;

procedure TShowGroupStatForm.dsDetPeriodsDataChange(Sender: TObject;
  Field: TField);
begin
  FYear := qDetPeriods.FieldByName('YEAR').AsInteger;
  FMonth := qDetPeriods.FieldByName('MONTH').AsInteger;

end;

procedure TShowGroupStatForm.btBillsBeelineInExcelClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Счета Beeline группы договоров '+FGroupName+' за период '+qBillsBeelineYEAR_MONTH.AsString;
  try
    ExportDBGridToExcel(ACaption,'',
      grBillsBeelineDetail, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowGroupStatForm.btBillsInExcelClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Счета группы договоров '+FGroupName+' за период '+qBillsYEAR_MONTH.AsString;
  try
    ExportDBGridToExcel(ACaption,'',
      grBillsDetail, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowGroupStatForm.btExportClick(Sender: TObject);
var
  i,period:integer;
  beeline_contacts:tstringlist;
  text:string;
  stream:tmemorystream;
  procedure SetQueryParam (q : TOraQuery; GrId : Integer; per : Integer);
  begin
    q.Close;
    q.ParamByName('GROUP_ID').AsInteger := GrId;
    q.ParamByName('YEAR_MONTH').AsInteger := per;
  end;
begin
  period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
  try
    savePdf.Title := 'Отчет о группе договоров - '+FGroupName;
    if savePdf.Execute then
    begin
      SetQueryParam(qBillsFrx, FGroupId, period);
      SetQueryParam(qAbonPeriodList, FGroupId, period);
      SetQueryParam(qOptsHistory, FGroupId, period);
      SetQueryParam(qBillMnRouming, FGroupId, period);
      SetQueryParam(qTitle, FGroupId, period);
      SetQueryParam(qBillMgRouming, FGroupId, period);

      //Заполняем шапку титульного листа
      qGroupParams.Close;
      qGroupParams.ParamByName('group_id').AsInteger:=FGroupId;
      qGroupParams.open;
      beeline_contacts:=tstringlist.Create;
      if not qGroupParams.FieldByName('ParamPDF_Contacts').IsNull then
      begin
        beeline_contacts.Delimiter:='/';
        beeline_contacts.DelimitedText:=replaceStr(qGroupParams.FieldByName('ParamPDF_Contacts').AsString,' ','#');
        for i := 0 to 2 do
          if beeline_contacts.Strings[i]<>'empty' then
            text:=text+beeline_contacts.Strings[i]+#13#10
          else text:=text+#13#10;
        (frxReport1.FindObject('Memo_Adr') as TfrxMemoView).Text:=ReplaceStr(text,'#',' ');
        text:='';
        for i := 3 to 5 do
          if beeline_contacts.Strings[i]<>'empty' then
            text:=text+beeline_contacts.Strings[i]+#13#10
          else text:=text+#13#10;
        (frxReport1.FindObject('Memo_Phone') as TfrxMemoView).Text:=ReplaceStr(text,'#',' ');
        text:='';
        for i := 6 to 8 do
          if beeline_contacts.Strings[i]<>'empty' then
            text:=text+beeline_contacts.Strings[i]+#13#10
          else
            text:=text+#13#10;
        (frxReport1.FindObject('Memo_Fax') as TfrxMemoView).Text:=ReplaceStr(text,'#',' ');
      end;
      //Заполняем титульный лист
      (frxReport1.FindObject('Memo_Bill1') as TfrxMemoView).Text:='Счет № '+ Edit_bill.Text;
      (frxReport1.FindObject('Memo_Period') as TfrxMemoView).Text:='Оплата услуг за период: 01/'+copy(Inttostr(period),5,2)+'/'+copy(inttostr(period),1,4)+' - '+inttostr(daysinamonth(period div 100, period mod 100))+'/'+copy(inttostr(period),5,2)+'/'+copy(inttostr(period),1,4);
       DateSeparator:='/';
      (frxReport1.FindObject('Memo_Date') as TfrxMemoView).Text:='Дата выставления: '+datetostr(date);
      (frxReport1.FindObject('Memo_Date1') as TfrxMemoView).Text:='Дата выставления: '+datetostr(date);
      (frxReport1.FindObject('Memo_Srok') as TfrxMemoView).Text:='Срок оплаты до: 25/'+formatfloat('00',(period mod 100)+1)+'/'+copy(inttostr(period),1,4);
      (frxReport1.FindObject('Memo_Group') as TfrxMemoView).Text:='Группа договоров: '+ FGroupName;
      (frxReport1.FindObject('Memo_Group1') as TfrxMemoView).Text:='Группа договоров: '+ FGroupName;
      (frxReport1.FindObject('Memo_Bill2') as TfrxMemoView).Text:=Edit_bill.Text;
      if not qGroupParams.FieldByName('ParamPDF_BankDet').IsNull then
        (frxReport1.FindObject('Memo_BankDet') as TfrxMemoView).Text:=qGroupParams.FieldByName('ParamPDF_BankDet').AsString;
     //загружаем логотип
      if TBlobField(qGroupParams.FieldByName('ParamPDF_Logo')).BlobSize > 0 then
        try
          stream:=TmemoryStream.Create;
          TBlobField(qGroupParams.FieldByName('ParamPDF_Logo')).SaveToStream(stream);
          stream.Position := 0;
          (frxReport1.FindObject('Memo_Logo') as TfrxPictureView).Picture.Graphic:=TJPEGImage.Create;
          (frxReport1.FindObject('Memo_Logo') as TfrxPictureView).Picture.Graphic.LoadFromStream(stream);
        finally
           stream.Free;
        end;

      frxReport1.PrepareReport();
      frxPDFExport1.FileName:=SavePdf.FileName;
      if not frxReport1.Export(frxPDFExport1) then
        MessageDlg('Ошибка при формировании отчета о группе договоров - '+FGroupName, mtError, [mbOK], 0)
      else
        MessageDlg('Отчет о группе договоров - '+FGroupName+' сформирован.'#13#10+'Файл '+SavePdf.FileName, mtInformation, [mbOK], 0);
    end;
  Finally
    beeline_contacts.Free;
    DateSeparator:='.';
    qBills.Close;
    qAbonPeriodList.Close;
    qOptsHistory.Close;
    qBillMnRouming.Close;
    qTitle.Close;
    qGroupParams.Close;
  end;
end;

procedure TShowGroupStatForm.btExportGroupListExcelClick(Sender: TObject);
var
  cr : TCursor;
  ACaption : String;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  ACaption := 'Номера группы договоров '+FGroupName;
  try
    ExportDBGridToExcel(ACaption,'',
      grGroup, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowGroupStatForm.btnAddClick(Sender: TObject);
var
  RegisterPaymentGroupForm : TRegisterPaymentGroupForm;
begin
  if FManualPaymentManagement then
  begin
    RegisterPaymentGroupForm := TRegisterPaymentGroupForm.Create(nil);
    try
      if RegisterPaymentGroupForm.PrepareForm('INSERT', 0, FGroupId, FGroupName) then
        if (mrOk = RegisterPaymentGroupForm.ShowModal) then
          qPayments.Refresh;
    finally
      RegisterPaymentGroupForm.Free;
    end;
  end;
end;

procedure TShowGroupStatForm.Execute(const pGroupId : integer; const pGroupName : string);
begin
   //создание слайдера для выбора времени отправки смс
    smstime := TAwSlider.Create(Self);
  with smstime do
  begin
    SetBounds(265, 40, grpDopParams.Width - 285, 50);
    //Anchors := [akLeft, akTop, akRight, akBottom];
    DecimalCount:=18;
    Filtered := False;
    MinData := 0;
    minFilter:= 0;
    MinValue := 0;
    MaxData := 0.999305555560000000;
    MaxFilter := 0.999305555560000000;
    MaxValue := 0.999305555560000000;
    Step := 0.041666666666666700;
    ValueType := vtTime;
    ParentShowHint := False;
    ShowHint := False;
    Parent := grpDopParams;
  end;

  FGroupId:=pGroupId;
  FGroupName:=pGroupName;
  FManualPaymentManagement := (GetConstantValue('MANUAL_LINK_PAYMENTS_ENABLED') = '1');
  btnAdd.Visible := FManualPaymentManagement;

  qGroupBalance.ParamByName('group_id').AsInteger:=FGroupId;
  qGroupBalance.Open;
  lBalance.Caption:=FloatToStrF(qGroupBalance.FieldByName('group_balance').AsFloat,ffNumber,15,2);
  qContractGroup.ParamByName('group_id').AsInteger:=FGroupId;
  qContractGroup.Open;
  PageControl1.ActivePage := tsGroup;



  try
    ShowModal;
  finally
    qContractGroup.Close;
    qGroupBalance.Close;
    qDetPeriods.Close;
  end;
end;

procedure TShowGroupStatForm.grPaymentsDblClick(Sender: TObject);
var
  FPaymentGroupForm : TRegisterPaymentGroupForm;
  FReceivedPaymentID: String;
  AdminPriv : boolean;
begin
//  MainForm.CheckAdminPrivs(AdminPriv);
//    if AdminPriv then
//    begin
        if not (qPayments.Fields[8].AsString = '') then
          begin
            FPaymentGroupForm := TRegisterPaymentGroupForm.Create(nil);
//            FPaymentGroupForm.cbFILIAL.Enabled := False;
//            FPaymentGroupForm.PAYMENT_DATE_TIME.Enabled := False;
            try
              if FPaymentGroupForm.PrepareForm('EDIT', qPayments.Fields[8].AsInteger, FGroupId, FGroupName) then
                if (mrOk = FPaymentGroupForm.ShowModal) then
                  qPayments.Refresh;
            finally
              FPaymentGroupForm.Free;
            end;

          end
        else
          MessageDlg('Можно редактировать только ручные платежи!',mtError, [mbOK], 0);
//    end;
end;

procedure TShowGroupStatForm.Hand_block_summKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(((key>=#48)and(key<=#57))or(key=#45)or(key=#189)or(key=#46)or(key=#8)) then key:=#0;
end;

procedure TShowGroupStatForm.sgParamsContactsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
type
  TypeHints=array[0..2,0..2] of string;
const
  hints:TypeHints=(('Левый столбец, 1 строка - Адрес [ОАО Вымпелком]', 'Средний столбец, 1 строка - Телефон [Телефон:]', 'Правый столбец, 1 строка - Факс [Факс:]'),
                   ('Левый столбец, 2 строка - Адрес [127083, Москва]', 'Средний столбец, 2 строка - Телефон [Пусто]', 'Правый столбец, 2 строка - Факс [Пусто]'),
                   ('Левый столбец, 3 строка - Адрес [ул. 8Марта, д.10, стр.14]', 'Средний столбец, 3 строка - Телефон [+7(495)974-8888, (сот.0611)]', 'Правый столбец, 3 строка - Факс [+7(495)974-5996]'));
var
 acol , arow : integer;
 p : Tpoint;
begin
 p.x := x;
 p.y := y;

 sgParamsContacts.MouseToCell(x,y,acol , arow);
 if (arow >= 0) and (acol >= 0) then
   sgParamsContacts.Hint := hints[arow,acol];
 Application.ActivateHint(p);
end;

procedure TShowGroupStatForm.tsBillsShow(Sender: TObject);
begin
  qBills.Close;
  qBills.ParamByName('group_id').AsInteger:=FGroupId;
  qBills.open;
  qBillsDetail.Close;
  qBillsDetail.ParamByName('group_id').AsInteger:=FGroupId;
  qBillsDetail.open;
end;

procedure TShowGroupStatForm.tsDetailShow(Sender: TObject);
begin
  if not qDetPeriods.Active then begin
    qDetPeriods.ParamByName('GROUP_ID').AsInteger:=FGroupId;
    qDetPeriods.Open;
  end;
end;

procedure TShowGroupStatForm.tsGroupShow(Sender: TObject);
begin
// qGroups.close;
// qGroups.open;
end;

procedure TShowGroupStatForm.tsParamsShow(Sender: TObject);
var
  beeline_contacts:tstringlist;
  i:integer;
  stream:TmemoryStream;
begin
 try
   qGroupParams.Close;
   qGroupParams.ParamByName('group_id').AsInteger:=FGroupId;
   qGroupParams.open;
   beeline_contacts:=tstringlist.Create;
   beeline_contacts.Delimiter:='/';
   beeline_contacts.DelimitedText:=replaceStr(qGroupParams.FieldByName('ParamPDF_Contacts').AsString,' ','#');
    for i:=0  to beeline_contacts.Count-1 do
      if beeline_contacts.Strings[i]<>'empty' then
        sgParamsContacts.Cells[i div 3,i-3*(i div 3)]:=ReplaceStr(beeline_contacts.Strings[i],'#',' ');
   mParamsBankDet.Text:=qGroupParams.FieldByName('ParamPDF_BankDet').AsString;
   if TBlobField(qGroupParams.FieldByName('ParamPDF_Logo')).BlobSize > 0 then
     try
       stream:=TmemoryStream.Create;
       TBlobField(qGroupParams.FieldByName('ParamPDF_Logo')).SaveToStream(stream);
       stream.Position := 0;
       ImageLogo.Picture.Graphic:=TJPEGImage.Create;
       ImageLogo.Picture.Graphic.LoadFromStream(stream);
     finally
       stream.Free;
     end
   else
     ImageLogo.Picture:=nil;
   eParamsDetMail.Text:=qGroupParams.FieldByName('ParamDet_Mail').AsString;
   chkUssd_bal.Checked:=(qGroupParams.FieldByName('PARAMUSSD_GR_BAL').AsString='1');
   chkHand_block.Checked:=(qGroupParams.FieldByName('paramhand_block').AsString='1');
  NewDateEnd.Text:= qGroupParams.FieldByName('hand_block_date_end').AsString;
  smstime.MinData:= qGroupParams.FieldByName('start_sms_time').AsFloat;
  smstime.MaxData:= qGroupParams.FieldByName('end_sms_time').AsFloat;
  Hand_block_summ.Text:=qGroupParams.FieldByName('hand_block_summ').AsString;
  finally
    beeline_contacts.Free;
    qGroupParams.Close;
  end;

end;

procedure TShowGroupStatForm.tsBillsBeelineShow(Sender: TObject);
begin
  qBillsBeeline.Close;
  qBillsBeeline.ParamByName('group_id').AsInteger:=FGroupId;
  qBillsBeeline.open;
  qBillsBeelineDetail.Close;
  qBillsBeelineDetail.ParamByName('group_id').AsInteger:=FGroupId;
  qBillsBeelineDetail.open;
end;

procedure TShowGroupStatForm.tsPaymentsShow(Sender: TObject);
begin
  qpayments.Close;
  qPayments.ParamByName('group_id').AsInteger:=FGroupId;
  qpayments.open;
end;

end.

