CREATE OR REPLACE PACKAGE DBASE_PKG AS
  --#Version=2
  --
  --v.2 Афросин - Добавил выгрузку во внешний dbf файл (процедура dump_table)
  --    
  PROCEDURE load_Table(p_dir      IN VARCHAR2,
                       p_file     IN VARCHAR2,
                       p_tname    IN VARCHAR2,
                       p_dbf_id   in integer,
                       p_cnames   IN VARCHAR2 DEFAULT NULL,
                       p_colnames IN VARCHAR2 DEFAULT NULL,
                       p_show     IN BOOLEAN DEFAULT FALSE);
  -- Load data from BLOB (parameters same as in load_Table(p_dir...),
  --       except p_dir and p_file replaced on p_data)
  PROCEDURE load_Table(p_data     IN BLOB,
                       p_tname    IN VARCHAR2,
                       p_dbf_id   in integer,
                       p_cnames   IN VARCHAR2 DEFAULT NULL,
                       p_colnames IN VARCHAR2 DEFAULT NULL,
                       p_show     IN BOOLEAN DEFAULT FALSE);

--ФУНКЦИЯ возвращает количество строк в dbf файле  
  
  FUNCTION GET_DBF_ROW_COUNT(p_dir      IN VARCHAR2,
                          p_file     IN VARCHAR2) RETURN INTEGER;
  
  FUNCTION GET_DBF_ROW_COUNT(p_data     IN BLOB) RETURN INTEGER;
  
  --выгрузка файла на диск
  procedure dump_table ( p_dir          in varchar2,
                           p_file         in varchar2,
                           p_schema       in varchar2,
                           p_tname        in varchar2,
                           p_cnames       in varchar2 DEFAULT '',
                           p_colnames     IN VARCHAR2 DEFAULT '',
                           p_where_clause in varchar2 DEFAULT '',
                           p_SQL          in varchar2 DEFAULT '',
                           p_coltype      in varchar2 DEFAULT '',
                           p_colsize      in varchar2 DEFAULT '',
                           p_show         IN BOOLEAN DEFAULT FALSE,
                           p_trim         in boolean  default false
                         );
  
END;
/


