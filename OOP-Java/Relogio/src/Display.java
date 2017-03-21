/**
 * Class Display 
 */

/**
 * @author Lucas Campos
 *
 */
public class Display {
	private int limit;
	private int count;
	
	public Display(int limit){
		this.limit = limit;
	}
	
	public int getLimit() {
		return limit;
	}
	
	public void setLimit(int limit) {
		this.limit = limit;
	}
	
	public int getCount() {
		return count;
	}
	
	public void setCount(int count) {
		this.count = count;
	}
	
	public void increaseCount(){
		count++;
		count = count % limit;
	}
}
