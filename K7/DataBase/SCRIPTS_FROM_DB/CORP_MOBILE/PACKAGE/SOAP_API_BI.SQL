
  CREATE OR REPLACE PACKAGE "CORP_MOBILE"."SOAP_API_BI" AS
-- --------------------------------------------------------------------------
-- Name         : http://www.oracle-base.com/dba/miscellaneous/soap_api
-- Author       : DR Timothy S Hall
-- Description  : SOAP related functions for consuming web services.
-- Ammedments   :
--   When         Who       What
--   ===========  ========  =================================================
--   04-OCT-2003  Tim Hall  Initial Creation
--   23-FEB-2006  Tim Hall  Parameterized the "soap" envelope tags.
-- --------------------------------------------------------------------------
-- Modified: Dmitry Ukolov.
--   Added support arrays and large request and responses
--
TYPE t_request IS RECORD (
  method        VARCHAR2(256),
  namespace     VARCHAR2(256),
  body          CLOB,
  envelope_tag  VARCHAR2(30)
);

TYPE t_response IS RECORD
(
--  doc           XMLTYPE,
  data CLOB,
  --data           XMLTYPE,
  envelope_tag  VARCHAR2(30)
);

FUNCTION new_request(p_method        IN  VARCHAR2,
                     p_namespace     IN  VARCHAR2,
                     p_envelope_tag  IN  VARCHAR2 DEFAULT 'SOAP-ENV')
  RETURN t_request;


PROCEDURE add_parameter(p_request  IN OUT NOCOPY  t_request,
                        p_name     IN             VARCHAR2,
                        p_type     IN             VARCHAR2,
                        p_value    IN             VARCHAR2);

PROCEDURE add_parameter_array(p_request  IN OUT NOCOPY  t_request,
                        p_name     IN             VARCHAR2,
                        p_type     IN             VARCHAR2,
                        p_value    IN             DBMS_SQL.VARCHAR2_TABLE,
                        p_item_type IN            VARCHAR2
                        );

FUNCTION invoke(p_request  IN OUT NOCOPY  t_request,
                p_url      IN             VARCHAR2,
                p_action   IN             VARCHAR2)
  RETURN t_response;

FUNCTION get_return_value(p_response   IN OUT NOCOPY  t_response,
                          p_name       IN             VARCHAR2,
                          p_namespace  IN             VARCHAR2)
  RETURN CLOB;

END soap_api_bi;

CREATE OR REPLACE PACKAGE BODY "CORP_MOBILE"."SOAP_API_BI" AS
-- --------------------------------------------------------------------------
-- Name         : http://www.oracle-base.com/dba/miscellaneous/soap_api
-- Author       : DR Timothy S Hall
-- Description  : SOAP related functions for consuming web services.
-- Ammedments   :
--   When         Who       What
--   ===========  ========  =================================================
--   04-OCT-2003  Tim Hall  Initial Creation
--   23-FEB-2006  Tim Hall  Parameterized the "soap" envelope tags.
-- --------------------------------------------------------------------------



-- ---------------------------------------------------------------------
FUNCTION new_request(p_method        IN  VARCHAR2,
                     p_namespace     IN  VARCHAR2,
                     p_envelope_tag  IN  VARCHAR2 DEFAULT 'SOAP-ENV')
  RETURN t_request AS
-- ---------------------------------------------------------------------
  l_request  t_request;
BEGIN
  l_request.method       := p_method;
  l_request.namespace    := p_namespace;
  l_request.envelope_tag := p_envelope_tag;
  RETURN l_request;
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
PROCEDURE add_parameter(p_request    IN OUT NOCOPY  t_request,
                        p_name   IN             VARCHAR2,
                        p_type   IN             VARCHAR2,
                        p_value  IN             VARCHAR2) AS
-- ---------------------------------------------------------------------
BEGIN
  p_request.body := p_request.body||'<'||p_name||' type="xsd:'||p_type||'">'||p_value||'</'||p_name||'>';
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
PROCEDURE add_parameter_array(p_request  IN OUT NOCOPY  t_request,
                        p_name     IN             VARCHAR2,
                        p_type     IN             VARCHAR2,
                        p_value    IN             DBMS_SQL.VARCHAR2_TABLE,
                        p_item_type IN            VARCHAR2
                        ) AS
BEGIN
  p_request.body := p_request.body||'<'||p_name||' xsi:type="'||p_type||'">';
  IF p_value.COUNT > 0 THEN
    FOR I IN p_value.FIRST..p_value.LAST LOOP
      p_request.body := p_request.body||'<'||p_item_type||'>'||p_value(I)||'</'||p_item_type||'>';
    END LOOP;
  END IF;
  p_request.body := p_request.body||'</'||p_name||'>';
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
PROCEDURE generate_envelope(p_request  IN OUT NOCOPY  t_request,
                            p_env      IN OUT NOCOPY  CLOB) AS
