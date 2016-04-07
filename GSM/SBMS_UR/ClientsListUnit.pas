unit ClientsListUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls,
   OleCtrls, SHDocVw, mshtml, IniFiles, ToolWin, ComCtrls, DBCtrls, comobj,
  Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MemoLog: TMemo;
    WebBrowser1: TWebBrowser;
    DoMainWork: TButton;
    OpenDialog1: TOpenDialog;
    StopProcess: TCheckBox;
    AddNextBut: TButton;
    SpinEdit1: TSpinEdit;
    PhoneNumber: TLabel;
    SaveBut: TButton;
    AddAllNext: TButton;
    Label1: TLabel;
    procedure DoMainWorkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddAllNextClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AddNextButClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SaveButClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(MesText:string);
    procedure WaitProcessMessage(WaitSec:integer);
    procedure Reconnect;

  end;

  
  
var
  Form1: TForm1;
  Site_www:string;
  Base_path:string;
  path_dir:string;
  comliteLoad:boolean;
  Ident_Login:string;
  Ident_pass:string;
  Form_Name:string;
  Form_Adress:string;
  Form_Street:string;
  Form_House:string;
  Form_Korpus:string;
  Form_OfficeNumber:string;
  Form_FIO:string;
  Form_BankName:string;
  Form_AccountNumber:string;
  Form_INN:string;
  Form_KPP:string;
  Form_KorSch:string;
  Form_OGRN:string;
  Form_TypeClient:string;
  Form_IsResident:string;
  Form_FIO2:string;
  Form_BIC:string;
  PopupFormNeedSetAbonInfo : string;
  PopupForm_FIO:string;
  PopupForm_BirthDay:string;
  PopupForm_Serial:string;
  PopupForm_Number:string;
  PopupForm_OrganV:string;
  PopupForm_House:string;
  PopupForm_Flat:string;
  PopupForm_Country:string;
  PopupForm_City:string;
  PopupForm_Sex:string;
  PopupForm_PasDate:string;
  PopupForm_FixTarif:integer;
  PopupForm_IDDocum:string;
  Common_WaitTimeOut:integer;
  Common_SaveTimeOut:integer;

  excel: variant;
  ListTarifs:TStringList;
  ListTarifNames:TStringList;
  GlobalExcelIndex:integer;
  stdErr:boolean;

implementation

{$R *.dfm}

procedure TForm1.AddAllNextClick(Sender: TObject);
var
  i:integer;
begin
  Application.ProcessMessages;
  for i := GlobalExcelIndex to Excel.WorkBooks[1].WorkSheets[1].Cells.CurrentRegion.Rows.Count do
  begin
    if StopProcess.Checked then
    begin
      StopProcess.Checked:=false;
      exit;
    end;
    try
      AddNextButClick(self);
      if not ((pos('Регистрационные данные по данному телефону уже внесены',Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4])>0)
      or (pos('Успешно сохранён.',Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4])>0)) then
        WaitProcessMessage(Common_WaitTimeOut);

      if SaveBut.Enabled then
        SaveButClick(self);

    except
      AddLog('Переконнект. Начало...');
      Reconnect;
      AddLog('Переконнект. Успешно выполнен.');
    end;

    if not((pos('Регистрационные данные по данному телефону уже внесены',Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4])>0)
    or (pos('Успешно сохранён.',Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4])>0)) then
     WaitProcessMessage(Common_WaitTimeOut);

  end;
end;

