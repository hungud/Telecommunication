insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-100, 'Новость 2', 'Аннотация, применяем <b>HTML</b> разметку', 'Текст новости, <a href="www.tarifer.ru" target="_blank">ссылка<p>вторая строка',
1, 1);

insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-100, 'Новость 3', 'Аннотация 3', 'Текст новости', 1, 0);

insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-90, 'Новость 4', 'Аннотация 4', 'Текст новости', 1, 0);

insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-80, 'Скрытая новость 5', 'Аннотация 5', 'Текст новости', 0, 1);

insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-75, 'Новость 6', 'Аннотация 6', 'Текст новости', 0, 0);

insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-70, 'Новость 7', 'Аннотация 7', 'Текст новости 7', 1, 0);

begin
  for i in 10..70 loop
insert into d_news (DATE_OF_NEW, NEW_HEADER, NEW_ANNOTATION, NEW_TEXT, NEW_ENABLED, NEW_IS_ON_TOP)
values(sysdate-80+i, 'Новость '||i, 'Аннотация '||i, 'Текст новости '||i, 1, 0);
  end loop;
end;

commit;