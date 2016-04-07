
  CREATE OR REPLACE PACKAGE "LONTANA"."PKG_PARAL_TEST" is
      type rec_t is record(g number, id number);
      type tab_t is table of rec_t;
      type rc_t is ref cursor return rec_t;

      function pip(in_p rc_t)
        return tab_t pipelined
        parallel_enable (partition in_p by range(g))
        order in_p by (id);
   end;

CREATE OR REPLACE PACKAGE BODY "LONTANA"."PKG_PARAL_TEST" is
  function pip(in_p rc_t)
      return tab_t pipelined
     parallel_enable (partition in_p by range(g))
        order in_p by (id)
      is
        v_rec rec_t;
      begin
        loop
         fetch in_p into v_rec;
         exit when in_p%notfound;
         pipe row(v_rec);
       end loop;
       return;
     end;
   end;