CREATE OR REPLACE PACKAGE BODY DBASE_PKG AS
  -- Might have to change on your platform!!!
  -- Controls the byte order of binary integers read in
  -- from the dbase file
  BIG_ENDIAN CONSTANT BOOLEAN DEFAULT TRUE;
  
  oem_convert boolean default false;
  
  SUBTYPE DATAFILE IS BLOB;
  
  TYPE dbf_header IS RECORD(
    version    VARCHAR2(25), -- dBASE version number
    year       INT, -- 1 byte int year, add to 1900
    month      INT, -- 1 byte month
    day        INT, -- 1 byte day
    no_records INT, -- number of records in file,
    -- 4 byte int
    hdr_len INT, -- length of header, 2 byte int
    rec_len INT, -- number of bytes in record,
    -- 2 byte int
    no_fields INT -- number of fields
    );
    
  TYPE field_descriptor IS RECORD(
    name     VARCHAR2(11),
    TYPE     CHAR(1),
    LENGTH   INT, -- 1 byte length
    decimals INT, -- 1 byte scale
    realname     varchar2(40),
    realtype     char(1)
    );
  TYPE field_descriptor_array IS TABLE OF field_descriptor INDEX BY BINARY_INTEGER;
  TYPE rowArray IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;
  g_cursor BINARY_INTEGER DEFAULT dbms_sql.open_cursor;
  -- Function to convert a binary unsigned integer
  -- into a PLSQL number
  function to_int(p_data in varchar2) return number is
    l_number number default 0;
    l_bytes  number default length(p_data);
  begin
    if (big_endian) then
      for i in 1 .. l_bytes loop
        l_number := l_number +
                    ascii(substr(p_data, i, 1)) * power(2, 8 * (i - 1));
      end loop;
    else
      for i in 1 .. l_bytes loop
        l_number := l_number + ascii(substr(p_data, l_bytes - i + 1, 1)) *
                    power(2, 8 * (i - 1));
      end loop;
    end if;
  
    return l_number;
  end;

  function to_int1(p_data in raw) return number is
    l_number  number default 0;
    l_numbert binary_integer;
    l_bytes   number default utl_raw.length(p_data);
  begin
    if (big_endian) then
      for i in 1 .. l_bytes loop
        l_numbert := utl_raw.cast_to_binary_integer(utl_raw.substr(p_data, i, 1));
        for y in 1 .. i - 1 loop
          l_numbert := l_numbert * 256;
        end loop;
        l_number := l_number + l_numbert;
      end loop;
    else
      for i in 1 .. l_bytes loop
        l_number := l_number + utl_raw.cast_to_number(substr(p_data,
                                                             l_bytes - i + 1,
                                                             1)) *
                    power(2, 8 * (i - 1));
      end loop;
    end if;
    return l_number;
  end;

  FUNCTION mytrim(p_str IN VARCHAR2) RETURN VARCHAR2 IS
    i     NUMBER;
    j     NUMBER;
    v_res VARCHAR2(100);
  BEGIN
    FOR i IN 1 .. 11 LOOP
      IF ASCII(SUBSTR(p_str, i, 1)) = 0 THEN
        j := i;
        EXIT;
      END IF;
    END LOOP;
    v_res := SUBSTR(p_str, 1, j - 1);
    RETURN v_res;
  END mytrim;
  -- Routine to parse the DBASE header record, can get
  -- all of the details of the contents of a dbase file from
  -- this header
  PROCEDURE get_header(p_bfile        IN DATAFILE,
                       p_bfile_offset IN OUT NUMBER,
                       p_hdr          IN OUT dbf_header,
                       p_flds         IN OUT field_descriptor_array) IS
    l_data            VARCHAR2(4000);
    l_hdr_size        NUMBER DEFAULT 32;
    l_field_desc_size NUMBER DEFAULT 32;
    l_flds            field_descriptor_array;
    l_ftype           varchar2(1);
    l_fname           varchar2(11);
    l_fieldno         NUMBER;
  BEGIN
    p_flds           := l_flds;
    l_data           := utl_raw.cast_to_varchar2(dbms_lob.SUBSTR(p_bfile,
                                                                 l_hdr_size,
                                                                 p_bfile_offset));
    p_bfile_offset   := p_bfile_offset + l_hdr_size;
    p_hdr.version    := ASCII(SUBSTR(l_data, 1, 1));
    p_hdr.year       := 1900 + ASCII(SUBSTR(l_data, 2, 1));
    p_hdr.month      := ASCII(SUBSTR(l_data, 3, 1));
    p_hdr.day        := ASCII(SUBSTR(l_data, 4, 1));
    p_hdr.no_records := to_int(SUBSTR(l_data, 5, 4));
    p_hdr.hdr_len    := to_int(SUBSTR(l_data, 9, 2));
    p_hdr.rec_len    := to_int(SUBSTR(l_data, 11, 2));
    p_hdr.no_fields  := TRUNC((p_hdr.hdr_len - l_hdr_size) /
                              l_field_desc_size);
    l_fieldno        := p_hdr.no_fields;
    FOR i IN 1 .. l_fieldno LOOP
      l_data         := utl_raw.cast_to_varchar2(dbms_lob.SUBSTR(p_bfile,
                                                                 l_field_desc_size,
                                                                 p_bfile_offset));
      p_bfile_offset := p_bfile_offset + l_field_desc_size;
      if p_hdr.no_fields >= i then
        l_fname := mytrim(SUBSTR(l_data, 1, 11));
        l_ftype := SUBSTR(l_data, 12, 1);
        if (l_ftype = '0') or (l_ftype = chr(0)) then
          p_hdr.no_fields := i - 1;
        else
          p_flds(i).name := l_fname;
          p_flds(i).TYPE := l_ftype;
          p_flds(i).LENGTH := ASCII(SUBSTR(l_data, 17, 1));
          p_flds(i).decimals := ASCII(SUBSTR(l_data, 18, 1));
        end if;
      end if;
    END LOOP;
    p_bfile_offset := p_bfile_offset +
                      MOD(p_hdr.hdr_len - l_hdr_size, l_field_desc_size);
  END;

  PROCEDURE get_header1(p_bfile        IN DATAFILE,
                        p_bfile_offset IN OUT NUMBER,
                        p_hdr          IN OUT dbf_header,
                        p_flds         IN OUT field_descriptor_array) IS
    l_data            VARCHAR2(4000);
    l_hdr_size        NUMBER DEFAULT 32;
    l_field_desc_size NUMBER DEFAULT 32;
    l_flds            field_descriptor_array;
    l_ftype           varchar2(1);
    l_fname           varchar2(11);
    l_fieldno         NUMBER;
    l_data_raw        raw(32767);
  BEGIN
    p_flds           := l_flds;
    l_data_raw       := dbms_lob.SUBSTR(p_bfile, l_hdr_size, p_bfile_offset);
    l_data           := utl_raw.cast_to_varchar2(dbms_lob.SUBSTR(p_bfile,
                                                                 l_hdr_size,
                                                                 p_bfile_offset));
    p_bfile_offset   := p_bfile_offset + l_hdr_size;
    p_hdr.version    := ASCII(SUBSTR(l_data, 1, 1));
    p_hdr.year       := 1900 + ASCII(SUBSTR(l_data, 2, 1));
    p_hdr.month      := ASCII(SUBSTR(l_data, 3, 1));
    p_hdr.day        := ASCII(SUBSTR(l_data, 4, 1));
    p_hdr.no_records := to_int1(utl_raw.SUBSTR(l_data_raw, 5, 4));
    p_hdr.hdr_len    := to_int1(utl_raw.SUBSTR(l_data_raw, 9, 2));
    p_hdr.rec_len    := to_int1(utl_raw.SUBSTR(l_data_raw, 11, 2));
    p_hdr.no_fields  := TRUNC((p_hdr.hdr_len - l_hdr_size) /
                              l_field_desc_size);
    l_fieldno        := p_hdr.no_fields;
    FOR i IN 1 .. l_fieldno LOOP
      l_data_raw := dbms_lob.SUBSTR(p_bfile, l_field_desc_size, p_bfile_offset);
      l_data         := utl_raw.cast_to_varchar2(l_data_raw);
      p_bfile_offset := p_bfile_offset + l_field_desc_size;
      if p_hdr.no_fields >= i then
        l_fname := mytrim(SUBSTRB(l_data, 1, 11));
        l_ftype := SUBSTRB(l_data, 12, 1);
        if (l_ftype = '0') or (l_ftype = chr(0)) then
          p_hdr.no_fields := i - 1;
        else
         
          p_flds(i).name := l_fname;
          p_flds(i).TYPE := l_ftype;
          p_flds(i).LENGTH := utl_raw.cast_to_binary_integer(utl_raw.substr(l_data_raw, 17, 1));
          p_flds(i).decimals := utl_raw.cast_to_binary_integer(utl_raw.substr(l_data_raw, 18, 1));
        end if;
      end if;
    END LOOP;
    p_bfile_offset := p_bfile_offset +
                      MOD(p_hdr.hdr_len - l_hdr_size, l_field_desc_size);
  END;

  FUNCTION build_insert(p_tname    IN VARCHAR2,
                        p_DBF_id   in integer,
                        p_cnames   IN VARCHAR2,
                        p_colnames IN VARCHAR2,
                        p_flds     IN field_descriptor_array) RETURN VARCHAR2 IS
    flag               integer;
    l_insert_statement LONG;
  BEGIN
    l_insert_statement := 'insert into ' || p_tname || '(';
    IF (p_cnames IS NOT NULL) THEN
      if p_dbf_id is not null then
        l_insert_statement := l_insert_statement || p_cnames ||
                              ',DBF_ID) values (';
      else
        l_insert_statement := l_insert_statement || p_cnames ||
                              ') values (';
      end if;
    ELSE
      FOR i IN 1 .. p_flds.COUNT LOOP
        IF (substr(l_insert_statement, -1) <> '(') THEN
          l_insert_statement := l_insert_statement || ',';
        END IF;
        --select count(*)
        --  into flag
        --  from dual
        -- where p_flds(i).name in
        --      (SELECT regexp_substr(str, '[^,]+', 1, level) str
        --       FROM (SELECT p_colnames str FROM dual) t
        --   CONNECT BY instr(str, ',', 1, level - 1) > 0);
        if (p_colnames is null) or (instr(p_colnames, p_flds(i).name) > 0)
        --flag = 1 
         then
          l_insert_statement := l_insert_statement || '"' || p_flds(i).name || '"';
        end if;
      END LOOP;
      if p_dbf_id is not null then
        l_insert_statement := l_insert_statement || ',DBF_ID';
      end if;
      l_insert_statement := l_insert_statement || ') values (';
    END IF;
    FOR i IN 1 .. p_flds.COUNT LOOP
      if (p_colnames is null) or (instr(p_colnames, p_flds(i).name) > 0) then
        IF (substr(l_insert_statement, -1) <> '(') THEN
          l_insert_statement := l_insert_statement || ',';
        END IF;
        IF (p_flds(i).TYPE = 'D') THEN
          l_insert_statement := l_insert_statement || 'to_date(:bv' || i ||
                                ',''yyyymmdd'' )';
        ELSE
          l_insert_statement := l_insert_statement || ':bv' || i;
        END IF;
      end if;
    END LOOP;
    if p_dbf_id is not null then
      l_insert_statement := l_insert_statement || ',:dbfid';
    end if;
    l_insert_statement := l_insert_statement || ')';
    RETURN l_insert_statement;
  END;
  FUNCTION get_row(p_bfile        IN DATAFILE,
                   p_bfile_offset IN OUT NUMBER,
                   p_hdr          IN dbf_header,
                   p_flds         IN field_descriptor_array) RETURN rowArray IS
  
    l_data      VARCHAR2(4000);
    l_row       rowArray;
    l_n         NUMBER DEFAULT 2;
    l_NumberRow NUMBER; -- by Roman
    l_StringRow VARCHAR2(255); -- by Roman
    l_TEST_DATE DATE;
    v_varchar   VARCHAR2(32767);
    v_start     PLS_INTEGER := p_bfile_offset;
    v_buffer    PLS_INTEGER := 32767;
  BEGIN
    --DBMS_LOB.CREATETEMPORARY(l_data, TRUE);
  
    --  FOR i IN 1..CEIL(p_hdr.rec_len / v_buffer)
    --  LOOP
  
    --     v_varchar := UTL_RAW.CAST_TO_VARCHAR2(DBMS_LOB.SUBSTR(p_bfile, v_buffer, v_start));
  
    --     DBMS_LOB.WRITEAPPEND(l_data, LENGTH(v_varchar), v_varchar);
  
    --    v_start := v_start + v_buffer;
    --  END LOOP;
  
    l_data := utl_raw.cast_to_varchar2(dbms_lob.SUBSTR(p_bfile,
                                                       p_hdr.rec_len,
                                                       p_bfile_offset));
    p_bfile_offset := p_bfile_offset + p_hdr.rec_len;
    l_row(0) := SUBSTR(l_data, 1, 1);
    if l_row(0) <> chr(26) then
      FOR i IN 1 .. p_hdr.no_fields LOOP
        l_row(i) := RTRIM(LTRIM(SUBSTRB(l_data, l_n, p_flds(i).LENGTH)));
        -- by Roman, jan.2004, Slovenia
        -- Because of different NLS_LANG parameters, an error occured with message: INVALID NUMBER.
        -- Because the type rowArray is consisted of strings, we have to change TO REAL (SYSTEM) DECIMAL CHARACTER.
        -- Some could use , and someone could use .
        -- So, what I do here:
        -- I convert the string value of number to number value and that back to string value.
        IF p_flds(i).TYPE = 'C' THEN
          l_row(i) := CONVERT(l_row(i), 'AL32UTF8', 'CL8MSWIN1251');
        ELSIF (p_flds(i).TYPE = 'F' OR p_flds(i).TYPE = 'N') THEN
          -- Only for FLOAT AND NUMBER TYPE
          BEGIN
            l_StringRow := l_row(i); --Save to temporary variable
            l_StringRow := REPLACE(l_StringRow, ',', '.'); --We change characters
            l_NumberRow := TO_NUMBER(l_StringRow); -- try to convert TO NUMBER
            l_row(i) := TO_CHAR(l_NumberRow); --If succeded that we have right NUMBER value!
          EXCEPTION
            WHEN OTHERS THEN
              l_StringRow := l_row(i); --Save to temporary variable
              l_StringRow := REPLACE(l_StringRow, '.', ','); --We CHANGE characters
              l_NumberRow := TO_NUMBER(l_StringRow); -- try to CONVERT TO NUMBER
              l_row(i) := TO_CHAR(l_NumberRow); --If succeded that we have right NUMBER value!
          END;
        END IF;
        -- End Roman
        IF (p_flds(i).TYPE = 'F' AND l_row(i) = '.') THEN
          l_row(i) := NULL;
        END IF;
        IF (p_flds(i).TYPE = 'D') THEN
          BEGIN
            l_TEST_DATE := TO_DATE(l_row(i), 'YYYYMMDD');
          EXCEPTION
            WHEN OTHERS THEN
              l_row(i) := NULL;
          END;
        END IF;
        l_n := l_n + p_flds(i).LENGTH;
      END LOOP;
    end if;
    RETURN l_row;
  END get_row;
  PROCEDURE show(p_hdr      IN dbf_header,
                 p_flds     IN field_descriptor_array,
                 p_tname    IN VARCHAR2,
                 p_dbf_id   in integer,
                 p_cnames   IN VARCHAR2,
                 p_colnames IN VARCHAR2,
                 p_bfile    IN DATAFILE) IS
    l_sep VARCHAR2(25) DEFAULT ',';
    flag  integer;
    PROCEDURE p(p_str IN VARCHAR2) IS
      l_str LONG DEFAULT p_str;
    BEGIN
      WHILE (l_str IS NOT NULL) LOOP
        dbms_output.put_line(SUBSTR(l_str, 1, 250));
        l_str := SUBSTR(l_str, 251);
      END LOOP;
    END;
  BEGIN
    p('Sizeof DBASE File: ' || dbms_lob.getlength(p_bfile));
    p('DBASE Header Information: ');
    p(CHR(9) || 'Version = ' || p_hdr.version);
    p(CHR(9) || 'Year    = ' || p_hdr.year);
    p(CHR(9) || 'Month   = ' || p_hdr.month);
    p(CHR(9) || 'Day     = ' || p_hdr.day);
    p(CHR(9) || '#Recs   = ' || p_hdr.no_records);
    p(CHR(9) || 'Hdr Len = ' || p_hdr.hdr_len);
    p(CHR(9) || 'Rec Len = ' || p_hdr.rec_len);
    p(CHR(9) || '#Fields = ' || p_hdr.no_fields);
    p(CHR(10) || 'Data Fields:');
    FOR i IN 1 .. p_hdr.no_fields LOOP
      p('Field(' || i || ') ' || 'Name = "' || p_flds(i).name || '", ' ||
        'Type = ' || p_flds(i).TYPE || ', ' || 'Len  = ' || p_flds(i)
        .LENGTH || ', ' || 'Scale= ' || p_flds(i).decimals);
    END LOOP;
    p(CHR(10) || 'Insert We would use:');
    p(build_insert(p_tname, p_dbf_id, p_cnames, p_colnames, p_flds));
    p(CHR(10) || 'Table that could be created to hold data:');
    p('create table ' || p_tname);
    p('(');
    FOR i IN 1 .. p_hdr.no_fields LOOP
      IF (i = p_hdr.no_fields) THEN
        if p_dbf_id is not null then
          l_sep := l_sep || chr(13) || chr(10) || CHR(9) || '"DBF_ID"' ||
                   CHR(9) || 'INTEGER)';
        else
          l_sep := ')';
        end if;
      END IF;
      select count(*)
        into flag
        from dual
       where p_flds(i)
       .name in (SELECT regexp_substr(str, '[^,]+', 1, level) str
                         FROM (SELECT p_colnames str FROM dual) t
                       CONNECT BY instr(str, ',', 1, level - 1) > 0);
      if flag = 1 then
        dbms_output.put(CHR(9) || '"' || p_flds(i).name || '"   ');
        IF (p_flds(i).TYPE = 'D') THEN
          p('date' || l_sep);
        ELSIF (p_flds(i).TYPE = 'F') THEN
          p('float' || l_sep);
        ELSIF (p_flds(i).TYPE = 'N') THEN
          IF (p_flds(i).decimals > 0) THEN
            p('number(' || p_flds(i).LENGTH || ',' || p_flds(i).decimals || ')' ||
              l_sep);
          ELSE
            p('number(' || p_flds(i).LENGTH || ')' || l_sep);
          END IF;
        ELSE
          p('varchar2(' || p_flds(i).LENGTH || ')' || l_sep);
        END IF;
      end if;
    END LOOP;
    p('/');
  END;
  PROCEDURE load_Table(p_data     IN BLOB,
                       p_tname    IN VARCHAR2,
                       p_dbf_id   in integer,
                       p_cnames   IN VARCHAR2,
                       p_colnames IN VARCHAR2,
                       p_show     IN BOOLEAN) IS
    l_offset NUMBER DEFAULT 1;
    l_hdr    dbf_header;
    l_flds   field_descriptor_array;
    l_row    rowArray;
    flag     integer;
    i        NUMBER;
    j        NUMBER;
    --  v_debug varchar2(2000);
  BEGIN
    get_header1(p_data, l_offset, l_hdr, l_flds);
    IF (p_show) THEN
      show(l_hdr, l_flds, p_tname, p_dbf_id, p_cnames, p_colnames, p_data);
    ELSE
      dbms_sql.parse(g_cursor,
                     build_insert(p_tname,
                                  p_dbf_id,
                                  p_cnames,
                                  p_colnames,
                                  l_flds),
                     dbms_sql.native);
      FOR j IN 1 .. l_hdr.no_records LOOP
        l_row := get_row(p_data, l_offset, l_hdr, l_flds);
        if l_row(0) = chr(26) then
          exit;
        end if;
        IF (l_row(0) <> '*') -- deleted record
         THEN
          --v_debug := null;
          FOR i IN 1 .. l_hdr.no_fields LOOP
            --                  v_debug := v_debug ||''''|| l_row(i)||''',';
            if (p_colnames is null) or
               (instr(p_colnames, l_flds(i).name) > 0) then
              dbms_sql.bind_variable(g_cursor, ':bv' || i, l_row(i), 4000);
            end if;
          END LOOP;
          IF p_dbf_id is not null then
            dbms_sql.bind_variable(g_cursor, ':dbfid', TO_CHAR(p_dbf_id), 4000);
          END IF;
          --                raise_application_error(-20000, v_debug);
          IF (dbms_sql.EXECUTE(g_cursor) <> 1) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Insert failed ' || SQLERRM);
          END IF;
        END IF;
      END LOOP;
    END IF;
  END;
  PROCEDURE load_Table(p_dir      IN VARCHAR2,
                       p_file     IN VARCHAR2,
                       p_tname    IN VARCHAR2,
                       p_dbf_id   in integer,
                       p_cnames   IN VARCHAR2 DEFAULT NULL,
                       p_colnames IN VARCHAR2 DEFAULT NULL,
                       p_show     IN BOOLEAN DEFAULT FALSE) IS
    l_bfile BFILE;
    l_data  BLOB;
  BEGIN
    l_bfile := BFILENAME(p_dir, p_file);
    dbms_lob.fileopen(l_bfile);
    dbms_lob.createtemporary(l_data, TRUE);
    dbms_lob.loadfromfile(l_data, l_bfile, dbms_lob.GETLENGTH(l_bfile));
    --    l_data := dbms_lob.SUBSTR(l_bfile, 1, dbms_lob.GETLENGTH(l_bfile));
    --RAISE_APPLICATION_ERROR(-20000, dbms_lob.GETLENGTH(l_data));
    load_Table(l_data, p_tname, p_dbf_id, p_cnames, p_colnames, p_show);
    dbms_lob.fileclose(l_bfile);
  EXCEPTION
    WHEN OTHERS THEN
      IF (dbms_lob.isopen(l_bfile) > 0) THEN
        dbms_lob.fileclose(l_bfile);
      END IF;
      IF (dbms_lob.istemporary(l_data) > 0) THEN
        dbms_lob.freetemporary(l_data);
      END IF;
      RAISE;
  END;
  
  FUNCTION GET_DBF_ROW_COUNT(p_dir      IN VARCHAR2,
                          p_file     IN VARCHAR2) RETURN INTEGER as
  
  l_bfile BFILE;
  l_data  BLOB;
  res INTEGER;
  begin
    res := NULL;
    l_bfile := BFILENAME(p_dir, p_file);
    dbms_lob.fileopen(l_bfile);
    dbms_lob.createtemporary(l_data, TRUE);
    dbms_lob.loadfromfile(l_data, l_bfile, dbms_lob.GETLENGTH(l_bfile));
    
    res := GET_DBF_ROW_COUNT(l_data);
    dbms_lob.fileclose(l_bfile);
    RETURN RES;
    EXCEPTION
      WHEN OTHERS THEN
        IF (dbms_lob.isopen(l_bfile) > 0) THEN
          dbms_lob.fileclose(l_bfile);
        END IF;
        IF (dbms_lob.istemporary(l_data) > 0) THEN
          dbms_lob.freetemporary(l_data);
        END IF;
      RAISE;  
  end;
  
  
  FUNCTION GET_DBF_ROW_COUNT(p_data     IN BLOB) RETURN INTEGER as
  
  l_offset NUMBER DEFAULT 1;
  l_hdr    dbf_header;
  l_flds   field_descriptor_array; 
  
  begin
    get_header1(p_data, l_offset, l_hdr, l_flds);
    RETURN l_hdr.no_records;
  end;
