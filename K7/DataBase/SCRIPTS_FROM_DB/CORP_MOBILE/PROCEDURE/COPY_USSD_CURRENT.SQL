
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."COPY_USSD_CURRENT" (pxcpaxaction in varchar2, presponset in varchar2) IS
BEGIN
 insert into test1_USSD_CURRENT
 select a.*/*, presponset*/ from USSD_CURRENT a where a.xcpaxaction=pxcpaxaction;
 commit;
END;
