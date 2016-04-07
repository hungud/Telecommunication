unit RefAgent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefAgentForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefAgentForm: TRefAgentForm;

implementation

{$R *.dfm}

procedure TRefAgentForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qAgent;
  inherited;
  AddExcelColNumber := False;
  qRef.OnDeleteError  := qRefDeleteError;
  qRef.AfterInsert := qRefAfterInsert;
end;

procedure TRefAgentForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'FK_AGENT_ID') then
  begin
    TimedMessageBox('Эта запись используется в соотношениях агентов и субагентов.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
    Exit;
  end;
  if AnsiContainsText(E.Message, '20001') then
  begin
    TimedMessageBox('Эта запись используется.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

procedure TRefAgentForm.qRefAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('PAYABLE').AsInteger := 0;
end;

end.
