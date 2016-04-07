unit RepPhoneWhisContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  CRGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,IntecExportGrid, Data.DB,
  MemDS, DBAccess, Ora;

type
  TRepPhoneWhisContractfrm = class(TForm)
    Panel1: TPanel;
    cbSearch: TCheckBox;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    grData: TCRDBGrid;
    qreport: TOraQuery;
    qreportPHONE_NUMBER_FEDERAL: TStringField;
    qreportTARIFF_NAME: TStringField;
    qreportPHONE_IS_ACTIVE: TStringField;
    qreportOPTION_CODE: TStringField;
    qreportOPTION_NAME: TStringField;
    dsReport: TDataSource;
    qreportSTATUS: TStringField;
    qreportTURN_ON_DATE: TDateTimeField;
    qreportTURN_OFF_DATE: TDateTimeField;
    qreportCONTRACT_NUM: TFloatField;
    qreportTARIFF_CODE: TStringField;
    cbShowOpt: TComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
    procedure cbShowOptChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure PhoneWhisContractShow;
  end;

  procedure DoRepPhoneWhisContract;

var
  RepPhoneWhisContractfrm: TRepPhoneWhisContractfrm;

implementation

{$R *.dfm}

uses DMUnit,ShowUserStat;

procedure DoRepPhoneWhisContract;
var
  ReportFrm : TRepPhoneWhisContractfrm;
begin
  ReportFrm := TRepPhoneWhisContractfrm.Create(Nil);
end;

procedure TRepPhoneWhisContractfrm.BitBtn1Click(Sender: TObject);
var
  cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('Отчёт о телефонах (по действующим договорам) на дату ' + FormatDateTime('dd.mm.yyyy', Date()),'',
                        grData, False, True);
  finally
    Screen.Cursor := cr;
  end;

end;

procedure TRepPhoneWhisContractfrm.BitBtn2Click(Sender: TObject);
begin
  PhoneWhisContractShow;
end;

procedure TRepPhoneWhisContractfrm.BitBtn3Click(Sender: TObject);
begin
  if dm.qReport.Active and (dm.qReport.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(dm.qReport.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
  end;
end;

procedure TRepPhoneWhisContractfrm.cbSearchClick(Sender: TObject);
begin
  if cbSearch.Checked then
    GrData.OptionsEx:=GrData.OptionsEx+[dgeSearchBar]
  else
    GrData.OptionsEx:=GrData.OptionsEx-[dgeSearchBar];
end;

procedure TRepPhoneWhisContractfrm.cbShowOptChange(Sender: TObject);
begin
  PhoneWhisContractShow;
end;

procedure TRepPhoneWhisContractfrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRepPhoneWhisContractfrm.FormCreate(Sender: TObject);
begin
  PhoneWhisContractShow;
end;

procedure TRepPhoneWhisContractfrm.PhoneWhisContractShow;
begin
  qreport.Close;
  try
 // MessageDlg('Текст запроса: '+qreport.sql.Text, mtError, [mbOK], 0);
    qReport.ParamByName('SHOW_ACTIVE_OPT').Value := cbShowOpt.ItemIndex;
    qReport.Open;
  except
    on e : exception do
      MessageDlg('Ошибка выполнения запроса: '+qreport.sql.Text, mtError, [mbOK], 0);
  end;
end;
end.
