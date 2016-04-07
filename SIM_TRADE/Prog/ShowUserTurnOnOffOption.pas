unit ShowUserTurnOnOffOption;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, CRGrid, MemDS, VirtualTable, DBAccess, Ora, Vcl.StdCtrls,
  Vcl.Buttons, Main, Vcl.ExtCtrls;

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
    procedure cbAdminClick(Sender: TObject);
    procedure lbSpisokClick(Sender: TObject);
    procedure ReHeightForm(Count: integer);
    procedure btTurnClick(Sender: TObject);
    procedure cbExpDateClick(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
  private
    { Private declarations }
  public
    PhoneNumber, OptionCode, TypeTurn: String;
    Count: Integer;
    IsAdmin: boolean;
    DefSpisok : TStrings;
  end;

procedure TurnOnOffOption(PhoneNumber:string; TypeTurn: char; OptionCode:string);

var
  ShowUserTurnOnOffOptionForm: TShowUserTurnOnOffOptionForm;

implementation

{$R *.dfm}
procedure TurnOnOffOption(PhoneNumber:string; TypeTurn: char; OptionCode:string);
var RefForm: TShowUserTurnOnOffOptionForm;
    i:integer;
begin
  RefForm:= TShowUserTurnOnOffOptionForm.Create(nil);
  MainForm.CheckAdminPrivs(RefForm.IsAdmin);
  RefForm.OptionCode:=OptionCode;
  RefForm.TypeTurn:=TypeTurn;
  RefForm.PhoneNumber:=PhoneNumber;
  With RefForm do //
  begin
    cbAdmin.Checked:=IsAdmin;
    cbAdmin.Enabled:=IsAdmin;
    if IsAdmin then
    begin
      qOptions.ParamByName('IS_ADMIN').AsInteger:=1;
      pAdmin.Show;
    end else
    begin
      qOptions.ParamByName('IS_ADMIN').AsInteger:=0;
      pAdmin.Hide;
    end;
    qOptions.ParamByName('OPTION_CODE').AsString:=OptionCode;
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
    ReHeightForm(Count);
    spTurn.ParamByName('PPHONE_NUMBER').AsString:= PhoneNumber;
    //spTurn.ParamByName('PREQUEST_INITIATOR').AsString:= 'USER';
    if (TypeTurn <> 'A') and (TypeTurn <> 'D')
      then spTurn.ParamByName('PTURN_ON').AsInteger:= -1
      else if TypeTurn = 'A' then
           begin
             spTurn.ParamByName('PTURN_ON').AsInteger:= 1;
             Caption:='Подключение услуг по номеру ' + PhoneNumber;
             Label3.Caption:='Дата подключения:';
             dtpEffDate.DateTime:=Date;
             dtpExpDate.DateTime:=Date + 23/24;
             btTurn.Caption:='Подключить';
           end else
           begin
             spTurn.ParamByName('PTURN_ON').AsInteger:= 0;
             Caption:='Отключение услуг по номеру ' + PhoneNumber;
             Label3.Caption:='Дата отключения:';
             dtpEffDate.DateTime:=Date;
             lExpDate.Hide;
             dtpExpDate.Hide;
             cbExpDate.Hide;
             btTurn.Caption:='Отключить';
             btTurn.Top:=RefForm.btTurn.Top - 27;
           end;
    DefSpisok:=TStringList.Create;
    DefSpisok.Clear;
    DefSpisok.AddStrings(lbSpisok.Items);
// :POPTION_CODE, :PEFF_DATE, :PEXP_DATE,
    try
      if not(IsAdmin) and (Count = 0)
        then ShowMessage('Доступно только администратору')
        else ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TShowUserTurnOnOffOptionForm.ReHeightForm(Count: integer);
var NewHeightSpisok, NewHeight: integer;
begin
  if IsAdmin
    then NewHeightSpisok:=38
    else NewHeightSpisok:=6;
  if Count <= 20
    then NewHeightSpisok:=NewHeightSpisok + 16*Count
    else NewHeightSpisok:=NewHeightSpisok + 16*20;
  pSpisok.Height:=NewHeightSpisok;
  NewHeight:=NewHeightSpisok + 145;
  if TypeTurn = 'D' then NewHeight:=NewHeight - 17;
  Height:=NewHeight;
end;

procedure TShowUserTurnOnOffOptionForm.btTurnClick(Sender: TObject);
var i : integer;
    pOptionCode, Question: string;
begin
  //
  Question:='Вы подтверждаете ';
  if TypeTurn = 'D'
    then Question:= Question + 'отключение '
    else Question:= Question + 'подключение ';
  if dtpEffDate.DateTime <> Date
    then spTurn.ParamByName('PEFF_DATE').AsDateTime:=dtpEffDate.DateTime
    else spTurn.ParamByName('PEFF_DATE').Clear;
  if (cbExpDate.Checked) and (dtpExpDate.DateTime > dtpEffDate.DateTime)
    then spTurn.ParamByName('PEXP_DATE').AsDateTime:=dtpExpDate.DateTime
    else spTurn.ParamByName('PEXP_DATE').Clear;
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
  if cbAdmin.Checked
    then qOptions.ParamByName('IS_ADMIN').AsInteger:=1
    else qOptions.ParamByName('IS_ADMIN').AsInteger:=0;
  qOptions.ParamByName('OPTION_CODE').AsString:=OptionCode;
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
  if lbSpisok.Count > 0
    then lbSpisok.ItemIndex:=0
    else lbSpisok.ItemIndex:=-1;
  ReHeightForm(Count);
end;

procedure TShowUserTurnOnOffOptionForm.cbExpDateClick(Sender: TObject);
begin
  lExpDate.Enabled:=cbExpDate.Checked;
  dtpExpDate.Enabled:=cbExpDate.Checked;
end;

procedure TShowUserTurnOnOffOptionForm.eSearchChange(Sender: TObject);
var i:integer;
begin
  if Length(eSearch.Text) > 2 then
  begin
    i:=0;
    lbSpisok.Items.Clear;
    for i:=0 to DefSpisok.Count - 1 do
      if Pos(eSearch.Text, DefSpisok[i]) > 0 then
        lbSpisok.Items.Append(DefSpisok[i]);
  end;
end;

procedure TShowUserTurnOnOffOptionForm.lbSpisokClick(Sender: TObject);
var ID : integer;
begin
  ID:=Integer(lbSpisok.Items.Objects[lbSpisok.ItemIndex]);
end;

end.
