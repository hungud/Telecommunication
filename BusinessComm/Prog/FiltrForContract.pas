unit FiltrForContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.StdCtrls, sGroupBox,
  uDM, Func_Const, TimedMsgBox,  System.StrUtils, System.DateUtils, cxDateUtils,
  sListBox, sCheckListBox, sLabel, sCheckBox, Data.DB, MemDS, DBAccess, Ora,
  Vcl.ComCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sTooledit;

type
  TFiltrForContractFrm = class(TChildForm)
    sGroupBox1: TsGroupBox;
    cbTarifs: TsCheckBox;
    cbStatus: TsCheckBox;
    cbProject: TsCheckBox;
    cbRegion: TsCheckBox;
    qPhones: TOraQuery;
    qPhonesREGION: TStringField;
    clbTariffs: TsCheckListBox;
    clbStatus: TsCheckListBox;
    cblProject: TsCheckListBox;
    clbRegion: TsCheckListBox;
    ScrollBox1: TScrollBox;
    slTariffs: TsLabel;
    slStatus: TsLabel;
    slProject: TsLabel;
    slRegion: TsLabel;
    cbDate: TsCheckBox;
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    sLabel1: TsLabel;
    cbDateBefore: TsCheckBox;
    cbDateAfter: TsCheckBox;
    sDateEdit_Before: TsDateEdit;
    sDateEdit_After: TsDateEdit;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    slDate: TsLabel;
    sRadioGroup1: TsRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cbTarifsClick(Sender: TObject);
    procedure cbStatusClick(Sender: TObject);
    procedure cbProjectClick(Sender: TObject);
    procedure cbRegionClick(Sender: TObject);
    procedure CheckListBoxClick(Sender: TObject);
    procedure clbTariffsClickCheck(Sender: TObject);
    procedure clbStatusClickCheck(Sender: TObject);
    procedure cblProjectClickCheck(Sender: TObject);
    procedure clbRegionClickCheck(Sender: TObject);
    procedure sBsaveClick(Sender: TObject);
    procedure SetCheckListBoxClick(Sender: TsCheckListBox; id : String; tp : Integer);
    procedure SetFiltr(aValue: Boolean);
    procedure cbDateClick(Sender: TObject);
    procedure cbDateBeforeClick(Sender: TObject);
    procedure cbDateAfterClick(Sender: TObject);
    procedure SetDateFiltr;
    procedure sDateEdit_BeforeChange(Sender: TObject);
    procedure sDateEdit_AfterChange(Sender: TObject);
    procedure sRadioGroup1Click(Sender: TObject);

  private
   Load_all, fnew_filtr : Boolean;

    { Private declarations }
  public
   id_Region, id_Project, id_Tariffs, id_Status, SaleDate, SaleDate1, SaleDate2,
   SaleDateChk, SaleDateChk1, SaleDateChk2, dateItemIndex : string;
   id_Region_count, id_Project_count, id_Tariffs_count, id_Status_count : Integer;

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean); reintroduce; overload;
    constructor Create(AOwner: TComponent; Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string); reintroduce; overload;

  published
    property new_filtr: Boolean read fnew_filtr write SetFiltr;
  end;

var
  FiltrForContractFrm: TFiltrForContractFrm;

implementation

{$R *.dfm}

constructor TFiltrForContractFrm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TFiltrForContractFrm.Create(AOwner: TComponent; var AFormVar: TChildForm; Cpt: string; ShM: Boolean);
begin
  inherited Create(AOwner, AFormVar, Cpt, ShM);
end;

constructor TFiltrForContractFrm.Create(AOwner: TComponent; Itm: Integer; var AFormVar: TChildForm; dscr: HWND; Cpt: string);
begin
  inherited Create(AOwner, Itm, AFormVar, dscr, Cpt);
end;

