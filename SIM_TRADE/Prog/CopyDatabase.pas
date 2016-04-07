unit CopyDatabase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBAccess, Ora, ActnList, Menus, DB, MemDS, Grids, DBGrids, CRGrid,
  ExtCtrls, ComCtrls, ToolWin;

type
  TRefCopyDataBaseForm = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    Panel2: TPanel;
    Splitter1: TSplitter;
    CRDBGrid1: TCRDBGrid;
    Panel3: TPanel;
    dgLoadingLogs: TCRDBGrid;
    qMain: TOraQuery;
    qMainACCOUNT_ID: TFloatField;
    qMainOPERATOR_ID: TFloatField;
    qMainACCOUNT_NUMBER: TFloatField;
    qMainLOGIN: TStringField;
    qMainPASSWORD: TStringField;
    qMainOPERATOR_NAME: TStringField;
    qMainDO_AUTO_LOAD_DATA: TIntegerField;
    qMainLOAD_INTERVAL: TFloatField;
    qMainPAY_LOAD_INTERVAL: TFloatField;
    qMainBALANCE_NOTICE_TEXT: TStringField;
    qMainBLOCK_NOTICE_TEXT: TStringField;
    qMainNEXT_MONTH_NOTICE_TEXT: TStringField;
    qMainLOAD_DETAIL_POOL_SIZE: TFloatField;
    qMainLOAD_DETAIL_THREAD_COUNT: TFloatField;
    qMainBALANCE_BLOCK: TFloatField;
    qMainDO_AUTO_BLOCK: TIntegerField;
    qMainBALANCE_NOTICE: TFloatField;
    qMainDO_BALANCE_NOTICE: TIntegerField;
    qMainDO_BALANCE_NOTICE_MONTH: TIntegerField;
    qMainBALANCE_NOTICE_END_MONTH: TFloatField;
    qMainBALANCE_NOTICE_CREDIT: TFloatField;
    qMainTEXT_NOTICE_BALANCE_CREDIT: TStringField;
    qMainBALANCE_BLOCK_CREDIT: TFloatField;
    qMainTEXT_NOTICE_BLOCK_CREDIT: TStringField;
    qMainBALANCE_NOTICE_MONTH_CREDIT: TFloatField;
    qMainTEXT_NOTICE_END_MONTH_CREDIT: TStringField;
    qMainDILER_PAYMETS: TFloatField;
    qMainUSER_CREATED: TStringField;
    qMainDATE_CREATED: TDateTimeField;
    qMainUSER_LAST_UPDATED: TStringField;
    qMainDATE_LAST_UPDATED: TDateTimeField;
    qMainNEXT_MONTH_NOTICE_BALANCE: TFloatField;
    qMainBALANCE_NOTICE2: TFloatField;
    qMainBALANCE_NOTICE_TEXT2: TStringField;
    qMainBALANCE_NOTICE_CREDIT2: TFloatField;
    qMainTEXT_NOTICE_BALANCE_CREDIT2: TStringField;
    qMainCOMPANY_NAME: TStringField;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ActionList1: TActionList;
    aInsert: TAction;
    aEdit: TAction;
    aDelete: TAction;
    aRefresh: TAction;
    aPost: TAction;
    aCancel: TAction;
    qGetNewId: TOraStoredProc;
    Panel4: TPanel;
    qLogs: TOraQuery;
    dsLogs: TDataSource;
    spLoadPayment: TOraStoredProc;
    qLoadLogTypes: TOraQuery;
    DsRadioGroup: TOraDataSource;
    spAllTurnOnOff: TOraStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefCopyDataBaseForm: TRefCopyDataBaseForm;

implementation

{$R *.dfm}

end.
