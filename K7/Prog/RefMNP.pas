unit RefMNP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls,
  TimedMsgBox, DMUnit, ShowUserStat, ExportGridToExcelPDF, Func_Const,
  Vcl.ToolWin, sToolBar, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sPanel;

type
  TMNP_NUMBERS = class(TRefForm)
    TabSheet2: TTabSheet;
    sToolBar1: TsToolBar;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    CRDBGrid1: TCRDBGrid;
    qReport: TOraQuery;
    qReportPHONE_NUMBER: TStringField;
    qReportTEMP_PHONE_NUMBER: TStringField;
    qReportDATE_ACTIVATE: TDateTimeField;
    qReportUSER_CREATED: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportDATE_INSERTED: TDateTimeField;
    qReportIS_ACTIVE: TFloatField;
    qReportCLR: TFloatField;
    qReportUSER_CREATED_FIO: TStringField;
    qReportDATE_CREATED_: TDateTimeField;
    ToolButton1: TToolButton;
    aRefresh1: TAction;
    aFind1: TAction;
    aFiltr1: TAction;
    aNext1: TAction;
    aPrev1: TAction;
    aFirst1: TAction;
    aLast1: TAction;
    aMoveNext1: TAction;
    aMovePrev1: TAction;
    aToExcel1: TAction;
    dsqReport: TOraDataSource;
    RadioGroup1: TRadioGroup;
    ToolButton2: TToolButton;
    aShowInfo: TAction;
    pm2: TPopupMenu;
    MenuItem1: TMenuItem;
    ToolButton7: TToolButton;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    aSort: TAction;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    sBitBtn1: TsBitBtn;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    qReportSB: TStringField;
    CheckBox1: TCheckBox;
    ToolButton6: TToolButton;
    DateTimePicker1: TDateTimePicker;
    RadioGroup2: TRadioGroup;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure aRefresh1Execute(Sender: TObject);
    procedure aShowInfoExecute(Sender: TObject);
    procedure CRDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aFind1Execute(Sender: TObject);
    procedure aFiltr1Execute(Sender: TObject);
    procedure aNext1Execute(Sender: TObject);
    procedure aPrev1Execute(Sender: TObject);
    procedure aFirstExecute(Sender: TObject);
    procedure aLastExecute(Sender: TObject);
    procedure aMoveNext1Execute(Sender: TObject);
    procedure aMovePrev1Execute(Sender: TObject);
    procedure aToExcel1Execute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FullColumn_Array1(DataSet: TDataSet);
    procedure CRDBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aSortExecute(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);

  private
    { Private declarations }
  public
    aColumn_Array1: TColumn_Array;
    { Public declarations }
  end;

var
  MNP_NUMBERS: TMNP_NUMBERS;

implementation

{$R *.dfm}

procedure TMNP_NUMBERS.aFiltr1Execute(Sender: TObject);
begin
  inherited;
  if aFiltr1.checked then
    CRDBGrid1.OptionsEx := CRDBGrid1.OptionsEx + [dgeFilterBar]
  else
    CRDBGrid1.OptionsEx := CRDBGrid1.OptionsEx - [dgeFilterBar];
end;

procedure TMNP_NUMBERS.aFind1Execute(Sender: TObject);
begin
  inherited;
  if aFind1.checked then
    CRDBGrid1.OptionsEx := CRDBGrid1.OptionsEx + [dgeSearchBar]
  else
    CRDBGrid1.OptionsEx := CRDBGrid1.OptionsEx - [dgeSearchBar];
end;

procedure TMNP_NUMBERS.aFirstExecute(Sender: TObject);
begin
  inherited;
  qReport.First;
end;

procedure TMNP_NUMBERS.aLastExecute(Sender: TObject);
begin
  inherited;
  qReport.Last;
end;

procedure TMNP_NUMBERS.aMoveNext1Execute(Sender: TObject);
begin
  inherited;
  qReport.MoveBy(100);

end;

procedure TMNP_NUMBERS.aMovePrev1Execute(Sender: TObject);
begin
  inherited;
  qReport.MoveBy(-100);
end;

procedure TMNP_NUMBERS.aNext1Execute(Sender: TObject);
begin
  inherited;
  qReport.Next;
end;

procedure TMNP_NUMBERS.aPrev1Execute(Sender: TObject);
begin
  inherited;
  qReport.Prior;
end;

procedure TMNP_NUMBERS.aRefresh1Execute(Sender: TObject);
var
 key : string;
begin
  inherited;
  key := qReport.FieldByName('PHONE_NUMBER').AsString;
  qReport.Close;
  qReport.Open;
  qReport.Locate('PHONE_NUMBER',key,[]);
end;

procedure TMNP_NUMBERS.aShowInfoExecute(Sender: TObject);
var
  vPhoneNumber : String;
  vContractID : Integer;
