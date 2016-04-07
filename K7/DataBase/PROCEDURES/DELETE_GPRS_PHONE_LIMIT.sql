CREATE OR REPLACE PROCEDURE DELETE_GPRS_PHONE_LIMIT AS
  
  --Version 1
  --
  --v.1 29.01.2016 Алексеев. Процедура удаления номеров из ограничений в случае расторжения договора
  
  pCount integer;
begin
  --из ограничения отбираем номера, у которых договор расторгнут или сменился
  select count(*) 
     into pCount
    from GPRS_PHONE_LIMIT ph
  where exists (
                          select 1
                            from GPRS_PHONE_LIMIT lm
                          where not exists (
                                                      select 1
                                                        from v_contracts v,
                                                                tariffs tr 
                                                      where V.PHONE_NUMBER_FEDERAL = LM.PHONE_NUMBER
                                                          and V.CONTRACT_CANCEL_DATE is null
                                                          and V.TARIFF_ID = TR.TARIFF_ID
                                                          and nvl(TR.IS_AUTO_INTERNET, 0) = 1
                                                          and V.CONTRACT_ID = lm.CONTRACT_ID
                                                  )
                              and LM.PHONE_NUMBER = ph.PHONE_NUMBER
                     );
                     
  --если имеются номера для удаления, то удаляем
  if nvl(pCount, 0) <> 0 then
    delete from GPRS_PHONE_LIMIT ph
    where exists (
                          select 1
                            from GPRS_PHONE_LIMIT lm
                          where not exists (
                                                      select 1
                                                        from v_contracts v,
                                                                tariffs tr 
                                                      where V.PHONE_NUMBER_FEDERAL = LM.PHONE_NUMBER
                                                          and V.CONTRACT_CANCEL_DATE is null
                                                          and V.TARIFF_ID = TR.TARIFF_ID
                                                          and nvl(TR.IS_AUTO_INTERNET, 0) = 1
                                                          and V.CONTRACT_ID = lm.CONTRACT_ID
                                                  )
                              and LM.PHONE_NUMBER = ph.PHONE_NUMBER
                     );                     
    commit;
  end if;                     
end;