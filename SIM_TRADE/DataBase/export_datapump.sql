--Овсянников Л.В. 
--Настройка DIRECTORY для выгрузки Backup Data Pump
CREATE OR REPLACE DIRECTORY datapump_dir AS 'D:\TARIFER\Backup\';
GRANT READ, WRITE ON DIRECTORY datapump_dir TO SIM_TRADE;
