unit ReportBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ActnList, Data.DB, MemDS, DBAccess, Ora, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TReportBlocksForm = class(TForm)
    pButtons: TPanel;
    btRefresh: TBitBtn;
    btLoadInExcel: TBitBtn;
    dsReport: TDataSource;
    qReport: TOraQuery;
    aList: TActionList;
    aRefresh: TAction;
    aLoadInExcel: TAction;
    gReport: TCRDBGrid;
    bShowUserStatInfo: TBitBtn;
    aShowUserStatInfo: TAction;
    procedure aRefreshExecute(Sender: TObject);
    procedure aLoadInExcelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure aShowUserStatInfoExecute(Sender: TObject);
  private
    //procedure SetSqlText;
  public
    { Public declarations }
  end;

procedure DoReportBlocks;

implementation

{$R *.dfm}

Uses IntecExportGrid, ShowUserStat;

{
procedure TReportBlocksForm.SetSqlText;
begin

{
   отчет по ручной отложенной блокировке
phone_number - номер                                            --
block_date_time - дата установлени€ ручной блокировки           --
user_name - пользователь, установивший дату ручной блокировки   --
date_unlock - дата отключени€ ручной блокировки
user_unlock - пользователь , отключивший ручную блокировку
ballance - баланс на момент установлени€ ручной  блокировки       --
ballanceBlock - баланс на момент отключени€ ручной блокировки
ballance_Warn - баланс предупреждени€
block_balance -- баланс блокировки


  qReport.SQL.Text := 'select a.phone_number,  '    //  номер
                    +' a.ballance,  '               //  баланс на момент установлени€ ручной  блокировки
                    +' a.block_date_time,  '        //  дата установлени€ ручной блокировки

                    +'  nvl(( select sh.update_user from SH_CONTRACTS sh '
                    +'          where sh.contract_id=t.contract_id and   '
                    +'                SH.update_time = a.block_date_time and   '
                    +'                SH.DATE_CREATED=( select min(SH1.DATE_CREATED) from SH_CONTRACTS sh1 '
                    +'                                  where sh1.contract_id=t.contract_id and            '
                    +'                                  SH1.HAND_BLOCK_DATE_END = t.HAND_BLOCK_DATE_END    '
                    +'                                ) and rownum <=1   '
                    +'      ),  t.user_last_updated   '
                    +'     ) as user_name, '

                    +' nvl(t.BALANCE_NOTICE_HAND_BLOCK,0) as BALANCE_NOTICE_HAND_BLOCK , '
                    +' (select u.BALLANCE from AUTO_UNBLOCKED_PHONE u  '
                    +'   where rownum<=1 and u.phone_number=t.phone_number_federal and '
                    +'   (u.unblock_date_time) in                              '
                    +'       (select max(u1.unblock_date_time)                 '
                    +'         from  AUTO_UNBLOCKED_PHONE u1                   '
                    +'         where u1.phone_number=t.phone_number_federal    '
                    +'           and u1.unblock_date_time>= a.block_date_time) '
                    +'   )      as ballance_unlock,                            '
                    +' (select u.unblock_date_time from AUTO_UNBLOCKED_PHONE u '
                    +'   where rownum=1 and u.phone_number=t.phone_number_federal and '
                    +'   (u.unblock_date_time) in                              '
                    +'       (select max(u1.unblock_date_time)                 '
                    +'         from  AUTO_UNBLOCKED_PHONE u1                   '
                    +'         where u1.phone_number=t.phone_number_federal    '
                    +'           and u1.unblock_date_time>= a.block_date_time) '
                    +'   )      as unblock_date_time, '

                    +'  nvl(( select sh.update_user from SH_CONTRACTS sh  '
                    +'          where sh.contract_id=t.contract_id and    '
                    +'                SH.HAND_BLOCK_DATE_END = t.HAND_BLOCK_DATE_END and    '
                    +'                SH.DATE_CREATED=( select min(SH1.DATE_CREATED) from SH_CONTRACTS sh1   '
                    +'                                  where sh1.contract_id=t.contract_id and              '
                    +'                                  SH1.HAND_BLOCK_DATE_END = t.HAND_BLOCK_DATE_END      '
                    +'                                ) and rownum <=1   '
                    +'      ),t.user_last_updated '
                    +'     ) as unblock_user_name, '

                    +' t.BALANCE_NOTICE_HAND_BLOCK, '
                    +'  NVL(CASE WHEN NVL(t.IS_CREDIT_CONTRACT, 0)=1 THEN ac.BALANCE_BLOCK_CREDIT '
                    +'           ELSE ac.BALANCE_BLOCK END, 0) + NVL(t.DISCONNECT_LIMIT, 0) block_balance '
                //    +' a.abonent_fio '              //
                //    +' /*,hand_block_date_end, decode(t.hand_block,1,''ƒа'',0,''Ќет'') hand_block  */ '
                    +' from CONTRACTS t, AUTO_BLOCKED_PHONE a, ACCOUNTS ac '
                    +' where nvl(t.hand_block,0)=1                         '
                    +' and ac.account_id=(SELECT da.account_id            '
                    +'   FROM db_loader_account_phones da                  '
                    +'   WHERE da.phone_number = t.phone_number_federal    '
                    +'     AND ROWNUM<=1                                   '
                    +'     AND (da.year_month =                            '
                    +'            ( SELECT MAX (t2.year_month)                 '
                    +'              FROM db_loader_account_phones t2         '
                    +'              WHERE t2.phone_number = da.phone_number) '
                    +'         ) ) '
                    +' and t.phone_number_federal = a.phone_number '
                    +' and a.block_date_time in  '
                    +'                     (select max(a1.block_date_time) '
                    +'                      from AUTO_BLOCKED_PHONE a1 where a1.phone_number=a.phone_number ) '
                    +' and t.contract_date in (select max(t1.contract_date) from CONTRACTS t1 '
                    +'                          where t1.phone_number_federal=t.phone_number_federal) '
                    +' and a.abonent_fio is not null and a.user_name is not null '  // and t.contract_id in (66158)
                    +' order by a.block_date_time ';
end;
}
procedure DoReportBlocks;
var
  ReportBlocksForm: TReportBlocksForm;
begin // запуск отчета
  ReportBlocksForm:=TReportBlocksForm.Create(Nil);
  try
    //ReportBlocksForm.SetSqlText;
    ReportBlocksForm.ShowModal;
  finally
    ReportBlocksForm.Free;
  end;
end;

procedure TReportBlocksForm.aLoadInExcelExecute(Sender: TObject);
var cr : TCursor;
begin    // ¬ыгрузить в Excel
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel('ќтчет по отложенной блокировке.','', gReport, False);
  finally
    Screen.Cursor := cr;
  end;
end;
procedure TReportBlocksForm.aRefreshExecute(Sender: TObject);
var cr : TCursor;
begin  // ќбновить
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    qReport.Close;
    qReport.Open;
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportBlocksForm.FormActivate(Sender: TObject);
begin
  aRefreshExecute(Self);
end;

procedure TReportBlocksForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qReport.Close;
end;

procedure TReportBlocksForm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qReport.Active and (qReport.RecordCount > 0) then
    ShowUserStatByPhoneNumber(qReport.FieldByName('PHONE_NUMBER').AsString, 0);
end;

end.
