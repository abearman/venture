package venture;

import java.util.ArrayList;

public class Activity {
	
	public int id;
	public String title;
	public String theme;
	public String address;
	public double latitude;
	public double longitude;
	public ArrayList<String> categories = new ArrayList<String>();
	public String phoneNumber;
	public String website;
	public String metadata;
	
	public Activity() { }

	public Activity(String title, int id, String theme, String address, double latitude, double longitude, ArrayList<String> categories, String website, String phoneNumber, String metadata) {
		this.title = title;
		this.id = id;
		this.theme = theme;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.categories = categories;
		this.website = website;
		this.phoneNumber = phoneNumber;
		this.metadata = metadata;
	}
}
