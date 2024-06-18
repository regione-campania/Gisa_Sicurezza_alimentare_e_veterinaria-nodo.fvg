package org.aspcfs.modules.ws;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import org.aspcfs.utils.ApplicationProperties;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


public class WsPost 
{
		  public static final MediaType hdr  = MediaType.parse("text/xml;charset=UTF-8");
		  public static final MediaType JSON  = MediaType.parse("application/json;charset=UTF-8");

		  
		  public static final int ENDPOINT_API = 1 ;
		  public static final int ENDPOINT_API_REGINE	= 2 ;
		  public static final int ENDPOINT_ACQUACOLTURA	= 3 ;
		  public static final int ENDPOINT_API_MOVIMENTAZIONI	= 4 ;
		  public static final int ENDPOINT_API_MOVIMENTAZIONI_INGRESSO	= 5 ;
		  public static final int ENDPOINT_API_MOVIMENTAZIONI_DETTAGLIO_MODELLO	= 6 ;
		  public static final int ENDPOINT_API_ATTIVITA = 7 ;
		  public static final int ENDPOINT_PRELIEVO_MOLLUSCHI = 8 ;
		  public static final int ENDPOINT_ALLEVAMENTI = 9 ;
		  public static final int ENDPOINT_ALLEVAMENTI_AZIENDA = 10 ;
		  public static final int ENDPOINT_ALLEVAMENTI_PERSONA = 11 ;
		  
		  public static final int AZIONE_GET = 1 ;
		  public static final int AZIONE_GETBYPK = 2 ;
		  public static final int AZIONE_INSERT = 3 ;
		  public static final int AZIONE_UPDATE = 4 ;
		  public static final int AZIONE_DELETE = 5 ;
		  
		  public static final String AMBIENTE_UFFICIALE = "UFFICIALE" ;
		  public static final String AMBIENTE_DEMO = "DEMO" ;
		  
		  public String url = "";
		  private String wsRequest = "";
		  private String xmlns;
		  private String suffissoAutenticazione;
		  private String prefissoUsernamePassword;
		  private String username;
		  private String password;
		  private String ruolo;
		  private String ruoloCodice;
		  private String ruoloValoreCodice;
		  private String nomeServizio;
		  private String tipoAutorizzazione;
		  private String nomeOggetto;
		  private String ambiente;
		  private int idEndpoint;
		  private HashMap<String,Object> campiOggetto = new HashMap<>();
		  private HashMap<String,Boolean> obbligatorioCampo = new HashMap<>();
		  private HashMap<String,Object> campiInput = new HashMap<>();
		  public boolean propagazioneSinaaf;
		  public String presenteInGisa;
		  public boolean sincronizzato;
		  public String nomeWs;
		  public String dbiGetEnvelope;
		  public String idTabella;
		  public String tabella;
		  public String dipendenze;
		  public String nomeCampoIdSinaaf;
		  public String nomeCampoCodiceSinaaf;
		  public String nomeCampoCodiceSinaafGET;
		  public String idSinaaf;
		  public String idSinaafSecondario;
		  public String codiceSinaaf;
		  public WsPost wsPostSecondario = null;
		  public String method;
		  public int step;
		  public String idEntita;
		  public String tokenReturn;
		  
		  
		  public WsPost()
		  {
		  }
		  
		  public WsPost(Connection db,String idEntita,String entita,String url)
		  {
			  setInfoWs(db,idEntita, entita);
			  this.url=url+nomeWs;
			  if(wsPostSecondario!=null)
				  wsPostSecondario.url=url+wsPostSecondario.nomeWs;
		  }
		  
		  public WsPost(Connection db,String idEntita,String entita,String url,String method)
		  {
			  setInfoWs(db,idEntita, entita,method);
			  this.url=url+nomeWs;
			  if(wsPostSecondario!=null)
				  wsPostSecondario.url=url+wsPostSecondario.nomeWs;
		  }
		  
		  public String getLabelSincronizzazione()
		  {
			  if(sincronizzato)
				  return "INVIATO SINCRONIZZATO";
			  else if((idSinaaf==null || idSinaaf.equals("")) && (codiceSinaaf==null || codiceSinaaf.equals("")))
				  return "NON SINCRONIZZATO";
			  else
				  return "INVIATO NON SINCRONIZZATO";
			  
		  }
		  