procedure TFiltrForContractFrm.FormCreate(Sender: TObject);
begin
  inherited;
  if not dm.qTariffs.Active then
    dm.qTariffs.Open
  else
    dm.qTariffs.First;
  while not dm.qTariffs.EOF do
  begin
    clbTariffs.Items.AddObject(Trim(dm.qTariffs.FieldByName('TARIFF_NAME').AsString),  Pointer(dm.qTariffs.FieldByName('TARIFF_ID').AsInteger));
    dm.qTariffs.Next;
  end;

  if not Dm.qLocal_Phone_Statuses.Active then
    Dm.qLocal_Phone_Statuses.Open
  else
    Dm.qLocal_Phone_Statuses.First;
  while not dm.qLocal_Phone_Statuses.EOF do
  begin
    clbStatus.Items.AddObject(Trim(dm.qLocal_Phone_Statuses.FieldByName('STATUS_NAME').AsString),  Pointer(dm.qLocal_Phone_Statuses.FieldByName('LOCAL_PHONE_STATUSE_ID').AsInteger));
    dm.qLocal_Phone_Statuses.Next;
  end;

  if not Dm.qProjects.Active then
    Dm.qProjects.Open
  else
    Dm.qProjects.First;
  while not dm.qProjects.EOF do
  begin
    cblProject.Items.AddObject(Trim(dm.qProjects.FieldByName('PROJECT_NAME').AsString),  Pointer(dm.qProjects.FieldByName('PROJECT_ID').AsInteger));
    dm.qProjects.Next;
  end;

  if not qPhones.Active then
    qPhones.Open
  else
    qPhones.First;
  while not qPhones.EOF do
  begin
    clbRegion.Items.Add(Trim(qPhones.FieldByName('REGION').AsString));
    qPhones.Next;
  end;
  clbTariffs.OnClick := CheckListBoxClick;
  clbStatus.OnClick := CheckListBoxClick;
  cblProject.OnClick := CheckListBoxClick;
  clbRegion.OnClick := CheckListBoxClick;
  sDateEdit_Before.Date := Date;
  sDateEdit_After.Date := Date;

end;

procedure TFiltrForContractFrm.SetFiltr(aValue: Boolean);
var
  id_str, st : string;
  id : Integer;
