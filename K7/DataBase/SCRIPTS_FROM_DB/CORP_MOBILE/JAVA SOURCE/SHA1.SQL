
   CREATE JAVA SOURCE NAMED "CORP_MOBILE"."SHA1" AS 
 public class SHA1 extends CommonHash {	public static java.lang.String calcHash(java.lang.String input) {		return common(input, "SHA1");	}}