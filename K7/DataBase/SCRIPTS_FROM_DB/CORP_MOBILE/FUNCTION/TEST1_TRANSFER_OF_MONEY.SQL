
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."TEST1_TRANSFER_OF_MONEY" (pPHONE_NUM_OUT IN VARCHAR2,
                                             pPHONE_NUM_IN  IN VARCHAR2,
                                             pSumm          in number)
  return varchar2 IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  /*declare
  pPHONE_NUM_OUT VARCHAR2(10):='9623630138';
  pPHONE_NUM_IN VARCHAR2(10):='9035550424';
  pSumm         number:='129'; */

  res varchar2(350);
  SMS varchar2(350);
  vCh number;

  vphone_num_out varchar2(11); -- номер подающего телефона
  vphone_num_in  varchar2(11); -- номер принимающего телефона
  vSummBalance   number; -- сумма баланса подающего телефона
  vContract_id   number;
  vFilial_id     number;
  vYEAR_MONTH    number := to_char(sysdate, 'yyyymm');

  Function get_contract(fPHONE_NUM   in varchar2,
                        fYEAR_MONTH  in number,
                        fContract_id out varchar2,
                        fFilial_id   out varchar2) return number is
    result integer;
  begin

    begin
      SELECT CONTRACTS.CONTRACT_ID, CONTRACTS.Filial_Id
        into fContract_id, fFilial_id
        FROM CONTRACTS, CONTRACT_CANCELS
       WHERE CONTRACTS.CONTRACT_ID = CONTRACT_CANCELS.CONTRACT_ID(+)
         AND CONTRACTS.PHONE_NUMBER_FEDERAL = fPHONE_NUM
         AND CONTRACTS.CONTRACT_DATE <=
             LAST_DAY(TO_DATE(fYEAR_MONTH || '01', 'YYYYMMDD'))
         AND (CONTRACT_CANCELS.CONTRACT_CANCEL_DATE >=
             TO_DATE(fYEAR_MONTH || '01', 'YYYYMMDD') or
             CONTRACT_CANCELS.CONTRACT_CANCEL_DATE IS NULL);

    exception
      when others then
        fContract_id := 0;
        fFilial_id   := 0;
    end;

    return nvl(result, -1);
  end;

begin
  --1) проверка наличия подающего телефона
  select count(*)
    into vphone_num_out
    from db_loader_account_phones a
   where a.phone_number = pPHONE_NUM_OUT
     and a.year_month = vYEAR_MONTH;

  if vphone_num_out <> 0 then
    -- проверка наличия принимающего телефона
    select count(*)
      into vphone_num_in
      from db_loader_account_phones a
     where a.phone_number = pPHONE_NUM_IN
       and a.year_month = vYEAR_MONTH;

    if vphone_num_in <> 0 then

      -- проверка баланса подающего ;
      select get_abonent_balance(pPHONE_NUM_OUT)
        into vSummBalance
        from dual;

      if (vSummBalance >= pSumm /*or pPHONE_NUM_OUT = '9623630138'*/) then

        -- перевод денег - два инсерта в received_payments (- подающему, + принимающему)

        vCh := get_contract(pPHONE_NUM_OUT,
                            vYEAR_MONTH,
                            vContract_id,
                            vFilial_id);

        -- подающий
        if (vContract_id <> 0 and vFilial_id <> 0) then
          insert into received_payments
            (received_payment_id,
             phone_number,
             payment_sum,
             payment_date_time,
             contract_id,
             filial_id,
             remark)
          values
            (new_received_payment_id,
             pPHONE_NUM_OUT,
             -pSumm,
             sysdate,
             vContract_id,
             vFilial_id,
             'Списание средств в адрес абонента ' || pPHONE_NUM_IN);
          commit;
        else
          Res := 'Ошибка определения реквизитов абонента отправителя';
        end if;

        vCh := get_contract(pPHONE_NUM_IN,
                            vYEAR_MONTH,
                            vContract_id,
                            vFilial_id);

        if (vContract_id <> 0 and vFilial_id <> 0) then
          -- принимающий
          insert into received_payments
            (received_payment_id,
             phone_number,
             payment_sum,
             payment_date_time,
             contract_id,
             filial_id,
             remark)
          values
            (new_received_payment_id,
             pPHONE_NUM_IN,
             pSumm,
             sysdate,
             vContract_id,
             vFilial_id,
             'Поступление средств от абонента ' || pPHONE_NUM_OUT);
          commit;
          -- dbms_output.put_line(2);
        else
          Res := 'Перевод невозможен.Ошибка определения реквизитов абонента получателя';
        end if;

        res := 'Абоненту ' || pPHONE_NUM_IN || ' зачислена сумма ' ||
               pSumm || ' руб. Благодарим Вас за мобильный перевод.';

        begin
          SMS := loader3_pckg.SEND_SMS('9276093052',
                                       'SMS_info',
                                       'Вам зачислено ' || pSumm || ' руб.' ||
                                       ' от абонента' || pPHONE_NUM_OUT);

         /* SMS := loader3_pckg.SEND_SMS(pPHONE_NUM_IN,
          'SMS_info',
          'Вам зачислено ' || pSumm || ' руб.' ||
          ' от абонента ' || pPHONE_NUM_OUT);
        */
        /*  SMS := loader3_pckg.SEND_SMS(pPHONE_NUM_OUT,
                                       'SMS_info',
                                       ' Абоненту ' || pPHONE_NUM_IN||
                                       ' зачислено ' || pSumm || ' руб.'
                                       );*/

        exception
          when others then
            null;
        end;

      end if;

      if (vSummBalance < pSumm /*and pPHONE_NUM_OUT <> '9623630138'*/) then
        res := 'Перевод невозможен. Ваш баланс меньше переводимой суммы.';
      end if;

    end if;

    if vphone_num_in = 0 then
      res := 'Перевод невозможен. Телефона получателя нет в базе';
    end if;

  end if;

  if vphone_num_out = 0 then
    res := 'Перевод невозможен. Телефона отправителя нет в базе';
  end if;

  -- dbms_output.put_line(res);
  return res;

end;

  /*  select a.*, a.rowid
   from received_payments a where phone_number in ('9035550424','9623630138') and trunc(payment_date_time)= trunc(sysdate)
  */
