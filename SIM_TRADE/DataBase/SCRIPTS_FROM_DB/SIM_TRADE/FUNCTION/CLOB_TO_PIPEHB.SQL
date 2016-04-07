
  CREATE OR REPLACE FUNCTION "SIM_TRADE"."CLOB_TO_PIPEHB" (year_T  in integer,
                                        month_t in integer,
                                        phone_t in varchar2)
  RETURN CALL_TEMP_TAB
  pipelined AS
  line_t   CALL_TEMP_TYPE := CALL_TEMP_TYPE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  cl       clob;
  l_amount pls_integer := 1;
  l_length pls_integer;
  token    varchar2(4000);
  sobch    varchar2(4000);
  y number :=0;
BEGIN
  select LOADER3_PCKG.GET_SITE_PHONE_DETAIL(year_T, month_t, phone_t)

    into cl
    from dual;
  l_length := dbms_lob.getlength(cl);
  for i in 1 .. l_length loop
    dbms_lob.read(lob_loc => cl,
                  amount  => l_amount,
                  offset  => i,
                  buffer  => token);
   if (token = chr(10)) /*or (token = chr(13)) */
     then
       y:=y+1;
      if y>=3 then
      select phone_t
        into line_t.subscr_no
        from dual;
      select to_char(to_date(substr(sobch,
                            1,
                            instr(sobch, chr(9), 1, 1) - 1) ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)),'dd.mm.yyyyhh24:mi:ss'),'yyyymmddhh24miss')
        into line_t.ch_seiz_dt
        from dual;
        
       select substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1))
        into line_t.at_chg_amt
        from dual;  
     
      select substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1))
        into line_t.calling_no
        from dual;
        
          select nvl(regexp_replace(substr(sobch,
                              instr(sobch, chr(9), 1, 2) + 1,
                              instr(sobch, chr(9), 1, 3) -
                              (instr(sobch, chr(9), 1, 2) + 1)),':',''),'000000')
        into line_t.duration
        from dual;  
        
          select substr(sobch,
                              instr(sobch, chr(9), 1, 8) + 1,
                              instr(sobch, chr(9), 1, 9) -
                              (instr(sobch, chr(9), 1, 8) + 1))
        into line_t.data_vol
        from dual;  
        
        select substr(sobch,
                              instr(sobch, chr(9), 1, 3) + 1,
                              instr(sobch, chr(9), 1, 4) -
                              (instr(sobch, chr(9), 1, 3) + 1))
        into line_t.dialed_dig
        from dual;  
        select substr(sobch,
                              instr(sobch, chr(9), 1, 4) + 1,
                              instr(sobch, chr(9), 1, 5) -
                              (instr(sobch, chr(9), 1, 4) + 1))
        into line_t.at_ft_desc
        from dual;          

        select 7529
        into line_t.dbf_id
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 9) + 1,
                              6)
        into line_t.cell_id
        from dual;
        
        pipe ROW(line_t);
      end if;
      sobch := null;
    elsif i = l_length then
      sobch := sobch || token;
      select phone_t
        into line_t.subscr_no
        from dual;
      select to_char(to_date(substr(sobch,
                            1,
                            instr(sobch, chr(9), 1, 1) - 1) ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)),'dd.mm.yyyyhh24:mi:ss'),'yyyymmddhh24miss')
        into line_t.ch_seiz_dt
        from dual;
        
       select substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1))
        into line_t.at_chg_amt
        from dual;  
     
      select substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1))
        into line_t.calling_no
        from dual;
        
          select regexp_replace(substr(sobch,
                              instr(sobch, chr(9), 1, 2) + 1,
                              instr(sobch, chr(9), 1, 3) -
                              (instr(sobch, chr(9), 1, 2) + 1)),':','')
        into line_t.duration
        from dual;  
        
          select substr(sobch,
                              instr(sobch, chr(9), 1, 8) + 1,
                              instr(sobch, chr(9), 1, 9) -
                              (instr(sobch, chr(9), 1, 8) + 1))
        into line_t.data_vol
        from dual;  
        
        select substr(sobch,
                              instr(sobch, chr(9), 1, 3) + 1,
                              instr(sobch, chr(9), 1, 4) -
                              (instr(sobch, chr(9), 1, 3) + 1))
        into line_t.dialed_dig
        from dual;  
        select substr(sobch,
                              instr(sobch, chr(9), 1, 4) + 1,
                              instr(sobch, chr(9), 1, 5) -
                              (instr(sobch, chr(9), 1, 4) + 1))
        into line_t.at_ft_desc
        from dual;          

        select 7529
        into line_t.dbf_id
        from dual;
        select substr(sobch,
                              instr(sobch, chr(9), 1, 9) + 1,
                              6)
        into line_t.cell_id
        from dual;
        
        pipe ROW(line_t);
    else
      sobch := sobch || token;
    end if;
  end loop;
  RETURN;
END;