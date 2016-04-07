unit RefAbonents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,  System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, uDm,  Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TRefAbonentsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefAbonentsForm: TRefAbonentsForm;

implementation

{$R *.dfm}

uses RefCountries, RefRegions;

procedure TRefAbonentsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Dm.filtrReg := false;
  Dm.qRegions.Filtered := False;
end;

procedure TRefAbonentsForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qAbonents;
  ListCls := TLCls.Create(TRefCountriesForm, TRefCountriesForm, TRefRegionsForm);
  inherited;
   CaptList.Add('Справочник стран - гражданство');
   CaptList.Add('Справочник стран - проживание');
   CaptList.Add('Справочник регионов');
   Dm.filtrReg := True;
  qRef.OnDeleteError  := qRefDeleteError;
  qRef.AfterInsert := qRefAfterInsert;
end;

procedure TRefAbonentsForm.qRefAfterInsert(DataSet: TDataSet);
begin
    DataSet.FieldByName('COUNTRY_ID').AsInteger := dm.CountryDef_Id;
    DataSet.FieldByName('COUNTRY_ID_CITIZENSHIP').AsInteger := dm.CountryDef_Id;
    DataSet.FieldByName('IS_VIP').AsInteger := 0;
end;

procedure TRefAbonentsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'CONTRACTS_FK_ABONENT_ID') then
  begin
    TimedMessageBox('Эта запись используется в справочнике договоров.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
