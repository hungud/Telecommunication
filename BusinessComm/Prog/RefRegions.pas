unit RefRegions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefRegionsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefAfterInsert(DataSet: TDataSet);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefRegionsForm: TRefRegionsForm;

implementation

{$R *.dfm}

uses RefCountries;

procedure TRefRegionsForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qRegions;
  ListCls := TLCls.Create(TRefCountriesForm);
  inherited;
  CaptList.Add('Справочник стран');
  AddExcelColNumber := False;
  qRef.OnDeleteError  := qRefDeleteError;
  qRef.AfterInsert := qRefAfterInsert;
end;

procedure TRefRegionsForm.qRefAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('COUNTRY_ID').AsInteger := dm.CountryDef_Id;
end;

procedure TRefRegionsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'ABONENTS_FK_REGION') then
  begin
    TimedMessageBox('Эта запись используется в справочнике абонентов.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
