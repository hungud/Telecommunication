unit ReportAccPay4Equip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ReportFrm, Vcl.ActnList, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ImgList, ShowUserStat;

type
  TReportAccPay4EquipForm = class(TReportForm)
    qReportID_ACC_PAYMENT_EQUIPMENT: TFloatField;
    qReportACC_PAYMENT_NUMBER: TFloatField;
    qReportACCOUNT_ID: TFloatField;
    qReportCOMPANY_NAME: TStringField;
    qReportDATE_ISSUING: TDateTimeField;
    qReportACC_PAYMENT_SUM: TFloatField;
    qReportACC_PAYMENT_CHECK: TFloatField;
    qReportUSER_CREATED: TStringField;
    qReportDATE_CREATED: TDateTimeField;
    qReportUSER_LAST_UPDATED: TStringField;
    qReportDATE_LAST_UPDATED: TDateTimeField;
    qReportACCOUNT_NUMBER: TFloatField;
    ImageList1: TImageList;
    lAccount: TLabel;
    cbAccounts: TComboBox;
    qAccounts: TOraQuery;
    btLoadAccPayEquip: TBitBtn;
    cbSearch: TCheckBox;
    stLoadAccPayEquip: TOraStoredProc;
    aLoadAccPayEquip: TAction;
    procedure gReportDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gReportDblClick(Sender: TObject);
    procedure cbAccountsChange(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure aLoadAccPayEquipExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportAccPay4EquipForm: TReportAccPay4EquipForm;

procedure DoReportAccPay4Equip;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, IntecExportGrid;

procedure DoReportAccPay4Equip;
var ReportFrm : TReportAccPay4EquipForm;
    Sdvig:integer;
begin
  ReportFrm := TReportAccPay4EquipForm.Create(Nil);
  try
    // «аполнение списка "Ћиц.счет"
    with ReportFrm do begin
      qAccounts.Open;
      cbAccounts.Items.AddObject('¬се', Pointer(0));
      while not qAccounts.EOF do
      begin
        cbAccounts.Items.AddObject(
          qAccounts.FieldByName('LOGIN').AsString,
          Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        qAccounts.Next;
      end;
      qAccounts.Close;
      if cbAccounts.Items.Count > 0 then
        cbAccounts.ItemIndex := 0;
      if Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])<>0 then
        qReport.ParamByName('ACCOUNT_ID').asInteger :=
          Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
      else qReport.ParamByName('ACCOUNT_ID').Clear;

      qReport.Open;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportAccPay4EquipForm.aLoadAccPayEquipExecute(Sender: TObject);
begin
  inherited;
  qReport.Close;
  //процедура загрузки счетов оплаты за оборудование
  stLoadAccPayEquip.ExecSQL;
  qReport.Open;
end;

procedure TReportAccPay4EquipForm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('»нформаци€ о счетах оплаты за оборудование','',
      gReport, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAccPay4EquipForm.cbAccountsChange(Sender: TObject);
var Account: integer;
begin
  if cbAccounts.ItemIndex >= 0 then
    Account := Integer(cbAccounts.Items.objects[cbAccounts.ItemIndex])
  else
    Account:=0;

  if Account<>0 then
    qReport.ParamByName('ACCOUNT_ID').asInteger := Account
  else
    qReport.ParamByName('ACCOUNT_ID').Clear;

  aRefreshExecute(nil);
end;

procedure TReportAccPay4EquipForm.cbSearchClick(Sender: TObject);
begin
  inherited;
  if cbSearch.Checked then
    gReport.OptionsEx := gReport.OptionsEx+[dgeSearchBar]
  else
    gReport.OptionsEx := gReport.OptionsEx-[dgeSearchBar];
end;

//устанавливаем/снимаем галку
procedure TReportAccPay4EquipForm.gReportDblClick(Sender: TObject);
var qS: TOraQuery;
    i: integer;
    pACC_PAYMENT_CHECK: variant;
begin
  inherited;
  if TCRDBGrid(Sender).SelectedField.Name = qReportACC_PAYMENT_CHECK.Name then //если щелкнули по полю проверки
  begin
    i := qReport.RecNo;
    qReport.DisableControls;

    qS := TOraQuery.Create(nil);
    try
      if qReportACC_PAYMENT_CHECK.Value <> 1 then //вставл€ем 1
        pACC_PAYMENT_CHECK := 1
      else
        pACC_PAYMENT_CHECK := 0;

      qS.SQL.Text := 'UPDATE ACC_PAYMENTS_FOR_EQUIPMENT SET ACC_PAYMENT_CHECK = :pACC_PAYMENT_CHECK ' +
        ' WHERE ID_ACC_PAYMENT_EQUIPMENT = :pID_ACC_PAYMENT_EQUIPMENT ';

      qS.ParamByName('pACC_PAYMENT_CHECK').AsInteger := pACC_PAYMENT_CHECK;
      qS.ParamByName('pID_ACC_PAYMENT_EQUIPMENT').AsInteger := qReportID_ACC_PAYMENT_EQUIPMENT.AsInteger;

      qS.ExecSQL;
      //обновл€ем данные по соответстви€м
      qReport.Close;
      qReport.Open;
    finally
      FreeANDNil(qS);
    end;

    qReport.RecNo := i;
    qReport.EnableControls;
  end;
end;

//прорисовываем галку
procedure TReportAccPay4EquipForm.gReportDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var Im1: TBitmap;
begin
  inherited;
  if Column.FieldName = qReportACC_PAYMENT_CHECK.FieldName then
    with gReport.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(Rect);

      if qReportACC_PAYMENT_CHECK.Value = 1 then
      begin
        Im1 := TBitmap.Create;//создание
        try
          ImageList1.GetBitmap(0,Im1);
          Draw(round((Rect.Left+Rect.Right-Im1.Width)/2),Rect.Top,Im1);
        finally
          Im1.Free;
        end;
      end;
    end;
end;

end.