begin
  fnew_filtr := aValue;
  if fnew_filtr then
  begin
    id_Tariffs_count := 0;
    id_Tariffs := '';
    id_Status_count := 0;
    id_Status := '';
    id_Project_count := 0;
    id_Project := '';
    id_Region_count := 0;
    id_Region := '';

    SaleDateChk := '0';
    SaleDateChk1 := '0';
    SaleDateChk2 := '0';
    SaleDate := '';
    SaleDate1 := '';
    SaleDate2 := '';
    Load_all := True;
  end
  else
  begin


    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs_count', st);
    id_Tariffs_count := StrToIntDef(st, 0);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs', id_Tariffs);

    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status_count', st);
    id_Status_count := StrToIntDef(st, 0);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status', id_Status);

    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project_count', st);
    id_Project_count := StrToIntDef(st, 0);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project', id_Project);

    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region_count', st);
    id_Region_count := StrToIntDef(st, 0);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region', id_Region);

    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk', SaleDateChk);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk1', SaleDateChk1);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk2', SaleDateChk2);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate', SaleDate);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate1', SaleDate1);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate2', SaleDate2);
    ReadIniAny(Dm.FileNameIni, 'FiltrForContract', 'dateItemIndex', dateItemIndex);
    if dateItemIndex = '' then dateItemIndex := '0';


    if id_Tariffs_count > 0  then
    begin
      st := id_Tariffs;
      cbTarifs.Checked := id_Tariffs_count > 0;
      while st <> '' do
      begin
        id := PosEx(',', st);
        if id > 0 then
        begin
          id_str := copy(st, 1, id - 1);
          SetCheckListBoxClick(clbTariffs, id_str, 0);
          st := copy(st, id+1, Length(st));
        end
        else
        begin
          SetCheckListBoxClick(clbTariffs, st, 0);
          st := '';
        end;
      end;
      slTariffs.Caption := 'Тарифы: выбрано - ' + IntToStr(id_Tariffs_count);
    end;

    if id_Status_count > 0  then
    begin
      st := id_Status;
      cbStatus.Checked := id_Status_count > 0;
      while st <> '' do
      begin
        id := PosEx(',', st);
        if id > 0 then
        begin
          id_str := copy(st, 1, id - 1);
          SetCheckListBoxClick(clbStatus, id_str, 0);
          st := copy(st, id+1, Length(st));
        end
        else
        begin
          SetCheckListBoxClick(clbStatus, st, 0);
          st := '';
        end;
      end;
      slStatus.Caption := 'Статусы: выбрано - ' + IntToStr(id_Status_count);
    end;

    if id_Project_count > 0  then
    begin
      st := id_Project;
      cbProject.Checked := id_Project_count > 0;
      while st <> '' do
      begin
        id := PosEx(',', st);
        if id > 0 then
        begin
          id_str := copy(st, 1, id - 1);
          SetCheckListBoxClick(cblProject, id_str, 0);
          st := copy(st, id+1, Length(st));
        end
        else
        begin
          SetCheckListBoxClick(cblProject, st, 0);
          st := '';
        end;
      end;
      slProject.Caption := 'Проекты: выбрано - ' + IntToStr(id_Project_count);
    end;

    if id_Region_count > 0  then
    begin
      st := id_Region;
      cbRegion.Checked := id_Region_count > 0;
      while st <> '' do
      begin
        id := PosEx(',', st);
        if id > 0 then
        begin
          id_str := copy(st, 1, id - 2);
          SetCheckListBoxClick(clbRegion, id_str, 1);
          st := copy(st, id+2, Length(st));
        end
        else
        begin
          SetCheckListBoxClick(clbRegion, st, 1);
          st := '';
        end;
      end;
      slRegion.Caption := 'Тип нумерации: выбрано - ' + IntToStr(id_Region_count);
    end;

    if SaleDateChk = '1'  then
    begin
      cbDate.Checked := True;
      sRadioGroup1.Enabled := True;
      if dateItemIndex = '2' then
      begin

        cbDateBefore.Checked := SaleDateChk1 = '1';
        cbDateAfter.Checked := SaleDateChk2 = '1';
        if SaleDate1 <> '' then
          sDateEdit_Before.Date := StrToDateFmt('dd.mm.yyyy',SaleDate1);
        if SaleDate2 <> '' then
          sDateEdit_After.Date := StrToDateFmt('dd.mm.yyyy',SaleDate2);
        sRadioGroup1.ItemIndex := 2;
      end;
      if dateItemIndex = '1' then
       sRadioGroup1.ItemIndex := 1;
      if dateItemIndex = '0' then
       sRadioGroup1.ItemIndex := 0;
       Load_all := True;
       SetDateFiltr;
    end
    else
     Load_all := True;
  end;
end;

procedure TFiltrForContractFrm.sRadioGroup1Click(Sender: TObject);
begin
  inherited;
  if (sRadioGroup1.ItemIndex = 2) then
  begin
    cbDateBefore.Enabled := true;
    sDateEdit_Before.Enabled := cbDateBefore.Checked;
    cbDateAfter.Enabled := true;
    sDateEdit_After.Enabled := cbDateAfter.Checked;
  end
  else
  begin
    cbDateBefore.Enabled := False;
    sDateEdit_Before.Enabled := False;
    cbDateAfter.Enabled := False;
    sDateEdit_After.Enabled := False;
  end;

  if Load_all then
    SetDateFiltr;
end;

