declare
begin
  for rec in (
    select *
      from temp4)
  loop
    insert into abonents(SURNAME, NAME, PATRONYMIC)
      values('Лидер Мобайл', rec.STR1, rec.STR1);
  end loop;    
  commit;
end;