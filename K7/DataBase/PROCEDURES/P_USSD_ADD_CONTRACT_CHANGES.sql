CREATE OR REPLACE PROCEDURE P_USSD_ADD_CONTRACT_CHANGES (
                                                          pPhone_number varchar2 default null,
                                                          pUSSD_CODE varchar2 default null
                                                        )
IS
--#Version =2
--
--v.2 17.07.2015 Афросин Добавил входные парметры для добавления изменения при отправке письма на мыло в процедуре P_USSD_CHANGE_PP_QUEUE
--v.1 13.07.2015 Афросин Добавил процедуру для заведения доп.договоров при смене ТП, заказаннйо по USSD
--
  cDOCUM_TYPE_ID CONSTANT INTEGER := 6; --СМЕНА ТАРИФА по USSD
  cFILIAL_ID  CONSTANT INTEGER := 49; --ИД филиала
  
  cUSSD_ADD_STATUS_ID CONSTANT USSD_CHANGE_CONTRACT_STATUS.USSD_CHANGE_CONTRACT_STATUS_ID%TYPE := 2; --доп.договор добавлен
  cUSSD_NO_ADD_STATUS_ID CONSTANT USSD_CHANGE_CONTRACT_STATUS.USSD_CHANGE_CONTRACT_STATUS_ID%TYPE := 3;--заявка обработана, доп договор не создан
  cUSSD_CAN_ADD_STATUS_ID CONSTANT USSD_CHANGE_CONTRACT_STATUS.USSD_CHANGE_CONTRACT_STATUS_ID%TYPE := 1;-- надо создать доп договор
  
  vUSSD_CHANGE_STATUS_ID USSD_CHANGE_PP_LOG.USSD_CHANGE_CONTRACT_STATUS_ID%TYPE;
   
  procedure ADD_CONTRACT_CHANGE (lPhoneNumber in varchar2, pUSSD in varchar2, pUSSD_CHANGE_STATUS_ID out USSD_CHANGE_PP_LOG.USSD_CHANGE_CONTRACT_STATUS_ID%TYPE)
  AS
    vCONTRACT_CHANGE_DATE CONTRACT_CHANGES.CONTRACT_CHANGE_DATE%TYPE;
    vCONTRACT_ID  CONTRACT_CHANGES.CONTRACT_ID%TYPE;
    vTARIFF_ID   CONTRACT_CHANGES.TARIFF_ID%TYPE;
    vTariffCode TARIFFS.TARIFF_CODE%TYPE;
    vERROR_MESSAGE varchar2(100 char);
  begin
    vCONTRACT_ID := PROG_SELECT_CONTRACT(lPhoneNumber) ;--GET_CURR_PHONE_TARIFF_ID(rec.PHONE_NUMBER);
    vCONTRACT_CHANGE_DATE := trunc(sysdate);
    vTariffCode := GET_TARIFF_CODE_BY_USSD(pUSSD, vERROR_MESSAGE, vTARIFF_ID);
    
    pUSSD_CHANGE_STATUS_ID := 0;
    
       
    if vERROR_MESSAGE is null AND nvl(vCONTRACT_ID, -1) <> -1  then
      pUSSD_CHANGE_STATUS_ID := cUSSD_ADD_STATUS_ID;
      INSERT INTO CONTRACT_CHANGES
        (
          CONTRACT_ID,
          FILIAL_ID,
          CONTRACT_CHANGE_DATE,
          TARIFF_ID,
          DOCUM_TYPE_ID
        )
      VALUES
      (
        vCONTRACT_ID,
        cFILIAL_ID,
        vCONTRACT_CHANGE_DATE,
        vTARIFF_ID,
        cDOCUM_TYPE_ID
        );
     end if;--if vERROR_MESSAGE is null
  end;   
BEGIN
  if pPhone_number is null and pUSSD_CODE is null then
  
    for rec in (
              select PHONE_NUMBER,
                     TICKET_ID,
                     USSD_CODE,
                     USSD_CHANGE_CONTRACT_STATUS_ID,
                     rowid r_rowid
                     
              from
                USSD_CHANGE_PP_LOG pp
              where USSD_CHANGE_CONTRACT_STATUS_ID is not null
              and exists (select 1
                          from USSD_CHANGE_CONTRACT_STATUS ss
                          where
                            nvl(pp.USSD_CHANGE_CONTRACT_STATUS_ID, 0) = SS.USSD_CHANGE_CONTRACT_STATUS_ID
                            and nvl(SS.CAN_ADD_CONTRACT_CHANGES, 0) = 1
                            
                          ) 
            )
    loop
      if rec.USSD_CHANGE_CONTRACT_STATUS_ID = cUSSD_CAN_ADD_STATUS_ID then --заявка удачно выполнена, создаем  доп договор
        ADD_CONTRACT_CHANGE (rec.PHONE_NUMBER, rec.USSD_CODE, vUSSD_CHANGE_STATUS_ID);
      else
        vUSSD_CHANGE_STATUS_ID := cUSSD_NO_ADD_STATUS_ID;  
      end if;--rec.USSD_CHANGE_CONTRACT_STATUS_ID = 1
      
      update USSD_CHANGE_PP_LOG
        set USSD_CHANGE_CONTRACT_STATUS_ID = vUSSD_CHANGE_STATUS_ID
       where USSD_CHANGE_PP_LOG.rowid = rec.r_rowid;
      
      COMMIT;
      
    end loop;
  else
    if pPhone_number is not null and pUSSD_CODE is not null then
      ADD_CONTRACT_CHANGE (pPhone_number, pUSSD_CODE, vUSSD_CHANGE_STATUS_ID);
      COMMIT;    
    end if;
    
  end if;
END;