		  public String getColoreSincronizzazione()
		  {
			  if(sincronizzato)
				  return "verde";
			  else if((idSinaaf==null || idSinaaf.equals("")) && (codiceSinaaf==null || codiceSinaaf.equals("")))
				  return "rosso";
			  else
				  return "giallo";
			  
		  }
		  
		  public String getIdEntita() 
		  {
		  	return idEntita;
		  }
		
		  public void setIdEntita(String idEntita) 
		  {
		  	this.idEntita = idEntita;
		  }
		  
		  public String getTokenReturn() 
		  {
		  	return tokenReturn;
		  }
		
		  public void setTokenReturn(String tokenReturn) 
		  {
		  	this.tokenReturn = tokenReturn;
		  }
		  
		  public String getWsRequest() 
		  {
		  	return wsRequest;
		  }
		
		  public void setWsRequest(String wsRequest) 
		  {
		  	this.wsRequest = wsRequest;
		  }
		
		  public HashMap<String, Object> getCampiInput() 
		  {
		  	return campiInput;
		  }
		
		  public void setCampiInput(HashMap<String, Object> campiInput) 
		  {
		  	this.campiInput = campiInput;
		  }
		
		  public String getXmlns() 
		  {
		  	return xmlns;
		  }
		
		  public void setXmlns(String xmlns) 
		  {
		  	this.xmlns = xmlns;
		  }
		  
		  public String getPrefissoUsernamePassword() 
		  {
		  	return prefissoUsernamePassword;
		  }
		
		  public void setPrefissoUsernamePassword(String prefissoUsernamePassword) 
		  {
		  	this.prefissoUsernamePassword = prefissoUsernamePassword;
		  }
		  
		  public String getSuffissoAutenticazione() 
		  {
		  	return suffissoAutenticazione;
		  }
		
		  public void setSuffissoAutenticazione(String suffissoAutenticazione) 
		  {
		  	this.suffissoAutenticazione = suffissoAutenticazione;
		  }
		  
		  public String getWsUrl() 
		  {
		  	return url;
		  }
		
		  public void setWsUrl(String url) 
		  {
		  	this.url = url;
		  }
		
		  public String getNomeServizio() 
		  {
		  	return nomeServizio;
		  }
		
		  public void setNomeServizio(String nomeServizio) 
		  {
		  	this.nomeServizio = nomeServizio;
		  }
		  
		  public String getTipoAutorizzazione() 
		  {
		  	return tipoAutorizzazione;
		  }
		
		  public void setTipoAutorizzazione(String tipoAutorizzazione) 
		  {
		  	this.tipoAutorizzazione = tipoAutorizzazione;
		  }
		
		  public String getNomeOggetto() 
		  {
		  	return nomeOggetto;
		  }
		
		  public void setNomeOggetto(String nomeOggetto) 
		  {
		  	this.nomeOggetto = nomeOggetto;
		  }
		  
		  public int getIdEndpoint() 
		  {
		  	return idEndpoint;
		  }
		
		  public void setIdEndpoint(int idEndpoint) 
		  {
		  	this.idEndpoint = idEndpoint;
		  }
		
		  public String getUsername() 
		  {
		    return username;
		  }
		
		  public void setUsername(String username) 
		  {
			this.username = username;
		  }
	
		  public String getPassword() 
		  {
		    return password;
		  }
	
	  	  public void setPassword(String password) 
	  	  {
	  		this.password = password;
	  	  }
	
	  	  public String getRuolo() 
	  	  {
	  		return ruolo;
	  	  }
	
	  	  public void setRuolo(String ruolo) 
	  	  {
	  		this.ruolo = ruolo;
	  	  }
	
	  	  public String getRuoloCodice() 
	  	  {
	  		return ruoloCodice;
	  	  }
	
	  	  public void setRuoloCodice(String ruoloCodice) 
	  	  {
	  		this.ruoloCodice = ruoloCodice;
	  	  }
	
	  	  public String getRuoloValoreCodice() 
	  	  {
	  		return ruoloValoreCodice;
	  	  }
	
