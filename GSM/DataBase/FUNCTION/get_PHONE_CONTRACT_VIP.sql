CREATE OR REPLACE FUNCTION get_PHONE_CONTRACT_VIP

RETURN PHONE_CONTRACT_TAB 
AS

l_tab                 PHONE_CONTRACT_TAB := PHONE_CONTRACT_TAB();

VGP                   Varchar2(600);
TXT                   Varchar2(20000);
--TXT1                   Varchar2(20000);

UseFirstParam         Varchar2(1);
UseSecondParam        Varchar2(1);
UseThirdParam         Varchar2(1);
UseThird_Param        Varchar2(1);
UseForthParam         Varchar2(1);
ValFirstParam         NUMBER;
ValSecondParam        NUMBER;
ValThirdParam         NUMBER;
ValThirdParamPeriod1  NUMBER;
ValThirdParamPeriod2  NUMBER;
Param1_2              NUMBER;
Param2_3              NUMBER;
Param3_4              NUMBER;
Bracket1              Varchar2(1);
Bracket2              Varchar2(1);
Bracket3              Varchar2(1); 
Bracket4              Varchar2(1);
Bracket5              Varchar2(1);

--RezultFirstParam      NUMBER;
--RezultSecondParam     NUMBER;
--RezultThirdParam      NUMBER;
--RezultForthParam      NUMBER;

