--Овсянников Л.В. 
--Настройка DIRECTORY для выгрузки Backup Data Pump
--LONTANA
CREATE OR REPLACE DIRECTORY datapump_dir AS 'B:\ora_back\';
GRANT READ, WRITE ON DIRECTORY datapump_dir TO LONTANA;
--CORP_MOBILE

CREATE OR REPLACE DIRECTORY datapump_dir AS 'E:\Backup\';
GRANT READ, WRITE ON DIRECTORY datapump_dir TO CORP_MOBILE;

--SIM_TRADE
CREATE OR REPLACE DIRECTORY datapump_dir AS 'D:\TARIFER\Backup\';
GRANT READ, WRITE ON DIRECTORY datapump_dir TO SIM_TRADE;
