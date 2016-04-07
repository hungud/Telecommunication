unit RefPhones;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  Func_Const,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm, System.StrUtils,
  TimedMsgBox, Vcl.Mask, Vcl.DBCtrls;

type
  TRefPhonesForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefBeforePost(DataSet: TDataSet);
    procedure qRefAfterInsert(DataSet: TDataSet);

  private
     ExBeforePost : MyProc; { Private declarations }
     AssignExBeforePost : Integer;
  public
    { Public declarations }
  end;

var
  RefPhonesForm: TRefPhonesForm;

implementation

{$R *.dfm}

uses RefFrmEdit;

procedure TRefPhonesForm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qPhones;
  inherited;
  qRef.OnPostError := qRefPostError;
  qRef.OnDeleteError := qRefDeleteError;
  qRef.AfterInsert := qRefAfterInsert;

 if Assigned(qRef.BeforePost) then
  begin
    AssignExBeforePost := 1;
    ExBeforePost := qRef.BeforePost;
  end;
  qRef.BeforePost := qRefBeforePost;
end;

procedure TRefPhonesForm.qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
var
 rzlt : Integer;
 nmb : Extended;
begin
  if  ContainsText(E.Message,'PK') then
  begin
    Action := daAbort;
    rzlt := TimedMessageBox('Такой телефонный номер уже есть! Перейти к нему?', 'Пожалуйста, будьте внимательны!', mtWarning, [mbYes, mbNo], mbNo, 15, 3);
    if (rzlt = 6) then
    begin
      nmb := DataSet.FieldByName('PHONE_NUMBER').AsLargeInt;
      CloseRefFormEdit;
      //RefFormEdit.sBClose.Click;
      DataSet.Cancel;
      DataSet.Locate('PHONE_ID', nmb, []);
    end;
  end;
end;

procedure TRefPhonesForm.qRefAfterInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('IS_NUMBER_CITY').AsInteger := 0;
end;

procedure TRefPhonesForm.qRefBeforePost(DataSet: TDataSet);
begin
  if AssignExBeforePost = 1 then
    ExBeforePost(DataSet);

  if Length(DataSet.FieldByName('PHONE_NUMBER').AsString) <> 10 then
  begin
    TimedMessageBox('Ошибка - ' + DataSet.FieldByName('PHONE_NUMBER').DisplayLabel + ' должно состоять из 10 цифр!', 'Внимание!', mtWarning, [mbAbort], mbAbort, 15, 3);
    raise EAbort.Create('');
  end;
  if DataSet.FieldByName('PHONE_NUMBER_CITY').AsString <> '' then
    if Length(DataSet.FieldByName('PHONE_NUMBER_CITY').AsString) < 5 then
    begin
      TimedMessageBox('Ошибка - ' + DataSet.FieldByName('PHONE_NUMBER_CITY').DisplayLabel + ' должно быть пустым или состоять от 5 до 13 цифр!', 'Внимание!', mtWarning, [mbAbort], mbAbort, 15, 3);
      raise EAbort.Create('');
    end;
  DataSet.FieldByName('PHONE_ID').AsLargeInt  := StrToInt64(DataSet.FieldByName('PHONE_NUMBER').AsString);
end;

procedure TRefPhonesForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'PHONE_ON_ACCOUNTS_PHONE_ID_FK') then
  begin
    TimedMessageBox('Этот телефон соотнесен с лицевым счетом оператора связи.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
