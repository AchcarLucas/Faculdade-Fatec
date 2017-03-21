/**
 * Class Conta 
 */

/**
 * @author Lucas Campos e Victor Ruas
 *
 */

public class Conta {
	private static int count_conta = 0;
	private int numero;
	private String Nome;
	private double saldo;
	private double limite;
	
	public Conta(double saldo, double limit){;
		numero = count_conta++;
		limite = limit;
		this.saldo = saldo;
	}
	
	public double getSaldo(){
		return saldo;
	}
	
	public double getLimite(){
		return limite;
	}
	
	public String getNome(){
		return Nome;
	}
	
	public int getConta(){
		return numero;
	}
	
	public boolean retirada(double valor){
		if (valor <= saldo + limite){
			saldo -= valor;
			return true;
		}
		return false;
	}
	public void deposito(double valor){
		saldo += valor;
	}
	public boolean transfer(Conta c, double valor){
		if(this.retirada(valor)){
			c.deposito(valor);
			return true;
		}
		return false;
	}
}