procedure TForm1.AddNextButClick(Sender: TObject);
var
  //a:  variant;
  //Win,  Doc,  Sel:  Variant;
  HTML_Doc: IHTMLDocument2;
  ovElements: OleVariant;
  Window: IHTMLWindow2;
  frame: Olevariant;
  framePopup: Olevariant;
  i:integer;
  iDisp : IDispatch;
  iElement : IHTMLElement;
  frameDispatch:IDispatch;
  childWindow: IHTMLWindow2;
  iDoc : IHtmlDocument2;
  tempstr :string;
  tempgetvaluetarif :integer;
  tariff_name : string;


  procedure WaitReadyState;
  begin
    while WebBrowser1.ReadyState < READYSTATE_COMPLETE do
      Application.ProcessMessages;
  end;





  function WaitSearchElement(nameEl:string; timeout:integer):boolean;
   var
    ii : integer;
    d1,d2:TDatetime;
    sec:integer;
    isSearch:boolean;
  begin
    isSearch:=false;
    d1:=now;
    while not isSearch do
    begin
       //проверка на timeout
      if timeout>0 then
      begin
        d2:=now;
        Sec := Round( (D2 - D1) * 24 * 60 * 60 );
        if Sec>timeout then
        begin
          AddLog('Превышено время ожидания элемента '+nameEl+'.');
          Result := false;
          isSearch:=true;
          Raise Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [nameEl]);
        end;
      end;

      Application.ProcessMessages;
      for ii:=1 to HTML_Doc.All.Get_length do
      begin
        //Application.ProcessMessages;
        Application.ProcessMessages;
        iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        if assigned(iElement) then
        begin
          //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          if iElement.id=nameEl then
          begin
            isSearch:=true;
            Result:=true;
            Break;
          end;
        end;
      end;
    end;
  end;

  Function FindInFrame(nameEl:string):boolean;
  var
    ii:integer;
    IsErrorInner:boolean;
  begin
    comliteLoad:=false;
    IsErrorInner:=false;
    while not comliteLoad do
    begin
      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp:=iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';

        if assigned(iElement) then
        begin
          //if trim(iElement.id)<>'' then MemoLog.Lines.Add(iElement.id);
          if iElement.id=nameEl then
          begin
            comliteLoad:=true;
            IsErrorInner:=true;
            Break;
          end;
        end;
      end;
    end;
    //end;
    FindInFrame:=IsErrorInner;

  end;

  procedure FillFrameField(FieldId : string; FieldValue:string);
  var
    itm: OleVariant;
  begin
    itm := Frame.getelementbyid(FieldId);	//нужный элемент
    itm.value:=FieldValue;//номер сим карты '89701026589083615';
  end;

  procedure FillFramePopupField(FieldId : string; FieldValue:string);
  var
    itm: OleVariant;
  begin
    itm := framePopup.getelementbyid(FieldId);	//нужный элемент
    itm.value := FieldValue;//номер сим карты '89701026589083615';
  end;



  procedure WaitSearch;
  var
    ii : integer;
    d1, d2:TDatetime;
    sec: integer;
    isSearch: boolean;
  begin
    isSearch := false;
    d1 := now;
    while not isSearch do
    begin
      //проверка на timeout
      d2:=now;
      Sec := Round( (D2 - D1) * 24 * 60 * 60 );
      if Sec>30 then
      begin
        AddLog('Превышено время ожидания 1.');
        isSearch:=true;
        Raise Exception.Create('Превышено время ожидания 1. ');
      end;

      Application.ProcessMessages;
      for ii:=1 to HTML_Doc.All.Get_length do
      begin
        Application.ProcessMessages;
        iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';
        if assigned(iElement) then
        begin
          //S:=S+'tag='+iElement.Get_tagName+' ';
          AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          if (iElement.id='shell.modal_busy_container') then
            if iElement.style.display='block' then
              isSearch := true;
            break;
        end;
      end;
    end;
  end;

  procedure Wait5Sec;
  var
    d1,d2:TDatetime;
    sec:integer;
    isSearch:boolean;
  begin
    isSearch:=false;
    d1:=now;
    while not isSearch do
    begin
      //проверка на timeout
      d2 := now;
      Sec := Round( (D2 - D1) * 24 * 60 * 60 );
      if Sec > 5 then
        break;
    end;
  end;



  function getvaluetarif(val:string):integer;
  var
    indexOf:integer;
    tempStr:string;
    posravno:integer;
    len:integer;
  begin
    indexOf:=-1;
    if not ListTarifNames.Find(val,indexOf) then
    begin
      AddLog('Ошибка определения тарифа. Проверьте соответствие тарифа в файле Excel тарифам в настройках.');
      getvaluetarif:=-1;
      exit;
    end;
    posravno:=pos('=', ListTarifs[indexOf]);
    len:=length(ListTarifs[indexOf]);
    tempstr:=copy(ListTarifs[indexOf],posravno+1,len-posravno);
    //
    getvaluetarif:=StrToInt(tempstr);
  end;

  Function CompleteLoadAndCheckError(mes:string):boolean;
  var
    ii:integer;
    IsErrorInner:boolean;
    tempStr:string;
    iTable:IHTMLTable;
    numstr:string;

  begin
    numstr:=Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,2];
    comliteLoad:=false;
    IsErrorInner:=false;
    while not comliteLoad do
    begin
      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp := iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';
        if assigned(iElement) then
        begin
          //S:=S+'tag='+iElement.Get_tagName+' ';
          iElement.QueryInterface(IHTMLtable,iTable);
          if assigned(iTable) then
          begin
            if (iElement.id='error_div') then
            begin
              comliteLoad:=true;
              if iElement.style.getAttribute( 'display', 0 )='none' then
                AddLog('Номер '+numstr+'. Ошибок поиска '+mes+' нет.');
            end;
            //sleep(1000);
            //Application.ProcessMessages;
            if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then
            begin
              tempStr:=iElement.innerText;
              //AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+tempStr);
              //ADOQuery1.Edit;
              if pos('Регистрационные данные по данному телефону уже внесены',tempStr)>0 then
              begin
                AddLog('Номер '+numstr+'. '+tempStr) ;
                Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]:=tempStr;
                Excel.WorkBooks[1].save;
                stdErr:=true;
              end
              else if pos('Некорректная операция с предактивированным комплектом',tempStr)>0 then
              begin
                AddLog('Номер '+numstr+'. Некорректная операция с предактивированным комплектом.');
                Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]:='Некорректная операция с предактивированным комплектом.';
                Excel.WorkBooks[1].save;
                stdErr:=true;
              end
              else
              begin
                AddLog(tempStr);
                stdErr:=false;
              end;
              //ShowMessage('ошибка!!!');
              IsErrorInner:=true;
              break;
            end;
          end;
        end;
      end;
    end;

    CompleteLoadAndCheckError:=IsErrorInner;
  end;

  Function CheckDisabled(Elname:string):boolean;
  var
    ii:integer;
  begin
    comliteLoad := false;

    while not comliteLoad do
    begin
      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp:=iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        if assigned(iElement) then
        begin
          if (iElement.id=Elname) then
          begin
            if (iElement.style.getAttribute( 'disabled', 0 )='') then
              Result := true
            else
              Result := false;
           //ShowMessage('ошибка!!!');

            comliteLoad := true;
            break;
          end;
        end;
      end;
    end;
  end;

  function GetElementById(const Doc: IDispatch; const Id: string): IDispatch;
  var
    Document: IHTMLDocument2;     // IHTMLDocument2 interface of Doc
    Body: IHTMLElement2;          // document body element
    Tags: IHTMLElementCollection; // all tags in document body
    Tag: IHTMLElement;            // a tag in document body
    I: Integer;                   // loops thru tags in document body
  begin
    Result := nil;
    // Check for valid document: require IHTMLDocument2 interface to it
    if not Supports(Doc, IHTMLDocument2, Document) then
      raise Exception.Create('Invalid HTML document');
    // Check for valid body element: require IHTMLElement2 interface to it
    if not Supports(Document.body, IHTMLElement2, Body) then
      raise Exception.Create('Can''t find <body> element');
    // Get all tags in body element ('*' => any tag name)
    Tags := Body.getElementsByTagName('*');
    // Scan through all tags in body
    for I := 0 to Pred(Tags.length) do
    begin
      // Get reference to a tag
      Tag := Tags.item(I, EmptyParam) as IHTMLElement;
      // Check tag's id and return it if id matches
      if AnsiSameText(Tag.id, Id) then
      begin
        Result := Tag;
        Break;
      end;
    end;
  end;

  procedure SelectTariff( tariffName : string);
  var
    framePopupTar : OleVariant;
    ovElements1: OleVariant;
    tariffId : OleVariant;
    iElementtAR : IHTMLElement;

     frameDispatchTar:IDispatch;
     childWindowTar: IHTMLWindow2;
     iDocTar : IHtmlDocument2;

    Function FindInFrametar(nameEl:string):boolean;
    var
      ii:integer;
      IsErrorInner:boolean;
    begin
      comliteLoad:=false;
      IsErrorInner:=false;
      while not comliteLoad do
      begin
        Application.ProcessMessages;
        for ii:=1 to iDocTar.All.Get_length do
        begin
          iDisp:=iDocTar.Get_all.item(pred(ii),0);
          iDisp.QueryInterface(IHTMLElement, iElementtAR);

          if assigned(iElement) then
          begin
           //if trim(iElement.id)<>'' then MemoLog.Lines.Add(iElement.id);

            if iElementtAR.id=nameEl then
            begin
              comliteLoad:=true;
              IsErrorInner:=true;
              break;
            end;
          end;
        end;
      end;
      //end;
      Result := IsErrorInner;

    end;

  begin
    WaitSearchElement('fav_selectFrame', 0);
    framePopupTar := Window.frames.item('fav_selectFrame').document;

    frameDispatchTar := Window.frames.item('fav_selectFrame');

    if Assigned(frameDispatchTar) then
    begin
     childWindowTar := frameDispatchTar as IHTMLWindow2;
     iDocTar := childWindowTar.document;
    end;
    //кликаем по названию тарифа
    tariffId := IntToStr(getvaluetarif(tariffName));

    WaitReadyState;

    Application.ProcessMessages;
    Application.ProcessMessages;

    FindInFrameTar(tariffId);

    if Assigned (iElementtAR) then
      iElementtAR.click
    else
      Raise Exception.Create('Код тарифа не найден');

    //кликаем по кнопке выбрать
    FindInFrameTar('btn_select_row');

    if Assigned (iElementtAR) then
      iElementtAR.click
    else
      Raise Exception.Create('Тариф не выбран');
  end;

