
   CREATE JAVA SOURCE NAMED "CORP_MOBILE"."SHA512" AS 
 public class SHA512 extends CommonHash {	public static java.lang.String calcHash(java.lang.String input) {		return common(input, "SHA-512");	}}