CREATE OR REPLACE FUNCTION Get_VipGroup(pPHONE_NUMBER IN VARCHAR2) RETURN NUMBER IS
tmpVar NUMBER;
/******************************************************************************
   NAME:       GetVipGroup
  v.1 Кочнев
******************************************************************************/
VGP                   Varchar2(600);
VGT                   Varchar2(600);
VGA                   Varchar2(600);
TXT                   Varchar2(20000);

UseFirstParam         Varchar2(1);
UseSecondParam        Varchar2(1);
UseThirdParam         Varchar2(1);
UseThird_Param        Varchar2(1);
ValFirstParam         NUMBER;
ValSecondParam        NUMBER;
ValThirdParam         NUMBER;
ValThirdParamPeriod1  NUMBER;
ValThirdParamPeriod2  NUMBER;
Param1_2              NUMBER;
Param2_3              NUMBER;
RezultFirstParam      NUMBER;
RezultSecondParam     NUMBER;
RezultThirdParam     NUMBER;

BEGIN
  tmpVar := 0;
  ValFirstParam  := 0;
  ValSecondParam := 0;
  
  select value into VGA from PARAMS where NAME = 'VIP_GROUP_ACCOUNT';
  
  select value into VGT from PARAMS where NAME = 'VIP_GROUP_TARIFS';

  select value into VGP from PARAMS where NAME = 'VIP_GROUP_PARAMS';
  
  UseFirstParam  := substr(VGP,1,1);
  UseSecondParam := substr(VGP,4,1);
  UseThirdParam  := substr(VGP,7,1);
  
  if UseFirstParam = '1' then -- телефон должен быть незаблокирован сохраненное количество месяцев
    ValFirstParam := to_number(ltrim(rtrim(substr(VGP,2,2))))+1; -- запомнили ItemIndex, значение отличается на +1;
    
    TXT := 
    'select count(1) from (select max(h.end_date) as max_date 
              from DB_LOADER_ACCOUNT_PHONE_HISTS h,
                   v_contracts v,
                   db_loader_account_phones ph   
             where h.PHONE_IS_ACTIVE = 0 
               and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)
               and h.PHONE_NUMBER = PH.PHONE_NUMBER 
               and h.phone_number = '''||pPHONE_NUMBER||
               ''' and V.CONTRACT_CANCEL_DATE is null                                        
               and V.PHONE_NUMBER_FEDERAL = h.phone_number
               and V.TARIFF_ID in ('||VGT||') 
               and ph.account_id in ('||VGA||') ) 
     where trunc(max_date) <= trunc(add_months(sysdate,-'||ValFirstParam||'))';
     
    execute immediate txt into RezultFirstParam ;
    
  end if;

  if UseSecondParam = '1' then -- договор по телефону должен быть заведен более сохраненного количества месяцев
    ValSecondParam := to_number(ltrim(rtrim(substr(VGP,5,2))))+1; -- запомнили ItemIndex, значение отличается на +1;
     
     TXT := 
    'select count(1)  
      from 
         (select V.CONTRACT_ID 
            from v_contracts v,
                 db_loader_account_phones ph   
           where V.CONTRACT_CANCEL_DATE is null
             and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)
             and V.CONTRACT_DATE <= add_months(sysdate,-'||ValSecondParam||') 
             and V.TARIFF_ID in ('||VGT||') 
             and ph.account_id in ('||VGA||')
             and V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER
             and V.PHONE_NUMBER_FEDERAL = '''||pPHONE_NUMBER||''')';
    execute immediate TXT into RezultSecondParam;                              
  end if;



  if UseThirdParam = '1' then -- за указанный период начисленнаю сумма должна быть больше абонентской платы по тарифу на сохраненное количество рублей
    ValThirdParam := to_number(ltrim(rtrim(substr(VGP,8,5))));
    UseThird_Param := substr(VGP,13,1); -- учитывать дополнительный параметр в третьем условии
    ValThirdParamPeriod1 := to_number(ltrim(rtrim(substr(VGP,14,6))));
    ValThirdParamPeriod2 := to_number(ltrim(rtrim(substr(VGP,20,6)))); 
    
    if UseThird_Param = '1' then
     TXT := 
      'select count(1) from 
                              (
                               select 1 
                                 from db_loader_bills lb,
                                      v_contracts v,
                                      V_DEBIT_AND_CREDIT v1, 
                                      IOT_BALANCE_HISTORY IO 
                                       where (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) < '||ValThirdParam||' 
                                         and lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||' 
                                         and lb.phone_number = '''||pPHONE_NUMBER||'''
                                         and V.CONTRACT_CANCEL_DATE is null  
                                         and V.PHONE_NUMBER_FEDERAL = lb.phone_number
                                         and V.TARIFF_ID in ('||VGT||') 
                                         and lb.account_id in ('||VGA||')
                                         and V1.PHONE_NUMBER        = lb.phone_number                                     
                                         and IO.PHONE_NUMBER        = lb.PHONE_NUMBER                                     
                                         and v1.YEAR_MONTH          = lb.YEAR_MONTH      
                                         and IO.last_update         =
                                                            (select max(last_update)                                               
                                                               from IOT_BALANCE_HISTORY IB                                        
                                                              where IB.PHONE_NUMBER = lb.phone_number                             
                                                                and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH
                                                            )
                                         and NVL(IO.BALANCE,0)>=0 AND V1.BEELINE_BILL<>0 
                              )';
            execute immediate TXT into RezultThirdParam;
    end if;
    
    if UseThird_Param = '0' then
       
       TXT := 
      'select count(1) from 
                              (
                               select 1 
                                 from db_loader_bills lb,
                                      v_contracts v
                                       where (lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) < '||ValThirdParam||' 
                                         and lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||' 
                                         and lb.phone_number = '''||pPHONE_NUMBER||'''
                                         and lb.account_id in ('||VGA||')
                                         and V.CONTRACT_CANCEL_DATE is null  
                                         and V.PHONE_NUMBER_FEDERAL = lb.phone_number
                                         and V.TARIFF_ID in ('||VGT||') 
                              )';
       execute immediate TXT into RezultThirdParam;
    end if;
                              
                                         
  end if;

  Param1_2 := to_number(ltrim(rtrim(substr(VGP,26,2)))); -- 0 = 'AND'; 1 = 'OR'
  Param2_3 := to_number(ltrim(rtrim(substr(VGP,28,2)))); -- 0 = 'AND'; 1 = 'OR'
 
  if UseFirstParam = '1' then 
    if UseSecondParam = '1' then 
      if UseThirdParam = '1' then
        -- первый второй третий
        if Param1_2 = 0 then
          if Param2_3 = 0 then 
             if (RezultFirstParam = 1) and (RezultSecondParam = 1) and (RezultThirdParam = 1) then
               tmpVar := 1;
             end if;  
          else
             if (RezultFirstParam = 1) and (RezultSecondParam = 1) or (RezultThirdParam = 1) then
               tmpVar := 1;
             end if;  
          end if;
        else  --Param1_2 = 1
          if Param2_3 = 0 then 
             if (RezultFirstParam = 1) or (RezultSecondParam = 1) and (RezultThirdParam = 1) then
               tmpVar := 1;
             end if;  
          else
             if (RezultFirstParam = 1) or (RezultSecondParam = 1) or (RezultThirdParam = 1) then
               tmpVar := 1;
             end if;  
          end if;
        end if; 
      else
      -- первый и второй
        if Param1_2 = 0 then  
          if (RezultFirstParam = 1) and (RezultSecondParam = 1) then
            tmpVar := 1;
          end if;  
        else
          if (RezultFirstParam = 1) or (RezultSecondParam = 1) then
            tmpVar := 1;
          end if;  
        end if;
      end if;
    else
      if UseThirdParam = '1' then 
     -- первый и третий 
        if Param2_3 = 0 then 
          if (RezultFirstParam = 1) and (RezultThirdParam = 1) then
            tmpVar := 1;
          end if;  
        else
          if (RezultFirstParam = 1) or (RezultThirdParam = 1) then
            tmpVar := 1;
          end if;  
        end if; 
      end if;  
    end if;
    if UseSecondParam = '0' and UseThirdParam = '0' then
   -- первый только
        if (RezultFirstParam = 1) then
          tmpVar := 1;
        end if;  
    end if;
  else -- второй и третий
    if UseSecondParam = '1' then 
       if UseThirdParam = '1' then 
         if Param2_3 = 0 then
           if (RezultSecondParam = 1) and (RezultThirdParam = 1) then
             tmpVar := 1;
           end if;  
         else
           if (RezultSecondParam = 1) or (RezultThirdParam = 1) then
             tmpVar := 1;
           end if;  
         end if;
      end if;
      -- только второй
         if (RezultSecondParam = 1) then
           tmpVar := 1;
         end if;  
    else
     -- третий только
       if (RezultThirdParam = 1) then
          tmpVar := 1;
        end if;
    end if;
    null;
  end if;

  RETURN tmpVar;
 --  EXCEPTION
  --   WHEN NO_DATA_FOUND THEN
   --    NULL;
   --  WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
   --    RAISE;
END Get_VipGroup;
/