unit ClientsListUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, ExportExcel, ComObj,
  OleCtrls, SHDocVw, mshtml, IniFiles, ToolWin, ComCtrls, DBCtrls, TlHelp32,clipbrd;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    MemoLog: TMemo;
    Button3: TButton;
    bInputCurrentRecord: TButton;
    OpenDialog1: TOpenDialog;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    StopLoad: TCheckBox;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WebBrowser1: TWebBrowser;
    WebBrowser2: TWebBrowser;
    GroupBox1: TGroupBox;
    cbSave: TCheckBox;
    CheckBox1: TCheckBox;
    cbReportSave: TCheckBox;
    Splitter1: TSplitter;
    procedure Button3Click(Sender: TObject);
    procedure bInputCurrentRecordClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Save_PDF(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(MesText:string);
  end;

var
  Form1: TForm1;
  Site_www:string;
  Base_path:string;
  path_dir:string;
  Ident_Login:string;
  Ident_Pass:string;
  ExpExcel:string;
  PDFPath:String;
  Passport_id: integer;
  TimeOut:integer;
  comliteLoad:boolean;
  XLApp: Variant;
  ListTarifs:TStringList;
  ListTarifNames:TStringList;
  PDF_Save: Boolean;
implementation

{$R *.dfm}

Procedure KillProcIE(ID: Cardinal);
var
hProcess : Cardinal;
begin
hProcess:= OpenProcess(PROCESS_ALL_ACCESS, false, ID);
if hProcess <> INVALID_HANDLE_VALUE then
begin
TerminateProcess(hProcess, 0);
CloseHandle(hProcess);
Sleep(500);
end;
end;


procedure ListProcIE;
var
hSnapShot: THandle;
lppe: TProcessEntry32;
hIcon: THandle;
Count: Integer;
procedure _FillList;
begin
if lppe.szExeFile = 'iexplore.exe' then begin
KillProcIE(lppe.th32ProcessID);
Inc(Count);
end;
end;
begin
hSnapShot:= CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0);
if hSnapShot <> INVALID_HANDLE_VALUE then
begin
lppe.dwSize:= SizeOf(lppe);
Count:= 0;
if Process32First(hSnapShot, lppe) then _FillList;
while Process32Next(hSnapShot, lppe) do _FillList;
CloseHandle(hSnapShot);
end;
end;

procedure TForm1.Save_PDF(Sender: TObject);
var hh, cbex, cb, ed, btn, DUI, DirUI, FL: Thandle;
   my_string  : string;
begin
{  hh:=FindWindow(nil, 'Дерево описателей окон');
  //edit1.Text:=inttostr(hh);
  webbrowser1.SetFocus;
  WebBrowser1.Focused;
  if RegisterHotKey(hh, 1 ,MOD_SHIFT and MOD_CONTROL, 83) then showmessage('ok');
  UnregisterHotKey(hh, 1);  }

  // Индивидуальная  вложенность для их компа
  timer2.Enabled:=FALSE;
  hh:=FindWindow(nil, 'Сохранить как');
  //cbex := FindWindowEx(hh, 0,'ComboBoxEx32', nil);
  btn := FindWindowEx(hh, 0,'Button', 'Со&хранить');
  DUI:= FindWindowEx(hh, 0,'DUIViewWndClassName', nil);
  DirUi:= FindWindowEx(DUI, 0,'DirectUIHWND', nil);
  FL:= FindWindowEx(DirUi, 0,'FloatNotifySink', nil);
  cb := FindWindowEx(FL, 0,'ComboBox', nil);
  ed := FindWindowEx(cb, 0,'Edit', nil);
  //edit1.Text:=inttostr(ed);
  my_string:=PDFPath;//'C:\Users\TARIFER\Desktop\IE_MANAGE\New.pdf';
  if FileExists(my_string) then
  while FileExists(my_string) do
    begin
      my_string:=COPY(my_string,0,length(my_string)-4) + '_' + COPY(my_string,length(my_string)-3,4);
    end;
  //StrToClipbrd(my_string);
  Clipboard.SetTextBuf(PChar(my_string));
  SendMessage(ed,WM_PASTE,0,0);
  //SendMessage(ed,WM_SETTEXT, 0, LParam(my_string));
  SendMessage(btn, BM_CLICK, 0, 0);
  ListProcIE;
  PDF_Save:=TRUE;
end;

procedure WaitProcessMessage(WaitSec: integer);
 var ii:integer;
     jj:integer;
