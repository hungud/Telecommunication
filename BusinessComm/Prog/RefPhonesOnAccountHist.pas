unit RefPhonesOnAccountHist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, sToolBar, uDm;

type
  TRefPhonesOnAccountHistForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefPhonesOnAccountHistForm: TRefPhonesOnAccountHistForm;

implementation

{$R *.dfm}

procedure TRefPhonesOnAccountHistForm.FormCreate(Sender: TObject);
begin
  qRef := Dm.qPhonForAccHist;
  inherited;

end;

end.
