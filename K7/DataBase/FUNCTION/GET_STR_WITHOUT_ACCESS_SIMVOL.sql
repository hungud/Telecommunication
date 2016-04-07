CREATE OR REPLACE FUNCTION GET_STR_WITHOUT_ACCESS_SIMVOL(
  pSTR VARCHAR2
  ) RETURN VARCHAR2 IS
  vSTR VARCHAR2(1000 CHAR);
BEGIN
  vSTR:=pSTR;
  vSTR:=REGEXP_REPLACE(vSTR, '[ABCDEFGHIJKLMNOPQRSTUVWXYZ]');
  vSTR:=REGEXP_REPLACE(vSTR, '[abcdefghijklmnopqrstuvwxyz]');
  vSTR:=REGEXP_REPLACE(vSTR, '[ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÜÛÚÝÞ‗]');
  vSTR:=REGEXP_REPLACE(vSTR, '[אבגדהו¸זחטיךכלםמןנסעףפץצקרשüûת‎‏ÿ]');
  vSTR:=REGEXP_REPLACE(vSTR, '[0123456789]');
  vSTR:=REPLACE(vSTR, ' ', '');
  vSTR:=REPLACE(vSTR, '(', '');
  vSTR:=REPLACE(vSTR, ')', '');
  vSTR:=REPLACE(vSTR, '.', '');
  vSTR:=REPLACE(vSTR, ',', '');
  vSTR:=REPLACE(vSTR, ':', '');
  vSTR:=REPLACE(vSTR, '-', '');
  vSTR:=REPLACE(vSTR, '"', '');
  vSTR:=REPLACE(vSTR, '/', '');
  vSTR:=REPLACE(vSTR, '$', '');
  vSTR:=REPLACE(vSTR, '_', '');
  RETURN vSTR;
END;