begin
 for II := 1 to WaitSec do begin
  for jj:=0 to 100 do
   Application.ProcessMessages;
  Sleep(1000);
  for jj:=0 to 100 do
   Application.ProcessMessages;
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
  if not ListTarifNames.Find(val,indexOf) then begin
    //AddLog('Ошибка определения тарифа. Проверьте соответствие тарифа в файле Access тарифам в настройках.');
    getvaluetarif:=-1;
    exit;
  end;
  posravno:=pos('=', ListTarifs[indexOf]);
  len:=length(ListTarifs[indexOf]);
  tempstr:=copy(ListTarifs[indexOf],posravno+1,len-posravno);
         //
  getvaluetarif:=StrToInt(tempstr);
  end;

procedure TForm1.Button1Click(Sender: TObject);
 var
  i:integer;
begin

try
 // ADOQuery1.DisableControls;
 Button1.Enabled:=false;
 ADOQuery1.First;
 Application.ProcessMessages;
 for i := 1 to ADOQuery1.Recordset.RecordCount do begin
  if StopLoad.Checked then begin
   StopLoad.Checked:=false;
   AddLog('Остановлена загрузка.');
   exit;
  end;
  bInputCurrentRecordClick(self);
  //AddLog(ADOQuery1.FieldByName('тел номер').AsString);
  //Application.ProcessMessages;
  if ADOQuery1.Recordset.RecordCount<>i then ADOQuery1.Next;
  Application.ProcessMessages;

 end;
//  ADOQuery1.EnableControls;

finally
 Button1.Enabled:=true;
end;

end;

procedure TForm1.Button3Click(Sender: TObject);
 var
  //a:  variant;
  //Win,  Doc,  Sel:  Variant;
 HTML_Doc: IHTMLDocument2;
 ovElements: OleVariant;
 Window: IHTMLWindow2;
 frame: Olevariant;
begin
  //WebBrowser1.Document
  //Variant(WebBrowser1.Document).getElementByName('X_username').text := '12345';
  //WebBrowser1.OleObject.document.getElementByName('TXT_LOGIN').text := '12345';
    //a:=webbrowser1.oleobject.document.getelementbyid('TXT_LOGIN');
  //a.value:='SBD037';
    //a:=webbrowser1.oleobject.document.getelementbyid('text');
  //a.value:='123';

  //a:=webbrowser1.oleobject.document.getelementbyid('TXT_LOGIN');
  //a.value:='123';

     //Окно, связанное с главным документом.
   //Win:=  WebBrowser1.OleObject.document.parentWindow;
   //Документ, связанный с фреймом frmVacs.
   //Doc:=  Win.frames.item('fr1').contentDocument;//
   //a:=Doc.getelementbyid('TXT_LOGIN');
   //a.value:='123';
   //Выбираем нужный элемент - первая форма и в ней 4-й элемент.
   //Предполагается, что этот элемент имеет тег '<select>'.
   //Sel:=  Doc.forms.Item(0).item(3);
   //Для элемента Sel, среди его дочерних элементов выбираем все элементы
   //с тегом '<option>'. Берём пятый по счёту элемент с тегом '<option>'
   //(т. е., его индекс = 4) и переводим его в состояние "выбран".
   //Sel.getElementsByTagName('option').item(4).selected  :=  'true'; end;
   HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
   Window := HTML_Doc.parentWindow as IHTMLWindow2;
   frame:=Window.frames.item('fr1').document;

   ovElements := Frame.getelementbyid('TXT_LOGIN');	//нужный элемент
   ovElements.value:=Ident_Login;
   ovElements := Frame.getelementbyid('TXT_PASSWORD');	//нужный элемент
   ovElements.value:=Ident_Pass;
   ovElements := Frame.getelementbyid('BTN_ENTER');	//нужный элемент
   ovElements.click;
   //BTN_ENTER

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  WebBrowser2.ExecWB(OLECMDID_SAVEAS, OLECMDEXECOPT_DONTPROMPTUSER);
  timer3.Enabled:=FALSE;
  timer2.Enabled:=TRUE;
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

