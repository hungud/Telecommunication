unit ReportMonitorAutoTurnInternet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, main, Vcl.ActnList, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Menus, ShowUserStat, IntecExportGrid,
  Registry, ContractsRegistration_Utils, IniFiles;

type
  TSystemPath=(Desktop, StartMenu, Programs, Startup, Personal, winroot, winsys, AppData, Cache, TMP);
  Function GetSystemPath(SystemPath:TSystemPath):string;

type
  TReportMonitorAutoTurnInternetFrm = class(TForm)
    aList: TActionList;
    pMain: TPanel;
    PageControlMain: TPageControl;
    tsAlienOpts: TTabSheet;
    tsTurnAutoInternet: TTabSheet;
    pAlien: TPanel;
    pReq: TPanel;
    pDopInfo: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    SplitterDop: TSplitter;
    pPCKG: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    gReport: TCRDBGrid;
    gTurnLog: TCRDBGrid;
    gStat: TCRDBGrid;
    qReport: TOraQuery;
    dsReport: TDataSource;
    qTurnLog: TOraQuery;
    dsTurnLog: TDataSource;
    qStat: TOraQuery;
    dsStat: TDataSource;
    gReq: TCRDBGrid;
    gRemains_PCKG: TCRDBGrid;
    qReportUpdate: TOraQuery;
    pTurnAutoConnectInet: TPanel;
    aViewHelp: TAction;
    pBtnAlien: TPanel;
    pTurnConnect: TPanel;
    pBtnPCKG: TPanel;
    pBtnReq: TPanel;
    pBtnStat: TPanel;
    pBtnTurnLog: TPanel;
    bRefreshAlien: TSpeedButton;
    aRefresh: TAction;
    aLoadInExcel: TAction;
    aShowUserStatInfo: TAction;
    bLoadInExcelAlien: TSpeedButton;
    pBtnTurnAutoConnectInet: TPanel;
    gTurnAutoConnectInet: TCRDBGrid;
    qTurnAutoConnectInet: TOraQuery;
    dsTurnAutoConnectInet: TDataSource;
    bRefreshPCKG: TSpeedButton;
    bLoadInExcelPCKG: TSpeedButton;
    bRefreshReq: TSpeedButton;
    bLoadInExcelReq: TSpeedButton;
    bRefreshStat: TSpeedButton;
    bLoadInExcelStat: TSpeedButton;
    bRefreshTurnLog: TSpeedButton;
    bLoadInExcelTurnLog: TSpeedButton;
    bRefreshTurnConnect: TSpeedButton;
    bLoadInExcelTurnConnect: TSpeedButton;
    bTreated: TSpeedButton;
    aTreated: TAction;
    bAddLogicAlien: TSpeedButton;
    aAddLogic: TAction;
    bStartCheckConnectPCKG: TSpeedButton;
    bStartCheckConnectPCKGAll: TSpeedButton;
    aStartCheckConnectPCKG: TAction;
    aStartCheckConnectPCKGAll: TAction;
    ProgressBar: TProgressBar;
    pStatConnect: TPanel;
    Splitter3: TSplitter;
    Label2: TLabel;
    bShowUserStatInfoAlien: TSpeedButton;
    bDetailInfoAlien: TSpeedButton;
    bShowUserStatInfoTurnCon: TSpeedButton;
    bDetailInfoTurnCon: TSpeedButton;
    aDetailInfoBtn: TAction;
    bViewHelp: TSpeedButton;
    bViewHelpAlien: TSpeedButton;
    aRefreshPCKG: TAction;
    aRefreshReq: TAction;
    aRefreshTurnLog: TAction;
    aRefreshStat: TAction;
    aLoadInExcelPCKG: TAction;
    aLoadInExcelReq: TAction;
    aLoadInExcelTurnLog: TAction;
    aLoadInExcelStat: TAction;
    spGprsCheckPhoneTariff: TOraStoredProc;
    bAddLogicTurn: TSpeedButton;
    qTariffCode: TOraQuery;
    qRemains_PCKG: TOraQuery;
    qReq: TOraQuery;
    dsRemains_PCKG: TDataSource;
    dsReq: TDataSource;
    tsSelectionOptions: TTabSheet;
    pBtnSelect: TPanel;
    pPhone: TPanel;
    mSelectOptions: TMemo;
    edtPhone: TEdit;
    bSelectOptions: TBitBtn;
    bViewHelpSelectOpt: TSpeedButton;
    aSelectOptions: TAction;
    qSelectionOpt: TOraQuery;
    qFile: TOraQuery;
    tsConfines: TTabSheet;
    gConfines: TCRDBGrid;
    tsDisconnect: TTabSheet;
    gDisconnect: TCRDBGrid;
    pBtnDisconnect: TPanel;
    bShowUserStatInfoConf: TSpeedButton;
    bRefreshConf: TSpeedButton;
    bLoadInExcelConf: TSpeedButton;
    bViewHelpConf: TSpeedButton;
    pBtnConfines: TPanel;
    bShowUserStatInfoDis: TSpeedButton;
    bRefreshDis: TSpeedButton;
    bLoadInExcelDis: TSpeedButton;
    bViewHelpDis: TSpeedButton;
    qConfines: TOraQuery;
    dsConfines: TDataSource;
    qDisconnect: TOraQuery;
    dsDisconnect: TDataSource;
    pStatusWorkJob: TPanel;
    lbState: TLabel;
    spAddLogic: TOraStoredProc;
    qWORK_J_GPRS_CHECK_FLOW_TURN_OFF: TOraQuery;
    lbTimeWork: TLabel;
    lbStatus: TLabel;
    tsErrorConnectPCKG: TTabSheet;
    gErrorConnectPCKG: TCRDBGrid;
    pBtnErrorConnectPCKG: TPanel;
    bShowUserStatInfoErr: TSpeedButton;
    bRefreshErr: TSpeedButton;
    bLoadInExcelErr: TSpeedButton;
    bViewHelpErr: TSpeedButton;
    qErrorConnectPCKG: TOraQuery;
    dsErrorConnectPCKG: TDataSource;
    bHandleErrorConnectPhone: TSpeedButton;
    aHandleErrorConnectPhone: TAction;
    spHandleErrorConnect: TOraStoredProc;
    aHandleErrorConnectAll: TAction;
    bHandleErrorConnectAll: TSpeedButton;
    prbErrConnectPCKG: TProgressBar;
    lbInfo: TLabel;
    lbStart: TLabel;
    lbNoStart: TLabel;
    lbWorked: TLabel;
    lbResNoError: TLabel;
    lbResError: TLabel;
    lbNoRes: TLabel;
    lbCountStream: TLabel;
    lbRepeat: TLabel;
    bTurnOffPhoneError: TSpeedButton;
    aTurnOffPhoneError: TAction;
    spTurnOffPhoneError: TOraStoredProc;
    qGPRS_TURN_OFF_PHN_ERR_LOG: TOraQuery;
    lbCountLog: TLabel;
    lbCountLogNoErr: TLabel;
    lbCountLogErr: TLabel;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure qTurnLogBeforeOpen(DataSet: TDataSet);
    procedure qTurnLogAfterScroll(DataSet: TDataSet);
    procedure qReportAfterScroll(DataSet: TDataSet);
    procedure qStatBeforeOpen(DataSet: TDataSet);
    procedure gReportDblClick(Sender: TObject);
    procedure aViewHelpExecute(Sender: TObject);
    procedure aTreatedExecute(Sender: TObject);
    procedure aAddLogicExecute(Sender: TObject);
    procedure aStartCheckConnectPCKGExecute(Sender: TObject);
    procedure aStartCheckConnectPCKGAllExecute(Sender: TObject);
    procedure aDetailInfoBtnExecute(Sender: TObject);
    procedure qTurnAutoConnectInetAfterScroll(DataSet: TDataSet);
    procedure aRefreshPCKGExecute(Sender: TObject);
    procedure aRefreshReqExecute(Sender: TObject);
    procedure aRefreshTurnLogExecute(Sender: TObject);
    procedure aRefreshStatExecute(Sender: TObject);
    procedure aLoadInExcelPCKGExecute(Sender: TObject);
    procedure aLoadInExcelReqExecute(Sender: TObject);
    procedure aLoadInExcelTurnLogExecute(Sender: TObject);
    procedure aLoadInExcelStatExecute(Sender: TObject);
    procedure gTurnAutoConnectInetDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControlMainChange(Sender: TObject);
    procedure qRemains_PCKGBeforeOpen(DataSet: TDataSet);
    procedure qReqBeforeOpen(DataSet: TDataSet);
    procedure aSelectOptionsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gConfinesDblClick(Sender: TObject);
    procedure gDisconnectDblClick(Sender: TObject);
    procedure gErrorConnectPCKGDblClick(Sender: TObject);
    procedure aHandleErrorConnectPhoneExecute(Sender: TObject);
    procedure aHandleErrorConnectAllExecute(Sender: TObject);
    procedure aTurnOffPhoneErrorExecute(Sender: TObject);
  private
    { Private declarations }
    PersonalPath : string; //путь сохранения файла справки
    sFileName : string;    //имя файла справки
    FVisDopInfoAlien,
    FVisDopInfoTurn : boolean;
  public
    { Public declarations }
    procedure RefreshDopInfo; //обновления данных дополнительной информации
    procedure LoadDataInExcel(gGrid: TCRDBGrid; pNameTitle: string); //выгрузка данных в excel
    procedure AddRecordInlogic(qS: TOraQuery; pTariff_Code: string); //добавление записи в логику автоподключение
    procedure ShowDopInfo(pVis: boolean); //процедура скрытия/показа дополнительной информации
    function  VisDopInfo : boolean; //функция определения признака показа доп. информации в зависимости от вкладки
    procedure RefreshDisconnectOpt; //обновление данных вкладки ошибки отключения интернет-опций
  end;

