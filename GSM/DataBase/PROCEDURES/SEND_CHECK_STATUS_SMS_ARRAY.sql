CREATE OR REPLACE PROCEDURE SEND_CHECK_STATUS_SMS_ARRAY
                       (p_phone in strArray,
                        p_message in strArray,
                        p_message_id in strArray,
                        p_status_code in strArray,
                        p_host in varchar2,
                        p_port in varchar2,       
                        p_user in varchar2,
                        p_passw in varchar2,
                        p_sourceAddr in varchar2,
                        p_serviceType in varchar2,
                        p_out out strArray)
       as
--
--#VERSION=1
--
--V.1 28.10.2015 Афросин - процедура для рассылки смс и проверки статусов отправленных смс
--       
      language java
      --MYJSMPP_AFR2.SEND_SMS_ARRAY
       name 'MYJSMPP.SEND_CHECK_STATUS_SMS_ARRAY(oracle.sql.ARRAY,
                                        oracle.sql.ARRAY,
                                        oracle.sql.ARRAY,
                                        oracle.sql.ARRAY,
                                        java.lang.String,
                                        java.lang.String,
                                        java.lang.String,
                                        java.lang.String,
                                        java.lang.String,
                                        java.lang.String,
                                        oracle.sql.ARRAY[]
                                        )';
    