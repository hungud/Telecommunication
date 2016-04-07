unit CorpPortalJournal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, MemDS, DBAccess, Ora, GridsEh, DBGridEh,
  StdCtrls, Buttons, sBitBtn, ExtCtrls, sPanel, sLabel, Mask, sMaskEdit,
  sCustomComboEdit, sTooledit;

type
  TCorpPortalJournalForm = class(TForm)
    grMain: TDBGridEh;
    dsMain: TDataSource;
    qMain: TOraQuery;
    sPanel1: TsPanel;
    sBitBtn1: TsBitBtn;
    sDateEdit1: TsDateEdit;
    sDateEdit2: TsDateEdit;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    qMainRESULTAT: TStringField;
    qMainACCOUNT_FROM: TFloatField;
    qMainACCOUNT_TO: TFloatField;
    qMainTRANSFER_SUM: TFloatField;
    qMainDATE_BEGIN: TDateTimeField;
    qMainDATE_END: TDateTimeField;
    qMainUSER_LAST_UPDATED: TStringField;
    qMainTRANSFERED_SUM: TFloatField;
    qMainNEW_TRANS_SUM: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sDateEdit1Change(Sender: TObject);
    procedure sDateEdit2Change(Sender: TObject);
    procedure grMainGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    procedure GetData;
    procedure Refresh;
  public
    { Public declarations }
  end;

var
  CorpPortalJournalForm: TCorpPortalJournalForm;

implementation

{$R *.dfm}

uses IntecExportGrid;

procedure TCorpPortalJournalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qMain.Close;
end;

procedure TCorpPortalJournalForm.GetData;
begin
  qMain.ParamByName('BEGIN').AsDateTime:=StrToDate(sDateEdit1.Text);
  qMain.ParamByName('END').AsDateTime:=StrToDate(sDateEdit2.Text);
end;

procedure TCorpPortalJournalForm.grMainGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if Column.Field.FieldName='RESULTAT' then
    if qMainRESULTAT.AsString='Перевод успешно выполнен' then AFont.Color:=clGreen
    else
      if Pos('Переведен остаток:', qMainRESULTAT.AsString)>0
      then AFont.Color:=clBlue
      else AFont.Color:=clRed;
end;

procedure TCorpPortalJournalForm.Refresh;
begin
  qMain.Close;
  qMain.Open;
end;

procedure TCorpPortalJournalForm.FormShow(Sender: TObject);
begin
  sDateEdit1.Text:=DateToStr(Date);
  sDateEdit2.Text:=DateToStr(Date);
  Refresh;
end;

procedure TCorpPortalJournalForm.sBitBtn1Click(Sender: TObject);
begin
  Enabled := false;
  Screen.Cursor := crHourGlass;
  qMain.DisableControls;
  try
    ExportDBGridEhToExcel(Caption, grMain, false);
    Enabled := true;
    Application.MessageBox('Выгрузка в Excel завершена!', 'Уведомление',
      MB_OK + MB_ICONEXCLAMATION);
  finally
    Enabled := true;
    qMain.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCorpPortalJournalForm.sDateEdit1Change(Sender: TObject);
begin
  GetData;
  Refresh;
end;

procedure TCorpPortalJournalForm.sDateEdit2Change(Sender: TObject);
begin
  GetData;
  Refresh;
end;

end.
