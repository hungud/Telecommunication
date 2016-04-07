unit SelectContract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Main, DB, MemDS, DBAccess, Ora, ExtCtrls, ActnList, Menus,
  Grids, DBGrids, CRGrid, ComCtrls, ToolWin, StdCtrls, Mask;

type
  TSelectContractForm = class(TForm)
    CRDBGrid1: TCRDBGrid;
    PopupMenu1: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N6: TMenuItem;
    ActionList1: TActionList;
    aRefresh: TAction;
    aSelect: TAction;
    aClose: TAction;
    tSearch: TTimer;
    qMain: TOraQuery;
    DataSource1: TDataSource;
    pSearch: TPanel;
    Label1: TLabel;
    eSearch: TMaskEdit;
    ToolBar2: TToolBar;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    cbSearchType: TComboBox;
    RBOpenContr: TRadioButton;
    RBCloseContr: TRadioButton;
    pType: TPanel;
    rbFastSelect: TRadioButton;
    rbFullSelect: TRadioButton;
    spSelectContract: TOraStoredProc;
    qRightAccountAllow: TOraQuery;
    qUserCheckAllow: TOraQuery;
    spGetFilialByPhone: TOraStoredProc;
    procedure aSelectExecute(Sender: TObject);
    function UserCheckAllow:boolean;
    function CheckRightAccountAllow(PhoneNumber:string):boolean;
    procedure CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aCloseExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eSearchChange(Sender: TObject);
    procedure tSearchTimer(Sender: TObject);
    procedure cbSearchTypeChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure eSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aRefreshExecute(Sender: TObject);
    procedure CRDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure RBOpenContrClick(Sender: TObject);
    procedure RBCloseContrClick(Sender: TObject);
    procedure rbFastSelectClick(Sender: TObject);
    procedure rbFullSelectClick(Sender: TObject);
    procedure PrepareSelect;
    procedure FormCreate(Sender: TObject);



  private
    procedure OnGetPhoneText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    { Private declarations }
  public
    FContractId: integer;
    FPhoneNumber: string;
  end;

  // выбрать действующий договор
  function SelectContractId : Variant;
  // выбрать номер телефона (в том числе из тех , по которым не заключены договора)
  //function SelectPhoneNumber : String;

  procedure SelectPhoneNumber (var rezPfone: string; var rezContractID : Integer);

//var
//  SelectContractForm: TSelectContractForm;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils,ShowUserStat;

procedure TSelectContractForm.aSelectExecute(Sender: TObject);
var
 phone_number:string;
begin
  if rbFastSelect.Checked then
    Phone_Number:=FPhoneNumber
  else
  if qMain.Active and (qMain.RecordCount > 0) then
    Phone_Number:=qMain.FieldByName('PHONE_NUMBER_FEDERAL').AsString;

  //проверка доступности BAN
  if not CheckBANByPhoneNumber(Phone_Number) then //если доступа нет
    exit;

  //Проверка на доступ к л/с телефона
  if UserCheckAllow then begin
    if CheckRightAccountAllow(Phone_Number) then begin
        MessageDlg('Нет доступа к л/с данного телефона.', mtError, [mbOK], 0);
        exit;
    end;
  end;
  Modalresult := mrOk;
end;

function TSelectContractForm.UserCheckAllow:boolean;
begin
  if not qUserCheckAllow.active then begin
    qUserCheckAllow.ParamByName('USER_NAME').AsString := mainform.OraSession.Username;
    qUserCheckAllow.open;
  end;
  if (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 1) or
     (qUserCheckAllow.FieldByName('check_allow_account').AsInteger = 2) then
    result:=true
  else
    result:=false;
end;

function TSelectContractForm.CheckRightAccountAllow(PhoneNumber:string):boolean;
begin
  qRightAccountAllow.Close;
  qRightAccountAllow.ParamByName('USER_NAME').AsString := mainform.OraSession.Username;
  qRightAccountAllow.ParamByName('PHONE_NUMBER').AsString := PhoneNumber;
  qRightAccountAllow.open;
  if qRightAccountAllow.FieldByName('cnt').AsInteger > 0 then result:=false else result:=true;
