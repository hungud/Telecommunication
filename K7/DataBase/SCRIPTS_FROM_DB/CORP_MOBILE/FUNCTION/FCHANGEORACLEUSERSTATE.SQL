
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."FCHANGEORACLEUSERSTATE" (AuthID in varchar2
                                                , event in number default 0)
                                                return varchar2 is
sqlstr varchar2(500);
begin
    if event>0 then sqlstr:='ALTER USER '||authid||' ACCOUNT UNLOCK';
    else sqlstr:='ALTER USER '||authid||' ACCOUNT LOCK';end if;
    Execute immediate sqlstr;
    return('OK');
    exception
    when others then return('Ошибка! '||chr(13)||sqlerrm);
end FChangeOracleUserState;

