unit ExcelUnit;

interface
uses DBGridEhGrouping, GridsEh, DBGridEh, DB, ComObj, Forms;

procedure SaveToExcelByGrid(grMain:TDBGridEh; DS:TDataSet);
procedure SaveToExcelByDataSet(DS:TDataSet);

implementation

procedure SaveToExcelByGrid(grMain:TDBGridEh; DS:TDataSet);
var
  Ap: Variant;
  i,j: integer;
  fields: array of String;
begin
  Ap := CreateOleObject('Excel.Application');
  Ap.Workbooks.add;
  Ap.Visible := false;
  DS.DisableControls;
  try
    SetLength(fields, 0);
    Ap.WorkBooks[1].WorkSheets[1].Rows[1].Font.Bold := true;
    for i:= 0 to grMain.Columns.Count-1 do
      if grMain.Columns[i].Visible then
      begin
        SetLength(fields, Length(fields)+1);
        fields[High(fields)] := grMain.Columns[i].FieldName;
        Ap.Workbooks[1].Sheets[1].Cells[1, Length(fields)].Value := grMain.Columns[i].Title.Caption;
        j:=round (grMain.Columns[i].Width/6);
        if j>25 then j:=25;
        Ap.Workbooks[1].Sheets[1].Columns[Length(fields)].ColumnWidth:=j;
      end;
    DS.First;
    while not DS.Eof do
    begin
      for i:= 0 to High(fields) do
        Ap.Workbooks[1].Sheets[1].Cells[DS.RecNo+1, i+1].Value := DS.FieldByName(fields[i]).AsVariant;
      DS.Next;
      Application.ProcessMessages;
    end;
    Ap.Visible := true;
  finally
    DS.EnableControls;
    SetLength(fields, 0);
  end;
end;

procedure SaveToExcelByDataSet(DS:TDataSet);
var
  Ap: Variant;
  i: integer;
  fields: array of String;
begin
  Ap := CreateOleObject('Excel.Application');
  Ap.Workbooks.add;
  Ap.Visible := false;
  DS.DisableControls;
  try
    SetLength(fields, 0);
    Ap.WorkBooks[1].WorkSheets[1].Rows[1].Font.Bold := true;
    for i:= 0 to DS.Fields.Count-1 do
      begin
        SetLength(fields, Length(fields)+1);
        fields[High(fields)] := DS.Fields[i].FieldName;
        Ap.Workbooks[1].Sheets[1].Cells[1, Length(fields)].Value := fields[i];
        Ap.Workbooks[1].Sheets[1].Columns[Length(fields)].ColumnWidth:=15;
      end;
    DS.First;
    while not DS.Eof do
    begin
      for i:= 0 to High(fields) do
        Ap.Workbooks[1].Sheets[1].Cells[DS.RecNo+1, i+1].Value := DS.FieldByName(fields[i]).AsVariant;
      DS.Next;
      Application.ProcessMessages;
    end;
    Ap.Visible := true;
  finally
    DS.EnableControls;
    SetLength(fields, 0);
  end;
end;

end.
