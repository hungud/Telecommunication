
   CREATE JAVA SOURCE NAMED "CORP_MOBILE"."Main" AS 
 public class Main {	public Main() {		System.out.println("SHA256 = " + new SHA1().calcHash("123444444441444444444"));	}		/**	 * @param args	 */	public static void main(String[] args) {		new Main();	}}