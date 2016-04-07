unit RefFilial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, uDm, Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TRefFilialForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefFilialForm: TRefFilialForm;

implementation

{$R *.dfm}

uses RefMobilOperator;

procedure TRefFilialForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qFilials;
  ListCls := TLCls.Create(TRefMobilOperatorForm);

  inherited;
  CaptList.Add('Справочник операторов');
  qRef.OnDeleteError := qRefDeleteError;
end;

procedure TRefFilialForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'CONTRACTS_FK_FILIAL_ID') then
  begin
    TimedMessageBox('Эта запись используется в справочнике договоров.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;
end.