end;

procedure TSelectContractForm.CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if aSelect.Enabled and (Key = VK_RETURN) then
    aSelect.Execute;
  if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute;
end;

procedure TSelectContractForm.aCloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSelectContractForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute
  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (aSelect.Enabled) then
    aSelect.Execute;
end;

procedure TSelectContractForm.eSearchChange(Sender: TObject);
var ContractId: integer;
    PhoneBlockAccessFilial : boolean;
begin
  PhoneBlockAccessFilial:=false;
  if (MainForm.FUseFilialBlockAccess) and (Length(eSearch.Text)=10) then
  begin
    PhoneBlockAccessFilial:=true;
    spGetFilialByPhone.ParamByName('PPHONE_NUMBER').AsString:=eSearch.Text;
    spGetFilialByPhone.ExecSQL;
    if spGetFilialByPhone.ParamByName('RESULT').AsInteger= MainForm.FFilial then
      PhoneBlockAccessFilial:=false;
  end;
  if not(PhoneBlockAccessFilial) then
  begin
    if rbFastSelect.Checked then
      if Length(eSearch.Text)=10 then
      begin
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

procedure TSelectContractForm.tSearchTimer(Sender: TObject);
var vSurname, vName, vPatronymic : String;
  vStr : String;
begin
  tSearch.Enabled := False;
  if Trim(eSearch.Text) <> '' then
  begin
    if cbSearchType.ItemIndex = 0 then
    begin
      vStr := StringReplace(Trim(eSearch.Text), '  ', ' ', [rfReplaceAll, rfIgnoreCase]);
      if Pos(' ', vStr) = 0 then
        vSurname := vStr
      else
      begin
        vSurname := copy(vStr, 1, Pos(' ', vStr) - 1);
        vStr := copy(vStr, Pos(' ', vStr)+1, Length(vStr) - Pos(' ', vStr));
        if Pos(' ', vStr) = 0 then
          vName := vStr
        else
        begin
          vName := copy(vStr, 1, Pos(' ', vStr) - 1);
          vStr := copy(vStr, Pos(' ', vStr)+1, Length(vStr) - Pos(' ', vStr));
          if Pos(' ', vStr) = 0 then
            vPatronymic := vStr
          else
            vPatronymic := copy(vStr, 1, Pos(' ', vStr) - 1);
        end;
      end;

      if (vName = '') and (vPatronymic = '') then
      begin
        qMain.Locate('SURNAME', vSurname, [loCaseInsensitive, loPartialKey]);
      end
      else if (vPatronymic = '') then
      begin
        qMain.Locate('SURNAME;NAME', VarArrayOf([vSurname, vName]), [loCaseInsensitive, loPartialKey]);
      end
      else
        qMain.Locate('SURNAME;NAME;PATRONYMIC', VarArrayOf([vSurname, vName, vPatronymic]), [loCaseInsensitive, loPartialKey]);
    end
    else if cbSearchType.ItemIndex = 1 then
    begin
      vStr := StringReplace(Trim(eSearch.Text), '  ', ' ', [rfReplaceAll, rfIgnoreCase]);
      qMain.Locate('CONTRACT_NUM', vStr, []);
    end
    else if cbSearchType.ItemIndex = 2 then
    begin
      vStr := StringReplace(Trim(eSearch.Text), ' ', '', [rfReplaceAll, rfIgnoreCase]);
      vStr := StringReplace(vStr, '-', '', [rfReplaceAll, rfIgnoreCase]);
      qMain.Locate('PHONE_NUMBER_FEDERAL', vStr, [loCaseInsensitive, loPartialKey]);
    end;
  end;
end;

