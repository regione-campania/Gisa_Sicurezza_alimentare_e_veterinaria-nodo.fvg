package org.aspcfs.modules.gestioneDocumenti.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;
import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ServletGeneraDocumentoRicevutaPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGeneraDocumentoRicevutaPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		int idSanzione = -1;
		int idPagamento = -1;
		String tipo = "";
		
		try { idSanzione = Integer.parseInt(request.getParameter("idSanzione"));} catch (Exception e) {}
		
		if (idSanzione == -1)
			try { idSanzione = (int)(request.getAttribute("idSanzione"));} catch (Exception e) {}

		try { idPagamento = Integer.parseInt(request.getParameter("idPagamento"));} catch (Exception e) {}
		
		if (idPagamento == -1)
			try { idPagamento = (int)(request.getAttribute("idPagamento"));} catch (Exception e) {}
		
		try { tipo = request.getParameter("tipo");} catch (Exception e) {}
		if (tipo == null)
			try { tipo = (String)(request.getAttribute("tipo"));} catch (Exception e) {}

		Pagamento p = new Pagamento();
		JSONObject jsonFinale = new JSONObject();

		try {
			ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
			String ceHost = prefs.get("GATEKEEPER.URL");
			String ceUser = prefs.get("GATEKEEPER.USER");
			String ceUserPw = prefs.get("GATEKEEPER.PASSWORD"); 

			ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
			cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
			db = cp.getConnection(ce, null);

			p = new Pagamento(db, idPagamento); 
			
			//URL oracle = null;
			
			String actionName = "GestionePagoPa.do"; //nome action da chiamare
			String urlOriginale = "";
			
			String idSessione = ""; /*context.getRequest().getSession().getId();*/
			
			if (request.getSession().getAttribute("User") != null){ 
				idSessione = request.getSession().getId();
			} else {
				//idSessione = loginDiServizio(request, response, db);
				}
			
			if (idSessione!=null && !idSessione.equals("")){ //ALTRIMENTI NON FUNZIONA. SENZA SESSIONE NON SI GENERA IL PDF
					
			String urlChiamante = "http://"+request.getLocalAddr()+":"+request.getLocalPort() + request.getContextPath() + "/";
			
			System.out.println("[DOCUMENTALE GISA] urlChiamante: "+urlChiamante);
					
			HttpURLConnection conn=null;
			
				URL oracle = null;
				
				String url          	= urlChiamante;
				String metodo="";
				metodo = "StampaRicevuta";
				
				url+=actionName+
							"?command="+ metodo + "&idPagamento=" + idPagamento; //PAGINA DA LEGGERE E CODIFICARE
				
				//PAGINA DA LEGGERE E CODIFICARE

				//test = getHtml(url, idSessione);
				urlOriginale = url;
					
				
			//UserBean user = (UserBean) context.getSession().getAttribute("User");
			//String ip = context.getIpAddress();

			String urlDocumentale = ApplicationProperties.getProperty("APP_DOCUMENTALE_URL")+ApplicationProperties.getProperty("APP_DOCUMENTALE_CODIFICA");
			//STAMPE
			System.out.println("\nUrl generato(chiamata a servlet): "+url.toString());
			URL obj;
			try {
				obj = new URL(urlDocumentale);
				conn = (HttpURLConnection) obj.openConnection();
				conn.setDoOutput(true);
				conn.setRequestMethod("GET");

				// conn.connect();
				StringBuffer requestParams = new StringBuffer();
				requestParams.append("tipoCertificato");
				requestParams.append("=").append(tipo);
				requestParams.append("&");
				requestParams.append("extra");
				requestParams.append("=").append(idPagamento);
				requestParams.append("&");
				requestParams.append("ticketId");
				requestParams.append("=").append(idSanzione);
				requestParams.append("&");
				requestParams.append("app_name");
				requestParams.append("=").append(ApplicationProperties.getProperty("APP_NAME_GISA"));
				requestParams.append("&");
				requestParams.append("sostituisciCaller");
				requestParams.append("=").append(ApplicationProperties.getProperty("APP_DOCUMENTALE_SOSTITUISCI_CALLER"));
				requestParams.append("&");
				requestParams.append("tipoTimbro");
				requestParams.append("=").append("GISA");
				requestParams.append("&");
				requestParams.append("urlOriginale");
				requestParams.append("=").append(URLEncoder.encode(urlOriginale, "ISO-8859-1"));
				requestParams.append("&");
				requestParams.append("caller");
				requestParams.append("=").append(URLEncoder.encode(urlChiamante, "ISO-8859-1"));
				requestParams.append("&");
				requestParams.append("idSessione");
				requestParams.append("=").append(request.getSession().getId());
				requestParams.append("&");
				requestParams.append("idUtente");
				requestParams.append("=").append("-1");
				 
				OutputStreamWriter wr = new OutputStreamWriter(conn
							.getOutputStream());
				wr.write(requestParams.toString());
				wr.flush();
				System.out.println("[DOCUMENTALE GISA] CONNESSIONE: "+conn.toString()+"?"+requestParams.toString());
				conn.getContentLength();
			
				String codDocumento=""/*, titolo=""*/;
				BufferedReader in = new BufferedReader( new InputStreamReader(conn.getInputStream()));
				StringBuffer result = new StringBuffer();

				//Leggo l'output: l'header del documento generato e il nome assegnatogli
				if (in != null) {
					String ricevuto = in.readLine();
					result.append(ricevuto); }
					in.close();
				JSONObject jo = new JSONObject(result.toString());
				codDocumento = jo.get("codDocumento").toString(); 
				//titolo = jo.get("titolo").toString();
				
				
				if (codDocumento!=null && !codDocumento.equals("")){
					
					String download_url = ApplicationProperties.getProperty("APP_DOCUMENTALE_URL")+ApplicationProperties.getProperty("APP_DOCUMENTALE_DOWNLOAD_SERVICE");
					download_url+="?codDocumento="+codDocumento;
					String codDocumentoRicevuta = PagoPaUtil.inviaADocumentaleConRitorno("", download_url, "RicevutaPagoPa", ("RICEVUTA PAGO PA "+idSanzione), idSanzione, idPagamento, ("IUD: "+p.getIdentificativoUnivocoDovuto()+" IUV: "+p.getIdentificativoUnivocoVersamento()+ " PAGATORE: "+p.getPagatore().getId() + "/"+p.getPagatore().getPartitaIvaCodiceFiscale()+ " URL: "+p.getUrlFileAvviso()), -1);
					
					PagoPaUtil.aggiornaHeaderRicevuta(db, idPagamento, codDocumentoRicevuta);
					
				}
				
				} catch (MalformedURLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
						
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					finally{
						conn.disconnect();
					}
			}
		} catch (Exception e) {
			logger.severe("[ServletGeneraDocumentoRicevutaPagoPA] Si e' verificata un'eccezione nella generazione del PDF Ricevuta.");
			e.printStackTrace();

			jsonFinale.put("Esito operazione", "KO");       
			jsonFinale.put("Errore", e.getMessage());

		} finally {
			if (cp != null) {
				if (db != null) {
					cp.free(db, null);
				}
			}

			response.setContentType("Application/JSON");
			response.getWriter().write(jsonFinale.toString());

		}
	}

//	private String loginDiServizio(HttpServletRequest request, HttpServletResponse response, Connection db) throws SQLException, IOException, IndirizzoNotFoundException {
//		
//		// LogBean lb = new LogBean();
//
//		ActionContext context = new ActionContext(this, null, null, request, response);
//		org.aspcfs.modules.login.actions.Login log = new org.aspcfs.modules.login.actions.Login();
//		String idSessione = log.executeCommandLoginDiServizio(context, USERNAME, PASSWORD);
//		return idSessione;
//		
//	}
}