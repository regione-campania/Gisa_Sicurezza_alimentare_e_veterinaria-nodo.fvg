

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class TestWsSinaafThread extends Thread {


	String id;
	String entita;
	
	public TestWsSinaafThread(String id, String entita)
	{
		this.id = id;
		this.entita = entita;
		
	}
    

	@Override
	public void run() 
	{
		URL url;
		try {
			url = new URL("http://131.1.255.93/sync2?json={\"token\":\"" + id + "@" + entita  + "\",\"ambiente\":\"ufficiale\",\"forza_allineamento\":\"true\"}");
		
		  
		  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		  System.out.println(url);
		  BufferedReader read = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		  String line = read.readLine();
		  String html = "";
		  /*while(line!=null) {
		    html += line;
		    line = read.readLine();
		  }*/
		  System.out.println(url + "ok");
		  
		  
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	public void stopRunning()
    {
    }
	
	
}