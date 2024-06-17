<%@page import="java.net.URLConnection"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonParser"%>
<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.OutputStreamWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="okhttp3.Response"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="okhttp3.OkHttpClient"%>
<%@page import="okhttp3.Request"%>
<%@page import="okhttp3.RequestBody"%>
<%@page import="it.izs.ws.WsPost"%>
<%@page import="okhttp3.MediaType"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>

<%
	String type = request.getParameter("type");
	String url = request.getParameter("url");
	String urlTest = request.getParameter("urlTest");
	String input = request.getParameter("input");
	String output = "";
	boolean onlyUrl = false;
	if(request.getParameter("onlyUrl")!=null && !request.getParameter("onlyUrl").equals(""))
		onlyUrl = Boolean.parseBoolean(request.getParameter("onlyUrl"));
%>



<%
if(type!=null)
{
		if(type.equals("preaccettazione"))
		{
			

			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			JSONObject json = new JSONObject(input);
			
			output = ChiamaServizioConJSON(url, json);
			}
		}
		else if(type.equals("https://ws.izs.it") || type.equals("https://bdrizsam.izs.it") || type.equals("https://cf-function02.azurewebsites.net") || type.equals("https://mypay.regione.campania.it"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			  String wsResponse = "";
			  
			  MediaType hdr = MediaType.parse("text/xml;charset=UTF-8");
			  
			  RequestBody body = RequestBody.create(hdr, input);
			  Request requestBuild = new Request.Builder().url(url).post(body).build();
		
			  OkHttpClient client = new OkHttpClient.Builder().connectTimeout(20, TimeUnit.SECONDS).writeTimeout(20, TimeUnit.SECONDS).readTimeout(20, TimeUnit.SECONDS).build();
			  
			  try (Response responseB = client.newCall(requestBuild).execute()) 
			  {
				  wsResponse = responseB.body().string();
				  System.out.println("\n\n [*** wsPost ***] RESPONSE:\n" + wsResponse);
				  output = wsResponse;
			  } 
			  catch (IOException e) 
			  {
				  e.printStackTrace();
				  output = e.getMessage();
			  }
			}
		  
		}
		else if(type.equals("documentale"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			String esito="";
			HttpURLConnection conn=null;
			URL obj;
			
			try
			{
				obj = new URL(url);
				conn = (HttpURLConnection) obj.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("GET");

				StringBuffer requestParams = new StringBuffer();
				requestParams.append("tipoCertificato");
				requestParams.append("=").append("-1");
				
				OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
				wr.write(requestParams.toString());
				wr.flush();
				conn.getContentLength();
				esito ="<font color=\"green\">Online</font>";
			}
			catch (IOException e) 
			{
					esito ="<font color=\"red\">OFFLINE</font>";
			} 
			finally 
			{
				conn.disconnect();
			}
			
			output = esito;
			}
		}
		else if(type.equals("sinac_hd"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			
			input = input.replaceAll("\"", "\\\"");
			url = url + "?json=" + input;
			
			response.sendRedirect(url);
			
			//out.println( "Response della chiamata a url: " );
			//out.println( url +"</br></br>" );
			//out.println( "<iframe src='" + url + "'></iframe>");
			}
		}
		
		else if(type.equals("sinac"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			JsonObject json = new JsonObject();
			
			try 
			{
				String[] esitoSinaaf;
				
				url = url + "?json=" + input;
			    URL url2 = new URL(url);
			    HttpURLConnection connection = (HttpURLConnection) url2.openConnection();
			    BufferedReader read = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			    String line = read.readLine();
			    String html = "";
			    while(line!=null) 
			    {
			    	html += line;
			    	line = read.readLine();
			    }
			    html=html.substring(html.indexOf("{"),html.lastIndexOf("}") + 1);
			    html=html.replaceAll("&#34;", "\"");
			    esitoSinaaf = new String[2];
			    esitoSinaaf[1] = html;
			    esitoSinaaf[0] = html;


				if(esitoSinaaf[1]!=null )
				{
					String result = esitoSinaaf[1];
				    JsonParser parser = new JsonParser();  
				    json = (JsonObject) parser.parse(result);  
				}
				
			} 
			catch (Exception e) 
			{
				output=e.getMessage();
			}

			if(output==null || output.equals(""))
				output = json.toString();
			}
		}
		else if(type.equals("https://maps.googleapis.com"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
			else
			{
			try
			{
				String key="AIzaSyA_XTLGPhbMx-cUxUW1H-FEqatg1naFEyk";
				URL url2 = new URL(url + "/maps/api/geocode/json?key="+key+"&address="+input+"&sensor=false&language=it");
				URLConnection connection = url2.openConnection();
				BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String inputLine;
				String jsonResult = "";
				while ((inputLine = in.readLine()) != null) {
				    jsonResult += inputLine;
				}
				in.close();
				output = jsonResult; 
			}
			catch(IOException e)
			{
				output = e.getMessage();
			}
			}
			
		}
		else if(type.equals("https://anagrafecanina.vetinfo.it"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
		}
		else if(type.equals("https://www.vetinfo.it"))
		{
			if(onlyUrl)
			{
				HttpURLConnection conn=null;
				URL obj;
				
				try
				{
					obj = new URL(url);
					conn = (HttpURLConnection) obj.openConnection();
					conn.setDoOutput(true);
					conn.setRequestMethod("GET");

					OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
					wr.flush();
					conn.getContentLength();
					output ="status code: " + conn.getResponseCode();
				}
				catch (IOException e) 
				{
					try{
					output ="status code: " + conn.getResponseCode();
					}
					catch (Exception ex){
						output ="errore di connessione: " + ex.getMessage();
					}
				} 
				finally 
				{
					conn.disconnect();
				}
				
			}
			
		}
		
		
		
		
		
		
		
		
}
		
	%>
	
	
	<form action="testConnectionNew.jsp">
<table>

<tr>
<td></td>
<td>
	<input type="hidden" name="onlyUrl" id="onlyUrl" value=""/>

	<select name="type" id="type" onchange="initDefault();">
		<option value="-1">&lt;-- Selezionare il servizio --&gt;</option>
		<optgroup label="Web Service">
			<option value="https://maps.googleapis.com">https://maps.googleapis.com</option>
			<option value="https://ws.izs.it">https://ws.izs.it</option>
			<option value="https://cf-function02.azurewebsites.net">https://cf-function02.azurewebsites.net</option>
			<option value="https://bdrizsam.izs.it">https://bdrizsam.izs.it</option>
			<option value="https://anagrafecanina.vetinfo.it">https://anagrafecanina.vetinfo.it</option>
			<option value="https://www.vetinfo.it">https://www.vetinfo.it (token sinac)</option>
			<option value="https://mypay.regione.campania.it">https://mypay.regione.campania.it</option>
		</optgroup>
		<optgroup label="Ecosistema GISA">
		<option value="preaccettazione">Preaccettazione</option>
		<option value="documentale">Documentale</option>
		<option value="sinac">Bdu2Sinac</option>
		<option value="sinac_hd">Bdu2Sinac - Funzioni HD</option>
		</optgroup>
	</select>

</td>
</tr>
<tr>
<td>
	Url
</td>
<td>
	<input size="100" type="text" size="50" name="url" id="url" value="<%=url==null ? "" : url%>"  placeholder="url" />

</td>
</tr>
<tr>
<td>
	Url Test
</td>
<td>
	<input size="100" type="text" size="50" name="urlTest" id="urlTest" value="<%=urlTest==null ? "" : urlTest%>"  placeholder="urlTest" />
</td>
</tr>
<tr>
<td>
	Input
	</td>
	<td>
	 <textarea name="input" id="input" placeholder="input" cols="50" rows="10"><%=input==null ? "" : input%></textarea>

</td>
</tr>
<tr>
<td>
	
	Output
</td>
<td> <textarea name="output" id="output" placeholder="output" cols="50" rows="10"><%=output==null ? "" : output%></textarea>

	<br/><br/>
</td>
</tr>
<tr>
<td></td>
<td>	
	<input type="submit" value="Test"                     onclick="if(document.getElementById('type').value=='-1'){alert('Selezionare il tipo di servizio');}else{document.getElementById('onlyUrl').value='false';}">
	<input type="submit" value="Test connection url only" onclick="if(document.getElementById('type').value=='-1'){alert('Selezionare il tipo di servizio');}else{document.getElementById('onlyUrl').value='true';}">
</td>
</tr>


</table>

</form>
	




<script type="text/javascript">
<%
	if(type!=null && !type.equals(""))
	{
%>
		document.getElementById('type').value="<%=type%>";
<%
	}
%>


function initDefault()
{
	type = document.getElementById('type').value;
	input = "";
	url="";
	urlTest="";
	if(type=='https://maps.googleapis.com')
	{
		url='https://maps.googleapis.com';
		urlTest='https://maps.googleapis.com';
		input="via Garibaldi, Napoli";
	}
	else if(type=='https://ws.izs.it')
	{
		url='https://ws.izs.it/j6_apicoltura/ws/apicoltura/apianagrafica/apiario';
		urlTest='https://wstest.izs.it/j_test_apicoltura/ws/apicoltura/apianagrafica/apiario';
		input="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.apianagrafica.apicoltura.izs.it/\"><soapenv:Header><ws:SOAPAutenticazioneWS><username>campania_BDA</username><password>US9560031!</password><ruoloCodice>REG</ruoloCodice><ruoloValoreCodice>150</ruoloValoreCodice></ws:SOAPAutenticazioneWS></soapenv:Header><soapenv:Body><ws:searchApi><ApiarioSearchTO><apiattAziendaCodice>031BN180</apiattAziendaCodice></ApiarioSearchTO></ws:searchApi></soapenv:Body></soapenv:Envelope>";
	}
	else if(type=='https://mypay.regione.campania.it')
	{
		url='https://mypay.regione.campania.it/pa/services/PagamentiTelematiciDovutiPagati/';
		urlTest='https://mypay-test.regione.campania.it/pa/services/PagamentiTelematiciDovutiPagati/';
		input="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ente=\"http://www.regione.veneto.it/pagamenti/ente/\">		   <soapenv:Header/>  <soapenv:Body>    <ente:paaSILChiediPagatiConRicevuta>      <codIpaEnte>R_CAMPAN</codIpaEnte>       <password>VOOYUGNPZZSO</password>  <identificativoUnivocoDovuto>192040010018861</identificativoUnivocoDovuto>    </ente:paaSILChiediPagatiConRicevuta> </soapenv:Body></soapenv:Envelope>";	
	}
	else if(type=='https://cf-function02.azurewebsites.net')
	{
		url='https://cf-function02.azurewebsites.net/api/autenticazione/login';
		urlTest='https://cf-function02-test.azurewebsites.net/api/autenticazione/login';
		input="{\"username\": \"regcampania_CF\",\"password\": \"yrq5nKqSr8CdOPOLmMxi4h/HtPM=\"}";
	}
	else if(type=='preaccettazione')
	{
		//url='http://10.1.15.171:8080/preaccettazione/All/Report/Elencocodicisigla';
		url='http://{ip_privato_preaccettazione}:{porta_preaccettazione}/preaccettazione/All/Report/Elencocodicisigla';
		input="{\"user\": \"rita.mele\",\"password\": \"rita.mele\"}";
	}
	else if(type=='documentale')
	{
		url='http://{ip_privato_documentale}:{porta_documentale}/serverDocumentale/ListaDocs';
		//url='http://10.1.15.4/serverDocumentale/ListaDocs';
		input="";
	}
	else if(type=='sinac')
	{
		//url='http://10.1.15.83:80/Get';
		url='http://{ip_privato_bdu2sinac}:{porta_bdu2sinac}/Get';
		input="{\"codice\":\"380260000938245\",\"evento\":\"giacenza\",\"ambiente\":\"COLLAUDO\"}";
	}
	else if(type=='sinac_hd')
	{
		//url='http://156.54.11.31:80/VediInSinaaf';
		url='http://{ip_pubblico_bdu2sinac}:{porta_bdu2sinac}/VediInSinaaf';
		input="{\"token\":\"380260000938245@giacenza\",\"ambiente\":\"collaudo\",\"forza_allineamento\":\"true\"}";
	}
	else if(type=='https://bdrizsam.izs.it')
	{
		url='https://bdrizsam.izs.it/wsBDNInterrogazioni/wsAziendeQry.asmx';
		urlTest='https://bdrtest.izs.it/wsBDNInterrogazioni/wsAziendeQry.asmx';
		input="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://bdr.izs.it/webservices\"> <soapenv:Header><ser:SOAPAutorizzazione> <ruolo></ruolo></ser:SOAPAutorizzazione><ser:SOAPAutenticazione><ser:username>izsna_006</ser:username><ser:password>na.izs34</ser:password><ruoloCodice></ruoloCodice><ruoloValoreCodice></ruoloValoreCodice></ser:SOAPAutenticazione></soapenv:Header><soapenv:Body><ser:FindAllevamento_STR><ser:p_azienda_codice>017AV389</ser:p_azienda_codice><ser:p_specie_codice></ser:p_specie_codice><ser:p_denominazione></ser:p_denominazione></ser:FindAllevamento_STR></soapenv:Body> </soapenv:Envelope>";
	}
	
	else if(type=='https://anagrafecanina.vetinfo.it')
	{
		url='https://anagrafecanina.vetinfo.it';
		urlTest='https://anagrafecaninatest.vetinfo.it';
		input="";
		}
	
	else if(type=='https://www.vetinfo.it')
	{
		url='https://www.vetinfo.it';
		urlTest='https://test.vetinfo.it';
		input="";
	}
	
	
	
	
	
	
	
	document.getElementById('url').value=url;
	document.getElementById('urlTest').value=urlTest;
	document.getElementById('input').value=input;
	document.getElementById('output').innerHTML="";
}
</script>
	
	
<%! 
public static final String ChiamaServizioConJSON(String urlService, JSONObject json) {
		
		String output = "{}";
		String amb = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("ambiente");
		String abilitazione_chiamata_microservices = org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("abilitazione_chiamata_microservices");
	
			
			URL url = null;
			HttpURLConnection connection;
			int random = (int )(Math.random() * 50 + 1);
			
	        System.out.println("[PREACCETTAZIONE] "+random+" INPUT URL: "+urlService);
	        System.out.println("[PREACCETTAZIONE] "+random+" INPUT JSON: "+json.toString());
			
	        try {
				url = new URL(urlService); //Creating the URL.
		        connection = (HttpURLConnection) url.openConnection();
		        connection.setRequestMethod("POST");
		        connection.setRequestProperty("Content-Type", "application/json");
		        //connection.setRequestProperty("Accept", "application/json");
		        connection.setUseCaches(false);
		        connection.setDoInput(true);
		        connection.setDoOutput(true);
		        connection.connect(); //New line
	
		        //Send request
		        OutputStream os = connection.getOutputStream();
		        OutputStreamWriter osw = new OutputStreamWriter(os, "UTF-8");
		        System.out.println("[PREACCETTAZIONE] "+random+" SERVICE URL: "+url.toString());
		        osw.write(json.toString());
		        osw.flush();
		        osw.close();
		        if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
		            System.out.println("[PREACCETTAZIONE] "+random+" SERVICE Ok response!");
		        } else {
		            System.out.println("[PREACCETTAZIONE] "+random+" SERVICE ******* Bad response *******");
		        }
			
		        BufferedReader in = new BufferedReader( new InputStreamReader(connection.getInputStream()));
				StringBuffer result = new StringBuffer();
		
				//Leggo l'output: l'header del documento generato e il nome assegnatogli
				if (in != null) {
					String ricevuto = in.readLine();
					result.append(ricevuto); }
					in.close();
				output = result.toString();
		        System.out.println("[PREACCETTAZIONE] "+random+" OUTPUT JSON: "+output);
		        
		        } catch (MalformedURLException e) {
					// TODO Auto-generated catch block
					output= e.getMessage();
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					output= e.getMessage();
					e.printStackTrace();
				}  
	        	return output;
	
}
	%>
	
	
	<!-- preaccettazione  -->
	<!-- http://10.1.15.171:8080/preaccettazione/All/Report/Elencocodicisigla   -->
	<!--  {"user": "rita.mele","password": "rita.mele"} -->
	
	<!-- http://10.1.15.171:8080/preaccettazione/All/Report/Getcodicepreaccettazionedacampione   -->
	<!--  {"idCampione": "prova"} -->
		
	<!-- ws_apicoltura -->
	<!-- https://ws.izs.it/j6_apicoltura/ws/apicoltura/apianagrafica/apiario -->
	<!-- <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.apianagrafica.apicoltura.izs.it/"><soapenv:Header><ws:SOAPAutenticazioneWS><username>campania_BDA</username><password>US9560031!</password><ruoloCodice>REG</ruoloCodice><ruoloValoreCodice>150</ruoloValoreCodice></ws:SOAPAutenticazioneWS></soapenv:Header><soapenv:Body><ws:searchApi><ApiarioSearchTO><apiattAziendaCodice>031BN180</apiattAziendaCodice></ApiarioSearchTO></ws:searchApi></soapenv:Body></soapenv:Envelope> -->
	
	
	<!-- documentale -->
	<!-- http://10.1.15.4/serverDocumentale/ListaDocs -->
	<!--  -->
	
	<!--  sinac_h -->
	<!-- http://156.54.11.31:80/VediInSinaaf -->
	<!-- {"token":"380260000938245@giacenza","ambiente":"collaudo","forza_allineamento":"true"} -->

	<!--  sinac -->
	<!-- http://10.1.15.83:80/Get -->
	<!-- {"codice":"380260000938245","evento":"giacenza","ambiente":"COLLAUDO"} -->
	
	
	