var
  numstr:string;
//Тело основной процедуры;
begin
 //try

  if SpinEdit1.Value=Excel.WorkBooks[1].WorkSheets[1].Cells.CurrentRegion.Rows.Count then
  begin
    AddLog('Все номера уже введены.');
    exit;
  end;

  SpinEdit1.Value := SpinEdit1.Value+1;
  numstr := Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,2];

  if (
        pos('Регистрационные данные по данному телефону уже внесены',
            Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]
          ) > 0
      )
      or
      (
        pos(
             'Успешно сохранён.',
             Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]
           ) > 0 ) then
  begin
    AddLog('Номер '+numstr+'. Данные по номеру уже внесены ранее.') ;
    AddNextBut.Enabled := true;
    AddAllNext.Enabled := true;
   exit;
  end;

  AddNextBut.Enabled := false;
  AddAllNext.Enabled := false;

  DoMainWork.Enabled := false;
  WebBrowser1.Enabled := false;
  HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
  Window := HTML_Doc.parentWindow as IHTMLWindow2;

  WaitSearchElement('fr3', 20);

  WaitReadyState;

  frame := Window.frames.item('fr3').document;
  frameDispatch := Window.frames.item('fr3');

  if Assigned(frameDispatch) then
  begin
    childWindow := frameDispatch as IHTMLWindow2;
    iDoc := childWindow.document;
  end;

  WaitReadyState;

  FindInFrame('BTN_SAVE');
  frame := Window.frames.item('fr3').document;

  WaitReadyState;

  FillFrameField('pname', Form_Name);
  //plgfm_lgfm_id
  ovElements := Frame.getelementbyid('plgfm_lgfm_id');	//нужный элемент
  ovElements.selectedindex := 14;

  FillFrameField('pjur_strt_strt_id', Form_Street);
  FillFrameField('pbank_name', Form_BankName);

  FillFrameField('pbank_account', Form_AccountNumber);
  FillFrameField('pmfo', Form_BIC);
  FillFrameField('pinn', Form_INN);
  FillFrameField('pcorr_account', Form_KorSch);
  FillFrameField('preg_certif', Form_KorSch);
  FillFrameField('pkpp', Form_KPP);
  FillFrameField('pjur_house', Form_House);
  FillFrameField('pjur_block', Form_Korpus);
  FillFrameField('pjur_appartment', Form_OfficeNumber);
  FillFrameField('pcontact_person', Form_FIO);
  FillFrameField('prepr_name', Form_FIO2);
  FillFrameField('pbank_place', Form_Adress);
  FillFrameField('psign_date', DateToStr(DATE-1));

  WaitReadyState;

  ovElements := Frame.getelementbyid('pctyp_ctyp_id');	//нужный элемент
  ovElements.selectedindex := strtoint(Form_TypeClient);
  ovElements := Frame.getelementbyid('pclrt_clrt_id');	//нужный элемент
  ovElements.selectedindex := strtoint(Form_IsResident);

  //поле контактный телефон, снимаем галку
  FindInFrame('pphone_sw');
  if Assigned(iElement) then
    iElement.click;

  FindInFrame('pjur_e_mail_sw');
  if Assigned(iElement) then
    iElement.click;


  WaitReadyState;

  ovElements := Frame.getelementbyid('btn_add_subs_info');	//нужный элемент
  ovElements.click;

  //ovElements := Frame.getelementbyid('btn_add_subs_info');	//нужный элемент
  //ovElements.click;
  //sleep(1);
  //Application.ProcessMessages;
  //sleep(1);
  Application.ProcessMessages;

  WaitReadyState;

  WaitReadyState;

  for i := 1 to 10000 do
  begin
    Application.ProcessMessages;
    sleep(0);
  end;

  //tempstr:='while (1) {if ((window.popupObj.callerWindow.g_subs_msisdns!==undefined) && (window.popupObj.callerWindow.g_subs_msisdns!==null)) {break;}}';
  //childWindow.execScript(tempstr, 'JavaScript');
  //ShowMessage('Продолжить.');
  WaitProcessMessage(Common_WaitTimeOut);

  WaitSearchElement('add_subs_infoFrame', 20);
  Application.ProcessMessages;

  WaitReadyState;

  frameDispatch := Window.frames.item('add_subs_infoFrame');

  if Assigned(frameDispatch) then
  begin
    childWindow := frameDispatch as IHTMLWindow2;
    iDoc:=childWindow.document;
  end;
  FindInFrame('prtpl_id');
  FindInFrame('BTN_ADD');
  FindInFrame('pmsisdn_find');
  FindInFrame('picc_find');

  WaitReadyState;

  framePopup := Window.frames.item('add_subs_infoFrame').document;
  //номер телефона
  FillFramePopupField('pmsisdn_find', Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,2]);
  //номер сим
  FillFramePopupField('picc_find', Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,1]);

  //Название тарифного плана
  //FillFramePopupField('prtpl_id', Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,3]);

  //нажатие на кнопку
  Application.ProcessMessages;
  framePopup := Window.frames.item('add_subs_infoFrame').document;
  Application.ProcessMessages;
  ovElements := framePopup.getelementbyid('btn_find_msisdn_icc');	//нужный элемент


  Application.ProcessMessages;
  //AddLog('-1');
  try
    ovElements.click;
  except
    AddLog('Ошибка нажатия кнопки поиска.');
  end;

  WaitProcessMessage(Common_WaitTimeOut*2);

  if not CompleteLoadAndCheckError('') then
  begin
    //if CheckDisabled('prtpl_id') then begin
    if PopupForm_FixTarif <> 1 then
    begin
      //ovElements := framePopup.getelementbyid('prtpl_id');	//нужный элемент
      tariff_name := Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,3];
      tempgetvaluetarif:=getvaluetarif(tariff_name);
      if tempgetvaluetarif <> -1 then
      begin
        ovElements := framePopup.getelementbyid('btn_prtpl_id');
        ovElements.click;

        SelectTariff(tariff_name);

      end
      else
        Raise Exception.Create('Ошибка определения тарифа.');
    end;


    Application.ProcessMessages;
    Application.ProcessMessages;
    //GlobalExcelIndex
    //ovElements.value:=Excel.WorkBooks[1].WorkSheets[1].cells[2,3];
    if PopupFormNeedSetAbonInfo <> '0' then
    begin
      FillFramePopupField('pname', PopupForm_FIO);
      FillFramePopupField('pdate_of_birth', PopupForm_BirthDay);
      FillFramePopupField('ppass_ser', PopupForm_Serial);
      FillFramePopupField('ppass_num', PopupForm_Number);
      FillFramePopupField('ppass_date', PopupForm_PasDate);
      FillFramePopupField('ppass_place', PopupForm_OrganV);

      ovElements := framePopup.getelementbyid('pgender');	//нужный элемент
      ovElements.selectedindex := strtoint(PopupForm_Sex);

      ovElements := framePopup.getelementbyid('pcou_id');	//нужный элемент
      ovElements.value:=PopupForm_Country;
      tempstr:='document.getElementById(''pcou_id'').setAttribute(''title'',''Поле заполнено из справочника'')';
      childWindow.execScript(tempstr, 'JavaScript');
      Application.ProcessMessages;
      tempstr:='document.getElementById(''pcou_id'').setAttribute(''id_value'',''1'')';
      childWindow.execScript(tempstr, 'JavaScript');
      Application.ProcessMessages;

      FillFramePopupField('phouse', PopupForm_House);
      FillFramePopupField('pappartment', PopupForm_Flat);
      FillFramePopupField('pcit_id', PopupForm_City);

      ovElements := framePopup.getelementbyid('pidtp_id');	//нужный элемент
      ovElements.selectedindex := strtoint(PopupForm_IDDocum);
      Wait5Sec;
    end;

    WaitReadyState;
    ovElements := framePopup.getelementbyid('BTN_ADD');	//нужный элемент

    if not CompleteLoadAndCheckError('') then
    begin
      while pos('disabled',vartostr(ovElements.outerHTML))>0 do
        application.ProcessMessages;
      ovElements.click;
    end
    else
    begin
      if stdErr then
      begin
        ovElements := framePopup.getelementbyid('BTN_CANCEL');	//нужный элемент
        ovElements.click;
        AddNextBut.Enabled:=true;
        AddAllNext.Enabled:=true;
      end;
      exit;
    end;

    //ждем пока закроется окно с поиском по номеру
    WaitProcessMessage(8);

    WaitReadyState;

    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    Window := HTML_Doc.parentWindow as IHTMLWindow2;

    WaitSearchElement('fr3', 0);
    frameDispatch := Window.frames.item('fr3');
    Application.ProcessMessages;

    if Assigned(frameDispatch) then
    begin
      childWindow := frameDispatch as IHTMLWindow2;
      iDoc := childWindow.document;
    end;

    frame := Window.frames.item('fr3').document;

    //жмем кнопку сохранить
    FindInFrame('BTN_SAVE');
    ovElements := Frame.getelementbyid('BTN_SAVE');	//нужный элемент

    ovElements.click;

    WaitProcessMessage(Common_WaitTimeOut);

    WaitProcessMessage(5);
    //нажимаем кнопку "ДА" при подтверждении сохранения
    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    Window := HTML_Doc.parentWindow as IHTMLWindow2;


    iElement := GetElementById(HTML_Doc, '_shell.modal_msg1_btn_0') as IHTMLElement;
    if Assigned(iElement) then
      iElement.click;
    SaveBut.Enabled:=true;

    //нас пункт
    //AddLog('Finished');
  end

  else
  begin
    if stdErr then
    begin
      ovElements := framePopup.getelementbyid('BTN_CANCEL');	//нужный элемент
      ovElements.click;
      AddNextBut.Enabled:=true;
      AddAllNext.Enabled:=true;
    end;
  end;
