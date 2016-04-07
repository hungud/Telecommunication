
  CREATE OR REPLACE FUNCTION "LONTANA"."EXPORT_TABLE_TO_CSV" (
    p_sql  VARCHAR2
)  RETURN  CLOB  IS

    v_cursor_id integer;
    v_col_cnt integer;
    v_ind  NUMBER;
    lvar_output  NUMBER := 0;
    v_columns  dbms_sql.desc_tab;
    v_tmp  T_VARCHAR2_4000_TAB;
    v_csv  CLOB;

BEGIN
    IF   p_sql  IS NULL  THEN
        RETURN  NULL;
    END IF;

BEGIN    
    v_csv := '';
    v_tmp := T_VARCHAR2_4000_TAB();
    v_cursor_id := dbms_sql.open_cursor;
    dbms_sql.parse( v_cursor_id, p_sql, dbms_sql.native );
    dbms_sql.describe_columns( v_cursor_id, v_col_cnt, v_columns );

    FOR  v_pos  IN  1 .. v_columns.count  LOOP
        v_tmp.extend();
        dbms_sql.define_column( v_cursor_id, v_pos, v_tmp( v_pos ), 20 );
    END LOOP;

    v_ind := dbms_sql.execute( v_cursor_id );

    LOOP
        v_ind := dbms_sql.fetch_rows( v_cursor_id );
        EXIT WHEN  v_ind = 0;
        lvar_output := lvar_output + 1;
        
        FOR  v_col_seq  IN  1 .. v_columns.count  LOOP
            v_tmp( v_col_seq ):= '';
            dbms_sql.column_value( v_cursor_id, v_col_seq, v_tmp( v_col_seq ) );
            v_csv := v_csv || (v_tmp( v_col_seq ) || chr( 9 ));
        END LOOP;
        v_csv := v_csv || (chr( 12 ) || chr( 10 ));
    END LOOP;

    dbms_sql.close_cursor( v_cursor_id );

EXCEPTION WHEN OTHERS THEN
    dbms_sql.close_cursor( v_cursor_id );
    raise;
END;

    RETURN  v_csv;
END;