unit RepPhoneWhisContract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  CRGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,IntecExportGrid;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure cbSearchClick(Sender: TObject);
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
var ReportFrm : TRepPhoneWhisContractfrm;

begin
   ReportFrm := TRepPhoneWhisContractfrm.Create(Nil);



end;

procedure TRepPhoneWhisContractfrm.BitBtn1Click(Sender: TObject);
var cr : TCursor;
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

procedure TRepPhoneWhisContractfrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TRepPhoneWhisContractfrm.PhoneWhisContractShow ;
begin

DM.qreport.Close;
 with DM.qreport do
              begin
                try
                  sql.Clear;

                  {sql.Add ('select a.PHONE_NUMBER_FEDERAL from v_contracts a ');
                  sql.Add (' where a.CONTRACT_CANCEL_DATE is null or a.CONTRACT_CANCEL_DATE>=trunc(sysdate)');}

                  sql.Add ('select t.PHONE_NUMBER_FEDERAL,CASE WHEN t.phone_is_active_code = 0 ');
                  sql.Add (' THEN CASE WHEN T.PHONE_CONSERVATION=1 THEN ''Сохр.'' ELSE ''Блок.'' END  ELSE ''Акт.'' ');
                  sql.Add(' END AS phone_is_active, T.status_date from (select c.PHONE_NUMBER_FEDERAL, ');
                  sql.Add(' (SELECT db_loader_account_phones.phone_is_active  FROM db_loader_account_phones');
                  sql.Add(' WHERE db_loader_account_phones.phone_number = c.phone_number_federal');
                  sql.Add('  AND ROWNUM<=1 AND (db_loader_account_phones.year_month =  ');
                  sql.Add('      (SELECT MAX (t2.year_month) ');
                  sql.Add('         FROM db_loader_account_phones t2 ');
                  sql.Add('         WHERE t2.phone_number = c.phone_number_federal))) AS phone_is_active_code,');
                  sql.Add('(SELECT db_loader_account_phones.CONSERVATION  ');
                  sql.Add('FROM db_loader_account_phones ');
                  sql.Add('WHERE db_loader_account_phones.phone_number = c.phone_number_federal ');
                  sql.Add('  AND ROWNUM<=1  ');
                  sql.Add(' AND (db_loader_account_phones.year_month = ');
                  sql.Add('     (SELECT MAX (t2.year_month) ');
                  sql.Add('        FROM db_loader_account_phones t2  ');
                  sql.Add('        WHERE t2.phone_number = c.phone_number_federal))) AS PHONE_CONSERVATION, ');
                  sql.Add('  (SELECT TRUNC (MAX (db_loader_account_phone_hists.begin_date)) ');
                  sql.Add(' FROM db_loader_account_phone_hists ');
                  sql.Add(' WHERE db_loader_account_phone_hists.phone_number = c.phone_number_federal) AS status_date ');
                  sql.Add(' from v_contracts c ');
                  sql.Add(' where c.CONTRACT_CANCEL_DATE is null or c.CONTRACT_CANCEL_DATE>=trunc(sysdate)) t ');

                       ExecSQL;
                        Open;
                       // MessageDlg('Текст запроса: '+sql.Text, mtError, [mbOK], 0);
                except
                  on e : exception do
                  MessageDlg('Ошибка выполнения запроса: '+sql.Text, mtError, [mbOK], 0);
                end;

              end;

 grData.Columns[0].Title.caption:='Номер телефона';
 grData.Columns[0].Width:=120;
 grData.Columns[1].Title.caption:='Статус телефона';
 grData.Columns[2].Title.caption:='Дата статуса телефона';
 grData.Columns[2].Width:=140;

end;



end.