end;

procedure TForm1.DoMainWorkClick(Sender: TObject);
 var
  //a:  variant;
  //Win,  Doc,  Sel:  Variant;
 HTML_Doc: IHTMLDocument2;
 ovElements: OleVariant;
 Window: IHTMLWindow2;
 frame: Olevariant;
 framePopup: Olevariant;
 iDisp : IDispatch;
 iElement : IHTMLElement;
 DOCUM: OleVariant;
 findmenu:boolean;

 frameDispatch:IDispatch;
 childWindow: IHTMLWindow2;
 iDoc : IHtmlDocument2;
 //js:TDelphiJS;

  function WaitSearchElement(nameEl:string; timeout:integer):boolean;
  var
    ii : integer;
    d1,d2:TDatetime;
    sec:integer;
    isSearch:boolean;
  begin
    isSearch := false;
    d1 := now;
    while not isSearch do
    begin
      //проверка на timeout
      if timeout>0 then
      begin
        d2 := now;
        Sec := Round( (D2 - D1) * 24 * 60 * 60 );
        if Sec > timeout then
        begin
          AddLog('Превышено время ожидания элемента '+nameEl+'.');
          WaitSearchElement := false;
          isSearch := true;

          Raise
            Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [nameEl]);
        end;
      end;
      Application.ProcessMessages;
      for ii:=1 to HTML_Doc.All.Get_length do
      begin
        try
          //Application.ProcessMessages;
          iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
          iDisp.QueryInterface(IHTMLElement, iElement);
          //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          //codesite.send('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          if iElement.id=nameEl then
          begin
            isSearch:=true;
            WaitSearchElement:=true;
          end;
        except
          on e : Exception do
          //

        end;
      end;
    end;
  end;

        Function FindInFrame(nameEl:string):boolean;
        var
          ii:integer;
          IsErrorInner:boolean;
        begin
          comliteLoad:=false;
          IsErrorInner:=false;
          while not comliteLoad do begin
           Application.ProcessMessages;
           for ii:=1 to iDoc.All.Get_length do begin
             iDisp:=iDoc.Get_all.item(pred(ii),0);
             iDisp.QueryInterface(IHTMLElement, iElement);
             //Str(pred(i),S);
             //S:= S+'';

              if assigned(iElement) then
              begin
               //if trim(iElement.id)<>'' then MemoLog.Lines.Add(iElement.id);
               if iElement.id=nameEl then begin
                comliteLoad:=true;
                IsErrorInner:=true;
               end;
              end;
           end;
          end;
          //end;
          FindInFrame:=IsErrorInner;

        end;

        procedure FillFrameField(FieldId : string; FieldValue:string);
          var
            itm: OleVariant;
          begin
            itm := Frame.getelementbyid(FieldId);	//нужный элемент
            itm.value:=FieldValue;//номер сим карты '89701026589083615';
          end;

        procedure FillFramePopupField(FieldId : string; FieldValue:string);
          var
            itm: OleVariant;
          begin
            itm := framePopup.getelementbyid(FieldId);	//нужный элемент
            itm.value:=FieldValue;//номер сим карты '89701026589083615';
          end;



        procedure WaitSearch;
         var
          ii : integer;
          d1,d2:TDatetime;
          sec:integer;
          isSearch:boolean;
        begin
           isSearch:=false;
           d1:=now;
           while not isSearch do begin
             //проверка на timeout
             d2:=now;
             Sec := Round( (D2 - D1) * 24 * 60 * 60 );
             if Sec>30 then begin
              AddLog('Превышено время ожидания 2.');
              isSearch:=true;
              Raise Exception.Create('Превышено время ожидания 2 ');
             end;
             Application.ProcessMessages;
             for ii:=1 to HTML_Doc.All.Get_length do begin
               //Application.ProcessMessages;
               iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
               iDisp.QueryInterface(IHTMLElement, iElement);
               //Str(pred(i),S);
               //S:= S+'';
                if assigned(iElement) then
                begin
                    //S:=S+'tag='+iElement.Get_tagName+' ';
                  //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
                  if (iElement.id='sbms_modal_busyContainer') then
                   if iElement.style.display='none' then
                    isSearch:=true;
               end;
             end;
           end;
        end;
        function getvaluetarif(val:string):integer;
         var
          indexOf:integer;
          tempStr:string;
          posravno:integer;
          len:integer;
        begin
         indexOf:=-1;
         if not ListTarifNames.Find(val,indexOf) then
          AddLog('Ошибка определения тарифа. Проверьте соответствие тарифа в файле Excel тарифам в настройках.');
         posravno:=pos('=', ListTarifs[indexOf]);
         len:=length(ListTarifs[indexOf]);
         tempstr:=copy(ListTarifs[indexOf],posravno+1,len-posravno);
         //
         getvaluetarif:=StrToInt(tempstr);
        end;


        Function CompleteLoadAndCheckError(mes:string):boolean;
         var
          ii:integer;
          IsErrorInner:boolean;
          tempStr:string;
          iTable:IHTMLTable;
          numstr:string;

        begin
          comliteLoad:=false;
          IsErrorInner:=false;
          while not comliteLoad do begin
           Application.ProcessMessages;
           for ii:=1 to iDoc.All.Get_length do begin
             iDisp:=iDoc.Get_all.item(pred(ii),0);
             iDisp.QueryInterface(IHTMLElement, iElement);
             //Str(pred(i),S);
             //S:= S+'';
              if assigned(iElement) then
              begin
                  //S:=S+'tag='+iElement.Get_tagName+' ';
                  iElement.QueryInterface(IHTMLtable,iTable);
               if assigned(iTable) then
               begin
                  numstr:=Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,2];
                  if (iElement.id='error_div') then begin
                   comliteLoad:=true;
                   if iElement.style.getAttribute( 'display', 0 )='none' then
                    AddLog('Номер '+numstr+'. Ошибок добавления абонентов нет.');
                  end;
                  //sleep(1000);
                  //Application.ProcessMessages;
                  if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then begin
                   tempStr:=iElement.innerText;
                   //AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+tempStr);
                   //ADOQuery1.Edit;
                   if pos('Регистрационные данные по данному телефону уже внесены',tempStr)>0 then begin
                    AddLog('Номер '+numstr+'. Регистрационные данные по данному телефону уже внесены.');
                    Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]:='Уже загружено.';
                    Excel.WorkBooks[1].save;
                   end
                   else if pos('Некорректная операция с предактивированным комплектом',tempStr)>0 then
                   begin
                   AddLog('Номер '+numstr+'. Некорректная операция с предактивированным комплектом.');
                    Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]:='Некорректная операция с предактивированным комплектом.';
                    Excel.WorkBooks[1].save;
                   end else
                    AddLog(tempStr);
                   //ShowMessage('ошибка!!!');
                   IsErrorInner:=true;
                   break;
                  end;
               end;
             end;
           end;
          end;
          CompleteLoadAndCheckError:=IsErrorInner;

        end;


