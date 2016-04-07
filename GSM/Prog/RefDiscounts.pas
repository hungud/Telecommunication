unit RefDiscounts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, DB, Ora, ActnList, Menus, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, StdCtrls, VirtualTable,
  ComObj, DateUtils;

type
  TRefDiscountsForm = class(TTemplateForm)
    qMainPHONE_NUMBER: TStringField;
    qMainIS_DISCOUNT_OPERATOR: TIntegerField;
    qMainDISCOUNT_VALIDITY: TFloatField;
    qMainDISCOUNT_BEGIN_DATE: TDateTimeField;
    cbFilter: TCheckBox;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    aImportExcel: TAction;
    OpenDialog1: TOpenDialog;
    vtLoad: TVirtualTable;
    vtLoadCellNum: TStringField;
    vtLoadDateBegin: TDateTimeField;
    vtLoadDateEnd: TDateTimeField;
    CheckBox1: TCheckBox;
    procedure CRDBGrid1GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure cbFilterClick(Sender: TObject);
    procedure aImportExcelExecute(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefDiscountsForm: TRefDiscountsForm;

implementation

uses Main;

{$R *.dfm}

procedure TRefDiscountsForm.aImportExcelExecute(Sender: TObject);
const
  ExcelApp = 'Excel.Application';
var
  Excel: OleVariant;
  i, Length: integer;
  datecheck, ErrorPhone:string;
begin
  inherited;
  if OpenDialog1.Execute then
  begin
    Excel := CreateOleObject(ExcelApp);
    Excel.Application.EnableEvents := false;
    Excel.Visible:=false;
    Excel.Workbooks.Open(OpenDialog1.FileName);
    i := 1;
    ErrorPhone:='';
    vtLoad.Open;
    vtLoad.Clear;
    while VarToStr(Excel.Cells[i,1]) <> '' do
    begin
      vtLoad.Append;
      vtLoadcellnum.AsString := Excel.Cells[i,1];
      if VarToStr(Excel.Cells[i,2])<>'' then
        vtLoadDateBegin.AsDateTime:=StrToDate(StringReplace(Excel.Cells[i,2],',','.',[rfReplaceAll]))
      else vtLoadDateBegin.AsVariant:=null;
      if VarToStr(Excel.Cells[i,3])<>'' then
        vtLoadDateEnd.AsDateTime:=StrToDate(StringReplace(Excel.Cells[i,3],',','.',[rfReplaceAll]))
      else vtLoadDateEnd.AsVariant:=null;
      vtLoad.Post;
      inc(i);
    end;
    Excel.Quit;
    Excel:=Unassigned;
  end;
  vtLoad.DisableControls;
  vtLoad.Last;
  while not vtLoad.Bof do
    if vtLoadDateEnd.AsDateTime>=Date then
    begin
      if vtLoadDateEnd.AsDateTime>=vtLoadDateBegin.AsDateTime then
      begin
        //Length:=MonthsBetween
        qMain.Insert;
        qMainPHONE_NUMBER.AsString:=vtLoadcellnum.AsString;
        qMainIS_DISCOUNT_OPERATOR.AsInteger:=1;
        Length:=0;
        while abs(IncMonth(vtLoadDateEnd.AsDateTime,-Length)-vtLoadDateBegin.AsDateTime)
                >abs(abs(IncMonth(vtLoadDateEnd.AsDateTime,-Length-1)-vtLoadDateBegin.AsDateTime)) do
          Inc(Length);
        qMainDISCOUNT_VALIDITY.AsInteger:=Length;
        qMainDISCOUNT_BEGIN_DATE.AsDateTime:=IncMonth(vtLoadDateEnd.AsDateTime,-Length);
        try
          qMain.Post;
          vtLoad.Prior;
        except
          ErrorPhone:=ErrorPhone+vtLoadcellnum.AsString+' ';
          vtLoad.Prior;
        end;
      end else
      begin
        ErrorPhone:=ErrorPhone+vtLoadcellnum.AsString+' ';
        vtLoad.Prior;
      end
    end else
    begin
      ErrorPhone:=ErrorPhone+vtLoadcellnum.AsString+' ';
      vtLoad.Prior;
    end;
  vtLoad.EnableControls;
  vtLoad.Close;
  if ErrorPhone<>'' then
    Application.MessageBox(PChar('Загрузка завершена! Не загружены: '+ErrorPhone), 'Уведомление', MB_OK);
  qMain.Close;
  qMain.Open;
end;

procedure TRefDiscountsForm.cbFilterClick(Sender: TObject);
begin
  inherited;
  if cbFilter.Checked then
    CRDBGrid1.OptionsEx:=CRDBGrid1.OptionsEx+[dgeFilterBar]
  else
    CRDBGrid1.OptionsEx:=CRDBGrid1.OptionsEx-[dgeFilterBar];
end;

procedure TRefDiscountsForm.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if CheckBox1.Checked then
    qMain.ParamByName('PDATE').AsDate:=Date
  else
    qMain.ParamByName('PDATE').Clear;
  aRefresh.Execute;
end;

procedure TRefDiscountsForm.CRDBGrid1GetCellParams(Sender: TObject;
  Field: TField; AFont: TFont; var Background: TColor; State: TGridDrawState;
  StateEx: TGridDrawStateEx);
begin
  inherited;
  if qMainIS_DISCOUNT_OPERATOR.AsInteger=0 then
    AFont.Color:=clBlack
  else
    if qMainIS_DISCOUNT_OPERATOR.AsInteger=1 then
      if (IncMonth(qMainDISCOUNT_BEGIN_DATE.AsDateTime, qMainDISCOUNT_VALIDITY.AsInteger) >= Date+7)
        and (qMainDISCOUNT_BEGIN_DATE.AsDateTime <= Date)
      then AFont.Color:=clGreen
      else AFont.Color:=clRed;
end;

procedure TRefDiscountsForm.FormCreate(Sender: TObject);
begin
  inherited;
  qMain.ParamByName('PDATE').Clear;
  if MainForm.FUseFilialBlockAccess then
    qMain.SQL.Insert(6, 'AND GET_FILIAL_ID_BY_PHONE(PHONE_NUMBER) = ' + IntToStr(MainForm.FFilial));
end;

end.
