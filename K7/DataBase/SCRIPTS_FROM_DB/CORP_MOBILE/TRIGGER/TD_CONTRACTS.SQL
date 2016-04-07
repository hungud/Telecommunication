
  CREATE OR REPLACE TRIGGER "CORP_MOBILE"."TD_CONTRACTS" 
BEFORE DELETE
ON CONTRACTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  if  DELETING then
      insert into sh_contracts
        (contract_id, contract_num, contract_date, filial_id, operator_id, phone_number_federal, phone_number_city, phone_number_type, tariff_id, sim_number, service_id, disconnect_limit, confirmed, user_created, date_created, user_last_updated, date_last_updated, abonent_id, received_sum, start_balance, gold_number_sum, hand_block, user_password, connect_limit, hand_block_date_end, is_credit_contract, comments, send_activ, curr_tariff_id, dop_status, balance_notice_hand_block, balance_block_hand_block, abon_tp_discount, installment_payment_date, installment_payment_sum, installment_payment_months, dealer_kod, installment_advanced_repayment, group_id, option_group_id, mn_roaming, paramdisable_sms, update_user, update_time)
      values
        (:old.contract_id, :old.contract_num, :old.contract_date, :old.filial_id, :old.operator_id, :old.phone_number_federal, :old.phone_number_city, :old.phone_number_type, :old.tariff_id, :old.sim_number, :old.service_id, :old.disconnect_limit, :old.confirmed, :old.user_created, :old.date_created, :old.user_last_updated, :old.date_last_updated, :old.abonent_id, :old.received_sum, :old.start_balance, :old.gold_number_sum, :old.hand_block, :old.user_password, :old.connect_limit, :old.hand_block_date_end, :old.is_credit_contract, 'Delete: '|| :old.comments , :old.send_activ, :old.curr_tariff_id, :old.dop_status, :old.balance_notice_hand_block, :old.balance_block_hand_block, :old.abon_tp_discount, :old.installment_payment_date, :old.installment_payment_sum, :old.installment_payment_months, :old.dealer_kod, :old.installment_advanced_repayment, :old.group_id, :old.option_group_id, :old.mn_roaming, :old.paramdisable_sms, user, sysdate);
  end if;
END;
ALTER TRIGGER "CORP_MOBILE"."TD_CONTRACTS" ENABLE