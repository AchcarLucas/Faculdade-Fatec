/**
 * Main Method 
 */

/**
 * @author Lucas Campos
 *
 */

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Clock clock = new Clock();
		for(int i = 0; i < (24*60); i++){
			clock.ticTac();
			try {
				Sleep(60);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static void Sleep(int sec) throws InterruptedException{
		Thread.sleep(sec*1000);
	}

}
