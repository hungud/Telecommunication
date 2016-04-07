unit RefTariffs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar,
  ChildFrm, Func_Const, DMUnit, TimedMsgBox, RefOperators, RefFilials;

type
  TRefTariffsForm = class(TRefForm)
    btn2: TToolButton;
    btnRecalcTarifBalUblck: TToolButton;
    aRecalcTarifBalUblck: TAction;
    spRecalcTarifBalUblck: TOraStoredProc;
    aExtEditExecute: TAction;
    btn3: TToolButton;
    btnExtEditExecute: TToolButton;
    N11: TMenuItem;
    tbRecommendedTariffOptions: TToolButton;
    aRecommendedTariffOptions: TAction;
    pmRecommendedTariffOptions: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure aRecalcTarifBalUblckExecute(Sender: TObject);
    procedure aExtEditExecuteExecute(Sender: TObject);
    procedure aRecommendedTariffOptionsExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefTariffsForm: TRefTariffsForm;

implementation

{$R *.dfm}

uses RefTariff_option, RefSpecialBans, RecommendedTariffOptions;

procedure TRefTariffsForm.aExtEditExecuteExecute(Sender: TObject);
var
  RFrm : TChildForm;
  st : string;
begin
  st := ' Стоимость тарифных опции для тарифа '+ GlQuery.FieldByName('TARIFF_NAME').asString;
  RFrm := TTariff_option.Create(nil, RFrm, st, True);
  try
    TTariff_option(RFrm).TarifCode := GlQuery.FieldByName('TARIFF_CODE').asString;
    RFrm.ShowModal;
  finally
    RFrm.Free;
  end;
end;

procedure TRefTariffsForm.aRecalcTarifBalUblckExecute(Sender: TObject);
begin
  inherited;
  try
    spRecalcTarifBalUblck.ExecProc;
    TimedMessageBox('Баланс разблокировки пересчитан успешно.', 'Приятной работы!', mtInformation, [mbOK], mbOK, 30, 0);
  Except
     TimedMessageBox('Ошибка при пересчёте баланса разблокировки.', 'Попробуйте повторить позже!', mtError, [mbOK], mbOK, 0, 0);
  end;
  aRefreshExecute(self);
end;

procedure TRefTariffsForm.aRecommendedTariffOptionsExecute(Sender: TObject);
begin
  DoRecommendedTariffOptions(GlQuery.FieldByName('TARIFF_ID').asInteger, GlQuery.FieldByName('TARIFF_NAME').AsString);
end;

procedure TRefTariffsForm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qTariffs;
  ListCls := TLCls.Create(TRefOperatorsForm, TRefFilialsForm, TfrmRefSpecialBans);
  inherited;
  CaptList.Add('Справочник операторов');
  CaptList.Add('Справочник Филиалов');
  CaptList.Add('Группы спец.банов (для тарифных планов)');
end;

end.
