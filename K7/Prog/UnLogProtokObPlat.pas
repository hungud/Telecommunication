unit UnLogProtokObPlat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, CRGrid,
  MemDS, DBAccess, Ora;

type
  TFrmLogProtokObPlat = class(TForm)
    qLogObPlat: TOraQuery;
    dsLogObPlat: TDataSource;
    gPromisedPayments: TCRDBGrid;
    qLogObPlatPAYMENT_DATE: TDateTimeField;
    qLogObPlatPAYMENT_SUM: TCurrencyField;
    qLogObPlatPAYMENT_NUMBER: TStringField;
    qLogObPlatPAYMENT_STATUS_TEXT: TStringField;
    qLogObPlatCOMM_TXT: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    FMnPhoneNumber: String;
  end;

var
  FrmLogProtokObPlat: TFrmLogProtokObPlat;

implementation

{$R *.dfm}

procedure TFrmLogProtokObPlat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin  //
  qLogObPlat.Close;
end;

procedure TFrmLogProtokObPlat.FormShow(Sender: TObject);
begin //
  qLogObPlat.Close;
  qLogObPlat.ParamByName('p_phone_number').AsString := FMnPhoneNumber ;
  qLogObPlat.Open;
  qLogObPlat.First;
end;

end.
