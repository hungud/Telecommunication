CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED "LOBUtils" as import oracle.sql.BLOB;
import oracle.sql.CLOB;
import java.io.*;
import java.sql.*;
public class LOBUtils {
  final static int bBufLen = 4 * 8192;

  public static long BLOB2File(BLOB BLOB, String outFile)
  throws IOException, SQLException {
    OutputStream out = new FileOutputStream(outFile);
    InputStream in = BLOB.getBinaryStream();
    int length = -1;
    long read = 0;
    byte[] buf = new byte[bBufLen];
    while ((length = in.read(buf)) != -1) {
      out.write(buf, 0, length);
      read += length;
    }
    in.close();
    out.close();
    return read;
  }

  public static void clob2file(CLOB clob, String fileName, String characterSet)
    throws SQLException, IOException {
    Writer writer = null;
    Reader reader = null;
    try {
      writer = new OutputStreamWriter(
        new BufferedOutputStream(new FileOutputStream(new File(fileName))), characterSet
      );
      reader = new BufferedReader(clob.getCharacterStream());
      int length;
      char[] buf = new char[clob.getChunkSize()];
      while ((length = reader.read(buf, 0, clob.getChunkSize())) != -1) {


       writer.write(buf, 0, length);
      }
    } finally {
      if (writer != null) {writer.close();}
      if (reader != null) {reader.close();}
    }
  }
}
/