begin
  inherited;
  vContractID := 0;
  if (RadioGroup1.ItemIndex = 0) then
    vPhoneNumber := qReport.FieldByName('TEMP_PHONE_NUMBER').AsString
  else
   vPhoneNumber := qReport.FieldByName('PHONE_NUMBER').AsString;
  ShowUserStatByPhoneNumber(vPhoneNumber,vContractID);
end;

procedure TMNP_NUMBERS.aSortExecute(Sender: TObject);
var
 key : string;
begin
  inherited;
  key := qReport.FieldByName('PHONE_NUMBER').AsString;
   qReport.SQL.Clear;
   qReport.SQL.Add('select');
   qReport.SQL.Add('phone_number,');
   qReport.SQL.Add('temp_phone_number,');
   qReport.SQL.Add('date_activate,');
   qReport.SQL.Add('user_created,');
   qReport.SQL.Add('date_created,');
   qReport.SQL.Add('Date_Inserted,');
   qReport.SQL.Add('is_active,');
   qReport.SQL.Add('clr,');
   qReport.SQL.Add('CASE WHEN clr = 0 THEN ''1 событие; получение МНП номера''');
   qReport.SQL.Add('WHEN clr = 1 THEN ''2 событие; определена активность''');
   qReport.SQL.Add('ELSE ''3 событие; номер перешел в историю'' END sb,');
   qReport.SQL.Add('USER_CREATED_FIO,');
   qReport.SQL.Add('DATE_CREATED_');
   qReport.SQL.Add('from V_ACTIVE_MNP_REMOVE');

  case ComboBox1.ItemIndex of
    1 : begin
          qReport.SQL.Add('order by clr');
          if ComboBox2.Text = 'сортировать по основному номеру' then
            qReport.SQL.Add(', phone_number')
          else
            qReport.SQL.Add(', temp_phone_number');
          end;
    2 : begin
          qReport.SQL.Add('order by temp_phone_number');
          if ComboBox2.Text = 'сортировать по событию' then
            qReport.SQL.Add(', clr')
          else
            qReport.SQL.Add(', temp_phone_number');
        end;
    3 : begin
          qReport.SQL.Add('order by phone_number');
          if ComboBox2.Text = 'сортировать по событию' then
            qReport.SQL.Add(', clr')
          else
            qReport.SQL.Add(', phone_number');
        end;
  end;

  qReport.Close;
  qReport.Open;
  qReport.Locate('PHONE_NUMBER',key,[]);
end;

procedure TMNP_NUMBERS.aToExcel1Execute(Sender: TObject);
begin
  inherited;
  ExportOraQuery2(TabSheet2.Caption, '', TabSheet2.Caption, qReport, aColumn_Array1, true, True, AddExcelColNumber);
end;

procedure TMNP_NUMBERS.CheckBox1Click(Sender: TObject);
begin
  inherited;
  Panel1.Visible := CheckBox1.Checked;
end;

procedure TMNP_NUMBERS.CheckBox2Click(Sender: TObject);
var
  FilterSQL : string;
begin
  inherited;
  qReport.Close;
  if CheckBox2.Checked then
  begin
    if (RadioGroup2.ItemIndex = 0) then
      FilterSQL := 'trunc(DATE_ACTIVATE) = to_date(' + #39  + DateToStr(DateTimePicker1.Date) + #39 + ',' + #39 +'dd.mm.yyyy' + #39 +')'
    else
      FilterSQL := 'trunc(date_created) = to_date(' + QuotedStr(DateToStr(DateTimePicker1.Date)) + ',' + QuotedStr('dd.mm.yyyy') +')';
    qReport.FilterSQL := FilterSQL;
  end else begin
   qReport.FilterSQL := '';
  end;
  FilterSQL := qReport.SQL.Text;
  qReport.Open;
end;

procedure TMNP_NUMBERS.ComboBox1Change(Sender: TObject);
begin
  inherited;
  case ComboBox1.ItemIndex of
    0 : begin
          ComboBox2.Items.Clear;
          ComboBox2.Items.Add('не сортировать');
          ComboBox2.Text := 'не сортировать';
          ComboBox2.Enabled := False;
        end;
    1 : begin
          ComboBox2.Items.Clear;
          ComboBox2.Items.Add('не сортировать');
          ComboBox2.Items.Add('сортировать по основному номеру');
          ComboBox2.Items.Add('сортировать по временному номеру');
          ComboBox2.Text := 'не сортировать';
          ComboBox2.Enabled := True;
        end;
    2 : begin
          ComboBox2.Items.Clear;
          ComboBox2.Items.Add('не сортировать');
          ComboBox2.Items.Add('сортировать по событию');
          ComboBox2.Items.Add('сортировать по временному номеру');
          ComboBox2.Text := 'не сортировать';
          ComboBox2.Enabled := True;
        end;
    3 : begin
          ComboBox2.Items.Clear;
          ComboBox2.Items.Add('не сортировать');
          ComboBox2.Items.Add('сортировать по событию');
          ComboBox2.Items.Add('сортировать по основному номеру');
          ComboBox2.Text := 'не сортировать';
          ComboBox2.Enabled := True;
        end;
  end;

