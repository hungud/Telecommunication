unit RefPaymentsType;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, uDm, Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;
type
  TRefPaymentsTypefrm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefPaymentsTypefrm: TRefPaymentsTypefrm;

implementation

{$R *.dfm}

procedure TRefPaymentsTypefrm.FormCreate(Sender: TObject);
begin
 qRef := dm.qPAYMENTS_TYPE;
  inherited;
 qRef.OnDeleteError := qRefDeleteError;
end;

procedure TRefPaymentsTypefrm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, '-20001') then
  begin
    TimedMessageBox('Эта запись используется.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
