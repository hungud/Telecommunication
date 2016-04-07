CREATE OR REPLACE VIEW V_TARIFFS_ATTRS_PIPE AS

select t.tariff_id, t.tariff_code, t.operator_id, t.filial_id, t.TARIFF_NAME, t.ATTRIBUTES_NAME, t.ATTRIBUTES_VALUE, t.ATTRIBUTES_TYPE, t.ATTRIBUTES_ID
       from TABLE(tariff_pckg.GET_TARIFFS_ATTR_PIPE) t order by t.tariff_id, t.attributes_id;

/