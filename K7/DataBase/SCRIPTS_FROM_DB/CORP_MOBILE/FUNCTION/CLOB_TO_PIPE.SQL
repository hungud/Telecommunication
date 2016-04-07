
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."CLOB_TO_PIPE" (year_T  in integer,
                                        month_t in integer,
                                        phone_t in varchar2)
  RETURN clob_tbl_pipe
  pipelined AS
  line_t   t_line_clob := t_line_clob(NULL, NULL, NULL, NULL);
  cl       clob;
  l_amount pls_integer := 1;
  l_length pls_integer;
  token    varchar2(4000);
  sobch    varchar2(4000);
BEGIN
  select loader3_pckg.GET_PHONE_DETAIL(year_T, month_t, phone_t)
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
      select to_date(substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)) || ' ' ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 2) + 1,
                            instr(sobch, chr(9), 1, 3) -
                            (instr(sobch, chr(9), 1, 2) + 1)),
                     'dd.mm.yyyy hh24:mi:ss')
        into line_t.start_time
        from dual;
      select substr(sobch, instr(sobch, chr(9), 1, 3) + 1, 1)
        into line_t.call_type
        from dual;
      select to_number(substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1)),
                       '99999999D9999',
                       ' NLS_NUMERIC_CHARACTERS = '',.''')
        into line_t.dur
        from dual;
      select to_number(substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1)),
                       '99999999D9999',
                       ' NLS_NUMERIC_CHARACTERS = '',.''')
        into line_t.costc
        from dual;
      pipe ROW(line_t);
      sobch := null;
    elsif i = l_length then
      sobch := sobch || token;
      select to_date(substr(sobch,
                            instr(sobch, chr(9), 1, 1) + 1,
                            instr(sobch, chr(9), 1, 2) -
                            (instr(sobch, chr(9), 1, 1) + 1)) || ' ' ||
                     substr(sobch,
                            instr(sobch, chr(9), 1, 2) + 1,
                            instr(sobch, chr(9), 1, 3) -
                            (instr(sobch, chr(9), 1, 2) + 1)),
                     'dd.mm.yyyy hh24:mi:ss')
        into line_t.start_time
        from dual;
      select substr(sobch, instr(sobch, chr(9), 1, 3) + 1, 1)
        into line_t.call_type
        from dual;
      select to_number(substr(sobch,
                              instr(sobch, chr(9), 1, 6) + 1,
                              instr(sobch, chr(9), 1, 7) -
                              (instr(sobch, chr(9), 1, 6) + 1)),
                       '99999999D9999',
                       ' NLS_NUMERIC_CHARACTERS = '',.''')
        into line_t.dur
        from dual;
      select to_number(substr(sobch,
                              instr(sobch, chr(9), 1, 7) + 1,
                              instr(sobch, chr(9), 1, 8) -
                              (instr(sobch, chr(9), 1, 7) + 1)),
                       '99999999D9999',
                       ' NLS_NUMERIC_CHARACTERS = '',.''')
        into line_t.costc
        from dual;
      pipe ROW(line_t);
    else
      sobch := sobch || token;
    end if;
  end loop;
  RETURN;
END;