procedure TSelectContractForm.cbSearchTypeChange(Sender: TObject);
begin
  if cbSearchType.ItemIndex = 0 then
  begin // по ФИО абонента
    qMain.IndexFieldNames := 'SURNAME, NAME, PATRONYMIC, BDATE';
  end
  else if cbSearchType.ItemIndex = 1 then
  begin // по № договора
    qMain.IndexFieldNames := 'CONTRACT_NUM';
  end
  else if cbSearchType.ItemIndex = 2 then
  begin // по № телефона
    qMain.IndexFieldNames := 'PHONE_NUMBER_FEDERAL';
  end;

  eSearch.Text := '';
  if eSearch.CanFocus() then
    eSearch.SetFocus();
end;

procedure TSelectContractForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 { if ModalResult = mrOk then
  begin
    if qMain.Active and (not qMain.FieldByName('CONTRACT_CANCEL_DATE').IsNull) then
    begin
      MessageDlg('Договор № '+qMain.FieldByName('CONTRACT_NUM').AsString+' расторгнут. Выбирать его нельзя.', mtWarning, [mbOK], 0);
      CanClose := False;
      if eSearch.CanFocus() then
        eSearch.SetFocus();
    end;
  end;}
  CanClose:=true;
end;

procedure TSelectContractForm.FormCreate(Sender: TObject);
begin
  if MainForm.FUseFilialBlockAccess then
  begin
    qMain.SQL.Insert(17, '          WHERE DB_LOADER_ACCOUNT_PHONES.ACCOUNT_ID IN'
     + ' (SELECT ACCOUNT_ID FROM ACCOUNTS WHERE FILIAL_ID =' + IntToStr(MainForm.FFilial) + ')');
  end;
end;

function SelectContractId : Variant;
var SelectContractFrm : TSelectContractForm;
    vResult:variant;
begin
  Result := '';
  SelectContractFrm := TSelectContractForm.Create(Application);
  try
  //SelectContractFrm.ActiveControl := SelectContractFrm.eSearch;
  //SelectContractFrm.qMain.Filter := 'CONTRACT_CANCEL_DATE IS NULL';
  //SelectContractFrm.qMain.Filtered := True;
    if (mrOk = SelectContractFrm.ShowModal) then
    begin
      if SelectContractFrm.rbFastSelect.Checked then
      begin
        Result:=SelectContractFrm.FContractId;
      end
      else
      begin
        if SelectContractFrm.qMain.Active and (SelectContractFrm.qMain.RecordCount > 0) then
          Result := SelectContractFrm.qMain.FieldByName('CONTRACT_ID').Value;
      end;
    end;
  finally
  SelectContractFrm.Free;
  end;
end;


procedure SelectPhoneNumber (var rezPfone: string; var rezContractID : Integer) ;
var SelectContractFrm : TSelectContractForm;

begin
  SelectContractFrm := TSelectContractForm.Create(Application);
  try
    SelectContractFrm.qMain.Filtered := False;
    if (mrOk = SelectContractFrm.ShowModal) then
    begin
      if SelectContractFrm.rbFastSelect.Checked then
      begin
        rezContractID :=SelectContractFrm.FContractId;
        rezPfone := SelectContractFrm.FPhoneNumber;
      end
      else
      begin
        if SelectContractFrm.qMain.Active and (SelectContractFrm.qMain.RecordCount > 0) then
          rezContractID :=SelectContractFrm.qMain.FieldByName('CONTRACT_ID').AsInteger;
          rezPfone := SelectContractFrm.qMain.FieldByName('PHONE_NUMBER_FEDERAL').AsString;
      end;
    end;
  finally
    SelectContractFrm.Free;
  end;
end;