-- ---------------------------------------------------------------------
BEGIN
  p_env := '<?xml version="1.0" encoding="utf-8" ?>'||
           '<'||p_request.envelope_tag||':Envelope xmlns:'||p_request.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/" ' ||
               'xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:urn="'||p_request.namespace||'">' ||
             '<'||p_request.envelope_tag||':Header/>' ||
             '<'||p_request.envelope_tag||':Body>' ||
               '<urn:'||p_request.method||'>' ||
                   p_request.body ||
               '</urn:'||p_request.method||'>' ||
             '</'||p_request.envelope_tag||':Body>' ||
           '</'||p_request.envelope_tag||':Envelope>';
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
PROCEDURE show_envelope(p_env  IN  VARCHAR2) AS
-- ---------------------------------------------------------------------
  i      PLS_INTEGER;
  l_len  PLS_INTEGER;
BEGIN
  i := 1; l_len := LENGTH(p_env);
  WHILE (i <= l_len) LOOP
    DBMS_OUTPUT.put_line(SUBSTR(p_env, i, 160));
    i := i + 160;
  END LOOP;
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
PROCEDURE check_fault(p_response IN OUT NOCOPY  t_response) AS
-- ---------------------------------------------------------------------
  l_fault_node    XMLTYPE;
  l_fault_code    VARCHAR2(256);
  l_fault_string  VARCHAR2(32767);
  l_err_pos       BINARY_INTEGER;
