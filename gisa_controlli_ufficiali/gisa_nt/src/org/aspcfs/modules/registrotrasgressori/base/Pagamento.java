package org.aspcfs.modules.registrotrasgressori.base;

import it.izs.ws.WsPost;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.logging.Logger;

import org.apache.commons.lang.StringEscapeUtils;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.registrotrasgressori.utils.RegistroTrasgressoriUtil;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.json.JSONObject;

public class Pagamento  {
	
	Logger logger = Logger.getLogger("MainLogger");

	private int id = -1;
	private int idSanzione = -1;
	private AnagraficaPagatore pagatore = null;
	private Ricevuta ricevuta = null;
	
	private int indice = -1; 
	
	private String tipoPagamento = null;
	private String dataScadenza = null;
	private String tipoVersamento = null;
	private String identificativoUnivocoDovuto = null;
	private String importoSingoloVersamento = null;
	private String identificativoTipoDovuto = null; 
	private String causaleVersamento = null;
	private String datiSpecificiRiscossione = null;
	private String tipoRiduzione = null;
	
	private int numeroRate = -1;
	
	private int enteredBy;
	private int modifiedBy;
	private int inviatoBy;
	private boolean inviato = false;
	private Timestamp dataInvio = null;
	private String esitoInvio = null;
	private String descrizioneErrore = null;
	private String statoPagamento = null;
	
	private String identificativoUnivocoVersamento = null;
	private String urlFileAvviso = null;
	private Timestamp dataGenerazioneIuv = null;

	private String codiceEsitoPagamento = null;
	
	private String codiceAvviso = null;
	private boolean aggiornatoConPagoPa = false;
	
	private boolean rigenerato = false;
	
	private String headerFileAvviso = null;
	private String headerFileRicevuta = null;
	
	public static final String PAGAMENTO_IN_CORSO = "PAGAMENTO IN CORSO";
	public static final String PAGAMENTO_COMPLETATO = "PAGAMENTO COMPLETATO";
	public static final String PAGAMENTO_NON_INIZIATO = "PAGAMENTO NON INIZIATO";
	public static final String PAGAMENTO_SCADUTO = "PAGAMENTO SCADUTO";

	public Pagamento(){
		
	}

	public Pagamento(ResultSet rs, Connection db) throws SQLException {
		buildRecord(rs, db);
	}
	
	private void buildRecord(ResultSet rs, Connection db) throws SQLException {
		
	this.id = rs.getInt("id");
	this.idSanzione = rs.getInt("id_sanzione");
	
	AnagraficaPagatore pag = new AnagraficaPagatore(db, rs.getInt("id_pagatore"));
	this.pagatore = pag;
	
	this.indice = rs.getInt("indice");
	
	this.tipoPagamento = rs.getString("tipo_pagamento");
	this.dataScadenza = rs.getString("data_scadenza");
	this.tipoVersamento = rs.getString("tipo_versamento");
	this.identificativoUnivocoDovuto = rs.getString("identificativo_univoco_dovuto");
	this.importoSingoloVersamento = rs.getString("importo_singolo_versamento");
	this.identificativoTipoDovuto = rs.getString("identificativo_tipo_dovuto"); 
	this.causaleVersamento = rs.getString("causale_versamento");
	this.datiSpecificiRiscossione = rs.getString("dati_specifici_riscossione");
	this.tipoRiduzione = rs.getString("tipo_riduzione");
	
	this.numeroRate = rs.getInt("numero_rate");
	
	this.enteredBy = rs.getInt("entered_by");
	this.modifiedBy = rs.getInt("modified_by");
	this.inviatoBy = rs.getInt("inviato_by");
	this.inviato = rs.getBoolean("inviato");
	this.dataInvio = rs.getTimestamp("data_invio");
	this.esitoInvio = rs.getString("esito_invio");
	this.descrizioneErrore = rs.getString("descrizione_errore");

	this.identificativoUnivocoVersamento = rs.getString("identificativo_univoco_versamento");
	this.urlFileAvviso = rs.getString("url_file_avviso");
	this.dataGenerazioneIuv = rs.getTimestamp("data_generazione_iuv");

	this.statoPagamento = rs.getString("stato_pagamento");
	
	if (statoPagamento.equals(PAGAMENTO_COMPLETATO))
		setRicevuta(db);
	
	this.codiceEsitoPagamento = rs.getString("codice_esito_pagamento");
	
	this.codiceAvviso = rs.getString("codice_avviso");
	this.aggiornatoConPagoPa = rs.getBoolean("aggiornato_con_pagopa");
	
	this.headerFileAvviso = rs.getString("header_file_avviso");
	this.headerFileRicevuta = rs.getString("header_file_ricevuta");

	this.rigenerato = rs.getBoolean("rigenerato");


	}


