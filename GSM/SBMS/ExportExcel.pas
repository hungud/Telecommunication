unit ExportExcel;
interface

uses DBGrids,Windows, Messages,SysUtils,VCL.FlexCel.Core, FlexCel.XlsAdapter,
Forms,FlexCel.Render, FlexCel.Pdf,ToolWin,IOUtils,  Ora, ADODB, ComObj, OleCtrls,
Variants, Classes, Graphics,Controls, StdCtrls,CRGrid,ShellAPI,dialogs;

  procedure Excel(ADOQuery: TADOQuery; DBGrid: TDBGrid; XLApp: Variant; ExpExcel: string);

implementation
uses DB, Math;

procedure Excel(ADOQuery: TADOQuery; DBGrid: TDBGrid; XLApp: Variant; ExpExcel: string);
var
// XLApp,
 Sheet,Colum:Variant;
 index,i,j:Integer;
begin
 XLApp:= CreateOleObject('Excel.Application');

 XLApp.Visible:=false;
 Try
  XLApp.Workbooks.open(ExpExcel);
 Except
  XLApp.Workbooks.Add(-4167);
 end;

 Colum:=XLApp.Workbooks[1].WorkSheets[1].Columns;
 Colum.Columns[1].ColumnWidth:=50;
 Colum.Columns[2].ColumnWidth:=20;
 Colum:=XLApp.Workbooks[1].WorkSheets[1].Rows;
 Colum.Rows[2].Font.Bold:=true;
 Colum.Rows[1].Font.Bold:=true;
 Colum.Rows[1].Font.Color:=clBlue;
 Colum.Rows[1].Font.Size:=12;
 Sheet:=XLApp.Workbooks[1].WorkSheets[1];
 //Sheet.Cells[1,1]:=IntToStr(DBGrid.SelectedRows.Count);
 //Sheet.Cells[1,2]:='Заголовок';
 Sheet.Cells[2,1]:='Дата день';
 Sheet.Cells[2,2]:='Дата месяц';
 Sheet.Cells[2,3]:='Дата год';
 Sheet.Cells[2,4]:='Физ. лицо';
 Sheet.Cells[2,5]:='Фамилия';
 Sheet.Cells[2,6]:='Имя';
 Sheet.Cells[2,7]:='Отчество';
 Sheet.Cells[2,8]:='Дата рождения (день)';
 Sheet.Cells[2,9]:='Дата рождения (месяц)';
 Sheet.Cells[2,10]:='Дата рождения (год)';
 Sheet.Cells[2,11]:='Пол М';
 Sheet.Cells[2,12]:='Пол Ж';
 Sheet.Cells[2,13]:='Паспорт';
 Sheet.Cells[2,14]:='П серия';
 Sheet.Cells[2,15]:='П номер';
 Sheet.Cells[2,16]:='П выдан';
 Sheet.Cells[2,17]:='П дата (день)';
 Sheet.Cells[2,18]:='П дата (месяц)';
 Sheet.Cells[2,19]:='П дата (год)';
 Sheet.Cells[2,20]:='Город';
 Sheet.Cells[2,21]:='Улица';
 Sheet.Cells[2,22]:='Дом';
 Sheet.Cells[2,23]:='Корпус';
 Sheet.Cells[2,24]:='Квартира';
 Sheet.Cells[2,25]:='Инициал И';
 Sheet.Cells[2,26]:='Инициал О';
 Sheet.Cells[2,27]:='К тел';
 Sheet.Cells[2,28]:='Модель тел';
 Sheet.Cells[2,29]:='Сер.номер';
 Sheet.Cells[2,30]:='План';
 Sheet.Cells[2,31]:='Номер сим-карты';
 Sheet.Cells[2,32]:='Тел. код';
 Sheet.Cells[2,33]:='Тел. номер';
 Sheet.Cells[2,34]:='Puk';
 Sheet.Cells[2,35]:='Номер диллера';
 Sheet.Cells[2,36]:='Диллер';
 Sheet.Cells[2,37]:='Принял';
 Sheet.Cells[2,38]:='№ т т';
 Sheet.Cells[2,39]:='№ договора';
 Sheet.Cells[2,40]:='Место рождения';

 if XLApp.ActiveSheet.UsedRange.Rows.Count=0
 then
  index:=3
 else
  index:= XLApp.ActiveSheet.UsedRange.Rows.Count+1;


 with DBGrid.DataSource.DataSet do
 begin
  begin
   for j := 1 to 40 do
    Sheet.Cells[index,j]:=ADOQuery.Fields.Fields[j-1].AsString;
  end;
    if ADOQuery.Fields.Fields[36].AsString='V'
    then
      begin
        Sheet.Cells[index,37]:=' +';
        Sheet.Cells[index,37].interior.colorindex:=4;
      end
    else
      if ADOQuery.Fields.Fields[36].AsString='E'
      then
        begin
          Sheet.Cells[index,37]:=' -';
          Sheet.Cells[index,37].interior.colorindex:=3;
        end
      else
        begin
          Sheet.Cells[index,37]:=' ?';
          Sheet.Cells[index,37].interior.colorindex:=37;
        end;
  end;
 XLApp.DisplayAlerts := False;
 XLApp.ActiveWorkbook.SaveAs(ExpExcel);
 XLApp.DisplayAlerts := True;
 XLApp.Workbooks.Close; //закрываю книги экселя
 XLApp.Quit;  //закрываю эксель
 XLApp:=UnAssigned;
end;

end.
