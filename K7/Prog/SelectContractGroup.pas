unit SelectContractGroup;
// #2875
// Кочнев Е. 25.05.2015
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, sComboBoxes,
  sEdit, sGroupBox, Vcl.ExtCtrls, sPanel, sRadioButton, Vcl.ActnList,
  Vcl.Buttons, sBitBtn, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.Menus,
  OraCall, Data.DB, DBAccess, Ora, MemDS, ContractsRegistration_Utils;

type
  TSelectContractForm_Group = class(TForm)
    sPanel1: TsPanel;
    eSearch: TsEdit;
    cbSearchType: TsComboBoxEx;
    sGroupBox1: TsGroupBox;
    rbFastSelect: TsRadioButton;
    rbFullSelect: TsRadioButton;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    g1: TCRDBGrid;
    ActionList1: TActionList;
    aRefresh: TAction;
    aSelect: TAction;
    aClose: TAction;
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
    spSelectGroup: TOraStoredProc;
    tSearch: TTimer;
    qRightAccountAllow: TOraQuery;
    qUserCheckAllow: TOraQuery;
    DataSource1: TDataSource;
    qMain: TOraQuery;
    qMainCONTRACT_NUM: TFloatField;
    qMainCONTRACT_DATE: TDateTimeField;
    qMainOPERATOR_NAME: TStringField;
    qMainPHONE_NUMBER_FEDERAL: TStringField;
    qMainCONTRACT_ID: TFloatField;
    qMainGROUP_NAME: TStringField;
    qMainGROUP_ID: TFloatField;
    qMainBAN: TFloatField;
    qMainSIGN_NAME: TStringField;
    procedure aRefreshExecute(Sender: TObject);
    procedure aSelectExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure rbFastSelectClick(Sender: TObject);
    procedure rbFullSelectClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    function CheckRightAccountAllow(PhoneNumber:string):boolean;
    //проверка доступности пользователя к лиц. счету в зависимости от номера тел.
    //доступ устанавливается указанием доступных BAN
    function CheckBANByPhoneNumber(pPhone: String): boolean;
    function UserCheckAllow:boolean;
    procedure qMainBeforeOpen(DataSet: TDataSet);
    procedure qMainHAND_BLOCKGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure OnGetPhoneText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure cbSearchTypeChange(Sender: TObject);
    procedure eSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qMainAfterScroll(DataSet: TDataSet);
    procedure g1CellClick(Column: TColumn);

  private
    { Private declarations }
     fInitForm : Boolean;
    FFilial: integer;
    cur_id : integer;

  public
   myOraSession: TOraSession;
    FGROUP_ID: integer;
    FGROUP_NAME: string;
    FPhoneNumber: string;
    FUseFilialBlockAccess : Boolean;
   constructor Create(AOwner : TComponent; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer); overload;

  end;

procedure SelectPhoneNumberGroup (var rezGROUP_NAME: string; var rezGROUP_ID : Integer; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer);


  //проверка дат
  function MainCheckDates(begin_date,end_date:TDate): boolean;

implementation

{$R *.dfm}


