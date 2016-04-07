unit RefUnblockSaveSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sSplitter, Data.DB, MemDS,
  DBAccess, Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls;

type
  TRefUnblockSaveSettingsForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    sSplitter1: TsSplitter;
    Splitter1: TSplitter;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CRDBGrid1: TCRDBGrid;
    GroupBox2: TGroupBox;
    qTariffs: TOraQuery;
    dsTariffs: TDataSource;
    qTariffsTARIFF_ID: TFloatField;
    qTariffsTARIFF_CODE: TStringField;
    qTariffsTARIFF_NAME: TStringField;
    qTariffsACCESS_UNLOCK_SAVE: TIntegerField;
    CRDBGrid2: TCRDBGrid;
    GroupBox3: TGroupBox;
    qNumberBlockInSave: TOraQuery;
    dsNumberBlockInSave: TDataSource;
    qNumberBlockInSavePHONE_NUMBER: TStringField;
    spGetParamValue: TOraStoredProc;
    spSetParamValue: TOraStoredProc;
    procedure FormShow(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefUnblockSaveSettingsForm: TRefUnblockSaveSettingsForm;

implementation

{$R *.dfm}

procedure TRefUnblockSaveSettingsForm.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text <> spGetParamValue.ParamByName('RESULT').AsString then
  begin
    spSetParamValue.ParamByName('PARAM_VALUE').AsInteger:=StrToInt(Edit1.Text);
    spSetParamValue.ExecProc;
  end;
end;

procedure TRefUnblockSaveSettingsForm.FormShow(Sender: TObject);
begin
  qTariffs.Close;
  qTariffs.Open;
  qNumberBlockInSave.Close;
  qNumberBlockInSave.Open;
  spGetParamValue.ParamByName('PARAM_NAME').AsString:='DAYS_FOR_UNLOCK_SAVE';
  spGetParamValue.ExecProc;
  Edit1.Text:= spGetParamValue.ParamByName('RESULT').AsString;
  spSetParamValue.ParamByName('PARAM_NAME').AsString:='DAYS_FOR_UNLOCK_SAVE';
end;

end.
