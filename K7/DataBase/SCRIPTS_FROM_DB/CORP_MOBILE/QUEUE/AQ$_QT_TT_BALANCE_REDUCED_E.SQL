
   BEGIN DBMS_AQADM.CREATE_QUEUE(
     Queue_name          => 'CORP_MOBILE.AQ$_QT_TT_BALANCE_REDUCED_E',
     Queue_table         => 'CORP_MOBILE.QT_TT_BALANCE_REDUCED',
     Queue_type          =>  1,
     dependency_tracking =>  FALSE,
     comment             => 'exception queue')
  END