	  	  public void setRuoloValoreCodice(String ruoloValoreCodice) 
	  	  {
	  		this.ruoloValoreCodice = ruoloValoreCodice;
	  	  }

		  public String post(Connection db, Integer userId,MediaType mediaType,String token, String idTabella, String tabella,String method)  
		  {
			  salvaStorico(db, userId, "### TENTATIVO DI CHIAMATA AI SERVIZI ### ");
			  
			  String suffissoWs="";
			  if(method.equalsIgnoreCase("put") )
				  suffissoWs="/"+idSinaaf;
		
			  String wsResponse = "";
			  System.out.println("\n [*** wsPost ***] URL :\n" + url+suffissoWs);
			  System.out.println("\n\n [*** wsPost ***] REQUEST:\n" + wsRequest); 
			  
			  RequestBody body = RequestBody.create(mediaType, wsRequest);
			  Request request = null;
			  okhttp3.Request.Builder builder ;
			  if(token!=null)
				  builder = new Request.Builder().addHeader("Authorization", "Bearer " + token).addHeader("Izs-Profile-Role", "WSREG").addHeader("Izs-Profile-Code", "150").url(url+suffissoWs);
			  else
				  builder = new Request.Builder().url(url+suffissoWs);
				  
			  if(method.equalsIgnoreCase("post"))
				  request = builder.post(body).build();
			  else if(method.equalsIgnoreCase("delete"))
				  request = builder.delete(body).build();
			  else if(method.equalsIgnoreCase("get"))
				  request = builder.get().build();
			  else
				  request = builder.put(body).build();
				  
			  OkHttpClient client = new OkHttpClient.Builder().connectTimeout(60, TimeUnit.SECONDS).writeTimeout(60, TimeUnit.SECONDS).readTimeout(60, TimeUnit.SECONDS).build();
			  
			  try (Response response = client.newCall(request).execute()) 
			  {
				  String esito = "OK";
				  wsResponse = response.body().string();
				  JsonParser parser = new JsonParser(); 
				  JsonObject json = (JsonObject) parser.parse(wsResponse);
				  String status = (json.get("status")==null)?(null):(json.get("status").toString());
				  String errors = (json.get("errors")==null)?(null):(json.get("errors").toString());
				  String error = (json.get("error")==null)?(null):(json.get("error").toString());
				  if(!getEsitoChiamata(status, error, errors))
					  esito="KO";
				  
				  
				  System.out.println("\n\n [*** wsPost ***] RESPONSE:\n" + wsResponse);
				  salvaStorico(db, userId, wsResponse,idTabella,tabella,esito,method);
			  } 
			  catch (IOException e) 
			  {
				  // TODO Auto-generated catch block
				  e.printStackTrace();
				  salvaStorico(db, userId, "### TENTATIVO DI CHIAMATA AI SERVIZI FALLITO ###: "+e.getStackTrace().toString(),idTabella,tabella,"KO",method);
			  }
			  return wsResponse;
		  }
		  
