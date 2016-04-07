--#if GetVersion("EDIT_CONTRACT_GROUP") < 2 then
CREATE OR REPLACE PROCEDURE EDIT_CONTRACT_GROUP
(
  p_ContractId IN INTEGER,
  p_GroupId IN INTEGER
) AS
--
--#Version=2
--v2 Назин добавил обновления полей paramdisable_sms hand_block_date_end  hand_block
v_rec_group contract_groups%rowtype;
BEGIN
  select * into v_rec_group from contract_groups cg where cg.group_id=p_GroupId;
  
  UPDATE contracts SET group_id = p_GroupId
                     , hand_block=v_rec_group.paramhand_block
                     , paramdisable_sms=v_rec_group.paramdisable_sms
                     , hand_block_date_end=v_rec_group.hand_block_date_end
  WHERE contract_id = p_ContractId;
exception 
  when no_data_found then 
    UPDATE contracts SET group_id = p_GroupId, hand_block=null, paramdisable_sms=null
    WHERE contract_id = p_ContractId;
END;
--#end if;

--#Execute MAIN_SCHEMA=IsClient("")

--#if not GrantExists("EDIT_CONTRACT_GROUP", "ROLE", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_CONTRACT_GROUP TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("EDIT_CONTRACT_GROUP", "ROLE_RO", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_CONTRACT_GROUP TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
