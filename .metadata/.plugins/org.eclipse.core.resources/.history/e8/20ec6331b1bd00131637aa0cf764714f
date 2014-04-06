package venture;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import org.json.JSONException;
import org.json.JSONObject;
 
/**
 * Created by Keenon on 1/20/14.
 */
public class JSONUtil {
	
    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString().trim();
    }
 
    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        String jsonText = "";
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            jsonText = readAll(rd);
            JSONObject json = new JSONObject(jsonText);
            return json;
        }
        catch (JSONException e) {
            System.err.println("Bad JSON text: "+jsonText);
            throw e;
        }
        finally {
            is.close();
        }
    }
}