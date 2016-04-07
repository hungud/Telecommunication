--#if GetVersion("EDIT_GROUP_PARAMS") < 5 then
CREATE OR REPLACE PROCEDURE EDIT_GROUP_PARAMS
(
  p_GroupId IN INTEGER,
  p_ParamPDF_Contacts IN VARCHAR2,
  p_ParamPDF_BankDet IN VARCHAR2,
  p_ParamPDF_Logo OUT BLOB,
  p_ParamDet_Mail IN VARCHAR2,
  p_PARAMUSSD_GR_BAL in number,
  p_paramhand_block in number,
  p_paramdisable_sms in varchar2,
  p_param_time_block_end in  varchar2
) AS
--
--#Version=5
--
--v.5 Назин разделил обновление для ручного блока и прочих параметров
--v.4 Назин добавил поля в таблицу процедуру и прогу paramdisable_sms, PARAMUSSD_GR_BAL, paramhand_block, p_param_time_block_end
cg_rec contract_groups%rowtype;


BEGIN

  --запоминаем текущее состояние.
  select * into cg_rec from contract_groups cg where cg.group_id=p_GroupId;
  
  --общее обновление
    UPDATE contract_groups SET ParamPDF_Contacts = p_ParamPDF_Contacts, ParamPDF_BankDet = p_ParamPDF_BankDet,
           ParamPDF_Logo = EMPTY_BLOB(), ParamDet_Mail = p_ParamDet_Mail,PARAMUSSD_GR_BAL=p_PARAMUSSD_GR_BAL,
           paramdisable_sms=p_paramdisable_sms
    WHERE group_id = p_GroupId
    RETURNING ParamPDF_Logo
    INTO p_ParamPDF_Logo;
    
    UPDATE contracts t set  t.paramdisable_sms=p_paramdisable_sms
           where t.group_id=p_GroupId;
           
  --обновляем ручной блок отдельно, только в случае если он действительно поменялся на форме...(требование Дениса _ К7)

  if   (cg_rec.paramhand_block is null and cg_rec.hand_block_date_end is null and p_paramhand_block is not null and p_param_time_block_end is not null) 
       --если пустые старые и заполнены оба новых
    or (cg_rec.paramhand_block!=p_paramhand_block or p_paramhand_block is null)--если удаляем или меняем значение
    or (trunc(cg_rec.hand_block_date_end)!=to_date(p_param_time_block_end,'DD.MM.YYYY') or p_param_time_block_end is null)
       
    
 then
    
    UPDATE contract_groups SET paramhand_block=to_number(p_paramhand_block), hand_block_date_end=to_date(p_param_time_block_end,'DD.MM.YYYY')
    WHERE group_id = p_GroupId;
    
    UPDATE contracts t set t.hand_block=to_number(p_paramhand_block) ,hand_block_date_end=to_date(p_param_time_block_end,'DD.MM.YYYY')
    where t.group_id=p_GroupId;
  end if;

END;
/
-#end if;

--#if not GrantExists("EDIT_GROUP_PARAMS", "ROLE", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_GROUP_PARAMS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("EDIT_GROUP_PARAMS", "ROLE_RO", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_GROUP_PARAMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