procedure TFiltrForContractFrm.SetCheckListBoxClick(Sender: TsCheckListBox; id : String; tp : Integer);
var
i, r : Integer;
st : string;
begin
  for i := 0 to Sender.Items.Count - 1 do
  begin
    if tp = 0 then
    begin
      r := Integer(Sender.Items.Objects[i]);
      if (IntToStr(r) = id) then
      begin
        Sender.Checked[i] := True;
        Exit;
      end;
    end;
    if tp > 0 then
    begin
      st := Sender.Items[i];
      if (st = id) then
      begin
        Sender.Checked[i] := True;
        Exit;
      end;
    end;
  end;
end;

procedure TFiltrForContractFrm.CheckListBoxClick(Sender: TObject);
var
i : Integer;
begin
  for i := 0 to (Sender as TsCheckListBox).Items.Count - 1 do
  begin
    if (Sender as TsCheckListBox).Selected[i] then
    begin
      (Sender as TsCheckListBox).Hint := '|'+(Sender as TsCheckListBox).Items[i];
      Exit;
    end;
  end;
end;

procedure TFiltrForContractFrm.clbRegionClickCheck(Sender: TObject);
var
  i: Integer;
begin
  id_Region := '';
  id_Region_count := 0;
  for i := 0 to clbRegion.Items.Count - 1 do
  begin
    if clbRegion.checked[i] then
    begin
      Inc(id_Region_count);
      id_Region := id_Region +  QuotedStr(clbRegion.Items[i]) + ',';
    end;
  end;
  id_Region := copy(id_Region, 1, Length(id_Region) - 1);
  slRegion.Caption := 'Тип нумерации: выбрано - ' + IntToStr(id_Region_count);

end;

procedure TFiltrForContractFrm.cbRegionClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  clbRegion.Enabled := cbRegion.Checked;
  if not cbRegion.Checked then
  begin
    for i := 0 to clbRegion.Items.Count - 1 do
      clbRegion.checked[i] := false;
    id_Region := '';
    id_Region_count := 0;
    slRegion.Caption := 'Тип нумерации: выбрано - 0';
  end;
end;

procedure TFiltrForContractFrm.clbStatusClickCheck(Sender: TObject);
var
  i: Integer;
begin
  id_Status := '';
  id_Status_count := 0;
  for i := 0 to clbStatus.Items.Count - 1 do
  begin
    if clbStatus.checked[i] then
    begin
      Inc(id_Status_count);
      id_Status := id_Status + IntToStr(Integer(clbStatus.Items.Objects[i])) + ',';
    end;
  end;
  id_Status := copy(id_Status, 1, Length(id_Status) - 1);
  slStatus.Caption := 'Статусы: выбрано - ' + IntToStr(id_Status_count);
end;

procedure TFiltrForContractFrm.clbTariffsClickCheck(Sender: TObject);
var
  i: Integer;
begin
  id_Tariffs := '';
  id_Tariffs_count := 0;
  for i := 0 to clbTariffs.Items.Count - 1 do
  begin
    if clbTariffs.checked[i] then
    begin
      Inc(id_Tariffs_count);
      id_Tariffs := id_Tariffs + IntToStr(Integer(clbTariffs.Items.Objects[i])) + ',';
    end;
  end;
  id_Tariffs := copy(id_Tariffs, 1, Length(id_Tariffs) - 1);
  slTariffs.Caption := 'Тарифы: выбрано - ' + IntToStr(id_Tariffs_count);
end;

procedure TFiltrForContractFrm.cbTarifsClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  clbTariffs.Enabled := cbTarifs.Checked;
  if not cbTarifs.Checked then
  begin
    for i := 0 to clbTariffs.Items.Count - 1 do
      clbTariffs.checked[i] := false;
    id_Tariffs := '';
    id_Tariffs_count := 0;
    slTariffs.Caption := 'Тарифы: выбрано - 0';
  end;
end;

procedure TFiltrForContractFrm.cbDateAfterClick(Sender: TObject);
begin
  inherited;
  sDateEdit_After.Enabled := cbDateAfter.Checked;
  if Load_all then
    SetDateFiltr;
