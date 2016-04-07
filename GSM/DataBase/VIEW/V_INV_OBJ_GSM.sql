CREATE OR REPLACE VIEW V_INV_OBJ AS
SELECT *
FROM dba_objects tab1
WHERE tab1.STATUS <> 'VALID'
AND tab1.OWNER = 'LONTANA'
AND tab1.OBJECT_TYPE <> 'MATERIALIZED VIEW'
AND tab1.OBJECT_NAME not in 
(   '/52db872e_JUnitTestRunner',
    '/7b7d6857_JUnitUtilsJUnitTestC',
    '/aeb68bdb_JUnitUtilsJUnitTestM',
    '/f0c4819b_JUnitTestRunnerTestR',
    'bsh/util/BeanShellBSFEngine',
    'com/beust/testng/TestNGAntTask',
    'org/apache/log4j/jmx/Agent',
    'org/testng/junit/JUnitUtils',
    'org/testng/JUnitConverterTask',
    'org/testng/TestNGAntTask' )