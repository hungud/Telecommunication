unit ShowDetalAPI;
// #2885
// Кочнев Е. 26.05.2015
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  OraCall, Data.DB, DBAccess, Ora, MemDS, ContractsRegistration_Utils,
  Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls, sPanel, Vcl.Grids,
  Vcl.DBGrids, CRGrid, Vcl.ActnList, Vcl.ImgList, IntecExportGrid, Vcl.Menus;

type
  TShowDetalAPIForm = class(TForm)
    sPanel3: TsPanel;
    sBitBtn1: TsBitBtn;
    sBitBtn2: TsBitBtn;
    CRDBGrid1: TCRDBGrid;
    MainQuery: TOraQuery;
    MainQueryCALLDATE: TStringField;
    MainQueryCALLNUMBER: TStringField;
    MainQueryCALLTONUMBER: TStringField;
    MainQuerySERVICENAME: TStringField;
    MainQueryCALLTYPE: TStringField;
    MainQueryDATAVOLUME: TStringField;
    MainQueryCALLAMT: TFloatField;
    MainQueryCALLDURATION: TStringField;
    odsMainQuery: TOraDataSource;
    Panel1: TPanel;
    ImageList2: TImageList;
    ActionList1: TActionList;
    aToExcel: TAction;
    aExit: TAction;
    PopupMenu1: TPopupMenu;
    Excel1: TMenuItem;
    N1: TMenuItem;
    MainQueryCALLDURATION_OLD: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aToExcelExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    myOraSession: TOraSession;
    FPhoneNumber: string;

  public
    { Public declarations }
  constructor Create(AOwner : TComponent; oss: TOraSession; PhoneNumber: String); overload;

  end;

var
  ShowDetalAPIForm: TShowDetalAPIForm;

implementation

{$R *.dfm}

procedure TShowDetalAPIForm.aExitExecute(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TShowDetalAPIForm.aToExcelExecute(Sender: TObject);
var
    cr : TCursor;
    ACaption : String;
    ANameFile : string;
begin
    cr := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    ACaption := 'Необилинная детализация по номеру ' + FPhoneNumber;
    ANameFile:= FPhoneNumber + '_Detail_' + DateToStr(now);
    try
      ExportDBGridToExcel(ACaption,ANameFile, CRDBGrid1, False, True);
    finally
      Screen.Cursor := cr;
    end;

end;

constructor TShowDetalAPIForm.Create(AOwner : TComponent; oss: TOraSession; PhoneNumber: String);
begin
  inherited Create(AOwner);
  myOraSession := oss;
  FPhoneNumber := PhoneNumber;
end;

procedure TShowDetalAPIForm.FormCreate(Sender: TObject);
begin
  Visible := false;
  caption := caption + FPhoneNumber;
  MainQuery.Session := myOraSession;
  MainQuery.params.ParamByName('q_num').Value := FPhoneNumber;
  MainQuery.Open;
  if MainQuery.IsEmpty then
  begin
    CRDBGrid1.Align := alNone;
    CRDBGrid1.Visible := false;
    Panel1.Caption := 'По номеру - ' + FPhoneNumber + ' нет данных.';
    Panel1.align := alClient;
    Panel1.Visible := true;
    aToExcel.Enabled := false;

  end;

end;

procedure TShowDetalAPIForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    aExit.Execute;
end;

end.
