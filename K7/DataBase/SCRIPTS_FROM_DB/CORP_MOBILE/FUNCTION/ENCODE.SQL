
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."ENCODE" 
(str in varchar2) return varchar2 is
begin
return '=?utf-8?b?'||utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(convert(substr(str,1,24),'UTF8'))))
||'?='||case when substr(str,25) is not null then utl_tcp.crlf||' '||encode(substr(str,25)) end;
end;
