import java.text.DecimalFormat;

/**
 * Class Clock 
 */

/**
 * @author Lucas Campos
 *
 */

public class Clock {
	private Display hour;
	private Display min;
	
	public Clock(){
		hour = new Display(24);
		min = new Display(60);
	}
	
	public Clock(Display hour, Display min){
		this.hour = hour;
		this.min = min;
	}
	
	public void DisplayClock(){
		DecimalFormat clockFormat = new DecimalFormat("00");
		System.out.println(clockFormat.format(hour.getCount()) + ":" + clockFormat.format(min.getCount()));
	}
	
	public void setClock(int hour, int min){
		// clamp 0 to limit
		hour = hour % this.hour.getLimit();
		min = min % this.min.getLimit();
		
		// set hour and min
		this.hour.setCount(hour);
		this.min.setCount(min);
	}
	
	public void ticTac(){
		min.increaseCount();
		if(min.getCount() == 0){
			hour.increaseCount();
		}
		this.DisplayClock();
	}
}
