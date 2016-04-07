unit RefPhonesOnAcc;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora, System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,  Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm,   ChildFrm,
  Vcl.Mask, Vcl.DBCtrls;

type
  TRefPhonesOnAccFrm = class(TRefForm)
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    aShowHist: TAction;
    aShowDeleting: TAction;
    procedure FormCreate(Sender: TObject);
    procedure aShowHistExecute(Sender: TObject);
    procedure aShowDeletingExecute(Sender: TObject);
    procedure ShowHist(pShowDeletingHist : Boolean);
  private

  public
    { Public declarations }
  end;

var
  RefPhonesOnAccFrm: TRefPhonesOnAccFrm;

implementation

{$R *.dfm}

uses  RefPhonesOnAccountHist, RefPhones, RefAccounts;

procedure TRefPhonesOnAccFrm.ShowHist(pShowDeletingHist : Boolean);
 var
  ReportFrm : TChildForm;
  capt : string;
begin
  //capt := Caption;

  Dm.qPhonForAccHist.close;
  if pShowDeletingHist then
  begin
    Dm.qPhonForAccHist.ParamByName('PHONE_ON_ACCOUNTS_ID').Clear;
    capt := 'История удаленных записей по л/с';
  end
  else
  begin
    Dm.qPhonForAccHist.ParamByName('PHONE_ON_ACCOUNTS_ID').Value := qRef.FieldByName('PHONE_ON_ACCOUNTS_ID').Value;
    capt := 'История перехода номера по л/с  - '+qRef.FieldByName('PHONE_ON_ACCOUNTS_ID').AsString;
  end;

  ReportFrm := TRefPhonesOnAccountHistForm.Create(nil, ReportFrm, capt, True);
  TRefPhonesOnAccountHistForm(ReportFrm).sBsave.Visible := false;
  TRefPhonesOnAccountHistForm(ReportFrm).sBClose.Caption := 'Ок';
  TRefPhonesOnAccountHistForm(ReportFrm).sBClose.ImageIndex := 25;
  try
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
  //Caption := capt;
end;

procedure TRefPhonesOnAccFrm.aShowDeletingExecute(Sender: TObject);
begin
  inherited;

  ShowHist(True);
end;

procedure TRefPhonesOnAccFrm.aShowHistExecute(Sender: TObject);
begin
  inherited;

  if qRef.FieldByName('PHONE_ON_ACCOUNTS_ID').IsNull then
    TimedMessageBox('Нет данных для показа истории!', 'Внимание!', mtWarning, [mbAbort], mbAbort, 15, 3)
  else
    ShowHist(False);
end;

procedure TRefPhonesOnAccFrm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qPhonesOnAccount;
  ListCls := TLCls.Create(TRefPhonesForm, TRefAccountsForm);
  inherited;
  CaptList.Add('Справочник телефонов');
  CaptList.Add('Справочник счетов');
  AddExcelColNumber := False;
end;

end.
