unit RefOperatorSubAccount;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefOperatorSubAccountForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefOperatorSubAccountForm: TRefOperatorSubAccountForm;

implementation

{$R *.dfm}

uses RefFilial;

procedure TRefOperatorSubAccountForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qOperatorSubAccounts;
  ListCls := TLCls.Create(TRefFilialForm);
  inherited;
  CaptList.Add('Справочник филиалов');
  qRef.OnDeleteError := qRefDeleteError;
end;

procedure TRefOperatorSubAccountForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  //if AnsiContainsText(E.Message, '20001') then
  begin
    TimedMessageBox('Эта запись используется.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;
end.
