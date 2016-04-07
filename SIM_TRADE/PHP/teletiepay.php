<?php 
 // Параметры коннекта к БД
 
 $db = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=109.95.210.5)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=K7)))";
 $dblogin = "teletie";
 $dbpass = "Yv0OAGvsMad0";
 
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
  $HTTP_ANSWER = "";
  $HTTP_BODY = "";
    	$query = 'begin :HTTP_BODY := TELETIE_PAYMENT(:phonenr, :amount, :numpay, :ssign,:HTTP_ANSWER); end;';
        $stmt = oci_parse($conn,$query);
        oci_bind_by_name($stmt, ":phonenr", $_GET['phonenr']);
        oci_bind_by_name($stmt, ":amount", $_GET['amount']);
        oci_bind_by_name($stmt, ":numpay", $_GET['numpay']);
        oci_bind_by_name($stmt, ":ssign",$_GET['sign']);
        oci_bind_by_name($stmt, ":HTTP_ANSWER", $HTTP_ANSWER,200);
        oci_bind_by_name($stmt, ":HTTP_BODY", $HTTP_BODY,200);
        oci_execute($stmt);

  	   header("HTTP/1.0 " . iconv("UTF-8","windows-1251", $HTTP_ANSWER));
        print $HTTP_BODY;
 if ($stmt)  {
     oci_free_statement($stmt);
  }
  oci_close($conn);
?>