procedure TForm1.bInputCurrentRecordClick(Sender: TObject);
 var
  //a:  variant;
  //Win,  Doc,  Sel:  Variant;
 HTML_Doc: IHTMLDocument2;
 ovElements: OleVariant;
 Window: IHTMLWindow2;
 frameDispatch:IDispatch;
 frame: Olevariant;
 frame1: Olevariant;
 element: Olevariant;
 cnt1:integer;
 i,i1:integer;
 str, SaveDialog:string;
 childWindow: IHTMLWindow2;
 iDoc : IHtmlDocument2;
 iDisp : IDispatch;
 iElement : IHTMLElement;
 iTable:IHTMLTable;
 iDiv:IHTMLDivElement;
 IsError:boolean;
 isSearch:boolean;
 notExept:boolean;
 tempSex:integer;
 isCheck :boolean;
 IsNullCheck:boolean;
 ExecParamL: string;
 tempgetvaluetarif:integer;
 J:Integer;



  procedure FillFrameField(const DBField, FieldId : string);
  var
    itm: OleVariant;
  begin
    if length(ADOQuery1.FieldByName(DBField).AsString)=0 then
     IsNullCheck:=true
    else
    IsNullCheck:=false;
    itm := Frame.getelementbyid(FieldId);	//нужный элемент
    itm.value:=TRIM(ADOQuery1.FieldByName(DBField).AsString);//номер сим карты '89701026589083615';
  end;

  procedure ClickElement(const ItemId: string);
  var
    itm: OleVariant;
  begin
   itm := Frame.getelementbyid(ItemId);	//нужный элемент
   itm.click;
  end;
  function translatedate(D1:string):string;
  begin
   if Length(D1)=1 then
    translatedate:='0'+D1
   else
    translatedate:=D1;
  end;

  function translateyear(D1:string):string;
  begin
   if Length(D1)=2 then
    translateyear:='20'+D1
   else
    translateyear:=D1;
  end;

  function CheckSex(LastName:string):integer;
   var L:integer;
   LastSymbols:string;
   LastName1:string;
  begin
 // Если отчество заканчивается на "НА" или "КЫЗЫ" - то пол женский,
      // а если на "ИЧ" или "ОГЛЫ" - то мужской
      LastName1:=AnsiUpperCase(LastName);
      L := Length(LastName1);
      if L > 2 then
      begin
        LastSymbols := Copy(LastName1, L-1, 2);
        if (LastSymbols = 'НА') or (LastSymbols = 'ЗЫ' {"КЫЗЫ"}) then
          CheckSex := 1 // Женский
        else begin
         if (LastSymbols = 'ИЧ') or (LastSymbols = 'ЛЫ' {"ОГЛЫ"}) then
          CheckSex := 2 // Мужской
         else
          CheckSex := 0; // не определили
        end;
      end
      else begin
          CheckSex := 0; // не определили
      end;

  end;

procedure WaitSearch;
 var
  ii : integer;
  d1,d2:TDatetime;
  sec:integer;
begin
   isSearch:=false;
   d1:=now;
   while not isSearch do begin
     //проверка на timeout
     d2:=now;
     Sec := Round( (D2 - D1) * 24 * 60 * 60 );
     if Sec>30 then begin
      AddLog('Превышено время ожидания1.');
      isSearch:=true;
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

procedure WaitSearch1(nameEl:string);
 var
  ii : integer;
  d1,d2:TDatetime;
  sec:integer;
begin
   isSearch:=false;
   d1:=now;
   while not isSearch do begin
     //проверка на timeout
     d2:=now;
     Sec := Round( (D2 - D1) * 24 * 60 * 60 );
     if Sec>30 then begin
      AddLog('Превышено время ожидания WaitSearch1 элемента - '+nameEl);
      isSearch:=true;
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

Function CompleteLoadAndCheckError1(mes:string):boolean;
 var
  ii:integer;
  IsErrorInner:boolean;
  comliteLoad1:boolean;
begin
  comliteLoad:=false;
  comliteLoad1:=false;
  IsErrorInner:=false;
  while (comliteLoad=false) do begin //or (comliteLoad1=false)
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
       //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);

       if (iElement.id='sbms_modal_confirmFrame') then begin
        comliteLoad1:=true;
       end;
       if assigned(iTable) then
       begin
          if (iElement.id='error_div') then begin
           comliteLoad:=true;
           //if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )='none') then
           // AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибок '+mes+' нет.');
          end;
          //sleep(1000);
          //Application.ProcessMessages;
          if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then begin
           AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+iElement.innerText);
           //ShowMessage('ошибка!!!');
           IsErrorInner:=true;
           comliteLoad1:=true;
           break;
          end;

       end;
     end;
   end;
  end;
  CompleteLoadAndCheckError1:=IsErrorInner;

end;


procedure WaitSearch1_New(nameEl:string);
 var
  ii : integer;
  d1,d2:TDatetime;
  sec:integer;
  tempStr:string;
begin
   isSearch:=false;
   d1:=now;
   while not isSearch do begin
     //проверка на timeout
     d2:=now;
     Sec := Round( (D2 - D1) * 24 * 60 * 60 );
     CompleteLoadAndCheckError1('сохранения');
     //Sec>30
     if Sec>30 then begin
      AddLog('Превышено время ожидания WaitSearch1_New. Элемент - '+nameEl);
      isSearch:=true;
     end;
     Application.ProcessMessages;
     for ii:=1 to HTML_Doc.All.Get_length do begin
       //Application.ProcessMessages;
       iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
       iDisp.QueryInterface(IHTMLElement, iElement);
       //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display+'/'+iElement.innerText);
       if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then begin
          tempStr:=iElement.innerText;
          AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+tempStr);
       end; //shell.modal_msg1_container
       if iElement.id=nameEl then begin
         isSearch:=true;
       end;
     end;
   end;
