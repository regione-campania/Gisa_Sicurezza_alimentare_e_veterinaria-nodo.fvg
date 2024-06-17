package org.aspcfs.modules.richiesteerratacorrige.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.logging.Logger;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.suap.base.PecMailSender;
import org.aspcfs.modules.util.imports.ApplicationProperties;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ServletGestioneRichiesteErrataCorrige extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ServletGestioneRichiesteErrataCorrige() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ServletGestioneRichiesteErrataCorrige] Inizio procedura.");
		
		boolean invioMail = false;  
		
		try {invioMail = Boolean.parseBoolean(request.getParameter("invioMail"));} catch (Exception e) {}
		
		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");
		
		LocalDate dateObj = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String data1 = dateObj.format(formatter);
		String data2 = dateObj.minusDays(1).format(formatter);
		
		String rowsGISA = "";
		String rowsBDU = "";
		String row = "";
		
		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from public.get_errata_corrige_generate_riepilogo(?::timestamp, ?::timestamp)");
			pst.setString(1, data2);
			pst.setString(2, data1);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				
					row = "<tr>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("asl")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("id_1")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("id_2")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("motivo")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("data")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("utente")+"</td>"+
						"<td align=\"center\" style=\"border:1px solid black;\">"+rs.getString("header_documento")+"</td>"+
						"</tr>";
					
					if (rs.getString("applicativo").equalsIgnoreCase("GISA"))
						rowsGISA += row;
					else if (rs.getString("applicativo").equalsIgnoreCase("BDU"))
						rowsBDU += row;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		String testo = "Di seguito il riepilogo delle richieste di Errata Corrige generate il giorno <b>"+data2+"</b><br/><br/>"
				+ "<table style=\"border: 1px solid black; border-collapse: collapse\" width=\"100%\">"
				+ "<tr><th align=\"center\" style=\"border:1px solid black;\" colspan=\"7\">GISA</th></tr>"
				+ "<tr>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">ASL</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">RAGIONE SOCIALE</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">NUMERO REGISTRAZIONE</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">MOTIVO</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">DATA</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">UTENTE</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">CODICE DOCUMENTO</th>"
				+ "</tr>"
				+ rowsGISA
				+ "</table>"
				+"<br/><br/>"
				+ "<table style=\"border: 1px solid black; border-collapse: collapse\" width=\"100%\">"
				+ "<tr><th align=\"center\" style=\"border:1px solid black;\" colspan=\"7\">BDU</th></tr>"
				+ "<tr>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">ASL</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">MICROCHIP 1</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">MICROCHIP 2</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">MOTIVO</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">DATA</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">UTENTE</th>"
				+ "<th align=\"center\" style=\"border:1px solid black;\">CODICE DOCUMENTO</th>"
				+ "</tr>"
				+ rowsBDU
				+ "</table>";
				
		String toDest=ApplicationProperties.getProperty("DEST_EMAIL_ERRATA_CORRIGE");
		String oggetto =ApplicationProperties.getProperty("OGGETTO_EMAIL_ERRATA_CORRIGE") + " RIEPILOGO ("+data2+")";
		
		if (invioMail)
			sendMail(testo, oggetto, toDest);
		
		response.setContentType("text/html");
		response.getWriter().write(testo);
		
		System.out.println("[ServletGestioneRichiesteErrataCorrige] Fine procedura.");

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
	
	public  void sendMail(String testo,String object,String toDest)
	{

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
			sender.sendMailConAllegato(object,testo,ApplicationProperties.getProperty("mail.smtp.from"), toDestArray, null);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}