end;

procedure TFiltrForContractFrm.cbDateBeforeClick(Sender: TObject);
begin
  inherited;
  sDateEdit_Before.Enabled := cbDateBefore.Checked;
  if Load_all then
    SetDateFiltr;
end;

procedure TFiltrForContractFrm.SetDateFiltr;
begin
  SaleDate1 := DateToStr(sDateEdit_Before.Date);
  SaleDate2 := DateToStr(sDateEdit_After.Date);

  if cbDate.Checked then
  begin
    if (sRadioGroup1.ItemIndex = 2) then
    begin
      if cbDateBefore.Checked and cbDateAfter.Checked then
      begin
      sDateEdit_Before.Enabled := true;
      sLabel1.Enabled := True;
      sDateEdit_After.Enabled := True;
      sLabel3.Enabled := True;
      if (sDateEdit_Before.Date = sDateEdit_After.date) then
      begin
        slDate.Caption := 'Дата продажи равна ' + DateToStr(sDateEdit_Before.Date);
        SaleDate := ' SALE_DATE = to_date(' + QuotedStr(DateToStr(sDateEdit_Before.Date)) + ', ' + QuotedStr('dd.mm.yyyy') + ')';
      end
      else
      begin
        slDate.Caption := 'Дата продажи в диапазоне от ' + DateToStr(sDateEdit_Before.Date) + ' до ' + DateToStr(sDateEdit_After.Date);
        SaleDate := ' SALE_DATE between to_date(' + QuotedStr(DateToStr(sDateEdit_Before.Date)) + ', ' + QuotedStr('dd.mm.yyyy') + ') ' +
                    ' and to_date(' + QuotedStr(DateToStr(sDateEdit_After.Date)) + ', ' + QuotedStr('dd.mm.yyyy') + ') ';
      end;
      SaleDateChk1 := '1';
      SaleDateChk2 := '1';
      SaleDateChk := '1';

      end;

      if not cbDateBefore.Checked and cbDateAfter.Checked then
      begin
      sDateEdit_Before.Enabled := False;
      sLabel1.Enabled := False;
      sDateEdit_After.Enabled := True;
      sLabel3.Enabled := True;
      slDate.Caption := 'Дата продажи меньше или равна '  + DateToStr(sDateEdit_After.Date);
      SaleDate := ' SALE_DATE <= to_date(' + QuotedStr(DateToStr(sDateEdit_After.Date)) + ', ' + QuotedStr('dd.mm.yyyy') + ') ';
      SaleDateChk := '1';
      SaleDateChk1 := '0';
      SaleDateChk2 := '1';
      end;

      if cbDateBefore.Checked and not cbDateAfter.Checked then
      begin
      sDateEdit_After.Enabled := False;
      sLabel3.Enabled := False;
      sDateEdit_Before.Enabled := true;
      sLabel1.Enabled := True;
      slDate.Caption := 'Дата продажи больше или равна '  + DateToStr(sDateEdit_Before.Date);
      SaleDate := ' SALE_DATE >= to_date(' + QuotedStr(DateToStr(sDateEdit_Before.Date)) + ', ' + QuotedStr('dd.mm.yyyy')+ ') ';
      SaleDateChk := '1';
      SaleDateChk1 := '1';
      SaleDateChk2 := '0';
      end;

      if not cbDateBefore.Checked and not cbDateAfter.Checked then
      begin
      SaleDate := '';
      slDate.Caption := 'Дата продажи не учитывается';
      sDateEdit_Before.Enabled := False;
      sLabel1.Enabled := False;
      sDateEdit_After.Enabled := False;
      sLabel3.Enabled := False;
      SaleDateChk1 := '0';
      SaleDateChk2 := '0';
      SaleDateChk := '0';
      end;
      dateItemIndex := '2';
    end else begin
      if (sRadioGroup1.ItemIndex = 0) then
      begin
        SaleDate := 'SALE_DATE is null';
        SaleDateChk := '1';
        slDate.Caption := 'Дата продажи пустая';
        dateItemIndex := '0';
      end;
      if (sRadioGroup1.ItemIndex = 1) then
      begin
        SaleDate := 'SALE_DATE is not null';
        SaleDateChk := '1';
        slDate.Caption := 'Дата продажи не пустая';
        dateItemIndex := '1';
      end;
    end;
  end
  else
  begin
    SaleDate := '';
    SaleDateChk := '0';
    slDate.Caption := 'Дата продажи не учитывается';
  end;

