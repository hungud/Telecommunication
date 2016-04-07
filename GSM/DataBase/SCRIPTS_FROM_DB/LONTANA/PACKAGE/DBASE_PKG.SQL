
  CREATE OR REPLACE PACKAGE "LONTANA"."DBASE_PKG" AS
  -- Используется при загрузке протоколов ведения больного из DBF
  --
  --#Version=7
  --
  -- 7. Афросин дбавил функцию получения количества строк в файле   
  -- 6. Уколов. Поправил перекодирование Windows 1251 в UTF-8.
  -- 5. Уколов. Добавил перекодирование Windows 1251 в UTF-8.
  -- 2 - доработана Уколовым
  -- 3. 12.09.2006. При загрузке дат выполняется проверка - если дата не в формате YYYYMMDD,
  --    то преобразуется в NULL
  --4. Николаев. 01.11.2012. Переписано определение заголовка.
  --
  -- procedure to a load a table with records
  -- from a DBASE file.
  --
  -- Uses a BFILE to read binary data and dbms_sql
  -- to dynamically insert into any table you
  -- have insert on.
  --
  -- p_dir is the name of an ORACLE Directory Object
  --       that was created via the CREATE DIRECTORY
  --       command
  --
  -- p_file is the name of a file in that directory
  --        will be the name of the DBASE file
  --
  -- p_tname is the name of the table to load from
  --
  -- p_cnames is an optional list of comma separated
  --          column names.  If not supplied, this pkg
  --          assumes the column names in the DBASE file
  --          are the same as the column names in the
  --          table
  --
  -- p_show boolean that if TRUE will cause us to just
  --        PRINT (and not insert) what we find in the
  --        DBASE files (not the data, just the info
  --        from the dbase headers....)
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
  
END;
CREATE OR REPLACE PACKAGE BODY "LONTANA"."DBASE_PKG" AS
  -- Might have to change on your platform!!!
  -- Controls the byte order of binary integers read in
  -- from the dbase file
  BIG_ENDIAN CONSTANT BOOLEAN DEFAULT TRUE;
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
    decimals INT -- 1 byte scale
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
      l_insert_statement := l_insert_statement || ',' || to_char(p_DBF_id);
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
                       
  
  
END;