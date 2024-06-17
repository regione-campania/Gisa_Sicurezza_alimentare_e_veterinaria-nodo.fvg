package it.us.web.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;






import java.util.Calendar;
import java.util.HashMap;

import javax.xml.xpath.XPathConstants;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import it.us.web.bean.guc.Ruolo;
import it.us.web.bean.guc.Utente;
import it.us.web.dao.guc.RuoloDAO;
import it.us.web.db.ApplicationProperties;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.LoginUtil;
import it.us.web.util.guc.DbUtil;
import it.us.web.util.guc.GUCEndpoint;
import it.us.web.util.guc.GUCOperationType;

public class IndexSca extends GenericAction
{
	
	
	
	public IndexSca() {		
	}
	
	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
		if( utenteGuc == null)
		{
			//gotoPage("/jsp/sca/index.jsp" );
			if(Boolean.parseBoolean(ApplicationProperties.getProperty("login_spid")))
			{
				req.setAttribute("test", req.getParameter("test"));
				gotoPage("/indexSpidVersion.jsp" );
			}
			else
			{
				req.setAttribute("reload", req.getParameter("reload"));
				gotoPage("/index.jsp" );
			}
		}
		else
		{
			ResultSet rs = null;
			if(Boolean.parseBoolean(ApplicationProperties.getProperty("login_spid")))
				rs = RuoloDAO.getEndpointByCf(utenteGuc.getCodiceFiscale(), db);
			else
				rs = RuoloDAO.getEndpointByIdUtente(utenteGuc.getId(), db);
			ArrayList<String> ruoli = new ArrayList<String>();
			ArrayList<String> endpoints = new ArrayList<String>();
			ArrayList<String> username = new ArrayList<String>();
			ArrayList<String> asl = new ArrayList<String>();
			ArrayList<String> num_registrazione_stab = new ArrayList<String>();
			ArrayList<String> lista_partita_iva = new ArrayList<String>();
			ArrayList<String> canilebdu = new ArrayList<String>();
			//RuoloDAO.getRolesByIdUtenteN(utenteGuc.getId(), db);
			//ArrayList<String> endpoints = RuoloDAO.getRolesByIdUtenteN(utenteGuc.getId(), db);
			//ArrayList<String> username = RuoloDAO.getUsernameByEndpoint(utenteGuc.getId(), db);
			
			//Flusso 342
			ArrayList<Integer> ruolo_id = new ArrayList<Integer>();
			ArrayList<Integer> asl_id = new ArrayList<Integer>();
			ArrayList<String> qualifica = new ArrayList<String>();
			ArrayList<String> profilo_professionale = new ArrayList<String>();
			
			//Query in caso di esistenza di raggruppamento
			while( rs.next())
			{	
				endpoints.add(rs.getString("endpoint") );
				ruoli.add(rs.getString("ruolo_string") );
				ruolo_id.add(rs.getInt("ruolo_id"));
				username.add(rs.getString("username") );
				asl.add(rs.getString("asl"));
				asl_id.add(rs.getInt("asl_id"));
				try
				{
				num_registrazione_stab.add(rs.getString("num_registrazione_stab"));
				lista_partita_iva.add(rs.getString("piva"));
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
				try
				{
					canilebdu.add(rs.getString("canilebdu_description"));
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			
			for(int i = 0;i<endpoints.size();i++){
				String sql = "select distinct * from opzioni.get_info_utente(?,?,?,?);";
				PreparedStatement pst = db.prepareStatement(sql);
				pst.setString(1, utenteGuc.getCodiceFiscale());
				pst.setString(2,endpoints.get(i));
				pst.setInt(3, ruolo_id.get(i));
				pst.setInt(4, asl_id.get(i));
				//System.out.println(pst);
				rs = pst.executeQuery();
				
				while(rs.next()){
					qualifica.add(rs.getString("qualifica"));
					profilo_professionale.add(rs.getString("profilo_professionale"));
				}
			}
			
			req.setAttribute("endpoints", endpoints);
			req.setAttribute("roles", ruoli);
			req.setAttribute("username", username);
			req.setAttribute("asl", asl);
			req.setAttribute("qualifica", qualifica);
			req.setAttribute("profilo_professionale", profilo_professionale);
			try {
			req.setAttribute("num_registrazione_stab", num_registrazione_stab);
			req.setAttribute("lista_partita_iva", lista_partita_iva);
			
			String mGisa = "";
			String mBdu = "";
			String mVam = "";
			
			Connection db = gtConnectionDb();
			
			String sql = "select * from get_messaggio_home('gisa')";
			PreparedStatement pst = db.prepareStatement(sql);
			ResultSet rsM = pst.executeQuery();
			
			while(rsM.next()){
				mGisa = rsM.getString("body");
			}
			
			sql = "select * from get_messaggio_home('bdu')";
			pst = db.prepareStatement(sql);
			rsM = pst.executeQuery();
			
			while(rsM.next()){
				mBdu = rsM.getString("body");
			}
			
			sql = "select * from get_messaggio_home('vam')";
			pst = db.prepareStatement(sql);
			rsM = pst.executeQuery();
			
			while(rsM.next()){
				mVam = rsM.getString("body");
			}
			
			
			HashMap<String,String> hostMessages = new HashMap<String,String>();
			hostMessages.put("GISA", mGisa);
			hostMessages.put("BDU", mBdu);
			hostMessages.put("VAM", mVam);
			
			req.setAttribute("hostMessages", hostMessages);
			
			}
			catch(Exception e)
			{
				
			}
			
			try {
				req.setAttribute("canilebdu", canilebdu);
				}
				catch(Exception e)
				{
					
				}
			
			//Verifica obsolescenza accessi
			NodeList endpointList = (NodeList)xpath.evaluate("//endpoint", doc, XPathConstants.NODESET);
			Element endpointElem = null;
			Element operationCheckEsistenzaUtente = null;
			GUCEndpoint nomeEndpoint = null;
			Connection conn = null;
			String dbHost = null;
			String dbName = null;
			String dbUser = null;
			String dbPwd  = null;
			ArrayList<Integer> esiti = new ArrayList<Integer>();
			String esito="";
			try{
				int i=0;
				while(i<endpoints.size()){
					operationCheckEsistenzaUtente = (Element)xpath.evaluate("//endpoint[@name='" + endpoints.get(i) + "']/operation[@name='CheckEnableUtente']",doc, XPathConstants.NODE);						
					GUCOperationType operationType = GUCOperationType.valueOf(operationCheckEsistenzaUtente.getAttribute("type"));
					dbHost = operationCheckEsistenzaUtente.getElementsByTagName("db_host").item(0) != null ? 
									 operationCheckEsistenzaUtente.getElementsByTagName("db_host").item(0).getTextContent() : null;
							dbName = operationCheckEsistenzaUtente.getElementsByTagName("db_name").item(0) != null ? 
									 operationCheckEsistenzaUtente.getElementsByTagName("db_name").item(0).getTextContent() : null;
							dbUser = operationCheckEsistenzaUtente.getElementsByTagName("db_user").item(0) != null ? 
									 operationCheckEsistenzaUtente.getElementsByTagName("db_user").item(0).getTextContent() : null;
							dbPwd  = operationCheckEsistenzaUtente.getElementsByTagName("db_pwd").item(0) != null ? 
									 operationCheckEsistenzaUtente.getElementsByTagName("db_pwd").item(0).getTextContent() : null;
							
										String	 dbDatasource  = operationCheckEsistenzaUtente.getElementsByTagName("db_datasource").item(0) != null ? 
												 operationCheckEsistenzaUtente.getElementsByTagName("db_datasource").item(0).getTextContent() : null;
								if(dbHost != null && dbName != null && dbUser != null && dbPwd != null ){
									//conn = DbUtil.ottieniConnessioneJDBC(dbUser, dbPwd, dbHost, dbName);
									conn = DbUtil.ottieniConnessioneJDBC(dbDatasource);
									}

						
					String timeout = ApplicationProperties.getProperty("timeout");
					//esito =	this.gestioneLastLoginUtente(operationCheckEsistenzaUtente, operationType, utenteGuc.getUsername(), conn, timeout);
					esito =	this.gestioneLastLoginUtente(operationCheckEsistenzaUtente, operationType, username.get(i), conn, timeout);
					if(esito.equals("KO")){
						esiti.add(i);
						
					}else{
						esiti.add(-1);
					}
						
					++i;
					DbUtil.chiudiConnessioneJDBC(null, conn);
					
				}
				
				if(endpoints.size() <=0){
					if(!Boolean.parseBoolean(ApplicationProperties.getProperty("login_spid")))
						setErrore("ATTENZIONE! L'utente "+utenteGuc.getUsername()+" non ha alcuna applicazione associata per effettuare l'accesso. Si prega di contattare il servizio di HD I livello.");
					else
						setErrore("ATTENZIONE! L'utente con codice fiscale "+utenteGuc.getCodiceFiscale()+" non ha alcuna applicazione associata per effettuare l'accesso. Si prega di contattare il servizio di HD I livello.");
						
				}
				
				req.setAttribute("errore2","ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO IL TUO ACCOUNT RISULTA DISATTIVATO PER "
						+ " APPLICAZIONE RUOLO E ASL SELEZIONATI. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.");
				
				req.setAttribute("esiti", esiti);
				
						
			}catch(Exception e){
				e.printStackTrace();
			}
			finally {
				DbUtil.chiudiConnessioneJDBC(rs,null, conn);
			}
			rs.close();
			
			try {
				LoginUtil.gestioneLogLogin(db, utenteGuc.getUsername(), utenteGuc.getCodiceFiscale(), Boolean.parseBoolean(ApplicationProperties.getProperty("login_spid")), "sca");
			}catch(Exception e){
				e.printStackTrace();
			}
			finally {
				DbUtil.chiudiConnessioneJDBC(null, db);
			}
					
			if(Boolean.parseBoolean(ApplicationProperties.getProperty("login_spid")))
				 gotoPage("/jsp/sca/sceltaSpidVersion.jsp" ); 
			else
				 gotoPage("/jsp/sca/scelta.jsp" ); 
		}
			
	}


public String gestioneLastLoginUtente ( Element operationCheckEsistenzaUtente , GUCOperationType operationType, String username, Connection conn, String timeout){
		
		String ris = "";
		int time = Integer.parseInt(timeout);
		  switch (operationType) {
			case Sql:
				
				try{

					PreparedStatement pst = null;
					ResultSet rs = null;
					String query = operationCheckEsistenzaUtente.getElementsByTagName("query").item(0).getTextContent();
					
					pst = conn.prepareStatement(query);
					int i = 0;
					
					pst.setString(++i,username);
					//Timeout
					Calendar cal = Calendar.getInstance();
					cal.add(Calendar.MONTH, -time);
					pst.setTimestamp(2, new Timestamp(cal.getTimeInMillis()));		
					//System.out.println("timestamp: "+ new Timestamp(cal.getTimeInMillis()) );
					rs = pst.executeQuery();
					
					while (rs.next()){
						ris = rs.getString(1);
					}
					
					//pst.close();
					//rs.close();
				} catch (Exception e){
					e.printStackTrace();
				}
				break;
			case Json:
				ris = "OK";
				break;
				
			default:
				try {
					throw new Exception("[gestioneEsistenzaUtente] - Il tipo di operazione " + operationType + " non e gestito.");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		  return ris;
		  
	  }
	
	
}
	
