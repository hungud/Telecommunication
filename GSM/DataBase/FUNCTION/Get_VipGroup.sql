CREATE OR REPLACE FUNCTION LONTANA.Get_VipGroup(pPHONE_NUMBER IN VARCHAR2) RETURN NUMBER IS
tmpVar NUMBER;
/******************************************************************************
   NAME:       GetVipGroup
  v.2 Кочнев
******************************************************************************/
VGP                   Varchar2(600);
--VGT                   Varchar2(600);
--VGA                   Varchar2(600);
TXT                   Varchar2(20000);

UseFirstParam         Varchar2(1);
UseSecondParam        Varchar2(1);
UseThirdParam         Varchar2(1);
UseThird_Param        Varchar2(1);
UseForthParam         Varchar2(1);
Bracket1              Varchar2(1);
Bracket2              Varchar2(1);
Bracket3              Varchar2(1); 
Bracket4              Varchar2(1);
Bracket5              Varchar2(1);

ValFirstParam         NUMBER;
ValSecondParam        NUMBER;
ValThirdParam         NUMBER;
ValThirdParamPeriod1  NUMBER;
ValThirdParamPeriod2  NUMBER;
Param1_2              NUMBER;
Param2_3              NUMBER;
Param3_4              NUMBER;
RezultFirstParam      NUMBER;
RezultSecondParam     NUMBER;
RezultThirdParam      NUMBER;
RezultForthParam      NUMBER;

