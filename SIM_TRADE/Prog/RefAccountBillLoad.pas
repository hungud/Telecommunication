unit RefAccountBillLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora,
  Buttons, ActnList, Mask, sMaskEdit, sCustomComboEdit, sTooledit;

type
  TRefAccountBillLoadForm = class(TForm)
    qRef: TOraQuery;
    dsRef: TDataSource;
    CRDBGrid1: TCRDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    cbPeriod: TComboBox;
    qPeriods: TOraQuery;
    qRefLOGIN: TStringField;
    qRefDATE_BEGIN: TDateTimeField;
    qRefDATE_END: TDateTimeField;
    qRefLOAD_BILL_IN_BALANCE: TFloatField;
    qRefDATE_CREDIT_END: TDateTimeField;
    qRefUSER_LAST_UPDATE: TStringField;
    qRefDATE_LAST_UPDATE: TDateTimeField;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    CRDBGrid2: TCRDBGrid;
    qAccNotBalance: TOraQuery;
    dsAccNotBalance: TDataSource;
    qAccNotBalanceLOGIN: TStringField;
    qAccNotBalanceYEAR_MONTH: TStringField;
    Panel3: TPanel;
    Panel4: TPanel;
    cbTurnOffSetup: TCheckBox;
    deDateCreditSetup: TsDateEdit;
    lSetup: TLabel;
    BitBtn2: TBitBtn;
    Panel5: TPanel;
    qSetupParamYearMonth: TOraQuery;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure cbPeriodChange(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoRefAccountBillLoad;

var
  RefAccountBillLoadForm: TRefAccountBillLoadForm;

implementation

uses Main;

{$R *.dfm}

procedure DoRefAccountBillLoad;
var ReportFrm : TRefAccountBillLoadForm;
    Sdvig:integer;
begin
  ReportFrm := TRefAccountBillLoadForm.Create(Nil);
  try
    if MainForm.FUseFilialBlockAccess then
    begin
      ReportFrm.qRef.SQL.Insert(13, '    AND ACCOUNTS.FILIAL_ID = ' + IntToStr(MainForm.FFilial));
      ReportFrm.qAccNotBalance.SQL.Insert(16, '    AND A.FILIAL_ID = ' + IntToStr(MainForm.FFilial));
      ReportFrm.Panel4.Hide;
    end;
    // Период
    ReportFrm.qPeriods.Open;
    while not ReportFrm.qPeriods.EOF do
    begin
      ReportFrm.cbPeriod.Items.AddObject(
        ReportFrm.qPeriods.FieldByName('YEAR_MONTH_NAME').AsString,
        TObject(ReportFrm.qPeriods.FieldByName('YEAR_MONTH').AsInteger)
        );
      ReportFrm.qPeriods.Next;
    end;
    ReportFrm.qPeriods.Close;
    if ReportFrm.cbPeriod.Items.Count > 0 then
      ReportFrm.cbPeriod.ItemIndex := 0;
    ReportFrm.cbPeriodChange(ReportFrm.cbPeriod);
//    ReportFrm.aRefresh.Execute;
    ReportFrm.qRef.Open;
    ReportFrm.qAccNotBalance.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TRefAccountBillLoadForm.aRefreshExecute(Sender: TObject);
begin
  qRef.Close;
  qRef.Open;
  qAccNotBalance.Close;
  qAccNotBalance.Open;
end;

procedure TRefAccountBillLoadForm.BitBtn2Click(Sender: TObject);
var Text: String;
    Period: integer;
begin
  Period:=Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex]);
  qSetupParamYearMonth.ParamByName('PYEAR_MONTH').AsInteger:=Period;
  qSetupParamYearMonth.ParamByName('PDATE_CREDIT').AsDateTime:=deDateCreditSetup.Date;
  if cbTurnOffSetup.Checked then
    qSetupParamYearMonth.ParamByName('PLOAD').AsInteger:=1
  else
    qSetupParamYearMonth.ParamByName('PLOAD').AsInteger:=0;
  if cbTurnOffSetup.Checked then
    Text:='Подключить в баланс'
  else
    Text:='Отключить от баланса';
  Text:= Text +' все счета за ' + IntToStr(Trunc(Period/100))
    + ' - ' + IntToStr(Period - Trunc(Period/100)*100) + ' с кредитом по '
    + deDateCreditSetup.Text;
  if mrOk = MessageDlg(Text, mtConfirmation, [mbOK, mbCancel], 0) then
    qSetupParamYearMonth.ExecSQL;
  aRefresh.Execute;
end;

procedure TRefAccountBillLoadForm.cbPeriodChange(Sender: TObject);
var
  Period : Integer;
begin
  if cbPeriod.ItemIndex >= 0 then
    Period := Integer(cbPeriod.Items.Objects[cbPeriod.ItemIndex])
  else
    Period := -1;
  qRef.ParamByName('YEAR_MONTH').AsInteger := Period;
  aRefresh.Execute;
end;

procedure TRefAccountBillLoadForm.FormShow(Sender: TObject);
begin
  deDateCreditSetup.Date:=Date;
end;

end.
