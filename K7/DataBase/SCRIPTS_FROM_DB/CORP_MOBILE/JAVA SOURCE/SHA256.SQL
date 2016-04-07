
   CREATE JAVA SOURCE NAMED "CORP_MOBILE"."SHA256" AS 
 public class SHA256 extends CommonHash {	public static java.lang.String calcHash(java.lang.String input) {		return common(input, "SHA-256");	}}