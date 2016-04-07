--#if GetVersion("EDIT_GROUP_PARAMS") < 6 then
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
  p_param_time_block_end in out  varchar2,
  p_param_hand_block_summ in number,
  p_send_detail_auto number,
  p_send_detail_day number,
  p_email_balance varchar2,
  p_email_balance_period number
) AS
--
--#Version=6
--
--v.6  отенков добавил пол€ в таблицу и процедуру send_detail_auto, send_detail_day
--v.5 Ќазин разделил обновление дл€ ручного блока и прочих параметров
--v.4 Ќазин добавил пол€ в таблицу процедуру и прогу paramdisable_sms, PARAMUSSD_GR_BAL, paramhand_block, p_param_time_block_end
cg_rec contract_groups%rowtype;


BEGIN
 if p_param_time_block_end ='' then p_param_time_block_end:='01.01.1900';end if;

  --запоминаем текущее состо€ние.
  select * into cg_rec from contract_groups cg where cg.group_id=p_GroupId;
  
  --общее обновление
    UPDATE contract_groups SET ParamPDF_Contacts = p_ParamPDF_Contacts, ParamPDF_BankDet = p_ParamPDF_BankDet,
           ParamPDF_Logo = EMPTY_BLOB(), ParamDet_Mail = p_ParamDet_Mail,PARAMUSSD_GR_BAL=p_PARAMUSSD_GR_BAL,
           paramdisable_sms=p_paramdisable_sms, send_detail_auto = p_send_detail_auto, send_detail_day = p_send_detail_day,
           email_balance = p_email_balance, email_balance_period = p_email_balance_period
    WHERE group_id = p_GroupId
    RETURNING ParamPDF_Logo
    INTO p_ParamPDF_Logo;
    
    UPDATE contracts t set  t.paramdisable_sms=p_paramdisable_sms
           where t.group_id=p_GroupId;
           
  --обновл€ем ручной блок отдельно, только в случае если он действительно помен€лс€ на форме...(требование ƒениса _  7)

  if   (nvl(cg_rec.paramhand_block,0)=0 and cg_rec.hand_block_date_end is null 
    and p_paramhand_block is not null and p_param_time_block_end is not null) 
       --если пустые старые и заполнены оба новых
    or (cg_rec.paramhand_block!=p_paramhand_block or p_paramhand_block is null)--если удал€ем или мен€ем значение
    or (trunc(cg_rec.hand_block_date_end)!=to_date(p_param_time_block_end,'DD.MM.YYYY') or p_param_time_block_end is null)
    or (nvl(cg_rec.hand_block_summ,0)!=p_param_hand_block_summ or p_param_hand_block_summ is null)
    
       
    
 then
    
    UPDATE contract_groups SET paramhand_block=to_number(p_paramhand_block), hand_block_date_end=to_date(p_param_time_block_end,'DD.MM.YYYY'),
    hand_block_summ=p_param_hand_block_summ
    WHERE group_id = p_GroupId;
    
    UPDATE contracts t set t.hand_block=to_number(p_paramhand_block) ,hand_block_date_end=to_date(p_param_time_block_end,'DD.MM.YYYY')
    ,balance_block_hand_block=p_param_hand_block_summ
    where t.group_id=p_GroupId;
  end if;

END;
/
--#end if;

--#if not GrantExists("EDIT_GROUP_PARAMS", "ROLE", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_GROUP_PARAMS TO &MAIN_SCHEMA'||'_ROLE'; end;
--#end if

--#if not GrantExists("EDIT_GROUP_PARAMS", "ROLE_RO", "EXECUTE") then
begin EXECUTE IMMEDIATE 'GRANT EXECUTE ON EDIT_GROUP_PARAMS TO &MAIN_SCHEMA'||'_ROLE_RO'; end;
--#end if
