
  CREATE OR REPLACE FUNCTION "CORP_MOBILE"."SAY_HELLO_FROM_JAVA_TO" (to_whom IN VARCHAR2)
      RETURN VARCHAR2
AS LANGUAGE JAVA
NAME 'MyJavaAgentInOracle.sayHello (java.lang.String)
      return java.lang.String';