end;

procedure TMNP_NUMBERS.CRDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
 if (qReport.FieldByName('clr').asinteger = 0) then
   begin
     CRDBGrid1.Canvas.Brush.Color := clWhite; //clYellow;
     CRDBGrid1.Canvas.Font.Color := clBlue;
   end;
 if (qReport.FieldByName('clr').asinteger = 1) then
   begin
     CRDBGrid1.Canvas.Brush.Color := clWhite; //clYellow;
     CRDBGrid1.Canvas.Font.Color := clRed;
   end;
   CRDBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TMNP_NUMBERS.CRDBGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
//
end;

procedure TMNP_NUMBERS.DateTimePicker1Change(Sender: TObject);
begin
  inherited;
   CheckBox2Click(Sender);
end;

procedure TMNP_NUMBERS.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qmnp_remove;
  inherited;
  qReport.Open;
  SetLength(aColumn_Array1, 0);
  FullColumn_Array1(qReport);
  PageControl1.ActivePage :=  TabSheet1;
  DateTimePicker1.Date := Date;
end;

procedure TMNP_NUMBERS.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i := Low(aColumn_Array1) to High(aColumn_Array1) do
  begin
    aColumn_Array1[i].LookupDataset := nil;
    aColumn_Array1[i].LookupDataSource := nil;
    aColumn_Array1[i].Cmpnt1 := nil;
    aColumn_Array1[i].Cmpnt2 := nil;
    aColumn_Array1[i].Cmpnt3 := nil;
  end;
  SetLength(aColumn_Array1, 0);

end;

procedure TMNP_NUMBERS.FullColumn_Array1(DataSet: TDataSet);
var
  i, r, q: Integer;
begin
  SetLength(aColumn_Array1, 0);
  for q := 0 to DataSet.FieldCount - 1 do
  begin
    if DataSet.Fields[q].Visible then
    begin
      r := Length(aColumn_Array1);
      SetLength(aColumn_Array1, r + 1); // Length(aColumn_Array) + 1);
      aColumn_Array1[r].FieldName := DataSet.Fields[q].FieldName;
      aColumn_Array1[r].FieldKind := DataSet.Fields[q].FieldKind;
      aColumn_Array1[r].DisplayLabel := DataSet.Fields[q].DisplayLabel;
      aColumn_Array1[r].ReadOnly := DataSet.Fields[q].ReadOnly;
      aColumn_Array1[r].Required := DataSet.Fields[q].Required;
      aColumn_Array1[r].Size := DataSet.Fields[q].Size;
      DataSet.Fields[q].Tag := r;
      aColumn_Array1[r].IsBlob := DataSet.Fields[q].IsBlob;
      aColumn_Array1[r].DisplayWidth := DataSet.Fields[q].DisplayWidth;
      aColumn_Array1[r].Tag := DataSet.Fields[q].Tag;
      if (DataSet.Fields[q].FieldKind = fkLookup) then
      begin
        aColumn_Array1[r].KeyFields := DataSet.Fields[q].KeyFields;
        aColumn_Array1[r].LookupDataset := DataSet.Fields[q].LookupDataset;
        if not DataSet.Fields[q].LookupDataset.Active then
          DataSet.Fields[q].LookupDataset.Open;
        for i := 0 to Dm.ComponentCount - 1 do
        begin
          if (Dm.Components[i].ClassName = 'TOraDataSource') or (Dm.Components[i].ClassName = 'TDataSource') then
          begin
            if ((Dm.Components[i] as TDataSource).DataSet = aColumn_Array[r].LookupDataset) then
              aColumn_Array1[r].LookupDataSource := (Dm.Components[i] as TDataSource);
          end;
        end;
        aColumn_Array1[r].LookupKeyFields := DataSet.Fields[q].LookupKeyFields;
        aColumn_Array1[r].LookupResultField := DataSet.Fields[q].LookupResultField;
      end;
      aColumn_Array1[r].DataType := DataSet.Fields[q].DataType;
      if (aColumn_Array1[r].DataType = ftBoolean) then
        DataSet.Fields[q].OnGetText := GetTextBoolean;
    end;
  end;
end;

procedure TMNP_NUMBERS.RadioGroup2Click(Sender: TObject);
begin
  inherited;
  CheckBox2Click(Sender);
end;

end.
