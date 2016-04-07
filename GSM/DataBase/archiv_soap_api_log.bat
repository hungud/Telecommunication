echo on
set nls_lang=russian_russia.CL8MSWIN1251
for /F "tokens=1 delims=." %%A in ('dir /b /d E:\ora_back\soap_api\ext_beeline_soap_api_log_*.dmp') do (
"C:\Program Files\7-Zip\7z.exe" a -t7z E:\ora_back\soap_api\%%A.7z E:\ora_back\soap_api\%%A.dmp
del E:\ora_back\soap_api\%%A.dmp /q
)

rem ---удаляем логи подключения к базе данных
del E:\ora_back\soap_api\*.log /q