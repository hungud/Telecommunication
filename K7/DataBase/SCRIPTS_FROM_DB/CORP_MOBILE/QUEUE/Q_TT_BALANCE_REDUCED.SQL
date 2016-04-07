
   BEGIN DBMS_AQADM.CREATE_QUEUE(
     Queue_name          => 'CORP_MOBILE.Q_TT_BALANCE_REDUCED',
     Queue_table         => 'CORP_MOBILE.QT_TT_BALANCE_REDUCED',
     Queue_type          =>  0,
     Max_retries         =>  5,
     Retry_delay         =>  0,
     dependency_tracking =>  FALSE,
     comment             => 'Отправка сообщений в ТелеТай о снижении баланса абонентов.')
  END