package org.aspcf.modules.checklist_benessere.actions;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
 
/**
 * Servlet implementation class ServletComuni
 */
public class ServletTestClassyfarm extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/** 
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletTestClassyfarm() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
			
			String url = "https://cf-function02.azurewebsites.net/api/autenticazione/login";
			String wsRequest = "{\"username\": \"regcampania_CF\",\"password\": \"yrq5nKqSr8CdOPOLmMxi4h/HtPM=\"}";
			
			MediaType hdr  = MediaType.parse("text/xml;charset=UTF-8");
			MediaType JSON  = MediaType.parse("application/json;charset=UTF-8");

			int TIMEOUT_SECONDS = 60 ;

			 String wsResponse = "";
			  System.out.println("\n [*** wsPost ***] URL :\n" + url);
			  System.out.println("\n\n [*** wsPost ***] REQUEST:\n" + wsRequest); 
			  
			res.getWriter().println("\n [*** wsPost ***] URL :\n" + url);			
			res.getWriter().println("\n\n [*** wsPost ***] REQUEST:\n" + wsRequest);			

			  
			  RequestBody body = RequestBody.create(hdr, wsRequest);
			  Request request = new Request.Builder().url(url).post(body).build();
		
			  OkHttpClient client = new OkHttpClient.Builder().connectTimeout(TIMEOUT_SECONDS, TimeUnit.SECONDS).writeTimeout(TIMEOUT_SECONDS, TimeUnit.SECONDS).readTimeout(TIMEOUT_SECONDS, TimeUnit.SECONDS).build();
			  
			  try (Response response = client.newCall(request).execute()) 
			  {
				  wsResponse = response.body().string();
				  System.out.println("\n\n [*** wsPost ***] RESPONSE:\n" + wsResponse);
	   			  res.getWriter().println("\n\n [*** wsPost ***] RESPONSE:\n" + wsResponse);			

			  } 
			  catch (IOException e) 
			  {
				  // TODO Auto-generated catch block
				  e.printStackTrace();
				 res.getWriter().println("\n\n ERRORE: " +e.getMessage());			
			  }
			
			
		
	} 
}