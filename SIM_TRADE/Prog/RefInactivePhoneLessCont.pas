unit RefInactivePhoneLessCont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, OraSmart, OraError,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TRefInactivePhoneLessContForm = class(TTemplateForm)
    qSystemBilling: TOraQuery;
    aUnLock: TAction;
    aLock: TAction;
    qMainPHONE_NUMBER: TStringField;
    qMainSIM_NUMBER: TStringField;
    qMainDATE_CREATED: TDateTimeField;
    qMainSYSTEM_BILLING: TFloatField;
    qMainDOP_INFO: TStringField;
    qMainMASK_BEAUTY_ID: TFloatField;
    qMainPATTERN: TStringField;
    qMainPRICE: TFloatField;
    qMainSYSTEM_PAID_NAME: TStringField;
    qMainPAID: TFloatField;
    OpenDialog: TOpenDialog;
    btLoad: TBitBtn;
    ToolButton9: TToolButton;
    btMask: TBitBtn;
    qMaskBeauty: TOraQuery;
    btExcel: TBitBtn;
    aExcel: TAction;
    qMainEXISTS_CONTRACT: TStringField;
    qMainINACTIVE_PHONE_ID: TFloatField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure btLoadClick(Sender: TObject);
    procedure btMaskClick(Sender: TObject);
    procedure CRDBGrid1GetCellParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; State: TGridDrawState;
      StateEx: TGridDrawStateEx);
    procedure aExcelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils,main, LoadInactivePhoneLessCont, RefMaskBeauty, IntecExportGrid;

procedure TRefInactivePhoneLessContForm.aExcelExecute(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Неактивные номера без контракта','',
      CRDBGrid1, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TRefInactivePhoneLessContForm.btLoadClick(Sender: TObject);
 var
 Frm:TLoadInactivePhoneLessContForm;
begin
  Frm := TLoadInactivePhoneLessContForm.Create(Application);
  Frm.ShowModal;
  qMain.Refresh;
end;

procedure TRefInactivePhoneLessContForm.btMaskClick(Sender: TObject);
 var
 Frm:TRefMaskBeautyForm;
begin
  Frm := TRefMaskBeautyForm.Create(Application);
  FRM.ShowModal;
  qMaskBeauty.Refresh;
end;

procedure TRefInactivePhoneLessContForm.CRDBGrid1GetCellParams(
  Sender: TObject; Field: TField; AFont: TFont; var Background: TColor;
  State: TGridDrawState; StateEx: TGridDrawStateEx);
begin
   //Подсветка систем оплаты
  if (Field.FieldName='SYSTEM_BILLING_NAME')and(Field.AsString='PREPAID')
  then AFont.Color := clRed;

end;

procedure TRefInactivePhoneLessContForm.qMainBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('PHONE_NUMBER').IsNull then
  begin
    MessageDlg('Номер должен быть заполнен', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('SIM_NUMBER').IsNull then
  begin
    MessageDlg('Номер сим должен быть заполнен!', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('PRICE').IsNull then
  begin
    MessageDlg('Стоимость должна быть заполнена!', mtError, [mbOK], 0);
    Abort;
  end
  else if DataSet.FieldByName('PAID').IsNull then
  begin
    MessageDlg('Поле "Платный" должно быть заполнено!', mtError, [mbOK], 0);
    Abort;
  end;

  inherited;
end;

end.