end;

procedure WaitSearch1_New_Dinam(nameEl:string);
 var
  ii : integer;
  d1,d2:TDatetime;
  sec:integer;
  tempStr:string;
begin
   isSearch:=false;
   d1:=now;
   while not isSearch do begin
     //проверка на timeout
     d2:=now;
     Sec := Round( (D2 - D1) * 24 * 60 * 60 );
     CompleteLoadAndCheckError1('сохранения');
     //Sec>30
     if Sec>30 then begin
      AddLog('Превышено время ожидания WaitSearch1_New. Элемент - '+nameEl);
      isSearch:=true;
     end;
     Application.ProcessMessages;
     for ii:=1 to HTML_Doc.All.Get_length do begin
       //Application.ProcessMessages;
       iDisp:=HTML_Doc.Get_all.item(pred(ii),0);
       iDisp.QueryInterface(IHTMLElement, iElement);
       //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display+'/'+iElement.innerText);
       if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then begin
          tempStr:=iElement.innerText;
          AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+tempStr);
       end; //shell.modal_msg1_container
       if COPY(iElement.id,0,14)=COPY(nameEl,0,14) then begin
         isSearch:=true;
       end;
     end;
   end;
end;


Function CompleteLoadAndCheckError(mes:string):boolean;
 var
  ii:integer;
  IsErrorInner:boolean;
  tempStr:string;
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
          if (iElement.id='error_div') then begin
           comliteLoad:=true;
           if iElement.style.getAttribute( 'display', 0 )='none' then
            AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибок '+mes+' нет.');
          end;
          //sleep(1000);
          //Application.ProcessMessages;
          if (iElement.id='error_div') and (iElement.style.getAttribute( 'display', 0 )<>'none') then begin
           tempStr:=iElement.innerText;
           AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Ошибка: '+tempStr);
           ADOQuery1.Edit;
           if pos('Регистрационные данные по данному телефону уже внесены',tempStr)>0 then
            ADOQuery1.FieldByName('принял').AsString:='V'
           else
            ADOQuery1.FieldByName('принял').AsString:='E';
           //ShowMessage('ошибка!!!');
           ADOQuery1.Post;
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


procedure WaitElement(ElName:string);
 var
  ii,iii:integer;
  IsErrorInner:boolean;
  d1,d2:TDatetime;
  sec:integer;
begin
  comliteLoad:=false;
  IsErrorInner:=false;
  d1:=now;
  iii:=1;
  while not comliteLoad do begin
   d2:=now;
   Sec := Round( (D2 - D1) * 24 * 60 * 60 );
   if Sec>30 then begin
    AddLog('Превышено время ожидания элемент '+ElName+'.');
    comliteLoad:=true;
   end;

   Application.ProcessMessages;
   for ii:=1 to iDoc.All.Get_length do begin
     iDisp:=iDoc.Get_all.item(pred(ii),0);
     iDisp.QueryInterface(IHTMLElement, iElement);
     //Str(pred(i),S);
     //S:= S+'';
     if assigned(iElement) then
     begin
      //S:=S+'tag='+iElement.Get_tagName+' ';   _shell.modal_msg1_btn_0
      //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
      if (iElement.id=ElName) then begin
       comliteLoad:=true;
       break;
      end;
     end;
   end;
  end;

end;


function WaitElementDinam(ElName:string) : string;
 var
  ii,iii:integer;
  IsErrorInner:boolean;
  d1,d2:TDatetime;
  sec:integer;
begin
  comliteLoad:=false;
  IsErrorInner:=false;
  d1:=now;
  iii:=1;
  while not comliteLoad do begin
   d2:=now;
   Sec := Round( (D2 - D1) * 24 * 60 * 60 );
   if Sec>30 then begin
    AddLog('Превышено время ожидания элемент '+ElName+'.');
    comliteLoad:=true;
   end;

   Application.ProcessMessages;
   for ii:=1 to iDoc.All.Get_length do begin
     iDisp:=iDoc.Get_all.item(pred(ii),0);
     iDisp.QueryInterface(IHTMLElement, iElement);
     //Str(pred(i),S);
     //S:= S+'';
     if assigned(iElement) then
     begin
      //S:=S+'tag='+iElement.Get_tagName+' ';   _shell.modal_msg1_btn_0
      //AddLog('Element-'+'name-'+iElement.id+'.'+iElement.style.visibility+'/'+iElement.style.display);
      if COPY(iElement.id,0,15)+COPY(iElement.id,length(iElement.id)-4,4)= COPY(ElName,0,15)+COPY(ElName,length(ElName)-4,4) then begin
       comliteLoad:=true;
       result:= iElement.id;
       break;
      end;
     end;
   end;
  end;
