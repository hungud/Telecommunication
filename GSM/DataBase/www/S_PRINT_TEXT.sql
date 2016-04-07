CREATE OR REPLACE FUNCTION LONTANA_WWW.S_PRINT_TEXT(
  pVALUE IN CLOB
  ) RETURN CLOB IS
  
  --Version 1
  --
  --v.1 Алексеевю 05.11.2015. Функция вывода текста
  
BEGIN
  RETURN 
    '<p>' || 
    REPLACE(
      HTF.ESCAPE_SC(pVALUE),
      CHR(10), 
      '</p><p>'
    ) ||
    '</p>';
END;