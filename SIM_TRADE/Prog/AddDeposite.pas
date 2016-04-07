unit AddDeposite;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, Buttons, DB, MemDS, DBAccess, Ora;

type
  TAddDepositeFrm = class(TForm)
    lAddDepositValue: TLabel;
    lAddDepositNote: TLabel;
    qAddDepositOper: TOraStoredProc;
    eAddDepositValue: TEdit;
    btCancel: TBitBtn;
    mAddDepositNote: TMemo;
    btOK: TBitBtn;
    Label1: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure eAddDepositValueKeyPress(Sender: TObject; var Key: Char);
    procedure btCancelClick(Sender: TObject);
  private
  public
    ContractID:Integer;

  end;

var
  AddDepositeFrm: TAddDepositeFrm;

implementation

{$R *.dfm}

procedure TAddDepositeFrm.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TAddDepositeFrm.btOKClick(Sender: TObject);
begin
  if eAddDepositValue.Text<>'' then
  begin
    qAddDepositOper.ParamByName('PCONTRACT_ID').AsInteger:=ContractID;
    qAddDepositOper.ParamByName('PDEPOSITE_VALUE').AsInteger:=StrToInt(eAddDepositValue.Text);
    qAddDepositOper.ParamByName('PNOTE').asString:=mAddDepositNote.Text;
    qAddDepositOper.ExecSQL;
  end;
  Close;
end;

procedure TAddDepositeFrm.eAddDepositValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key<'0')or(key>'9') then Key:=#0;

end;

end.
