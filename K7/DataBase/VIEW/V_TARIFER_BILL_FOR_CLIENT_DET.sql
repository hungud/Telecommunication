CREATE OR REPLACE FORCE VIEW V_TARIFER_BILL_FOR_CLIENT_DET AS 

select
--
--
-- Version = 3
--
-- v.3. јфросин 2015.12.09  поправка в получении date_end и date_begin
-- 2015.09.21  райнов. ѕравка по услугам дискретным, обработка ошибки, что у них нет дат.  
  
    
  V.YEAR_MONTH, 
  V.PHONE_NUMBER,
  -v.ROW_COST ABON_PAY, 
  case
    when (ROW_TYPE in(1,2)) and (INSTR(ROW_COMMENT, ' c ') > 0)  
      and (instr(V.ROW_COMMENT, 'списано за мес€ц') = 0) then
        to_date(SUBSTR(V.ROW_COMMENT, INSTR(ROW_COMMENT, ' c ')+3, 10), 'dd.mm.yyyy')
    
    when 
      (ROW_TYPE in(1, 2)) and (instr(V.ROW_COMMENT, 'списано за мес€ц') > 0) then
        v.ROW_DATE
  else
    null
  end date_begin,
  
  case
    when ROW_TYPE in (1, 2) AND (INSTR(ROW_COMMENT, ' по ') > 0) AND
        (instr(V.ROW_COMMENT, 'списано за мес€ц') = 0)
      then 
        to_date(SUBSTR(V.ROW_COMMENT, INSTR(ROW_COMMENT, ' по ')+ 4, 10), 'dd.mm.yyyy')

  else
    null
  end date_end,
  
  case
    when ROW_TYPE = 1 then 
      SUBSTR(V.ROW_COMMENT, INSTR(ROW_COMMENT, '(')+1, INSTR(ROW_COMMENT, ',') - INSTR(ROW_COMMENT, '(')-1)
    when ROW_TYPE = 2 then 
      SUBSTR(V.ROW_COMMENT, INSTR(ROW_COMMENT, '(')+1, INSTR(ROW_COMMENT, ')') - INSTR(ROW_COMMENT, '(') -1)
  else
    null
  end tariff_code,
  
  v.ROW_TYPE, 
  case
    when ROW_TYPE = 1 then
      null
    when ROW_TYPE = 2 then 
      SUBSTR(V.ROW_COMMENT, INSTR(ROW_COMMENT, '2 јбонплата за услугу ')+22, INSTR(ROW_COMMENT, '(') -24)
  else
    null
  end tariff_name
from
  TARIFER_BILL_FOR_CLIENT_DET V
where
  V.ROW_TYPE in (1, 2);

       