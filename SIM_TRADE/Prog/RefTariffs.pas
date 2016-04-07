unit RefTariffs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, ContractsRegistration_Utils,
  OraSmart, Vcl.ImgList;

type
  TRefTariffsForm = class(TTemplateForm)
    qOperators: TOraQuery;
    qMainTARIFF_ID: TFloatField;
    qMainTARIFF_CODE: TStringField;
    qMainOPERATOR_ID: TFloatField;
    qMainPHONE_NUMBER_TYPE: TIntegerField;
    qMainTARIFF_NAME: TStringField;
    qMainIS_ACTIVE: TIntegerField;
    qMainSTART_BALANCE: TFloatField;
    qMainCONNECT_PRICE: TFloatField;
    qMainADVANCE_PAYMENT: TFloatField;
    qMainOPERATOR_NAME: TStringField;
    qMainPHONE_NUMBER_TYPE_NAME: TStringField;
    qIsActive: TOraQuery;
    qMainIS_ACTIVE_NAME: TStringField;
    qPhoneNumberTypes: TOraQuery;
    qMainDAYLY_PAYMENT: TFloatField;
    qMainDAYLY_PAYMENT_LOCKED: TFloatField;
    qMainMONTHLY_PAYMENT: TFloatField;
    qMainMONTHLY_PAYMENT_LOCKED: TFloatField;
    qMainCALC_KOEFF: TFloatField;
    qMainFREE_MONTH_MINUTES_CNT_FOR_RPT: TIntegerField;
    qMainBALANCE_BLOCK: TFloatField;
    qMainBALANCE_UNBLOCK: TFloatField;
    qMainBALANCE_NOTICE: TFloatField;
    qMainTARIFF_ADD_COST: TFloatField;
    qMainBALANCE_BLOCK_CREDIT: TFloatField;
    qMainBALANCE_UNBLOCK_CREDIT: TFloatField;
    qMainBALANCE_NOTICE_CREDIT: TFloatField;
    qMainTARIFF_CODE_CRM: TStringField;
    qMainTARIFF_PRIORITY: TFloatField;
    qMainFILIAL_ID: TFloatField;
    qFilials: TOraTable;
    qMainFILIAL_NAME: TStringField;
    ToolButton9: TToolButton;
    qMainOPERATOR_MONTHLY_ABON_ACTIV: TFloatField;
    qMainOPERATOR_MONTHLY_ABON_BLOCK: TFloatField;
    qMainCALC_KOEFF_DETAL: TFloatField;
    act1: TAction;
    btnRecalcBalUnblock: TToolButton;
    spRecalcTarifBalUblck: TOraStoredProc;
    aExtEdit: TAction;
    N7: TMenuItem;
    H1: TMenuItem;
    qMainTRAFFIC_NOT_IGNOR_FOR_INACTIVE: TFloatField;
    qTRAFFICNOTIGNOR4INACTIVE: TOraQuery;
    qMainTrafNotIgnor4InactName: TStringField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure btnRecalcBalUnblockClick(Sender: TObject);
    procedure aExtEditExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Main, IntecExportGrid, CRStrUtils,RefTariff_option;

{$R *.dfm}

procedure TRefTariffsForm.aExtEditExecute(Sender: TObject);
Var
FTarOpts: TTariff_option;
begin
 FTarOpts:= TTariff_option.Create(self);
 FTarOpts.Caption:='�������������� ������ '+qmain.FieldByName('TARIFF_CODE').AsString+' � ��������� �����';
 FTarOpts.STariffID:=qmain.FieldByName('TARIFF_ID').AsString;
 FTarOpts.ShowModal;
end;

procedure TRefTariffsForm.btnRecalcBalUnblockClick(Sender: TObject);
begin
  inherited;
  try
    spRecalcTarifBalUblck.ExecProc;
  Except
    ShowMessage('������ ��� ��������� ������� �������������.');
  end;
  ShowMessage('������ ������������� ���������� �������.');
  aRefreshExecute(self);
end;

