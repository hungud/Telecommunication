unit SelectContract_;
// #2875
//  очнев ≈. 25.05.2015
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, sComboBoxes,
  sEdit, sGroupBox, Vcl.ExtCtrls, sPanel, sRadioButton, Vcl.ActnList,
  Vcl.Buttons, sBitBtn, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Menus,
  OraCall, Data.DB, DBAccess, Ora, MemDS, ContractsRegistration_Utils;

type
  TSelectContractForm_1 = class(TForm)
    sPanel1: TsPanel;
    eSearch: TsEdit;
    cbSearchType: TsComboBoxEx;
    sGroupBox1: TsGroupBox;
    rbFastSelect: TsRadioButton;
    rbFullSelect: TsRadioButton;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    g1: TCRDBGrid;
    sGroupBox2: TsGroupBox;
    RBCloseContr: TsRadioButton;
    ActionList1: TActionList;
    aRefresh: TAction;
    aSelect: TAction;
    aClose: TAction;
    RBAllContr: TsRadioButton;
    ImageList24: TImageList;
    ImageList16: TImageList;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    PopupMenu1: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N6: TMenuItem;
    spGetFilialByPhone: TOraStoredProc;
    spSelectContract: TOraStoredProc;
    tSearch: TTimer;
    qRightAccountAllow: TOraQuery;
    qUserCheckAllow: TOraQuery;
    DataSource1: TDataSource;
    qMain: TOraQuery;
    qMainCONTRACT_NUM: TFloatField;
    qMainCONTRACT_DATE: TDateTimeField;
    qMainOPERATOR_NAME: TStringField;
    qMainPHONE_NUMBER_FEDERAL: TStringField;
    qMainCONTRACT_CANCEL_DATE: TDateTimeField;
    qMainFIO: TStringField;
    qMainCONTRACT_ID: TFloatField;
    qMainHAND_BLOCK: TFloatField;
    qMainSURNAME: TStringField;
    qMainNAME: TStringField;
    qMainPATRONYMIC: TStringField;
    RBOpenContr: TsRadioButton;
    procedure aRefreshExecute(Sender: TObject);
    procedure aSelectExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure rbFastSelectClick(Sender: TObject);
    procedure rbFullSelectClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    function CheckRightAccountAllow(PhoneNumber:string):boolean;
    //проверка доступности пользовател€ к лиц. счету в зависимости от номера тел.
    //доступ устанавливаетс€ указанием доступных BAN
    function CheckBANByPhoneNumber(pPhone: String): boolean;
    function UserCheckAllow:boolean;
    procedure qMainBeforeOpen(DataSet: TDataSet);
    procedure qMainHAND_BLOCKGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure OnGetPhoneText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure g1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cbSearchTypeChange(Sender: TObject);
    procedure eSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RBAllContrClick(Sender: TObject);
    procedure RBOpenContrClick(Sender: TObject);
    procedure RBCloseContrClick(Sender: TObject);
    procedure qMainAfterScroll(DataSet: TDataSet);
    procedure g1CellClick(Column: TColumn);

  private
    { Private declarations }
     fInitForm : Boolean;
    FFilial: integer;
    cur_id : integer;

  public
   myOraSession: TOraSession;
    FContractId: integer;
    FPhoneNumber: string;
    FUseFilialBlockAccess : Boolean;
   constructor Create(AOwner : TComponent; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer); overload;

  end;

procedure SelectPhoneNumber_ (var rezPfone: string; var rezContractID : Integer; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer);


  //проверка дат
  function MainCheckDates(begin_date,end_date:TDate): boolean;

implementation

{$R *.dfm}


