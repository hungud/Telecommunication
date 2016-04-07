
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."HOT_BILLING_PIPE_DBF" (p_dir      IN VARCHAR2,
                       p_file     IN VARCHAR2)  return CALL_TEMP_TAB PIPELINED
                       AS
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
    no_records PLS_INTEGER, -- number of records in file,
    -- 4 byte int
    hdr_len PLS_INTEGER, -- length of header, 2 byte int
    rec_len PLS_INTEGER, -- number of bytes in record,
    -- 2 byte int
    no_fields PLS_INTEGER -- number of fields
    );
  TYPE field_descriptor IS RECORD(
    name     VARCHAR2(11),
    TYPE     CHAR(1),
    LENGTH   INTEGER, -- 1 byte length
    OFFSET   INTEGER,
    decimals INTEGER -- 1 byte scale
    );
  TYPE field_descriptor_array IS TABLE OF field_descriptor INDEX BY BINARY_INTEGER;
  TYPE rowArray IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;
  TYPE field_index_array IS TABLE OF BINARY_INTEGER INDEX BY BINARY_INTEGER;
  --
  l_offset PLS_INTEGER DEFAULT 1;
  l_hdr    dbf_header;
  l_flds   field_descriptor_array;
  l_field_index_array field_index_array;
  l_row    rowArray;
  flag     integer;
  --i        PLS_INTEGER;
  l_row_number        NUMBER;
  l_bfile BFILE;
  l_data  BLOB;
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
    l_data_raw        raw(32767);
    l_n         PLS_INTEGER DEFAULT 2;
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
          p_flds(i).OFFSET := l_n;
          l_n := l_n + p_flds(i).LENGTH;
        end if;
      end if;
    END LOOP;
    p_bfile_offset := p_bfile_offset +
                      MOD(p_hdr.hdr_len - l_hdr_size, l_field_desc_size);
  END;

  PROCEDURE get_row(p_bfile        IN DATAFILE,
                   p_bfile_offset IN OUT NUMBER,
                   p_hdr          IN dbf_header,
                   p_flds         IN field_descriptor_array,
                   p_field_index_array IN field_index_array,
                   l_row IN OUT NOCOPY rowArray       ) IS
  
    l_data      VARCHAR2(4000);
--    l_row       rowArray;
    l_NumberRow NUMBER; -- by Roman
    l_StringRow VARCHAR2(255); -- by Roman
    l_TEST_DATE DATE;
    l_field_type CHAR(1);
    v_varchar   VARCHAR2(32767);
    v_start     PLS_INTEGER := p_bfile_offset;
    v_buffer    PLS_INTEGER := 32767;
  BEGIN
    l_data := utl_raw.cast_to_varchar2(dbms_lob.SUBSTR(p_bfile,
                                                       p_hdr.rec_len,
                                                       p_bfile_offset));
    l_data := CONVERT(l_data, 'AL32UTF8', 'CL8MSWIN1251');
    p_bfile_offset := p_bfile_offset + p_hdr.rec_len;
    l_row(0) := SUBSTR(l_data, 1, 1);
    if l_row(0) <> chr(26) then
      FOR i IN p_field_index_array.first .. p_field_index_array.last LOOP
        l_row(i) := TRIM(SUBSTR(l_data, p_flds(p_field_index_array(i)).OFFSET, p_flds(p_field_index_array(i)).LENGTH));
        -- by Roman, jan.2004, Slovenia
        -- Because of different NLS_LANG parameters, an error occured with message: INVALID NUMBER.
        -- Because the type rowArray is consisted of strings, we have to change TO REAL (SYSTEM) DECIMAL CHARACTER.
        -- Some could use , and someone could use .
        -- So, what I do here:
        -- I convert the string value of number to number value and that back to string value.
        l_field_type := p_flds(p_field_index_array(i)).TYPE;
        IF l_field_type = 'F' OR l_field_type = 'N' THEN
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
        -- End Roman
        ELSIF l_field_type='F' THEN 
          IF l_row(i) = '.' THEN
            l_row(i) := NULL;
          END IF;
        ELSIF l_field_type='D' THEN
          BEGIN
            l_TEST_DATE := TO_DATE(l_row(i), 'YYYYMMDD');
          EXCEPTION
            WHEN OTHERS THEN
              l_row(i) := NULL;
          END;
        END IF;
      END LOOP;
    end if;
    --RETURN l_row;
  END get_row;
  --
  FUNCTION GET_FIELD_INDEX(l_flds   field_descriptor_array, FIELD_NAME VARCHAR2) RETURN PLS_INTEGER IS
  BEGIN
    FOR I IN l_flds.FIRST..l_flds.LAST LOOP
      IF l_flds(I).NAME = FIELD_NAME THEN
        RETURN I;
      END IF;
    END LOOP;
    RAISE_APPLICATION_ERROR(-20000, 'Поле '||FIELD_NAME||' не найдено в DBF файле');
  END;
  --
  BEGIN
    l_bfile := BFILENAME(p_dir, p_file);
    dbms_lob.fileopen(l_bfile);
    dbms_lob.createtemporary(l_data, TRUE);
    dbms_lob.loadfromfile(l_data, l_bfile, dbms_lob.GETLENGTH(l_bfile));
    get_header(l_data, l_offset, l_hdr, l_flds);
      -- Определим индексы нужных полей
  -- 'SUBSCR_NO,CH_SEIZ_DT,AT_FT_CODE,AT_CHG_AMT,CALLING_NO,DURATION,DATA_VOL,IMEI,CELL_ID,DIALED_DIG,AT_FT_DESC'
    l_field_index_array(1) := GET_FIELD_INDEX(l_flds, 'SUBSCR_NO');
    l_field_index_array(2) := GET_FIELD_INDEX(l_flds, 'CH_SEIZ_DT');
    l_field_index_array(3) := GET_FIELD_INDEX(l_flds, 'AT_FT_CODE');
    l_field_index_array(4) := GET_FIELD_INDEX(l_flds, 'AT_CHG_AMT');
    l_field_index_array(5) := GET_FIELD_INDEX(l_flds, 'CALLING_NO');
    l_field_index_array(6) := GET_FIELD_INDEX(l_flds, 'DURATION');
    l_field_index_array(7) := GET_FIELD_INDEX(l_flds, 'DATA_VOL');
    l_field_index_array(8) := GET_FIELD_INDEX(l_flds, 'IMEI');
    l_field_index_array(9) := GET_FIELD_INDEX(l_flds, 'CELL_ID');
    l_field_index_array(10) := GET_FIELD_INDEX(l_flds, 'DIALED_DIG');
    l_field_index_array(11) := GET_FIELD_INDEX(l_flds, 'AT_FT_DESC');
    --
    FOR l_row_number IN 1 .. l_hdr.no_records LOOP
      get_row(l_data, l_offset, l_hdr, l_flds, l_field_index_array, l_row);
      if l_row(0) = chr(26) then
        exit;
      end if;
      IF (l_row(0) <> '*') -- deleted record
      THEN
        PIPE ROW(
          CALL_TEMP_TYPE(
            l_row(1),
            l_row(2),
            l_row(3),
            l_row(4),
            l_row(5),
            l_row(6),
            l_row(7),
            l_row(8),
            l_row(9),
            l_row(10),
            l_row(11),
            NULL
            )
          );
      END IF;
    END LOOP;
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