			private void salvaStorico(Connection db, int userId, String wsResponse, String idTabella, String tabella, String esito,String metodo)  
			{
				PreparedStatement pst;
				try 
				{
			        System.out.println("\n\n [*** wsPost ***] INSERISCO STORICO ");
			
					//pst = db.prepareStatement("insert into ws_storico_chiamate(url, request, response, id_utente, data, id_tabella, tabella, esito) values (?, ?, ?, ?, now(), ?,?,?);");
					
					pst = db.prepareStatement("select * from ws_insert_storico_chiamate (?, ?, ?, ?, ?,?,?);");
					
					
					pst.setString(1, url);
					pst.setString(2, wsRequest);
					pst.setString(3, wsResponse);
					pst.setInt(4, userId);
					pst.setString(5, idTabella);
					pst.setString(6, tabella);
					pst.setString(7, esito);
					pst.execute();
					
					//SVILUPPO APE
			        /*pst = db.prepareStatement(" select * from ws_storico_chiamate(?, ?, ?, ?, now(), ?,?,?);" );
					
					pst.setString(1, url);
					pst.setString(2, wsRequest.replaceAll("'", "''"));
					pst.setString(3, wsResponse.replaceAll("'", "''"));
					pst.setInt(4, userId);
					pst.setString(5, esito);
					pst.setString(6, "sinaaf");
					pst.setString(7, metodo);
					pst.execute();*/
					//FINE SVILUPPO APE
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			private void salvaStorico(Connection db, int userId, String wsResponse)  
			{
				PreparedStatement pst;
				try 
				{
			        System.out.println("\n\n [*** wsPost ***] INSERISCO STORICO ");
			
					/*pst = db.prepareStatement("insert into ws_storico_chiamate(url, request, response, id_utente, data) values (?, ?, ?, ?, now());");
					
					pst.setString(1, url);
					pst.setString(2, wsRequest);
					pst.setString(3, wsResponse);
					pst.setInt(4, userId);*/
					
					
					pst = db.prepareStatement("select * from ws_insert_storico_chiamate (?, ?, ?, ?, ?,?,?);");
					pst.setString(1, url);
					pst.setString(2, wsRequest);
					pst.setString(3, wsResponse);
					pst.setInt(4, userId);
					pst.setString(5, null);
					pst.setString(6, null);
					pst.setString(7, null);
					
					
					pst.execute();
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			public WsPost getSincronizzato(Connection db, String idTabella, String tabella,String nomeIdTabella)  
			{
				PreparedStatement pst;
				WsPost ws = new WsPost();
				try 
				{
					pst = db.prepareStatement("select * from sinaaf_is_sincronizzato(?,?,?)");

					pst.setString(1, idTabella);
					pst.setString(2, tabella);
					pst.setString(3, nomeIdTabella);
					
					ResultSet rs = pst.executeQuery();
					if(rs.next() )
					{
						ws.sincronizzato = rs.getBoolean("sincronizzato");
						ws.idSinaaf = rs.getString("id_sinaaf");
						ws.idSinaafSecondario = rs.getString("id_sinaaf_secondario");
						ws.codiceSinaaf= rs.getString("codice_sinaaf");
					}
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return ws;
			}
			
			
			public void setIdSinaaf(Connection db, String idSinaaf, String idEntita,String codiceSinaaf) throws SQLException  
			{
				setIdSinaaf( db,  idSinaaf,  idEntita, codiceSinaaf,"");
			}
			
			public void setIdSinaaf(Connection db, String idSinaaf, String idEntita, String codiceSinaaf,String suffisso) throws SQLException  
			{
				PreparedStatement pst;
				pst = db.prepareStatement("update "+ tabella + " set id_sinaaf" + suffisso  + " = ?::integer, codice_sinaaf = ? where " + idTabella + "::text = ?::text ");
				pst.setString(1, idSinaaf);
				pst.setString(2, codiceSinaaf);
				pst.setString(3, idEntita);
				pst.execute();
			}
			
			public void setModifiedSinaaf(Connection db, String tabella, String idEntita) throws SQLException  
			{
				
				if(tabella.equalsIgnoreCase("proprietario"))
				{
					tabella="opu_relazione_stabilimento_linee_produttive";
					idTabella="id";
				}
				else if(tabella.equalsIgnoreCase("evento"))
				{
					idTabella="id_evento";
				}
				else if(tabella.equalsIgnoreCase("microchips"))
				{
					idTabella="microchip";
				}
				PreparedStatement pst;
				pst = db.prepareStatement(" update "+ tabella + " set modified_sinaaf = current_timestamp where " + idTabella + "::text = ? ");
				pst.setString(1, idEntita);
				pst.execute();
			}
			
			public String getIdSinaaf(Connection db, String idEntita) throws SQLException  
			{
				PreparedStatement pst;
				pst = db.prepareStatement("select coalesce(id_sinaaf,codice_sinaaf) as id_sinaaf from "+ tabella + " where " + idTabella + "::text = ? ");
				pst.setString(1, idEntita);
				ResultSet rs = pst.executeQuery();
				if(rs.next())
				{
					return rs.getString(1);
				}
				return null;
			}
			
			public void setInfoWs(Connection db, String idEntita, String entita)  
			{
				setInfoWs( db,  idEntita,  entita,null);
			}
			
			
			
			public void setInfoWs(Connection db, String idEntita, String entita,String method)  
			{
				PreparedStatement pst;
				try 
				{
					pst = db.prepareStatement("select * from sinaaf_get_info_ws(?,?,?)");
					
					pst.setString(1, idEntita);
					pst.setString(2, entita);
					pst.setString(3, method);
					ResultSet rs = pst.executeQuery();
					if(rs.next() )
					{
							propagazioneSinaaf=rs.getBoolean(1);
							nomeWs=(rs.getString(2)==null)?(""):(rs.getString(2).split(";")[0]);
							dbiGetEnvelope=(rs.getString(3)==null)?(""):(rs.getString(3).split(";")[0]);
							idTabella=rs.getString(4);
							tabella=rs.getString(5); 
							dipendenze=rs.getString(6); 
							nomeCampoIdSinaaf=(rs.getString(7)==null)?(""):(rs.getString(7).split(";")[0]);
							nomeCampoCodiceSinaafGET=(rs.getString(11)==null)?(""):(rs.getString(11).split(";")[0]);
							nomeCampoCodiceSinaaf=(rs.getString(12)==null)?(""):(rs.getString(12).split(";")[0]);
							presenteInGisa=rs.getString(8);
							sincronizzato=rs.getBoolean(9);
							idSinaaf = rs.getString(10);
							codiceSinaaf = rs.getString(13);
							
							if(rs.getString(2)!=null && rs.getString(2).split(";").length>1)
							{
								wsPostSecondario = new WsPost();
								wsPostSecondario.propagazioneSinaaf=propagazioneSinaaf;
								wsPostSecondario.nomeWs=(rs.getString(2)==null)?(""):(rs.getString(2).split(";")[1]);
								wsPostSecondario.dbiGetEnvelope=(rs.getString(3)==null)?(""):(rs.getString(3).split(";")[1]);
								wsPostSecondario.idTabella=idTabella;
								wsPostSecondario.tabella=tabella; 
								wsPostSecondario.dipendenze=dipendenze; 
								wsPostSecondario.nomeCampoIdSinaaf=(rs.getString(7)==null)?(""):(rs.getString(7).split(";")[1]);
								wsPostSecondario.nomeCampoCodiceSinaafGET=(rs.getString(11)==null)?(""):(rs.getString(11).split(";")[1]);
								wsPostSecondario.nomeCampoCodiceSinaaf=(rs.getString(12)==null)?(""):(rs.getString(12).split(";")[1]);
								wsPostSecondario.presenteInGisa=presenteInGisa;
								wsPostSecondario.sincronizzato=sincronizzato;
								wsPostSecondario.idSinaaf = idSinaaf;
								wsPostSecondario.codiceSinaaf = codiceSinaaf;
							}
					}
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			
			public boolean getPropagabilitaByVersion(Connection db, String idEntita, String entita)  
			{
				PreparedStatement pst;
				boolean propagabile = false;
				try 
				{
					pst = db.prepareStatement("select * from sinaaf_get_propagabilita_by_version(?,?)");
					
					pst.setString(1, idEntita);
					pst.setString(2, entita);
					ResultSet rs = pst.executeQuery();
					if(rs.next() )
					{
						propagabile = rs.getBoolean(1);
					}
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return propagabile;
			}
			
			public boolean getPropagabilita(Connection db, String idEntita, String entita)  
			{
				PreparedStatement pst;
				boolean propagabile = false;
				try 
				{
					if(ApplicationProperties.getProperty("SINAAF_ATTIVO")==null || ApplicationProperties.getProperty("SINAAF_ATTIVO").equals("false"))
					{
						propagabile = false;
					}
					else
					{
						pst = db.prepareStatement("select * from sinaaf_get_propagabilita(?,?)");
						
						pst.setString(1, idEntita);
						pst.setString(2, entita);
						ResultSet rs = pst.executeQuery();
						if(rs.next() )
						{
							propagabile = rs.getBoolean(1);
						}
					}
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return propagabile;
			}
			
			
			
			
			public String getToken() throws SQLException, IOException 
			{
				OkHttpClient client = new OkHttpClient();
				MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
				
				String username = ApplicationProperties.getProperty("USERNAME_WS_SINAAF");
				String password = ApplicationProperties.getProperty("PASSWORD_WS_SINAAF");
				String url = ApplicationProperties.getProperty("END_POINT_SINAAF_TOKEN");
				String authorization = ApplicationProperties.getProperty("AUTHORIZATION_METHOD_SINAAF");
				
				RequestBody body = RequestBody.create(mediaType, "grant_type=password&username="+username+"&password="+password);
				Request request = new Request.Builder()
				.url(url)
				.post(body)
				.addHeader("authorization", "Basic " + authorization)
				.addHeader("content-type", "application/x-www-form-urlencoded")
				.addHeader("cache-control", "no-cache")
				.build();
				Response response = client.newCall(request).execute();
				
				int code = response.code();
				String token = null;
				if(code==200)
				{
					String result = response.body().string();
				    JsonParser parser = new JsonParser();  
				    JsonObject json = (JsonObject) parser.parse(result);  
				    token = json.get("access_token").toString();
				    token=token.replaceAll("\"", "");
				    System.out.println("Token: " + token);
				}
				else
				{
					String result = response.body().string();
				    JsonParser parser = new JsonParser();  
				    JsonObject json = (JsonObject) parser.parse(result);  
				    String errore = json.get("error").toString();
				    String erroreDescrizione = json.get("error_description").toString();
				    System.out.println("Errore: " + errore);
				    System.out.println("ErroreDescrizione: " + erroreDescrizione);
					//throw new Exception("Errore nella richiesta del token. Errore: " + errore + ". ErroreDescrizione: " + erroreDescrizione);
				}
				
				
				return token;
			}
			
			
			private boolean getEsitoChiamata(String status, String error, String errors)
			{
				boolean statusError = status!=null && (status.equals("422") || status.equals("500") || status.equals("403"));
			    boolean status404 = status!=null && status.equals("404");
			    boolean nessunaModifica = (error!=null && error.toUpperCase().contains("NESSUNA MODIFICA")) || (errors!=null && errors.toUpperCase().contains("NESSUNA MODIFICA"));
			    if(statusError || (status404 && !nessunaModifica))
			    	return false;
			    else
			    	return true;
			}
			
			
			public ArrayList<WsPost> getChiamate(Connection db, String idEntita, String entita,String method)  
			{
				PreparedStatement pst;
				ArrayList<WsPost> lista = new ArrayList<WsPost>();
				try 
				{
					pst = db.prepareStatement("select * from sinaaf_get_step_allineamento_entita(?,?)");
					
					pst.setString(1, idEntita + "@" + entita);
					pst.setString(2, method);
					ResultSet rs = pst.executeQuery();
					while(rs.next() )
					{
							WsPost ws = new WsPost();
							ws.propagazioneSinaaf=rs.getBoolean(1);
							ws.nomeWs=(rs.getString(2)==null)?(""):(rs.getString(2).split(";")[0]);
							ws.dbiGetEnvelope=(rs.getString(3)==null)?(""):(rs.getString(3).split(";")[0]);
							ws.idTabella=rs.getString(4);
							ws.tabella=rs.getString(5); 
							ws.dipendenze=rs.getString(6); 
							ws.nomeCampoIdSinaaf=(rs.getString(7)==null)?(""):(rs.getString(7).split(";")[0]);
							ws.nomeCampoCodiceSinaafGET=(rs.getString(11)==null)?(""):(rs.getString(11).split(";")[0]);
							ws.nomeCampoCodiceSinaaf=(rs.getString(12)==null)?(""):(rs.getString(12).split(";")[0]);
							ws.presenteInGisa=rs.getString(8);
							ws.sincronizzato=rs.getBoolean(9);
							ws.idSinaaf = rs.getString(10);
							ws.codiceSinaaf = rs.getString(13);
							ws.method =  rs.getString(14);
							ws.wsRequest = (rs.getString(15)==null)?(""):(rs.getString(15));
							ws.idEntita = (rs.getString(16)==null)?(null):(rs.getString(16).split("@")[0]);
							ws.tokenReturn = rs.getString(16);
							ws.step = rs.getInt(17);
							ws.url=ApplicationProperties.getProperty("END_POINT_SINAAF")+ws.nomeWs;
							lista.add(ws);
					}
				} 
				catch (SQLException e) 
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return lista;
			}
			
			
			
}
