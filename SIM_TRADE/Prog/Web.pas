unit Web;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw,
   StdCtrls, InvokeRegistry, Rio, SOAPHTTPClient,XSBuiltIns,
  ExtCtrls, DB, DBAccess, Ora, DBCtrls, MemDS, OraSmart, dblookup, Vcl.ComCtrls, DateUtils,
  sButton, sSkinManager, acMagn,MSHTML,WinInet;

type

  TFormWeb = class(TForm)
    wb: TWebBrowser;
    qNumberinfo: TOraQuery;
    procedure wbDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      const URL: OleVariant);
  procedure checkNumber;
    procedure FormShow(Sender: TObject);
    procedure ClosePage;
  private

  public
  Phone_n:string;
  activated:Boolean;

  end;

var
 formweb:TFormWeb;
 myDoc: IHTMLDocument2;
 myForm: IHTMLFormElement;
 docloaded:Boolean;
 closeloaded:Integer=0;
implementation

{$R *.dfm}


function GetToken(Cadena, Separador: String; Token: Integer): String;
 var
 Posicion: Integer;
 begin
 while Token > 1 do begin
 Delete(Cadena, 1, Pos(Separador,Cadena)+Length(Separador)-1);
 Dec(Token);
 end;
 Posicion:= Pos(Separador, Cadena);
 if Posicion = 0
 then Result:= Cadena
 else Result:= Copy(Cadena, 1, Posicion-1);
 end;

 function GetFormByName(document: IHTMLDocument2;
    const formName: string): IHTMLFormElement;
var
  forms: IHTMLElementCollection;
begin
  forms := document.Forms as IHTMLElementCollection;
  result := forms.Item(formName,'') as IHTMLFormElement
end;
 function GetFormFieldNames(fromForm: IHTMLFormElement): TStringList;
var
  index: integer;
  field: IHTMLElement;
  input: IHTMLInputElement;
  select: IHTMLSelectElement;
  text: IHTMLTextAreaElement;
begin
  result := TStringList.Create;
  for index := 0 to fromForm.length do
  begin
    field := fromForm.Item(index,'') as IHTMLElement;
    if Assigned(field) then
    begin
      if field.tagName = 'INPUT' then
      begin
        // Input field.
        input := field as IHTMLInputElement;
        result.Add(input.name);
      end
      else if field.tagName = 'SELECT' then
      begin
        // Select field.
        select := field as IHTMLSelectElement;
        result.Add(select.name);
      end
      else if field.tagName = 'TEXTAREA' then
      begin
        // TextArea field.
        text := field as IHTMLTextAreaElement;
        result.Add(text.name);
      end;
    end;
  end;
end;

procedure SetFieldValue(theForm: IHTMLFormElement;
const fieldName: string; const newValue: string;
const instance: integer=0);
var
field: IHTMLElement;
inputField: IHTMLInputElement;
selectField: IHTMLSelectElement;
textField: IHTMLTextAreaElement;
begin
field := theForm.Item(fieldName,instance) as IHTMLElement;
if Assigned(field) then
begin
if field.tagName = 'INPUT' then
begin
inputField := field as IHTMLInputElement;
if (inputField.type_ <> 'radio') and
(inputField.type_ <> 'checkbox')
then
inputField.value := newValue
else
inputField.checked := (newValue = 'checked');
end
else if field.tagName = 'SELECT' then
begin
selectField := field as IHTMLSelectElement;
selectField.value := newValue;
end
else if field.tagName = 'TEXTAREA' then
begin
textField := field as IHTMLTextAreaElement;
textField.value := newValue;
end;
end;
end;


procedure DeleteIECache;
var
lpEntryInfo: PInternetCacheEntryInfo;
hCacheDir: LongWord;
dwEntrySize: LongWord;
begin
    dwEntrySize := 0;
    FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
    GetMem(lpEntryInfo, dwEntrySize);
    if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
    hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
    if hCacheDir <> 0 then
            repeat
                DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
                FreeMem(lpEntryInfo, dwEntrySize);
                dwEntrySize := 0;
                FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
                GetMem(lpEntryInfo, dwEntrySize);
                if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
            until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
    FreeMem(lpEntryInfo, dwEntrySize);
    FindCloseUrlCache(hCacheDir);
end;

procedure tformweb.checkNumber;
begin

 with qNumberinfo do begin
  Close;
  ParamByName('phone').AsString:=Phone_n;
  Open;
   if (Eof or FieldByName('OBJ_ID').IsNull) then activated:=false else activated:=True;
 end;

end;

procedure TFormWeb.ClosePage;
procedure timeexec(sender:TObject);
begin
   closeloaded:=4;
end;
var
  i:integer;
  timer:TTimer;
  Mtimeexec:TMethod;

begin
  closeloaded:=1;
   for I := 0 to wb.OleObject.Document.links.Length-1 do
          begin
            if (AnsiUpperCase(wb.OleObject.Document.links(i).id) = 'USERBUTTONS:LOGOUT') then
                wb.OleObject.Document.links(i).Click;
          end;
   timer:=TTimer.Create(nil);
   MtimeExec.Code:=@timeexec;
   with timer do
   begin
   Interval:=5000;
   OnTimer:=TNotifyEvent(MtimeExec);
   Enabled:=True;
   end;
   repeat Application.ProcessMessages; until (closeloaded=4);
   FreeAndNil(timer);
   Freeandnil(WB)
end;

procedure TFormWeb.FormShow(Sender: TObject);
var
  i:integer;
  Sender_name:string;
begin
  docloaded:=False;
  wb.Navigate('http://www.tarifer.ru');
  DeleteIECache;
  wb.Navigate('https://my.beeline.ru/login.html');
  wb.Silent:=True;
  repeat Application.ProcessMessages; until (docloaded);
  Sleep(1000);
  //mydoc:= wb.Document as IHTMLDocument2;
  wb.ControlInterface.Document.QueryInterface(IHtmlDocument2,mydoc);
  if Assigned(myDoc) then
      begin
        myForm:=GetFormByName(myDoc,'loginFormB2C:loginForm');
        // ListBox1.Items:=GetFormFieldNames(myForm);
        SetFieldValue(myForm,'loginFormB2C:loginForm:login',qNumberinfo.FieldByName('login').AsString);
        SetFieldValue(myForm,'loginFormB2C:loginForm:password',qNumberinfo.FieldByName('new_pswd').AsString);
        for I := 0 to wb.OleObject.Document.Forms.Item(0).Elements.Length-1 do
          begin
            if (AnsiUpperCase(wb.OleObject.Document.Forms.Item(0).Elements.Item(i).type) = 'SUBMIT') or
            (AnsiUpperCase(wb.OleObject.Document.Forms.Item(0).Elements.Item(i).type) = 'BUTTON') then
              if (wb.OleObject.Document.Forms.Item(0).Elements.item(i).Value = ' Войти')
              then wb.OleObject.Document.Forms.Item(0).Elements.Item(i).Click;
          end;
        Sleep(2000);
        docloaded:=False;
        wb.Navigate('https://my.beeline.ru'+qNumberinfo.FieldByName('OBJ_ID').AsString);
        repeat Application.ProcessMessages; until (docloaded);
      end;
end;

procedure TFormWeb.wbDocumentComplete(ASender: TObject; const pDisp: IDispatch;
  const URL: OleVariant);
begin
 docloaded:=True;
 if closeloaded>0 then closeloaded:=closeloaded+1;

 //if (Assigned(myDoc) and Assigned(formweb))  then Width := (mydoc.body as IHTMLElement2).scrollWidth+30;
end;

end.



