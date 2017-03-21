/**
 * Main Method 
 */

/**
 * @author Lucas Campos e Victor Ruas
 *
 */

public class Banco {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Conta c1 = new Conta(750.0, 500.0);
		Conta c2 = new Conta(3000.0, 1000.0);
		System.out.println(c1.getConta());
		System.out.println(c2.getConta());
		
		System.out.println(c1.transfer(c2, 20.0));
		System.out.println(c1.getSaldo());
		System.out.println(c2.getSaldo());
	}
}