//проверка дат
function MainCheckDates(begin_date,end_date:TDate): boolean;
begin
  Result := false;
  if begin_date > end_date then begin
    MessageDlg('Ќачальна€ дата не может быть больше конечной даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then begin
    MessageDlg('Ќачальна€ дата не может быть больше текущей даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  Result := true;
end;

procedure SelectPhoneNumber_ (var rezPfone: string; var rezContractID : Integer; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer) ;
var SelectContractFrm_1 : TSelectContractForm_1;
begin
  SelectContractFrm_1 := TSelectContractForm_1.Create(Application, UseFilialBlockAccess, oss, Filial);

  try
    if (mrOk = SelectContractFrm_1.ShowModal) then
    begin
       rezContractID :=SelectContractFrm_1.FContractId;
       rezPfone := SelectContractFrm_1.FPhoneNumber;
    end;
  finally
    SelectContractFrm_1.Free;
  end;
end;

constructor TSelectContractForm_1.Create(AOwner : TComponent;  UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer);
begin
  inherited Create(AOwner);     ;
  FUseFilialBlockAccess := UseFilialBlockAccess;
  myOraSession := oss;
  FFilial := Filial;

  spGetFilialByPhone.Session := myOraSession;
  spSelectContract.Session  := myOraSession;
  qRightAccountAllow.Session  := myOraSession;
  qUserCheckAllow.Session  := myOraSession;
  qMain.Session := myOraSession;
end;

//проверка доступности пользовател€ к лиц. счету в зависимости от номера тел.
//доступ устанавливаетс€ указанием доступных BAN
function TSelectContractForm_1.CheckBANByPhoneNumber(pPhone: String): boolean;
var qS: TOraQuery;
begin
  Result := true;
  if (GetConstantValue('SHOW_USER_NAME_ACCOUNTS')='1') then
  begin
    qS := TOraQuery.Create(nil);
    try
      //провер€ем имеетс€ ли ограничение дл€ пользовател€ по лиц. счетам
      qS.SQL.Text:= 'SELECT COUNT(ac.ACCOUNT_ID) AccCount FROM USER_NAME_ACCOUNTS ac ' +
      ' LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID ' +
      ' WHERE us.USER_NAME = UPPER(:pUSER_NAME)';
      qS.ParamByName('pUSER_NAME').AsString := myOraSession.Username;
      qS.Open;

      //если ограничени€ имеютс€
      if qS.FieldByName('AccCount').AsInteger <> 0 then
      begin
        qS.Close;
        qS.SQL.Text:= 'SELECT DISTINCT(PHONE_NUMBER) PHONE_NUMBE FROM DB_LOADER_ACCOUNT_PHONES ' +
        ' WHERE PHONE_NUMBER = :pPHONE_NUMBER AND ACCOUNT_ID IN ' +
        ' (SELECT ac.ACCOUNT_ID FROM USER_NAME_ACCOUNTS ac ' +
        ' LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID ' +
        ' WHERE us.USER_NAME = UPPER(:pUSER_NAME))';
        qS.ParamByName('pUSER_NAME').AsString := myOraSession.Username;
        qS.ParamByName('pPHONE_NUMBER').AsString := pPhone;
        qS.Open;
        Result := (not qS.IsEmpty);
      end;
    finally
      FreeAndNil(qS);
    end;
  end;
end;

function TSelectContractForm_1.UserCheckAllow:boolean;
begin
  result:=false;
  if not qUserCheckAllow.active then
  begin
    qUserCheckAllow.ParamByName('USER_NAME').AsString := myOraSession.Username;
    qUserCheckAllow.open;
  end;
  if (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 1) or
     (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 2) then
    result:=true
end;

function TSelectContractForm_1.CheckRightAccountAllow(PhoneNumber:string):boolean;
begin
  qRightAccountAllow.Close;
  qRightAccountAllow.ParamByName('USER_NAME').AsString := myOraSession.Username;
  qRightAccountAllow.ParamByName('PHONE_NUMBER').AsString := PhoneNumber;
  qRightAccountAllow.open;
  if qRightAccountAllow.FieldByName('cnt').AsInteger > 0 then
    result:=false
  else
    result:=true;
end;


procedure TSelectContractForm_1.g1CellClick(Column: TColumn);
begin
  cur_id := qMain.FieldByName('CONTRACT_ID').AsInteger;
end;

procedure TSelectContractForm_1.g1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  g : TCRDBGrid;
  f : TFont;
begin
  g := (Sender as TCRDBGrid);
  f := g.Canvas.Font;

  if not qMain.FieldByName('CONTRACT_CANCEL_DATE').IsNull then
  begin
    if (gdSelected in State) then
    begin  // Ќомер телефона белым, остальные - серым
      if (Column.FieldName = 'PHONE_NUMBER_FEDERAL') then
        f.Color := clWhite
      else
        f.Color := clSilver;
    end else
      f.Color := clGray;
  end;

   if (Column.Index = 7) then  // FieldName = 'HAND_BLOCK'
   begin
     if (g.DataSource.DataSet.FieldByName('HAND_BLOCK').AsInteger = 1) then
       ImageList16.Draw(g.Canvas,Rect.CenterPoint.X, Rect.Top, 11)
     else
       ImageList16.Draw(g.Canvas,Rect.CenterPoint.X, Rect.Top, 12);

   end else begin
     g.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;

end;

procedure TSelectContractForm_1.eSearchChange(Sender: TObject);
var ContractId: integer;
    PhoneBlockAccessFilial : boolean;
begin
if not fInitForm  then exit;

  PhoneBlockAccessFilial:=false;
  if (FUseFilialBlockAccess) and (Length(eSearch.Text)=10) then
  begin
    PhoneBlockAccessFilial:=true;
    spGetFilialByPhone.ParamByName('PPHONE_NUMBER').AsString:=eSearch.Text;
    spGetFilialByPhone.ExecSQL;
    if spGetFilialByPhone.ParamByName('RESULT').AsInteger= FFilial then
      PhoneBlockAccessFilial:=false;
  end;
  if not(PhoneBlockAccessFilial) then
  begin
    if rbFastSelect.Checked then
      if Length(eSearch.Text)=10 then
      begin
      aSelect.Enabled := TRUE;
        spSelectContract.ParamByName('PPHONE_NUMBER').AsString:=eSearch.Text;
        spSelectContract.ExecSQL;
        ContractId:=spSelectContract.ParamByName('RESULT').AsInteger;
        if ContractId>0 then
        begin
          FContractId:=ContractId;
          FPhoneNumber:=eSearch.Text;
          aSelect.Execute;
        end
        else
          if ContractId=0 then
          begin
            FContractId:=0;
            FPhoneNumber:=eSearch.Text;
            aSelect.Execute;
          end;
      end;
    if rbFullSelect.Checked then
      if aSelect.Enabled then
        tSearch.Enabled := True;
  end;

end;

procedure TSelectContractForm_1.eSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (aSelect.Enabled and (Key = VK_RETURN)) then
    aSelect.Execute
  else
    if ((Key = VK_ESCAPE) and aClose.Enabled) then
      aClose.Execute
    else
      if Key = VK_DOWN then
      begin
        if qMain.Active then
          qMain.Next;
      end else
        if Key = VK_UP then
        begin
          if qMain.Active then
            qMain.Prior;
        end;
end;

procedure TSelectContractForm_1.aCloseExecute(Sender: TObject);
begin
       ModalResult := mrCancel;
end;

procedure TSelectContractForm_1.aRefreshExecute(Sender: TObject);
begin
   if not qMain.Active then
    qMain.Open
  else
    qMain.Refresh;

end;

procedure TSelectContractForm_1.aSelectExecute(Sender: TObject);
 var
 phone_number:string;
begin
  if rbFastSelect.Checked then
    Phone_Number:=FPhoneNumber
  else
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    Phone_Number:=qMain.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
    FPhoneNumber := Phone_Number;
    FContractId := qMain.FieldByName('CONTRACT_ID').AsInteger;
  end;
  //проверка доступности BAN
  if not CheckBANByPhoneNumber(Phone_Number) then //если доступа нет
    exit;

  //ѕроверка на доступ к л/с телефона
  if UserCheckAllow then begin
    if CheckRightAccountAllow(Phone_Number) then
    begin
      MessageDlg('Ќет доступа к л/с данного телефона.', mtError, [mbOK], 0);
      exit;
    end;
  end;
  Modalresult := mrOk;
end;

procedure TSelectContractForm_1.FormCreate(Sender: TObject);
begin
  rbFastSelectClick(Sender);
  eSearch.text := '';
  fInitForm := true;

end;

procedure TSelectContractForm_1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute
  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (aSelect.Enabled) then
    aSelect.Execute;
end;

procedure TSelectContractForm_1.OnGetPhoneText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatPhoneNumber(Sender.AsString);
end;

procedure TSelectContractForm_1.qMainAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('PHONE_NUMBER_FEDERAL').OnGetText := OnGetPhoneText;
end;

procedure TSelectContractForm_1.qMainAfterScroll(DataSet: TDataSet);
begin
//  cur_id :=  qMain.FieldByName('CONTRACT_ID').AsInteger;
end;

procedure TSelectContractForm_1.qMainBeforeOpen(DataSet: TDataSet);
begin
  if UserCheckAllow then
  begin
    qMain.SQL.Text:='SELECT C.CONTRACT_NUM,'+#13#10+
                    '    C.CONTRACT_DATE,'+#13#10+
                    '    O.OPERATOR_NAME,'+#13#10+
                    '    AP.PHONE_NUMBER_FEDERAL,'+#13#10+
                    '     CC.CONTRACT_CANCEL_DATE,'+#13#10+
                    '     A.SURNAME ||'' ''|| A.NAME || '' '' || A.PATRONYMIC AS FIO,'+#13#10+
                    '     C.CONTRACT_ID,'+#13#10+
                    '     C.HAND_BLOCK,'+#13#10+
                    '     A.SURNAME,'+#13#10+
                    '     A.NAME,'+#13#10+
                    '     A.PATRONYMIC'+#13#10+
                    ' FROM CONTRACTS C,'+#13#10+
                    '    CONTRACT_CANCELS CC,'+#13#10+
                    '    ABONENTS A,'+#13#10+
                    '    OPERATORS O,'+#13#10+
                    '    (SELECT PHONE_NUMBER PHONE_NUMBER_FEDERAL'+#13#10+
                    '       FROM DB_LOADER_ACCOUNT_PHONES p, rights_type_account_allow r, user_names u'+#13#10+
                    '       WHERE r.rights_type = u.rights_type AND r.account_id = p.account_id AND UPPER(u.user_name) = UPPER(:user_name)'+#13#10+
                    '       GROUP BY PHONE_NUMBER) AP'+#13#10+
                    ' WHERE AP.PHONE_NUMBER_FEDERAL=C.PHONE_NUMBER_FEDERAL(+)'+#13#10+
                    '  AND C.CONTRACT_ID=CC.CONTRACT_ID(+)'+#13#10+
                    '  AND C.ABONENT_ID=A.ABONENT_ID(+)'+#13#10+
                    '  AND C.OPERATOR_ID=O.OPERATOR_ID(+)'+#13#10+
                    ' ORDER BY AP.PHONE_NUMBER_FEDERAL ASC, C.CONTRACT_DATE DESC';
      qMain.ParamByName('USER_NAME').AsString := myOraSession.Username;
  end;

end;

procedure TSelectContractForm_1.qMainHAND_BLOCKGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
 Text:= '';
end;

procedure TSelectContractForm_1.RBAllContrClick(Sender: TObject);
begin
  qMain.Filter := '';
  qMain.Filtered := false;
  if not qMain.Locate('CONTRACT_ID',cur_id,[]) then
    qMain.first;
end;

procedure TSelectContractForm_1.RBCloseContrClick(Sender: TObject);
begin
  qMain.Filter := 'CONTRACT_CANCEL_DATE IS NOT NULL';
  qMain.Filtered := True;
  if not qMain.Locate('CONTRACT_ID',cur_id,[]) then
    qMain.first;
end;

procedure TSelectContractForm_1.rbFastSelectClick(Sender: TObject);
begin
   sPanel2.Visible := false;
   height := 88;
   if fInitForm  then
     top := top + 150;
   refresh;
   cbSearchType.Enabled := false;
    if qMain.Active then
      qMain.close;

end;

procedure TSelectContractForm_1.rbFullSelectClick(Sender: TObject);
begin
   sPanel2.Visible := true;
   height := 387;
   top := top - 150;
   refresh;
   cbSearchType.Enabled := true;
   aRefresh.Execute;
   if not qMain.IsEmpty then
     aSelect.Enabled := TRUE;


end;

procedure TSelectContractForm_1.RBOpenContrClick(Sender: TObject);
begin
  qMain.Filter := 'CONTRACT_CANCEL_DATE IS NULL';
  qMain.Filtered := True;
  if not qMain.Locate('CONTRACT_ID',cur_id,[]) then
    qMain.first;
end;

procedure TSelectContractForm_1.cbSearchTypeChange(Sender: TObject);
begin
 if not fInitForm  then exit;
  if cbSearchType.ItemIndex = 0 then
  begin // по ‘»ќ абонента
    qMain.IndexFieldNames := 'SURNAME, NAME, PATRONYMIC';
  end else
    if cbSearchType.ItemIndex = 1 then
    begin // по є договора
      qMain.IndexFieldNames := 'CONTRACT_NUM';
    end else
      if cbSearchType.ItemIndex = 2 then
      begin // по є телефона
        qMain.IndexFieldNames := 'PHONE_NUMBER_FEDERAL';
  end;

  eSearch.Text := '';
  if eSearch.CanFocus() then
    eSearch.SetFocus();

end;

end.

