unit RefCountries;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, Func_Const, TimedMsgBox,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  System.StrUtils,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefCountriesForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefAfterInsert(DataSet: TDataSet);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefCountriesForm: TRefCountriesForm;

implementation

{$R *.dfm}

procedure TRefCountriesForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qCountry;
  inherited;
  qRef.AfterInsert := qRefAfterInsert;
  qRef.OnDeleteError := qRefDeleteError;
end;

procedure TRefCountriesForm.qRefAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('IS_DEFAULT').AsInteger := 0;
end;

procedure TRefCountriesForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'REGIONS_COUNTRY_ID_FK') then
  begin
    TimedMessageBox('Эта запись используется в справочнике регионов.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
  if AnsiContainsText(E.Message, 'ABONENTS_FK_COUNTRY') then
  begin
    TimedMessageBox('Эта запись используется в справочнике абонентов.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
  if AnsiContainsText(E.Message, 'ABONENTS_FK_CITIZENSHIP') then
  begin
    TimedMessageBox('Эта запись используется в справочнике абонентов.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;

end;

end.