end;

procedure TFiltrForContractFrm.cbDateClick(Sender: TObject);
begin
  inherited;
 //

   sRadioGroup1.Enabled := cbDate.Checked;
   sRadioGroup1.OnClick(sender);
  {
  if cbDate.Checked then
  begin
    cbDateBefore.Enabled := true;
    sDateEdit_Before.Enabled := cbDateBefore.Checked;
    cbDateAfter.Enabled := true;
    sDateEdit_After.Enabled := cbDateAfter.Checked;
  end
  else
  begin
    cbDateBefore.Enabled := False;
    sDateEdit_Before.Enabled := False;
    cbDateAfter.Enabled := False;
    sDateEdit_After.Enabled := False;
  end;
  if Load_all then
    SetDateFiltr;
   }
end;


procedure TFiltrForContractFrm.cblProjectClickCheck(Sender: TObject);
var
  i: Integer;
begin
  id_Project := '';
  id_Project_count := 0;
  for i := 0 to cblProject.Items.Count - 1 do
  begin
    if cblProject.checked[i] then
    begin
      Inc(id_Project_count);
      id_Project := id_Project + IntToStr(Integer(cblProject.Items.Objects[i])) + ',';
    end;
  end;
  id_Project := copy(id_Project, 1, Length(id_Project) - 1);
  slProject.Caption := 'Проекты: выбрано - ' + IntToStr(id_Project_count);
end;

procedure TFiltrForContractFrm.cbProjectClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  cblProject.Enabled := cbProject.Checked;
  if not cbProject.Checked then
  begin
    for i := 0 to cblProject.Items.Count - 1 do
      cblProject.checked[i] := false;
    id_Project := '';
    id_Project_count := 0;
    slProject.Caption := 'Проекты: выбрано - 0';
  end;
end;


procedure TFiltrForContractFrm.cbStatusClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  clbStatus.Enabled := cbStatus.Checked;
  if not cbStatus.Checked then
  begin
    for i := 0 to clbStatus.Items.Count - 1 do
      clbStatus.checked[i] := false;
    id_Status := '';
    id_Status_count := 0;
    slStatus.Caption := 'Статусы: выбрано - 0';
  end;
end;

procedure TFiltrForContractFrm.sBsaveClick(Sender: TObject);
begin
  inherited;
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs_count', IntToStr(id_Tariffs_count));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Tariffs', id_Tariffs);

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status_count', IntToStr(id_Status_count));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Status', id_Status);

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project_count', IntToStr(id_Project_count));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Project', id_Project);

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region_count', IntToStr(id_Region_count));
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'id_Region', id_Region);

  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk', SaleDateChk);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk1', SaleDateChk1);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDateChk2', SaleDateChk2);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate', SaleDate);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate1', SaleDate1);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'SaleDate2', SaleDate2);
  WriteIniAny(Dm.FileNameIni, 'FiltrForContract', 'dateItemIndex', dateItemIndex);
end;

procedure TFiltrForContractFrm.sDateEdit_AfterChange(Sender: TObject);
begin
  inherited;
  if Load_all then
    SetDateFiltr;
end;

procedure TFiltrForContractFrm.sDateEdit_BeforeChange(Sender: TObject);
begin
  inherited;
  if Load_all then
    SetDateFiltr;
end;

end.
