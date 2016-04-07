unit RefMailRecipients;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.ActnList,
  Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  VirtualTable, DBAccess, CRGrid,
  sToolBar, sBitBtn, Ora, MemDS, sPanel, RefFrm, DMUnit;

type
  TRefMailRecipientsFrm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefMailRecipientsFrm: TRefMailRecipientsFrm;

implementation

{$R *.dfm}

uses RefReportType;

procedure TRefMailRecipientsFrm.FormCreate(Sender: TObject);
begin
  GlQuery := dm.qMailRecipients;
  ListCls := TLCls.Create(TRefReportTypeFrm);
  inherited;
  CaptList.Add('Справочник типов отчетов');
end;

end.
