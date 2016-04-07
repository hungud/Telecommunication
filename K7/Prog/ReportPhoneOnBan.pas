unit ReportPhoneOnBan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemplateFrm, Data.DB, Ora, Vcl.ActnList,
  Vcl.Menus, MemDS, DBAccess, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.CheckLst, aceCheckComboBox,
  Vcl.Buttons;

type
  TBeelineLoaderForm = class(TForm)
    GridBeelineLoader: TCRDBGrid;
    qBeeline_Loader_Inf: TOraQuery;
    dsBeeline: TDataSource;
    spBANS_AND_PHONE_STATUS: TOraStoredProc;
    PopupMenuOnGread: TPopupMenu;
    menuItemExcel: TMenuItem;
    rgSelectedType: TRadioGroup;
    pSettings: TPanel;
    qAccounts: TOraQuery;
    pAccounts: TPanel;
    btCheckAll: TButton;
    btUnCheckAll: TButton;
    btRefreshData: TBitBtn;
    procedure menuItemExcelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCheckAllClick(Sender: TObject);
    procedure btUnCheckAllClick(Sender: TObject);
    procedure btRefreshDataClick(Sender: TObject);

  private
    chcbAccountList : TacCheckComboBox;
    procedure SetItemsState (State : Boolean);
  public
    procedure Execute (Session : TOraSession);
  end;

const
  MainSQLText = 'SELECT ACCOUNTS.ACCOUNT_NUMBER, ' + #13#10+
                '  BEELINE_LOADER_INF.PHONE_NUMBER, ' + #13#10+
                '   BEELINE_LOADER_INF.OBJ_ID, ' + #13#10+
                '   BEELINE_LOADER_INF.BAN ' + #13#10+
                '   FROM BEELINE_LOADER_INF, ACCOUNTS ' + #13#10+
                '   where ' + #13#10+
                '      BEELINE_LOADER_INF.ACCOUNT_ID= ACCOUNTS.ACCOUNT_ID and ' + #13#10+
                '      ( ' + #13#10+
                '          (:IS_COLLECTOR IS NULL) OR --выбираем все счета ' + #13#10+
                '          (ACCOUNTS.IS_COLLECTOR = :IS_COLLECTOR) OR --выбираем только коллектор ' + #13#10+
                '          (:IS_COLLECTOR IS NOT NULL AND :IS_COLLECTOR <> 1) --выбираем все без коллеткора ' + #13#10+
                '      ) ';


var
  BeelineLoaderForm: TBeelineLoaderForm;

implementation

{$R *.dfm}

uses ExportGridToExcelPDF;



procedure TBeelineLoaderForm.btCheckAllClick(Sender: TObject);
begin
  SetItemsState(True);
  chcbAccountList.Text := 'Все счета';
end;

procedure TBeelineLoaderForm.btRefreshDataClick(Sender: TObject);
var
  CheckedItemCount : Integer;
  strCheckedAccountId : String;
  i: Integer;
begin
  qBeeline_Loader_Inf.Close;
  if chcbAccountList.Text <> '' then
  begin
    qBeeline_Loader_Inf.SQL.Text := MainSQLText;
    case rgSelectedType.ItemIndex of
      0 : qBeeline_Loader_Inf.ParamByName('IS_COLLECTOR').Value := null;
      1 : qBeeline_Loader_Inf.ParamByName('IS_COLLECTOR').Value := 0;
      2 : qBeeline_Loader_Inf.ParamByName('IS_COLLECTOR').Value := 1;
    end;

    strCheckedAccountId := '';
    CheckedItemCount := 0;

    for i := 0 to chcbAccountList.Items.Count - 1 do
    begin
      if TCheckListItem(chcbAccountList.Items.Items[i]).Checked then
      begin
        strCheckedAccountId := strCheckedAccountId + IntToStr(Integer(TCheckListItem(chcbAccountList.Items.Items[i]).GetObject)) + ',';
        Inc(CheckedItemCount);
      end;
    end;
    strCheckedAccountId := Copy( strCheckedAccountId, 1, Length(strCheckedAccountId) - 1);

    if CheckedItemCount <> chcbAccountList.Items.Count  then
      qBeeline_Loader_Inf.SQL.Add('and BEELINE_LOADER_INF.ACCOUNT_ID in (' + strCheckedAccountId + ')');

    qBeeline_Loader_Inf.Open;
  end;
end;

procedure TBeelineLoaderForm.btUnCheckAllClick(Sender: TObject);
begin
  SetItemsState(False);
  chcbAccountList.Text := '';
end;

procedure TBeelineLoaderForm.Execute(Session: TOraSession);
var
  Item : TCheckListItem;
begin

  chcbAccountList := TacCheckComboBox.Create(nil);
  chcbAccountList.Align := alLeft;
  chcbAccountList.Height := rgSelectedType.Height;
  chcbAccountList.Width := 150;
  chcbAccountList.Visible := True;
  chcbAccountList.Parent := pAccounts;


  qAccounts.Session := Session;

  qAccounts.Open;
  qAccounts.First;
  while not qAccounts.Eof do
  begin
    Item := (chcbAccountList.Items.Add as TCheckListItem);
    Item.Caption := qAccounts.FieldByName('ACCOUNT_NUMBER').AsString;
    Item.AddObject(TObject(qAccounts.FieldByName('ACCOUNT_ID').AsInteger));
    qAccounts.Next;
  end;


  spBANS_AND_PHONE_STATUS.Session := Session;
  spBANS_AND_PHONE_STATUS.ExecProc;
  qBeeline_Loader_Inf.Session := Session;
  ShowModal;
end;

procedure TBeelineLoaderForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qBeeline_Loader_Inf.Close;
end;

procedure TBeelineLoaderForm.menuItemExcelClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGrid(Caption , '', '', GridBeelineLoader , True, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TBeelineLoaderForm.SetItemsState(State: Boolean);
var
  i : Integer;
begin
  for i := 0 to chcbAccountList.Items.Count - 1 do
    TCheckListItem(chcbAccountList.Items.Items[i]).Checked := State;
end;

end.
