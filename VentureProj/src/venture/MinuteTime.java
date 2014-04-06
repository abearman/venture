package venture;

import java.lang.Integer;
import java.lang.Math;
import java.lang.String;
import java.util.Calendar;
 
/**
 * Created by Keenon on 1/21/14.
 */
public class MinuteTime {
 
    public int minute;
    public final int MINUTES_PER_DAY = 60*24;
 
    public MinuteTime() {
        Calendar cal = Calendar.getInstance();
        minute = (int)Math.floor(cal.getTimeInMillis() / 60000);
    }
    
    public MinuteTime(int minute) {
    	this.minute = minute;
    }
 
    public int getMinutesUntilToday() {
        Calendar cal = Calendar.getInstance();
        return ((int)Math.floor(cal.getTimeInMillis() / 60000))%MINUTES_PER_DAY;
    }
 
    public String toString() {
        int dayMinute = minute%MINUTES_PER_DAY;
        int hours = (int)Math.floor(((double)dayMinute)/60f);
        int minutes = dayMinute-(hours*60);
        boolean AM = true;
        if (hours >= 12) {
            AM = false;
            if (hours > 12) hours -= 12;
        }
        return hours+":"+((new Integer(minutes)).toString().length() == 1 ? "0" : "")+minutes+(AM?"AM":"PM");
    }
 
    public MinuteTime(String parse) {
        String[] parts = parse.split(":");
        int hours = Integer.parseInt(parts[0]);
        String minutes = parts[1];
        boolean AM = false;
        if (minutes.contains("am") || minutes.contains("AM")) {
            AM = true;
        }
        else if (minutes.contains("pm") || minutes.contains("PM")) {
            AM = false;
        }
        else {
            // Just assume PM. There are things wrong with this, but TODO
            AM = false;
        }
        minutes = minutes.replaceAll("am","").replaceAll("pm","").replaceAll("AM","").replaceAll("PM","").trim();
        if (!AM && hours != 12) hours += 12;
        minute = getMinutesUntilToday()+(hours*60)+Integer.parseInt(minutes);
    }
 
    public MinuteTime(MinuteTime reference, int minutesOffset) {
        minute = reference.minute + minutesOffset;
    }
 
    public boolean withinMinutesOf(MinuteTime current, int minutesOffset) {
        return ((minute - current.minute)<minutesOffset) && ((minute - current.minute)>0);
    }
 
}