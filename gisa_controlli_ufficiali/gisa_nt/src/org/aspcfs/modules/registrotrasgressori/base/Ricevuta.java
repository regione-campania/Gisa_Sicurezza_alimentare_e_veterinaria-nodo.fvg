package org.aspcfs.modules.registrotrasgressori.base;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.json.JSONObject;

public class Ricevuta {

	private int id = -1;
	private int idPagamento = -1;
	
	private String singoloImportoPagato = null;
	private String codiceContestoPagamento = null;
	private String idUnivocoVersamento = null;
	private String identificativoDominio = null;
	private String riferimentoDataRichiesta = null;
	private String riferimentoMessaggioRichiesta = null;
	
	private String esitoSingoloPagamento = null;
	private String dataRicevuta = null;
	private String identificativoMessaggioRicevuta = null;

	private String denominazioneBeneficiario = null;
	private String tipoBeneficiario = null;
	private String codiceUnivocoBeneficiario = null;
	private String nazioneBeneficiario = null;
	private String provinciaBeneficiario = null;
	private String localitaBeneficiario = null;
	private String indirizzoBeneficiario = null;
	private String civicoBeneficiario = null;
	private String capBeneficiario = null;

	private String anagraficaPagatore = null;
	private String tipoPagatore = null;
	private String codiceUnivocoPagatore = null;
	private String emailPagatore = null;
	private String nazionePagatore = null;
	private String provinciaPagatore = null;
	private String localitaPagatore = null;
	private String indirizzoPagatore = null;
	private String civicoPagatore = null;
	private String capPagatore = null;

	private String denominazioneAttestante = null;
	private String tipoAttestante = null;
	private String codiceUnivocoAttestante = null;
	
	private String idUnivocoDovuto = null;
	private String dataEsitoSingoloPagamento = null;
	private String identificativoUnivocoRiscossione = null;
	private String causaleVersamento = null;
	private String datiSpecificiRiscossione = null;

	private String codiceEsitoPagamento = null;

	public Ricevuta(String decodedString) {
		
		String dominio = getTagValue(decodedString, "dominio");
		String istitutoAttestante = getTagValue(decodedString, "istitutoAttestante");
		String enteBeneficiario = getTagValue(decodedString, "enteBeneficiario");
		String soggettoPagatore = getTagValue(decodedString, "soggettoPagatore");
		String datiPagamento = getTagValue(decodedString, "datiPagamento");
		String datiSingoloPagamento = getTagValue(datiPagamento, "datiSingoloPagamento");
		
		singoloImportoPagato = getTagValue(datiPagamento, "importoTotalePagato");
		codiceContestoPagamento = getTagValue(datiPagamento, "codiceContestoPagamento");
		idUnivocoVersamento = getTagValue(datiPagamento, "identificativoUnivocoVersamento");
		identificativoDominio = getTagValue(dominio, "identificativoDominio");
		
		riferimentoDataRichiesta =  getTagValue(decodedString, "riferimentoDataRichiesta");
		riferimentoMessaggioRichiesta =  getTagValue(decodedString, "riferimentoMessaggioRichiesta");

		esitoSingoloPagamento = getTagValue(datiSingoloPagamento, "esitoSingoloPagamento");
		dataRicevuta = getTagValue(decodedString, "dataOraMessaggioRicevuta");
		identificativoMessaggioRicevuta = getTagValue(decodedString, "identificativoMessaggioRicevuta");

		denominazioneBeneficiario = getTagValue(enteBeneficiario, "denominazioneBeneficiario");
		tipoBeneficiario = getTagValue(enteBeneficiario, "tipoIdentificativoUnivoco");
		codiceUnivocoBeneficiario = getTagValue(enteBeneficiario, "codiceIdentificativoUnivoco");
		nazioneBeneficiario = getTagValue(enteBeneficiario, "nazioneBeneficiario");
		provinciaBeneficiario = getTagValue(enteBeneficiario, "provinciaBeneficiario");
		localitaBeneficiario = getTagValue(enteBeneficiario, "localitaBeneficiario");
		indirizzoBeneficiario = getTagValue(enteBeneficiario, "indirizzoBeneficiario");
		civicoBeneficiario = getTagValue(enteBeneficiario, "civicoBeneficiario");
		capBeneficiario = getTagValue(enteBeneficiario, "capBeneficiario");

		anagraficaPagatore = getTagValue(soggettoPagatore, "anagraficaPagatore");
		tipoPagatore = getTagValue(soggettoPagatore, "tipoIdentificativoUnivoco");
		codiceUnivocoPagatore = getTagValue(soggettoPagatore, "codiceIdentificativoUnivoco");
		emailPagatore = getTagValue(soggettoPagatore, "e-mailPagatore");
		nazionePagatore = getTagValue(soggettoPagatore, "nazionePagatore");
		provinciaPagatore = getTagValue(soggettoPagatore, "provinciaPagatore");
		localitaPagatore = getTagValue(soggettoPagatore, "localitaPagatore");
		indirizzoPagatore = getTagValue(soggettoPagatore, "indirizzoPagatore");
		civicoPagatore = getTagValue(soggettoPagatore, "civicoPagatore");
		capPagatore = getTagValue(soggettoPagatore, "capPagatore");

		denominazioneAttestante = getTagValue(istitutoAttestante, "denominazioneAttestante");
		tipoAttestante = getTagValue(istitutoAttestante, "tipoIdentificativoUnivoco");
		codiceUnivocoAttestante = getTagValue(istitutoAttestante, "codiceIdentificativoUnivoco");

		idUnivocoDovuto = getTagValue(datiSingoloPagamento, "identificativoUnivocoDovuto");
		dataEsitoSingoloPagamento = getTagValue(datiSingoloPagamento, "dataEsitoSingoloPagamento");
		identificativoUnivocoRiscossione = getTagValue(datiSingoloPagamento, "identificativoUnivocoRiscossione");
		causaleVersamento = getTagValue(datiSingoloPagamento, "causaleVersamento");
		datiSpecificiRiscossione = getTagValue(datiSingoloPagamento, "datiSpecificiRiscossione");

		codiceEsitoPagamento = getTagValue(datiPagamento, "codiceEsitoPagamento");
		
	}

