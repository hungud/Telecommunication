unit RefTariffs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, Func_Const, TimedMsgBox,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, uDm, System.StrUtils,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TRefTariffsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefAfterInsert(DataSet: TDataSet);
 private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefTariffsForm: TRefTariffsForm;

implementation

{$R *.dfm}

uses RefFilial;

procedure TRefTariffsForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qTariffs;
  ListCls := TLCls.Create(TRefFilialForm);
  inherited;
  CaptList.Add('Справочник филиалов');
  qRef.OnDeleteError := qRefDeleteError;
  qRef.AfterInsert := qRefAfterInsert;
end;

procedure TRefTariffsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'CONTRACTS_FK_TARIFF_ID') then
  begin
    TimedMessageBox('Эта запись используется в справочнике договоров.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

procedure TRefTariffsForm.qRefAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('IS_ACTIVE').AsInteger := 0;
end;

end.
