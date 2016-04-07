unit RefMobilOperator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, System.StrUtils,
  Vcl.Buttons, sBitBtn, sPanel, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  sToolBar, uDm, Vcl.Mask, Vcl.DBCtrls, Func_Const, TimedMsgBox;

type
  TRefMobilOperatorForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefMobilOperatorForm: TRefMobilOperatorForm;

implementation

{$R *.dfm}

procedure TRefMobilOperatorForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qMob_Operators;
  inherited;
  qRef.OnDeleteError  := qRefDeleteError;
  qRef.OnPostError := qRefPostError;
end;

procedure TRefMobilOperatorForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'ACC_MOBILE_OPERATOR_NAME_ID_FK') then
  begin
    TimedMessageBox('Эта запись используется в лицевых счетах организации.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

procedure TRefMobilOperatorForm.qRefPostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'MOBILE_OPER_NAMES_UNIQ_NAMES') then
  begin
    TimedMessageBox('Такое наименование уже есть!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
