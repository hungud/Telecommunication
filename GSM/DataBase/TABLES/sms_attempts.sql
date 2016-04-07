drop table attempts cascade constraints;

create table sms_attempts 
(
   sms_id               INTEGER              not null,
   attempt_id           INTEGER              not null,
   submit_seq           INTEGER              not null,
   start_date           DATE                 not null,
   sms_address          VARCHAR2(22)         not null,
   submit_date          DATE,
   submit_resp_result   INTEGER,
   submit_resp_date     DATE,
   smsc_message_id      VARCHAR2(22),
   result_date          DATE,
   result               INTEGER,
   result_text          VARCHAR2(1000),
   constraint PK_SMS_ATTEMPTS primary key (attempt_id, sms_id, submit_seq)
);

comment on column sms_attempts.sms_id is
'Id sms (соответствует значению id таблицы sms_current';

comment on column sms_attempts.attempt_id is
'Id попытки';

comment on column sms_attempts.submit_seq is
'Id команды submit_sm';

comment on column sms_attempts.start_date is
'Дата начала обработки';

comment on column sms_attempts.sms_address is
'Номер, куда отправлять SMS';

comment on column sms_attempts.submit_date is
'Дата отправки команды submit_sm';

comment on column sms_attempts.submit_resp_result is
'Резкльтат команды submit_sm';

comment on column sms_attempts.submit_resp_date is
'Дата приема результата команды submit_sm';

comment on column sms_attempts.smsc_message_id is
'SMSC_ID (если команда submit_sm выполнена успешно)';

comment on column sms_attempts.result_date is
'Дата приема квитанции';

comment on column sms_attempts.result is
'Результат доставки (0 - доставлено, -1 - не доставлено)';

comment on column sms_attempts.result_text is
'Текст квитанции';

/*==============================================================*/
/* Index: attempts_smsc_id_address                              */
/*==============================================================*/
create index attempts_smsc_id_address on sms_attempts (
   sms_address ASC,
   smsc_message_id ASC
);

grant insert, update, delete, select on sms_attempts to BEELINE_SEND_SMS_USER;

CREATE OR REPLACE SYNONYM BEELINE_SEND_SMS_USER.sms_attempts for sms_attempts;