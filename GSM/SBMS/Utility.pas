unit Utility;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, ComObj,
  OleCtrls, SHDocVw, mshtml, IniFiles, ToolWin, ComCtrls, DBCtrls, TlHelp32,clipbrd;

procedure KillProcIE(ID: Cardinal);
procedure ListProcIE;
procedure WaitProcessMessage(WaitSec: integer);

implementation

//Убивает процесс
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

// Находит и убивает процесс Internet Explorer
procedure ListProcIE;
var
  hSnapShot: THandle;
  lppe: TProcessEntry32;
  //hIcon: THandle;
  Count: Integer;
  procedure _FillList;
    begin
      if lppe.szExeFile = 'iexplore.exe' then
      begin
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

// Ожидание действий от процесса
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

end.