BEGIN
  tmpVar := 0;
  --RETURN tmpVar;
  
  ValFirstParam  := 0;
  ValSecondParam := 0;
  
  select value into VGP from PARAMS where NAME = 'VIP_GROUP_PARAMS';
  
  UseFirstParam  := substr(VGP,1,1);
  UseSecondParam := substr(VGP,4,1);
  UseThirdParam  := substr(VGP,7,1);
  UseForthParam  := substr(VGP,30,1);
  
  if UseFirstParam = '1' then -- телефон должен быть незаблокирован сохраненное количество месяцев
    ValFirstParam := to_number(ltrim(rtrim(substr(VGP,2,2))))+1; -- запомнили ItemIndex, значение отличается на +1;
    
    TXT := 
      'select count(1) 
          from v_contracts v,
               db_loader_account_phones ph,
               ACCOUNT_VIPGROUP av,                                                   
               TARIFS_VIPGROUP tv           
         where PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)
           and V.PHONE_NUMBER_FEDERAL = '''||pPHONE_NUMBER||'''
           and V.CONTRACT_CANCEL_DATE is null                                        
           and V.PHONE_NUMBER_FEDERAL = ph.phone_number
           and V.TARIFF_ID = tv.TARIFF_ID 
           and ph.account_id = av.account_id 
           and (not exists (select 1 
                              from DB_LOADER_ACCOUNT_PHONE_HISTS           
                             where PHONE_IS_ACTIVE = 0                            
                               and phone_number = V.PHONE_NUMBER_FEDERAL      
                               and end_date >= trunc(add_months(sysdate,-'||ValFirstParam||'))                                    
                           )) '; 
    execute immediate txt into RezultFirstParam ;
  end if;

  if UseSecondParam = '1' then -- договор по телефону должен быть заведен более сохраненного количества месяцев
    ValSecondParam := to_number(ltrim(rtrim(substr(VGP,5,2))))+1; -- запомнили ItemIndex, значение отличается на +1;
     TXT := 
    'select count(1) 
          from v_contracts v,
               db_loader_account_phones ph,
               ACCOUNT_VIPGROUP av,                                                   
               TARIFS_VIPGROUP tv           
         where PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)
           and V.PHONE_NUMBER_FEDERAL = '''||pPHONE_NUMBER||'''
           and V.CONTRACT_CANCEL_DATE is null                                        
           and V.PHONE_NUMBER_FEDERAL = ph.phone_number
           and V.TARIFF_ID = tv.TARIFF_ID 
           and ph.account_id = av.account_id 
           and V.CONTRACT_DATE <= add_months(sysdate,-'||ValSecondParam||')'; 
    execute immediate TXT into RezultSecondParam;                              
  end if;

  if UseThirdParam = '1' then -- за указанный период начисленнаю сумма должна быть больше абонентской платы по тарифу на сохраненное количество рублей
    ValThirdParam := to_number(ltrim(rtrim(substr(VGP,8,5))));
    UseThird_Param := substr(VGP,13,1); -- учитывать дополнительный параметр в третьем условии
    ValThirdParamPeriod1 := to_number(ltrim(rtrim(substr(VGP,14,6))));
    ValThirdParamPeriod2 := to_number(ltrim(rtrim(substr(VGP,20,6)))); 
    if UseThird_Param = '1' then
     TXT := 
          'select count(1)  
             from db_loader_bills lb, IOT_BALANCE_HISTORY IO, v_contracts v, ACCOUNT_VIPGROUP av, TARIFS_VIPGROUP tv
            where lb.phone_number  = '''||pPHONE_NUMBER||'''                                    
              and V.CONTRACT_CANCEL_DATE is null 
              and V.PHONE_NUMBER_FEDERAL = lb.phone_number
              and IO.PHONE_NUMBER = lb.PHONE_NUMBER                                   
              and V.TARIFF_ID = tv.TARIFF_ID 
              and lb.account_id = av.account_id
              and IO.last_update = (select max(last_update) 
                                      from IOT_BALANCE_HISTORY IB 
                                     where IB.PHONE_NUMBER = lb.phone_number                          
                                       and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH)
                                       and ((lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) >  '||ValThirdParam||' and                            
                                             lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||') 
                                            and (NVL(IO.BALANCE,0)>=0 AND lb.bill_sum<>0) ';
       execute immediate TXT into RezultThirdParam;
    end if;
    if UseThird_Param = '0' then
       TXT := 
          'select count(1)  
             from db_loader_bills lb, IOT_BALANCE_HISTORY IO, v_contracts v, ACCOUNT_VIPGROUP av, TARIFS_VIPGROUP tv
            where lb.phone_number  = '''||pPHONE_NUMBER||'''                                    
              and V.CONTRACT_CANCEL_DATE is null 
              and V.PHONE_NUMBER_FEDERAL = lb.phone_number
              and IO.PHONE_NUMBER = lb.PHONE_NUMBER                                   
              and V.TARIFF_ID = tv.TARIFF_ID 
              and lb.account_id = av.account_id
              and IO.last_update = (select max(last_update) 
                                      from IOT_BALANCE_HISTORY IB 
                                     where IB.PHONE_NUMBER = lb.phone_number                          
                                       and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH)
                                       and ((lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) >  '||ValThirdParam||' and                            
                                             lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||') ';
       execute immediate TXT into RezultThirdParam;
    end if;
  end if;
  
  if UseForthParam = '1' then
    TXT := 
           'select count(1) 
                   from v_contracts v,
                   tariffs t
             where  V.PHONE_NUMBER_FEDERAL = '''||pPHONE_NUMBER||'''  
               and V.CONTRACT_CANCEL_DATE is null                                      
               and CHECK_PHONE_DAILY_ABON_PAY(V.PHONE_NUMBER_FEDERAL,''='') = 0   
              and V.TARIFF_ID = t.TARIFF_ID 
              and (NVL(T.DISCR_SPISANIE,0) = 0)';
    execute immediate txt into RezultForthParam ;          
  end if;         

  Param1_2 := to_number(ltrim(rtrim(substr(VGP,26,2)))); -- 0 = 'AND'; 1 = 'OR'
  Param2_3 := to_number(ltrim(rtrim(substr(VGP,28,2)))); -- 0 = 'AND'; 1 = 'OR'
  Param3_4 := to_number(ltrim(rtrim(substr(VGP,31,2)))); -- 0 = 'AND'; 1 = 'OR'

  Bracket1 := substr(VGP,33,1);
  Bracket2 := substr(VGP,34,1);
  Bracket3 := substr(VGP,35,1);
  Bracket4 := substr(VGP,36,1);
  Bracket5 := substr(VGP,37,1);

 
  if UseFirstParam = '1' then 
    if UseSecondParam = '1' then 
      if UseThirdParam = '1' then
        if UseForthParam = '1' then -- и первый, и второй, и третий, и четвертый
          
          if Param1_2 = 0 then
          
            if Param2_3 = 0 then 
              if Param3_4 = 0 then 
                if (((RezultFirstParam = 1) and (RezultSecondParam = 1)) and (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              else  -- if Param3_4 = 1   
                if (((RezultFirstParam = 1) and (RezultSecondParam = 1)) and (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              end if;
            else --if Param2_3 =1   
              if Param3_4 = 0 then 
                if (((RezultFirstParam = 1) and (RezultSecondParam = 1)) or (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              else -- -- if Param3_4 = 1 
                if (((RezultFirstParam = 1) and (RezultSecondParam = 1)) or (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              end if; -- if Param3_4 = 0 
            end if; -- if Param2_3 = 0
          
          else  -- if Param1_2 = 1
          
            if Param2_3 = 0 then 
               if Param3_4 = 0 then 
                 if (((RezultFirstParam = 1) or (RezultSecondParam = 1)) and (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
               else -- if Param3_4 = 0
                 if (((RezultFirstParam = 1) or (RezultSecondParam = 1)) and (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
               end if;--if Param3_4 = 0  
            else -- if Param2_3 = 1
               if Param3_4 = 0 then 
                 if (((RezultFirstParam = 1) or (RezultSecondParam = 1)) or (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
               else -- if Param3_4 = 0
                 if (((RezultFirstParam = 1) or (RezultSecondParam = 1)) or (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
               end if;--if Param3_4 = 0  
            end if;-- if Param2_3 = 0
          
          end if; -- if Param1_2 = 0
        
        else --if UseForthParam = '0' -- нет четвертого
             -- первый второй и третий
          if UseFirstParam = '1' then 
            if UseSecondParam = '1' then 
              if UseThirdParam = '1' then
                  -- первый второй третий
                if Param1_2 = 0 then
                  if Param2_3 = 0 then 
                     if ((RezultFirstParam = 1) and (RezultSecondParam = 1)) and (RezultThirdParam = 1) then
                       tmpVar := 1;
                     end if;  
                  else --  if Param2_3 = 0
                     if ((RezultFirstParam = 1) and (RezultSecondParam = 1)) or (RezultThirdParam = 1) then
                         tmpVar := 1;
                     end if;   
                  end if;  --  if Param2_3 = 0
                else  --Param1_2 = 1
                  if Param2_3 = 0 then 
                    if ((RezultFirstParam = 1) or (RezultSecondParam = 1)) and (RezultThirdParam = 1) then
                        tmpVar := 1;
                    end if;  
                  else  -- if Param2_3 = 0
                    if ((RezultFirstParam = 1) or (RezultSecondParam = 1)) or (RezultThirdParam = 1) then
                      tmpVar := 1;
                    end if;  
                  end if; -- if Param2_3 = 0
                end if; --Param1_2 = 1 
                
              else  --if UseThirdParam = '0'
              -- первый и второй
                if Param1_2 = 0 then  
                  if (RezultFirstParam = 1) and (RezultSecondParam = 1) then
                    tmpVar := 1;
                  end if;  
                else  -- if Param1_2 = 0
                  if (RezultFirstParam = 1) or (RezultSecondParam = 1) then
                    tmpVar := 1;
                  end if;  
                end if; --if Param1_2 = 0
              
              end if; --if UseThirdParam = '1'
                
            else  --if UseSecondParam = '1'
                    
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
              end if; --if UseThirdParam = '1' 
              
            end if; --if UseSecondParam = '1'
                        
            if UseSecondParam = '0' and UseThirdParam = '0' then
             -- первый только
                if (RezultFirstParam = 1) then
                  tmpVar := 1;
                end if;  
            end if;
          else -- if UseFirstParam = '1' -- второй и третий
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
              
              else  -- if UseThirdParam = '1' только второй
                if (RezultSecondParam = 1) then
                  tmpVar := 1;
                end if;  
              
              end if; -- if UseThirdParam = '1'-- только второй
            
            else --if UseSecondParam = '1'
               -- третий только
              if (RezultThirdParam = 1) then
                tmpVar := 1;
              end if;
            end if; --if UseSecondParam = '1'
          
          end if; -- if UseFirstParam = '1'
           
        end if; -- if UseForthParam = '1'  
      else --if UseThirdParam = '1' 
           --нет третьего - первый второй и четвертый  
      ----------------------------------------------------------------   
        if UseFirstParam = '1' then 
          if UseSecondParam = '1' then 
            if UseForthParam = '1' then
                -- первый второй четвертый
              if Param1_2 = 0 then
                if Param3_4 = 0 then 
                  if ((RezultFirstParam = 1) and (RezultSecondParam = 1)) and (RezultForthParam = 1) then
                       tmpVar := 1;
                  end if;  
                else  -- if Param3_4 = 0
                  if ((RezultFirstParam = 1) and (RezultSecondParam = 1)) or (RezultForthParam = 1) then
                       tmpVar := 1;
                  end if;  
                end if;-- if Param3_4 = 0
              else  --Param1_2 = 1
                if Param3_4 = 0 then 
                  if ((RezultFirstParam = 1) or (RezultSecondParam = 1)) and (RezultForthParam = 1) then
                       tmpVar := 1;
                  end if;  
                else  -- if Param3_4 = 0
                  if ((RezultFirstParam = 1) or (RezultSecondParam = 1)) or (RezultForthParam = 1) then
                       tmpVar := 1;
                  end if;  
                end if;  -- if Param3_4 = 0
              end if; --Param1_2 = 1
            else  --  if UseForthParam = '1' 
              -- первый и второй
              if Param1_2 = 0 then  
                if (RezultFirstParam = 1) and (RezultSecondParam = 1) then
                  tmpVar := 1;
                end if;  
              else -- if Param1_2 = 0 
                if (RezultFirstParam = 1) or (RezultSecondParam = 1) then
                  tmpVar := 1;
                end if;  
              end if; -- if Param1_2 = 0 
            end if;  --if UseForthParam = '1' 
          else  -- if UseSecondParam = '1'
            if UseForthParam = '1' then 
              -- первый и четвертый 
              if Param2_3 = 0 then 
                if (RezultFirstParam = 1) and (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              else  -- if Param2_3 = 0
                if (RezultFirstParam = 1) or (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              end if; -- if Param2_3 = 0 
            end if;  
          end if;  --if UseSecondParam = '1'
          if UseSecondParam = '0' and RezultForthParam = '0' then
           -- первый только
            if (RezultFirstParam = 1) then
              tmpVar := 1;
            end if;  
          end if;
        else -- if UseFirstParam = '1' второй и четвертый
          if UseSecondParam = '1' then 
            if UseForthParam = '1' then 
              if Param2_3 = 0 then
                if (RezultSecondParam = 1) and (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              else
                if (RezultSecondParam = 1) or (RezultForthParam = 1) then
                  tmpVar := 1;
                end if;  
              end if;
            end if;
            -- только второй
            if (RezultSecondParam = 1) then
              tmpVar := 1;
            end if;  
          else
             -- четвертый только
             if (RezultForthParam = 1) then
               tmpVar := 1;
             end if;
          end if;
        end if; --if UseFirstParam = '1' 
      -------------------------------------------------------   
      end if; --if UseThirdParam = '1' then
    
    else -- if UseSecondParam = '1' then  -- нет второго
             -- первый третий и четвертый 
     ---------------------------------------
      if UseFirstParam = '1' then 
        if UseThirdParam = '1' then 
          if UseForthParam = '1' then
            -- первый третий и четвертый
            if Param2_3 = 0 then
              if Param3_4 = 0 then 
                 if ((RezultFirstParam = 1) and (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              else
                 if ((RezultFirstParam = 1) and (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              end if;
            else  --Param1_2 = 1
              if Param2_3 = 0 then 
                 if ((RezultFirstParam = 1) or (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              else
                 if ((RezultFirstParam = 1) or (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              end if;
            end if; 
          else
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
        else
          if UseForthParam = '1' then 
         -- первый и четвертый 
            if Param3_4 = 0 then 
              if (RezultFirstParam = 1) and (RezultForthParam = 1) then
                tmpVar := 1;
              end if;  
            else
              if (RezultFirstParam = 1) or (RezultForthParam = 1) then
                tmpVar := 1;
              end if;  
            end if; 
          end if;  
        end if;
        if UseThirdParam = '0' and UseForthParam = '0' then
       -- первый только
            if (RezultFirstParam = 1) then
              tmpVar := 1;
            end if;  
        end if;
      else -- четвертый и третий
        if UseThirdParam = '1' then 
           if UseForthParam = '1' then 
             if Param3_4 = 0 then
               if (RezultThirdParam = 1) and (RezultForthParam = 1) then
                 tmpVar := 1;
               end if;  
             else
               if (RezultThirdParam = 1) or (RezultForthParam = 1) then
                 tmpVar := 1;
               end if;  
             end if;
          end if;
          -- только четвертый
             if (RezultForthParam = 1) then
               tmpVar := 1;
             end if;  
        else
         -- третий только
           if (RezultThirdParam = 1) then
              tmpVar := 1;
            end if;
        end if;
      end if;
     ---------------------------------------
    end if; -- if UseSecondParam = '1' then
  else  -- if UseFirstParam = '1' 
  ---ьез первой второй третий и четвертый
  ----------------------------------------
      if UseSecondParam = '1' then 
        if UseThirdParam = '1' then 
          if UseForthParam = '1' then
            --  второй третий четвертый
            if Param2_3 = 0 then
              if Param3_4 = 0 then 
                 if ((RezultSecondParam = 1) and (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              else
                 if ((RezultSecondParam = 1) and (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              end if;
            else  --Param1_2 = 1
              if Param3_4 = 0 then 
                 if ((RezultSecondParam = 1) or (RezultThirdParam = 1)) and (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              else
                 if ((RezultSecondParam = 1) or (RezultThirdParam = 1)) or (RezultForthParam = 1) then
                   tmpVar := 1;
                 end if;  
              end if;
            end if; 
          else
          -- второй и третий
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
        else
          if UseForthParam = '1' then 
         -- второй и четвертый 
            if Param3_4 = 0 then 
              if (RezultSecondParam = 1) and (RezultForthParam = 1) then
                tmpVar := 1;
              end if;  
            else
              if (RezultSecondParam = 1) or (RezultForthParam = 1) then
                tmpVar := 1;
              end if;  
            end if; 
          end if;  
        end if;
        if UseThirdParam = '0' and RezultForthParam = '0' then
       -- второй только
            if (RezultSecondParam = 1) then
              tmpVar := 1;
            end if;  
        end if;
      else -- второй и третий
        if UseThirdParam = '1' then 
           if UseForthParam = '1' then 
             if Param3_4 = 0 then
               if (RezultThirdParam = 1) and (RezultForthParam = 1) then
                 tmpVar := 1;
               end if;  
             else
               if (RezultThirdParam = 1) or (RezultForthParam = 1) then
                 tmpVar := 1;
               end if;  
             end if;
          end if;
          -- только третий
             if (RezultThirdParam = 1) then
               tmpVar := 1;
             end if;  
        else
         -- четвертый только
           if (RezultForthParam = 1) then
              tmpVar := 1;
            end if;
        end if;
      end if;
  -----------------------------------------
  end if; --if UseFirstParam = '1' then
  
     

  RETURN tmpVar;
 --  EXCEPTION
  --   WHEN NO_DATA_FOUND THEN
   --    NULL;
   --  WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
   --    RAISE;
END Get_VipGroup;
/
