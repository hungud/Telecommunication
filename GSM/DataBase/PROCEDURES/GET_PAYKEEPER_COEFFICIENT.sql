CREATE OR REPLACE FUNCTION GET_PAYKEEPER_COEFFICIENT RETURN NUMBER IS
  -- Version1
  --v1 - 13.05.2015 - Матюнин И. - Определяем коэффициент пересчета платежей PayKeeper 
  vRES number;
BEGIN  
  vRES :=  TO_NUMBER2 (
                          nvl(
                              MS_PARAMS.GET_PARAM_VALUE('PAYKEEPER_COEFFICIENT'),
                              '1' -- елси коэффициент не задан, то берем 1
                             )
                      );
  return vRES;                      
END;