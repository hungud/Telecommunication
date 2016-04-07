unit RefMailRecipients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefMailRecipientsFrm = class(TTemplateForm)
    qReportType: TOraQuery;
    qMainMAIL_ADRESS: TStringField;
    qMainTYPE_REPORT: TStringField;
    qMainREPORT_NAME: TStringField;
    procedure aRefreshExecute(Sender: TObject);
    procedure qMainBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefMailRecipientsFrm: TRefMailRecipientsFrm;

implementation

{$R *.dfm}

procedure TRefMailRecipientsFrm.aRefreshExecute(Sender: TObject);
begin
  qMain.Close;
  qMain.Open;
end;

procedure TRefMailRecipientsFrm.qMainBeforePost(DataSet: TDataSet);
begin
  if qMain.Active and (qMain.State in [dsInsert]) then
  begin
    //
  end;
end;

end.