BEGIN
  TXT := ' ';
  ValSecondParam := 0;
  
  select value into VGP from PARAMS where NAME = 'VIP_GROUP_PARAMS';
  
  UseFirstParam  := substr(VGP,1,1);
  UseSecondParam := substr(VGP,4,1);
  UseThirdParam  := substr(VGP,7,1);
  UseForthParam  := substr(VGP,30,1);
  Param1_2       := to_number(ltrim(rtrim(substr(VGP,26,2)))); -- 0 = 'AND'; 1 = 'OR'
  Param2_3       := to_number(ltrim(rtrim(substr(VGP,28,2)))); -- 0 = 'AND'; 1 = 'OR'
  Param3_4       := to_number(ltrim(rtrim(substr(VGP,31,2)))); -- 0 = 'AND'; 1 = 'OR'
  ValFirstParam  := to_number(ltrim(rtrim(substr(VGP,2,2))))+1; 
  ValSecondParam := to_number(ltrim(rtrim(substr(VGP,5,2))))+1;
  ValThirdParam := to_number(ltrim(rtrim(substr(VGP,8,5))));
  UseThird_Param := substr(VGP,13,1); -- учитывать дополнительный параметр в третьем условии
  ValThirdParamPeriod1 := to_number(ltrim(rtrim(substr(VGP,14,6))));
  ValThirdParamPeriod2 := to_number(ltrim(rtrim(substr(VGP,20,6)))); 
  Bracket1 := substr(VGP,33,1);
  Bracket2 := substr(VGP,34,1);
  Bracket5 := substr(VGP,35,1);
  Bracket3 := substr(VGP,36,1);
  Bracket4 := substr(VGP,37,1);
    
  
 TXT := 'select cast(MULTISET(
                                select distinct V.PHONE_NUMBER_FEDERAL, V.CONTRACT_ID                                        
                                  from v_contracts v,                                                         
                                       tariffs t,                                                             
                                       db_loader_account_phones ph,                                           
                                       db_loader_bills lb,                                                    
                                       ACCOUNT_VIPGROUP av,                                                   
                                       TARIFS_VIPGROUP tv,
                                       IOT_BALANCE_HISTORY IO 
                                 where V.TARIFF_ID = T.TARIFF_ID                                             
                                   and V.CONTRACT_CANCEL_DATE is null                                        
                                   and V.PHONE_NUMBER_FEDERAL = PH.PHONE_NUMBER                              
                                   and V.PHONE_NUMBER_FEDERAL = lb.phone_number 
                                   and V.TARIFF_ID = tv.TARIFF_ID                              
                                   and PH.YEAR_MONTH = (select max(year_month) from db_loader_account_phones)
                                   and ph.account_id = av.account_id  
                                   and IO.PHONE_NUMBER = lb.PHONE_NUMBER  
                                   and IO.last_update = (select max(last_update) 
                                                           from IOT_BALANCE_HISTORY IB 
                                                          where IB.PHONE_NUMBER = lb.phone_number                          
                                                            and to_number(to_Char(last_update,''yyyymm'')) = lb.YEAR_MONTH)
                 and ( -- обща€ скобка';
  
    if Bracket1 <> '|' then
       TXT := TXT||'
                        '||Bracket1||' -- 1 скобка
                       ';
    end if;
    
    if Bracket2 <> '|' then
       TXT := TXT||'
                        '||Bracket2||' -- 2 скобка
                       ';
    end if;
    
    
    if UseFirstParam = '1' then -- телефон должен быть незаблокирован сохраненное количество мес€цев
      TXT := TXT||'
                        -- 1 условие
                       ';
      TXT := TXT||' (not exists (select 1 
                                       from DB_LOADER_ACCOUNT_PHONE_HISTS           
                                      where PHONE_IS_ACTIVE = 0                            
                                        and phone_number = V.PHONE_NUMBER_FEDERAL      
                                        and end_date >= trunc(add_months(sysdate,-'||ValFirstParam||')))) ';   
    end if;   --if UseFirstParam = '1'                                             
                         
    if Bracket5 <> '|' then
       TXT := TXT||'
                        '||Bracket5||' -- 5 скобка
                       ';
    end if;

    if UseSecondParam = '1' then -- договор по телефону должен быть заведен более сохраненного количества мес€цев 
      
      if UseFirstParam = '1' then
        if Param1_2 = 0 then
          TXT := TXT||' 
                        -- св€зка дл€ 2 услови€
                        and ';
        else             
          TXT := TXT||'
                        -- св€зка дл€ 2 услови€
                        or ';
        end if;
      end if; 
    
      TXT := TXT||' 
                      -- 2 условие 
                      (V.CONTRACT_DATE <= add_months(sysdate,-'||ValSecondParam||'))
                      ';
    end if;
   
    if Bracket3 <> '|' then
       TXT := TXT||'
                        '||Bracket3||' -- 3 скобка
                       ';
    end if;

    if UseThirdParam = '1' then -- за указанный период начисленнаю сумма должна быть больше абонентской платы по тарифу на сохраненное количество рублей
      if Param2_3 = 0 then
        TXT := TXT||' -- св€зка дл€ 3 услови€
                      and 
        ';
      else
        TXT := TXT||' -- св€зка дл€ 3 услови€
                      or 
        ';
      end if;

      if UseThird_Param = '0' then
       TXT := TXT||'              -- 3 условие 
                        ( 
                             ((lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) >  '||ValThirdParam||' and lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||' ) 
                        )';
      end if;  
      if UseThird_Param = '1' then
       TXT := TXT||'              -- 3 условие 
                        ( 
                             ((lb.bill_sum - lb.SUBSCRIBER_PAYMENT_MAIN) >  '||ValThirdParam||' and lb.YEAR_MONTH between '||ValThirdParamPeriod1||' and '||ValThirdParamPeriod2||' ) 
                         and (NVL(IO.BALANCE,0) >= 0 AND lb.bill_sum <> 0) 
                        )';
      end if;  
    END IF;
    
    
    if Bracket4 <> '|' then
       TXT := TXT||'
                        '||Bracket4||' -- 4 скобка
                       ';
    end if;

    if UseForthParam = '1' then
      
      if Param3_4 = 0 then
        TXT := TXT||'
                      -- св€зка дл€ 4 услови€
                      and 
        ';                
      else            
        TXT := TXT||'  
                      -- св€зка дл€ 4 услови€
                      or 
        ';
      end if;
      
      TXT := TXT||'              -- 4 условие 
                        (
                            CHECK_PHONE_DAILY_ABON_PAY(V.PHONE_NUMBER_FEDERAL,''='') = 0  
                         and (NVL(T.DISCR_SPISANIE,0) = 0)
                        )';
    
    end if;
    
 
         
  TXT :=  TXT||' 
                     ) -- обща€ скобка
                ) AS PHONE_CONTRACT_TAB) from dual';          
 
 --DBMS_OUTPUT.PUT_LINE(TXT); 
 
 EXECUTE IMMEDIATE TXT into l_tab;
 return l_tab;
end;