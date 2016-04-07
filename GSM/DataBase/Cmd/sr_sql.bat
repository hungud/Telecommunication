for %%f in (%1) do sr.vbs "%%f" "(VARCHAR2 *\( *\d+ *)\)" "$1 CHAR)" "%2"
