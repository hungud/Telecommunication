
  CREATE OR REPLACE FUNCTION "LONTANA"."MSISDN_REFRESH_UPD" (
  MSISDNs IN VARCHAR2,
  typeru in number
  ) RETURN NUMBER IS
  RES number(1);
--#Version=1
BEGIN
  case typeru
    when 3 then
      begin
        delete MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs
        and mr.typer=1;
        commit;
        res:=0;
      end;
    when 4 then
      begin
        select count(*) into res from MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs;
        if res>0 then
          res:=0;
        else
          res:=1;
        end if;
      end;
      when 5 then
      begin
        delete MSISDN_REFRESH mr
        where mr.msisdn=MSISDNs;
        commit;
        res:=0;
      end;
    else
      begin
        insert into MSISDN_REFRESH values(MSISDNs,typeru);
        commit;
        res:=0;
      end;
  end case;
  RETURN RES;
EXCEPTION WHEN others THEN
  return 1;
END;