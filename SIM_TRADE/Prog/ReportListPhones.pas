unit ReportListPhones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, VirtualTable, Vcl.CheckLst, Vcl.ExtCtrls,
  Vcl.Samples.Gauges, Vcl.ComCtrls, Vcl.Buttons;

type
  TfReportListPhones = class(TForm)
    btnCalculate: TButton;
    memPhoneList: TMemo;
    cbListFields: TCheckListBox;
    vtListFields: TVirtualTable;
    TopPanel: TPanel;
    lAccount: TLabel;
    Label1: TLabel;
    dsRepoprt: TOraDataSource;
    vtReport: TVirtualTable;
    grReport: TCRDBGrid;
    Panel2: TPanel;
    Gauge1: TGauge;
    btLoadInExcel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnCalculateClick(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    vsqlstr : array of string;
    vmax    : integer;
    procedure frmColReport;
  end;

var
  fReportListPhones: TfReportListPhones;

implementation

Uses Main, IntecExportGrid;

{$R *.dfm}

procedure DrawGridCheckBox(Canvas: TCanvas; Rect: TRect; Checked: boolean);
var
  DrawFlags: Integer;
begin
  Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, ' ');
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DFCS_BUTTONPUSH or DFCS_ADJUSTRECT);
  DrawFlags := DFCS_BUTTONCHECK or DFCS_ADJUSTRECT;// DFCS_BUTTONCHECK
  if Checked then
    DrawFlags := DrawFlags or DFCS_CHECKED;
  DrawFrameControl(Canvas.Handle, Rect, DFC_BUTTON, DrawFlags);
end;

procedure TfReportListPhones.frmColReport;
var vFld:string; i,l : integer; vCol:TColumn;
begin
  vtListFields.First;
    i:=0; vmax:=i;       // 0. добавим поля
    vtReport.FieldDefs.BeginUpdate;
    vtReport.FieldDefs.Update;
    vtReport.FieldDefs.Clear;
    vtReport.FieldDefs.Add( 'PHONE_NUMBER', ftString, 100, False);
    grReport.Columns.Clear;
    vCol:=grReport.Columns.Add;  // поля грид
    vCol.FieldName := 'PHONE_NUMBER';
    vCol.Title.Caption := 'Номер телефона';
    vCol.Width := 150;
    for l := 0 to cbListFields.Count-1 do
    begin
      if cbListFields.State[l]=cbChecked then
      begin
        Inc(i); vmax:=i;
        setLength(vsqlstr,i);
        if vtListFields.FieldByName('phone_report_column_id').AsInteger<>l then
        begin
          vtListFields.First;
          while not vtListFields.Eof do
          begin
            if vtListFields.FieldByName('phone_report_column_id').AsInteger=l then
              Break;
            vtListFields.Next;
          end;
        end;
        vsqlstr[i-1]:=vtListFields.FieldByName('fsql').AsString;
        vFld:='F'+inttostr(i);
        vCol:=grReport.Columns.Add;  // поля грид
        vCol.FieldName := vFld;
        vCol.Title.Caption := vtListFields.FieldByName('fname').AsString;
        vCol.Width := 100;
        // поля таблицы
        vtReport.FieldDefs.Add( vFld, ftString, 100, False);
      end;
      vtListFields.Next;
    end;
    vtReport.FieldDefs.EndUpdate;
end;

procedure TfReportListPhones.btLoadInExcelClick(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Списковый отчет','',
      grReport, nil, False, False);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TfReportListPhones.btnCalculateClick(Sender: TObject);
var vOra : TOraQuery; vFld:string;
  I, j : Integer;
begin  // Рассчитать
  Screen.Cursor := crSQLWait ;
  vtReport.DisableControls;
  try
    frmColReport;     // 0. список полей
    vtReport.Clear;   // 1. список телефонов
    vtReport.Open;
    Gauge1.MaxValue:=memPhoneList.Lines.Count*vmax;
    for I := 0 to memPhoneList.Lines.Count-1 do
      if Trim(memPhoneList.Lines[i])<>'' then
      begin
        vtReport.Insert;
        vtReport.FieldByName('PHONE_NUMBER').AsString:=Trim(memPhoneList.Lines[i]);
        for j:=1 to vmax do
        begin
          vOra:=TOraQuery.Create(nil);
          try
            vOra.Session := MainForm.OraSession ;
            vOra.SQL.Clear; vOra.Params.Clear;
            vOra.SQL.Text:=vsqlstr[j-1];
            if pos(':',vsqlstr[j-1])>0 then
              vOra.Params[0].AsString:=Trim(memPhoneList.Lines[i]);
            if not vOra.Prepared then vOra.Prepare;
            try
              vOra.Open; vOra.First; vFld:='F'+inttostr(j);
              if not vOra.Eof then
              begin
                vtReport.FieldByName(vFld).AsString := VarToStr(vOra.Fields[0].Value)
              end else
                vtReport.FieldByName(vFld).AsString := '' ;
            except
              on E:Exception do
                vtReport.FieldByName(vFld).AsString := 'ERROR' ;
            end;
          finally
            MainForm.OraSession.Commit;
            vOra.Close;
            vOra.Free;
          end;
          Gauge1.Progress:= (I*vmax)+j;
          Application.ProcessMessages;
        end;
        vtReport.Post;
      end;
  finally
    vtReport.EnableControls;
    vtReport.First;
    Gauge1.Progress:=0;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfReportListPhones.FormCreate(Sender: TObject);
var vOraQr1 : TOraQuery; vCurItem : integer;
begin
  vOraQr1 := TOraQuery.Create(nil);
  try
    vOraQr1.Session := MainForm.OraSession ;
    vOraQr1.sql.Add('select * from PHONE_REPORT_COLUMNS t order by t.order_number');
    vOraQr1.Open; vOraQr1.First; vtListFields.Open;
    cbListFields.Items.Clear;
    vCurItem:=0;
    vtListFields.Clear;
    while not vOraQr1.Eof do
    begin
      cbListFields.Items.Append(vOraQr1.FieldByName('fname').AsString);
      cbListFields.State[vCurItem]:=cbChecked;
      vtListFields.Insert;
      vtListFields.FieldByName('phone_report_column_id').AsInteger := vCurItem;
      vtListFields.FieldByName('fsql').AsString :=
        vOraQr1.FieldByName('fsql').AsString;
      vtListFields.FieldByName('fname').AsString :=
          vOraQr1.FieldByName('fname').AsString;
      vtListFields.Post;
      Inc(vCurItem);
      vOraQr1.Next;
    end;
    vOraQr1.Close;
  finally
    vOraQr1.Free;
  end;
  frmColReport;     // 0. список полей
end;

end.
