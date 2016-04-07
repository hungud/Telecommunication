CREATE OR REPLACE PROCEDURE CHECK_DB_LOADER_PHONE_STAT (
   p_month_to_check IN DATE DEFAULT TRUNC (SYSDATE, 'MM'))
IS
  --Version 3
  --
  --v3 ��������. ��������� ������. ������� �������� ���������
  --v2 ��������. ��������� ���� �� ������
  -- v1 - 14.01.2015 - ������� ����������(�������� ������� ���������)
   v_subscr_no VARCHAR2 (10);     
   v_sum         NUMBER;
   v_sum2        NUMBER;
   pDB             INTEGER;
   pCount     INTEGER;
   curnm         sys_refcursor;
BEGIN
  --��������� ������� HOT_BILLING_MONTH �� ������� ������ � ������
  SELECT count(DB)
  INTO pCount 
  FROM HOT_BILLING_MONTH
  WHERE YEAR_MONTH = to_number(to_char(p_month_to_check, 'YYYYMM'));  
  
  --���� � ������� HOT_BILLING_MONTH ������� ������ � ������, �� ���������� ������, ����� ������ �� ������
  IF pCount = 1 THEN
      --��������� ������ �������� ������� CALL �� ����
      SELECT NVL(DB, 0)
      INTO pDB 
      FROM HOT_BILLING_MONTH
      WHERE YEAR_MONTH = to_number(to_char(p_month_to_check, 'YYYYMM'));
      
      --���� ������� �� ��������� �� ����
      IF pDB = 1 THEN
        -- ��������� �� ���� ������� �� ������� CALL
        open curnm for 'SELECT DISTINCT subscr_no 
                                FROM CALL_'||to_char(p_month_to_check,'MM_YYYY');
        loop
          FETCH curnm INTO v_subscr_no;
          EXIT WHEN curnm%NOTFOUND;          
          --��������� �� ������ ������� ����������
          SELECT count(v_subscr_no)  
          INTO pCount
          FROM DB_LOADER_PHONE_STAT PS 
          WHERE PS.PHONE_NUMBER = v_subscr_no
          AND PS.YEAR_MONTH = to_number(to_char(p_month_to_check, 'YYYYMM'));
          --���� ���������� �� ������ ����, �� ���������� ����� � ����. CALL          
          IF pCount = 1 THEN
              --���������� ����� �� ������� CALL                          
              EXECUTE IMMEDIATE 'select sum(call_cost)  
                                              from 
                                              (select
                                                 c.servtype,c.servicedirection,decode(c.call_cost,0,0,1),count(*),
                                                 sum(c.call_cost) as call_cost, sum(c.COST_CHNG),
                                                 sum(decode(c.servtype,''C'',ceil(c.dur/60),''B'',ceil(c.dur/60),''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur)),
                                                 sum(decode(c.servtype,''C'',c.dur/60,''B'',c.dur/60,''G'',c.dur/1024,''W'',c.dur/1024/1024,c.dur))
                                               from 
                                               (select 
                                                  distinct subscr_no, start_time, at_ft_code,dbf_id, call_cost, costnovat, dur, imei, 
                                                  case at_ft_code
                                                    when ''CBIN'' then ''B''
                                                    when ''CBOUT'' then ''B''
                                                    else servicetype
                                                  end servtype, 
                                                  servicedirection, call_date, call_time, duration, dialed_dig,calling_no, at_chg_amt, data_vol,
                                                  cell_id, mn_unlim, insert_date,COST_CHNG 
                                                from CALL_'||to_char(p_month_to_check, 'mm_yyyy')||') c
                                                where c.start_time>(SELECT nvl(DB_LOADER_PCKG.GET_PHONE_BALANCE_DATE(:pv_subscr_no),trunc(sysdate,''mm'')-1/86400) FROM DUAL)
                                                and (c.servtype=''C'' or (c.servtype=''S'') or (c.servtype=''U'') or c.servtype=''G'' or c.servtype=''W'' or c.servtype=''B'')
                                                and c.subscr_no= :pv_subscr_no
                                                and ((c.call_cost=0 and not exists (select 1 
                                                                                                   from services s
                                                                                                   where s.feature_co=c.at_ft_code
                                                                                                   and s.not_use_for_calc=1))
                                                         or c.call_cost<>0)
                                                group by c.servtype,c.servicedirection,decode(c.call_cost,0,0,1))' INTO v_sum USING v_subscr_no, v_subscr_no;               
              --���������� ����� �� ������� DB_LOADER_PHONE_STAT
              SELECT sum(estimate_sum)  
              INTO v_sum2
              FROM DB_LOADER_PHONE_STAT PS 
              WHERE PS.PHONE_NUMBER = v_subscr_no
              AND PS.YEAR_MONTH = to_number(to_char(p_month_to_check, 'YYYYMM'));
              --���������� �����, ���� �� �������� - ��������� ����������
              IF (NVL(v_sum, 0) <> NVL(v_sum2, 0)) AND (v_subscr_no is not null) THEN
                 --��������� ����������
                 HOT_BILLING_PCKG.CalcDetailSumOpt (v_subscr_no,  to_date('01.'||to_char(p_month_to_check, 'MM.YYYY'), 'dd.mm.yyyy'));
                 --������ ����� �� �������� �������
                 INSERT INTO QUEUE_CURRENT_BALANCES(PHONE_NUMBER, QUEUE_TYPE) VALUES(v_subscr_no, 88);
                 commit;
              END IF;
          END IF;
        end loop;
        close curnm;   
      END IF;
  END IF;
END;
/