end;


function checkDate(dd:string;mm:string; yyyy:string):boolean;
begin
 checkDate:=true;
 if Length(dd)<>2 then begin
  AddLog('Неверная длина дня - '+inttostr(Length(dd)));
  checkDate:=false;
 end;
 if Length(mm)<>3 then begin
  AddLog('Неверная длина месяца - '+inttostr(Length(mm)));
  checkDate:=false;
 end;
 if mm[1]<>'.' then begin
  AddLog('Неверный формат месяца');
  checkDate:=false;
 end;
 if yyyy[1]<>'.' then begin
  AddLog('Неверный формат года');
  checkDate:=false;
 end;

 if Length(yyyy)<>5 then begin
  AddLog('Неверная длина года - '+inttostr(Length(yyyy)));
  checkDate:=false;
 end;

end;

  Procedure procmes(cnt:integer);
  var
    p, m:integer;
  begin
    m:=1;
    while m<cnt do
    begin
      for p := 1 to 100 do
        Application.ProcessMessages;
        m:=m+1;
        sleep(100);
    end;
  end;

begin
  pagecontrol1.TabIndex:=0;
  PDF_Save:=FALSE;
  try
    if ADOQuery1.FieldByName('принял').AsString='V' then
    begin
      AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Уже был успешно обработан.');
      exit;
    end;
  except
    on E: exception do
    begin
      AddLog('Ошибка при работе с БД Access: '+E.Message);
      exit;
    end;
  end;

  {try
   if ADOQuery1.FieldByName('план').AsString='' then begin
    AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Отсутствует тарифный план.');
    exit;
   end;
  except
   on E: exception do begin
     AddLog('Ошибка при работе с БД Access: '+E.Message);
     exit;
   end;
  end; }

  try
    HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
    Window := HTML_Doc.parentWindow as IHTMLWindow2;
    //frame:=Window.frames.item('fr4').document;
    frame:=Window.frames.item('fr3').document;
    //frame:=Window.frames.item('fr1').document;
    WaitProcessMessage(8);
    FillFrameField('тел номер', 'pmsisdn_find');
    FillFrameField('номер сим карты', 'picc_find');
    ClickElement('btn_find_msisdn_icc');	// Найти
    WaitProcessMessage(8);
    //frameDispatch:=Window.frames.item('fr4');
    frameDispatch:=Window.frames.item('fr3');
    //frameDispatch:=Window.frames.item('fr1');

    if Assigned(frameDispatch) then
    begin
      childWindow := frameDispatch as IHTMLWindow2;
      iDoc:=childWindow.document;
    end;

    // ExecParamL:='function rtpl_onchange() { var ctrl = g_tag[''prtpl_id'']; if (!ctrl) return false; if (ctrl.old_value && (ctrl.old_value == ctrl.value)) return false; ctrl.old_value = ctrl.value; request_pack_srls_list("prtpl_id"); } ';
    //Window.execScript(ExecParamL,'JavaScript');
    //WaitSearch; --28.11.2012
    procmes(TimeOut);

    IsError:=CompleteLoadAndCheckError('поиска');
  except
    on E : exception do
    begin
      IsError:=true;
      AddLog('Ошибка поиска документа: '+E.Message);
    end;
  end;

  if not IsError then
  begin
    try
      WaitProcessMessage(8);
      frame:=Window.frames.item('fr3').document;
      //frame:=Window.frames.item('fr1').document;
      //FillFrameField('номер сим карты', 'picc_find');
      element := Frame.getelementbyid('pname');
      element.value:=TRIM(ADOQuery1.FieldByName('фамилия').AsString)+' '+TRIM(ADOQuery1.FieldByName('имя').AsString)+' '+TRIM(ADOQuery1.FieldByName('отчество').AsString);//номер сим карты '89701026589083615';
      element := Frame.getelementbyid('psign_date');

      isCheck := checkDate((TRIM(ADOQuery1.FieldByName('дата день').AsString)),'.'
                  + translatedate(TRIM(ADOQuery1.FieldByName('дата месяц').AsString)),'.'
                  + translateyear(TRIM(ADOQuery1.FieldByName('дата год').AsString)));

      if not isCheck then
        exit;

      element.value := translatedate(TRIM(ADOQuery1.FieldByName('дата день').AsString))
                        +'.'+translatedate(TRIM(ADOQuery1.FieldByName('дата месяц').AsString))+'.'
                        +translateyear(TRIM(ADOQuery1.FieldByName('дата год').AsString));//номер сим карты '89701026589083615';

      element := Frame.getelementbyid('pdate_of_birth');

      element.value := translatedate(TRIM(ADOQuery1.FieldByName('дата р день').AsString))+'.'
                        +translatedate(TRIM(ADOQuery1.FieldByName('дта р месяц').AsString))+'.'
                        +TRIM(ADOQuery1.FieldByName('дата р год').AsString);

      element := Frame.getelementbyid('pidtp_idtp_id');
      element.selectedindex := Passport_id;
      // пол
      element := Frame.getelementbyid('pgnd_gnd_id');
      tempSex := CheckSex(TRIM(ADOQuery1.FieldByName('отчество').AsString));
      if tempSex=0 then
      begin
         AddLog('Ошибка определения пола. Проверьте отчество.');
        exit;
      end;

      element.selectedindex := tempSex;
       //element.selectedindex := CheckSex(ADOQuery1.FieldByName('отчество').AsString);
      //     element.selected := 'Муж.';
       //element.value:='1';
       //element.click;
       //резидент
      element := Frame.getelementbyid('pclrt_clrt_id');
      element.selectedindex := 2;
       //ShowMessage(Frame.Content);

       // 18.06.2014 Отключены, так как тариф предустановлен на сим-карте
       // Тариф
       {if TRIM(ADOQuery1.FieldByName('план').AsString)<>''  then
       begin
       ovElements := Frame.getelementbyid('prtpl_id');
       tempgetvaluetarif:=getvaluetarif(TRIM(ADOQuery1.FieldByName('план').AsString));
       if tempgetvaluetarif<>-1 then
          ovElements.selectedindex := tempgetvaluetarif
       else
          Raise Exception.Create('Ошибка определения тарифа.');
       //WaitProcessMessage(4);
       ovElements.onchange;
       ovElements := frame.getelementbyid('prtpl_id');	//нужный элемент
       if ovElements.selectedindex <> tempgetvaluetarif then
          Raise Exception.Create('Ошибка определения тарифа.');
       //WaitProcessMessage(4);
       end; }

      FillFrameField(TRIM('п серия'), 'ppass_ser');

      if IsNullCheck then
      begin
        AddLog('Ошибка определения серии паспорта.');
        exit;
      end;


      FillFrameField(TRIM('п номер'), 'ppass_num');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения номера паспорта.');
        exit;
      end;

      FillFrameField(TRIM('п выдан'), 'ppass_place');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения "Паспорт выдан".');
        exit;
      end;

      element := Frame.getelementbyid('ppass_date');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения поля ppass_date.');
        exit;
      end;

      element.value := translatedate(TRIM(ADOQuery1.FieldByName('п дата день').AsString))+'.'
                       +translatedate(TRIM(ADOQuery1.FieldByName('п дата месяц').AsString))+'.'
                       +TRIM(ADOQuery1.FieldByName('п дата год').AsString);

      FillFrameField(TRIM('улица'), 'pjur_strt_strt_id');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения поля улица.');
        exit;
      end;
      FillFrameField(TRIM('дом'), 'pjur_house');

      FillFrameField(TRIM('квартира'), 'pjur_appartment');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения поля квартира.');
        exit;
      end;

      FillFrameField(TRIM('дом'), 'pjur_house');
      if IsNullCheck then
      begin
        AddLog('Ошибка определения поля дом.');
        exit;
      end;

      element := Frame.getelementbyid('prepr_name');
      element.value:='Курило Н. И.';

      element := Frame.getelementbyid('pother_oper');
      element.checked:=true;
      element := Frame.getelementbyid('psend_adver');
      element.checked:=true;
      element := Frame.getelementbyid('pother_servinfo');
      element.checked:=true;

      element := Frame.getelementbyid('pphone_sw');
      if element.Checked then
        ClickElement('pphone_sw');


      element := Frame.getelementbyid('pjur_e_mail_sw');
      if element.Checked then
        ClickElement('pjur_e_mail_sw');
    except
      on E : exception do
      begin
        AddLog('Ошибка поиска документа: '+E.Message);
        exit;
      end;
    end;

    if cbSave.Checked then
    begin
      try
        //28.11.2012
        procmes(TimeOut*10);
        //ClickElement('BTN_SAVE');
        ClickElement('BTN_SAVE'); //!!!!!!!!!!!!!!!!!!!!!!!Сохранение
        //анализ наличия ошибки
        IsError:=CompleteLoadAndCheckError1('сохранения');
      except
        on E : exception do
        begin
          AddLog('Ошибка при сохранении документа: '+E.Message);
          exit;
        end;
      end;
     //обработка: Вы уверены? Да, нет.

     //ожидание загрузки фрэйма sbms_modal_confirmFrame
      try
        //WaitSearch1_New('sbms_modal_confirmFrame');
        procmes(TimeOut);
        //WaitSearch1_New('sbms_modal_confirmFrame'); PS_SBMS_WORK_WINDOW
        //WaitSearch1_New('PS_SBMS_WORK_WINDOW');
        WaitSearch1_New_Dinam('shell.modal_msg1_container');
        procmes(TimeOut);
      except
        on E : exception do
        begin
          AddLog('Ошибка ожидания фрэйма подтверждения сохранения.: '+E.Message);
          exit;
        end;
      end;
      procmes(TimeOut);

      if not IsError then
      begin
        try
          HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
          Window := HTML_Doc.parentWindow as IHTMLWindow2;
          (* 28.11.2012
          frameDispatch:=Window.frames.item('sbms_modal_confirmFrame');
          MemoLog.Lines.Add('-33');
          if Assigned(frameDispatch) then
          begin
            childWindow := frameDispatch as IHTMLWindow2;
            iDoc:=childWindow.document;
          end;
          MemoLog.Lines.Add('-44');

          //ожидание загрузки sbms_modal_confirm_btn_0 для Click
          MemoLog.Lines.Add('0');*)
          iDoc:=Window.document;

          //28.11.2012
          //WaitElement('sbms_modal_confirm_btn_0');
          //WaitSearch1_New('_shell.modal_msg4_btn_0');
          SaveDialog:=WaitElementDinam('_shell.modal_msg1_btn_0');

          //frame1:=Window.frames.item('sbms_modal_confirmFrame').document;
          frame1:=Window.document;
          element := Frame1.getelementbyid(SaveDialog);
          //element := frame1.getelementbyid('sbms_modal_confirm_btn_0');
          //нажатие на кнопку sbms_modal_confirm_btn_0
          element.click;

        except
          on E : exception do
          begin
            AddLog('Ошибка подтверждения сохранения документа: '+E.Message);
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

          if cbReportSave.Checked=TRUE then
          Begin
            try
              WaitElement('BTN_REP');
              frame1:=Window.frames.item('g_modal_after_saveFrame').document;
              element := Frame1.getelementbyid('BTN_REP');
              //нажатие на кнопку BTN_REP
              element.click;
              //Ожидание браузера
              WaitProcessMessage(10);
              {SW:=CoShellWindows.Create;
              for j:=2 to SW.Count-1 do
                form2.WebBrowser2.Navigate2(SW.Item(j).LocationURL); }
              // Ожидание загрузки PDF
              //WaitProcessMessage(8);

            except
              on E : exception do
                AddLog('Ошибка нажатия на кнопку Печатать договор: '+E.Message);
            end;

            PDFPath:= path_dir + '\PDF\' + ADOQuery1.FieldByName('тел номер').AsString +'.pdf';
            timer1.Enabled:= TRUE;

            while PDF_Save <> TRUE do
            Forms.Application.ProcessMessages;
            WaitProcessMessage(8);
          end;

          WaitElement('BTN_NEW_CLNT');
          frame1:=Window.frames.item('g_modal_after_saveFrame').document;
          element := Frame1.getelementbyid('BTN_NEW_CLNT');
          //нажатие на кнопку BTN_NEW_CLNT
          element.click;
          AddLog('Номер '+ADOQuery1.FieldByName('тел номер').AsString+'. Успешно сохранён.');
          ADOQuery1.Edit;
          ADOQuery1.FieldByName('принял').AsString:='V';
          ADOQuery1.Post;
        except
          on E : exception do
          begin
            AddLog('Ошибка нажатия на кнопку ввод нового клиента: '+E.Message);
            exit;
          end;
        end;
      end;
    end;
  end;
  Excel(ADOQuery1, DBGrid1, XLApp, ExpExcel);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
