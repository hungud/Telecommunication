unit RefDiscounts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, VirtualTable, Ora,
  MemDS, DBAccess, Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, sToolBar, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  Vcl.ExtCtrls, VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Render, FlexCel.Pdf,
  IOUtils, TimedMsgBox, sPanel, DMUnit, ExportGridToExcelPDF;



type
  TRefDiscountsForm = class(TRefForm)
    CheckBox1: TCheckBox;
    btn2: TToolButton;
    btnFromExcel: TToolButton;
    aFromExcel: TAction;
    btn3: TToolButton;
    vtLoad: TVirtualTable;
    vtLoadCellNum: TStringField;
    vtLoadDateBegin: TDateTimeField;
    vtLoadDateEnd: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure aFromExcelExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefDiscountsForm: TRefDiscountsForm;

implementation

//uses uMain;
{$R *.dfm}

procedure TRefDiscountsForm.aFromExcelExecute(Sender: TObject);
var
  Curs: TCursor;
  Xls: TExcelFile;
  row, Length, RowCount : integer;
  DefaultExt, Filter, ErrorPhone : string;
begin
  inherited;
  Filter := Dm.dlgOpen.Filter;
  DefaultExt := Dm.dlgOpen.DefaultExt;
  Dm.dlgOpen.Filter := 'Excel 2007/ newer|*.xlsx|Excel 5-2003|*.xls';
  Dm.dlgOpen.DefaultExt := 'xlsx';
  if Dm.dlgOpen.Execute then
  begin
    Curs := Screen.Cursor;
    Screen.Cursor := crSQLWait;
    vtLoad.Clear;
    vtLoad.Open;
    try
      Xls := TXlsFile.Create(false);
      xls.IgnoreFormulaText := true;
      Xls.Open(Dm.dlgOpen.FileName);
      RowCount := xls.RowCount;
      for row := 1 to RowCount do
      begin
        vtLoad.Append;
        FullFieldFromExcel(xls, Row, 1, TField(vtLoadcellnum));
        FullFieldFromExcel(xls, Row, 2, TField(vtLoadDateBegin));
        FullFieldFromExcel(xls, Row, 3, TField(vtLoadDateEnd));
        vtLoad.Post;
      end;
    finally
      Screen.Cursor := Curs;
      FreeAndNil(Xls);
    end;
    GlQuery.ReadOnly := False;
    vtLoad.Last;
    ErrorPhone := '';
    row := 0;
    while not vtLoad.Bof do
    if vtLoadDateEnd.AsDateTime >= Date then
    begin
      if vtLoadDateEnd.AsDateTime >= vtLoadDateBegin.AsDateTime then
      begin
        GlQuery.Insert;
        GlQuery.FieldByName('PHONE_NUMBER').AsString := vtLoadcellnum.AsString;
        GlQuery.FieldByName('IS_DISCOUNT_OPERATOR').AsInteger := 1;
        Length := 0;
        while abs(IncMonth(vtLoadDateEnd.AsDateTime, - Length) - vtLoadDateBegin.AsDateTime)>
              abs(abs(IncMonth(vtLoadDateEnd.AsDateTime, -Length -1) -vtLoadDateBegin.AsDateTime))
        do Inc(Length);

        GlQuery.FieldByName('DISCOUNT_VALIDITY').AsInteger := Length;
        GlQuery.FieldByName('DISCOUNT_BEGIN_DATE').AsDateTime := IncMonth(vtLoadDateEnd.AsDateTime,-Length);
        try
          GlQuery.Post;
          vtLoad.Prior;
          row := row +1;
        except
          GlQuery.Cancel;
          ErrorPhone := ErrorPhone + vtLoadcellnum.AsString + ' :- такой номер уже загружен! ' + #10#13;
          vtLoad.Prior;
        end;
      end
      else
      begin
        ErrorPhone := ErrorPhone + vtLoadcellnum.AsString +  ' :- дата окончани€ скидки - ' + vtLoadDateEnd.AsString + ' меньше даты начала скидки - ' + vtLoadDateBegin.AsString + '! ' + #10#13;
        vtLoad.Prior;
      end
    end
    else
    begin
      ErrorPhone := ErrorPhone + vtLoadcellnum.AsString + ' :- дата окончани€ скидки - ' + vtLoadDateEnd.AsString + ' устарела! ' + #10#13;
      vtLoad.Prior;
    end;
    vtLoad.Close;
    if ErrorPhone <> '' then
      TimedMessageBox('«агрузка завершена! Ќе загружены следующие номера: '  + #10#13 + ErrorPhone, 'ѕожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 35, 3);
    GlQuery.ReadOnly := True;
    if row > 0 then
    begin
      GlQuery.Close;
      GlQuery.Open;
    end;
  end;
  Dm.dlgOpen.Filter := Filter;
  Dm.dlgOpen.DefaultExt := DefaultExt;

end;

procedure TRefDiscountsForm.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if CheckBox1.Checked then
    GlQuery.ParamByName('PDATE').AsDate := Date
  else
    GlQuery.ParamByName('PDATE').Clear;
  aRefresh.Execute;

end;

procedure TRefDiscountsForm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qDiscounts;
  GlQuery.ParamByName('PDATE').Clear;
  if dm.FUseFilialBlockAccess then
    GlQuery.SQL.Add(' AND GET_FILIAL_ID_BY_PHONE(PHONE_NUMBER) = ' +
      IntToStr(dm.FFilial));

  inherited;

end;

end.
