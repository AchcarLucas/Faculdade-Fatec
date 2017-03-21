
/**
 * Class Clock
 * 
 * @author Lucas Campos Achcar
 * @version 1.0.0 - 22/02/2017
 */

import java.text.DecimalFormat;

public class Clock
{
    private Display mins;
    private Display hours;
    
    Clock(){
        mins = new Display(30, 60);
        hours = new Display(0, 24);
    }
    
    public void TicTac(){
        DecimalFormat time = new DecimalFormat("00");
        System.out.println(time.format(hours.getTime()) + ":" + time.format(mins.getTime()));
        if(mins.increaseTime()){
            hours.increaseTime();
        }
    }
    
    public void test(){
        for(int i = 0; i < (24*60)+1; i++){
            try{
                Thread.sleep(1000);
            }catch(InterruptedException e){
                System.out.println("Exception occurred");
            }
            TicTac();
        }
    }
}
