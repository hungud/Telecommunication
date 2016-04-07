
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."GET_LAST_RD_UPDATE" (pphone_number in varchar2) return date is
            Result date; --дата последнего обновления опций
          begin
            select max(po.date_last_update) into result
            from db_loader_report_data po
            where po.phone_number=pphone_number and po.year_month=to_char(sysdate,'YYYYMM');
            return(result);
          exception
            when others then
            return(Result);
          end get_last_RD_update;

