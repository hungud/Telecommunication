-- SELECT * FROM dba_directories -- CREATE DIRECTORY mytest_dir AS 'c:\tmp\22_12_2014_last\';
select * from SYS.USER_ERRORS 
where /*NAME = upper('LZBinTree') and*/ type = 'JAVA SOURCE' 
order by NAME,sequence