begin
  try
    DoMainWork.Enabled:=false;
    WebBrowser1.Enabled:=false;
    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    Window := HTML_Doc.parentWindow as IHTMLWindow2;
    frame:=Window.frames.item('fr1').document;

    ovElements := Frame.getelementbyid('TXT_LOGIN');	//нужный элемент
    ovElements.value := Ident_Login;
    ovElements := Frame.getelementbyid('TXT_PASSWORD');	//нужный элемент
    ovElements.value := Ident_pass;
    ovElements := Frame.getelementbyid('BTN_ENTER');	//нужный элемент
    ovElements.click;
    //menu-CLIR.ITEM0050
    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    findmenu := WaitSearchElement('menu-820075.ITEM820082', 0);
    {false;
    while not findmenu do begin
      Application.ProcessMessages;
      for i:=1 to HTML_Doc.All.Get_length do begin
        iDisp:=HTML_Doc.Get_all.item(pred(i),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        if assigned(iElement) then
        begin
          if (iElement.id='menu-CLIR.ITEM0051') then begin
            //MemoLog.Lines.Add('Id='+iElement.id);
            findmenu:=true;
          end;
        end;
      end;
    end;}
    Window := HTML_Doc.parentWindow as IHTMLWindow2;
    DOCUM := Window.document;

    //Application.ProcessMessages;
    ovElements := DOCUM.getelementbyid('menu-820075.ITEM820082');	//нужный элемент
    ovElements.click;
    WaitSearchElement('fr3', 20);
    frame := Window.frames.item('fr3').document;
    frameDispatch := Window.frames.item('fr3');

    if Assigned(frameDispatch) then
    begin
     childWindow := frameDispatch as IHTMLWindow2;
     iDoc := childWindow.document;
    end;
    FindInFrame('BTN_SAVE');
    frame := Window.frames.item('fr3').document;
    //showmessage(Excel.WorkBooks[1].WorkSheets[1].Cells.CurrentRegion.Rows.Count);
    //for I := 1 to Excel.WorkBooks[1].WorkSheets[1].Cells.CurrentRegion.Rows.Count do begin
     AddNextButClick(self);
  finally
    //DoMainWork.Enabled:=true;
    WebBrowser1.Enabled:=true;
  end;


end;

procedure TForm1.AddLog(MesText: string);
 var
   OutFile:textfile;
   LogPath:string;
begin
 MemoLog.Lines.Add(MesText);
 LogPath:=path_dir+'\Log\'+FormatDateTime('yyyy_mm_dd', now)+'.log';
 AssignFile(OutFile,LogPath);
 if FileExists(LogPath) then
  Append(OutFile)
 else
  rewrite(OutFile);
 MesText:=FormatDateTime('hh:nn:ss', now)+' '+MesText;
 Writeln(OutFile,MesText);
 CloseFile(OutFile);
end;

function GetVersionTextOfModule(const FileName : string) : string;
{$IFNDEF CLR}
var
  V1, V2, V3, V4 : Word;
  VerInfoSize : Cardinal;
  VerInfo : Pointer;
  VerValueSize : Cardinal;
  VerValue : PVSFixedFileInfo;
  Dummy : Cardinal;
{$ELSE}
var
  FileVersionAttribute : AssemblyFileVersionAttribute;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(
    PChar(FileName),
    Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      try
        GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
        Result := IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3)+'.'+IntToStr(v4);
      except
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
{$ELSE}
  FileVersionAttribute := AssemblyFileVersionAttribute(
    AssemblyFileVersionAttribute.GetCustomAttribute(
			&Assembly.GetExecutingAssembly(),
      typeof(AssemblyFileVersionAttribute)
      )
    );
  if FileVersionAttribute = nil then
    Result := '0.0.0.0'
  else
    Result := FileVersionAttribute.Version;
{$ENDIF}
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  version :string;
begin
  path_dir:=GetCurrentDir;
  IniFile:=TIniFile.Create(path_dir+'\SBMS_UR.ini');
  Site_www:=IniFile.ReadString('Site', 'www','');
  ListTarifs:=TStringList.Create;
  ListTarifNames:=TStringList.Create;
  IniFile.ReadSectionValues('PlanTarifs', ListTarifs);
  IniFile.ReadSection('PlanTarifs',ListTarifNames);
  //AddLog(ListTarifs[0]);

  Ident_Login:=IniFile.ReadString('Ident', 'Login','');
  Ident_pass:=IniFile.ReadString('Ident', 'pass','');
  Base_path:= IniFile.ReadString('Base', 'Path','');
  Form_Name:= IniFile.ReadString('Form', 'Name','');
  Form_Adress:= IniFile.ReadString('Form', 'Adress','');
  Form_Street:= IniFile.ReadString('Form', 'Street','');
  Form_House:= IniFile.ReadString('Form', 'House','');
  Form_Korpus:= IniFile.ReadString('Form', 'Korpus','');
  Form_OfficeNumber:= IniFile.ReadString('Form', 'OfficeNumber','');
  Form_FIO:= IniFile.ReadString('Form', 'FIO','');
  Form_BankName:= IniFile.ReadString('Form', 'BankName','');
  Form_AccountNumber:= IniFile.ReadString('Form', 'AccountNumber','');
  Form_INN:= IniFile.ReadString('Form', 'INN','');
  Form_KPP:= IniFile.ReadString('Form', 'KPP','');
  Form_KorSch:= IniFile.ReadString('Form', 'KorSch','');
  Form_OGRN:= IniFile.ReadString('Form', 'OGRN','');
  Form_TypeClient:= IniFile.ReadString('Form', 'TypeClient','');
  Form_IsResident:= IniFile.ReadString('Form', 'IsResident','');
  Form_FIO2:= IniFile.ReadString('Form', 'FIO2','');
  Form_BIC:= IniFile.ReadString('Form', 'BIC','');

  PopupFormNeedSetAbonInfo := IniFile.ReadString('PopupForm', 'NeedSetAbonInfo', '0');
  if PopupFormNeedSetAbonInfo <> '0' then
  begin
    PopupForm_FIO:=IniFile.ReadString('PopupForm', 'FIO','');
    PopupForm_BirthDay:=IniFile.ReadString('PopupForm', 'BirthDay','');
    PopupForm_Serial:=IniFile.ReadString('PopupForm', 'Serial','');
    PopupForm_Number:=IniFile.ReadString('PopupForm', 'Number','');
    PopupForm_OrganV:=IniFile.ReadString('PopupForm', 'OrganV','');
    PopupForm_House:=IniFile.ReadString('PopupForm', 'House','');
    PopupForm_Flat:=IniFile.ReadString('PopupForm', 'Flat','');
    PopupForm_Country:=IniFile.ReadString('PopupForm', 'Country','');
    PopupForm_City:=IniFile.ReadString('PopupForm', 'City','');
    PopupForm_Sex:=IniFile.ReadString('PopupForm', 'Sex','');
    PopupForm_IDDocum:=IniFile.ReadString('PopupForm', 'IDDocum','');
    PopupForm_PasDate:=IniFile.ReadString('PopupForm', 'PasDate','');
  end;

  PopupForm_FixTarif:=IniFile.ReadInteger('PopupForm', 'FixTarif',0);

  Common_WaitTimeOut:=IniFile.ReadInteger('Common', 'WaitTimeOut',10);
  Common_SaveTimeOut:=IniFile.ReadInteger('Common', 'SaveTimeOut',10);


  Excel:= CreateOleObject('Excel.Application');
  Excel.workbooks.open(GetCurrentDir() + '\'+Base_path);
  GlobalExcelIndex:=1;
  SpinEdit1.MaxValue:=Excel.WorkBooks[1].WorkSheets[1].Cells.CurrentRegion.Rows.Count;

  if not DirectoryExists(path_dir+'\Log') then
  if not CreateDir(path_dir+'\Log') then
   ShowMessage('Ошибка создания каталога \Log');
 
  version:=GetVersionTextOfModule(ParamStr(0));
  AddLog('Версия программы: '+version);
  Caption := 'SBMS_UR ' + version;
  WebBrowser1.Navigate(Site_www);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   Excel.ActiveWorkbook.Close;
end;

procedure TForm1.Reconnect;
 var
  HTML_Doc: IHTMLDocument2;
  findmenu:boolean;
  iDisp : IDispatch;
  Window: IHTMLWindow2;
  DOCUM: OleVariant;
  ovElements: OleVariant;
  frame: Olevariant;
  frameDispatch:IDispatch;
  childWindow: IHTMLWindow2;
  iDoc : IHtmlDocument2;

  function WaitSearchElement(nameEl:string; timeout:integer):boolean;
  var
    ii : integer;
    d1,d2:TDatetime;
    sec:integer;
    isSearch:boolean;
    iElement : IHTMLElement;

  begin
    isSearch:=false;
    d1:=now;
    while not isSearch do
    begin
      //проверка на timeout
      if timeout>0 then
      begin
        d2:=now;
        Sec := Round( (D2 - D1) * 24 * 60 * 60 );
        if Sec>timeout then
        begin
          AddLog('Превышено время ожидания элемента '+nameEl+'.');
          Result :=false;
          isSearch:=true;
          Raise Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [nameEl]);
        end;
      end;

      Application.ProcessMessages;
      for ii:=1 to HTML_Doc.All.Get_length do
      begin
        //Application.ProcessMessages;
        Application.ProcessMessages;
        iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        if assigned(iElement) then
        begin
          //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          if iElement.id=nameEl then
          begin
            isSearch:=true;
            WaitSearchElement:=true;
          end;
        end;
      end;
    end;
  end;

  Function FindInFrame(nameEl:string):boolean;
  var
    ii:integer;
    IsErrorInner:boolean;
    iElement : IHTMLElement;

  begin
    comliteLoad:=false;
    IsErrorInner:=false;
    while not comliteLoad do
    begin
      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp:=iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';

        if assigned(iElement) then
        begin
         //if trim(iElement.id)<>'' then MemoLog.Lines.Add(iElement.id);
          if iElement.id=nameEl then
          begin
            comliteLoad:=true;
            IsErrorInner:=true;
          end;
        end;
      end;
    end;
    //end;
    FindInFrame:=IsErrorInner;

  end;
///////////////////////////
//КОД ПРОЦЕДУРЫ RECONNECT//
///////////////////////////
begin
    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    findmenu:=WaitSearchElement('menu-CLIR.ITEM0051', 30);
    Window := HTML_Doc.parentWindow as IHTMLWindow2;
    DOCUM:=Window.document;

    ovElements := DOCUM.getelementbyid('menu-CLIR.ITEM0051');	//нужный элемент
    ovElements.click;
    WaitSearchElement('fr3', 20);
    frame:=Window.frames.item('fr3').document;
    frameDispatch:=Window.frames.item('fr3');

    if Assigned(frameDispatch) then
    begin
     childWindow := frameDispatch as IHTMLWindow2;
     iDoc:=childWindow.document;
    end;
    FindInFrame('BTN_SAVE');
    frame:=Window.frames.item('fr3').document;

end;

procedure TForm1.SaveButClick(Sender: TObject);
var
  HTML_Doc: IHTMLDocument2;
  iDisp : IDispatch;
  Window: IHTMLWindow2;
  iElement : IHTMLElement;
  ovElements: OleVariant;
  frameDispatch:IDispatch;
  childWindow: IHTMLWindow2;
  iDoc : IHtmlDocument2;
  frame: Olevariant;
  frame1: Olevariant;
  //iElement : IHTMLElement;
  element: Olevariant;
  numstr:string;


           procedure WaitSearch1(nameEl:string);
           var
            ii : integer;
            d1,d2:TDatetime;
            sec:integer;
            isSearch:boolean;
          begin
             isSearch:=false;
             d1:=now;
             while not isSearch do begin
               //проверка на timeout
               d2:=now;
               Sec := Round( (D2 - D1) * 24 * 60 * 60 );
               if Sec>30 then begin
                AddLog('Превышено время ожидания элемента '+nameEl+'.');
                isSearch:=true;
                Raise Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [nameEl]);
               end;
               Application.ProcessMessages;
               for ii:=1 to HTML_Doc.All.Get_length do begin
                 //Application.ProcessMessages;
                 iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
                 iDisp.QueryInterface(IHTMLElement, iElement);
                 //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
                 if iElement.id=nameEl then begin
                   isSearch:=true;
                 end;

               end;
             end;
          end;


  procedure WaitElement(ElName:string);
   var
    ii:integer;
    d1,d2:TDatetime;
    sec:integer;
  begin
    comliteLoad:=false;
    d1:=now;
    while not comliteLoad do
    begin
      d2:=now;
      Sec := Round( (D2 - D1) * 24 * 60 * 60 );
      if Sec>30 then
      begin
        AddLog('Превышено время ожидания элемента '+ElName+'.');
        comliteLoad:=true;
        Raise Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [Elname]);
      end;

      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp:=iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';
        if assigned(iElement) then
        begin
        //S:=S+'tag='+iElement.Get_tagName+' ';
        //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
          if (iElement.id=ElName) then
          begin
            comliteLoad:=true;
            break;
          end;
        end;
      end;
    end;

  end;

  function WaitSearchElement(nameEl:string; timeout:integer):boolean;
   var
    ii : integer;
    d1,d2:TDatetime;
    sec:integer;
    isSearch:boolean;
  begin
    isSearch := false;
    d1 := now;
    while not isSearch do
    begin
      //проверка на timeout
      if timeout>0 then
      begin
        d2:=now;
        Sec := Round( (D2 - D1) * 24 * 60 * 60 );
        if Sec>timeout then
        begin
          AddLog('Превышено время ожидания.');
          Result := false;
          isSearch := true;
          Raise Exception.CreateFmt('Превышено время ожидания элемента : ''%s''', [nameEl]);
        end;
      end;

      Application.ProcessMessages;
      for ii:=1 to HTML_Doc.All.Get_length do
      begin
        //Application.ProcessMessages;
        iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
        if iElement.id=nameEl then
        begin
          isSearch:=true;
          Result :=true;
        end;
      end;
    end;
  end;


  Function FindInFrame(nameEl:string):boolean;
  var
    ii:integer;
    IsErrorInner:boolean;
  begin
    comliteLoad:=false;
    IsErrorInner:=false;
    while not comliteLoad do
    begin
      Application.ProcessMessages;
      for ii:=1 to iDoc.All.Get_length do
      begin
        iDisp:=iDoc.Get_all.item(pred(ii),0);
        iDisp.QueryInterface(IHTMLElement, iElement);
        //Str(pred(i),S);
        //S:= S+'';

        if assigned(iElement) then
        begin
         //if trim(iElement.id)<>'' then MemoLog.Lines.Add(iElement.id);
          if iElement.id=nameEl then
          begin
            comliteLoad:=true;
            IsErrorInner:=true;
          end;
        end;
      end;
    end;
    //end;
    FindInFrame:=IsErrorInner;

  end;

