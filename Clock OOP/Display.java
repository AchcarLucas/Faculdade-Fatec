
/**
 * Classe Display
 * 
 * @author Lucas Campos Achcar
 * @version 1.0.0 - 22/02/2017
 */
public class Display
{
    private int time;           // do count of time
    private int breakTime;      // break time to zero again
    
    Display(int time, int breakTime){
        this.time = time;
        this.breakTime = breakTime;
    }
    
    public boolean increaseTime(){
        time++;
        if(time >= breakTime){
            resetTime();
            return true;    // Break point Carry (resetTime)
        }
        return false;   // None
    }
    
    public boolean decreaseTime(){
        time--;
        if(time <= 0){
            time = breakTime;
            return true;    // Break point Carry (Time Elipse)
        }
        return false;   // None
    }
    
    public void resetTime(){
        time = 0;
    }
    
    public int getTime(){
        return time;
    }
}