function str2tbl (P_STR IN VARCHAR2) RETURN RowArray
is
  L_STR LONG DEFAULT P_STR || ',';
  L_N NUMBER;
  L_DATA RowArray;
  V_Data VARCHAR2(4000);
BEGIN
  LOOP
    L_N := INSTR (L_STR, ',');
    EXIT WHEN (NVL (L_N, 0) = 0);

    v_data := NVL(TRIM(SUBSTR (L_STR, 1, L_N - 1)),'/|\');

    IF v_data<>'/|\' THEN
      L_DATA (L_DATA.COUNT) := V_DATA;
    END IF;
    
    L_STR := SUBSTR (L_STR, L_N + 1);
    
  END LOOP;

  RETURN L_DATA;
END;                       

procedure put_header (p_schema       in varchar2,
                      p_tname        in varchar2,
                      p_cnames       in varchar2 DEFAULT NULL,
                      p_colnames     IN VARCHAR2 DEFAULT '',
                      p_trim         in boolean DEFAULT false,
                      p_where_clause in varchar2 DEFAULT '',
                      p_SQL          in varchar2 DEFAULT '',
                      p_coltype      in varchar2 DEFAULT NULL,
                      p_colsize      in varchar2 DEFAULT NULL,
                      l_hdr          in out dbf_header,
                      vFlds          in out field_descriptor_array)
is
    v_value_list  RowArray;
    vCursor   varchar2(10000);
    type rc IS ref cursor;
    col_cur rc;
    i  INTEGER:=0;
    v_colsizetmp varchar2(1000);
    v_cnames varchar2(4000)   := UPPER(replace(p_cnames,' ',''));
    v_colnames varchar2(4000) := UPPER(replace(p_colnames,' ',''));
    v_coltype varchar2(4000) := UPPER(replace(p_coltype,' ',''));
    v_colsize varchar2(4000) := UPPER(replace(p_colsize,' ',''));
    v_cnames_list  RowArray;
    v_colnames_list  RowArray;
    v_coltype_list  RowArray;
    v_colsize_list  RowArray;
    vINSTR integer;
    vlenfld integer;
begin
  
  if v_colnames is null then
    v_colnames := v_cnames;
  end if;
  
  if p_SQL is not null then
    -- задан SQL запрос
    v_colnames_list := str2tbl( v_colnames );
    v_cnames_list := str2tbl( p_cnames );
    v_coltype_list  := str2tbl( v_coltype );
    v_colsize_list  := str2tbl( v_colsize );                   
    
    FOR i IN 0..v_colnames_list.count-1 LOOP
      vFlds(i).name := v_colnames_list(i);
      vFlds(i).realname := v_cnames_list(i);
      vFlds(i).type := v_coltype_list(i);
      vFlds(i).realtype := vFlds(i).type;
      --  vFlds(i).type:='C';        
      if vFlds(i).type='D' then
        vFlds(i).length := 10; -- 20;  -- 8
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='T' then 
        vFlds(i).type := 'C';  
        vFlds(i).realtype := 'T';  
        vFlds(i).length := 8; 
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='C' then
        vFlds(i).length := to_number(v_colsize_list(i));
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='N' then
        v_colsizetmp := v_colsize_list(i);
        vINSTR := INSTR(v_colsizetmp,'.');
        if vINSTR>0 then
          vFlds(i).length := substr(v_colsizetmp,0,vINSTR-1);
          vFlds(i).decimals := substr(v_colsizetmp,vINSTR+1);
        else
          vFlds(i).length := to_number(v_colsize_list(i));
          vFlds(i).decimals := 0;
        end if;
      end if;
    end loop;
  elsif v_coltype IS NOT NULL THEN                       
    v_colnames_list :=str2tbl( v_colnames );
    v_cnames_list :=str2tbl( p_cnames );
    v_coltype_list  :=str2tbl( v_coltype );
    v_colsize_list  :=str2tbl( v_colsize );                   
    FOR i IN 0..v_colnames_list.count-1 LOOP
      vFlds(i).name := v_colnames_list(i);
      vFlds(i).realname := v_cnames_list(i);
      vFlds(i).type := v_coltype_list(i);
      vFlds(i).realtype := vFlds(i).type;
      --  vFlds(i).type:='C';
      case vFlds(i).type
        when 'D' then
          vFlds(i).length := 10; -- 20;  -- 8
          vFlds(i).decimals := 0;
        when 'T' then  
          vFlds(i).type := 'C';  
          vFlds(i).realtype := 'T';  
          vFlds(i).length := 8; 
          vFlds(i).decimals := 0;
        when 'C' then
          vFlds(i).length := to_number(v_colsize_list(i));
          vFlds(i).decimals := 0;  
        when 'N' then
          v_colsizetmp := v_colsize_list(i);
          vINSTR := INSTR(v_colsizetmp,'.');
          if vINSTR>0 then
            vFlds(i).length := substr(v_colsizetmp,0,vINSTR-1);
            vFlds(i).decimals := substr(v_colsizetmp,vINSTR+1);
          else
            vFlds(i).length := to_number(v_colsize_list(i));
            vFlds(i).decimals := 0;
          end if;
      end case;         
      /*
      if vFlds(i).type ='D' then
        vFlds(i).length := 10; -- 20;  -- 8
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='T' then  
        vFlds(i).type := 'C';  
        vFlds(i).realtype := 'T';  
        vFlds(i).length := 8; 
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='C' then
        vFlds(i).length := to_number(v_colsize_list(i));
        vFlds(i).decimals := 0;
      elsif vFlds(i).type='N' then
        v_colsizetmp := v_colsize_list(i);
        vINSTR := INSTR(v_colsizetmp,'.');
        if vINSTR>0 then
          vFlds(i).length := substr(v_colsizetmp,0,vINSTR-1);
          vFlds(i).decimals := substr(v_colsizetmp,vINSTR+1);
        else
          vFlds(i).length := to_number(v_colsize_list(i));
          vFlds(i).decimals := 0;
        end if;
      end if;
      */
    end loop;
  elsif p_cnames IS NOT NULL THEN                       
    v_colnames_list :=str2tbl( v_colnames );
    v_cnames_list :=str2tbl( p_cnames );
    v_coltype_list  :=str2tbl( v_coltype );
    v_colsize_list  :=str2tbl( v_colsize );                   
    FOR i IN 0..v_colnames_list.count-1
    LOOP
      vFlds(i).name := v_colnames_list(i);
      vFlds(i).realname := v_cnames_list(i);
      if ((v_coltype is null) or (v_colsize is null)) then
        -- если тип или длина не заданы то они определ¤ютс¤ автоматически
        vCursor:='select  '||
                 '    case data_type '||
                 '    when ''DATE'' then ''D'' '||
                 '    when ''NUMBER'' then ''N'' '||
                 '    else ''C'' end , '||
                 '    case data_type '||
                 '    when ''NUMBER'' then NVL(data_precision,22) '||
                 '    when ''DATE'' then 10 '|| -- 20
                 '    else data_length end, '||
                 '    case data_type '||
                 '    when ''NUMBER'' then data_scale '||
                 '    end '||
                 '    from all_tab_cols '||
                 '    where column_name = '''||vFlds(i).realname||'''  '||
                 '    and table_name='''||upper(p_tname)||''' '||
                 '    and owner='''||upper(p_schema)||''' ';
        open col_cur for vCursor;
        loop
          fetch col_cur into vFlds(i).type,vFlds(i).length,vFlds(i).decimals;
          vFlds(i).realtype := vFlds(i).type;
          --   vFlds(i).type:='C';
          --   vFlds(i).realname := vFlds(i).name;
          exit when col_cur%notfound;
        end loop;

        close col_cur;
        
      else                   
        vFlds(i).type := v_coltype_list(i);
        vFlds(i).realtype := vFlds(i).type;
      --  vFlds(i).type:='C';
        
        case vFlds(i).type
          when 'D' then
            vFlds(i).length := 10;  -- 20
            vFlds(i).decimals := 0;
          when 'C' then
            vFlds(i).length := to_number(v_colsize_list(i));
            vFlds(i).decimals := 0;
          when 'N' then
            v_colsizetmp := v_colsize_list(i);
            vINSTR := INSTR(v_colsizetmp,'.');
            if vINSTR > 0 then
              vFlds(i).length := substr(v_colsizetmp,0,vINSTR-1);
              vFlds(i).decimals := substr(v_colsizetmp,vINSTR+1);
            else
              vFlds(i).length := to_number(v_colsize_list(i));
              vFlds(i).decimals := 0;
            end if;
        end case;
            
            
        /*
        if vFlds(i).type='D' then
          vFlds(i).length := 10;  -- 20
          vFlds(i).decimals := 0;
        elsif vFlds(i).type='C' then
          vFlds(i).length := to_number(v_colsize_list(i));
          vFlds(i).decimals := 0;
        elsif vFlds(i).type='N' then
          v_colsizetmp := v_colsize_list(i);
          vINSTR := INSTR(v_colsizetmp,'.');
          if vINSTR>0 then
            vFlds(i).length := substr(v_colsizetmp,0,vINSTR-1);
            vFlds(i).decimals := substr(v_colsizetmp,vINSTR+1);
          else
            vFlds(i).length := to_number(v_colsize_list(i));
            vFlds(i).decimals := 0;
          end if;
        end if;
        */
      end if;
    end loop;
                       
  else
    IF p_cnames IS NOT NULL THEN
        v_value_list:= str2tbl(UPPER(p_cnames));
        vCursor:='select column_name, '||
                 '    case data_type '||
                 '    when ''DATE'' then ''D'' '||
                 '    when ''NUMBER'' then ''N'' '||
                 '    else ''C'' end , '||
                 '    case data_type '||
                 '    when ''NUMBER'' then NVL(data_precision,22) '||
                 '    when ''DATE'' then 10 '|| -- 20
                 '    else data_length end, '||
                 '    case data_type '||
                 '    when ''NUMBER'' then data_scale '||
                 '    end '||
                 '    from all_tab_cols '||
                 '    where column_name IN ('''||upper(replace(p_cnames,',',''','''))||''')  '||
                 '    and table_name='''||upper(p_tname)||''' '||
                 '    and owner='''||upper(p_schema)||''' '||
         '  order by column_id';
--               where column_name IN (select * from TABLE (cast(str2tbl(UPPER('''||p_cnames||''')) as RowArray)))
    else
        vCursor:='select column_name,
                     case data_type
                     when ''DATE'' then ''D''
                     when ''NUMBER'' then ''N''
                     else ''C'' end ,
                     case data_type
                     when ''NUMBER'' then NVL(data_precision,22)
                     when ''DATE'' then 10 
                     else data_length end,
                     case data_type
                     when ''NUMBER'' then data_scale
                     end
              from all_tab_cols
              where table_name='''||upper(p_tname)||'''
                     and owner='''||upper(p_schema)||''' 
              order by column_id';
    END IF;

    open col_cur for vCursor;
    
    i:=0;
    loop
      i:=i+1;
      fetch col_cur into vFlds(i).name,vFlds(i).type,vFlds(i).length,vFlds(i).decimals;
      vFlds(i).realtype := vFlds(i).type;
      --  vFlds(i).type:='C';
      vFlds(i).realname := vFlds(i).name;
      exit when col_cur%notfound;
    end loop;

    close col_cur;
    
  end if;  
  
  if p_trim is not null then
    FOR i IN 0..v_colnames_list.count-1 LOOP
      if vFlds(i).type='C' then
        if p_SQL is not null then
          vcursor:='select max(length('||vFlds(i).realname||')) from ('||p_SQL||')';
        else
          vcursor:='select max(length('||vFlds(i).realname||')) from '||p_tname;
        end if;
        open col_cur for vCursor;
        fetch col_cur into vlenfld;
        close col_cur;
        if vlenfld=0 then vlenfld:=1; end if;
        vFlds(i).length := vlenfld;
      end if;
    end loop;
  end if;                   

  if p_SQL is null then 
    vcursor:='select count(*) from '||upper(p_schema)||'.'||upper(p_tname);
    if p_where_clause is not null then
      vcursor:=vcursor||' where '||p_where_clause;
    end if;
  else
    vcursor:='select count(*) from ('||p_SQL||')';
  end if;   

  open col_cur for vCursor;
  fetch col_cur into l_hdr.no_records;
  close col_cur;

  l_hdr.version:='03';
  l_hdr.year:=to_number(to_char(sysdate,'yyyy'))-1900;
  l_hdr.month:=to_number(to_char(sysdate,'mm'));
  l_hdr.day:=to_number(to_char(sysdate,'dd'));
  l_hdr.rec_len:=1; -- to be set later
  l_hdr.no_fields:=vFlds.COUNT;
  --l_hdr.hdr_len:=to_char((l_hdr.no_fields*32)+33),'FM000x');
  l_hdr.hdr_len:=(l_hdr.no_fields*32)+33;

end;

procedure put_rows (p_tname IN  varchar2,
                    p_file in UTL_FILE.file_type,
                    p_where_clause in varchar2,
                    vFlds in field_descriptor_array,
                    p_SQL in varchar2 DEFAULT '',
                    p_trim in boolean  default false)

is  
    type rc is ref cursor;
    vpos integer;
    cur rc;
    i  integer:=0;
    vSelectList  VARCHAR2(32767):='';
    v_cur VARCHAR2(32767);
    fld_qry varchar2(100);
    tmp_row varchar2(32767);
    t_raw raw(32767);
    vfrmt varchar2(100);
begin
    
  for l in 0..vFlds.count-1 loop
    fld_qry := vFlds(l).realname;
    
    if p_trim is null then
      vSelectList:= vSelectList || '||' ||
                    case
                      when l=0 then
                        ''' ''||'
                    else
                      '||'
                    end||
                    'rpad(NVL('||
                    case
                      when vFlds(l).realtype in ('D', 'N','T') then
                        'replace(to_char ('
                      end
                      ||' '||fld_qry||' '|| 
  --               case when vFlds(l).type='D' then ', ''yyyymmdd HH24:MI''' end||
                   case
                    when vFlds(l).realtype='T' then
                      ', ''HH24:MI:SS'''
                   end||
                   
                   case
                    when vFlds(l).realtype ='D' then
                      --', ''dd.mm.yyyy'''
                      ', ''yyyymmdd'''
                   end||
                   
                   case
                    when vFlds(l).realtype in ('D', 'N','T') then
                      '),'','',''.'')'
                   end
                   ||','' ''),'||
                   vFlds(l).length||
                   ','' '')';
    else
      vSelectList:= vSelectList || '||' ||
                      case
                        when l=0 then
                          ''' ''||'
                      else
                        '||'
                      end||
                      'rpad(NVL('||
                      case
                        when vFlds(l).realtype in ('D', 'N','T') then
                          'replace(to_char ('
                        end||
                      case
                        when vFlds(l).realtype ='C' then
                          'rpad(substr('
                      end  
                      ||' '||fld_qry||' '|| 
                      case
                        when vFlds(l).realtype ='C' then
                          ',1,'||vFlds(l).length||'),'||
                          vFlds(l).length||','' '')'
                      end||
  --               case when vFlds(l).type='D' then ', ''yyyymmdd HH24:MI''' end||
  --                 case when vFlds(l).realtype='D' then ', ''dd.mm.yyyy HH24:MI:SS''' end||
--                     /*
                     case
                       when vFlds(l).realtype='D' then
--                         ', ''dd.mm.yyyy'''
                         ', ''yyyymmdd'''
                     end||
--                     */
                     case
                       when vFlds(l).realtype='T' then
                         ', ''HH24:MI:SS'''
                     end||
                     case
                       when vFlds(l).realtype in ('D','N','T') then
                         '),'','',''.'')'
                     end
                     ||','' ''),'||
                     vFlds(l).length||
                     ','' '')';
    end if;
  end loop;
  
  vSelectList := replace(vSelectList,'||||','||');
  vSelectList := trim(vSelectList);
  
  vpos:=instr(vSelectList,'||');
  
  if vpos=1 then
    vSelectList:=substr(vSelectList,3);
  end if;
  
  if p_SQL is not null then
    v_cur:='select '||vSelectList||' from ('||p_SQL||')';
  else
    v_cur:='select '||vSelectList||' from '||p_tname;
  end if;

  if p_where_clause is not null then
      v_cur:=v_cur||' where '||p_where_clause;
  end if;
      
  open cur for v_cur;

  i:=0;
  t_raw:='';
  loop
    
    fetch cur into tmp_row;
    exit when cur%notfound;
              
    --   tmp_row := convert(tmp_row, 'CL8MSWIN1251', 'RU8PC866');

    tmp_row := convert(tmp_row, 'CL8MSWIN1251', 'AL32UTF8');
              
    --   tmp_row := convert(tmp_row, 'AL32UTF8', 'RU8PC866');

    --        if oem_convert then
    --            tmp_row:=CONVERT (tmp_row, 'RU8PC866', 'CL8MSWIN1251');
    --        end if;
              
    for l in 0..trunc(length(tmp_row)/2000) loop
      if utl_raw.LENGTH(t_raw)>(32767-4000) then
        utl_file.PUT_RAW(p_file,t_raw,true);
        t_raw:='';
      end if;
      t_raw:=utl_raw.CONCAT(t_raw,utl_raw.cast_to_raw(substr(tmp_row,2000*l+1,2000)));
    end loop;

  end loop;
  utl_file.PUT_RAW(p_file,t_raw,true);
  utl_file.FFLUSH(p_file);
  close cur;
    
end;
                       


/*  p_dir IN VARCHAR2 - директория куда будет сохранен файл
    p_file IN VARCHAR2 - название файла,
    p_schema in varchar2, - название схемы 
    p_tname IN VARCHAR2 название таблицы из которой будет идти выгрузка,
    p_cnames IN VARCHAR2 - список полей для выгрузки (в нужном порядке),
    p_colnames IN VARCHAR2- название полей которые будут в dbf файле (порядок должен соответствовать p_cnames)
               если не задано то берется из параметра p_cnames,
    p_where_clause - условие выборки
    p_sql - текст SQL запроса (значение p_where_clause игнорируется)
    P_coltype in varchar2 - типы полей в которые должна идти выгрузка (соответствует p_colnames)
                            D - дата
                            N - число
                            C - строка
                            T - время (выгружается в отдельное поле в строковом формате)
    P_colsize in varchar2 - размерность полей в которые должна идти выгрузка (соответствует p_colnames)
                            для даты - всегда 8 символов (без времени)
                            для строки - сколько указано
                            для числа допускается значение с указанием точности 
                            (кол-во знаков в дробной части) через разделитель "."
    p_show IN BOOLEAN DEFAULT FALSE - debug режим (по аналогии с dbase_pkg.load_table)
    p_trim - если TRUE то автоматически определяется максимальная длина значения столбца и
        устанавливается размер поля (только для символьных значений)
    
    т.е. либо задана таблица и используется условие where либо запрос 
    включающий условие (тогда значение p_where_clause игнорируется)
*/
/* варианты вызова :
1. “аблица, список полей, типы и длины
  p_dir  =>  CUBE_DIR
  p_file  =>  TEST.DBF
  p_schema  =>  CORP_MOBILE
  p_tname  =>  CALL_09_2015
  p_cnames  =>  SUBSCR_NO,START_TIME,CALL_COST,DBF_ID
  p_colnames  =>  SUBSCR_NO,START_TIME,CALL_COST,DBF_ID1   ( названия колонок )
  p_where_clause  =>  subscr_no='123'
  p_sql    
  p_coltype  =>  C,D,N,N     (если тип или длина не заданы то они определяются автоматически)
  p_colsize  =>  11,8,8,38
  p_show    
  p_trim    
2. –езультат запроса, заданный параметром p_sql
  Enabled  p_dir  String  CUBE_DIR
  Enabled  p_file  String  TEST.DBF
  Enabled  p_schema  String  CORP_MOBILE
  Enabled  p_tname  String  CALL_09_2015
  Enabled  p_cnames  String  SUBSCR_NO,START_TIME,CALL_COST,DBF_ID
  Enabled  p_colnames  String  SUBSCR_NO1,START_TIME1,CALL_COST1,DBF_ID1
  Enabled  p_where_clause  String  
  Enabled  p_sql  String  select SUBSCR_NO,START_TIME,CALL_COST,DBF_ID from CALL_09_2015 
      все поля должны быть проименованны ( select FUNC() AS FIELD1, ... from ... )
      и имена полей соответствовать перечисленным в параметре p_cnames
      параметр p_where_clause не используется
  Enabled  p_coltype  String  C,D,N,N
  Enabled  p_colsize  String  11,20,15.3,38
  Enabled  p_show  Integer  
  Enabled  p_trim  Integer   определяется маскимальная длина значения каждой текстовой строки и 
      уменьшается ширина текстовых столбцов в результирующем файле 
*/  

/*
  ПРИМЕР ВЫЗОВА
  
  dump_table(p_dir    => 'DIR_BILL_FOR_1C',
    p_file    =>    'TEST_20151208.DBF',
    p_schema    =>    'schema_name',
    p_tname    =>    'V_BILLS', 
    p_cnames    =>    'INN,BILL_SUMM,BILL_DATE',
    p_colnames    =>    'INN,BILL_SUMM,BILL_DATE',
    p_coltype    =>    'C,N,D',  
    p_colsize    =>    '12,10.2,20',
    p_sql => c_SQL_TEXT,
    p_show => TRUE
    
    );
*/

procedure dump_table ( p_dir          in varchar2,
                       p_file         in varchar2,
                       p_schema       in varchar2,
                       p_tname        in varchar2,
                       p_cnames       in varchar2 DEFAULT '',
                       p_colnames     IN VARCHAR2 DEFAULT '',
                       p_where_clause in varchar2 DEFAULT '',
                       p_SQL          in varchar2 DEFAULT '',
                       p_coltype      in varchar2 DEFAULT '',
                       p_colsize      in varchar2 DEFAULT '',
                       p_show         IN BOOLEAN DEFAULT FALSE,
                       p_trim         in boolean  default false
                     )
is
    l_hdr dbf_header;
    vFlds field_descriptor_array;
    vRow  rowarray;
    v_cnames  VARCHAR2(4000);
    v_outputfile UTL_FILE.file_type;
    vCount int;
    vStartTime  DATE;
    vEndTime    DATE;
    no_rec_hex varchar2(8);
    hdr_len_hex varchar2(4);
    rec_len_hex varchar2(4);
    enc varchar(2);
    
    vstr varchar2(32767):='';
    vstr1 varchar2(32767):='';
    vstr2 varchar2(32767):='';
    vlen integer;
    vlen1 integer;
    
    p_convert      boolean := false;
    
    vCode integer;
    
begin
  vStartTime:=sysdate;
  oem_convert:=p_convert;
     
  put_header( p_schema,
              p_tname,
              p_cnames,
              p_colnames,
              p_trim,
              p_where_clause,
              p_SQL,
              p_coltype,
              p_colsize,
              l_hdr,
              vFlds
            );

  v_outputfile := utl_file.fopen(p_dir,p_file,'wb',32767);
      
  for i in 0..vFlds.count-1 loop
    l_hdr.rec_len:=l_hdr.rec_len+vFlds(i).length;
  end loop;

  rec_len_hex:=to_char(l_hdr.rec_len,'FM000x');

  no_rec_hex :=to_char(l_hdr.no_records,'FM0000000x');

  hdr_len_hex:=to_char(l_hdr.hdr_len,'FM000x');

  if big_endian then
    rec_len_hex:=substr(rec_len_hex,-2)||
                 substr(rec_len_hex,1,2);

    no_rec_hex:=substr(no_rec_hex,-2)||
                substr(no_rec_hex,5,2)||
                substr(no_rec_hex,3,2)||
                substr(no_rec_hex,1,2);

    hdr_len_hex:=substr(hdr_len_hex,-2)||
                 substr(hdr_len_hex,1,2);
  end if;

  if oem_convert then
    enc:='26';
  else
    enc:='57';
  end if;
      
  vstr1 := rpad(l_hdr.version||
            to_char(l_hdr.year,'FM0x')||
            to_char(l_hdr.month,'FM0x')||
            to_char(l_hdr.day,'FM0x')||
            no_rec_hex||
            hdr_len_hex||  
            rec_len_hex  ,
            58,'0')   --  58
            || utl_raw.cast_to_raw(chr(201))
          --  ||enc
            ||'0000';
      
  --  vstr1:=substr(vstr1,1,28)||utl_raw.cast_to_raw(chr(201))||substr(vstr1,31);
      
  utl_file.put_raw( v_outputFile, vstr1 );
                
  utl_file.Fflush(v_outputFile);     

  for i in 0..vFlds.count-1 loop
        
    utl_file.put_raw(
                      v_outputFile, 
                      utl_raw.cast_to_raw(rpad(substr(vFlds(i).name,1,10),11,chr(0)))||
                      utl_raw.cast_to_raw(vFlds(i).type)||'00000000'||
     --     utl_raw.cast_to_raw('C')||'00000000'||    
              
                      to_char(vFlds(i).length,'FM0x')||
                      to_char(nvl(vFlds(i).decimals,0),'FM0x')||
                      utl_raw.cast_to_raw(rpad(chr(0),14,chr(0))) 
      );
          
      utl_file.Fflush(v_outputFile);
          
  end loop;

  -- terminator for the field names
  utl_file.put_raw(v_outputFile,'0D');

  put_rows(p_tname,v_outputFile,p_where_clause,vFlds,p_SQL,p_trim);

  --if utl_file.IS_OPEN(v_outputFile ) then
   UTL_FILE.FCLOSE(v_outputFile);
  --end if;

  vEndTime := sysdate;

--    dbms_output.put_line('Started - '||to_char(vStartTime,'HH24:MI'));
--    dbms_output.put_line('Finished - '||to_char(vEndTime,'HH24:MI'));
end;

  
END;
/

GRANT EXECUTE ON DBASE_PKG TO BUSINESS_COMM_ROLE;
