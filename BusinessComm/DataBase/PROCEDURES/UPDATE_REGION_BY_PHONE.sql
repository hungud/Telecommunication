CREATE OR REPLACE PROCEDURE UPDATE_REGION_BY_PHONE AS
--
--#VERSION=1
--
--v.1 Афросин 14.01.2016- Процедура для обновления регионов телефонных номеров
--
begin
  for c in (select
              distinct phone_number,
                       phone_id
            from phones
            where
              REGION is null
           ) loop
    update phones
      set REGION = GET_REGION_BY_PHONE(c.phone_number)
      where phone_id =c.phone_id;
      
  end loop;
  commit;
end;