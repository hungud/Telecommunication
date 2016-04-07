unit ShowHackers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, Grids, DBGrids, CRGrid, StdCtrls, Buttons,
  ExtCtrls, ActnList, Menus;


type
  TShowHackersForm = class(TForm)
    dsHackers: TDataSource;
    qHackers: TOraQuery;
    Panel1: TPanel;
    lStatuses: TLabel;
    btLoadInExcel: TBitBtn;
    btRefresh: TBitBtn;
    cbStatuses: TComboBox;
    ActionList: TActionList;
    aCheck: TAction;
    aExcel: TAction;
    aRefresh: TAction;
    aPayments: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    qUpdate: TOraQuery;
    qStatuses: TOraQuery;
    grDataHackers: TCRDBGrid;
    dsCheckedTypes: TDataSource;
    qCheckedTypes: TOraQuery;
    qHackersDATE_CREATED: TDateTimeField;
    qHackersPHONE_NUMBER: TStringField;
    qHackersSERVICE_NAME: TStringField;
    qHackersCHECKED_TYPE_NAME: TStringField;
    qHackersCHECKED_TYPE_ID: TFloatField;
    qHackersCHECKED_TYPE_NAME_2: TStringField;
    qHackersHACKERS_ID: TFloatField;
    BitBtn3: TBitBtn;
    qHackersCOUNT_SMS_CHANGE: TFloatField;
    qHackersBALANCE: TFloatField;

    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure cbStatusesChange(Sender: TObject);
    procedure aCheckExecute(Sender: TObject);
    procedure dsHackersUpdateData(Sender: TObject);
    procedure grDataHackersKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshData;
  end;

var
  ShowHackersForm: TShowHackersForm;

procedure DoShowHackers;

implementation

{$R *.dfm}

uses ShowUserStat, ContractsRegistration_Utils, Main, IntecExportGrid, DMUnit;

procedure DoShowHackers;

var
  HackersFrm: TShowHackersForm;
begin
  //Отключаем таймер проверки
  mainform.Timer1.Enabled:=false;
  HackersFrm:=TShowHackersForm.Create(Nil);

  try
    HackersFrm.lStatuses.Show;
    HackersFrm.cbStatuses.Show;
    HackersFrm.qStatuses.Open;

    HackersFrm.cbStatuses.Items.Add('Все статусы');
    while not HackersFrm.qStatuses.EOF do
      begin
        HackersFrm.cbStatuses.Items.Add(
          HackersFrm.qStatuses.FieldByName('CHECKED_TYPE_NAME').AsString);
        HackersFrm.qStatuses.Next;
      end;

     if HackersFrm.cbStatuses.Items.Count > 0 then
        HackersFrm.cbStatuses.ItemIndex := 1;

    HackersFrm.qStatuses.Open;
    HackersFrm.qHackers.ParamByName('CHECKED_TYPE_NAME').asString := 'Не проверен';
    HackersFrm.qHackers.Open;
    HackersFrm.ShowModal;
  finally
    HackersFrm.Free;
    //включаем таймер проверки
    mainform.Timer1.Enabled:=true;
    mainform.Timer1Timer(nil);
  end;

end;

procedure TShowHackersForm.aCheckExecute(Sender: TObject);
begin
//Проставляем признак проверки
  if qHackers.Active and (qHackers.RecordCount > 0) then
  begin
    Dm.OraSession.StartTransaction;
    Try
      qUpdate.Close;
      qUpdate.ParamByName('HACKERS_ID').AsInteger:=qHackers.FieldByName('HACKERS_ID').AsInteger;
     {if qHackers.FieldByName('date_last_updated').IsNull then
      qUpdate.ParamByName('record_date').AsDateTime:=qHackers.FieldByName('date_created').AsDateTime
     else qUpdate.ParamByName('record_date').AsDateTime:=qHackers.FieldByName('date_last_updated').AsDateTime; }
       qUpdate.Execute;
      Dm.OraSession.Commit;
    Except
      on e: Exception do
      begin
        Dm.OraSession.Rollback;
        MessageDlg('Ошибка проверки л/с.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    End;
  end;
  qHackers.Close;
  qHackers.Open;
  qStatuses.Close;
  qStatuses.Open;

end;

procedure TShowHackersForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
 begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Список хакеров','',
      grDataHackers, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TShowHackersForm.aRefreshExecute(Sender: TObject);
var
  cbIndex: integer;
begin
  qStatuses.Close;
  qStatuses.Open;

  if cbStatuses.ItemIndex > 0 then
    qHackers.ParamByName('CHECKED_TYPE_NAME').asString := cbStatuses.Items.Strings[cbStatuses.ItemIndex];

  qHackers.Close;
  qHackers.Open;
end;

procedure TShowHackersForm.BitBtn3Click(Sender: TObject);
begin
  if qHackers.Active and (qHackers.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qHackers.FieldByName('PHONE_NUMBER').AsString,0);
  end;
end;

procedure TShowHackersForm.cbStatusesChange(Sender: TObject);
var
  CheckedTypeName : String;
begin
  if cbStatuses.ItemIndex > 0 then
    CheckedTypeName := cbStatuses.Items.Strings[cbStatuses.ItemIndex]
  else CheckedTypeName:='';
  if CheckedTypeName<>''then
  begin
    qHackers.ParamByName('CHECKED_TYPE_NAME').asString := CheckedTypeName;
  end else
  begin
    qHackers.ParamByName('CHECKED_TYPE_NAME').Clear;
  end;
end;

procedure TShowHackersForm.dsHackersUpdateData(Sender: TObject);
begin
   RefreshData;
end;

procedure TShowHackersForm.grDataHackersKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then RefreshData;
end;

procedure TShowHackersForm.RefreshData;
begin
  if qHackers.Active and (qHackers.RecordCount > 0) then
  begin
    Dm.OraSession.StartTransaction;
    Try
     qUpdate.Close;
     qUpdate.ParamByName('HACKERS_ID').AsInteger:=qHackers.FieldByName('HACKERS_ID').AsInteger;
     qUpdate.ParamByName('CHECKED_TYPE_ID').AsInteger:=qHackers.FieldByName('CHECKED_TYPE_ID').AsInteger;
     {if qHackers.FieldByName('date_last_updated').IsNull then
      qUpdate.ParamByName('record_date').AsDateTime:=qHackers.FieldByName('date_created').AsDateTime
     else qUpdate.ParamByName('record_date').AsDateTime:=qHackers.FieldByName('date_last_updated').AsDateTime; }
     qUpdate.Execute;
     Dm.OraSession.Commit;
    Except
      on e: exception do
      begin
        Dm.OraSession.Rollback;
        MessageDlg('Ошибка проверки л/с.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    End;
    Dm.OraSession.StartTransaction;
  end;
  qHackers.Close;
  qHackers.Open;
  qStatuses.Close;
  qStatuses.Open;

end;

end.