//проверка дат
function MainCheckDates(begin_date,end_date:TDate): boolean;
begin
  Result := false;
  if begin_date > end_date then begin
    MessageDlg('Начальная дата не может быть больше конечной даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  if begin_date > Now then begin
    MessageDlg('Начальная дата не может быть больше текущей даты!', mtConfirmation, [mbOK], 0);
    exit;
  end;
  Result := true;
end;

procedure SelectPhoneNumberGroup (var rezGROUP_NAME: string; var rezGROUP_ID : Integer; UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer) ;
var SelectContractFrm_1 : TSelectContractForm_Group;
begin
  SelectContractFrm_1 := TSelectContractForm_Group.Create(Application, UseFilialBlockAccess, oss, Filial);

  try
    if (mrOk = SelectContractFrm_1.ShowModal) then
    begin
       rezGROUP_ID :=SelectContractFrm_1.FGROUP_ID;
       rezGROUP_NAME := SelectContractFrm_1.FGROUP_NAME;
    end;
  finally
    SelectContractFrm_1.Free;
  end;
end;

constructor TSelectContractForm_Group.Create(AOwner : TComponent;  UseFilialBlockAccess : Boolean; oss: TOraSession; Filial: integer);
begin
  inherited Create(AOwner);     ;
  FUseFilialBlockAccess := UseFilialBlockAccess;
  myOraSession := oss;
  FFilial := Filial;

  spGetFilialByPhone.Session := myOraSession;
  spSelectGroup.Session  := myOraSession;
  qRightAccountAllow.Session  := myOraSession;
  qUserCheckAllow.Session  := myOraSession;
  qMain.Session := myOraSession;
end;

//проверка доступности пользователя к лиц. счету в зависимости от номера тел.
//доступ устанавливается указанием доступных BAN
function TSelectContractForm_Group.CheckBANByPhoneNumber(pPhone: String): boolean;
var qS: TOraQuery;
begin
  Result := true;
  if (GetConstantValue('SHOW_USER_NAME_ACCOUNTS')='1') then
  begin
    qS := TOraQuery.Create(nil);
    try
      //проверяем имеется ли ограничение для пользователя по лиц. счетам
      qS.SQL.Text:= 'SELECT COUNT(ac.ACCOUNT_ID) AccCount FROM USER_NAME_ACCOUNTS ac ' +
      ' LEFT JOIN USER_NAMES us ON us. USER_NAME_ID = ac. USER_NAME_ID ' +
      ' WHERE us.USER_NAME = UPPER(:pUSER_NAME)';
      qS.ParamByName('pUSER_NAME').AsString := myOraSession.Username;
      qS.Open;

      //если ограничения имеются
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

function TSelectContractForm_Group.UserCheckAllow:boolean;
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

function TSelectContractForm_Group.CheckRightAccountAllow(PhoneNumber:string):boolean;
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


procedure TSelectContractForm_Group.g1CellClick(Column: TColumn);
begin
  cur_id := qMain.FieldByName('CONTRACT_ID').AsInteger;
end;



procedure TSelectContractForm_Group.eSearchChange(Sender: TObject);
var ContractId: integer;
    GroupId: integer;
    GROUPNAME : string;
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
        spSelectGroup.ParamByName('PPHONE_NUMBER').AsString:=eSearch.Text;
        spSelectGroup.ExecSQL;
        ContractId:=spSelectGroup.ParamByName('RESULT').AsInteger;
        GroupId:=spSelectGroup.ParamByName('PGROUP_ID').AsInteger;
        GROUPNAME:=spSelectGroup.ParamByName('PGROUP_NAME').AsString;
        if ContractId>0 then
        begin
          FGROUP_ID:=GroupId;
          FGROUP_NAME:=GROUPNAME;
          FPhoneNumber:=eSearch.Text;
          aSelect.Execute;
        end
        else
          if ContractId=0 then
          begin
            FGROUP_ID:=0;
            FPhoneNumber:= eSearch.Text;
            FGROUP_NAME:='';
            aSelect.Execute;
          end;
      end;
    if rbFullSelect.Checked then
      begin
        if eSearch.Text<>'' then
           if cbSearchType.ItemIndex = 0 then
           begin // по наименование группы
              qMain.Locate('GROUP_NAME',eSearch.Text, [loCaseInsensitive, loPartialKey]);
           end else
             if cbSearchType.ItemIndex = 1 then
             begin // по № группы
                qMain.Locate('GROUP_ID',eSearch.Text, [loCaseInsensitive, loPartialKey]);
             end else
               if cbSearchType.ItemIndex = 2 then
               begin // по № телефона
               qMain.Locate('PHONE_NUMBER_FEDERAL',eSearch.Text, [loCaseInsensitive, loPartialKey]);
               end else
                 if cbSearchType.ItemIndex = 3 then
                 begin // по № телефона
                   qMain.Locate('BAN',eSearch.Text, [loCaseInsensitive, loPartialKey]);
               end;
        if aSelect.Enabled then
           tSearch.Enabled := True;
        end;
  end;

end;

procedure TSelectContractForm_Group.eSearchKeyDown(Sender: TObject; var Key: Word;
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

procedure TSelectContractForm_Group.aCloseExecute(Sender: TObject);
begin
       ModalResult := mrCancel;
end;

procedure TSelectContractForm_Group.aRefreshExecute(Sender: TObject);
begin
   if not qMain.Active then
    qMain.Open
  else
    qMain.Refresh;

end;

procedure TSelectContractForm_Group.aSelectExecute(Sender: TObject);
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
    FGROUP_ID := qMain.FieldByName('GROUP_ID').AsInteger;
    FGROUP_NAME := qMain.FieldByName('GROUP_NAME').AsString;
  end;

  //проверка доступности BAN
  if not CheckBANByPhoneNumber(Phone_Number) then //если доступа нет
    exit;

  //Проверка на доступ к л/с телефона
  if UserCheckAllow then begin
    if CheckRightAccountAllow(Phone_Number) then
    begin
      MessageDlg('Нет доступа к л/с данного телефона.', mtError, [mbOK], 0);
      exit;
    end;
  end;
  Modalresult := mrOk;
end;

procedure TSelectContractForm_Group.FormCreate(Sender: TObject);
begin
  rbFastSelectClick(Sender);
  eSearch.text := '';
  fInitForm := true;

end;

procedure TSelectContractForm_Group.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute
  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (aSelect.Enabled) then
    aSelect.Execute;
end;

procedure TSelectContractForm_Group.OnGetPhoneText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatPhoneNumber(Sender.AsString);
end;

procedure TSelectContractForm_Group.qMainAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('PHONE_NUMBER_FEDERAL').OnGetText := OnGetPhoneText;
end;

procedure TSelectContractForm_Group.qMainAfterScroll(DataSet: TDataSet);
begin
//  cur_id :=  qMain.FieldByName('CONTRACT_ID').AsInteger;
end;

procedure TSelectContractForm_Group.qMainBeforeOpen(DataSet: TDataSet);
begin
  if UserCheckAllow then
  begin
    qMain.SQL.Text:='SELECT C.CONTRACT_NUM,'+#13#10+
                    '    C.CONTRACT_DATE,'+#13#10+
                    '    O.OPERATOR_NAME,'+#13#10+
                    '    AP.PHONE_NUMBER_FEDERAL,'+#13#10+
                    '     C.CONTRACT_ID,'+#13#10+
                    '     CG.GROUP_ID,'+#13#10+
                    '     CG.GROUP_NAME,'+#13#10+
                    '     BI.BAN,'+#13#10+
                    '     GS.SIGN_NAME'+#13#10+
                    ' FROM CONTRACTS C,'+#13#10+
                    '    CONTRACT_GROUPS CG,'+#13#10+
                    '    OPERATORS O,'+#13#10+
                    '    GROUPS_SIGN  GS,'+#13#10+
                    '    BEELINE_LOADER_INF BI,'+#13#10+
                    '    (SELECT PHONE_NUMBER PHONE_NUMBER_FEDERAL'+#13#10+
                    '       FROM DB_LOADER_ACCOUNT_PHONES p, rights_type_account_allow r, user_names u'+#13#10+
                    '       WHERE r.rights_type = u.rights_type AND r.account_id = p.account_id AND UPPER(u.user_name) = UPPER(:user_name)'+#13#10+
                    '       GROUP BY PHONE_NUMBER) AP'+#13#10+
                    ' WHERE AP.PHONE_NUMBER_FEDERAL=C.PHONE_NUMBER_FEDERAL(+)'+#13#10+
                    '  AND C.GROUP_ID = CG.GROUP_ID'+#13#10+
                    '  AND C.OPERATOR_ID=O.OPERATOR_ID(+)'+#13#10+
                    '  AND AP.PHONE_NUMBER_FEDERAL = BI.PHONE_NUMBER(+)'+#13#10+
                    '  AND CG.SIGN_ID = GS.SIGN_ID(+)'+#13#10+
                    '  AND NOT EXISTS (SELECT 1'+#13#10+
                    '                  FROM CONTRACT_CANCELS CC'+#13#10+
                    '                  WHERE CC.CONTRACT_ID = C.CONTRACT_ID)'+#13#10+
                    ' ORDER BY AP.PHONE_NUMBER_FEDERAL ASC, C.CONTRACT_DATE DESC';
      qMain.ParamByName('USER_NAME').AsString := myOraSession.Username;
  end;

end;

procedure TSelectContractForm_Group.qMainHAND_BLOCKGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
 Text:= '';
end;

procedure TSelectContractForm_Group.rbFastSelectClick(Sender: TObject);
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

procedure TSelectContractForm_Group.rbFullSelectClick(Sender: TObject);
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

procedure TSelectContractForm_Group.cbSearchTypeChange(Sender: TObject);
begin
 if not fInitForm  then exit;
  if cbSearchType.ItemIndex = 0 then
  begin // по наименование группы
    qMain.IndexFieldNames := 'GROUP_NAME';
  end else
    if cbSearchType.ItemIndex = 1 then
    begin // по № группы
      qMain.IndexFieldNames := 'GROUP_ID';
    end else
      if cbSearchType.ItemIndex = 2 then
      begin // по № телефона
        qMain.IndexFieldNames := 'PHONE_NUMBER_FEDERAL';
      end else
        if cbSearchType.ItemIndex = 3 then
        begin // по № подбана
          qMain.IndexFieldNames := 'BAN';
      end;

  eSearch.Text := '';
  if eSearch.CanFocus() then
    eSearch.SetFocus();

end;

end.

