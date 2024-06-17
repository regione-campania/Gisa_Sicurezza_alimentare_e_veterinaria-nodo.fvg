package org.aspcfs.modules.registrotrasgressori.servlets;

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
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore;
import org.aspcfs.modules.registrotrasgressori.base.NotificaPagatore;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;

/**
 * Servlet implementation class ReloadUtenti
 */
public class ControllaScadenzePagoPA extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("MainLogger");
	
	private class Avviso
	{
	    private int idPagamento; 
	    private int idSanzione; 
	    private String    dataScadenza;
	    private String importoSingoloVersamento;
	    private String identificativoUnivocoVersamento;
	    private String statoPagamento;
	    private String tipoRiduzione;
	    private String trasgressoreObbligato;
	    private int idTrasgressore;
	    private String tipoNotificaTrasgressore;
	    private String dataNotificaTrasgressore;
	    private boolean notificaAggiornataTrasgressore;
	    private int idObbligato;
	    private String tipoNotificaObbligato;
	    private String dataNotificaObbligato;
	    private boolean notificaAggiornataObbligato;
	    private String operazione;
	    
	 };

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControllaScadenzePagoPA() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("[ControllaScadenzePagoPA] Inizio procedura.");

		ConnectionElement ce = null;
		ConnectionPool cp = null;
		Connection db = null;
		JSONObject jsonFinale = new JSONObject();
		JSONArray jsonAvvisi = new JSONArray();

		ApplicationPrefs prefs = (ApplicationPrefs) request.getSession().getServletContext().getAttribute("applicationPrefs");
		String ceHost = prefs.get("GATEKEEPER.URL");
		String ceUser = prefs.get("GATEKEEPER.USER");
		String ceUserPw = prefs.get("GATEKEEPER.PASSWORD");

		ce = new ConnectionElement(ceHost, ceUser, ceUserPw);
		cp = (ConnectionPool) request.getServletContext().getAttribute("ConnectionPool");

		ArrayList<Avviso> listaAvvisiInScadenza = new ArrayList<Avviso>();
		ArrayList<Pagamento> listaAvvisiScaduti = new ArrayList<Pagamento>();

		try {
			db = apriConnessione(request, cp, db, ce);

			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaScadenzePagoPA] Inizio.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		// GESTIONE PROROGA AVVISI IN SCADENZA

		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_avvisi_in_scadenza_processo_verbale();");
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Avviso avviso = new Avviso();
				avviso.idPagamento = rs.getInt("id_pagamento");
				avviso.idSanzione = rs.getInt("id_sanzione");
				avviso.dataScadenza = rs.getString("data_scadenza");
				avviso.importoSingoloVersamento = rs.getString("importo_singolo_versamento");
				avviso.statoPagamento = rs.getString("stato_pagamento");
				avviso.tipoRiduzione = rs.getString("tipo_riduzione");
				avviso.trasgressoreObbligato = rs.getString("trasgressore_obbligato");
				avviso.idTrasgressore = rs.getInt("id_trasgressore");
				avviso.tipoNotificaTrasgressore = rs.getString("tipo_notifica_trasgressore");
				avviso.dataNotificaTrasgressore = rs.getString("data_notifica_trasgressore");
				avviso.notificaAggiornataTrasgressore = rs.getBoolean("notifica_aggiornata_trasgressore");
				avviso.idObbligato = rs.getInt("id_obbligato");
				avviso.tipoNotificaObbligato = rs.getString("tipo_notifica_obbligato");
				avviso.dataNotificaObbligato = rs.getString("data_notifica_obbligato");
				avviso.notificaAggiornataObbligato = rs.getBoolean("notifica_aggiornata_obbligato");				
				avviso.operazione = rs.getString("operazione");
				listaAvvisiInScadenza.add(avviso);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		for (int i = 0; i<listaAvvisiInScadenza.size(); i++) {
			try {
				db = apriConnessione(request, cp, db, ce);
				Avviso a = (Avviso) listaAvvisiInScadenza.get(i);
				Pagamento p = new Pagamento(db, a.idPagamento);
				
				if ("PROROGA DA DATA NOTIFICA OBBLIGATO".equals(a.operazione)){
					
					String nuovaDataNotifica = null;
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date parsedDate = dateFormat.parse(a.dataNotificaObbligato);
					Timestamp dataPartenzaTimestamp = new java.sql.Timestamp(parsedDate.getTime());
					Calendar cal = Calendar.getInstance();
					cal.setTime(dataPartenzaTimestamp);
					cal.add(Calendar.DAY_OF_MONTH, 100);
					Timestamp dataTimestampNew = new Timestamp(cal.getTime().getTime());
					nuovaDataNotifica = new SimpleDateFormat("yyyy-MM-dd").format(dataTimestampNew).toString();
					
					NotificaPagatore.update(db, a.idTrasgressore, a.idSanzione, a.tipoNotificaTrasgressore, nuovaDataNotifica, -1);

					String messaggio = "";
					String vecchiaDataScadenza = a.dataScadenza;
					String nuovaDataScadenza = PagoPaUtil.calcolaDataScadenza(nuovaDataNotifica, a.tipoNotificaTrasgressore, "PV", a.tipoRiduzione, -1);
					
					p.setDataScadenza(nuovaDataScadenza);
					PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					p.update(db, -1);
					p.aggiornaDovuto(db, -1);
					if (p.getEsitoInvio().equalsIgnoreCase("OK")) {
						messaggio += "[ControllaScadenzePagoPA] [OBBLIGATO notificato tramite Contestazione Immediata/PEC, TRASGRESSORE non notificato] Data scadenza TRASGRESSORE aggiornata.";
					} else {
						messaggio += "[ControllaScadenzePagoPA] [OBBLIGATO notificato tramite Contestazione Immediata/PEC, TRASGRESSORE non notificato] Data scadenza TRASGRESSORE non aggiornata. Motivazione: " + PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore()) + ".";
						p.setDataScadenza(vecchiaDataScadenza);
						p.update(db, -1);
					}
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), vecchiaDataScadenza, p.getDataScadenza(), messaggio);

					JSONObject jsonAvviso = new JSONObject();
					jsonAvviso.put("Id sanzione", p.getIdSanzione());
					jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
					jsonAvviso.put("Vecchia data scadenza", vecchiaDataScadenza);
					jsonAvviso.put("Nuova data scadenza", p.getDataScadenza());
					jsonAvviso.put("Operazione", a.operazione);
					jsonAvviso.put("Esito operazione", p.getEsitoInvio());
					jsonAvviso.put("Messaggio", messaggio);
					jsonAvvisi.put(jsonAvviso);					
					
				}
				else if ("PROROGA DA DATA NOTIFICA TRASGRESSORE".equals(a.operazione)){

					String nuovaDataNotifica = null;
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date parsedDate = dateFormat.parse(a.dataNotificaTrasgressore);
					Timestamp dataPartenzaTimestamp = new java.sql.Timestamp(parsedDate.getTime());
					Calendar cal = Calendar.getInstance();
					cal.setTime(dataPartenzaTimestamp);
					cal.add(Calendar.DAY_OF_MONTH, 100);
					Timestamp dataTimestampNew = new Timestamp(cal.getTime().getTime());
					nuovaDataNotifica = new SimpleDateFormat("yyyy-MM-dd").format(dataTimestampNew).toString();
					
					NotificaPagatore.update(db, a.idObbligato, a.idSanzione, a.tipoNotificaObbligato, nuovaDataNotifica, -1);

					String messaggio = "";
					String vecchiaDataScadenza = a.dataScadenza;
					String nuovaDataScadenza = PagoPaUtil.calcolaDataScadenza(nuovaDataNotifica, a.tipoNotificaObbligato, "PV", a.tipoRiduzione, -1);
					
					p.setDataScadenza(nuovaDataScadenza);
					PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					p.update(db, -1);
					p.aggiornaDovuto(db, -1);
					if (p.getEsitoInvio().equalsIgnoreCase("OK")) {
						messaggio += "[ControllaScadenzePagoPA] [TRASGRESSORE notificato tramite Contestazione Immediata/PEC, OBBLIGATO non notificato] Data scadenza OBBLIGATO aggiornata.";
					} else {
						messaggio += "[ControllaScadenzePagoPA] [TRASGRESSORE notificato tramite Contestazione Immediata/PEC, OBBLIGATO non notificato] Data scadenza OBBLIGATO non aggiornata. Motivazione: " + PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore()) + ".";
						p.setDataScadenza(vecchiaDataScadenza);
						p.update(db, -1);
					}
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), vecchiaDataScadenza, p.getDataScadenza(), messaggio);

					JSONObject jsonAvviso = new JSONObject();
					jsonAvviso.put("Id sanzione", p.getIdSanzione());
					jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
					jsonAvviso.put("Vecchia data scadenza", vecchiaDataScadenza);
					jsonAvviso.put("Nuova data scadenza", p.getDataScadenza());
					jsonAvviso.put("Operazione", a.operazione);
					jsonAvviso.put("Esito operazione", p.getEsitoInvio());
					jsonAvviso.put("Messaggio", messaggio);
					jsonAvvisi.put(jsonAvviso);					
									
				}
				else if ("PROROGA DA PROPRIA DATA NOTIFICA".equals(a.operazione)){
					
					String nuovaDataNotifica = null;
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date parsedDate = dateFormat.parse("T".equals(a.trasgressoreObbligato) ? a.dataNotificaTrasgressore : "O".equals(a.trasgressoreObbligato) ? a.dataNotificaObbligato : "");
					Timestamp dataPartenzaTimestamp = new java.sql.Timestamp(parsedDate.getTime());
					Calendar cal = Calendar.getInstance();
					cal.setTime(dataPartenzaTimestamp);
					cal.add(Calendar.DAY_OF_MONTH, 100);
					Timestamp dataTimestampNew = new Timestamp(cal.getTime().getTime());
					nuovaDataNotifica = new SimpleDateFormat("yyyy-MM-dd").format(dataTimestampNew).toString();

					NotificaPagatore.update(db, ("T".equals(a.trasgressoreObbligato) ? a.idTrasgressore : "O".equals(a.trasgressoreObbligato) ? a.idObbligato : -1), a.idSanzione, ("T".equals(a.trasgressoreObbligato) ? a.tipoNotificaTrasgressore : "O".equals(a.trasgressoreObbligato) ? a.tipoNotificaObbligato : ""), nuovaDataNotifica, -1);

					String messaggio = "";
					String vecchiaDataScadenza = a.dataScadenza;
					String nuovaDataScadenza = PagoPaUtil.calcolaDataScadenza(nuovaDataNotifica, ("T".equals(a.trasgressoreObbligato) ? a.tipoNotificaTrasgressore : "O".equals(a.trasgressoreObbligato) ? a.tipoNotificaObbligato : ""), "PV", a.tipoRiduzione, -1);
					
					p.setDataScadenza(nuovaDataScadenza);
					PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di aggiornamento data scadenza.");
					p.update(db, -1);
					p.aggiornaDovuto(db, -1);
					if (p.getEsitoInvio().equalsIgnoreCase("OK")) {
						messaggio += "[ControllaScadenzePagoPA] [TRASGRESSORE non notificato, OBBLIGATO non notificato] Data scadenza "+ ("T".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "O".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "") +" aggiornata.";
					} else {
						messaggio += "[ControllaScadenzePagoPA] [TRASGRESSORE non notificato, OBBLIGATO non notificato] Data scadenza "+ ("T".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "O".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "") +" non aggiornata. Motivazione: " + PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore()) + ".";
						p.setDataScadenza(vecchiaDataScadenza);
						p.update(db, -1);
					}
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), vecchiaDataScadenza, p.getDataScadenza(), messaggio);

					JSONObject jsonAvviso = new JSONObject();
					jsonAvviso.put("Id sanzione", p.getIdSanzione());
					jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
					jsonAvviso.put("Vecchia data scadenza", vecchiaDataScadenza);
					jsonAvviso.put("Nuova data scadenza", p.getDataScadenza());
					jsonAvviso.put("Operazione", a.operazione);
					jsonAvviso.put("Esito operazione", p.getEsitoInvio());
					jsonAvviso.put("Messaggio", messaggio);
					jsonAvvisi.put(jsonAvviso);		
						
				}
				else if ("ANNULLA".equals(a.operazione)){
					
					String messaggio = "";
					PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di annullamento IUV.");
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di annullamento IUV.");
					p.annullaDovuto(db, -1);
					if (p.getEsitoInvio().equalsIgnoreCase("OK")) {
						p.delete(db, -1);
						messaggio += "[ControllaScadenzePagoPA] [ "+ ("T".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "O".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "") +" notificato tramite Raccomandata, "+ ("T".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "O".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "") +" non notificato] Avviso di pagamento annullato.";
					} else
						messaggio += "[ControllaScadenzePagoPA] [ "+ ("T".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "O".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "") +" notificato tramite Raccomandata, "+ ("T".equals(a.trasgressoreObbligato) ? "TRASGRESSORE" : "O".equals(a.trasgressoreObbligato) ? "OBBLIGATO" : "") +" non notificato] Avviso di pagamento non annullato. Motivazione: " + PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore()) + ".";
					PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", messaggio);

					JSONObject jsonAvviso = new JSONObject();
					jsonAvviso.put("Id sanzione", p.getIdSanzione());
					jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
					jsonAvviso.put("Operazione", a.operazione);
					jsonAvviso.put("Esito operazione", p.getEsitoInvio());
					jsonAvviso.put("Messaggio", messaggio);
					jsonAvvisi.put(jsonAvviso);
					
				}
		
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
		// GESTIONE AVVISI SCADUTI

		try {
			db = apriConnessione(request, cp, db, ce);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_get_avvisi_scaduti();");
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {

				Pagamento p = new Pagamento(db, rs.getInt("id_pagamento"));
				listaAvvisiScaduti.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}

		for (int i = 0; i<listaAvvisiScaduti.size(); i++) {
			try {
				db = apriConnessione(request, cp, db, ce);
				Pagamento p = (Pagamento) listaAvvisiScaduti.get(i);
				AnagraficaPagatore trasgressore = new AnagraficaPagatore(db, p.getIdSanzione(), "T");
				AnagraficaPagatore obbligato = new AnagraficaPagatore(db, p.getIdSanzione(), "O");

				String tipologiaQuestoPagatore = null;

				if (p.getPagatore().getId() == trasgressore.getId()){
					tipologiaQuestoPagatore = "TRASGRESSORE";
				}
				else if (p.getPagatore().getId() == obbligato.getId()){
					tipologiaQuestoPagatore = "OBBLIGATO";
				}

				String messaggio = "";
				PagoPaUtil.salvaStorico(db, -1, p.getIdSanzione(), p.getId(), "[ControllaScadenzePagoPA] Tentativo di scadenza IUV.");
				PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", "[ControllaScadenzePagoPA] Tentativo di scadenza IUV.");
				p.scadiDovuto(db, -1);
				messaggio += "[ControllaScadenzePagoPA] [" + tipologiaQuestoPagatore + " scaduto] Avviso di pagamento scaduto.";
				PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, p.getIdSanzione(), p.getId(), "", "", messaggio);

				JSONObject jsonAvviso = new JSONObject();
				jsonAvviso.put("Id sanzione", p.getIdSanzione());
				jsonAvviso.put("IUV", p.getIdentificativoUnivocoVersamento());
				jsonAvviso.put("Esito operazione", p.getEsitoInvio());
				jsonAvviso.put("Messaggio", messaggio);
				jsonAvvisi.put(jsonAvviso);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				chiudiConnessione(cp, db);
			}
		}


		jsonFinale.put("Numero avvisi coinvolti", jsonAvvisi.length());       

		try {
			db = apriConnessione(request, cp, db, ce);
			PagoPaUtil.salvaStoricoOperazioniAutomatiche(db, -1, -1, "", "", "[ControllaScadenzePagoPA] Fine.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			chiudiConnessione(cp, db);
		}


		jsonFinale.put("Lista avvisi", jsonAvvisi);
		response.setContentType("Application/JSON");
		response.getWriter().write(jsonFinale.toString());
		
		System.out.println("[ControllaScadenzePagoPA] Fine procedura.");

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

}