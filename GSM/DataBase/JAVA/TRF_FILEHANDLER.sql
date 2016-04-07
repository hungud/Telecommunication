﻿DROP JAVA SOURCE TRF_FILEHANDLER;

--
-- TRF_FILEHANDLER  (Java Source) 
--
CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED TRF_FILEHANDLER as import java.lang.*;
import java.util.*;
import java.io.*;
import java.sql.Timestamp;

public class TRF_FileHandler
{
  private static int SUCCESS = 1;
  private static  int FAILURE = 0;

  public static int canRead (String path) {
    File myFile = new File (path);
    if (myFile.canRead()) return SUCCESS; else return FAILURE;
  }

  public static int canWrite (String path) {
    File myFile = new File (path);
    if (myFile.canWrite()) return SUCCESS; else return FAILURE;
  }

  public static int createNewFile (String path) throws IOException {
    File myFile = new File (path);
    if (myFile.createNewFile()) return SUCCESS; else return FAILURE;
  }

  public static int delete (String path) {
    File myFile = new File (path);
    if (myFile.delete()) return SUCCESS; else return FAILURE;
  }

  public static int exists (String path) {
    File myFile = new File (path);
    if (myFile.exists()) return SUCCESS; else return FAILURE;
  }

  public static int isDirectory (String path) {
    File myFile = new File (path);
    if (myFile.isDirectory()) return SUCCESS; else return FAILURE;
  }

  public static int isFile (String path) {
    File myFile = new File (path);
    if (myFile.isFile()) return SUCCESS; else return FAILURE;
  }

  public static int isHidden (String path) {
    File myFile = new File (path);
    if (myFile.isHidden()) return SUCCESS; else return FAILURE;
  }

  public static Timestamp lastModified (String path) {
    File myFile = new File (path);
    return new Timestamp(myFile.lastModified());
  }

  public static long length (String path) {
    File myFile = new File (path);
    return myFile.length();
  }

  public static String list (String path) {
    String list = "";
    File myFile = new File (path);
    String[] arrayList = myFile.list();

    Arrays.sort(arrayList, String.CASE_INSENSITIVE_ORDER);

    for (int i=0; i < arrayList.length; i++) {
      // Prevent directory listing expanding if we will blow VARCHAR2 limit.
      if ((list.length() + arrayList[i].length() + 1) > 32767)
        break;

      if (!list.equals(""))
        list += "," + arrayList[i];
      else
        list += arrayList[i];
    }
    return list;
  }

  public static int mkdir (String path) {
    File myFile = new File (path);
    if (myFile.mkdir()) return SUCCESS; else return FAILURE;
  }

  public static int mkdirs (String path) {
    File myFile = new File (path);
    if (myFile.mkdirs()) return SUCCESS; else return FAILURE;
  }

  public static int renameTo (String fromPath, String toPath) {
    File myFromFile = new File (fromPath);
    File myToFile   = new File (toPath);
    if (myFromFile.renameTo(myToFile)) return SUCCESS; else return FAILURE;
  }

  public static int setReadOnly (String path) {
    File myFile = new File (path);
    if (myFile.setReadOnly()) return SUCCESS; else return FAILURE;
  }

  public static int getFileCount (String path) {
    File topDirectory = new File(path);
    File[] list = topDirectory.listFiles();
    return list.length;
  } 

  public static int copy (String fromPath, String toPath) {
    try {
      File myFromFile = new File (fromPath);
      File myToFile   = new File (toPath);

      InputStream  in  = new FileInputStream(myFromFile);
      OutputStream out = new FileOutputStream(myToFile);

      byte[] buf = new byte[1024];
      int len;
      while ((len = in.read(buf)) > 0) {
        out.write(buf, 0, len);
      }
      in.close();
      out.close();
      return SUCCESS;
    }
    catch (Exception ex) {
      return FAILURE;
    }
  }
};
/
