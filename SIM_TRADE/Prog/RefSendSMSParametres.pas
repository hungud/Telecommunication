unit RefSendSMSParametres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Ora, MemDS, DBAccess, Grids, DBGrids, CRGrid, ComCtrls,
  ToolWin, ActnList;

type
  TRefProvidersFrm = class(TForm)
    DSProvider: TDataSource;
    qProvider: TOraQuery;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    RefSMSProviderGrid: TCRDBGrid;
    procedure FormShow(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    { Private declarations }
  public
    FRefForm: TRefProvidersFrm;
  end;

//var
//  RefProvidersFrm: TRefProvidersFrm;

implementation

{$R *.dfm}

procedure TRefProvidersFrm.aRefreshExecute(Sender: TObject);
begin
  qProvider.Close;
  qProvider.Open;
end;

procedure TRefProvidersFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRefProvidersFrm.FormShow(Sender: TObject);
begin
  if not Assigned(FRefForm) then
  begin
    FRefForm := TRefProvidersFrm.Create(Application);
    qProvider.Close;
    qProvider.Open;
    aRefresh.Execute;
  end;
end;

end.