	public Ricevuta() {
		// TODO Auto-generated constructor stub
	}

	private void buildRecord(ResultSet rs) throws SQLException {
		
		this.id = rs.getInt("id");
		this.idPagamento = rs.getInt("id_pagamento");
		
		this.denominazioneAttestante = rs.getString("denominazione_attestante");
		this.denominazioneBeneficiario = rs.getString("denominazione_beneficiario");
		this.esitoSingoloPagamento = rs.getString("esito_singolo_pagamento");
		this.identificativoUnivocoRiscossione = rs.getString("identificativo_univoco_riscossione");
		this.singoloImportoPagato = rs.getString("singolo_importo_pagato");
		this.dataEsitoSingoloPagamento = rs.getString("data_esito_singolo_pagamento");
		this.codiceEsitoPagamento = rs.getString("codice_esito_pagamento");
		
		this.identificativoMessaggioRicevuta = rs.getString("identificativo_messaggio_ricevuta");
		this.indirizzoBeneficiario = rs.getString("indirizzo_beneficiario");
		this.civicoBeneficiario = rs.getString("civico_beneficiario");
		this.capBeneficiario = rs.getString("cap_beneficiario");
		this.localitaBeneficiario = rs.getString("localita_beneficiario");
		this.provinciaBeneficiario = rs.getString("provincia_beneficiario");
		this.nazioneBeneficiario = rs.getString("nazione_beneficiario");
		this.anagraficaPagatore = rs.getString("anagrafica_pagatore");
		this.indirizzoPagatore = rs.getString("indirizzo_pagatore");
		this.civicoPagatore = rs.getString("civico_pagatore");
		this.capPagatore = rs.getString("cap_pagatore");
		this.localitaPagatore = rs.getString("localita_pagatore");
		this.provinciaPagatore = rs.getString("provincia_pagatore");
		this.nazionePagatore = rs.getString("nazione_pagatore");
		this.causaleVersamento = rs.getString("causale_versamento");
		this.codiceContestoPagamento = rs.getString("codice_contesto_pagamento");
		this.idUnivocoVersamento = rs.getString("id_univoco_versamento");
		this.identificativoDominio = rs.getString("identificativo_dominio");
		this.riferimentoDataRichiesta = rs.getString("riferimento_data_richiesta");
		this.riferimentoMessaggioRichiesta = rs.getString("riferimento_messaggio_richiesta");
		this.dataRicevuta = rs.getString("data_ricevuta");
		this.tipoBeneficiario = rs.getString("tipo_beneficiario");
		this.codiceUnivocoBeneficiario = rs.getString("codice_univoco_beneficiario");
		this.tipoPagatore = rs.getString("tipo_pagatore");
		this.codiceUnivocoPagatore = rs.getString("codice_univoco_pagatore");
		this.emailPagatore = rs.getString("email_pagatore");
		this.tipoAttestante = rs.getString("tipo_attestante");
		this.codiceUnivocoAttestante = rs.getString("codice_univoco_attestante");
		this.idUnivocoDovuto = rs.getString("id_univoco_dovuto");
		this.datiSpecificiRiscossione = rs.getString("dati_specifici_riscossione");
		
		
		}
	
