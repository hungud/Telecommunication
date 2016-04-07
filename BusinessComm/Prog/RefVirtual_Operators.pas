unit RefVirtual_Operators;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDm, Func_Const, System.StrUtils,
  TimedMsgBox, RefFrm, Data.DB, MemDS, DBAccess, Ora, Vcl.Menus, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, Vcl.Grids,
  Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar;

type
  TRefVirtual_OperatorsForm = class(TRefForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    aTranscriptBalance: TAction;
    procedure FormCreate(Sender: TObject);
    procedure qRefAfterInsert(DataSet: TDataSet);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure qRefBeforeOpen(DataSet: TDataSet);
    procedure aTranscriptBalanceExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefVirtual_OperatorsForm: TRefVirtual_OperatorsForm;

implementation

{$R *.dfm}

uses ChildFrm, AddPeriod, uTranscriptBalance;

procedure TRefVirtual_OperatorsForm.aTranscriptBalanceExecute(Sender: TObject);
var
 spf : TChildForm;
 mr : Integer;
// DATE_BALANCE : TDate;
// SUM_BALANCE : Currency;
begin
  inherited;
  spf := TTranscriptBalanceFrm.Create(self, spf, 'Расшифровка баланса по счету ' + qRef.FieldByName('VIRTUAL_ACCOUNTS_NAME').Asstring, true); //, self//
//  TTranscriptBalanceFrm(spf).YearMonth := YEAR_MONTH;
  TTranscriptBalanceFrm(spf).VirtualAccountsId :=  qRef.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
  TTranscriptBalanceFrm(spf).VirtualAccountName := qRef.FieldByName('VIRTUAL_ACCOUNTS_NAME').AsString;

  try
    mr := spf.ShowModal;
    if (mr = mrOk) then
    begin
      qRef.RefreshRecord;
    end;
  finally
    spf.Free;
  end;

end;

procedure TRefVirtual_OperatorsForm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qVirtual_Operator;
  qRef.BeforeOpen := qRefBeforeOpen;
  inherited;
  qRef.AfterInsert := qRefAfterInsert;
  qRef.OnDeleteError := qRefDeleteError;

end;

procedure TRefVirtual_OperatorsForm.qRefBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  fqRefBeforeOpen(DataSet);
//  qRef.ParamByName('YEAR_MONTH').AsInteger := Dm.month_year_withLastData;
end;

procedure TRefVirtual_OperatorsForm.qRefAfterInsert(DataSet: TDataSet);
begin
   DataSet.FieldByName('VIRTUAL_ACCOUNTS_IS_ACTIVE').AsInteger := 0;
end;

procedure TRefVirtual_OperatorsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'CONTRACTS_FK_VIRT_ACC_ID') then
  begin
    TimedMessageBox('Эта запись используется в справочнике договоров.  Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;
end.
