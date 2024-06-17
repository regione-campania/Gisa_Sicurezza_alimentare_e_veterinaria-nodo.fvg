package org.aspcfs.modules.registrotrasgressori.servlets;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.logging.Logger;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore;
import org.aspcfs.modules.registrotrasgressori.base.ImportoOrdinanza;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.suap.base.PecMailSender;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.json.JSONArray;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ControllaScadenzeOrdinanzaPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllaScadenzeOrdinanzaPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ControllaScadenzeOrdinanzaPagoPA] Inizio procedura.");

		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;
		JSONObject jsonFinale = new JSONObject();
		JSONArray jsonSanzioni = new JSONArray();


		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");

		ArrayList<Integer> listaSanzioniScadute = new ArrayList<Integer>();
		
		try {
			db = apriConnessione(request, cp, db, ce);

			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaScadenzeOrdinanzaPagoPA] Inizio.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		// GESTIONE RIGENERAZIONE AVVISI SCADUTI
		ArrayList<Pagamento> listaPagamenti = null;
		
		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_due_avvisi_scaduti_ordinanza();");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				listaSanzioniScadute.add(rs.getInt("id_sanzione_scaduta"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		for (int i = 0; i<listaSanzioniScadute.size(); i++) {
			String messaggio = "";

			int idSanzione = (Integer) listaSanzioniScadute.get(i);
			int maxIndice = -1;
			String importoResiduo = "";
			
			AnagraficaPagatore trasgressore = null;
			AnagraficaPagatore obbligato = null;
			try {
				db = apriConnessione(request, cp, db, ce);
			
				PagoPaUtil.gestioneSemaforo(db, idSanzione, -1, true);

				trasgressore = new AnagraficaPagatore(db, idSanzione, "T");
				obbligato = new AnagraficaPagatore(db, idSanzione, "O");
				
				// Recupero importo residuo
				
				double[] importiTotaliOrdinanza = Pagamento.getImportiTotaliOrdinanza(db, idSanzione); 
				importoResiduo = String.format(Locale.US, "%.2f", importiTotaliOrdinanza[2]);
				
				// Annullo tutti gli avvisi non pagati
				
				listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, -1);

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
			
			for (int k = 0; k<listaPagamenti.size(); k++){
			
				try {
					db = apriConnessione(request, cp, db, ce);
				
					Pagamento p = (Pagamento) listaPagamenti.get(k);
					if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento())){
						PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di annullamento IUV.");
						PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di annullamento IUV");
						p.annullaDovuto(db, -1);
						if (p.getEsitoInvio().equalsIgnoreCase("OK")  || (p.getIdentificativoUnivocoVersamento()==null || p.getIdentificativoUnivocoVersamento().equals("")) /*|| (p.getEsitoInvio().equalsIgnoreCase("KO") && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))*/){ 
							p.delete(db, -1);
						}
						else
							messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					}
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					chiudiConnessione(cp, db);
				}
			}
			
				
				// Rigenero rata unica su importo residuo
				
			try {
				db = apriConnessione(request, cp, db, ce);
				maxIndice = PagoPaUtil.aggiornaIndici(db, idSanzione);
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date dataAttuale = new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(dataAttuale);
				cal.add(Calendar.DAY_OF_MONTH, 60);
				Timestamp dataScadenzaTimestamp = new Timestamp(cal.getTime().getTime());
				String dataScadenza = new SimpleDateFormat("yyyy-MM-dd").format(dataScadenzaTimestamp).toString();
				
				Pagamento p = new Pagamento();
				p.setIndice(maxIndice);
				p.setImportoSingoloVersamento(importoResiduo);
				p.setDataScadenza(dataScadenza);
				p.setPagatore(trasgressore);
				p.setIdSanzione(idSanzione);
				p.setTipoPagamento("NO");
				p.setNumeroRate(1);
				p.setRigenerato(true);
				
				PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di rigenerazione IUV.");
				PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di rigenerazione IUV.");
				
				p.insert(db, -1);
				p.importaDovuto(db, -1);

				if (p.getEsitoInvio().equalsIgnoreCase("OK"))
					messaggio=messaggio+"Rigenerato Avviso di Pagamento (TRASGRESSORE).<br/>IUV: "+p.getIdentificativoUnivocoVersamento() + "<br/>Importo: "+importoResiduo+"<br/>Data scadenza: "+dataScadenza+"<br/><br/>";
				else {
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(TRASGRESSORE/Rata "+(p.getIndice())+")\\nNon generato! <font color='red'>Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
				}
				
				if (obbligato!=null && obbligato.getId()>0){
					Pagamento p2 = new Pagamento();
					p2.setIndice(maxIndice);
					p2.setImportoSingoloVersamento(importoResiduo);
					p2.setDataScadenza(dataScadenza);
					p2.setPagatore(obbligato);
					p2.setIdSanzione(idSanzione);
					p2.setTipoPagamento("NO");
					p2.setNumeroRate(1);
					p2.setRigenerato(true);
					
					PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di rigenerazione IUV.");
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di rigenerazione IUV.");
					
					p2.insert(db, -1);
					p2.importaDovuto(db, -1);

					if (p2.getEsitoInvio().equalsIgnoreCase("OK"))
						messaggio=messaggio+"Rigenerato Avviso di Pagamento (OBBLIGATO IN SOLIDO).<br/>IUV: "+p2.getIdentificativoUnivocoVersamento() + "<br/>Importo: "+importoResiduo+"<br/>Data scadenza: "+dataScadenza+"<br/><br/>";
					else {
						messaggio+="[<b>IUD</b>: " + (p2.getIdentificativoUnivocoDovuto()!=null ? p2.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p2.getIdentificativoUnivocoVersamento()!=null ? p2.getIdentificativoUnivocoVersamento() : "")+"]\\n(OBBLIGATO/Rata "+(p2.getIndice())+")\\nNon generato! <font color='red'>Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p2.getDescrizioneErrore())+"</font>\\n\\n";
						messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
					}	
				}
				
				ImportoOrdinanza.updatePossibilitaRigenera(db, idSanzione, false, -1);
				PagoPaUtil.gestioneSemaforo(db, idSanzione, -1, false);
				
				JSONObject jsonSanzione = new JSONObject();
				jsonSanzione.put("Id", p.getIdSanzione());
				jsonSanzione.put("Messaggio", messaggio);
				jsonSanzioni.put(jsonSanzione);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
		}
		jsonFinale.put("Numero sanzioni coinvolte", jsonSanzioni.length());       

		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaScadenzeOrdinanzaPagoPA] Fine.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		
		if (jsonSanzioni.length()>0){
			try {
				db = apriConnessione(request, cp, db, ce);
				invioMail(db, jsonSanzioni);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
		}

		jsonFinale.put("Lista sanzioni", jsonSanzioni);
		response.setContentType("Application/JSON");
		response.getWriter().write(jsonSanzioni.toString());
		
		System.out.println("[ControllaScadenzeOrdinanzaPagoPA] Fine procedura.");

	}

	private Connection apriConnessione(HttpServletRequest request, ConnectionPool cp, Connection db, ConnectionElement ce) throws SQLException{
		db = cp.getConnection(ce, null);
		return db;
	}
	private void chiudiConnessione(ConnectionPool cp, Connection db){
		if (cp != null) {
			if (db != null) {
				cp.free(db, null);
			}
		}
	}
	
	private void invioMail(Connection db, JSONArray jsonSanzioni){
		String toDest=ApplicationProperties.getProperty("DEST_EMAIL_PAGOPA");
		String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_PAGOPA");

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(d1);
		Timestamp d2 = new Timestamp(cal.getTime().getTime());
		String d3 = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(d2).toString();
		
		String testo = "E' stato eseguito un automatismo notturno per annullamento e rigenerazione di avvisi di pagamento per Numero Ordinanza.<br/><br/>";
		
		testo = testo + "Data operazione: "+ d3 +"<br/><br/>";
		
		for (int i = 0; i<jsonSanzioni.length(); i++){
			
			JSONObject json = (JSONObject) jsonSanzioni.get(i);
			int idSanzione = -1;
			String messaggio = "";
			String progressivoRegistro = "";
			
			try {
			
				idSanzione = (int) json.get("Id");
				messaggio = (String) json.get("Messaggio");
				JSONObject infoSanzione = PagoPaUtil.getInfoSanzione(db, idSanzione);
				progressivoRegistro = (String) infoSanzione.get("REGISTRO TRASGRESSORI");
			} catch (Exception e) {}
			
			testo = testo + "Id Sanzione: "+idSanzione + "<br/>Progressivo Registro Trasgressori: " + progressivoRegistro + "<br/>Esito: " + messaggio + "<br/><br/>";
		}
		
		String[] toDestArray = toDest.split(";");
		HashMap<String,String> configs = new HashMap<String,String>();
		configs.put("mail.smtp.starttls.enable",ApplicationProperties.getProperty("mail.smtp.starttls.enable"));
		configs.put("mail.smtp.auth", ApplicationProperties.getProperty("mail.smtp.auth"));
		configs.put("mail.smtp.host", ApplicationProperties.getProperty("mail.smtp.host"));
		configs.put("mail.smtp.port", ApplicationProperties.getProperty("mail.smtp.port"));
		configs.put("mail.smtp.ssl.enable",ApplicationProperties.getProperty("mail.smtp.ssl.enable"));
		configs.put("mail.smtp.ssl.protocols", ApplicationProperties.getProperty("mail.smtp.ssl.protocols"));
		configs.put("mail.smtp.socketFactory.class", ApplicationProperties.getProperty("mail.smtp.socketFactory.class"));
		configs.put("mail.smtp.socketFactory.fallback", ApplicationProperties.getProperty("mail.smtp.socketFactory.fallback"));
		
		PecMailSender sender = new PecMailSender(configs,ApplicationProperties.getProperty("username"), ApplicationProperties.getProperty("password"));
		try {
			sender.sendMailConAllegato(oggetto,testo,ApplicationProperties.getProperty("mail.smtp.from"), toDestArray, null);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	

}