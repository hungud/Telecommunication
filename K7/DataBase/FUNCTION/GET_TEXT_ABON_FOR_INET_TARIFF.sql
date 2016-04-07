CREATE OR REPLACE FUNCTION GET_TEXT_ABON_FOR_INET_TARIFF(pPHONE IN VARCHAR2) RETURN varchar2 IS

	--Version 1
	--
	--v1. 22.05.2015 Алексеев. Функция оповещения о необходимости пополнения счета, когда баланс по номеру меньше абонентской платы
	
    shab varchar2(200 char);
    month_name varchar2(20 char);
    sms_text varchar2(200 char);
BEGIN
    sms_text := '';
    --шаблон сообщения
    shab:= MS_params.GET_PARAM_VALUE('TEXT_ABON_FOR_INET_TARIFF');
    --определяем месяц
    month_name:= CONVERT_PCKG.MONTH_NAME (to_number(to_char(SYSDATE, 'MM'))+1);
    --замена шаблонов подставными параметрами
    shab:= replace(shab, '%new_date%', '01.'||to_char(add_months(sysdate, 1), 'mm.yyyy'));    
    shab:=replace(shab, '%month_name%', month_name);
    --отбор необходимого номера и вывод результатат
    --отбираются только интернет тарифы и drive
    for rec in (
                        select 
                            vc.PHONE_NUMBER_FEDERAL, 
                            vc.MONTHLY_PAYMENT
                        from
                        (
                            select v.PHONE_NUMBER_FEDERAL,  v.MONTHLY_PAYMENT
                              from V_PHONE_UNL_INET_BAL_LESS_ABON v
                            where v.PHONE_NUMBER_FEDERAL = pPHONE
                            union all    
                            select c.PHONE_NUMBER_FEDERAL, c.MONTHLY_PAYMENT
                              from v_drave_info c
                            where c.PHONE_NUMBER_FEDERAL = pPHONE        
                        ) vc
                        where ROWNUM < 2
                  )
    loop
      sms_text:=replace(shab, '%abon_sum%', to_char(rec.MONTHLY_PAYMENT));
    end loop; 
    return sms_text;       
END;