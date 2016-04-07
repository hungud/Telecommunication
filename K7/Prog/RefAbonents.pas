unit RefAbonents;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, EditAbonent, ContractsRegistration_Utils,
  StdCtrls, Main, Mask;

type
  TRefAbonentsForm = class(TTemplateForm)
    qCountries_Citizen: TOraQuery;
    qCountries: TOraQuery;
    qRegions: TOraQuery;
    qIsVIP: TOraQuery;
    qMainABONENT_ID: TFloatField;
    qMainSURNAME: TStringField;
    qMainNAME: TStringField;
    qMainPATRONYMIC: TStringField;
    qMainBDATE: TDateTimeField;
    qMainPASSPORT_SER: TStringField;
    qMainPASSPORT_NUM: TStringField;
    qMainPASSPORT_DATE: TDateTimeField;
    qMainPASSPORT_GET: TStringField;
    qMainCITIZENSHIP: TFloatField;
    qMainCOUNTRY_ID: TFloatField;
    qMainREGION_ID: TFloatField;
    qMainREGION_NAME: TStringField;
    qMainCITY_NAME: TStringField;
    qMainSTREET_NAME: TStringField;
    qMainHOUSE: TStringField;
    qMainKORPUS: TStringField;
    qMainAPARTMENT: TStringField;
    qMainCONTACT_INFO: TStringField;
    qMainCODE_WORD: TStringField;
    qMainIS_VIP: TIntegerField;
    qMainCITIZEN_COUNTRY_NAME: TStringField;
    qMainCOUNTRY_NAME: TStringField;
    qMainREGION_NAME2: TStringField;
    qMainIS_VIP_NAME: TStringField;
    pSearch: TPanel;
    Label1: TLabel;
    eSearch: TMaskEdit;
    tSearch: TTimer;
    aSelect: TAction;
    aClose: TAction;
    ToolBar2: TToolBar;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure qMainAfterInsert(DataSet: TDataSet);
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aInsertExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    procedure tSearchTimer(Sender: TObject);
    procedure aSelectExecute(Sender: TObject);
    procedure CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CRDBGrid1DblClick(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FOldSearchStr : String;
  public
    { Public declarations }
    EditAbonentForm  : TEditAbonentForm;
  end;

  function SelectAbonent : Variant;

implementation

{$R *.dfm}

procedure TRefAbonentsForm.qMainAfterInsert(DataSet: TDataSet);
var vCountryId : Variant;
begin
  inherited;
  if DataSet.Active then
  begin
    vCountryId := GetDefaultCountry;
    DataSet.FieldByName('CITIZENSHIP').Value := vCountryId;
    DataSet.FieldByName('COUNTRY_ID').Value := vCountryId;
    //
    DataSet.FieldByName('REGION_ID').Value := GetDefaultregion;
  end;
end;

procedure TRefAbonentsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('SURNAME').IsNull then
  begin
    MessageDlg('Фамилия должна быть заполнена', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('NAME').IsNull then
  begin
    MessageDlg('Имя должно быть заполнено', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('BDATE').IsNull then
  begin
    MessageDlg('Дата рождения должна быть заполнена', mtError, [mbOK], 0);
    Abort;
  end;
  //
  inherited;
end;

procedure TRefAbonentsForm.aInsertExecute(Sender: TObject);
begin
//  inherited;
  if CheckPost then
  begin
    if not Assigned(EditAbonentForm) then
      EditAbonentForm := TEditAbonentForm.Create(Application);

    EditAbonentForm.FRunMode := 'INSERT';
    EditAbonentForm.FAbonentId := Null;
    if (mrOk = EditAbonentForm.ShowModal) then
    begin
      aRefresh.Execute;
      qMain.Locate('ABONENT_ID', EditAbonentForm.FAbonentId, []);
    end;
  end;
end;

procedure TRefAbonentsForm.aEditExecute(Sender: TObject);
begin
//  inherited;
  if CheckPost then
  begin
    if qMain.Active and (qMain.RecordCount > 0) then
    begin
      if not Assigned(EditAbonentForm) then
        EditAbonentForm := TEditAbonentForm.Create(Application);

      EditAbonentForm.FRunMode := 'EDIT';
      EditAbonentForm.FAbonentId := qMain.FieldByName('ABONENT_ID').Value;
      if (mrOk = EditAbonentForm.ShowModal) then
      begin
        aRefresh.Execute;
        qMain.Locate('ABONENT_ID', EditAbonentForm.FAbonentId, []);
      end;
    end;
  end;
end;

procedure TRefAbonentsForm.eSearchChange(Sender: TObject);
begin
  //inherited;
  if aSelect.Enabled then
    tSearch.Enabled := True;
end;

procedure TRefAbonentsForm.tSearchTimer(Sender: TObject);
var vSurname, vName, vPatronymic : String;
  vStr : String;
begin
  //inherited;
  tSearch.Enabled := False;
  if Trim(eSearch.Text) = '' then
    FOldSearchStr := ''
  else
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

    {
    begin
      //FOldSearchStr := eSearch.Text;
    end
    else
    begin
      //eSearch.Text := FOldSearchStr;
    end;
    }
  end;
end;

function SelectAbonent : Variant;
var RefAbonentsForm : TRefAbonentsForm;
begin
  Result := Null;
  RefAbonentsForm := TRefAbonentsForm.Create(Application);
  try
    RefAbonentsForm.aInsert.Enabled := False;
    RefAbonentsForm.aEdit.Enabled := False;
    RefAbonentsForm.aDelete.Enabled := False;
    RefAbonentsForm.aPost.Enabled := False;
    RefAbonentsForm.aCancel.Enabled := False;

    RefAbonentsForm.aInsert.Visible := False;
    RefAbonentsForm.aEdit.Visible := False;
    RefAbonentsForm.aDelete.Visible := False;
    RefAbonentsForm.aPost.Visible := False;
    RefAbonentsForm.aCancel.Visible := False;
    RefAbonentsForm.Panel1.Visible := False;

    RefAbonentsForm.pSearch.Visible := True;
    RefAbonentsForm.aSelect.Enabled := True;
    RefAbonentsForm.aClose.Enabled := True;
    RefAbonentsForm.aSelect.Visible := True;
    RefAbonentsForm.aClose.Visible := True;

    RefAbonentsForm.ActiveControl := RefAbonentsForm.eSearch; 
    if (mrOk = RefAbonentsForm.ShowModal) then
    begin
      if RefAbonentsForm.qMain.Active and (RefAbonentsForm.qMain.RecordCount > 0) then
        Result := RefAbonentsForm.qMain.FieldByName('ABONENT_ID').Value;
    end;
  finally
    RefAbonentsForm.Free;
  end;
end;


procedure TRefAbonentsForm.aSelectExecute(Sender: TObject);
begin
  //inherited;
  Modalresult := mrOk; 
end;

procedure TRefAbonentsForm.CRDBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if aSelect.Enabled and (Key = VK_RETURN) then
    aSelect.Execute
  else
    inherited;
end;

procedure TRefAbonentsForm.CRDBGrid1DblClick(Sender: TObject);
begin
  if aSelect.Enabled then
    aSelect.Execute
  else
    inherited;
end;

procedure TRefAbonentsForm.aCloseExecute(Sender: TObject);
begin
  //inherited;
  ModalResult := mrCancel;
end;

procedure TRefAbonentsForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and aClose.Enabled then
    aClose.Execute
  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (aSelect.Enabled) then
    aSelect.Execute;
end;

procedure TRefAbonentsForm.FormShow(Sender: TObject);
begin
  inherited;
  FOldSearchStr := '';  
end;

end.
