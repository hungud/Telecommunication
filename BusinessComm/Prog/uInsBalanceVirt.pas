unit uInsBalanceVirt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.StdCtrls, Vcl.Buttons,
  sBitBtn, Vcl.ExtCtrls, sPanel, sBevel, sCurrEdit, sCurrencyEdit, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sTooledit;

type
  TInsBalanceVirtFrm = class(TChildForm)
    btnPanel: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    deDateBalance: TsDateEdit;
    sCurrencyEdit: TsCurrencyEdit;
    sBevel1: TsBevel;
    procedure deDateBalanceChange(Sender: TObject);
    procedure sCurrencyEditChange(Sender: TObject);
    procedure CheckControl;

  private

    { Private declarations }
  public
  inserting : Boolean;
  DateBalance : TDateTime;
  SumBalance : Currency;
    { Public declarations }
  end;

var
  InsBalanceVirtFrm: TInsBalanceVirtFrm;

implementation

{$R *.dfm}

procedure TInsBalanceVirtFrm.deDateBalanceChange(Sender: TObject);
begin
  inherited;
  CheckControl;
end;

procedure TInsBalanceVirtFrm.sCurrencyEditChange(Sender: TObject);
begin
  inherited;
  CheckControl;
end;

procedure TInsBalanceVirtFrm.CheckControl;
begin
  if inserting then
  begin
    sBsave.Enabled := (deDateBalance.Text<>'');
    //sBsave.Enabled := sBsave.Enabled and (sCurrencyEdit.AsInteger <> 0);
  end
  else
  begin
    sBsave.Enabled := (deDateBalance.Date <> DateBalance) or (sCurrencyEdit.Value  <>  SumBalance);
  end;
end;
end.
