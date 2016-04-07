unit FindData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Forms, Vcl.Menus, ShellApi,
  Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.ActnList, Vcl.DBCtrls,
  Data.DB, DBAccess, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, System.StrUtils,
  sBitBtn, sPanel, sScrollBox, sLabel, sToolBar, Ora, MemDS, CRGrid,
  VirtualTable, ExportGridToExcelPDF, uDM,
  ChildFrm, Func_Const, TimedMsgBox, RefFrmEdit, ImageVarnCl, Vcl.Buttons,
  Vcl.Mask, sCheckBox, sEdit, sComboBox, sBevel, sRadioButton, sMaskEdit,
  sCustomComboEdit, sTooledit, sGroupBox, sCurrencyEdit, sCurrEdit;

type
  TFindDataForm = class(TChildForm)
    sgbPeriods: TsGroupBox;
    sdeBegin: TsDateEdit;
    srbToday: TsRadioButton;
    srbYestoDay: TsRadioButton;
    srbLastWeek: TsRadioButton;
    srbThisWeek: TsRadioButton;
    srbAl: TsRadioButton;
    srbThisMonth: TsRadioButton;
    srbLastMonth: TsRadioButton;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sdeEnd: TsDateEdit;
    sBevel4: TsBevel;
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    sPanel2: TsPanel;
    scbFilials: TsComboBox;
    seVirtAccount: TsEdit;
    schbShowAll: TsCheckBox;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sBevel3: TsBevel;
    sChBVirtAccount: TsCheckBox;
    schbPhone: TsCheckBox;
    srbCalendar: TsRadioButton;
    sePhone: TsEdit;
    procedure FormCreate(Sender: TObject);
    procedure SetDatesEnabled(const pEnabled: boolean);
    procedure GetDates(const pDate : TDateTime; const pDatesTypes : String; var pDateBegin, pDateEnd : TDateTime);
    procedure PrepareCombobox(const pCB : TsComboBox; const pDataset : TDataset);
    procedure srbTodayClick(Sender: TObject);
    procedure srbYestoDayClick(Sender: TObject);
    procedure srbThisWeekClick(Sender: TObject);
    procedure srbLastWeekClick(Sender: TObject);
    procedure srbThisMonthClick(Sender: TObject);
    procedure srbLastMonthClick(Sender: TObject);
    procedure srbCalendarClick(Sender: TObject);
    procedure srbAlClick(Sender: TObject);
    procedure sChBVirtAccountClick(Sender: TObject);
    procedure schbPhoneClick(Sender: TObject);
    procedure seVirtAccountChange(Sender: TObject);
    procedure ChecksBsaveEnabled;
    procedure sBsaveClick(Sender: TObject);
    procedure sePhoneChange(Sender: TObject);
    procedure sePhoneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
   FChanging : boolean;
   srb, deBegin, deEnd, Filials_ItemIndex, ChBVirtAccount, chbPhone, chbShowAll : string;
    { Private declarations }
  public
    addSQL : string;
    { Public declarations }
  end;

var
  FindDataForm: TFindDataForm;

implementation

{$R *.dfm}

procedure TFindDataForm.FormCreate(Sender: TObject);
begin
  inherited;
  PrepareCombobox(scbFilials, Dm.qFilials_find);
  scbFilials.Items.Insert(0, 'Все филиалы');
  scbFilials.ItemIndex := 0;
  srbTodayClick(Sender);
  sBsave.Visible := True;
  sBClose.Visible := True;

  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'DEBEGIN', deBegin);
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'DEEND', deEnd);
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'SRB', srb);
  if srb = '1' then
    srbToday.Checked := true
  else
    if srb = '2' then
      srbYestoDay.Checked := true
    else
      if srb = '3' then
        srbThisWeek.Checked := true
      else
        if srb = '4' then
          srbLastWeek.Checked := true
        else
          if srb = '5' then
            srbThisMonth.Checked := true
          else
            if srb = '6' then
              srbLastMonth.Checked := true
            else
              if srb = '7' then
                srbCalendar.Checked := true
              else
                if srb = '8' then
                  srbAl.Checked := true
                else
                  srbAl.Checked := true;

  if srbCalendar.Checked then
  begin
    sdeBegin.Text := deBegin;
    sdeEnd.Text := deEnd;
  end;
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'FILIALS_ITEMINDEX', Filials_ItemIndex);
  scbFilials.ItemIndex :=  StrToIntdef(Filials_ItemIndex,0);
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBVIRTACCOUNT', ChBVirtAccount);
  if ChBVirtAccount = '1' then
    sChBVirtAccount.Checked := true
  else
    sChBVirtAccount.Checked := False;
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'VIRTUAL_ACCOUNTS_NAME', chbPhone);
  seVirtAccount.Text := chbPhone;
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBPHONE', chbPhone);
  if chbPhone = '1' then
    schbPhone.Checked := True
  else
    schbPhone.Checked := False;
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'PHONE_ID', chbPhone);
  sePhone.Text := chbPhone;
  ReadIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBSHOWALL', chbShowAll);
  if chbShowAll = '1' then
    schbShowAll.Checked := True
  else
    schbShowAll.Checked := false;
  schbPhoneClick(sender) ;
