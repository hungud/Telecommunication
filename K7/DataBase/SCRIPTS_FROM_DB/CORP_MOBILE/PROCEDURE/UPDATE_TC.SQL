
  CREATE OR REPLACE PROCEDURE "CORP_MOBILE"."UPDATE_TC" IS
BEGIN
/*  update temp_call tc
     set tc.coast_vo = decode(tc.coast_vo, '0,0', '0', tc.coast_vo);
  commit;
  update temp_call tc set tc.coast_vo = replace(tc.coast_vo, ',', '.');
  commit;
  update temp_call tc
     set tc.coast = to_char(round(to_number(tc.coast_vo, '9999999.99') * 1.18,
                                  4));
  commit;
  update temp_call tc set tc.coast_vo = replace(tc.coast_vo, '.', ',');
  commit;
  update temp_call tc set tc.coast = replace(tc.coast, '.', ',');
  commit;*/
  update temp_call tc
     set tc.type_call = 'U'
   where tc.ext_type_call = 'MMS';
  commit;
    update temp_call tc set tc.dur = decode(tc.type_call, 'S', 1, tc.dur);
  commit;
  update temp_call tc set tc.cell_id = decode(tc.cell_id, '-', '', tc.cell_id);
  commit;
  update temp_call tc
     set tc.regi =
         (select bz.zone_name
            from beeline_bs_zones bz
           where bz.beeline_bs_zone_id = to_number(tc.cell_id));
  commit;
  update temp_call tc
     set tc.is_roam   = decode(tc.ext_type_call,
                               '(Рег) Москва и МО',
                               null,
                               1),
         tc.roam_zone = decode(tc.ext_type_call,
                               '(Рег) Москва и МО',
                               '',
                               'РФ')
   where Lower(tc.ext_type_call) like '(рег)%';
  commit;
END;