//
//ТЕЛО ОСНОВНОЙ ПРОЦЕДУРЫ
//
begin

        SaveBut.Enabled:=false;
        numstr:=Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,2];
        HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
        Window := HTML_Doc.parentWindow as IHTMLWindow2;
        frameDispatch:=Window.frames.item('fr3');
        frame:=Window.frames.item('fr3').document;
        Application.ProcessMessages;

        if Assigned(frameDispatch) then
        begin
         childWindow := frameDispatch as IHTMLWindow2;
         iDoc:=childWindow.document;
        end;

        Application.ProcessMessages;
        ovElements := Frame.getelementbyid('BTN_SAVE');
        ovElements.click;
        {
        try
         WaitSearch1('sbms_modal_confirmFrame');
        except
         on E : exception do begin
          AddLog('Ошибка ожидания фрэйма подтверждения сохранения.: '+E.Message);
          Raise Exception.CreateFmt('Ошибка ожидания фрэйма подтверждения сохранения: ''%s''', [E.Message]);
          exit;
         end;
        end;{}
        WaitProcessMessage(Common_WaitTimeOut*Common_SaveTimeOut);


        if {not IsError}true then begin
        try
          HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
          Window := HTML_Doc.parentWindow as IHTMLWindow2;
          (* 29.11.2012
          frameDispatch:=Window.frames.item('sbms_modal_confirmFrame');
          if Assigned(frameDispatch) then
          begin
            childWindow := frameDispatch as IHTMLWindow2;
            iDoc:=childWindow.document;
          end;
           *)
          iDoc:=Window.document;
          //ожидание загрузки sbms_modal_confirm_btn_0 для Click
          WaitElement('_shell.modal_confirm_btn_0');
          frame1:=Window.document;
          element := Frame1.getelementbyid('_shell.modal_confirm_btn_0');
          //нажатие на кнопку sbms_modal_confirm_btn_0
          element.click;

        except
         on E : exception do begin
          AddLog('Ошибка подтверждения сохранения документа: '+E.Message);
          Raise Exception.CreateFmt('Ошибка подтверждения сохранения документа: ''%s''', [E.Message]);
          exit;
         end;
        end;

        //эмуляция - ввод нового клиента

        //ожидание загрузки фрэйма g_modal_after_saveFrame
        try

          WaitSearch1('g_modal_after_saveFrame');

          frameDispatch:=Window.frames.item('g_modal_after_saveFrame');
          if Assigned(frameDispatch) then
          begin
            childWindow := frameDispatch as IHTMLWindow2;
            iDoc:=childWindow.document;
          end;
          WaitElement('BTN_NEW_CLNT');
          frame1:=Window.frames.item('g_modal_after_saveFrame').document;
          element := Frame1.getelementbyid('BTN_NEW_CLNT');
          //нажатие на кнопку BTN_NEW_CLNT
          element.click;
          AddLog('Номер '+numstr+'. Успешно сохранён.');
          Excel.WorkBooks[1].WorkSheets[1].cells[GlobalExcelIndex,4]:='Номер '+numstr+'. Успешно сохранён.';
          Excel.WorkBooks[1].save;
          AddNextBut.Enabled:=true;
          AddAllNext.Enabled:=true;

          {
          HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
          findmenu:=WaitSearchElement('menu-CLIR.ITEM0051', 0);
          Window := HTML_Doc.parentWindow as IHTMLWindow2;
          DOCUM:=Window.document;

          ovElements := DOCUM.getelementbyid('menu-CLIR.ITEM0051');	//нужный элемент
          ovElements.click;
          WaitSearchElement('fr3', 20);
          frame:=Window.frames.item('fr3').document;
          frameDispatch:=Window.frames.item('fr3');

          if Assigned(frameDispatch) then
          begin
           childWindow := frameDispatch as IHTMLWindow2;
           iDoc:=childWindow.document;
          end;
          FindInFrame('BTN_SAVE');
          frame:=Window.frames.item('fr3').document;

          {}

        except
         on E : exception do begin
          AddLog('Ошибка нажатия на кнопку ввод нового клиента: '+E.Message);
          Raise Exception.CreateFmt('Ошибка нажатия на кнопку ввод нового клиента: ''%s''', [E.Message]);
          exit;
         end;
        end;
       end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
 GlobalExcelIndex:=SpinEdit1.Value;
end;

procedure TForm1.WaitProcessMessage(WaitSec: integer);
 var ii:integer;
     jj:integer;
begin
  for II := 1 to WaitSec do
  begin
    for jj:=0 to 100 do
      Application.ProcessMessages;
    Sleep(1000);

    for jj:=0 to 100 do
      Application.ProcessMessages;
   end;
end;



end.