IniFile: TIniFile;
begin
 //path_dir:=GetCurrentDir;
 IniFile:=TIniFile.Create(path_dir+'SBMS.ini');
 IniFile.WriteString('Site', 'www', 'https://www.activa.megadealer.ru/ps/sbms/shell.html');
 IniFile.WriteString('Base', 'Path', 'C:\tempWork\SBMS\base\Megafon # + интерком.mdb');
end;

procedure TForm1.Button6Click(Sender: TObject);
var
      i : integer;
      iDoc : IHtmlDocument2;
      iDisp : IDispatch;
      frameDispatch:IDispatch;
      iElement : IHTMLElement;
      t1:IHTMLFramesCollection2;
      ff:IHtmlDocument2;
      iInputElement : IHTMLInputElement;
      iOption:IHTMLOptionElement;
      iDiv:IHTMLDivElement;
      iTable:IHTMLTable;
      S : string;
      pDisp: IDispatch;

      HTML_Doc : IHTMLDocument2;
      Window : IHTMLWindow2;
      childWindow: IHTMLWindow2;
begin
  //.Clear;
  //HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
  //Window := HTML_Doc.parentWindow as IHTMLWindow2;
   HTML_Doc := WebBrowser1.Document as IHTMLDocument2;
   Window := HTML_Doc.parentWindow as IHTMLWindow2;
   frameDispatch:=Window.frames.item('sbms_modal_confirmFrame');
   if Assigned(frameDispatch) then
   begin
    childWindow := frameDispatch as IHTMLWindow2;
    iDoc:=childWindow.document;
   end;

  //iDoc:=(pDisp as IWebBrowser).Document as IHtmlDocument2;
  for i:=1 to iDoc.All.Get_length do begin
    iDisp:=iDoc.Get_all.item(pred(i),0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    //Str(pred(i),S);
    //S:= S+'';
     if assigned(iElement) then
     begin
         //S:=S+'tag='+iElement.Get_tagName+' ';
         iElement.QueryInterface(IHTMLtable,iTable);
      if assigned(iTable) then
      begin
         Str(pred(i),S);
         S:= S+'';
         //S:=S+'tag='+iElement.Get_tagName+' ';

         S:=S+'Name='+iElement.id+'; display='+iElement.style.getAttribute( 'display', 0 )+' ';

         //S:=S+'name='+iDiv.;
         AddLog(S);
      end;
    end;
  end;

end;
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.Checked then begin
   //(принял<>''V'') or ((((Контракт.
   ADOQuery1.Active:=false;
   ADOQuery1.sql.Clear;
   ADOQuery1.sql.Add('select * from контракт where принял Is NULL OR принял<>"V"');
   ADOQuery1.Active:=true;
   //ADOQuery1.Filter :='принял Is NULL';
   //ADOQuery1.Filtered:=true;
 end
 else begin
   ADOQuery1.Active:=false;
   ADOQuery1.sql.Clear;
   ADOQuery1.sql.Add('select * from контракт');
   ADOQuery1.Active:=true;
 end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
IniFile: TIniFile;
b1:boolean;
begin
 ListProcIE;
 WebBrowser2.Silent := true;
 path_dir:=GetCurrentDir;
 IniFile:=TIniFile.Create(path_dir+'\SBMS.ini');
 Ident_Login:=IniFile.ReadString('Ident', 'Login','');
 Ident_pass:=IniFile.ReadString('Ident', 'pass','');
 Site_www:=IniFile.ReadString('Site', 'www','');
 Base_path:= IniFile.ReadString('Base', 'Path','');
 TimeOut:=IniFile.ReadInteger('Options', 'TimeOut',10);
 //ExpExcel:=IniFile.ReadString('Export', 'Excel','');
 ExpExcel:=path_dir+'\ExportAbon.xlsx';
 Passport_id:=IniFile.ReadInteger('Passport', 'Passport_id',-1);
 ListTarifs:=TStringList.Create;
 ListTarifNames:=TStringList.Create;
 IniFile.ReadSectionValues('PlanTarifs', ListTarifs);
 IniFile.ReadSection('PlanTarifs',ListTarifNames);

 if not DirectoryExists(path_dir+'\Log') then
  if not CreateDir(path_dir+'\Log') then
   ShowMessage('Ошибка создания каталога \Log');

 if not DirectoryExists(path_dir+'\PDF') then
  if not CreateDir(path_dir+'\PDF') then
   ShowMessage('Ошибка создания каталога \PDF');

 //if Base_path='' or not
 if (not FileExists(Base_path)) or (Base_path='') then begin
  if OpenDialog1.Execute then begin
    Base_path:=OpenDialog1.FileName;
    ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+OpenDialog1.FileName+';Persist Security Info=False';
    IniFile.WriteString('Base', 'Path', OpenDialog1.FileName);
  end;
 end
 else begin
   ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+Base_path+';Persist Security Info=False';
  //ADOConnection1.Connected:=true;
 end;
 ADOConnection1.Connected:=true;
 ADOQuery1.Active:=true;
 WebBrowser1.Navigate(Site_www);

end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
 SW:Variant;
 ie: THandle;
 i: integer;
begin
  ie := FindWindow(pchar('IEFrame'),nil);
  SW:=CoShellWindows.Create;
  for I:=0 to SW.Count-1 do
    begin
      if SW.item(i).hwnd = ie then
        WebBrowser2.Navigate2(SW.Item(I).LocationURL);
    end;
  timer1.Enabled:=false;
  pagecontrol1.TabIndex:=1;
  timer3.Enabled:=TRUE;
end;

end.
