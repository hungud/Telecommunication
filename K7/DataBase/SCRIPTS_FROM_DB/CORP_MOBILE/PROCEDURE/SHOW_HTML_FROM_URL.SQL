
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."SHOW_HTML_FROM_URL" (p_url  IN  VARCHAR2) AS
  l_http_request   UTL_HTTP.req;
  l_http_response  UTL_HTTP.resp;
  l_text           VARCHAR2(32767);
BEGIN
  -- Make a HTTP request and get the response.
  l_http_request  := UTL_HTTP.begin_request(p_url);
  l_http_response := UTL_HTTP.get_response(l_http_request);

  -- Loop through the response.
  BEGIN
    LOOP
      UTL_HTTP.read_text(l_http_response, l_text, 32766);
      DBMS_OUTPUT.put_line (l_text);
    END LOOP;
  EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response(l_http_response);
  END;
EXCEPTION
  WHEN OTHERS THEN
    UTL_HTTP.end_response(l_http_response);
    RAISE;
END show_html_from_url;