end;

procedure TFindDataForm.SetDatesEnabled(const pEnabled: boolean);
begin
  sLabel3.Enabled := pEnabled;
  sLabel4.Enabled := pEnabled;
  sLabel5.Enabled := pEnabled;
  sdeBegin.Enabled := pEnabled;
  sdeEnd.Enabled := pEnabled;
end;

procedure TFindDataForm.seVirtAccountChange(Sender: TObject);
begin
  inherited;
  ChecksBsaveEnabled;
end;

procedure TFindDataForm.srbCalendarClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(TRUE);
    GetDates(Date(), 'TODAY', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbAlClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(FALSE);
    GetDates(Date(), 'ALL', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbLastMonthClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'LAST_MONTH', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbLastWeekClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'LAST_WEEK', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbThisMonthClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'THIS_MONTH', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbThisWeekClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'THIS_WEEK', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbTodayClick(Sender: TObject);
var
  vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'TODAY', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.srbYestoDayClick(Sender: TObject);
var vDateBegin, vDateEnd : TDateTime;
begin
  if not FChanging then
  begin
    SetDatesEnabled(false);
    GetDates(Date(), 'YESTODAY', vDateBegin, vDateEnd);
    sdeBegin.Date := vDateBegin;
    sdeEnd.Date := vDateEnd;
  end;
end;

procedure TFindDataForm.GetDates(const pDate : TDateTime; const pDatesTypes : String; var pDateBegin, pDateEnd : TDateTime);
var w : Integer;
   Year, Month, Day: Word;
begin
  if pDatesTypes = 'TODAY' then
  begin
    pDateBegin := pDate;
    pDateEnd := pDate;
  end
  else if pDatesTypes = 'YESTODAY' then
  begin
    pDateBegin := pDate - 1;
    pDateEnd := pDate - 1;
  end
  else if pDatesTypes = 'THIS_WEEK' then
  begin
    // DayOfWeek - воскресенье дает = 1, понедельник = 2
    w := DayOfWeek(pDate) - 1;
    if w = 0 then w := 7;
    //
    pDateBegin := pDate - w + 1;
    pDateEnd := pDate - w + 7;
  end
  else if pDatesTypes = 'LAST_WEEK'  then
  begin
    // DayOfWeek - воскресенье дает = 1, понедельник = 2
    w := DayOfWeek(pDate) - 1;
    if w = 0 then w := 7;
    //
    pDateBegin := pDate - w + 1 - 7;
    pDateEnd := pDate - w + 7 - 7;
  end
  else if pDatesTypes = 'THIS_MONTH' then
  begin
    DecodeDate(pDate, Year, Month, Day);
    pDateBegin := EncodeDate(Year, Month, 1);
    if Month = 12 then
      pDateEnd := EncodeDate(Year+1, 1, 1) - 1
    else
      pDateEnd := EncodeDate(Year, Month+1, 1) - 1;
  end
  else if pDatesTypes = 'LAST_MONTH' then
  begin
    DecodeDate(pDate, Year, Month, Day);
    if Month = 1 then
    begin
      Year := Year - 1;
      Month := 12;
    end
    else
      Month := Month - 1;

    pDateBegin := EncodeDate(Year, Month, 1);
    if Month = 12 then
      pDateEnd := EncodeDate(Year+1, 1, 1) - 1
    else
      pDateEnd := EncodeDate(Year, Month+1, 1) - 1;
  end
  else if pDatesTypes = 'ALL' then
  begin
    pDateBegin := EncodeDate(1900, 1, 1);
    pDateEnd := EncodeDate(3000, 1, 1);
  end
  else
    raise Exception.Create('Вид дат ' + pDatesTypes + ' не поддерживается.');
  pDateBegin := Trunc(pDateBegin);
  pDateEnd := Trunc(pDateEnd);
end;

procedure TFindDataForm.PrepareCombobox(const pCB : TsComboBox; const pDataset : TDataset);
var vInt : Integer;
begin
  if not pDataset.Active then
    pDataset.Open;

  pCB.Clear;
  pDataset.First;
  while not pDataset.Eof do
  begin
    vInt := pDataset.FieldbyName('ID').AsInteger;
    pCB.AddItem(pDataset.FieldbyName('NAME').AsString, Pointer(vInt));
    pDataset.Next;
  end;
end;

procedure TFindDataForm.sChBVirtAccountClick(Sender: TObject);
begin
  inherited;
  ChecksBsaveEnabled;
  seVirtAccount.Enabled := sChBVirtAccount.Checked;
  if sChBVirtAccount.Checked then
    schbPhone.Checked := False;

end;

procedure TFindDataForm.sePhoneChange(Sender: TObject);
begin
  ChecksBsaveEnabled;
  schbShowAll.Enabled := (schbPhone.Checked and (Length(sePhone.Text) = 10));
end;

procedure TFindDataForm.sePhoneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
           //
end;

procedure TFindDataForm.sBsaveClick(Sender: TObject);
var
 st1, st2 : string;
begin
  inherited;
  addSQL := '';
  st1 := FormatDateTime('yyyymm', sdeBegin.Date);
  st2 := FormatDateTime('yyyymm', sdeEnd.Date);
//  if sdeBegin.Date = sdeEnd.Date then
  if st1 = st2 then
    addSQL := ' and dlb.YEAR_MONTH = :YEAR_MONTH1'+#13#10
  else
    addSQL := ' and dlb.YEAR_MONTH between :YEAR_MONTH1 and :YEAR_MONTH2'+#13#10;

  if scbFilials.ItemIndex <> 0 then
    addSQL := addSQL + ' and dlb.filial_id = :FILIAL_ID'+#13#10;

  if sChBVirtAccount.Checked then
    addSQL := addSQL + ' and upper(VIRTUAL_ACCOUNTS_NAME) like upper(''%''||:VIRTUAL_ACCOUNTS_NAME||''%'')'+#13#10;
    // upper('%'||:VIRTUAL_ACCOUNTS_NAME||'%')

  if schbPhone.Checked then
  begin
    if not schbShowAll.Checked then
      addSQL := addSQL + ' and PHONE_ID = :PHONE_ID'+#13#10 //+ sePhone.Text
    else
      addSQL := addSQL + ' and upper(VIRTUAL_ACCOUNTS_NAME) = '+#13#10+
                         ' (select distinct  upper(VIRTUAL_ACCOUNTS_NAME) ' + #13#10 +
                         '    from V_BILLS where PHONE_ID = :PHONE_ID ) '+#13#10;
  end;
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'YEAR_MONTH1', st1);
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'YEAR_MONTH2', st2);
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'FILIAL_ID', IntToStr(Integer(scbFilials.Items.Objects[scbFilials.ItemIndex])));
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'VIRTUAL_ACCOUNTS_NAME', seVirtAccount.Text);
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'PHONE_ID', sePhone.Text);
  if srbToday.Checked then
    srb := '1';
  if srbYestoDay.Checked then
    srb := '2';
  if srbThisWeek.Checked then
    srb := '3';
  if srbLastWeek.Checked then
    srb := '4';
  if srbThisMonth.Checked then
    srb := '5';
  if srbLastMonth.Checked then
    srb := '6';
  if srbCalendar.Checked then
    srb := '7';
  if srbAl.Checked then
    srb := '8';
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'SRB', srb);
  deBegin := sdeBegin.Text;
  deEnd := sdeEnd.Text;
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'DEBEGIN', deBegin);
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'DEEND', deEnd);
  Filials_ItemIndex := IntToStr(scbFilials.ItemIndex);
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'FILIALS_ITEMINDEX', Filials_ItemIndex);
  if sChBVirtAccount.Checked then
    ChBVirtAccount := '1'
  else
    ChBVirtAccount := '0';
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBVIRTACCOUNT', ChBVirtAccount);
  if schbPhone.Checked then
    chbPhone := '1'
  else
    chbPhone := '0';
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBPHONE', chbPhone);
  if schbShowAll.Checked then
    chbShowAll := '1'
  else
    chbShowAll := '0';
  WriteIniAny(Dm.FileNameIni, 'FIND_DATA', 'CHBSHOWALL', chbShowAll);
end;

procedure TFindDataForm.schbPhoneClick(Sender: TObject);
begin
  inherited;
  ChecksBsaveEnabled;
  sePhone.Enabled := schbPhone.Checked;
  schbShowAll.Enabled := (schbPhone.Checked and (Length(sePhone.Text) = 10));
  if schbPhone.Checked then
    sChBVirtAccount.Checked := False;
end;

procedure TFindDataForm.ChecksBsaveEnabled;
begin
  sBsave.Enabled := False;
  if sChBVirtAccount.Checked  then
     sBsave.Enabled := (Length(seVirtAccount.Text) > 0)
  else
    sBsave.Enabled := not(sChBVirtAccount.Checked);
  //  Проверка по вирт л/с
  if schbPhone.Checked  then
     sBsave.Enabled := sBsave.Enabled and (Length(sePhone.Text) = 10)
  else
    sBsave.Enabled := sBsave.Enabled and not(schbPhone.Checked);
  //  Проверка по номерам
end;

end.