BEGIN
  --dbms_output.put_line(p_response.data);
  --dbms_output.put_line('<'||p_response.envelope_tag||':Fault>');
  l_err_pos := dbms_lob.instr(p_response.data, '<'||p_response.envelope_tag||':Fault>');
  --dbms_output.put_line('l_err_pos='||l_err_pos);
  IF l_err_pos > 0 THEN
    l_fault_node := XMLTYPE.createxml(p_response.data);
    IF (l_fault_node IS NOT NULL) THEN
      l_fault_node := l_fault_node.extract('/'||p_response.envelope_tag||':Envelope/'||p_response.envelope_tag||':Body/child::node()',
                                           'xmlns:'||p_response.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/"');
      IF (l_fault_node IS NOT NULL) THEN
        l_fault_node := l_fault_node.extract(/*'/'||p_response.envelope_tag||':Envelope/'||p_response.envelope_tag||':Body/child::node()'
                                         ||*/'/'||p_response.envelope_tag||':Fault',
                                         'xmlns:'||p_response.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/');
        IF (l_fault_node IS NOT NULL) THEN
    l_fault_code   := l_fault_node.extract('/'||p_response.envelope_tag||':Fault/faultcode/child::text()',
                                           'xmlns:'||p_response.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/').getstringval();
    l_fault_string := l_fault_node.extract('/'||p_response.envelope_tag||':Fault/faultstring/child::text()',
                                           'xmlns:'||p_response.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/').getstringval();
    RAISE_APPLICATION_ERROR(-20001, l_fault_code || ' - ' || l_fault_string);
        END IF;
      END IF;
    END IF;
    IF (l_fault_node IS NOT NULL) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Unknown error in SOAP call');
    END IF;
  END IF;
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
FUNCTION invoke(p_request IN OUT NOCOPY  t_request,
                p_url     IN             VARCHAR2,
                p_action  IN             VARCHAR2)
  RETURN t_response AS
-- ---------------------------------------------------------------------
  l_envelope       CLOB;
  l_result         CLOB;
  l_text           VARCHAR2(10000 CHAR);
  l_http_request   UTL_HTTP.req;
  l_http_response  UTL_HTTP.resp;
  l_response       t_response;
  l_part_count     BINARY_INTEGER;
  l_request_blob   BLOB;
    vLANG_CONTEXT   INTEGER;
    vWARNING        INTEGER;
    vCLOB_DEST_OFFSET INTEGER;
    vBLOB_SRC_OFFSET  INTEGER;
BEGIN
  generate_envelope(p_request, l_envelope);
  --show_envelope(l_envelope);
  l_http_request := UTL_HTTP.begin_request(p_url, 'POST','HTTP/1.1');
  -- Преобразуем текст запроса в бинарный вид в кодировке UTF-8
  vCLOB_DEST_OFFSET := 1;
  vBLOB_SRC_OFFSET := 1;
  vLANG_CONTEXT := DBMS_LOB.default_lang_ctx;
  DBMS_LOB.CREATETEMPORARY(l_request_blob, TRUE);
  DBMS_LOB.CONVERTTOBLOB(
    l_request_blob,
    l_envelope,
    DBMS_LOB.GETLENGTH(l_envelope),
    vCLOB_DEST_OFFSET,
    vBLOB_SRC_OFFSET,
    NLS_CHARSET_ID('AL32UTF8'),
    vLANG_CONTEXT,
    vWARNING);
  -- Освободим ресурсы
  l_envelope := NULL;
  -- Кодировка запроса - UTF8
  utl_http.set_body_charset(l_http_request, 'AL32UTF8');
  UTL_HTTP.SET_TRANSFER_TIMEOUT(l_http_request, 60 * 60 * 8); -- 8 часов
  UTL_HTTP.set_header(l_http_request, 'Content-Type', 'text/xml; charset=utf-8');
  UTL_HTTP.set_header(l_http_request, 'Content-Length', DBMS_LOB.GETLENGTH(l_request_blob));
  UTL_HTTP.set_header(l_http_request, 'SOAPAction', p_action);
  FOR i IN 0..TRUNC((DBMS_LOB.GETLENGTH(l_request_blob)-1)/32000) LOOP
    UTL_HTTP.write_raw(l_http_request, DBMS_LOB.SUBSTR(l_request_blob, 32000, i*32000+1));
  END LOOP;
  DBMS_LOB.FREETEMPORARY(l_request_blob);
  --
  l_http_response := UTL_HTTP.get_response(l_http_request);
  BEGIN
    -- Кодировка результата - UTF8
    utl_http.set_body_charset(l_http_response, 'AL32UTF8');
    LOOP
      UTL_HTTP.read_text(l_http_response, l_text, 10000);
      EXIT WHEN l_text IS NULL;
      l_response.data := l_response.data || l_text;
      l_text := NULL;
    end loop;
    UTL_HTTP.end_response(l_http_response);
  EXCEPTION
    WHEN utl_http.end_of_body THEN
      utl_http.end_response(l_http_response);
    WHEN OTHERS THEN
      utl_http.end_response(l_http_response);
--    pERROR_TEXT := SQLERRM;
      RAISE;
  END;
  l_response.data := l_response.data || l_text;
  l_text := NULL;
--  show_envelope(l_result);
--  l_response.data := XMLTYPE.createxml(l_result);
--  l_response.data := l_result;
  l_response.envelope_tag := p_request.envelope_tag;
  --
--  l_response.doc := l_response.doc.extract('/'||l_response.envelope_tag||':Envelope/'||l_response.envelope_tag||':Body/child::node()',
--                                           'xmlns:'||l_response.envelope_tag||'="http://schemas.xmlsoap.org/soap/envelope/"');
  -- show_envelope(l_response.doc.getstringval());
  check_fault(l_response);
  RETURN l_response;
END;
-- ---------------------------------------------------------------------



-- ---------------------------------------------------------------------
FUNCTION get_return_value(p_response   IN OUT NOCOPY  t_response,
                          p_name       IN             VARCHAR2,
                          p_namespace  IN             VARCHAR2)
  RETURN CLOB AS
-- ---------------------------------------------------------------------
  l_result_item XMLTYPE;
  l_result_pos BINARY_INTEGER;
  l_result_pos_end BINARY_INTEGER;
  l_pattern VARCHAR2(200);
  l_result CLOB;
BEGIN
  --dbms_output.put_line(p_response.data);
  --RETURN REGEXP_REPLACE(p_response.data, '<return[^>]*>([.\r\n]*)<', '$1');
  IF DBMS_LOB.GETLENGTH(p_response.data) < 8000 then
    l_result_item := XMLTYPE.createxml(p_response.data);
    l_result_item := l_result_item.extract('//'||p_name||'/child::text()',p_namespace);
    IF l_result_item IS NOT NULL THEN
      l_result := l_result_item.getclobval();
    END IF;
  ELSE
    l_pattern := '<'||p_name||' xsi:type="xsd:string">';
    l_result_pos := DBMS_LOB.INSTR(p_response.data, l_pattern);
    IF l_result_pos > 0 THEN
      l_result_pos := l_result_pos + LENGTH(l_pattern);
      l_result_pos_end := DBMS_LOB.INSTR(p_response.data, '</'||p_name||'>');
      IF l_result_pos_end > l_result_pos THEN
        l_result := SUBSTR(p_response.data, l_result_pos, l_result_pos_end-l_result_pos);
        --RAISE_APPLICATION_ERROR(-20000, DBMS_LOB.GETLENGTH(l_result));
      END IF;
    END IF;
  END IF;
  RETURN l_result;
END;
-- ---------------------------------------------------------------------

END soap_api_bi;
