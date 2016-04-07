<?php 
 // Параметры коннекта к БД
 //$db = "simtrade.tarifer.ru:1521/XE";
// $db = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=simtrade.tarifer.ru)(PORT=1521))(CONNECT_DATA=(SID=XE)))";
// $dblogin = "lontana";
// $dbpass = "lontana13";
 
 $db = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=188.65.212.124)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=GSMCORP)))";
// $dblogin = "corp_mobile";
// $dbpass = "corp_mobile";
 $dblogin = "USSD_USER";
 $dbpass = "0JgP3XmVkidT";
 
function trlt($st) {
$st = strtr($st, array(
"yo"=>'ё',    "h"=>'х',  "ts"=>'ц',  "ch"=>'ч', "sh"=>'ш',
"shch"=>'щ',   "yu"=>'ю', "ya"=>'я',
"Yo"=>'Ё',    "H"=>'Х', "Ts"=>'Ц',  "Ch"=>'Ч', "Sh"=>'Ш',
"Shch"=>'Щ',"Yu"=>'Ю', "Ya"=>'Я')
);

$st = strtr($st,
"abvgdegziyklmnoprstufieABVGDEGZIYKLMNOPRSTUFIE",
"абвгдежзийклмнопрстуфыэАБВГДЕЖЗИЙКЛМНОПРСТУФЫЭ"
);
return $st;
}

 // Обработка ошибок
 function error_handler($level, $message, $file, $line, $context) {
    //Handle user errors, warnings, and notices ourself
    if($level === E_USER_ERROR || $level === E_USER_WARNING || $level === E_USER_NOTICE) {
        echo '<strong>Error:</strong> '.$message;
        return(true); //And prevent the PHP error handler from continuing
    }
    return(false); //Otherwise, use PHP's error handler
  }

  // Включаем обработчик ошибок
  set_error_handler('error_handler');

  // Подключаемся к ораклу
  //,"AMERICAN_AMERICA.CL8MSWIN1251"
  $conn = oci_connect($dblogin,$dbpass,$db);
  if (!$conn) {
      $e = oci_error();
      trigger_error(htmlentities($e['message'], ENT_QUOTES, "CP1251"), E_USER_ERROR);
  }
//меняем установки
/*$z = "select * from nls_session_parameters";
$y = oci_parse($conn,$z);
oci_execute($y);
while (($row=oci_fetch_array($y, OCI_BOTH))){
echo $row[0]."  ". $row[1]. " " . $row[2]."<br>\n";
}*/
//
  $action = strtolower($_GET['action']);
  $XCPAUSSDSession = "";
  $HTTP_ANSWER = "";
  $HTTP_BODY = "";
    $XCPAXAction ="";
    $XCPAMSGID ="";
    $XCPAStatus="";
    $XCPAError="";
    $headers = apache_request_headers();
    foreach ($headers as $header => $value) {
    if ($header=="X-CPA-XAction") {
         $XCPAXAction=$value;
              }
    elseif ($header=="X-CPA-MSGID") {
        $XCPAMSGID=$value;
             }
    elseif ($header=="X-CPA-Status") {
      $XCPAStatus=$value;
           }
    elseif ($header=="X-CPA-Error") {
        $XCPAError=$value;
         }
    }

  switch ($action) {
      case 'deliver':
    	$query = 'begin :HTTP_BODY := USSD_DELIVER(:response,:msisdn,:service,:location,:lang,:ussd,:XCPAXAction,:XCPAMSGID,:XCPAUSSDSession,:HTTP_ANSWER); end;';
        $stmt = oci_parse($conn,$query);
        oci_bind_by_name($stmt, ":response", $_GET['response']);
        oci_bind_by_name($stmt, ":msisdn", $_GET['msisdn']);
        oci_bind_by_name($stmt, ":service", $_GET['service']);
        oci_bind_by_name($stmt, ":location",$_GET['location']);
        oci_bind_by_name($stmt, ":lang", $_GET['lang']);
        oci_bind_by_name($stmt, ":ussd", $_GET['ussd']);
        oci_bind_by_name($stmt, ":XCPAXAction", $XCPAXAction);
        oci_bind_by_name($stmt, ":XCPAMSGID", $XCPAMSGID );
//        oci_bind_by_name($stmt, ":XCPAXAction", $_GET['X-CPA-XAction']);
//        oci_bind_by_name($stmt, ":XCPAMSGID", $_GET['X-CPA-MSGID']);
        oci_bind_by_name($stmt, ":XCPAUSSDSession", $XCPAUSSDSession,5);
        oci_bind_by_name($stmt, ":HTTP_ANSWER", $HTTP_ANSWER,200);
        oci_bind_by_name($stmt, ":HTTP_BODY", $HTTP_BODY,200);
        oci_execute($stmt);

  	    header("HTTP/1.0 " . iconv("UTF-8","windows-1251", $HTTP_ANSWER));
         header("X-CPA-USSDSession: " . $XCPAUSSDSession); 
		//print iconv("UTF-8","windows-1251",$HTTP_BODY);
		//print trlt($HTTP_BODY);
		print urldecode($HTTP_BODY);
        break;
      case 'notify':
		$query = 'begin :HTTP_BODY := USSD_NOTIFY(:XCPAXAction,:XCPAMSGID,:XCPAStatus,:XCPAError,:HTTP_ANSWER); end;';
        $stmt = oci_parse($conn,$query);
        oci_bind_by_name($stmt, ":XCPAXAction", $XCPAXAction);
        oci_bind_by_name($stmt, ":XCPAMSGID", $XCPAMSGID);
       oci_bind_by_name($stmt, ":XCPAStatus", $XCPAStatus);
        oci_bind_by_name($stmt, ":XCPAError", $XCPAError);
//        oci_bind_by_name($stmt, ":XCPAXAction", $_GET['X-CPA-XAction']);
//        oci_bind_by_name($stmt, ":XCPAMSGID", $_GET['X-CPA-MSGID']);
//        oci_bind_by_name($stmt, ":XCPAStatus", $_GET['X-CPA-Status']);
//        oci_bind_by_name($stmt, ":XCPAError", $_GET['X-CPA-Error']);
        oci_bind_by_name($stmt, ":HTTP_ANSWER", $HTTP_ANSWER,200);
        oci_bind_by_name($stmt, ":HTTP_BODY", $HTTP_BODY,200);
        oci_execute($stmt);

		header("HTTP/1.0 " . $HTTP_ANSWER);
		print urldecode($HTTP_BODY);
		
        break;
      default:
         header("HTTP/1.0 400 Invalid action parameter is request");
  }


  if ($stmt)  {
     oci_free_statement($stmt);
  }
  oci_close($conn);
?>
