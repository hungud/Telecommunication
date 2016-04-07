unit ShowUserTurnOnOffOption;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, CRGrid, MemDS, VirtualTable, DBAccess, Ora, Vcl.StdCtrls,
  Vcl.Buttons, Main, Vcl.ExtCtrls, DateUtils;

type
  TShowUserTurnOnOffOptionForm = class(TForm)
    qOptions: TOraQuery;
    Label3: TLabel;
    lExpDate: TLabel;
    dtpExpDate: TDateTimePicker;
    dtpEffDate: TDateTimePicker;
    spTurn: TOraStoredProc;
    btTurn: TBitBtn;
    pTurn: TPanel;
    pSpisok: TPanel;
    lbSpisok: TListBox;
    pAdmin: TPanel;
    cbAdmin: TCheckBox;
    cbExpDate: TCheckBox;
    eSearch: TEdit;
    lSearch: TLabel;
    PageControl1: TPageControl;
    tsBeeline: TTabSheet;
    tsDELAYED_ON_OFF_TARIFF_OPTIONS: TTabSheet;
    dtActionDate: TDateTimePicker;
    dtActionTime: TDateTimePicker;
    lActionDate: TLabel;
    btDealedTurn: TBitBtn;
    qCheck: TOraQuery;
    qAdd: TOraQuery;
    qUpdate: TOraQuery;
    lOffDealedOpt: TLabel;
    dtOffActionDate: TDateTimePicker;
    dtOFFActionTime: TDateTimePicker;
    cbOff: TCheckBox;
    cbRecommended: TCheckBox;
    procedure cbAdminClick(Sender: TObject);
    procedure lbSpisokClick(Sender: TObject);
    procedure ReHeightForm(Count: integer);
    procedure btTurnClick(Sender: TObject);
    procedure cbExpDateClick(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    procedure btDealedTurnClick(Sender: TObject);
    procedure cbOffClick(Sender: TObject);
  private
    { Private declarations }
  public
    PhoneNumber, OptionCode, TypeTurn: String;
    Count, Tariff_id : Integer;
    IsAdmin: boolean;
    DefSpisok : TStrings;
  end;

procedure TurnOnOffOption(PhoneNumber : string;
                          TypeTurn: char;
                          OptionCode : string;
                          Tariff_id:integer ;
                          isCollector : boolean
                         );

var
  ShowUserTurnOnOffOptionForm: TShowUserTurnOnOffOptionForm;

implementation

{$R *.dfm}
procedure TurnOnOffOption(PhoneNumber : string;
                          TypeTurn: char;
                          OptionCode : string;
                          Tariff_id:integer;
                          isCollector : boolean
                         );
var RefForm: TShowUserTurnOnOffOptionForm;
    i:integer;
begin
  RefForm:= TShowUserTurnOnOffOptionForm.Create(nil);
  MainForm.CheckAdminPrivs(RefForm.IsAdmin);
  RefForm.OptionCode := OptionCode;
  RefForm.TypeTurn := TypeTurn;
  RefForm.Tariff_id := Tariff_id;
  RefForm.PhoneNumber := PhoneNumber;
  RefForm.PageControl1.ActivePageIndex := 0;
  RefForm.dtActionDate.Date := Date;
  RefForm.dtActionTime.Time := IncSecond(Time, 60);//по умолчанию ставим время подключения на минуту больше (60 сек)
  RefForm.dtOFFActionDate.Date := RefForm.dtActionDate.Date;
  RefForm.dtOFFActionTime.Time := IncSecond(RefForm.dtActionTime.Time, 120);//по умолчанию ставим время отключения на две минуты больше (2*60 сек)
  With RefForm do //
  begin
    cbAdmin.Checked := IsAdmin;
    cbAdmin.Enabled := IsAdmin;

    if isCollector then
    begin
      dtpExpDate.Visible := False;
      lExpDate.Visible := False;
      cbExpDate.Visible := False;
      cbExpDate.Checked := False;
    end;

    if IsAdmin then
    begin
      qOptions.ParamByName('IS_ADMIN').AsInteger:=1;
      cbAdmin.Visible := True;
      //pAdmin.Show;
    end
    else
    begin
      qOptions.ParamByName('IS_ADMIN').AsInteger:=0;
      cbAdmin.Visible := True;
      //pAdmin.Hide;
    end;
    qOptions.ParamByName('OPTION_CODE').AsString := OptionCode;
    qOptions.ParamByName('SHOW_ALL').AsInteger := 1;
    qOptions.Open;
    Count:=0;
    lbSpisok.Items.Clear;
    while not qOptions.EOF do
    begin
      Inc(Count);
      lbSpisok.Items.AddObject(
        qOptions.FieldByName('OPTION_NAME').AsString + ' - ('
          + qOptions.FieldByName('OPTION_CODE').AsString + ')',
        TObject(qOptions.FieldByName('TARIFF_OPTION_ID').AsInteger)
        );
      qOptions.Next;
    end;
    qOptions.Close;
    lbSpisok.ItemIndex:=0;
    //ReHeightForm(Count);
    spTurn.ParamByName('PPHONE_NUMBER').AsString:= PhoneNumber;
    //spTurn.ParamByName('PREQUEST_INITIATOR').AsString:= 'USER';
    if (TypeTurn <> 'A') and (TypeTurn <> 'D')then
      spTurn.ParamByName('PTURN_ON').AsInteger:= -1
    else if TypeTurn = 'A' then
    begin
      spTurn.ParamByName('PTURN_ON').AsInteger:= 1;
      Caption:='Подключение услуг по номеру ' + PhoneNumber;
      Label3.Caption:='Дата подключения:';
      dtpEffDate.DateTime:=Date;
      dtpExpDate.DateTime:=Date + 23/24;
      btTurn.Caption:='Подключить';
      btDealedTurn.Caption  := 'Добавить в очередь на подключение';
      tsBeeline.Caption := 'Подключение через Билайн';
      tsDELAYED_ON_OFF_TARIFF_OPTIONS.Caption := 'Отложенное подключение';
      if Tariff_id > 0 then
        cbRecommended.Show;
    end
    else
    begin
      spTurn.ParamByName('PTURN_ON').AsInteger:= 0;
      Caption:='Отключение услуг по номеру ' + PhoneNumber;
      Label3.Caption:='Дата отключения:';
      Label3.Hide;
      dtpEffDate.DateTime:=Date;
      dtpEffDate.Hide;
      lExpDate.Hide;
      dtpExpDate.Hide;
      cbExpDate.Hide;
      tsBeeline.Caption := 'Отключение через Билайн';
      tsDELAYED_ON_OFF_TARIFF_OPTIONS.Caption := 'Отложенное отключение';
     // btTurn.Align := alClient;
      btTurn.Caption := 'Отключить';
      lActionDate.Visible := False;
      dtActionDate.Visible := False;
      dtActionTime.Visible := False;
      cbOff.Checked := True;
      cbOff.Visible := False;
      btDealedTurn.Caption  := 'Добавить в очередь на отключение';
    //  btTurn.Top:=RefForm.btTurn.Top - 27;
    end;
    DefSpisok:=TStringList.Create;
    DefSpisok.Clear;
    DefSpisok.AddStrings(lbSpisok.Items);
// :POPTION_CODE, :PEFF_DATE, :PEXP_DATE,
    try
      if not(IsAdmin) and (Count = 0)then
        ShowMessage('Доступно только администратору')
      else
        ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TShowUserTurnOnOffOptionForm.ReHeightForm(Count: integer);
var
  NewHeightSpisok, NewHeight: integer;
begin
  if IsAdmin then
    NewHeightSpisok := 38
  else
    NewHeightSpisok := 6;
  if Count <= 20 then
    NewHeightSpisok := NewHeightSpisok + 16*Count
  else
    NewHeightSpisok := NewHeightSpisok + 16*20;
  pSpisok.Height := NewHeightSpisok;
  NewHeight := NewHeightSpisok + 145;
  if TypeTurn = 'D' then
    NewHeight := NewHeight - 17;
  Height := NewHeight;
end;

procedure TShowUserTurnOnOffOptionForm.btDealedTurnClick(Sender: TObject);
var
  i : integer;
  OptionCode, OptionName, Question: string;
  ActionDate : TDateTime;
  ActionType : Integer;


  procedure AddAction(pActionType : Integer; pPhoneNumber : string; pOptionCode : String; pActionDate : TDateTime; pQuestion :String);
  const
    ActionTypeName : array [0..1] of string = ('отключиние ', 'подключение ');
  var
    str :string;
  begin
    qCheck.Close;
    qCheck.ParamByName('phone_number').Value := pPhoneNumber;
    qCheck.ParamByName('option_code').Value := pOptionCode;
    qCheck.ParamByName('ACTION_TYPE').Value := pActionType;
    //qCheck.ParamByName('ACTION_DATE').Value := null;
    qCheck.Open;
    if qCheck.RecordCount > 0 then
    begin
      str :=  'Заявка на '+ ActionTypeName[pActionType] +' данной опции уже существует!!!'+#13#10+
                'Заданное время выполнения: ' + qCheck.FieldByName('ACTION_DATE').AsString +#13#10+
                'Заменить время выполнения на '+ DateTimeToStr(pActionDate)+'?';


      if mrOk = MessageDlg(str, mtWarning, [mbOK, mbCancel], 0)then
      begin
        qUpdate.ParamByName('ACTION_DATE').Value := pActionDate;
        qUpdate.ParamByName('DELAYED_TURN_TO_ID').Value := qCheck.FieldByName('DELAYED_TURN_TO_ID').Value;
        qUpdate.ExecSQL;
        ShowMessage('Заявка обновлена.');
        //Close;
        exit;
      end
      else
        exit;
    end;

    if mrOk = MessageDlg(Question, mtConfirmation, [mbOK, mbCancel], 0) then
    begin
      qAdd.ParamByName('PHONE_NUMBER').Value := pPhoneNumber;
      qAdd.ParamByName('OPTION_CODE').Value := pOptionCode;
      qAdd.ParamByName('ACTION_TYPE').Value := pActionType;
      qAdd.ParamByName('ACTION_DATE').Value := pActionDate;
      qAdd.ExecSQL;
      ShowMessage('Заявка добавлена в очередь');
      //Close;
    end;
  end;
begin
  //
  Question := '';

  ActionDate := StrToDateTime(DateToStr(dtActionDate.Date) + TimeToStr(dtActionTime.Time));

  if (ActionDate < Now) AND (dtActionDate.Visible) then
    Question := 'Дата автоподключения ('+DateTimeToStr(ActionDate)+') не может быть меньше текущей даты ('+DateTimeToStr(Now)+')!'
  else
  begin
    ActionDate := StrToDateTime(DateToStr(dtOFFActionDate.Date) + TimeToStr(dtOFFActionTime.Time));
    if (ActionDate < Now) AND (cbOff.Checked) then
      Question := 'Дата автоотключения ('+DateTimeToStr(ActionDate)+') не может быть меньше текущей даты ('+DateTimeToStr(Now)+')!';
  end;

  if Question <> '' then
  begin
    MessageDlg(Question, mtWarning, [mbOK], 0);
    exit;
  end;

  Question := '';
  Question := 'Вы подтверждаете ';
  if TypeTurn = 'D' then
  begin
    Question:= Question + '"ОТКЛЮЧЕНИЕ" ';
    ActionType := 0;
  end
  else
  begin
    Question:= Question + '"ПОДКЛЮЧЕНИЕ" ';
    ActionType := 1;
  end;

  OptionCode := lbSpisok.Items[lbSpisok.ItemIndex];
  OptionName := copy(OptionCode, 1, Pos(' - (', OptionCode) - 1);
  OptionCode := copy(OptionCode, Pos(' - (', OptionCode)+4,
                      Length(OptionCode)-Pos(' - (', OptionCode)-4);

  if (dtActionDate.Visible) then
  begin
    ActionDate := StrToDateTime(DateToStr(dtActionDate.Date) + TimeToStr(dtActionTime.Time));

    Question:= Question + 'услуги ''' + OptionName + ''' с кодом ''';
    Question:= Question + OptionCode + '''?';

    AddAction(ActionType, PhoneNumber, OptionCode, ActionDate, Question);
  end;
  if cbOff.Checked then
  begin
    ActionType := 0;
    Question := 'Вы подтверждаете "ОТКЛЮЧЕНИЕ" ';

    Question:= Question + 'услуги ''' + OptionName + ''' с кодом ''';
    Question:= Question + OptionCode + '''?';

    ActionDate := StrToDateTime(DateToStr(dtOffActionDate.Date) + TimeToStr(dtOFFActionTime.Time));
    AddAction(ActionType, PhoneNumber, OptionCode, ActionDate, Question);

    Close;
  end
  else
    Close;
end;

procedure TShowUserTurnOnOffOptionForm.btTurnClick(Sender: TObject);
var i : integer;
    pOptionCode, Question: string;
begin
  //
  Question:='Вы подтверждаете ';
  if TypeTurn = 'D' then
    Question:= Question + 'отключение '
  else
    Question:= Question + 'подключение ';

  if dtpEffDate.DateTime <> Date then
    spTurn.ParamByName('PEFF_DATE').AsDateTime:=dtpEffDate.DateTime
  else
    spTurn.ParamByName('PEFF_DATE').Clear;
  if (cbExpDate.Checked) and (dtpExpDate.DateTime > dtpEffDate.DateTime) then
    spTurn.ParamByName('PEXP_DATE').AsDateTime:=dtpExpDate.DateTime
  else
    spTurn.ParamByName('PEXP_DATE').Clear;

  pOptionCode:=lbSpisok.Items[lbSpisok.ItemIndex];
  Question:= Question + 'услуги ''' + copy(pOptionCode, 1, Pos(' - (', pOptionCode) - 1)
    + ''' с кодом ''';
  pOptionCode:=copy(pOptionCode, Pos(' - (', pOptionCode)+4,
                    Length(pOptionCode)-Pos(' - (', pOptionCode)-4);
  spTurn.ParamByName('POPTION_CODE').AsString:= pOptionCode;
  Question:= Question + spTurn.ParamByName('POPTION_CODE').AsString + '''?';
  if mrOk = MessageDlg(Question, mtConfirmation, [mbOK, mbCancel], 0) then
  begin
    spTurn.ExecProc;
    ShowMessage(spTurn.ParamByName('RESULT').AsString);
    if Pos('Заявка', spTurn.ParamByName('RESULT').AsString) > 0 then
      Close;
  end;
end;

procedure TShowUserTurnOnOffOptionForm.cbAdminClick(Sender: TObject);
begin
  if cbAdmin.Checked then
    qOptions.ParamByName('IS_ADMIN').AsInteger:=1
  else
    qOptions.ParamByName('IS_ADMIN').AsInteger:=0;
  qOptions.ParamByName('OPTION_CODE').AsString:=OptionCode;

  if cbRecommended.Checked then
  begin
    qOptions.ParamByName('SHOW_ALL').AsInteger := 0;
    qOptions.ParamByName('TARIFF_ID').AsInteger := Tariff_id;
  end
  else
    qOptions.ParamByName('SHOW_ALL').AsInteger:=1;

  qOptions.Open;
  Count:=0;
  lbSpisok.Items.Clear;
  while not qOptions.EOF do
  begin
    Inc(Count);
    lbSpisok.Items.AddObject(
      qOptions.FieldByName('OPTION_NAME').AsString + ' - ('
        + qOptions.FieldByName('OPTION_CODE').AsString + ')',
      TObject(qOptions.FieldByName('TARIFF_OPTION_ID').AsInteger)
      );
    qOptions.Next;
  end;
  qOptions.Close;
  if lbSpisok.Count > 0 then
    lbSpisok.ItemIndex:=0
  else
    lbSpisok.ItemIndex:=-1;
  //ReHeightForm(Count);
end;

procedure TShowUserTurnOnOffOptionForm.cbExpDateClick(Sender: TObject);
begin
  lExpDate.Enabled:=cbExpDate.Checked;
  dtpExpDate.Enabled:=cbExpDate.Checked;
end;

procedure TShowUserTurnOnOffOptionForm.cbOffClick(Sender: TObject);
var
  enb : Boolean;
begin
  enb := cbOff.Checked;
  lOffDealedOpt.Enabled := enb;
  dtOffActionDate.Enabled := enb;
  dtOffActionTime.Enabled := enb;
end;

procedure TShowUserTurnOnOffOptionForm.eSearchChange(Sender: TObject);
var
  i:integer;
begin
  //if Length(eSearch.Text) > 2 then
  begin
    i:=0;
    lbSpisok.Items.Clear;
    if length(eSearch.Text) > 0 then
    begin
      for i:=0 to DefSpisok.Count - 1 do
        if Pos(AnsiUpperCase(eSearch.Text), AnsiUpperCase(DefSpisok[i])) > 0 then
          lbSpisok.Items.Append(DefSpisok[i]);
    end
    else
      for i:=0 to DefSpisok.Count - 1 do
        lbSpisok.Items.Append(DefSpisok[i]);
  end;
end;

procedure TShowUserTurnOnOffOptionForm.lbSpisokClick(Sender: TObject);
var
  ID : integer;
begin
  ID := Integer(lbSpisok.Items.Objects[lbSpisok.ItemIndex]);
end;

end.
