CREATE OR REPLACE FORCE VIEW V_PERIODS
AS
select
--
--#version= 2
--
--v.2 Афросин 10.11.2015 переделал вьюху на таблицу
--v.1 Кочнев
--
      YEARS, 
      MONTHS, 
      YEAR_MONTH, 
      IS_ACTIVE,
      YEAR_MONTH_NAME    
     from(
            SELECT
              years,
              p.months,
              year_month,
              is_active,
              N.RUS_NAME || ' - '||years  year_month_name
            FROM
              periods p,
              MONTH_NAME N
             WHERE
              P.MONTHS = N.MONTHS(+)
           );



GRANT SELECT ON V_PERIODS TO BUSINESS_COMM_ROLE;

GRANT SELECT ON V_PERIODS TO BUSINESS_COMM_ROLE_RO;