	public static String getTagValue(String xml, String tagName){
		String esito = "";
	    try {esito =  xml.split("<"+tagName+">")[1].split("</"+tagName+">")[0]; } catch (Exception e) {}
	    return esito;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdPagamento() {
		return idPagamento;
	}

	public void setIdPagamento(int idPagamento) {
		this.idPagamento = idPagamento;
	}

	public String getDenominazioneAttestante() {
		return denominazioneAttestante;
	}

	public void setDenominazioneAttestante(String denominazioneAttestante) {
		this.denominazioneAttestante = denominazioneAttestante;
	}

	public String getEsitoSingoloPagamento() {
		return esitoSingoloPagamento;
	}

	public void setEsitoSingoloPagamento(String esitoSingoloPagamento) {
		this.esitoSingoloPagamento = esitoSingoloPagamento;
	}

	public String getIdentificativoUnivocoRiscossione() {
		return identificativoUnivocoRiscossione;
	}

	public void setIdentificativoUnivocoRiscossione(String identificativoUnivocoRiscossione) {
		this.identificativoUnivocoRiscossione = identificativoUnivocoRiscossione;
	}

	public String getSingoloImportoPagato() {
		return singoloImportoPagato;
	}

	public void setSingoloImportoPagato(String singoloImportoPagato) {
		this.singoloImportoPagato = singoloImportoPagato;
	}

	public String getDataEsitoSingoloPagamento() {
		return dataEsitoSingoloPagamento;
	}

	public void setDataEsitoSingoloPagamento(String dataEsitoSingoloPagamento) {
		this.dataEsitoSingoloPagamento = dataEsitoSingoloPagamento;
	}

	public String getCodiceEsitoPagamento() {
		return codiceEsitoPagamento;
	}

	public void setCodiceEsitoPagamento(String codiceEsitoPagamento) {
		this.codiceEsitoPagamento = codiceEsitoPagamento;
	}

	public String getIdentificativoMessaggioRicevuta() {
		return identificativoMessaggioRicevuta;
	}

	public void setIdentificativoMessaggioRicevuta(String identificativoMessaggioRicevuta) {
		this.identificativoMessaggioRicevuta = identificativoMessaggioRicevuta;
	}

	public String getDenominazioneBeneficiario() {
		return denominazioneBeneficiario;
	}

	public void setDenominazioneBeneficiario(String denominazioneBeneficiario) {
		this.denominazioneBeneficiario = denominazioneBeneficiario;
	}

	public String getIndirizzoBeneficiario() {
		return indirizzoBeneficiario;
	}

	public void setIndirizzoBeneficiario(String indirizzoBeneficiario) {
		this.indirizzoBeneficiario = indirizzoBeneficiario;
	}

	public String getCivicoBeneficiario() {
		return civicoBeneficiario;
	}

	public void setCivicoBeneficiario(String civicoBeneficiario) {
		this.civicoBeneficiario = civicoBeneficiario;
	}

	public String getCapBeneficiario() {
		return capBeneficiario;
	}

	public void setCapBeneficiario(String capBeneficiario) {
		this.capBeneficiario = capBeneficiario;
	}

	public String getLocalitaBeneficiario() {
		return localitaBeneficiario;
	}

	public void setLocalitaBeneficiario(String localitaBeneficiario) {
		this.localitaBeneficiario = localitaBeneficiario;
	}

	public String getProvinciaBeneficiario() {
		return provinciaBeneficiario;
	}

	public void setProvinciaBeneficiario(String provinciaBeneficiario) {
		this.provinciaBeneficiario = provinciaBeneficiario;
	}

	public String getNazioneBeneficiario() {
		return nazioneBeneficiario;
	}

	public void setNazioneBeneficiario(String nazioneBeneficiario) {
		this.nazioneBeneficiario = nazioneBeneficiario;
	}

	public String getAnagraficaPagatore() {
		return anagraficaPagatore;
	}

	public void setAnagraficaPagatore(String anagraficaPagatore) {
		this.anagraficaPagatore = anagraficaPagatore;
	}

	public String getIndirizzoPagatore() {
		return indirizzoPagatore;
	}

	public void setIndirizzoPagatore(String indirizzoPagatore) {
		this.indirizzoPagatore = indirizzoPagatore;
	}

	public String getCivicoPagatore() {
		return civicoPagatore;
	}

	public void setCivicoPagatore(String civicoPagatore) {
		this.civicoPagatore = civicoPagatore;
	}

	public String getCapPagatore() {
		return capPagatore;
	}

	public void setCapPagatore(String capPagatore) {
		this.capPagatore = capPagatore;
	}

	public String getLocalitaPagatore() {
		return localitaPagatore;
	}

	public void setLocalitaPagatore(String localitaPagatore) {
		this.localitaPagatore = localitaPagatore;
	}

	public String getProvinciaPagatore() {
		return provinciaPagatore;
	}

	public void setProvinciaPagatore(String provinciaPagatore) {
		this.provinciaPagatore = provinciaPagatore;
	}

	public String getNazionePagatore() {
		return nazionePagatore;
	}

	public void setNazionePagatore(String nazionePagatore) {
		this.nazionePagatore = nazionePagatore;
	}

	public String getCausaleVersamento() {
		return causaleVersamento;
	}

	public void setCausaleVersamento(String causaleVersamento) {
		this.causaleVersamento = causaleVersamento;
	}
	
	public void insert(Connection db) throws SQLException{
		PreparedStatement pst = db.prepareStatement("insert into pagopa_ricevute ("
				+ "id_pagamento, codice_esito_pagamento, esito_singolo_pagamento, identificativo_univoco_riscossione, singolo_importo_pagato, "
				+ "data_esito_singolo_pagamento, identificativo_messaggio_ricevuta, denominazione_attestante, denominazione_beneficiario, indirizzo_beneficiario, "
				+ "civico_beneficiario, cap_beneficiario, localita_beneficiario, provincia_beneficiario, nazione_beneficiario, "
				+ "anagrafica_pagatore, indirizzo_pagatore, civico_pagatore, cap_pagatore, localita_pagatore, "
				+ "provincia_pagatore, nazione_pagatore, causale_versamento, codice_contesto_pagamento, id_univoco_versamento, "
				+ "identificativo_dominio, riferimento_messaggio_richiesta, data_ricevuta, tipo_beneficiario, codice_univoco_beneficiario, "
				+ "tipo_pagatore, codice_univoco_pagatore, email_pagatore, tipo_attestante, codice_univoco_attestante, "
				+ "id_univoco_dovuto, dati_specifici_riscossione, riferimento_data_richiesta"
				+ ") values ("
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, "
				+ "?, ?, ?) returning id as id_inserito;");
		int i = 0; 
		
		pst.setInt(++i, idPagamento);
		pst.setString(++i, codiceEsitoPagamento);
		pst.setString(++i, esitoSingoloPagamento );
		pst.setString(++i, identificativoUnivocoRiscossione );
		pst.setString(++i, singoloImportoPagato);
		
		pst.setString(++i, dataEsitoSingoloPagamento);
		pst.setString(++i, identificativoMessaggioRicevuta);
		pst.setString(++i, denominazioneAttestante);
		pst.setString(++i, denominazioneBeneficiario);
		pst.setString(++i, indirizzoBeneficiario);
		
		pst.setString(++i, civicoBeneficiario);
		pst.setString(++i, capBeneficiario);
		pst.setString(++i, localitaBeneficiario);
		pst.setString(++i, provinciaBeneficiario);
		pst.setString(++i, nazioneBeneficiario);
		
		pst.setString(++i, anagraficaPagatore);
		pst.setString(++i, indirizzoPagatore);
		pst.setString(++i, civicoPagatore);
		pst.setString(++i, capPagatore);
		pst.setString(++i, localitaPagatore);
		
		pst.setString(++i, provinciaPagatore);
		pst.setString(++i, nazionePagatore);
		pst.setString(++i, causaleVersamento);
		pst.setString(++i, codiceContestoPagamento);
		pst.setString(++i, idUnivocoVersamento);
		
		pst.setString(++i, identificativoDominio);
		pst.setString(++i, riferimentoMessaggioRichiesta);
		pst.setString(++i, dataRicevuta);
		pst.setString(++i, tipoBeneficiario);
		pst.setString(++i, codiceUnivocoBeneficiario);
		
		pst.setString(++i, tipoPagatore);
		pst.setString(++i, codiceUnivocoPagatore);
		pst.setString(++i, emailPagatore);
		pst.setString(++i, tipoAttestante);
		pst.setString(++i, codiceUnivocoAttestante);
		
		pst.setString(++i, idUnivocoDovuto);
		pst.setString(++i, datiSpecificiRiscossione);
		pst.setString(++i, riferimentoDataRichiesta);

		ResultSet rs = pst.executeQuery();
		if (rs.next())
			this.id = rs.getInt("id_inserito");
		
	}


	public void buildRicevutaFromIdPagamento(Connection db, int idPagamento) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from pagopa_ricevute where id_pagamento = ? and trashed_date is null");
		int i = 0;
		pst.setInt(++i, idPagamento);
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			buildRecord(rs);
		
	}

