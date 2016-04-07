
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."GET_SEND_MAIL_PARAM" (vphone_number    in varchar2,
                                                vsmtp_server   out varchar2,
                                                vsmtp_port     out integer,
                                                vuser_login    out varchar2,
                                                vuser_password out varchar2,
                                                vsmtp_from out varchar2) IS

BEGIN
  select smp.smtp_server, smp.smtp_port, smp.user_login, smp.user_password,smp.smtp_from
    into vsmtp_server, vsmtp_port, vuser_login, vuser_password,vsmtp_from
    from SEND_MAIL_PARAM_BY_ACCOUNT smp
   where smp.account_id = get_account_id_by_phone(vphone_number);
exception
  when others then
    select smp.smtp_server,
           smp.smtp_port,
           smp.user_login,
           smp.user_password,
           smp.smtp_from
      into vsmtp_server, vsmtp_port, vuser_login, vuser_password,vsmtp_from
      from SEND_MAIL_PARAM_BY_ACCOUNT smp
     where smp.account_id = 0;
end;
