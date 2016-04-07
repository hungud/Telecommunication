unit MessageTexts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, StdCtrls, DBCtrls;

type
  TMessageTextsFrm = class(TForm)
    panel2:Tpanel;
    qMessageList: TOraQuery;
    DSMessageTexts: TDataSource;
    DBMemoNoticeMonth: TDBMemo;
    DBMemoNoticeBalance: TDBMemo;
    DBMemoNoticeBlock: TDBMemo;
    

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageTextsFrm: TMessageTextsFrm;

implementation

{$R *.dfm}




end.
