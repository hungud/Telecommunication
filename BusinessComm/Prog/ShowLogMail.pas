unit ShowLogMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, udm, Func_Const,
  TimedMsgBox,  ShellAPI, CRGrid, Vcl.Grids, Vcl.DBGrids;
type
  TShowLogMailFrm = class(TChildForm)
    LoaderLog: TOraQuery;
    dsLoaderLog: TDataSource;
    sPanel1: TsPanel;
    sBsave: TsBitBtn;
    sBClose: TsBitBtn;
    LoaderLogVIRTUAL_ACCOUNTS_ID: TFloatField;
    LoaderLogVIRTUAL_ACCOUNTS_NAME: TStringField;
    LoaderLogINN: TStringField;
    LoaderLogDATE_SEND: TDateTimeField;
    LoaderLogYEAR_MONTH_NAME: TStringField;
    LoaderLogDELIVERED: TStringField;
    LoaderLogERROR: TStringField;
    qBlob: TOraQuery;
    cRGrid: TCRDBGrid;
    qBlobBODY_MAIL: TBlobField;
    LoaderLogEMAIL: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure sBCloseClick(Sender: TObject);
    procedure cRGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fYear_month : Integer;
    procedure SetYear_month(aValue : Integer);
  public
    { Public declarations }
  published
     property Year_month : Integer read fYear_month write SetYear_month;
  end;

var
  ShowLogMailFrm: TShowLogMailFrm;

implementation

{$R *.dfm}

procedure TShowLogMailFrm.sBCloseClick(Sender: TObject);
var
  filtr_old, def_ext : string;
begin
  inherited;
    filtr_old :=  dm.dlgSave.Filter;
    def_ext := dm.dlgSave.DefaultExt;
    dm.dlgSave.DefaultExt := 'pdf';
    dm.dlgSave.Filter := 'Файлы (*.pdf)|*.pdf|Все файлы|*.*';
    dm.dlgSave.FileName := LoaderLog.FieldByName('VIRTUAL_ACCOUNTS_ID').AsString + '.pdf';
  if dm.dlgSave.Execute then
  begin
    try
      qBlob.Close;
      qBlob.ParamByName('VIRTUAL_ACCOUNTS_ID').AsInteger := LoaderLog.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
      qBlob.Open;
      if qBlob.IsEmpty then
      begin
        TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
      end
      else
      begin
        SaveBlobFile('', dm.dlgSave.FileName, qBlob, qBlob.FieldByName('BODY_MAIL'));
        ShellExecute(0, 'open', PCHAR(dm.dlgSave.FileName), nil, nil, SW_SHOWNORMAL);
      end;
    except
      TimedMessageBox('Не удалось получить данные с базы. Попробуйте еще раз чуть позже!', 'Произошла ошибка!', mtError, [mbOK], mbOK, 25, 3);
    end;
  end;
    dm.dlgSave.DefaultExt := def_ext;
    dm.dlgSave.Filter := filtr_old;

end;

procedure TShowLogMailFrm.SetYear_month(aValue : Integer);
begin
  if aValue <> fYear_month then
  begin
    LoaderLog.Close;
    LoaderLog.ParamByName('YEAR_MONTH').AsInteger := aValue;
    LoaderLog.Open;
    fYear_month := aValue;
    sBClose.Enabled := not LoaderLog.IsEmpty;
  end;
end;

procedure TShowLogMailFrm.cRGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
   if Length(cRGrid.DataSource.DataSet.FieldByName('ERROR').AsString) >  0 then
   begin
    cRGrid.Canvas.Brush.Color := clRed;
    cRGrid.Canvas.Font.Color := clYellow;
   end;
  cRGrid.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TShowLogMailFrm.FormCreate(Sender: TObject);
var
  st : string;
begin
  inherited;
  ReadIniAny(Dm.FileNameIni, Caption, TDBGrid(CRGrid).Columns[0].FieldName, st);
  if (st <> '') then
  begin
    FitGrid(TDBGrid(CRGrid), Dm.FileNameIni, Caption);
  end;
end;

procedure TShowLogMailFrm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to CRGrid.Columns.Count - 1 do
  begin
    WriteIniAny(Dm.FileNameIni, Caption, CRGrid.Columns[i].FieldName, IntToStr(CRGrid.Columns[i].Width));
  end;
end;

end.
