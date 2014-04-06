package venture;

import java.util.ArrayList;

public class Activity {
	
	public String title;
	public String address;
	public double latitude;
	public double longitude;
	public ArrayList<String> categories = new ArrayList<String>();
	public String phoneNumber;
	public String website;
	public String metadata;

	public Activity(String title, String address, double latitude, double longitude, ArrayList<String> categories, String website, String phoneNumber, String metadata) {
		this.title = title;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.categories = categories;
		this.website = website;
		this.phoneNumber = phoneNumber;
		this.metadata = metadata;
	}
}
