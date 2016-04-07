create or replace function STRINLIKE
(
str           in varchar2,
source        in varchar2,
delimiter     in varchar2,
blank         in varchar2
)
return integer
as 

cnt           integer;

item          varchar2( 2000 );

function STRCNT
(
source    in varchar2,
delimeter in varchar2
)
return integer
is
n         integer;
i         integer;
begin
-- проверка параметров
if ( source is null ) then
return 0;
end if;
if ( delimeter is null ) then
return 1;
end if;
i := 1;
n := 0;
while ( i > 0 ) loop
i := instr( source,delimeter,i );
if ( i = 0 ) then
exit;
end if;
i := i + length( delimeter );
n := n + 1;
if ( n > length( source ) ) then
exit;
end if;
end loop;
if ( i < length( source ) ) then
n := n + 1; -- последняя - подстрока, а не разделитель
end if;
return n;
end;

function STRTOK
(
source    in varchar2,
delimeter in varchar2,
item      in integer
)
return varchar2
is
i         integer;
n         integer;
begin
-- проверка параметров
if ( delimeter is null ) then
return source;
end if;
if ( item < 1 ) then
return null;
end if;
-- прогнать до item группы
n := 1;
i := 1;
while n < item loop
i := instr( source,delimeter,i );
if ( i = 0 ) then
return null; -- не нашли столько групп
end if;
n := n + 1;
i := i + length( delimeter );
end loop;
-- взять строку
n := i;
i := instr( source,delimeter,n );
if ( i > 0 ) then
return substr( source,n,i-n );
end if;
return substr( source,n );
end;

begin
if ( source is null ) then
return 0;
end if;
cnt := strcnt( source,delimiter );
for i in 1..cnt loop
item := strtok( source,delimiter,i );
if (    item is not null and blank is not null and item = blank and str is null
or item is not null and str is not null and str like item ) then
return 1;
end if;
end loop;
return 0;
end;
/