	public String getCodiceContestoPagamento() {
		return codiceContestoPagamento;
	}

	public void setCodiceContestoPagamento(String codiceContestoPagamento) {
		this.codiceContestoPagamento = codiceContestoPagamento;
	}

	public String getIdUnivocoVersamento() {
		return idUnivocoVersamento;
	}

	public void setIdUnivocoVersamento(String idUnivocoVersamento) {
		this.idUnivocoVersamento = idUnivocoVersamento;
	}

	public String getIdentificativoDominio() {
		return identificativoDominio;
	}

	public void setIdentificativoDominio(String identificativoDominio) {
		this.identificativoDominio = identificativoDominio;
	}

	public String getRiferimentoMessaggioRichiesta() {
		return riferimentoMessaggioRichiesta;
	}

	public void setRiferimentoMessaggioRichiesta(String riferimentoMessaggioRichiesta) {
		this.riferimentoMessaggioRichiesta = riferimentoMessaggioRichiesta;
	}

	public String getDataRicevuta() {
		return dataRicevuta;
	}

	public void setDataRicevuta(String dataRicevuta) {
		this.dataRicevuta = dataRicevuta;
	}

	public String getTipoBeneficiario() {
		return tipoBeneficiario;
	}

	public void setTipoBeneficiario(String tipoBeneficiario) {
		this.tipoBeneficiario = tipoBeneficiario;
	}