procedure TSelectContractForm.FormShow(Sender: TObject);
begin
  if eSearch.CanFocus then
    eSearch.SetFocus();
  PrepareSelect;

  //если для пользователя нужно проверять доступ к л/с
  if UserCheckAllow then begin
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
  'FROM CONTRACTS C,'+#13#10+
  '    CONTRACT_CANCELS CC,'+#13#10+
  '    ABONENTS A,'+#13#10+
  '    OPERATORS O,'+#13#10+
  '    (SELECT PHONE_NUMBER PHONE_NUMBER_FEDERAL'+#13#10+
  '       FROM DB_LOADER_ACCOUNT_PHONES p, rights_type_account_allow r, user_names u'+#13#10+
  '       WHERE r.rights_type = u.rights_type AND r.account_id = p.account_id AND UPPER(u.user_name) = UPPER(:user_name)'+#13#10+
  '       GROUP BY PHONE_NUMBER) AP'+#13#10+
  'WHERE AP.PHONE_NUMBER_FEDERAL=C.PHONE_NUMBER_FEDERAL(+)'+#13#10+
  '  AND C.CONTRACT_ID=CC.CONTRACT_ID(+)'+#13#10+
  '  AND C.ABONENT_ID=A.ABONENT_ID(+)'+#13#10+
  '  AND C.OPERATOR_ID=O.OPERATOR_ID(+)'+#13#10+
  'ORDER BY AP.PHONE_NUMBER_FEDERAL ASC, C.CONTRACT_DATE DESC';
  qMain.ParamByName('USER_NAME').AsString := mainform.OraSession.Username;
  end;

 // qMain.Open;

  try
    aRefresh.Execute;
  except
    on E: exception do
    begin
      MessageDlg('Ошибка открытия списка договоров. '#13#10+e.Message, mtError, [mbOK], 0);
      Close();
    end;
  end;
end;

procedure TSelectContractForm.eSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if aSelect.Enabled and (Key = VK_RETURN) then
    aSelect.Execute
  else if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute
  else if Key = VK_DOWN then
  begin
    if qMain.Active then
      qMain.Next;
  end
  else if Key = VK_UP then
  begin
    if qMain.Active then
      qMain.Prior;
  end;
end;

procedure TSelectContractForm.aRefreshExecute(Sender: TObject);
begin
  if not qMain.Active then
    qMain.Open
  else
    qMain.Refresh;
end;

procedure TSelectContractForm.CRDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  g : TCRDBGrid;
  f : TFont;
begin
  g := (Sender as TCRDBGrid);
  f := g.Canvas.Font;
  if not qMain.FieldByName('CONTRACT_CANCEL_DATE').IsNull then
  begin
    if (gdSelected in State) then
    begin
      // Номер телефона белым, остальные - серым
      if Column.FieldName = 'PHONE_NUMBER_FEDERAL' then
        f.Color := clWhite
      else
        f.Color := clSilver;
    end
    else
      f.Color := clGray;
  end;
  g.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TSelectContractForm.OnGetPhoneText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := FormatPhoneNumber(Sender.AsString);
end;

procedure TSelectContractForm.qMainAfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('PHONE_NUMBER_FEDERAL').OnGetText := OnGetPhoneText;
end;


procedure TSelectContractForm.RBOpenContrClick(Sender: TObject);
begin
//  qMain.Close;
  qMain.Filter := 'CONTRACT_CANCEL_DATE IS NULL';
  qMain.Filtered := True;
//  qMain.Open;

end;

procedure TSelectContractForm.RBCloseContrClick(Sender: TObject);
begin
//  qMain.Close;
  qMain.Filter := 'CONTRACT_CANCEL_DATE IS NOT NULL';
  qMain.Filtered := True;
//  qMain.Open;
end;




procedure TSelectContractForm.rbFastSelectClick(Sender: TObject);
begin
  PrepareSelect;
end;

procedure TSelectContractForm.rbFullSelectClick(Sender: TObject);
begin
  PrepareSelect;
end;

procedure TSelectContractForm.PrepareSelect;
begin
  if rbFastSelect.Checked
    then CRDBGrid1.Hide
    else CRDBGrid1.Show;
end;

end.

