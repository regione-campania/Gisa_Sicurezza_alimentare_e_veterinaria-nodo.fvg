package org.aspcfs.modules.registrotrasgressori.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Logger;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
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
public class ControllaCoerenzaAvvisiPagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllaCoerenzaAvvisiPagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ControllaCoerenzaAvvisiPagoPA] Inizio procedura.");
		
		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
		

		JSONObject jsonFinale = new JSONObject();
		
		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaCoerenzaAvvisiPagoPA] Inizio.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}
		
		
		JSONArray jsonImportiNonCoerenti = new JSONArray();

		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_importi_non_coerenti();");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				JSONObject jsonImporto = new JSONObject();
				jsonImporto.put("Importo calcolato", rs.getFloat("importo_calcolato"));
				jsonImporto.put("Id sanzione", rs.getInt("id_sanzione"));
				jsonImporto.put("Importo attuale", rs.getFloat("importo_totale_versamento"));
				jsonImportiNonCoerenti.put(jsonImporto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}
		if (jsonImportiNonCoerenti.length() > 0)
			jsonFinale.put("Importi non coerenti", jsonImportiNonCoerenti);

		JSONArray jsonAvvisiNonAnnullati = new JSONArray();

		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_avvisi_non_annullati();");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				JSONObject jsonAvviso = new JSONObject();
				jsonAvviso.put("Id sanzione", rs.getInt("id_sanzione"));
				jsonAvviso.put("IUV", rs.getString("identificativo_univoco_versamento"));
				jsonAvviso.put("Stato pagamento", rs.getString("stato_pagamento"));
				jsonAvviso.put("Registro Trasgressori", rs.getInt("progressivo_registro") + "\\"+ rs.getInt("anno_registro"));

				jsonAvvisiNonAnnullati.put(jsonAvviso);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}
		
		if (jsonAvvisiNonAnnullati.length() > 0)
			jsonFinale.put("Avvisi non annullati", jsonAvvisiNonAnnullati);
		
		
		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaCoerenzaAvvisiPagoPA] Fine.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}
		
		if (jsonFinale.length() > 0)
			invioMail(jsonFinale);

		response.setContentType("Application/JSON");
		response.getWriter().write(jsonFinale.toString());

		System.out.println("[ControllaCoerenzaAvvisiPagoPA] Fine procedura.");

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
	
	
	private void invioMail(JSONObject jsonFinale){
		String toDest=ApplicationProperties.getProperty("DEST_EMAIL_PAGOPA_COERENZA");
		String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_PAGOPA_COERENZA");

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date d1 = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(d1);
		Timestamp d2 = new Timestamp(cal.getTime().getTime());
		String d3 = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(d2).toString();
		
		String testo = "E' stato riscontrato un errore di coerenza dati PagoPA.<br/><br/>";
		
		testo = testo + "Data operazione: "+ d3 +"<br/><br/>";
			
		testo = testo + jsonFinale.toString(4);
		
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