var
  ReportMonitorAutoTurnInternetFrm: TReportMonitorAutoTurnInternetFrm;

  procedure DoReportMonitorAutoTurnInternet;
  procedure ReadIniAny(const pFileName, Section, Param: String; var pValue: String);
  procedure WriteIniAny(const pFileName, Section, Param, pValue: String);

implementation

{$R *.dfm}

//определяем путь сохранения файла справки
//сохраняем в папку Documents на диске C
Function GetSystemPath(SystemPath:TSystemPath):string;
var
  p:pchar;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', True);
    case SystemPath of
    Desktop:
      Result := Reg.ReadString('Desktop');
    StartMenu:
      Result := Reg.ReadString('Start Menu');
    Programs:
      Result := Reg.ReadString('Programs');
    Startup:
      Result := Reg.ReadString('Startup');
    Personal:
      Result := Reg.ReadString('Personal');
    AppData:
      Result := Reg.ReadString('AppData');
    Cache:
      Result := Reg.ReadString('Cache');
    Winroot:
      begin
        GetMem(p,255);
        GetWindowsDirectory(p,254);
        result := StrPas(p);
        Freemem(p);
      end;
    WinSys:
      begin
        GetMem(p,255);
        GetSystemDirectory(p,254);
        result := StrPas(p);
        Freemem(p);
      end;
    TMP:
      begin
        GetMem(p,255);
        GetTempPath(254,p);
        result := StrPas(p);
        Freemem(p);
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.free;
  end;
  if (result<>'') and (result[length(result)]<>'\') then
    result:=result+'\';
end;

//подготовка формы и ее показ
procedure DoReportMonitorAutoTurnInternet;
var ReportFrm : TReportMonitorAutoTurnInternetFrm;
begin
  //создаем форму
  ReportFrm := TReportMonitorAutoTurnInternetFrm.Create(Nil);
  try
    //указываем активную панель
    ReportFrm.PageControlMain.ActivePage := ReportFrm.tsAlienOpts;
    //скрываем доп информацию
    ReportFrm.pDopInfo.Visible := false;
    ReportFrm.SplitterDop.Visible := false;
    //признак показа/скрытия доп инфы для каждой вкладки, указываем что панель доп. инфы скрыта
    ReportFrm.FVisDopInfoAlien := false;
    ReportFrm.FVisDopInfoTurn := false;
    //получаем данные
    ReportFrm.qReport.Close;
    ReportFrm.qReport.Open;
    //показываем форму
    ReportFrm.ShowModal;
  finally
    //уничтожаем форму
    ReportFrm.Free;
  end;
end;

//функция определения признака показа доп. информации в зависимости от вкладки
function TReportMonitorAutoTurnInternetFrm.VisDopInfo : boolean;
begin
  Result := false;
  //в зависимости от активной панели
  if PageControlMain.ActivePage = tsAlienOpts then
    Result := FVisDopInfoAlien
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
      Result := FVisDopInfoTurn
end;

//обновление доп. информации (детальной)
procedure TReportMonitorAutoTurnInternetFrm.RefreshDopInfo;
begin
  //ориентируемся на признак показа панели доп. инфы в зависимости от вклдаки
  if VisDopInfo then
  begin
    qReq.Close;
    qReq.Open;
    qTurnLog.Close;
    qTurnLog.Open;
    //получаем данные по остаткам пакетов, данные получаем по rest_api
    //в связи с этим, осущ. проверку на ошибки
    try
      qRemains_PCKG.Close;
      qRemains_PCKG.Open;
    except
      showmessage('Ошибка обновления остатков по пакетам! Попробуйте обновить данные вручную!');
    end;
  end;
end;

//обновление данных дополнительной информации
procedure TReportMonitorAutoTurnInternetFrm.qReportAfterScroll(
  DataSet: TDataSet);
begin
  RefreshDopInfo;
end;

//обновление данных дополнительной информации
procedure TReportMonitorAutoTurnInternetFrm.qTurnAutoConnectInetAfterScroll(
  DataSet: TDataSet);
begin
  RefreshDopInfo;
end;

procedure TReportMonitorAutoTurnInternetFrm.RefreshDisconnectOpt;
var pStart, pNoStart, pWorked,
    pResNoError, pResError, pNoRes,
    i, pCountLogNoErr, pCountLogErr: integer;
    pTimeWork: string;
begin
  qDisconnect.Close;
  qDisconnect.Open;

  qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.Close;
  qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.Open;

  //заполняем данные по механизму отключения интернет-опций
  lbStart.Caption := 'запущенно - ';
  lbNoStart.Caption := 'не запущенно - ';
  lbWorked.Caption := 'отработанно - ';
  lbResNoError.Caption := 'без ошибок - ';
  lbResError.Caption := 'с ошибками - ';
  lbNoRes.Caption := 'не выполнялись - ';
  lbTimeWork.Caption := 'Макс. время работы: ';
  lbCountStream.Caption := 'Количество потоков механизма: ';

  pStart := 0;
  pNoStart := 0;
  pWorked := 0;
  presNoError := 0;
  pResError := 0;
  pNoRes := 0;
  pTimeWork := '-';
  i := 1;
  //пробегаем по всем потокам механизма отключения
  if not qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.IsEmpty then
  begin
    qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.First;
    while not (qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.Eof) do
    begin
      //необходимы только работа текущей даты
      if (not qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_START_DATE').IsNull) and
         (qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_START_DATE').AsString = FormatDateTime('dd.mm.yyyy', now)) then
      begin
        //статус работы
        if qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('STATE').AsString = 'DISABLED' then
          pNoStart := pNoStart + 1
        else
          //если задача в работе
          if qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('STATE').AsString = 'RUNNING' then
            pStart := pStart + 1
          else
            //если задача отработанна
            if qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('STATE').AsString = 'SCHEDULED' then
            begin
              pWorked := pWorked + 1;
              pNoStart := pNoStart + 1;
            end;

        //определяем результат выполнения (с ошибкой или без), т.е. если даже остановлена задача, то считаю ошибкой
        if qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('STATE').AsString <> 'RUNNING' then
        begin
          if qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('STATUS').AsString = 'SUCCEEDED' then
            presNoError := presNoError + 1
          else
            pResError := pResError + 1;
        end;

        //максимальное время работы
        if not qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_RUN_DURATION').IsNull then
        begin
          if i = 1 then
            pTimeWork := qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_RUN_DURATION').AsString
          else
            if pTimeWork < qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_RUN_DURATION').AsString then
              pTimeWork := qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.FieldByName('LAST_RUN_DURATION').AsString;
        end;
      end
      else
        begin
          pNoStart := pNoStart + 1;
          pNoRes := pNoRes + 1;
        end;

      //следующая строка
      qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.Next;
    end;
  end
  else
    begin
      pNoStart := qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.RecordCount;
      pNoRes := qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.RecordCount;
      pTimeWork := '-';
    end;

  //заполняем инфу
  lbStart.Caption := lbStart.Caption + inttostr(pStart);
  lbNoStart.Caption := lbNoStart.Caption + inttostr(pNoStart);
  lbWorked.Caption := lbWorked.Caption + inttostr(pWorked);
  lbResNoError.Caption := lbResNoError.Caption + inttostr(pResNoError);
  lbResError.Caption := lbResError.Caption + inttostr(pResError);
  lbNoRes.Caption := lbNoRes.Caption + inttostr(pNoRes);
  lbTimeWork.Caption := lbTimeWork.Caption + pTimeWork;
  lbCountStream.Caption := lbCountStream.Caption + inttostr(qWORK_J_GPRS_CHECK_FLOW_TURN_OFF.RecordCount);


  //заполняем данные по механизму повторного отключения опций
  lbCountLog.Caption := 'Количество попыток работы - ';
  lbCountLogNoErr.Caption := 'Удачно отработанных - ';
  lbCountLogErr.Caption := 'Ошибок - ';

  pCountLogNoErr := 0;
  pCountLogErr := 0;

  qGPRS_TURN_OFF_PHN_ERR_LOG.Close;
  qGPRS_TURN_OFF_PHN_ERR_LOG.Open;

  if not qGPRS_TURN_OFF_PHN_ERR_LOG.IsEmpty then
  begin
    qGPRS_TURN_OFF_PHN_ERR_LOG.First;
    while not (qGPRS_TURN_OFF_PHN_ERR_LOG.Eof) do
    begin
      if not qGPRS_TURN_OFF_PHN_ERR_LOG.FieldByName('DATE_END').IsNull then
        pCountLogNoErr := pCountLogNoErr +1
      else
        pCountLogErr := pCountLogErr + 1;

      //следующая строка
      qGPRS_TURN_OFF_PHN_ERR_LOG.Next;
    end;
  end;

  lbCountLog.Caption := lbCountLog.Caption + inttostr(qGPRS_TURN_OFF_PHN_ERR_LOG.RecordCount);
  lbCountLogNoErr.Caption := lbCountLogNoErr.Caption + inttostr(pCountLogNoErr);
  lbCountLogErr.Caption := lbCountLogErr.Caption + inttostr(pCountLogErr);
end;

//переключение между владками
procedure TReportMonitorAutoTurnInternetFrm.PageControlMainChange(
  Sender: TObject);

  procedure HideDopInfo;
  begin
    //обрабатываем вкладку чужих подкл.
    if (FVisDopInfoTurn) and (PageControlMain.ActivePage <> tsTurnAutoInternet) then
      pTurnAutoConnectInet.Align := alClient;
    //обрабатывае вкладку очереди подкл
    if (FVisDopInfoAlien) and (PageControlMain.ActivePage <> tsAlienOpts) then
      pAlien.Align := alClient;

    pDopInfo.Align := alRight;
    SplitterDop.Align := alRight;
    pDopInfo.Visible := false;
    SplitterDop.Visible := false;
  end;

var vCount: integer;
    vVis: boolean;
begin
  //при смене вкладок необходимо сварачивать панель доп. инфы на предыдущей вкладке если она показывалась
  //Для того, чтобы корректно отрисовывались формы при обновлении данных
  vCount := 0;
  vVis := false;
  //в зависимости от активной вкладки обновляем необходимые данные
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    //проверяем показывалась ли вкладка ранее
    //если не показывалась, то пропускаем все
    qReport.Close;
    qReport.Open;
    vCount := qReport.RecordCount;
    vVis := FVisDopInfoAlien;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      qTurnAutoConnectInet.Close;
      qTurnAutoConnectInet.Open;
      vCount := qTurnAutoConnectInet.RecordCount;
      vVis := FVisDopInfoTurn;
    end
    else
      if PageControlMain.ActivePage = tsConfines then
      begin
        //в виду того, что при получении данных по GPRS_U и ограничением скорости
        //производится загруска услуг по апи, введем дилог о необх. полученяи данных
        if MessageDlg('Получение данных о номерах с GPRS_U и ограничением скорости займет какое-то время!'+#13+'Продолжить получение данных?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          qConfines.Close;
          qConfines.Open;
        end;
      end
      else
        if PageControlMain.ActivePage = tsDisconnect then
        begin
          lbInfo.Caption := ' Работа потоков механизма отключения интернет-опций на ' + FormatDateTime('dd.mm.yyyy', now);
          RefreshDisconnectOpt;
        end
        else
          if PageControlMain.ActivePage = tsErrorConnectPCKG then
          begin
            qErrorConnectPCKG.Close;
            qErrorConnectPCKG.Open;
          end;

  //скрываем панели доп. инфы на неактивных вкладках
  HideDopInfo;

  //если вкладка показывалась
  if vVis then
  begin
    //проверяем количество записей в табл.
    //если записей нет, то скрываем доп. информацию. т.к. показывать нечего
    if vCount = 0 then
      ShowDopInfo(false)
    else
      ShowDopInfo(true);
  end;
end;

//показать/скрыть детальную информацию
procedure TReportMonitorAutoTurnInternetFrm.aDetailInfoBtnExecute(
  Sender: TObject);
var vis: boolean;
begin
  //проверяем признак показа в зависимости от активной вкладки
  if not VisDopInfo then
  begin
    vis := false;
    //определяем активную вкладку
    if PageControlMain.ActivePage = tsAlienOpts then
    begin
      if qReport.RecordCount > 0 then
      begin
        vis := true;
        FVisDopInfoAlien := true;
      end;
    end
    else
      if PageControlMain.ActivePage = tsTurnAutoInternet then
        if qTurnAutoConnectInet.RecordCount > 0 then
        begin
          vis := true;
          FVisDopInfoTurn := true;
        end;

    if vis then
    begin
      RefreshDopInfo; //обновляем данные по дополнительной информации
      ShowDopInfo(true);
      //RefreshDopInfo;
    end
    else
      showmessage('Отсутсвует номер для получения подробной информации!');
  end
  else
    ShowDopInfo(false);
end;

//обработка ошибок подключения на всех номерах (вкладка - Ошибки подключения интернет - опций)
procedure TReportMonitorAutoTurnInternetFrm.aHandleErrorConnectAllExecute(
  Sender: TObject);
var i: integer;
begin
  //пробегаем по всем записям грида и осущ проверку подкл.
  if qErrorConnectPCKG.RecordCount > 0 then
  begin
    i := qErrorConnectPCKG.RecNo;
    qErrorConnectPCKG.DisableControls;

    prbErrConnectPCKG.Min := 0;
    prbErrConnectPCKG.Max := qErrorConnectPCKG.RecordCount;
    prbErrConnectPCKG.Position := prbErrConnectPCKG.Min;
    qErrorConnectPCKG.First;
    while not qErrorConnectPCKG.EOF do
    begin
      spHandleErrorConnect.ParamByName('PPHONE_NUMBER').AsString := qErrorConnectPCKG.FieldByName('phone').AsString;
      try
        spHandleErrorConnect.ExecProc;
      except
        null;
      end;
      prbErrConnectPCKG.Position := prbErrConnectPCKG.Position + 1;
      qErrorConnectPCKG.Next;
    end;
    //обновляем
    qErrorConnectPCKG.Close;
    qErrorConnectPCKG.Open;

    qErrorConnectPCKG.RecNo := i;
    qErrorConnectPCKG.EnableControls;
  end;
end;

//обработка ошибок подключения по конкретному номеру (вкладка - Ошибки подключения интернет - опций)
procedure TReportMonitorAutoTurnInternetFrm.aHandleErrorConnectPhoneExecute(
  Sender: TObject);
begin
  if qErrorConnectPCKG.RecordCount > 0 then
  begin
    try
      spHandleErrorConnect.ParamByName('PPHONE_NUMBER').AsString := qErrorConnectPCKG.FieldByName('phone').AsString;
      spHandleErrorConnect.ExecProc;
    except
      null;
    end;
    //обновляем
    qErrorConnectPCKG.Close;
    qErrorConnectPCKG.Open;
  end;
end;

//процедура скрытия/показа дополнительной информации
procedure TReportMonitorAutoTurnInternetFrm.ShowDopInfo(pVis: boolean);
var pnlDop: TPanel;
begin
  //определяем панель активной вкладки
  if PageControlMain.ActivePage = tsAlienOpts then
    pnlDop := pAlien
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
      pnlDop := pTurnAutoConnectInet;

  //определяем действие - скрыть/показать
  if pVis then
  begin
    pnlDop.Align := alLeft;
    pnlDop.Width := 400;
    if pnlDop.Name = pAlien.Name then
    begin
      pDopInfo.Parent := tsAlienOpts;
      SplitterDop.Parent := tsAlienOpts;
      FVisDopInfoAlien := true;
      bDetailInfoAlien.Hint := 'Скрыть детальную информацию по автоподключениям';
    end
    else
      if pnlDop.Name = pTurnAutoConnectInet.Name then
      begin
        pDopInfo.Parent := tsTurnAutoInternet;
        SplitterDop.Parent := tsTurnAutoInternet;
        FVisDopInfoTurn := true;
        bDetailInfoTurnCon.Hint := 'Скрыть детальную информацию по автоподключениям';
      end;

    SplitterDop.Align := alLeft;
    pDopInfo.Align := alClient;
    pDopInfo.Visible := true;
    SplitterDop.Visible := true;
  end
  else
    begin
      //если панель на активной вкладке, то убираем ее
      if pDopInfo.Parent = PageControlMain.ActivePage then
      begin
        //определяем на чем лежит панель доп. инфы
        if pDopInfo.Parent.Name = tsAlienOpts.Name then
        begin
          pnlDop := pAlien;
          FVisDopInfoAlien := false;
          bDetailInfoAlien.Hint := 'Показать детальную информацию по автоподключениям';
        end
        else
          if pDopInfo.Parent.Name = tsTurnAutoInternet.Name then
          begin
            pnlDop := pTurnAutoConnectInet;
            FVisDopInfoTurn := false;
            bDetailInfoTurnCon.Hint := 'Показать детальную информацию по автоподключениям';
          end;

        pnlDop.Align := alClient;
        pDopInfo.Align := alRight;
        SplitterDop.Align := alRight;
        pDopInfo.Visible := false;
        SplitterDop.Visible := false;
      end;
    end;
end;

//обновляем данные по чужакам
procedure TReportMonitorAutoTurnInternetFrm.aRefreshExecute(Sender: TObject);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    qReport.Close;
    qReport.Open;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      qTurnAutoConnectInet.Close;
      qTurnAutoConnectInet.Open;
    end
    else
      if PageControlMain.ActivePage = tsConfines then
      begin
        qConfines.Close;
        qConfines.Open;
      end
      else
        if PageControlMain.ActivePage = tsDisconnect then
          RefreshDisconnectOpt
        else
          if PageControlMain.ActivePage = tsErrorConnectPCKG then
          begin
            qErrorConnectPCKG.Close;
            qErrorConnectPCKG.Open;
          end;
end;

//обновляем данные по пакетам
procedure TReportMonitorAutoTurnInternetFrm.aRefreshPCKGExecute(
  Sender: TObject);
begin
  qRemains_PCKG.Close;
  qRemains_PCKG.Open;
end;

//обновляем данные по заявкам на подключение
procedure TReportMonitorAutoTurnInternetFrm.aRefreshReqExecute(Sender: TObject);
begin
  qReq.Close;
  qReq.Open;
end;

//обновляем историю подключений
procedure TReportMonitorAutoTurnInternetFrm.aRefreshTurnLogExecute(
  Sender: TObject);
begin
  qTurnLog.Close;
  qTurnLog.Open;
end;

//обновляем статистику использования пакетов
procedure TReportMonitorAutoTurnInternetFrm.aRefreshStatExecute(
  Sender: TObject);
begin
  qstat.Close;
  qStat.Open;
end;

//выгрузка данных в Excel
procedure TReportMonitorAutoTurnInternetFrm.aLoadInExcelExecute(
  Sender: TObject);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
    LoadDataInExcel(gReport, 'Чужие подключения интернет-опций')
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
      LoadDataInExcel(gTurnAutoConnectInet, 'Очередь номеров на проверку автоподключения интернет-опций')
    else
      if PageControlMain.ActivePage = tsConfines then
        LoadDataInExcel(gConfines, 'Номера с GPRS_U и ограничением скорости')
      else
        if PageControlMain.ActivePage = tsDisconnect then
          LoadDataInExcel(gDisconnect, 'Ошибки отключения интернет-опций')
        else
          if PageControlMain.ActivePage = tsErrorConnectPCKG then
            LoadDataInExcel(gErrorConnectPCKG, 'Ошибки подключения интернет-опций');
end;

procedure TReportMonitorAutoTurnInternetFrm.aLoadInExcelPCKGExecute(
  Sender: TObject);
begin
  LoadDataInExcel(gRemains_PCKG, 'Остатки по пакетам');
end;

procedure TReportMonitorAutoTurnInternetFrm.aLoadInExcelReqExecute(
  Sender: TObject);
begin
  LoadDataInExcel(gReq, 'Журнал заявок на подключение/отключение услуг');
end;

procedure TReportMonitorAutoTurnInternetFrm.aLoadInExcelStatExecute(
  Sender: TObject);
begin
  LoadDataInExcel(gTurnLog, 'История автоподключения интернет-опций');
end;

procedure TReportMonitorAutoTurnInternetFrm.aLoadInExcelTurnLogExecute(
  Sender: TObject);
begin
  LoadDataInExcel(gStat, 'Статистика использования интернет-опций');
end;

//выгрузка данных в excel
procedure TReportMonitorAutoTurnInternetFrm.LoadDataInExcel(gGrid: TCRDBGrid; pNameTitle: string);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2(pNameTitle,'', gGrid, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

//пометка записи чужих подключений обработанной
procedure TReportMonitorAutoTurnInternetFrm.aTreatedExecute(Sender: TObject);
var i: integer;
begin
  if qReport.RecordCount > 0 then
  begin
    i := qReport.RecNo;
    qReport.DisableControls;

    //обновляем поле проверки
    qReportUpdate.ParamByName('pIS_CHECKED').AsInteger := 1;
    qReportUpdate.ParamByName('p_phone').AsString := qReport.FieldByName('phone').AsString;
    qReportUpdate.ParamByName('pALIEN_CODE').AsString := qReport.FieldByName('ALIEN_CODE').AsString;
    qReportUpdate.ParamByName('pCURR_CODE').AsString := qReport.FieldByName('CURR_CODE').AsString;
    qReportUpdate.ExecSQL;

    qReport.RecNo := i;
    qReport.EnableControls;

    //обновляем данные по соответствиям
    qReport.Close;
    qReport.Open;
  end;
end;

procedure TReportMonitorAutoTurnInternetFrm.aTurnOffPhoneErrorExecute(
  Sender: TObject);
begin
  //осущ отключение.
  if MessageDlg('Запустить механизм отключения интернет-опций?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      spTurnOffPhoneError.ExecProc;
    except
      null;
    end;

    //обновляем
    qDisconnect.Close;
    qDisconnect.Open;
  end;
end;

//добавление чужой опции в логику подкл.
procedure TReportMonitorAutoTurnInternetFrm.aAddLogicExecute(Sender: TObject);
var i, vCount: integer;
    qS: TOraQuery;
    s: string;
begin
  vCount := 0;
  //добавление интернет-опции в логику автоподключения очень важный момент
  //поэтому перед добавление спросим уверены ли они в подключении и не ошибся ли оператор
  s:= '';
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.RecordCount > 0 then
    begin
      s := qReport.FieldByName('ALIEN_CODE').AsString + ' на номере ' +  qReport.FieldByName('phone').AsString;
      vCount := qReport.RecordCount;
    end;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.RecordCount > 0 then
      begin
        //определяем тп на номере
        qTariffCode.Close;
        qTariffCode.ParamByName('PHONE_NUMBER').AsString := qTurnAutoConnectInet.FieldByName('phone').AsString;
        qTariffCode.Open;
        s := qTariffCode.FieldByName('TARIFF_CODE').AsString + ' на номере ' +  qTurnAutoConnectInet.FieldByName('phone').AsString;
        vCount := qTurnAutoConnectInet.RecordCount;
      end;
    end;

  //если в табл. имеются записи
  if vCount > 0 then
    if MessageDlg('Добавить ' + s + ' в логику автоподключения?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if PageControlMain.ActivePage = tsAlienOpts then
        AddRecordInlogic(qReport, qReport.FieldByName('ALIEN_CODE').AsString)
      else
        AddRecordInlogic(qTurnAutoConnectInet, qTariffCode.FieldByName('TARIFF_CODE').AsString);
    end;
end;

//добавление записи в логику автоподключение
procedure TReportMonitorAutoTurnInternetFrm.AddRecordInlogic(qS: TOraQuery; pTariff_Code: string);
var i: integer;
begin
  i := qS.RecNo;
  qS.DisableControls;


  spAddLogic.ParamByName('p_phone').AsString := qS.FieldByName('phone').AsString;
  spAddLogic.ParamByName('p_tariff_code').AsString := pTariff_Code;
  spAddLogic.ExecProc;

  qS.Close;
  qS.Open;

  qS.RecNo := i;
  qS.EnableControls;
  ShowMessage(spAddLogic.ParamByName('RESULT').AsString);
end;

//запуск номера на проверку автоподключения интернет-опции
procedure TReportMonitorAutoTurnInternetFrm.aStartCheckConnectPCKGExecute(
  Sender: TObject);
begin
  if qTurnAutoConnectInet.RecordCount > 0 then
  begin
    try
      spGprsCheckPhoneTariff.ParamByName('P_PHONE').AsString := qTurnAutoConnectInet.FieldByName('phone').AsString;
      spGprsCheckPhoneTariff.ExecProc;
    except
      null;
    end;
    //обновляем
    qTurnAutoConnectInet.Close;
    qTurnAutoConnectInet.Open;
  end;
end;

//запуск всех номеров на проверку автоподключения интернет-опции
procedure TReportMonitorAutoTurnInternetFrm.aStartCheckConnectPCKGAllExecute(
  Sender: TObject);
var i: integer;
begin
  //пробегаем по всем записям грида и осущ проверку подкл.
  if qTurnAutoConnectInet.RecordCount > 0 then
  begin
    i := qTurnAutoConnectInet.RecNo;
    qTurnAutoConnectInet.DisableControls;

    ProgressBar.Min := 0;
    ProgressBar.Max := qTurnAutoConnectInet.RecordCount;
    ProgressBar.Position := ProgressBar.Min;
    qTurnAutoConnectInet.First;
    while not qTurnAutoConnectInet.EOF do
    begin
      spGprsCheckPhoneTariff.ParamByName('P_PHONE').AsString := qTurnAutoConnectInet.FieldByName('phone').AsString;
      try
        spGprsCheckPhoneTariff.ExecProc;
      except
        null;
      end;
      ProgressBar.Position := ProgressBar.Position + 1;
      qTurnAutoConnectInet.Next;
    end;
    //обновляем
    qTurnAutoConnectInet.Close;
    qTurnAutoConnectInet.Open;

    qTurnAutoConnectInet.RecNo := i;
    qTurnAutoConnectInet.EnableControls;
  end;
end;

//справка
procedure TReportMonitorAutoTurnInternetFrm.aViewHelpExecute(Sender: TObject);
var h : HWND; // идентификатор (дескриптор)
    pDiv : integer; //какой раздел справки открыть
begin
  h := FindWindow('HH Parent','Справка');
  if h = 0 then
  begin
    pDiv := 1;
    //определяем активную вкладку
    if PageControlMain.ActivePage = tsErrorConnectPCKG then
      pDiv := 5
    else
      if PageControlMain.ActivePage = tsDisconnect then
        pDiv := 4
      else
        if PageControlMain.ActivePage = tsAlienOpts then
          pDiv := 2
        else
          if PageControlMain.ActivePage = tsTurnAutoInternet then
            pDiv := 3
          else
            if PageControlMain.ActivePage = tsSelectionOptions then
              pDiv := 1;

    WinExec(PAnsiChar(AnsiString('hh.exe - mapid ' + inttostr(pDiv) + ' ' + PersonalPath + sFileName)), SW_RESTORE);
  end
  else
  begin
    ShowWindow(h,SW_RESTORE);
    SetForegroundWindow(h);
  end;
end;

//при закрытии формы необходимо также закрыть справку если она открыта
procedure TReportMonitorAutoTurnInternetFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var h: HWND;
begin
  h := FindWindow('HH Parent','Справка');
  //открыто окно справочной информации
  if h <> 0 then
    SendMessage(h,WM_CLOSE,0,0);
end;

procedure ReadIniAny(const pFileName, Section, Param: String;
  var pValue: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      pValue := Ini.ReadString(Section, Param, '');
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    pValue := '';
  end;
end;

procedure WriteIniAny(const pFileName, Section, Param, pValue: String);
var
  Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(pFileName, '.INI'));
    try
      Ini.WriteString(Section, Param, pValue);
    finally
      Ini.Free;
    end;
  except // глотаем ошибку
    ;
  end;
end;

procedure TReportMonitorAutoTurnInternetFrm.FormCreate(Sender: TObject);
var StrmSrc: TStream;
    StrmDst: TStream;
    sLoad: string;
begin
  //необходимо проверить "свежесть" справки
  //данные по загрузке файла справки хранится в ini файле
  //получаем файл справки chm
  qFile.Close;
  qFile.Open;

  if qFile.RecordCount > 0 then
  begin
    sFileName := 'Help.chm';
    PersonalPath := GetSystemPath(Personal);//путь хранения файла

    //если файл справки отсутствует, то записываем его и указываем дату файла спрвки в ini файле
    if not FileExists(PersonalPath + sFileName) then
    begin
      WriteIniAny(Application.ExeName, 'HELP FILE', 'DATE_LAST_UPDATED', qFile.FieldByName('DATE_LAST_UPDATED').AsString);
      SaveBlobFile(PersonalPath, sFileName, qFile, qFile.FieldByName('FILE_CLB'));
    end
    else  //провеярем свежесть файла справки
      begin
        //считываем дату из ini файла в виде строки
        ReadIniAny(Application.ExeName, 'HELP FILE', 'DATE_LAST_UPDATED', sLoad);
        if sLoad <> qFile.FieldByName('DATE_LAST_UPDATED').AsString then
          SaveBlobFile(PersonalPath, sFileName, qFile, qFile.FieldByName('FILE_CLB'));
      end;
  end;
end;

//подбор интернет-опции
procedure TReportMonitorAutoTurnInternetFrm.aSelectOptionsExecute(
  Sender: TObject);
var i: integer;
    err: boolean;
begin
  //проверяем корректность ввода номера
  err := true;
  if Length(edtPhone.Text) = 10 then
  begin
    //проверяем на то, чтобы все символы были цифрами
    for i := 1 to Length(edtPhone.Text) do
      if not (edtPhone.Text[i] in ['0'..'9']) then
        err := false;
  end
  else
    err := false;

  if err then
  begin
    //проверяем на то, чтобы на номере был тариф с автоподключением пакетов
    qTariffCode.Close;
    qTariffCode.ParamByName('PHONE_NUMBER').AsString := edtPhone.Text;
    qTariffCode.Open;

    if not qTariffCode.IsEmpty then
    begin
      qSelectionOpt.Close;
      qSelectionOpt.ParamByName('p_phone').AsString := edtPhone.Text;
      qSelectionOpt.Open;
      mSelectOptions.Clear;
      mSelectOptions.Text := qSelectionOpt.FieldByName('v_data').AsString;
    end
    else
      showmessage('На номер тарифный план не с автоподключением интернет-опций!');
  end
  else
    showmessage('Номер введен не корректно!');
end;

//остатки
procedure TReportMonitorAutoTurnInternetFrm.qRemains_PCKGBeforeOpen(
  DataSet: TDataSet);
begin
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.RecordCount > 0 then
      qRemains_PCKG.ParamByName('p_phone').AsString:= qReport.FieldByName('phone').AsString;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.RecordCount > 0 then
        qRemains_PCKG.ParamByName('p_phone').AsString:= qTurnAutoConnectInet.FieldByName('phone').AsString;
    end;
end;

//показываем заявки на подкл./откл.
procedure TReportMonitorAutoTurnInternetFrm.qReqBeforeOpen(DataSet: TDataSet);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.RecordCount > 0 then
      qReq.ParamByName('PHONE_NUMBER').AsString := qReport.FieldByName('phone').AsString;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.RecordCount > 0 then
        qReq.ParamByName('PHONE_NUMBER').AsString := qTurnAutoConnectInet.FieldByName('phone').AsString;
    end;

  qReq.ParamByName('RETARIF').AsInteger := 1;//админская привелегия
end;

//показываем историю автоподключений
procedure TReportMonitorAutoTurnInternetFrm.qTurnLogBeforeOpen(
  DataSet: TDataSet);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.RecordCount > 0 then
      qTurnLog.ParamByName('p_phone').AsString:= qReport.FieldByName('phone').AsString;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.RecordCount > 0 then
        qTurnLog.ParamByName('p_phone').AsString:= qTurnAutoConnectInet.FieldByName('phone').AsString;
    end;
end;

//показывам статистику исп. пакетов
procedure TReportMonitorAutoTurnInternetFrm.qStatBeforeOpen(DataSet: TDataSet);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.RecordCount > 0 then
      qStat.ParamByName('p_phone').AsString:= qReport.FieldByName('phone').AsString;
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.RecordCount > 0 then
        qStat.ParamByName('p_phone').AsString:= qTurnAutoConnectInet.FieldByName('phone').AsString;
    end;

  qStat.ParamByName('pturn_log_id').AsInteger:= qTurnLog.FieldByName('LOG_ID').AsInteger;
end;

//при показе истории подкл. показываем статистику исп. пакетов
procedure TReportMonitorAutoTurnInternetFrm.qTurnLogAfterScroll(
  DataSet: TDataSet);
begin
  qStat.Close;
  qStat.Open;
end;

//показываем карточку абонента
procedure TReportMonitorAutoTurnInternetFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  //определяем активную вкладку
  if PageControlMain.ActivePage = tsAlienOpts then
  begin
    if qReport.Active and (qReport.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE').AsString, 0);
  end
  else
    if PageControlMain.ActivePage = tsTurnAutoInternet then
    begin
      if qTurnAutoConnectInet.Active and (qTurnAutoConnectInet.RecordCount > 0) then
        ShowUserStatByPhoneNumber(qTurnAutoConnectInet.FieldByName('PHONE').AsString, 0);
    end
    else
      if PageControlMain.ActivePage = tsConfines then
      begin
        if qConfines.Active and (qConfines.RecordCount > 0) then
          ShowUserStatByPhoneNumber(qConfines.FieldByName('PHONE').AsString, 0);
      end
      else
        if PageControlMain.ActivePage = tsDisconnect then
        begin
          if qDisconnect.Active and (qDisconnect.RecordCount > 0) then
            ShowUserStatByPhoneNumber(qDisconnect.FieldByName('PHONE').AsString, 0);
        end
        else
          if PageControlMain.ActivePage = tsErrorConnectPCKG then
          begin
            if qErrorConnectPCKG.Active and (qErrorConnectPCKG.RecordCount > 0) then
              ShowUserStatByPhoneNumber(qErrorConnectPCKG.FieldByName('PHONE').AsString, 0);
          end;
end;

//по двойному щелчку мышью по записи чужих подкл. открываем карточку абонента
procedure TReportMonitorAutoTurnInternetFrm.gConfinesDblClick(Sender: TObject);
begin
  aShowUserStatInfo.Execute;
end;

procedure TReportMonitorAutoTurnInternetFrm.gDisconnectDblClick(
  Sender: TObject);
begin
  aShowUserStatInfo.Execute;
end;

procedure TReportMonitorAutoTurnInternetFrm.gErrorConnectPCKGDblClick(
  Sender: TObject);
begin
  aShowUserStatInfo.Execute;
end;

procedure TReportMonitorAutoTurnInternetFrm.gReportDblClick(Sender: TObject);
var i: integer;
begin
  aShowUserStatInfo.Execute;
end;

//по двойному щелчку мышью по записи очереди подкл. открываем карточку абонента
procedure TReportMonitorAutoTurnInternetFrm.gTurnAutoConnectInetDblClick(
  Sender: TObject);
begin
  aShowUserStatInfo.Execute;
end;

end.
