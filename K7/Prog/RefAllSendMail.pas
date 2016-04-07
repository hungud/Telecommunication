unit RefAllSendMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Buttons,ActnList;

type
  TRefAllSendMailForm = class(TForm)
    RGLoadLogTypes: TRadioGroup;
    CRDBGrid1: TCRDBGrid;
    DsRadioGroup: TOraDataSource;
    qLoadLogTypes: TOraQuery;
    qLogs: TOraQuery;
    DsLogs: TOraDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ActionList1: TActionList;
    aExcel: TAction;
    aRefresh: TAction;
    aShowUserStatInfo: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGLoadLogTypesClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefAllSendMailForm: TRefAllSendMailForm;

implementation

{$R *.dfm}

procedure TRefAllSendMailForm.BitBtn1Click(Sender: TObject);
begin
  qLogs.Close;
  qLogs.Open;
end;

procedure TRefAllSendMailForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRefAllSendMailForm.FormCreate(Sender: TObject);
begin
qLoadLogTypes.Open;
  DsRadioGroup.DataSet.First;
  while Not (DsRadioGroup.DataSet.Eof) do
  begin
    RGLoadLogTypes.Items.AddObject(
      qLoadLogTypes.FieldByName('LOAD_TYPE_NAME').AsString,
      TObject(qLoadLogTypes.FieldByName('LOAD_TYPE_ID').AsInteger)
      );
    DsRadioGroup.DataSet.next;
  end;
  qLoadLogTypes.Close;

end;

procedure TRefAllSendMailForm.FormShow(Sender: TObject);
begin
qLogs.Open;
end;

procedure TRefAllSendMailForm.RGLoadLogTypesClick(Sender: TObject);
var param: integer;
begin
inherited;
  qlogs.Close;
  param:=Integer(RGLoadLogTypes.Items.Objects[RGLoadLogTypes.ItemIndex]);
  qlogs.ParamByName('load_type_id').AsInteger:=param;
  qlogs.Open;


end;

end.
