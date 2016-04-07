CREATE OR REPLACE PACKAGE Ms_TARIFFS AS
--
--#Version=1

type mtariffs_TARIFF_ID is Table of INTEGER;
type mtariffs_TARIFF_CODE is Table of VARCHAR2(30 CHAR)
 
procedure set_tariffmem;
  
END;
/

CREATE OR REPLACE PACKAGE BODY Ms_TARIFFS AS
--
     -- 14.01.2013 г. Пакет для оптимизации работы с тарифами

  procedure set_tariffmem is 
        begin
          execute immediate 'select TARIFF_ID, TARIFF_CODE FROM TARRIFS ' BULK COLLECT INTO mtariffs_TARIFF_ID, mtariffs_TARIFF_CODE;
        end;

 
  -- Одноразовая процедура, вызывается один раз при первом вызове пакета

BEGIN 

    Ms_TARIFFS.set_num_var('CRIT_SMS_COUNT', GET_PARAM_VALUE('CRIT_SMS_COUNT'));
       
END;
/