procedure TRefTariffsForm.FormShow(Sender: TObject);
var i:integer;
begin
  inherited;
  if (GetConstantValue('SERVER_NAME')<>'CORP_MOBILE') then  begin
    btnRecalcBalUnblock.Visible:=false;
    aExtEdit.Visible:=false;
  end;

  if MainForm.FUseFilialBlockAccess then
    qMain.SQL.Append('    WHERE TARIFFS.FILIAL_ID = ' + IntToStr(MainForm.FFilial));

  for i:=0 to CRDBGrid1.Columns.Count-1 do
  begin

    if CRDBGrid1.Columns[i].FieldName='FILIAL_ID' then
      if (GetConstantValue('USE_FILIAL_BLOCK_ACCESS')='1') then
       CRDBGrid1.Columns[i].Visible:=true
      else
        CRDBGrid1.Columns[i].Visible:=false;
    if CRDBGrid1.Columns[i].FieldName='TARIFF_ADD_COST' then
      if (GetConstantValue('SHOW_TARIFFS_ADD_COST')='1') then
        CRDBGrid1.Columns[i].Visible:=true
      else
        CRDBGrid1.Columns[i].Visible:=false;
    if CRDBGrid1.Columns[i].FieldName='TARIFF_CODE_CRM' then
      if (GetConstantValue('SERVER_NAME')='GSM_CORP') then
      begin
        CRDBGrid1.Columns[i].Visible:=true;
        CRDBGrid1.Columns[i].Title.Caption:='GUID';
      end else
      if (GetConstantValue('SERVER_NAME')='CORP_MOBILE') then
        CRDBGrid1.Columns[i].Visible:=true
         else
        CRDBGrid1.Columns[i].Visible:=false;
    if (CRDBGrid1.Columns[i].FieldName='BALANCE_NOTICE_CREDIT')
        or (CRDBGrid1.Columns[i].FieldName='BALANCE_BLOCK_CREDIT')
        or (CRDBGrid1.Columns[i].FieldName='BALANCE_UNBLOCK_CREDIT') then
      if (GetConstantValue('CREDIT_SYSTEM_ENABLE')='1') then
        CRDBGrid1.Columns[i].Visible:=true
      else
        CRDBGrid1.Columns[i].Visible:=false;
        {if CRDBGrid1.Columns[i].FieldName='CALC_KOEFF_DETAL' then
     CRDBGrid1.Columns[i].Visible:=true ;   }
  end;

  for i:=0 to CRDBGrid1.Columns.Count-1 do
  begin
   if CRDBGrid1.Columns[i].FieldName='CALC_KOEFF_DETAL' then
          if (GetConstantValue('SERVER_NAME')='CORP_MOBILE') then
        CRDBGrid1.Columns[i].Visible:=true
         else
        CRDBGrid1.Columns[i].Visible:=false;
  end;

  //����������/�������� ������� �� ����� ������ ��� ������������
  if (GetConstantValue('USE_TRAF_NOT_IGNOR_FOR_INACT') = '1') then
    VisibleColumnByFieldName(CRDBGrid1, qMainTrafNotIgnor4InactName.FieldName, true)
  else
    VisibleColumnByFieldName(CRDBGrid1, qMainTrafNotIgnor4InactName.FieldName, false);
end;

procedure TRefTariffsForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('OPERATOR_ID').IsNull then
  begin
    MessageDlg('�������� ������ ���� ������', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('TARIFF_NAME').IsNull then
  begin
    MessageDlg('������������ ��������� ����� ������ ���� ���������', mtError, [mbOK], 0);
    Abort;
  end;
  //
  if qMain.FieldByName('IS_ACTIVE').IsNull then
    qMain.FieldByName('IS_ACTIVE').Value := 1;
  if qMain.FieldByName('PHONE_NUMBER_TYPE').IsNull then
    qMain.FieldByName('PHONE_NUMBER_TYPE').Value := 0; // �����������
  inherited;
end;

procedure TRefTariffsForm.ToolButton9Click(Sender: TObject);
var cr : TCursor;
begin
  inherited;
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('������ �������','',
      CRDBGrid1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

end.