	public String getCodiceUnivocoBeneficiario() {
		return codiceUnivocoBeneficiario;
	}

	public void setCodiceUnivocoBeneficiario(String codiceUnivocoBeneficiario) {
		this.codiceUnivocoBeneficiario = codiceUnivocoBeneficiario;
	}

	public String getTipoPagatore() {
		return tipoPagatore;
	}

	public void setTipoPagatore(String tipoPagatore) {
		this.tipoPagatore = tipoPagatore;
	}

	public String getCodiceUnivocoPagatore() {
		return codiceUnivocoPagatore;
	}

	public void setCodiceUnivocoPagatore(String codiceUnivocoPagatore) {
		this.codiceUnivocoPagatore = codiceUnivocoPagatore;
	}

	public String getEmailPagatore() {
		return emailPagatore;
	}

	public void setEmailPagatore(String emailPagatore) {
		this.emailPagatore = emailPagatore;
	}

	public String getTipoAttestante() {
		return tipoAttestante;
	}

	public void setTipoAttestante(String tipoAttestante) {
		this.tipoAttestante = tipoAttestante;
	}

	public String getCodiceUnivocoAttestante() {
		return codiceUnivocoAttestante;
	}

	public void setCodiceUnivocoAttestante(String codiceUnivocoAttestante) {
		this.codiceUnivocoAttestante = codiceUnivocoAttestante;
	}

	public String getIdUnivocoDovuto() {
		return idUnivocoDovuto;
	}

	public void setIdUnivocoDovuto(String idUnivocoDovuto) {
		this.idUnivocoDovuto = idUnivocoDovuto;
	}

	public String getDatiSpecificiRiscossione() {
		return datiSpecificiRiscossione;
	}

	public void setDatiSpecificiRiscossione(String datiSpecificiRiscossione) {
		this.datiSpecificiRiscossione = datiSpecificiRiscossione;
	}

	public String getRiferimentoDataRichiesta() {
		return riferimentoDataRichiesta;
	}

	public void setRiferimentoDataRichiesta(String riferimentoDataRichiesta) {
		this.riferimentoDataRichiesta = riferimentoDataRichiesta;
	}
}