	public Pagamento(Connection db, int idPagamento) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti where id = ?");
		pst.setInt(1, idPagamento);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			buildRecord(rs, db);
	}


	public Pagamento(Connection db, String IUV) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti where identificativo_univoco_versamento = ? and trashed_date is null");
		pst.setString(1, IUV);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			buildRecord(rs, db);	}

	public Logger getLogger() {
		return logger;
	}


	public void setLogger(Logger logger) {
		this.logger = logger;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getIdSanzione() {
		return idSanzione;
	}


	public void setIdSanzione(int idSanzione) {
		this.idSanzione = idSanzione;
	}

	public AnagraficaPagatore getPagatore() {
		return pagatore;
	}


	public void setPagatore(AnagraficaPagatore pagatore) {
		this.pagatore = pagatore;
	}


	public int getIndice() {
		return indice;
	}


	public void setIndice(int indice) {
		this.indice = indice;
	}


	public String getTipoPagamento() {
		return tipoPagamento;
	}


	public void setTipoPagamento(String tipoPagamento) {
		this.tipoPagamento = tipoPagamento;
	}


	public String getDataScadenza() {
		return dataScadenza;
	}


	public void setDataScadenza(String dataScadenza) {
		this.dataScadenza = dataScadenza;
	}


	public String getTipoVersamento() {
		return tipoVersamento;
	}


	public void setTipoVersamento(String tipoVersamento) {
		this.tipoVersamento = tipoVersamento;
	}


	public String getIdentificativoUnivocoDovuto() {
		return identificativoUnivocoDovuto;
	}


	public void setIdentificativoUnivocoDovuto(String identificativoUnivocoDovuto) {
		this.identificativoUnivocoDovuto = identificativoUnivocoDovuto;
	}


	public String getImportoSingoloVersamento() {
		return importoSingoloVersamento;
	}


	public void setImportoSingoloVersamento(String importoSingoloVersamento) {
		this.importoSingoloVersamento = importoSingoloVersamento;
	}


	public String getIdentificativoTipoDovuto() {
		return identificativoTipoDovuto;
	}


	public void setIdentificativoTipoDovuto(String identificativoTipoDovuto) {
		this.identificativoTipoDovuto = identificativoTipoDovuto;
	}


	public String getCausaleVersamento() {
		return causaleVersamento;
	}


	public void setCausaleVersamento(String causaleVersamento) {
		this.causaleVersamento = causaleVersamento;
	}


	public String getDatiSpecificiRiscossione() {
		return datiSpecificiRiscossione;
	}


	public String getDescrizioneErrore() {
		return descrizioneErrore;
	}


	public void setDescrizioneErrore(String descrizioneErrore) {
		this.descrizioneErrore = descrizioneErrore;
	}


	public void setDatiSpecificiRiscossione(String datiSpecificiRiscossione) {
		this.datiSpecificiRiscossione = datiSpecificiRiscossione;
	}


	public int getEnteredBy() {
		return enteredBy;
	}


	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}


	public int getModifiedBy() {
		return modifiedBy;
	}


	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}


	public int getInviatoBy() {
		return inviatoBy;
	}


	public void setInviatoBy(int inviatoBy) {
		this.inviatoBy = inviatoBy;
	}


	public boolean isInviato() {
		return inviato;
	}


	public void setInviato(boolean inviato) {
		this.inviato = inviato;
	}


	public Timestamp getDataInvio() {
		return dataInvio;
	}


	public void setDataInvio(Timestamp dataInvio) {
		this.dataInvio = dataInvio;
	}


	public String getEsitoInvio() {
		return esitoInvio;
	}


	public void setEsitoInvio(String esitoInvio) {
		this.esitoInvio = esitoInvio;
	}


	public String getIdentificativoUnivocoVersamento() {
		return identificativoUnivocoVersamento;
	}


	public void setIdentificativoUnivocoVersamento(String identificativoUnivocoVersamento) {
		this.identificativoUnivocoVersamento = identificativoUnivocoVersamento;
	}


	public String getUrlFileAvviso() {
		return urlFileAvviso;
	}


	public void setUrlFileAvviso(String urlFileAvviso) {
		this.urlFileAvviso = urlFileAvviso;
	}
	
	public static ArrayList<Pagamento> getListaPagamenti (Connection db, int idSanzione, int userId) throws SQLException{
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti p where p.id_sanzione = ? and p.trashed_date is null and p.stato_pagamento <> ? order by p.id_pagatore asc, p.indice asc");
		pst.setInt(1, idSanzione);
		pst.setString(2, Pagamento.PAGAMENTO_SCADUTO);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Pagamento pagamento = new Pagamento(rs, db);
			
//			if (!Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
//				pagamento.chiediPagati(db, userId);
//			else if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
//				pagamento.annullaAltriPagamenti(db, userId);
			
			listaPagamenti.add(pagamento);
		}
		return listaPagamenti;
	}
	
	public static ArrayList<Pagamento> getListaPagamentiScaduti (Connection db, int idSanzione, int userId) throws SQLException{
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti p where p.id_sanzione = ? and p.trashed_date is null and p.stato_pagamento = ? order by p.id_pagatore asc, p.indice asc");
		pst.setInt(1, idSanzione);
		pst.setString(2, Pagamento.PAGAMENTO_SCADUTO);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Pagamento pagamento = new Pagamento(rs, db);
			
//			if (!Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
//				pagamento.chiediPagati(db, userId);
//			else if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
//				pagamento.annullaAltriPagamenti(db, userId);
			
			listaPagamenti.add(pagamento);
		}
		return listaPagamenti;
	}
	
	public static ArrayList<Pagamento> getListaPagamentiConVerificaStato (Connection db, int idSanzione, int userId) throws SQLException{
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti p where p.id_sanzione = ? and p.trashed_date is null and p.stato_pagamento <> ? order by p.id_pagatore asc, p.indice asc");
		pst.setInt(1, idSanzione);
		pst.setString(2, Pagamento.PAGAMENTO_SCADUTO);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Pagamento pagamento = new Pagamento(rs, db);
			
			if (!Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
				pagamento.chiediPagati(db, false, userId);
			else if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
				pagamento.annullaAltriPagamenti(db, userId);
			
			listaPagamenti.add(pagamento);
		}
		return listaPagamenti;
	}


	public static ArrayList<Pagamento> getListaAltriPagamenti (Connection db, int idSanzione, int idPagamento, int userId) throws SQLException{
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		PreparedStatement pst = db.prepareStatement("select * from pagopa_pagamenti p where p.id_sanzione = ? and p.id <> ? and (p.tipo_pagamento = 'NO' and p.indice = (select indice from pagopa_pagamenti where id = ?) or (p.tipo_pagamento='PV')) and p.trashed_date is null and p.stato_pagamento <> ? order by p.id_pagatore asc, p.indice asc");
		pst.setInt(1, idSanzione);
		pst.setInt(2, idPagamento);
		pst.setInt(3, idPagamento);
		pst.setString(4, Pagamento.PAGAMENTO_SCADUTO);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Pagamento pagamento = new Pagamento(rs, db);
			
			listaPagamenti.add(pagamento);
		}
		return listaPagamenti;
	}

	public String getStatoPagamento() {
		return statoPagamento;
	}

	public void setStatoPagamento(String statoPagamento) {
		this.statoPagamento = statoPagamento;
	}

	public void insert(Connection db, int idUtente) throws SQLException, ParseException {
		PreparedStatement pst = db.prepareStatement("select * from pagopa_genera_pagamento(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");  
		int i = 0;
		pst.setInt(++i, idSanzione);
		pst.setInt(++i, pagatore.getId());
		pst.setString(++i,  importoSingoloVersamento);
		pst.setString(++i, dataScadenza);
		pst.setString(++i, tipoPagamento);
		pst.setString(++i, tipoRiduzione);
		pst.setInt(++i, indice);
		pst.setInt(++i, numeroRate);
		pst.setBoolean(++i, rigenerato);
		pst.setInt(++i, idUtente); 
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			JSONObject json = new JSONObject(rs.getString(1));
			this.id = (int) json.get("idInserito");
			this.identificativoUnivocoDovuto = (String) json.get("IUD");
			
		}
	}


	public void importaDovuto(Connection db, int userId) throws SQLException {
		WsPost ws = new WsPost();
		String envelope = null;
		String response = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		logger.info(" ------ INVIO DATI importaDovuto A PAGOPA id pagamento "+id+" -----"); 
		ws.setWsUrl(ApplicationProperties.getProperty("END_POINT_PAGOPA")); 

		pst = db.prepareStatement("select * from get_chiamata_ws_pagopa_importa_dovuto(?, ?, ?)");
		pst.setString(1, ApplicationProperties.getProperty("USERNAME_WS_PAGOPA"));
		pst.setString(2, ApplicationProperties.getProperty("PASSWORD_WS_PAGOPA"));
		pst.setInt(3, id);
		rs = pst.executeQuery();
		while (rs.next())
			envelope = rs.getString(1);
		
		ws.setWsRequest(envelope);
		ws.setTIMEOUT_SECONDS(Integer.parseInt(ApplicationProperties.getProperty("TIMEOUT_SECONDS_PAGOPA")));
		response= ws.post(db, userId);
		try {Thread.sleep(500);} catch (InterruptedException e) {e.printStackTrace();}

		updateEsitoImportaDovuto(db, response, userId);
		
		updateStoricoDovuto(db, id, userId, envelope, response);
		
		PagoPaUtil.salvaStorico(db, userId, idSanzione, id, "ImportaDovuto");

	}

	public void aggiornaDovuto(Connection db, int userId) throws SQLException{
		WsPost ws = new WsPost();
		String envelope = null;
		String response = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		logger.info(" ------ INVIO DATI aggiornaDovuto A PAGOPA id pagamento "+id+" -----"); 
		ws.setWsUrl(ApplicationProperties.getProperty("END_POINT_PAGOPA")); 

		pst = db.prepareStatement("select * from get_chiamata_ws_pagopa_importa_dovuto_aggiorna(?, ?, ?)");
		pst.setString(1, ApplicationProperties.getProperty("USERNAME_WS_PAGOPA"));
		pst.setString(2, ApplicationProperties.getProperty("PASSWORD_WS_PAGOPA"));
		pst.setInt(3, id);
		rs = pst.executeQuery();
		while (rs.next())
			envelope = rs.getString(1);
		
		ws.setWsRequest(envelope);
		ws.setTIMEOUT_SECONDS(Integer.parseInt(ApplicationProperties.getProperty("TIMEOUT_SECONDS_PAGOPA")));
		response= ws.post(db, userId);
		try {Thread.sleep(500);} catch (InterruptedException e) {e.printStackTrace();}

		updateEsitoAggiornaDovuto(db, response, userId);
		
		updateStoricoDovuto(db, id, userId, envelope, response);
		
		PagoPaUtil.salvaStorico(db, userId, idSanzione, id, "AggiornaDovuto");
	}
	
	public void annullaDovuto(Connection db, int userId) throws SQLException{ 
		
		if (identificativoUnivocoVersamento!=null) {
			WsPost ws = new WsPost();
			String envelope = null;
			String response = null;
			PreparedStatement pst = null;
			ResultSet rs = null;
	
			logger.info(" ------ INVIO DATI annullaDovuto A PAGOPA id pagamento "+id+" -----"); 
			ws.setWsUrl(ApplicationProperties.getProperty("END_POINT_PAGOPA")); 
	
			pst = db.prepareStatement("select * from get_chiamata_ws_pagopa_importa_dovuto_annulla(?, ?, ?)");
			pst.setString(1, ApplicationProperties.getProperty("USERNAME_WS_PAGOPA"));
			pst.setString(2, ApplicationProperties.getProperty("PASSWORD_WS_PAGOPA"));
			pst.setInt(3, id);
			rs = pst.executeQuery();
			while (rs.next())
				envelope = rs.getString(1);
			
			ws.setWsRequest(envelope);
			ws.setTIMEOUT_SECONDS(Integer.parseInt(ApplicationProperties.getProperty("TIMEOUT_SECONDS_PAGOPA")));
			response= ws.post(db, userId);
			try {Thread.sleep(500);} catch (InterruptedException e) {e.printStackTrace();}

			updateEsitoAnnullaDovuto(db, response, userId);
			
			updateStoricoDovuto(db, id, userId, envelope, response);
			
			PagoPaUtil.salvaStorico(db, userId, idSanzione, id, "AnnullaDovuto");
		}
		else {
			this.esitoInvio="OK";
		}
}
	
	public void chiediPagati(Connection db, boolean verificaSolo, int userId) throws SQLException{
		WsPost ws = new WsPost();
		String envelope = null;
		String response = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		logger.info(" ------ INVIO DATI ChiediPagatiConRicevuta A PAGOPA id pagamento "+id+" -----"); 
		ws.setWsUrl(ApplicationProperties.getProperty("END_POINT_PAGOPA")); 

		pst = db.prepareStatement("select * from get_chiamata_ws_pagopa_chiedi_pagati(?, ?, ?)");
		pst.setString(1, ApplicationProperties.getProperty("USERNAME_WS_PAGOPA"));
		pst.setString(2, ApplicationProperties.getProperty("PASSWORD_WS_PAGOPA"));
		pst.setInt(3, id);
		rs = pst.executeQuery();
		while (rs.next())
			envelope = rs.getString(1);
		
		ws.setWsRequest(envelope);
		ws.setTIMEOUT_SECONDS(Integer.parseInt(ApplicationProperties.getProperty("TIMEOUT_SECONDS_PAGOPA")));
		response= ws.post(db, userId);
	// PER RISPOSTA PAGATO response="<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ns4:paaSILChiediPagatiConRicevutaRisposta xmlns:ns2=\"http://www.regione.veneto.it/pagamenti/ente/ppthead\" xmlns:ns3=\"http://www.regione.veneto.it/schemas/2012/Pagamenti/Ente/\" xmlns:ns4=\"http://www.regione.veneto.it/pagamenti/ente/\"><pagati>UEZCaFoyRjBhVU52YmxKcFkyVjJkWFJoSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5KbFoybHZibVV1ZG1WdVpYUnZMbWwwTDNOamFHVnRZWE12TWpBeE1pOVFZV2RoYldWdWRHa3ZSVzUwWlM4aVBnb2dJRHgyWlhKemFXOXVaVTluWjJWMGRHOCtOaTR5TGpBOEwzWmxjbk5wYjI1bFQyZG5aWFIwYno0S0lDQThaRzl0YVc1cGJ6NEtJQ0FnSUR4cFpHVnVkR2xtYVdOaGRHbDJiMFJ2YldsdWFXOCtPREF3TVRFNU9UQTJNems4TDJsa1pXNTBhV1pwWTJGMGFYWnZSRzl0YVc1cGJ6NEtJQ0E4TDJSdmJXbHVhVzgrQ2lBZ1BHbGtaVzUwYVdacFkyRjBhWFp2VFdWemMyRm5aMmx2VW1salpYWjFkR0UrT1RkaFlXVmxNRFJrTW1ZNE5HTXdOemt5WXpnM09UUTROalV6TkRaaU16TThMMmxrWlc1MGFXWnBZMkYwYVhadlRXVnpjMkZuWjJsdlVtbGpaWFoxZEdFK0NpQWdQR1JoZEdGUGNtRk5aWE56WVdkbmFXOVNhV05sZG5WMFlUNHlNREl5TFRFeExUSXpWREV3T2pVMU9qTTBMakF3TUNzd01Ub3dNRHd2WkdGMFlVOXlZVTFsYzNOaFoyZHBiMUpwWTJWMmRYUmhQZ29nSUR4eWFXWmxjbWx0Wlc1MGIwMWxjM05oWjJkcGIxSnBZMmhwWlhOMFlUNWhNamc1WlRsa00yVmlaV001TXpFME5UWTRPR1ptTUdGaVpUZzBPR1k0TlRaa056d3ZjbWxtWlhKcGJXVnVkRzlOWlhOellXZG5hVzlTYVdOb2FXVnpkR0UrQ2lBZ1BISnBabVZ5YVcxbGJuUnZSR0YwWVZKcFkyaHBaWE4wWVQ0eU1ESXlMVEV4TFRJekt6QXhPakF3UEM5eWFXWmxjbWx0Wlc1MGIwUmhkR0ZTYVdOb2FXVnpkR0UrQ2lBZ1BHbHpkR2wwZFhSdlFYUjBaWE4wWVc1MFpUNEtJQ0FnSUR4cFpHVnVkR2xtYVdOaGRHbDJiMVZ1YVhadlkyOUJkSFJsYzNSaGJuUmxQZ29nSUNBZ0lDQThkR2x3YjBsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amJ6NUhQQzkwYVhCdlNXUmxiblJwWm1sallYUnBkbTlWYm1sMmIyTnZQZ29nSUNBZ0lDQThZMjlrYVdObFNXUmxiblJwWm1sallYUnBkbTlWYm1sMmIyTnZQa0ZDU1RBek1EWTVQQzlqYjJScFkyVkpaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjgrQ2lBZ0lDQThMMmxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYjBGMGRHVnpkR0Z1ZEdVK0NpQWdJQ0E4WkdWdWIyMXBibUY2YVc5dVpVRjBkR1Z6ZEdGdWRHVStTVzUwWlhOaElGTmhibkJoYjJ4dklGTXVjQzVCUEM5a1pXNXZiV2x1WVhwcGIyNWxRWFIwWlhOMFlXNTBaVDRLSUNBOEwybHpkR2wwZFhSdlFYUjBaWE4wWVc1MFpUNEtJQ0E4Wlc1MFpVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHBaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjlDWlc1bFptbGphV0Z5YVc4K0NpQWdJQ0FnSUR4MGFYQnZTV1JsYm5ScFptbGpZWFJwZG05VmJtbDJiMk52UGtjOEwzUnBjRzlKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K0NpQWdJQ0FnSUR4amIyUnBZMlZKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K09EQXdNVEU1T1RBMk16azhMMk52WkdsalpVbGtaVzUwYVdacFkyRjBhWFp2Vlc1cGRtOWpiejRLSUNBZ0lEd3ZhV1JsYm5ScFptbGpZWFJwZG05VmJtbDJiMk52UW1WdVpXWnBZMmxoY21sdlBnb2dJQ0FnUEdSbGJtOXRhVzVoZW1sdmJtVkNaVzVsWm1samFXRnlhVzgrVW1WbmFXOXVaU0JEWVcxd1lXNXBZVHd2WkdWdWIyMXBibUY2YVc5dVpVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHBibVJwY21sNmVtOUNaVzVsWm1samFXRnlhVzgrVm1saElGTmhiblJoSUV4MVkybGhQQzlwYm1ScGNtbDZlbTlDWlc1bFptbGphV0Z5YVc4K0NpQWdJQ0E4WTJsMmFXTnZRbVZ1WldacFkybGhjbWx2UGpneFBDOWphWFpwWTI5Q1pXNWxabWxqYVdGeWFXOCtDaUFnSUNBOFkyRndRbVZ1WldacFkybGhjbWx2UGpnd01UTXlQQzlqWVhCQ1pXNWxabWxqYVdGeWFXOCtDaUFnSUNBOGJHOWpZV3hwZEdGQ1pXNWxabWxqYVdGeWFXOCtUbUZ3YjJ4cFBDOXNiMk5oYkdsMFlVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHdjbTkyYVc1amFXRkNaVzVsWm1samFXRnlhVzgrVGtFOEwzQnliM1pwYm1OcFlVSmxibVZtYVdOcFlYSnBiejRLSUNBZ0lEeHVZWHBwYjI1bFFtVnVaV1pwWTJsaGNtbHZQa2xVUEM5dVlYcHBiMjVsUW1WdVpXWnBZMmxoY21sdlBnb2dJRHd2Wlc1MFpVSmxibVZtYVdOcFlYSnBiejRLSUNBOGMyOW5aMlYwZEc5UVlXZGhkRzl5WlQ0S0lDQWdJRHhwWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI5UVlXZGhkRzl5WlQ0S0lDQWdJQ0FnUEhScGNHOUpaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjgrUmp3dmRHbHdiMGxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYno0S0lDQWdJQ0FnUEdOdlpHbGpaVWxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYno1R1RGUldRMDQxTjFBeE0wYzRNelJRUEM5amIyUnBZMlZKWkdWdWRHbG1hV05oZEdsMmIxVnVhWFp2WTI4K0NpQWdJQ0E4TDJsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxQmhaMkYwYjNKbFBnb2dJQ0FnUEdGdVlXZHlZV1pwWTJGUVlXZGhkRzl5WlQ1R1RFRlZWRThnVmtsT1EwVk9Xazg4TDJGdVlXZHlZV1pwWTJGUVlXZGhkRzl5WlQ0S0lDQThMM052WjJkbGRIUnZVR0ZuWVhSdmNtVStDaUFnUEdSaGRHbFFZV2RoYldWdWRHOCtDaUFnSUNBOFkyOWthV05sUlhOcGRHOVFZV2RoYldWdWRHOCtNRHd2WTI5a2FXTmxSWE5wZEc5UVlXZGhiV1Z1ZEc4K0NpQWdJQ0E4YVcxd2IzSjBiMVJ2ZEdGc1pWQmhaMkYwYno0eE5UQXdMakF3UEM5cGJYQnZjblJ2Vkc5MFlXeGxVR0ZuWVhSdlBnb2dJQ0FnUEdsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxWmxjbk5oYldWdWRHOCtNREV3TURBd01EQXdNRGMwTkRJd05qTThMMmxrWlc1MGFXWnBZMkYwYVhadlZXNXBkbTlqYjFabGNuTmhiV1Z1ZEc4K0NpQWdJQ0E4WTI5a2FXTmxRMjl1ZEdWemRHOVFZV2RoYldWdWRHOCtOVFpsT1RZMU1UUTJOV016TkdSallUZzNZelZoTVRobE9HWTROVEpoWVRJOEwyTnZaR2xqWlVOdmJuUmxjM1J2VUdGbllXMWxiblJ2UGdvZ0lDQWdQR1JoZEdsVGFXNW5iMnh2VUdGbllXMWxiblJ2UGdvZ0lDQWdJQ0E4YVdSbGJuUnBabWxqWVhScGRtOVZibWwyYjJOdlJHOTJkWFJ2UGpFNE1qQTBNREF4TURBd05qWTVOVHd2YVdSbGJuUnBabWxqWVhScGRtOVZibWwyYjJOdlJHOTJkWFJ2UGdvZ0lDQWdJQ0E4YzJsdVoyOXNiMGx0Y0c5eWRHOVFZV2RoZEc4K01UVXdNQzR3TUR3dmMybHVaMjlzYjBsdGNHOXlkRzlRWVdkaGRHOCtDaUFnSUNBZ0lEeGxjMmwwYjFOcGJtZHZiRzlRWVdkaGJXVnVkRzgrUlZORlIxVkpWRTg4TDJWemFYUnZVMmx1WjI5c2IxQmhaMkZ0Wlc1MGJ6NEtJQ0FnSUNBZ1BHUmhkR0ZGYzJsMGIxTnBibWR2Ykc5UVlXZGhiV1Z1ZEc4K01qQXlNaTB4TVMweU15c3dNVG93TUR3dlpHRjBZVVZ6YVhSdlUybHVaMjlzYjFCaFoyRnRaVzUwYno0S0lDQWdJQ0FnUEdsa1pXNTBhV1pwWTJGMGFYWnZWVzVwZG05amIxSnBjMk52YzNOcGIyNWxQalUyWlRrMk5URTBOalZqTXpSa1kyRTROMk0xWVRFNFpUaG1PRFV5WVdFeVBDOXBaR1Z1ZEdsbWFXTmhkR2wyYjFWdWFYWnZZMjlTYVhOamIzTnphVzl1WlQ0S0lDQWdJQ0FnUEdOaGRYTmhiR1ZXWlhKellXMWxiblJ2UGk5U1JrSXZNREV3TURBd01EQXdNRGMwTkRJd05qTXZNVFV3TUM0d01DOVVXRlF2VUZZZ1RpNGdNakF2TVRZM0xUSWdMU0JPUVZNZ1UwRWdMU0JTUVZSQklGVk9TVU5CUEM5allYVnpZV3hsVm1WeWMyRnRaVzUwYno0S0lDQWdJQ0FnUEdSaGRHbFRjR1ZqYVdacFkybFNhWE5qYjNOemFXOXVaVDQ1THpnM01URTVPREExTnpZOEwyUmhkR2xUY0dWamFXWnBZMmxTYVhOamIzTnphVzl1WlQ0S0lDQWdJQ0FnUEdsdVpHbGpaVVJoZEdsVGFXNW5iMnh2VUdGbllXMWxiblJ2UGpFOEwybHVaR2xqWlVSaGRHbFRhVzVuYjJ4dlVHRm5ZVzFsYm5SdlBnb2dJQ0FnSUNBOFkyOXRiV2x6YzJsdmJtbEJjSEJzYVdOaGRHVlFVMUErTUM0d01Ed3ZZMjl0YldsemMybHZibWxCY0hCc2FXTmhkR1ZRVTFBK0NpQWdJQ0E4TDJSaGRHbFRhVzVuYjJ4dlVHRm5ZVzFsYm5SdlBnb2dJRHd2WkdGMGFWQmhaMkZ0Wlc1MGJ6NEtQQzlRWVdkaGRHbERiMjVTYVdObGRuVjBZVDQ9</pagati><tipoFirma></tipoFirma><rt>PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIiA/PjxSVCB4bWxuczp4c2k9Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvWE1MU2NoZW1hLWluc3RhbmNlIiB4bWxuczp4cz0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEiIHhtbG5zOnBheV9pPSJodHRwOi8vd3d3LmRpZ2l0cGEuZ292Lml0L3NjaGVtYXMvMjAxMS9QYWdhbWVudGkvIiB4bWxucz0iaHR0cDovL3d3dy5kaWdpdHBhLmdvdi5pdC9zY2hlbWFzLzIwMTEvUGFnYW1lbnRpLyI+PHZlcnNpb25lT2dnZXR0bz42LjIuMDwvdmVyc2lvbmVPZ2dldHRvPjxkb21pbmlvPjxpZGVudGlmaWNhdGl2b0RvbWluaW8+ODAwMTE5OTA2Mzk8L2lkZW50aWZpY2F0aXZvRG9taW5pbz48L2RvbWluaW8+PGlkZW50aWZpY2F0aXZvTWVzc2FnZ2lvUmljZXZ1dGE+OTdhYWVlMDRkMmY4NGMwNzkyYzg3OTQ4NjUzNDZiMzM8L2lkZW50aWZpY2F0aXZvTWVzc2FnZ2lvUmljZXZ1dGE+PGRhdGFPcmFNZXNzYWdnaW9SaWNldnV0YT4yMDIyLTExLTIzVDEwOjU1OjM0PC9kYXRhT3JhTWVzc2FnZ2lvUmljZXZ1dGE+PHJpZmVyaW1lbnRvTWVzc2FnZ2lvUmljaGllc3RhPmEyODllOWQzZWJlYzkzMTQ1Njg4ZmYwYWJlODQ4Zjg1NmQ3PC9yaWZlcmltZW50b01lc3NhZ2dpb1JpY2hpZXN0YT48cmlmZXJpbWVudG9EYXRhUmljaGllc3RhPjIwMjItMTEtMjM8L3JpZmVyaW1lbnRvRGF0YVJpY2hpZXN0YT48aXN0aXR1dG9BdHRlc3RhbnRlPjxpZGVudGlmaWNhdGl2b1VuaXZvY29BdHRlc3RhbnRlPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkc8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz5BQkkwMzA2OTwvY29kaWNlSWRlbnRpZmljYXRpdm9Vbml2b2NvPjwvaWRlbnRpZmljYXRpdm9Vbml2b2NvQXR0ZXN0YW50ZT48ZGVub21pbmF6aW9uZUF0dGVzdGFudGU+SW50ZXNhIFNhbnBhb2xvIFMucC5BPC9kZW5vbWluYXppb25lQXR0ZXN0YW50ZT48L2lzdGl0dXRvQXR0ZXN0YW50ZT48ZW50ZUJlbmVmaWNpYXJpbz48aWRlbnRpZmljYXRpdm9Vbml2b2NvQmVuZWZpY2lhcmlvPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkc8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz44MDAxMTk5MDYzOTwvY29kaWNlSWRlbnRpZmljYXRpdm9Vbml2b2NvPjwvaWRlbnRpZmljYXRpdm9Vbml2b2NvQmVuZWZpY2lhcmlvPjxkZW5vbWluYXppb25lQmVuZWZpY2lhcmlvPlJlZ2lvbmUgQ2FtcGFuaWE8L2Rlbm9taW5hemlvbmVCZW5lZmljaWFyaW8+PGluZGlyaXp6b0JlbmVmaWNpYXJpbz5WaWEgU2FudGEgTHVjaWE8L2luZGlyaXp6b0JlbmVmaWNpYXJpbz48Y2l2aWNvQmVuZWZpY2lhcmlvPjgxPC9jaXZpY29CZW5lZmljaWFyaW8+PGNhcEJlbmVmaWNpYXJpbz44MDEzMjwvY2FwQmVuZWZpY2lhcmlvPjxsb2NhbGl0YUJlbmVmaWNpYXJpbz5OYXBvbGk8L2xvY2FsaXRhQmVuZWZpY2lhcmlvPjxwcm92aW5jaWFCZW5lZmljaWFyaW8+TkE8L3Byb3ZpbmNpYUJlbmVmaWNpYXJpbz48bmF6aW9uZUJlbmVmaWNpYXJpbz5JVDwvbmF6aW9uZUJlbmVmaWNpYXJpbz48L2VudGVCZW5lZmljaWFyaW8+PHNvZ2dldHRvUGFnYXRvcmU+PGlkZW50aWZpY2F0aXZvVW5pdm9jb1BhZ2F0b3JlPjx0aXBvSWRlbnRpZmljYXRpdm9Vbml2b2NvPkY8L3RpcG9JZGVudGlmaWNhdGl2b1VuaXZvY28+PGNvZGljZUlkZW50aWZpY2F0aXZvVW5pdm9jbz5GTFRWQ041N1AxM0c4MzRQPC9jb2RpY2VJZGVudGlmaWNhdGl2b1VuaXZvY28+PC9pZGVudGlmaWNhdGl2b1VuaXZvY29QYWdhdG9yZT48YW5hZ3JhZmljYVBhZ2F0b3JlPkZMQVVUTyBWSU5DRU5aTzwvYW5hZ3JhZmljYVBhZ2F0b3JlPjwvc29nZ2V0dG9QYWdhdG9yZT48ZGF0aVBhZ2FtZW50bz48Y29kaWNlRXNpdG9QYWdhbWVudG8+MDwvY29kaWNlRXNpdG9QYWdhbWVudG8+PGltcG9ydG9Ub3RhbGVQYWdhdG8+MTUwMC4wMDwvaW1wb3J0b1RvdGFsZVBhZ2F0bz48aWRlbnRpZmljYXRpdm9Vbml2b2NvVmVyc2FtZW50bz4wMTAwMDAwMDAwNzQ0MjA2MzwvaWRlbnRpZmljYXRpdm9Vbml2b2NvVmVyc2FtZW50bz48Q29kaWNlQ29udGVzdG9QYWdhbWVudG8+NTZlOTY1MTQ2NWMzNGRjYTg3YzVhMThlOGY4NTJhYTI8L0NvZGljZUNvbnRlc3RvUGFnYW1lbnRvPjxkYXRpU2luZ29sb1BhZ2FtZW50bz48c2luZ29sb0ltcG9ydG9QYWdhdG8+MTUwMC4wMDwvc2luZ29sb0ltcG9ydG9QYWdhdG8+PGVzaXRvU2luZ29sb1BhZ2FtZW50bz5FU0VHVUlUTzwvZXNpdG9TaW5nb2xvUGFnYW1lbnRvPjxkYXRhRXNpdG9TaW5nb2xvUGFnYW1lbnRvPjIwMjItMTEtMjM8L2RhdGFFc2l0b1NpbmdvbG9QYWdhbWVudG8+PGlkZW50aWZpY2F0aXZvVW5pdm9jb1Jpc2Nvc3Npb25lPjU2ZTk2NTE0NjVjMzRkY2E4N2M1YTE4ZThmODUyYWEyPC9pZGVudGlmaWNhdGl2b1VuaXZvY29SaXNjb3NzaW9uZT48Y2F1c2FsZVZlcnNhbWVudG8+L1JGQi8wMTAwMDAwMDAwNzQ0MjA2My8xNTAwLjAwL1RYVC9QViBOLiAyMC8xNjctMiAtIE5BUyBTQSAtIFJBVEEgVU5JQ0E8L2NhdXNhbGVWZXJzYW1lbnRvPjxkYXRpU3BlY2lmaWNpUmlzY29zc2lvbmU+OS8wMzAxMTE0U0EvODcxMTk4MDU3Ni88L2RhdGlTcGVjaWZpY2lSaXNjb3NzaW9uZT48Y29tbWlzc2lvbmlBcHBsaWNhdGVQU1A+MC4wMDwvY29tbWlzc2lvbmlBcHBsaWNhdGVQU1A+PC9kYXRpU2luZ29sb1BhZ2FtZW50bz48L2RhdGlQYWdhbWVudG8+PC9SVD4=</rt></ns4:paaSILChiediPagatiConRicevutaRisposta></soap:Body></soap:Envelope>";
		try {Thread.sleep(500);} catch (InterruptedException e) {e.printStackTrace();}
		
		updateEsitoChiediPagati(db, response, verificaSolo, userId);
		
		updateStoricoDovuto(db, id, userId, envelope, response);

		PagoPaUtil.salvaStorico(db, userId, idSanzione, id, "ChiediPagati");
	}
	
	public void updateEsitoImportaDovuto(Connection db, String response, int userId) throws SQLException {
		PreparedStatement pst = null;
		if (!inviato && response!=null){
			esitoInvio = getTagValue(response, "esito");
			if (esitoInvio.equalsIgnoreCase("OK")){
				if (identificativoUnivocoVersamento==null)
					identificativoUnivocoVersamento = getTagValue(response, "identificativoUnivocoVersamento");
				if (urlFileAvviso==null)
					urlFileAvviso = getTagValue(response, "urlFileAvviso");
	
				inviato = true;
			} else {
				descrizioneErrore = getTagValue(response, "description");
				if (descrizioneErrore== null || descrizioneErrore.equals(""))
					descrizioneErrore = getTagValue(response, "faultString");
}
		}
			
		pst = db.prepareStatement("update pagopa_pagamenti set esito_invio = ?, descrizione_errore = ?, inviato = ?, identificativo_univoco_versamento = ?, url_file_avviso = ?,  inviato_by = ?, data_invio = now(), note_hd = concat(note_hd, ';', '[', now(), '] [ImportaDovuto] Esito invio aggiornato a " + esitoInvio + " da utente "+userId+"') where id = ?");
		int i = 0;
		pst.setString(++i, esitoInvio);
		pst.setString(++i, descrizioneErrore);
		pst.setBoolean(++i, inviato);
		pst.setString(++i, identificativoUnivocoVersamento);
		pst.setString(++i, urlFileAvviso);
		pst.setInt(++i, userId);
		pst.setInt(++i, id); 
		pst.executeUpdate();
		
		if (urlFileAvviso != null && !"".equals(urlFileAvviso)){
			try {
				String codDocumento = PagoPaUtil.inviaADocumentaleConRitorno("", StringEscapeUtils.unescapeHtml(urlFileAvviso), "AvvisoPagoPA", ("AVVISO PAGO PA "+idSanzione), idSanzione, id, ("IUD: "+identificativoUnivocoDovuto+" IUV: "+identificativoUnivocoVersamento+ " PAGATORE: "+pagatore.getId() + "/"+pagatore.getPartitaIvaCodiceFiscale()+ " URL: "+urlFileAvviso), userId);
				pst = db.prepareStatement("update pagopa_pagamenti set header_file_avviso = ? where id = ?");
				pst.setString(1, codDocumento);
				pst.setInt(2, id); 
				pst.executeUpdate();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if (identificativoUnivocoVersamento != null && !identificativoUnivocoVersamento.equals("")){
			pst = db.prepareStatement("update pagopa_pagamenti set codice_avviso = ?, data_generazione_iuv = now(), note_hd = concat(note_hd, ';', '[', now(), '] Data generazione IUV modificata da utente "+userId+"') where id = ?");
			pst.setString(1, "3"+identificativoUnivocoVersamento);
			pst.setInt(2, id); 
			pst.executeUpdate();	
		}
	}
	
	public void updateEsitoAggiornaDovuto(Connection db, String response, int userId) throws SQLException {
		PreparedStatement pst = null;
		if (response!=null){
			try {urlFileAvviso = getTagValue(response, "urlFileAvviso");} catch (Exception e) {}
			esitoInvio = getTagValue(response, "esito");
			if (esitoInvio.equalsIgnoreCase("OK")){} else {
				descrizioneErrore = getTagValue(response, "description");
				if (descrizioneErrore== null || descrizioneErrore.equals(""))
					descrizioneErrore = getTagValue(response, "faultString");
			}
		}
			
		pst = db.prepareStatement("update pagopa_pagamenti set url_file_avviso = ?, esito_invio = ?, descrizione_errore = ?, inviato_by = ?, modified_by = ?, data_invio = now(), note_hd = concat(note_hd, ';', '[', now(), '] [AggiornaDovuto] Esito invio aggiornato a " + esitoInvio + " da utente "+userId+"')  where id = ?");
		int i = 0;
		pst.setString(++i, urlFileAvviso);
		pst.setString(++i, esitoInvio);
		pst.setString(++i, descrizioneErrore);
		pst.setInt(++i, userId);
		pst.setInt(++i, userId);
		pst.setInt(++i, id); 
		pst.executeUpdate();	
		
		if (urlFileAvviso != null && !"".equals(urlFileAvviso)){
			try {
				String codDocumento = PagoPaUtil.inviaADocumentaleConRitorno("", StringEscapeUtils.unescapeHtml(urlFileAvviso), "AvvisoPagoPA", ("AVVISO PAGO PA "+idSanzione), idSanzione, id, ("IUD: "+identificativoUnivocoDovuto+" IUV: "+identificativoUnivocoVersamento+ " PAGATORE: "+pagatore.getId() + "/"+pagatore.getPartitaIvaCodiceFiscale()+ " URL: "+urlFileAvviso), userId);
				pst = db.prepareStatement("update pagopa_pagamenti set header_file_avviso = ? where id = ?");
				pst.setString(1, codDocumento);
				pst.setInt(2, id); 
				pst.executeUpdate();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

	public void updateEsitoAnnullaDovuto(Connection db, String response, int userId) throws SQLException {
		PreparedStatement pst = null;
		if (response!=null){
			esitoInvio = getTagValue(response, "esito");
			if (esitoInvio.equalsIgnoreCase("OK")){} else {
				descrizioneErrore = getTagValue(response, "description");
				if (descrizioneErrore== null || descrizioneErrore.equals(""))
					descrizioneErrore = getTagValue(response, "faultString");
			}
		}
			
		pst = db.prepareStatement("update pagopa_pagamenti set esito_invio = ?, descrizione_errore = ?, note_hd = concat(note_hd, ';', '[', now(), '] [AnnullaDovuto] Esito invio aggiornato a " + esitoInvio + " da utente "+userId+"') where id = ?");
		int i = 0;
		pst.setString(++i, esitoInvio);
		pst.setString(++i, descrizioneErrore);
		pst.setInt(++i, id); 
		pst.executeUpdate();
		
	}
	
	public void updateEsitoChiediPagati(Connection db, String response, boolean verificaSolo, int userId) throws SQLException {
		PreparedStatement pst = null;
		
		String faultCode = null;
		String faultString = null;
		String description = null;
		
		if (response!=null && !response.equals("")){
			faultString = getTagValue(response, "faultString");
			faultCode = getTagValue(response, "faultCode");
			description = getTagValue(response, "description");

			String rt = getTagValue(response, "rt");
			String pagati = getTagValue(response, "pagati");
			String esito = getTagValue(response, "esito");
			String pagati_o_esito = "";
			
			if (pagati!=null && !pagati.equalsIgnoreCase(""))
				pagati_o_esito = pagati;
			else if (esito!=null && !esito.equalsIgnoreCase(""))
				pagati_o_esito = esito;
			else
				pagati_o_esito = rt;

			byte[] decodedBytes = null;
			String decodedString = "";
			
			int k = 0;
			
			while (k++<10 && !decodedString.startsWith("<")){ //decodifico il tag finche' non contiene il contenuto giusto (sono necessari piu' decode in alcuni casi)
					decodedBytes = Base64.getDecoder().decode(pagati_o_esito);
					decodedString = new String(decodedBytes);
					pagati_o_esito = decodedString;
			}
			
			decodedString = decodedString.replaceAll("pay_i:", "");

			// dati pagamento
			codiceEsitoPagamento = getTagValue(decodedString, "codiceEsitoPagamento");
			
			// dati ricevuta
			ricevuta = new Ricevuta(decodedString);
			
			if ((faultCode!=null && faultCode.equals("PAA_PAGAMENTO_NON_INIZIATO")))
				statoPagamento = PAGAMENTO_NON_INIZIATO;
			else if ((faultCode!=null && faultCode.equals("PAA_PAGAMENTO_IN_CORSO")))
				statoPagamento = PAGAMENTO_IN_CORSO;
			else if ((codiceEsitoPagamento!=null && codiceEsitoPagamento.equals("0"))) 
				statoPagamento = PAGAMENTO_COMPLETATO;
			else if ((faultCode!=null && faultCode.equals("PAA_SYSTEM_ERROR")) && (description!=null && description.toLowerCase().contains("dovuto scaduto"))) 
				statoPagamento = PAGAMENTO_SCADUTO;
			else
				statoPagamento = faultString;
			
			pst = db.prepareStatement("update pagopa_pagamenti set aggiornato_con_pagopa = true where id = ?");
			int i = 0;
			pst.setInt(++i, id); 
			pst.executeUpdate();	
	}
		else {
			pst = db.prepareStatement("update pagopa_pagamenti set aggiornato_con_pagopa = false where id = ?");
			int i = 0;
			pst.setInt(++i, id); 
			pst.executeUpdate();	
			}
		
		if (statoPagamento!=null && !statoPagamento.equals("")) {
			pst = db.prepareStatement("update pagopa_pagamenti set stato_pagamento = ?, codice_esito_pagamento = ?, note_hd = concat(note_hd, ';', '[', now(), '] [ChiediPagati] Stato pagamento aggiornato a " + statoPagamento + " da utente "+userId+"') where id = ?");
			int i = 0;
			pst.setString(++i, statoPagamento);
			pst.setString(++i, codiceEsitoPagamento);
			pst.setInt(++i, id);
			
			pst.executeUpdate();	
			
			if (statoPagamento.equals(PAGAMENTO_COMPLETATO)){
				
				ricevuta.setIdPagamento(id);
				ricevuta.insert(db);

				if (!verificaSolo)
					annullaAltriPagamenti(db, userId);
			}
	}
}
	
	private void annullaAltriPagamenti(Connection db, int userId) throws SQLException {
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		listaPagamenti = Pagamento.getListaAltriPagamenti(db, idSanzione, id, userId);
		if (listaPagamenti.size()>0) {
			PagoPaUtil.salvaStorico(db, userId, idSanzione, -1, "Tentativo di annullamento massivo IUV ad eccezione di quello pagato");
	
			for (int i = 0; i<listaPagamenti.size(); i++){
				Pagamento p = (Pagamento) listaPagamenti.get(i);
				p.chiediPagati(db, true, userId);
				
				if (PAGAMENTO_NON_INIZIATO.equals(p.getStatoPagamento())) {
					p.annullaDovuto(db, userId);
					if ((p.getEsitoInvio().equalsIgnoreCase("OK") || (p.getEsitoInvio().equalsIgnoreCase("KO") && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))))
						p.delete(db, userId);
				}
			}
		}
	}

	public static String getTagValue(String xml, String tagName){
		String esito = "";
	    try {esito =  xml.split("<"+tagName+">")[1].split("</"+tagName+">")[0]; } catch (Exception e) {}
	    return esito;
	}

	public void update(Connection db, int userId) throws SQLException {
		PreparedStatement pst = null;
		pst = db.prepareStatement("update pagopa_pagamenti set data_scadenza = ?, modified_by = ?, note_hd = concat(note_hd, ';', '[', now(), '] Data scadenza modificata da ', data_scadenza, ' a " + dataScadenza + " da utente "+userId+"') where id = ?"); 
		int i = 0;
		pst.setString(++i, dataScadenza);
		pst.setInt(++i, userId); 
		pst.setInt(++i, id); 
		pst.executeUpdate();	
	
	}
	
	public void delete(Connection db, int userId) throws SQLException {
		PreparedStatement pst = null;
		pst = db.prepareStatement("update pagopa_pagamenti set trashed_date = now(), modified_by = ?  where id = ?");
		int i = 0;
		pst.setInt(++i, userId); 
		pst.setInt(++i, id); 
		pst.executeUpdate();	
		
	}

	public Timestamp getDataGenerazioneIuv() {
		return dataGenerazioneIuv;
	}

	public void setDataGenerazioneIuv(Timestamp dataGenerazioneIuv) {
		this.dataGenerazioneIuv = dataGenerazioneIuv;
	}

	public String getTipoRiduzione() {
		return tipoRiduzione;
	}

	public void setTipoRiduzione(String tipoRiduzione) {
		this.tipoRiduzione = tipoRiduzione;
	}

	public String getCodiceAvviso() {
		return codiceAvviso;
	}

	public void setCodiceAvviso(String codiceAvviso) {
		this.codiceAvviso = codiceAvviso;
	}

	public boolean isAggiornatoConPagoPa() {
		return aggiornatoConPagoPa;
	}

	public void setAggiornatoConPagoPa(boolean aggiornatoConPagoPa) {
		this.aggiornatoConPagoPa = aggiornatoConPagoPa;
	}

	public int getNumeroRate() {
		return numeroRate;
	}

	public void setNumeroRate(int numeroRate) {
		this.numeroRate = numeroRate;
	}

	public String getCodiceEsitoPagamento() {
		return codiceEsitoPagamento;
	}

	public void setCodiceEsitoPagamento(String codiceEsitoPagamento) {
		this.codiceEsitoPagamento = codiceEsitoPagamento;
	}

	public static double[] getImportiTotaliOrdinanza(Connection db, int idSanzione) throws SQLException {
		double[] importiTotali = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		pst = db.prepareStatement("select * from get_pagopa_importi_totali_ordinanza(?)"); 
		int i = 0;
		pst.setInt(++i, idSanzione); 
		rs = pst.executeQuery();
		
		if (rs.next()){
			importiTotali = new double[] {rs.getFloat("importo_totale_richiesto"), rs.getFloat("importo_totale_versato"), rs.getFloat("importo_totale_residuo")};
		};
		return importiTotali;		 
	}
	
	public static boolean getPossibilitaRigeneraOrdinanza(Connection db, int idSanzione) throws SQLException {
		boolean possibilitaRigenera = true;
		PreparedStatement pst = null;
		ResultSet rs = null;
		pst = db.prepareStatement("select * from get_pagopa_importi_totali_ordinanza(?)"); 
		int i = 0;
		pst.setInt(++i, idSanzione); 
		rs = pst.executeQuery();
		
		if (rs.next()){
			possibilitaRigenera = rs.getBoolean("possibilita_rigenera");
		};
		return possibilitaRigenera;		 
	}

	public boolean isRigenerato() {
		return rigenerato;
	}

	public void setRigenerato(boolean rigenerato) {
		this.rigenerato = rigenerato;
	}
	
	public void testPaga(Connection db, int userId) throws SQLException {
		PreparedStatement pst = null;
		pst = db.prepareStatement("update pagopa_pagamenti set stato_pagamento = ?, codice_esito_pagamento = ? , note_hd = concat(note_hd, ';', '[', now(), '] [ChiediPagati] Stato pagamento aggiornato a " + PAGAMENTO_COMPLETATO + " da utente "+userId+"') where id = ?");
		int i = 0;
		pst.setString(++i, PAGAMENTO_COMPLETATO);
		pst.setString(++i, "0");
		pst.setInt(++i, id); 
		pst.executeUpdate();	
		
		Ricevuta r = new Ricevuta();
		r.setIdPagamento(id);
		
		r.setEsitoSingoloPagamento("OK");
		r.setCodiceEsitoPagamento("0");
		r.setIdentificativoUnivocoRiscossione("12345678-TEST");
		r.setSingoloImportoPagato(importoSingoloVersamento);
		r.setDataEsitoSingoloPagamento(String.valueOf(new Timestamp(System.currentTimeMillis())));
		r.setRiferimentoDataRichiesta(String.valueOf(new Timestamp(System.currentTimeMillis())));
		r.setCodiceContestoPagamento("123456abc");
		r.setIdUnivocoVersamento(identificativoUnivocoVersamento);
		r.setIdUnivocoDovuto(identificativoUnivocoDovuto);
		r.setIdentificativoDominio("987654321");
		r.setRiferimentoMessaggioRichiesta("BXZAQWERTRT");
		
		r.setDenominazioneAttestante("US BANK");
		r.setTipoAttestante("Y");
		r.setCodiceUnivocoAttestante("FFF111FFF111");
		
		r.setDenominazioneBeneficiario("GISA COLLAUDO");
		r.setTipoBeneficiario("Y");
		r.setCodiceUnivocoBeneficiario("XYZXYZ987XYZ");
		r.setIndirizzoBeneficiario("CENTRO DIREZIONALE");
		r.setCivicoBeneficiario("G2");
		r.setCapBeneficiario("80010");
		r.setLocalitaBeneficiario("NAPOLI");
		r.setProvinciaBeneficiario("NA");
		r.setNazioneBeneficiario("IT");

		r.setAnagraficaPagatore("COLLAUDATORE");
		r.setTipoPagatore("Y");
		r.setCodiceUnivocoPagatore("ABCDEF123ABC");
		r.setIndirizzoPagatore("STANZA DEL COLLAUDO");
		r.setCivicoPagatore("32");
		r.setCapPagatore("80010");
		r.setLocalitaPagatore("NAPOLI");
		r.setProvinciaPagatore("NA");
		r.setNazionePagatore("IT");
		r.setEmailPagatore("gisadev@usmail.it");
		
		r.setCausaleVersamento(causaleVersamento);
		r.setDatiSpecificiRiscossione(datiSpecificiRiscossione);
		r.setIdentificativoMessaggioRicevuta("RT_TEST_"+Math.random());
		r.insert(db);
		
		annullaAltriPagamenti(db, userId);
	}
	
	public void testScadi(Connection db, int userId) throws SQLException {
		PreparedStatement pst = null;
		pst = db.prepareStatement("update pagopa_pagamenti set stato_pagamento = ?, data_scadenza = to_char((now() -interval '1 day'), 'yyyy-mm-dd'), note_hd = concat(note_hd, ';', '[', now(), '] [ChiediPagati] Stato pagamento aggiornato a " + PAGAMENTO_SCADUTO + " da utente "+userId+"') where id = ?");
		int i = 0;
		pst.setString(++i, PAGAMENTO_SCADUTO);
		pst.setInt(++i, id); 
		pst.executeUpdate();	
	}

	public void updateStoricoDovuto(Connection db, int idPagamento, int idUtente, String request, String response)
			throws SQLException {
		
		try {
			if (request==null)
				request="";
			if (response==null)
				response="";
			
			String jsonStorico = " { "; 
			jsonStorico += " \"Data\" : \"" + (new Timestamp(System.currentTimeMillis())) + "\"";
			jsonStorico += ", \"Utente\" : \"" + idUtente + "\""; 
			jsonStorico += ", \"Request\" : \"" + request.replace("\"", "'").replaceAll("\r\n|\r|\n", "") + "\"";
			jsonStorico += ", \"Response\" : \"" + response.replace("\"", "'").replaceAll("\r\n|\r|\n", "")  + "\"";
			jsonStorico += " } ";
			
			PreparedStatement pst = db
					.prepareStatement("insert into pagopa_pagamenti_storico_chiamate(id_pagamento, storico) values(?, ?)");
			int i = 0;
			pst.setInt(++i, idPagamento);
			pst.setString(++i, jsonStorico.toString());
			pst.executeUpdate();
		
	} catch (Exception e) {e.printStackTrace();}
		
	}

	public Ricevuta getRicevuta() {
		return ricevuta;
	}

	public void setRicevuta(Ricevuta ricevuta) { 
		this.ricevuta = ricevuta;
	}
	
	public void setRicevuta(Connection db) throws SQLException {
		Ricevuta r = new Ricevuta();
		r.buildRicevutaFromIdPagamento(db, id);
		this.ricevuta = r;
	}

	public String getHeaderFileAvviso() {
		return headerFileAvviso;
	}

	public void setHeaderFileAvviso(String headerFileAvviso) {
		this.headerFileAvviso = headerFileAvviso;
	}
	
	public String getHeaderFileRicevuta() {
		return headerFileRicevuta;
	}

	public void setHeaderFileRicevuta(String headerFileRicevuta) {
		this.headerFileRicevuta = headerFileRicevuta;
	}

	public void scadiDovuto(Connection db, int userId) throws SQLException {
		PreparedStatement pst = null;
			
		pst = db.prepareStatement("update pagopa_pagamenti set stato_pagamento = ?, note_hd = concat(note_hd, ';', '[', now(), '] [ScadiDovuto] Dovuto scaduto.') where id = ?");
		int i = 0;
		pst.setString(++i, PAGAMENTO_SCADUTO);
		pst.setInt(++i, id); 
		pst.executeUpdate();
		
	}

	public static ArrayList<Integer> getDoppiPagamenti(Connection db, int idSanzione) throws SQLException {
		ArrayList<Integer> lista = new ArrayList<Integer>();
		String doppiPagamenti = "";
		PreparedStatement pst = null;
		ResultSet rs = null;
		pst = db.prepareStatement("select * from get_registro_trasgressori_doppi_pagamenti(?)"); 
		int i = 0;
		pst.setInt(++i, idSanzione); 
		rs = pst.executeQuery();
		
		if (rs.next()){
			doppiPagamenti = rs.getString(1);
			if (doppiPagamenti != null){
				String[] doppiPagamentiArray = doppiPagamenti.split(";");
				for (int k=0; k<doppiPagamentiArray.length; k++)
					lista.add(Integer.parseInt(doppiPagamentiArray[k]));
			}
		};
		return lista;		 
	}
	
	
}


