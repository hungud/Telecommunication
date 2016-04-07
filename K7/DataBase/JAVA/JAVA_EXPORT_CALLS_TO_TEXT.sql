CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED "JAVA_EXPORT_CALLS_TO_TEXT" AS
//
//йКЮЯЯ ДКЪ ГЮОЯЙЮ БШЦПСГЙХ ДЮММШУ ХГ РЮАХКЖШ Б ТЮИКШ
//
//#Version=1
//
import java.io.IOException;
public class JAVA_EXPORT_CALLS_TO_TEXT {
    public static void EXPORT_CALLS_TO_TEXT(java.lang.String PROG_FILE_DIR, // осрэ й оюойе я хонкмъелшл тюикнл
                                            java.lang.String MONTH_YEAR,      //леяъж_цнд гю йнрнпши опнхяундхр бшцпсгйю
                                            java.lang.String EXT_FILE_PATH,   //осрэ йсдю асдср бшцпсфюрэяъ тюикш
                                            java.lang.String CONNECT_STR,       //ярпнйю янедхмемхъ
                                            java.lang.String WORK_SCHEMA_NAME       //хлъ яуелш дкъ йнрнпни опнхгбндхряъ бшцпсгйю тюикнб
                                            )
    throws Exception {
    Runtime rt = Runtime.getRuntime();
    java.lang.String PROG_NAME = "ExportCallsToText.exe";
    //user/password@server:port:sid  04_2014  d:\robot\DB\2014_04
    java.lang.String PARAM_STR = " "+ CONNECT_STR + " " + MONTH_YEAR + " " + EXT_FILE_PATH + " " + WORK_SCHEMA_NAME;
    Process proc = rt.exec(PROG_FILE_DIR + PROG_NAME + PARAM_STR);
  }
};
/