package org.aspcfs.modules.gestoriacquenew.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.DatabaseUtils;


/*questa classe e' una versione semplificata e riscritta per la nuova versione di gestori acque di rete (e per i loro controlli interni) della classe Ticket di acque di rete (il cavaliere originale
 * gestito dalle asl)*/

public class ControlloInterno {

	public Integer getStatusId() {
		return statusId;
	}
	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	
	public Integer getSiteId() {
		return siteId;
	}
	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAlfa() {
		return alfa;
	}
	public void setAlfa(String alfa) {
		this.alfa = alfa;
	}
	public String getBeta() {
		return beta;
	}
	public void setBeta(String beta) {
		this.beta = beta;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getTipoDecreto() {
		return tipoDecreto;
	}
	public void setTipoDecreto(String tipoDecreto) {
		this.tipoDecreto = tipoDecreto;
	}
	public String getDose() {
		return dose;
	}
	public void setDose(String dose) {
		this.dose = dose;
	}
	public String getRadon() {
		return radon;
	}
	public void setRadon(String radon) {
		this.radon = radon;
	}
	public String getTrizio() {
		return trizio;
	}
	public void setTrizio(String trizio) {
		this.trizio = trizio;
	}
	public Integer getIdControlloUfficiale() {
		return idControlloUfficiale;
	}
	public void setIdControlloUfficiale(Integer idControlloUfficiale) {
		this.idControlloUfficiale = idControlloUfficiale;
	}
	public Integer getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(Integer enteredBy) {
		this.enteredBy = enteredBy;
	}
	public Integer getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(Integer modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public Integer getTipologia() {
		return tipologia;
	}
	public void setTipologia(Integer tipologia) {
		this.tipologia = tipologia;
	}
	public Integer getTipoControllo() {
		return tipoControllo;
	}
	public void setTipoControllo(Integer tipoControllo) {
		this.tipoControllo = tipoControllo;
	}
	public Timestamp getDataInizioControllo() {
		return dataInizioControllo;
	}
	public void setDataInizioControllo(Timestamp dataInizioControllo) {
		this.dataInizioControllo = dataInizioControllo;
	}
	public Timestamp getDataFineControllo() {
		return dataFineControllo;
	}
	public void setDataFineControllo(Timestamp dataFineControllo) {
		this.dataFineControllo = dataFineControllo;
	}
//	public Integer getMotivoIspezione() {
//		return motivoIspezione;
//	}
//	public String getDescMotivoIspezione()
//	{
//		return descMotivoIspezione;
//	}
//	public void setDescMotivoIspezione(String s)
//	{
//		this.descMotivoIspezione = s;
//	}
	public String getDescAsl()
	{
		return this.descAsl;
	}
	public void setDescAsl(String s)
	{
		descAsl = s;
	}
//	public void setMotivoIspezione(Integer motivoIspezione) {
//		this.motivoIspezione = motivoIspezione;
//	}
//	public Integer getIdUnitaOperativa() {
//		return idUnitaOperativa;
//	}
//	public void setIdUnitaOperativa(Integer idUnitaOperativa) {
//		this.idUnitaOperativa = idUnitaOperativa;
//	}
	public Integer getOggettoIspezione() {
		return oggettoIspezione;
	}
	public void setOggettoIspezione(Integer oggettoIspezione) {
		this.oggettoIspezione = oggettoIspezione;
	}
	public Integer getIdComponenteNucleoIspettivo() {
		return idComponenteNucleoIspettivo;
	}
	public void setIdComponenteNucleoIspettivo(Integer idComponenteNucleoIspettivo) {
		this.idComponenteNucleoIspettivo = idComponenteNucleoIspettivo;
	}
	public String getTemperatura() {
		return temperatura;
	}
	public void setTemperatura(String temperatura) {
		this.temperatura = temperatura;
	}
	public String getCloro() {
		return cloro;
	}
	public void setCloro(String cloro) {
		this.cloro = cloro;
	}
	public String getOra() {
		return ora;
	}
	public void setOra(String ora) {
		this.ora = ora;
	}
	public String getAltro() {
		return altro;
	}
	public void setAltro(String altro) {
		this.altro = altro;
	}
	public boolean isProtocolloRoutine() {
		return protocolloRoutine;
	}
	public void setProtocolloRoutine(boolean protocolloRoutine) {
		this.protocolloRoutine = protocolloRoutine;
	}
	public boolean isProtocollVerifica() {
		return protocollVerifica;
	}
	public void setProtocollVerifica(boolean protocollVerifica) {
		this.protocollVerifica = protocollVerifica;
	}
	public boolean isProtocolloReplicaMicro() {
		return protocolloReplicaMicro;
	}
	public void setProtocolloReplicaMicro(boolean protocolloReplicaMicro) {
		this.protocolloReplicaMicro = protocolloReplicaMicro;
	}
	public boolean isProtocolloReplicaChim() {
		return protocolloReplicaChim;
	}
	public void setProtocolloReplicaChim(boolean protocolloReplicaChim) {
		this.protocolloReplicaChim = protocolloReplicaChim;
	}
	public boolean isProtocolloRadioattivita() {
		return protocolloRadioattivita;
	}
	public void setProtocolloRadioattivita(boolean protocolloRadioattivita) {
		this.protocolloRadioattivita = protocolloRadioattivita;
	}
	public boolean isProtocolloRicercaFitosanitari() {
		return protocolloRicercaFitosanitari;
	}
	public void setProtocolloRicercaFitosanitari(boolean protocolloRicercaFitosanitari) {
		this.protocolloRicercaFitosanitari = protocolloRicercaFitosanitari;
	}
	
	public void setPuntoPrelievoPadre(PuntoPrelievo pp)
	{
		this.puntoPrelievoPadre = pp;
	}
	public PuntoPrelievo getPuntoPrelievoPadre()
	{
		return this.puntoPrelievoPadre;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public String getNonConformita() {
		return nonConformita;
	}
	public void setNonConformita(String nonConformita) {
		this.nonConformita = nonConformita;
	}
	private Integer statusId ; 
	private Integer siteId;  
	private String alfa;
	private String beta; 
	private String dose; 
	private String radon; 
	private String trizio; 
	private Integer id; 
	private Integer idControlloUfficiale; /*la versione padded di id*/
	private Integer enteredBy;  
	private Integer modifiedBy; 
	private Integer tipologia;  
	private Integer tipoControllo; 
	private Timestamp dataInizioControllo;  
	private Timestamp dataFineControllo; 
//	private Integer motivoIspezione; 
//	private String descMotivoIspezione;
	private String descAsl;
//	private Integer idUnitaOperativa;  
	private Integer oggettoIspezione; 
	private Integer idComponenteNucleoIspettivo;
	private String tipoDecreto;
	private String temperatura;
	private String cloro;
	private String ora;
	private  String  altro;
	private String note;
	private boolean protocolloRoutine;
	private boolean protocollVerifica;
	private boolean protocolloReplicaMicro;
	private boolean protocolloReplicaChim;
	private boolean protocolloRadioattivita;
	private boolean protocolloRicercaFitosanitari;
	private String esito;
	

	private String nonConformita;
	private PuntoPrelievo puntoPrelievoPadre;

	private String campione_finalitaMisura;
	private String campione_notaFinalitaMisura;
	private String campione_motivoPrelievo;
	private String campione_notaMotivoPrelievo;

	private String fornitura_denominazioneZona;
	private String fornitura_denominazioneGestore;

	private String punto_tipoAcqua;
	private String punto_note;

	private String campionamento_numeroPrelievi;
	private String campionamento_chi;

	private String DI_alfaTotaleMar;
	private String DI_alfaTotaleMisura;
	private String DI_alfaTotaleIncertezza;
	private String DI_alfaTotaleDataMisura;
	private String DI_alfaTotaleLaboratorio;
	private String DI_alfaTotaleMetodoProva;

	private String DI_betaTotaleMar;
	private String DI_betaTotaleMisura;
	private String DI_betaTotaleIncertezza;
	private String DI_betaTotaleDataMisura;
	private String DI_betaTotaleLaboratorio;
	private String DI_betaTotaleMetodoProva;

	private String DI_betaResiduaMar;
	private String DI_betaResiduaMisura;
	private String DI_betaResiduaIncertezza;
	private String DI_betaResiduaDataMisura;
	private String DI_betaResiduaLaboratorio;
	private String DI_betaResiduaMetodoProva;

	private String Radon_concentrazioneMar;
	private String Radon_concentrazioneMisura;
	private String Radon_concentrazioneIncertezza;
	private String Radon_concentrazioneDataMisura;
	private String Radon_concentrazioneLaboratorio;
	private String Radon_concentrazioneMetodoProva;

	private String Trizio_concentrazioneMar;
	private String Trizio_concentrazioneMisura;
	private String Trizio_concentrazioneIncertezza;
	private String Trizio_concentrazioneDataMisura;
	private String Trizio_concentrazioneLaboratorio;
	private String Trizio_concentrazioneMetodoProva;
	
	//flusso 326 - campi nuovi
	
	private String idUnivocoCampione;
	private String codiceInternoLab;
	private String ambitoPrelievo;
	private String numeroPuntiPrelievo;
	private String numeroProgressivoPuntoPrelievo;
	private String numeroProgressivoPrelievoEffettuatoAnno;
	private String tipologiaPuntoPrelievo;
	private String codicePuntoPrelievo;
	private Integer comunePuntoPrelievo;
	private String indirizzoPuntoPrelievo;
	private String coordinateLatitudine;
	private String coordinateLongitudine;
	private String campioneNote;
	private String alfaTotale_superato;
	private String betaTotale_superato;
	private String betaResidua_superato;
	private String misureApprofondimento;
	
	private String DI_betaResiduoValoreDeterminato;
	private String DI_betaResiduoIncertezza;
	
	private String Radio226_concentrazioneMar;
	private String Radio226_concentrazioneMisura;
	private String Radio226_concentrazioneIncertezza;
	private String Radio226_concentrazioneDataMisura;
	private String Radio226_concentrazioneLaboratorio;
	private String Radio226_concentrazioneMetodoProva;
	private String Radio226_concentrazioneRapporto;
	
	private String Radio228_concentrazioneMar;
	private String Radio228_concentrazioneMisura;
	private String Radio228_concentrazioneIncertezza;
	private String Radio228_concentrazioneDataMisura;
	private String Radio228_concentrazioneLaboratorio;
	private String Radio228_concentrazioneMetodoProva;
	private String Radio228_concentrazioneRapporto;
	
	private String Uranio234_concentrazioneMar;
	private String Uranio234_concentrazioneMisura;
	private String Uranio234_concentrazioneIncertezza;
	private String Uranio234_concentrazioneDataMisura;
	private String Uranio234_concentrazioneLaboratorio;
	private String Uranio234_concentrazioneMetodoProva;
	private String Uranio234_concentrazioneRapporto;
	
	private String Uranio238_concentrazioneMar;
	private String Uranio238_concentrazioneMisura;
	private String Uranio238_concentrazioneIncertezza;
	private String Uranio238_concentrazioneDataMisura;
	private String Uranio238_concentrazioneLaboratorio;
	private String Uranio238_concentrazioneMetodoProva;
	private String Uranio238_concentrazioneRapporto;
	
	private String Piombo210_concentrazioneMar;
	private String Piombo210_concentrazioneMisura;
	private String Piombo210_concentrazioneIncertezza;
	private String Piombo210_concentrazioneDataMisura;
	private String Piombo210_concentrazioneLaboratorio;
	private String Piombo210_concentrazioneMetodoProva;
	private String Piombo210_concentrazioneRapporto;
	
	private String Polonio210_concentrazioneMar;
	private String Polonio210_concentrazioneMisura;
	private String Polonio210_concentrazioneIncertezza;
	private String Polonio210_concentrazioneDataMisura;
	private String Polonio210_concentrazioneLaboratorio;
	private String Polonio210_concentrazioneMetodoProva;
	private String Polonio210_concentrazioneRapporto;

	private String Radionuclide1_concentrazioneSimbolo;
	private String Radionuclide1_concentrazioneMar;
	private String Radionuclide1_concentrazioneMisura;
	private String Radionuclide1_concentrazioneIncertezza;
	private String Radionuclide1_concentrazioneDataMisura;
	private String Radionuclide1_concentrazioneLaboratorio;
	private String Radionuclide1_concentrazioneMetodoProva;
	private String Radionuclide1_concentrazioneDerivata;
	private String Radionuclide1_concentrazioneRapporto;
	
	private String Radionuclide2_concentrazioneSimbolo;
	private String Radionuclide2_concentrazioneMar;
	private String Radionuclide2_concentrazioneMisura;
	private String Radionuclide2_concentrazioneIncertezza;
	private String Radionuclide2_concentrazioneDataMisura;
	private String Radionuclide2_concentrazioneLaboratorio;
	private String Radionuclide2_concentrazioneMetodoProva;
	private String Radionuclide2_concentrazioneDerivata;
	private String Radionuclide2_concentrazioneRapporto;
	
	private String Radionuclide3_concentrazioneSimbolo;
	private String Radionuclide3_concentrazioneMar;
	private String Radionuclide3_concentrazioneMisura;
	private String Radionuclide3_concentrazioneIncertezza;
	private String Radionuclide3_concentrazioneDataMisura;
	private String Radionuclide3_concentrazioneLaboratorio;
	private String Radionuclide3_concentrazioneMetodoProva;
	private String Radionuclide3_concentrazioneDerivata;
	private String Radionuclide3_concentrazioneRapporto;
	
	private String DI_MSV_Inferiore;
	private String DI_MSV_Superiore;
	
	private String rapportoRa226;
	private String rapportoRa228;
	private String rapportoU234;
	private String rapportoU238;
	private String rapportoPb210;
	private String rapportoPo210;
	private String rapportoRN1;
	private String rapportoRN2;
	private String rapportoRN3;
	
	private String approfondimentoNote;
	
	//flusso 326 - getter & setter
	
	public String getIdUnivocoCampione() {
		return idUnivocoCampione;
	}
	public void setIdUnivocoCampione(String idUnivocoCampione) {
		this.idUnivocoCampione = idUnivocoCampione;
	}
	public String getCodiceInternoLab() {
		return codiceInternoLab;
	}
	public void setCodiceInternoLab(String codiceInternoLab) {
		this.codiceInternoLab = codiceInternoLab;
	}
	public String getAmbitoPrelievo() {
		return ambitoPrelievo;
	}
	public void setAmbitoPrelievo(String ambitoPrelievo) {
		this.ambitoPrelievo = ambitoPrelievo;
	}
	public String getNumeroPuntiPrelievo() {
		return numeroPuntiPrelievo;
	}
	public void setNumeroPuntiPrelievo(String numeroPuntiPrelievo) {
		this.numeroPuntiPrelievo = numeroPuntiPrelievo;
	}
	public String getNumeroProgressivoPuntoPrelievo() {
		return numeroProgressivoPuntoPrelievo;
	}
	public void setNumeroProgressivoPuntoPrelievo(String numeroProgressivoPuntoPrelievo) {
		this.numeroProgressivoPuntoPrelievo = numeroProgressivoPuntoPrelievo;
	}
	public String getNumeroProgressivoPrelievoEffettuatoAnno() {
		return numeroProgressivoPrelievoEffettuatoAnno;
	}
	public void setNumeroProgressivoPrelievoEffettuatoAnno(String numeroProgressivoPrelievoEffettuatoAnno) {
		this.numeroProgressivoPrelievoEffettuatoAnno = numeroProgressivoPrelievoEffettuatoAnno;
	}
	public String getTipologiaPuntoPrelievo() {
		return tipologiaPuntoPrelievo;
	}
	public void setTipologiaPuntoPrelievo(String tipologiaPuntoPrelievo) {
		this.tipologiaPuntoPrelievo = tipologiaPuntoPrelievo;
	}
	public String getCodicePuntoPrelievo() {
		return codicePuntoPrelievo;
	}
	public void setCodicePuntoPrelievo(String codicePuntoPrelievo) {
		this.codicePuntoPrelievo = codicePuntoPrelievo;
	}
	public Integer getComunePuntoPrelievo() {
		return comunePuntoPrelievo;
	}
	public void setComunePuntoPrelievo(Integer comunePuntoPrelievo) {
		this.comunePuntoPrelievo = comunePuntoPrelievo;
	}
	public String getIndirizzoPuntoPrelievo() {
		return indirizzoPuntoPrelievo;
	}
	public void setIndirizzoPuntoPrelievo(String indirizzoPuntoPrelievo) {
		this.indirizzoPuntoPrelievo = indirizzoPuntoPrelievo;
	}
	public String getCoordinateLatitudine() {
		return coordinateLatitudine;
	}
	public void setCoordinateLatitudine(String coordinateLatitudine) {
		this.coordinateLatitudine = coordinateLatitudine;
	}
	public String getCoordinateLongitudine() {
		return coordinateLongitudine;
	}
	public void setCoordinateLongitudine(String coordinateLongitudine) {
		this.coordinateLongitudine = coordinateLongitudine;
	}
	public String getCampioneNote() {
		return campioneNote;
	}
	public void setCampioneNote(String campioneNote) {
		this.campioneNote = campioneNote;
	}
	public String getAlfaTotale_superato() {
		return alfaTotale_superato;
	}
	public void setAlfaTotale_superato(String alfaTotale_superato) {
		this.alfaTotale_superato = alfaTotale_superato;
	}
	public String getBetaTotale_superato() {
		return betaTotale_superato;
	}
	public void setBetaTotale_superato(String betaTotale_superato) {
		this.betaTotale_superato = betaTotale_superato;
	}
	public String getBetaResidua_superato() {
		return betaResidua_superato;
	}
	public void setBetaResidua_superato(String betaResidua_superato) {
		this.betaResidua_superato = betaResidua_superato;
	}
	public String getMisureApprofondimento() {
		return misureApprofondimento;
	}
	public void setMisureApprofondimento(String misureApprofondimento) {
		this.misureApprofondimento = misureApprofondimento;
	}
	public String getDI_betaResiduoValoreDeterminato() {
		return DI_betaResiduoValoreDeterminato;
	}
	public void setDI_betaResiduoValoreDeterminato(String dI_betaResiduoValoreDeterminato) {
		DI_betaResiduoValoreDeterminato = dI_betaResiduoValoreDeterminato;
	}
	public String getDI_betaResiduoIncertezza() {
		return DI_betaResiduoIncertezza;
	}
	public void setDI_betaResiduoIncertezza(String dI_betaResiduoIncertezza) {
		DI_betaResiduoIncertezza = dI_betaResiduoIncertezza;
	}
	public String getRadio226_concentrazioneMar() {
		return Radio226_concentrazioneMar;
	}
	public void setRadio226_concentrazioneMar(String radio226_concentrazioneMar) {
		Radio226_concentrazioneMar = radio226_concentrazioneMar;
	}
	public String getRadio226_concentrazioneMisura() {
		return Radio226_concentrazioneMisura;
	}
	public void setRadio226_concentrazioneMisura(String radio226_concentrazioneMisura) {
		Radio226_concentrazioneMisura = radio226_concentrazioneMisura;
	}
	public String getRadio226_concentrazioneIncertezza() {
		return Radio226_concentrazioneIncertezza;
	}
	public void setRadio226_concentrazioneIncertezza(String radio226_concentrazioneIncertezza) {
		Radio226_concentrazioneIncertezza = radio226_concentrazioneIncertezza;
	}
	public String getRadio226_concentrazioneDataMisura() {
		return Radio226_concentrazioneDataMisura;
	}
	public void setRadio226_concentrazioneDataMisura(String radio226_concentrazioneDataMisura) {
		Radio226_concentrazioneDataMisura = radio226_concentrazioneDataMisura;
	}
	public String getRadio226_concentrazioneLaboratorio() {
		return Radio226_concentrazioneLaboratorio;
	}
	public void setRadio226_concentrazioneLaboratorio(String radio226_concentrazioneLaboratorio) {
		Radio226_concentrazioneLaboratorio = radio226_concentrazioneLaboratorio;
	}
	public String getRadio226_concentrazioneMetodoProva() {
		return Radio226_concentrazioneMetodoProva;
	}
	public void setRadio226_concentrazioneMetodoProva(String radio226_concentrazioneMetodoProva) {
		Radio226_concentrazioneMetodoProva = radio226_concentrazioneMetodoProva;
	}
	public String getRadio226_concentrazioneRapporto() {
		return Radio226_concentrazioneRapporto;
	}
	public void setRadio226_concentrazioneRapporto(String radio226_concentrazioneRapporto) {
		Radio226_concentrazioneRapporto = radio226_concentrazioneRapporto;
	}
	public String getRadio228_concentrazioneMar() {
		return Radio228_concentrazioneMar;
	}
	public void setRadio228_concentrazioneMar(String radio228_concentrazioneMar) {
		Radio228_concentrazioneMar = radio228_concentrazioneMar;
	}
	public String getRadio228_concentrazioneMisura() {
		return Radio228_concentrazioneMisura;
	}
	public void setRadio228_concentrazioneMisura(String radio228_concentrazioneMisura) {
		Radio228_concentrazioneMisura = radio228_concentrazioneMisura;
	}
	public String getRadio228_concentrazioneIncertezza() {
		return Radio228_concentrazioneIncertezza;
	}
	public void setRadio228_concentrazioneIncertezza(String radio228_concentrazioneIncertezza) {
		Radio228_concentrazioneIncertezza = radio228_concentrazioneIncertezza;
	}
	public String getRadio228_concentrazioneDataMisura() {
		return Radio228_concentrazioneDataMisura;
	}
	public void setRadio228_concentrazioneDataMisura(String radio228_concentrazioneDataMisura) {
		Radio228_concentrazioneDataMisura = radio228_concentrazioneDataMisura;
	}
	public String getRadio228_concentrazioneLaboratorio() {
		return Radio228_concentrazioneLaboratorio;
	}
	public void setRadio228_concentrazioneLaboratorio(String radio228_concentrazioneLaboratorio) {
		Radio228_concentrazioneLaboratorio = radio228_concentrazioneLaboratorio;
	}
	public String getRadio228_concentrazioneMetodoProva() {
		return Radio228_concentrazioneMetodoProva;
	}
	public void setRadio228_concentrazioneMetodoProva(String radio228_concentrazioneMetodoProva) {
		Radio228_concentrazioneMetodoProva = radio228_concentrazioneMetodoProva;
	}
	public String getRadio228_concentrazioneRapporto() {
		return Radio228_concentrazioneRapporto;
	}
	public void setRadio228_concentrazioneRapporto(String radio228_concentrazioneRapporto) {
		Radio228_concentrazioneRapporto = radio228_concentrazioneRapporto;
	}
	public String getUranio234_concentrazioneMar() {
		return Uranio234_concentrazioneMar;
	}
	public void setUranio234_concentrazioneMar(String uranio234_concentrazioneMar) {
		Uranio234_concentrazioneMar = uranio234_concentrazioneMar;
	}
	public String getUranio234_concentrazioneMisura() {
		return Uranio234_concentrazioneMisura;
	}
	public void setUranio234_concentrazioneMisura(String uranio234_concentrazioneMisura) {
		Uranio234_concentrazioneMisura = uranio234_concentrazioneMisura;
	}
	public String getUranio234_concentrazioneIncertezza() {
		return Uranio234_concentrazioneIncertezza;
	}
	public void setUranio234_concentrazioneIncertezza(String uranio234_concentrazioneIncertezza) {
		Uranio234_concentrazioneIncertezza = uranio234_concentrazioneIncertezza;
	}
	public String getUranio234_concentrazioneDataMisura() {
		return Uranio234_concentrazioneDataMisura;
	}
	public void setUranio234_concentrazioneDataMisura(String uranio234_concentrazioneDataMisura) {
		Uranio234_concentrazioneDataMisura = uranio234_concentrazioneDataMisura;
	}
	public String getUranio234_concentrazioneLaboratorio() {
		return Uranio234_concentrazioneLaboratorio;
	}
	public void setUranio234_concentrazioneLaboratorio(String uranio234_concentrazioneLaboratorio) {
		Uranio234_concentrazioneLaboratorio = uranio234_concentrazioneLaboratorio;
	}
	public String getUranio234_concentrazioneMetodoProva() {
		return Uranio234_concentrazioneMetodoProva;
	}
	public void setUranio234_concentrazioneMetodoProva(String uranio234_concentrazioneMetodoProva) {
		Uranio234_concentrazioneMetodoProva = uranio234_concentrazioneMetodoProva;
	}
	public String getUranio234_concentrazioneRapporto() {
		return Uranio234_concentrazioneRapporto;
	}
	public void setUranio234_concentrazioneRapporto(String uranio234_concentrazioneRapporto) {
		Uranio234_concentrazioneRapporto = uranio234_concentrazioneRapporto;
	}
	public String getUranio238_concentrazioneMar() {
		return Uranio238_concentrazioneMar;
	}
	public void setUranio238_concentrazioneMar(String uranio238_concentrazioneMar) {
		Uranio238_concentrazioneMar = uranio238_concentrazioneMar;
	}
	public String getUranio238_concentrazioneMisura() {
		return Uranio238_concentrazioneMisura;
	}
	public void setUranio238_concentrazioneMisura(String uranio238_concentrazioneMisura) {
		Uranio238_concentrazioneMisura = uranio238_concentrazioneMisura;
	}
	public String getUranio238_concentrazioneIncertezza() {
		return Uranio238_concentrazioneIncertezza;
	}
	public void setUranio238_concentrazioneIncertezza(String uranio238_concentrazioneIncertezza) {
		Uranio238_concentrazioneIncertezza = uranio238_concentrazioneIncertezza;
	}
	public String getUranio238_concentrazioneDataMisura() {
		return Uranio238_concentrazioneDataMisura;
	}
	public void setUranio238_concentrazioneDataMisura(String uranio238_concentrazioneDataMisura) {
		Uranio238_concentrazioneDataMisura = uranio238_concentrazioneDataMisura;
	}
	public String getUranio238_concentrazioneLaboratorio() {
		return Uranio238_concentrazioneLaboratorio;
	}
	public void setUranio238_concentrazioneLaboratorio(String uranio238_concentrazioneLaboratorio) {
		Uranio238_concentrazioneLaboratorio = uranio238_concentrazioneLaboratorio;
	}
	public String getUranio238_concentrazioneMetodoProva() {
		return Uranio238_concentrazioneMetodoProva;
	}
	public void setUranio238_concentrazioneMetodoProva(String uranio238_concentrazioneMetodoProva) {
		Uranio238_concentrazioneMetodoProva = uranio238_concentrazioneMetodoProva;
	}
	public String getUranio238_concentrazioneRapporto() {
		return Uranio238_concentrazioneRapporto;
	}
	public void setUranio238_concentrazioneRapporto(String uranio238_concentrazioneRapporto) {
		Uranio238_concentrazioneRapporto = uranio238_concentrazioneRapporto;
	}
	public String getPiombo210_concentrazioneMar() {
		return Piombo210_concentrazioneMar;
	}
	public void setPiombo210_concentrazioneMar(String piombo210_concentrazioneMar) {
		Piombo210_concentrazioneMar = piombo210_concentrazioneMar;
	}
	public String getPiombo210_concentrazioneMisura() {
		return Piombo210_concentrazioneMisura;
	}
	public void setPiombo210_concentrazioneMisura(String piombo210_concentrazioneMisura) {
		Piombo210_concentrazioneMisura = piombo210_concentrazioneMisura;
	}
	public String getPiombo210_concentrazioneIncertezza() {
		return Piombo210_concentrazioneIncertezza;
	}
	public void setPiombo210_concentrazioneIncertezza(String piombo210_concentrazioneIncertezza) {
		Piombo210_concentrazioneIncertezza = piombo210_concentrazioneIncertezza;
	}
	public String getPiombo210_concentrazioneDataMisura() {
		return Piombo210_concentrazioneDataMisura;
	}
	public void setPiombo210_concentrazioneDataMisura(String piombo210_concentrazioneDataMisura) {
		Piombo210_concentrazioneDataMisura = piombo210_concentrazioneDataMisura;
	}
	public String getPiombo210_concentrazioneLaboratorio() {
		return Piombo210_concentrazioneLaboratorio;
	}
	public void setPiombo210_concentrazioneLaboratorio(String piombo210_concentrazioneLaboratorio) {
		Piombo210_concentrazioneLaboratorio = piombo210_concentrazioneLaboratorio;
	}
	public String getPiombo210_concentrazioneMetodoProva() {
		return Piombo210_concentrazioneMetodoProva;
	}
	public void setPiombo210_concentrazioneMetodoProva(String piombo210_concentrazioneMetodoProva) {
		Piombo210_concentrazioneMetodoProva = piombo210_concentrazioneMetodoProva;
	}
	public String getPiombo210_concentrazioneRapporto() {
		return Piombo210_concentrazioneRapporto;
	}
	public void setPiombo210_concentrazioneRapporto(String piombo210_concentrazioneRapporto) {
		Piombo210_concentrazioneRapporto = piombo210_concentrazioneRapporto;
	}
	public String getPolonio210_concentrazioneMar() {
		return Polonio210_concentrazioneMar;
	}
	public void setPolonio210_concentrazioneMar(String polonio210_concentrazioneMar) {
		Polonio210_concentrazioneMar = polonio210_concentrazioneMar;
	}
	public String getPolonio210_concentrazioneMisura() {
		return Polonio210_concentrazioneMisura;
	}
	public void setPolonio210_concentrazioneMisura(String polonio210_concentrazioneMisura) {
		Polonio210_concentrazioneMisura = polonio210_concentrazioneMisura;
	}
	public String getPolonio210_concentrazioneIncertezza() {
		return Polonio210_concentrazioneIncertezza;
	}
	public void setPolonio210_concentrazioneIncertezza(String polonio210_concentrazioneIncertezza) {
		Polonio210_concentrazioneIncertezza = polonio210_concentrazioneIncertezza;
	}
	public String getPolonio210_concentrazioneDataMisura() {
		return Polonio210_concentrazioneDataMisura;
	}
	public void setPolonio210_concentrazioneDataMisura(String polonio210_concentrazioneDataMisura) {
		Polonio210_concentrazioneDataMisura = polonio210_concentrazioneDataMisura;
	}
	public String getPolonio210_concentrazioneLaboratorio() {
		return Polonio210_concentrazioneLaboratorio;
	}
	public void setPolonio210_concentrazioneLaboratorio(String polonio210_concentrazioneLaboratorio) {
		Polonio210_concentrazioneLaboratorio = polonio210_concentrazioneLaboratorio;
	}
	public String getPolonio210_concentrazioneMetodoProva() {
		return Polonio210_concentrazioneMetodoProva;
	}
	public void setPolonio210_concentrazioneMetodoProva(String polonio210_concentrazioneMetodoProva) {
		Polonio210_concentrazioneMetodoProva = polonio210_concentrazioneMetodoProva;
	}
	public String getPolonio210_concentrazioneRapporto() {
		return Polonio210_concentrazioneRapporto;
	}
	public void setPolonio210_concentrazioneRapporto(String polonio210_concentrazioneRapporto) {
		Polonio210_concentrazioneRapporto = polonio210_concentrazioneRapporto;
	}
	public String getRadionuclide1_concentrazioneSimbolo() {
		return Radionuclide1_concentrazioneSimbolo;
	}
	public void setRadionuclide1_concentrazioneSimbolo(String radionuclide1_concentrazioneSimbolo) {
		Radionuclide1_concentrazioneSimbolo = radionuclide1_concentrazioneSimbolo;
	}
	public String getRadionuclide1_concentrazioneMar() {
		return Radionuclide1_concentrazioneMar;
	}
	public void setRadionuclide1_concentrazioneMar(String radionuclide1_concentrazioneMar) {
		Radionuclide1_concentrazioneMar = radionuclide1_concentrazioneMar;
	}
	public String getRadionuclide1_concentrazioneMisura() {
		return Radionuclide1_concentrazioneMisura;
	}
	public void setRadionuclide1_concentrazioneMisura(String radionuclide1_concentrazioneMisura) {
		Radionuclide1_concentrazioneMisura = radionuclide1_concentrazioneMisura;
	}
	public String getRadionuclide1_concentrazioneIncertezza() {
		return Radionuclide1_concentrazioneIncertezza;
	}
	public void setRadionuclide1_concentrazioneIncertezza(String radionuclide1_concentrazioneIncertezza) {
		Radionuclide1_concentrazioneIncertezza = radionuclide1_concentrazioneIncertezza;
	}
	public String getRadionuclide1_concentrazioneDataMisura() {
		return Radionuclide1_concentrazioneDataMisura;
	}
	public void setRadionuclide1_concentrazioneDataMisura(String radionuclide1_concentrazioneDataMisura) {
		Radionuclide1_concentrazioneDataMisura = radionuclide1_concentrazioneDataMisura;
	}
	public String getRadionuclide1_concentrazioneLaboratorio() {
		return Radionuclide1_concentrazioneLaboratorio;
	}
	public void setRadionuclide1_concentrazioneLaboratorio(String radionuclide1_concentrazioneLaboratorio) {
		Radionuclide1_concentrazioneLaboratorio = radionuclide1_concentrazioneLaboratorio;
	}
	public String getRadionuclide1_concentrazioneMetodoProva() {
		return Radionuclide1_concentrazioneMetodoProva;
	}
	public void setRadionuclide1_concentrazioneMetodoProva(String radionuclide1_concentrazioneMetodoProva) {
		Radionuclide1_concentrazioneMetodoProva = radionuclide1_concentrazioneMetodoProva;
	}
	public String getRadionuclide1_concentrazioneDerivata() {
		return Radionuclide1_concentrazioneDerivata;
	}
	public void setRadionuclide1_concentrazioneDerivata(String radionuclide1_concentrazioneDerivata) {
		Radionuclide1_concentrazioneDerivata = radionuclide1_concentrazioneDerivata;
	}
	public String getRadionuclide1_concentrazioneRapporto() {
		return Radionuclide1_concentrazioneRapporto;
	}
	public void setRadionuclide1_concentrazioneRapporto(String radionuclide1_concentrazioneRapporto) {
		Radionuclide1_concentrazioneRapporto = radionuclide1_concentrazioneRapporto;
	}
	public String getRadionuclide2_concentrazioneSimbolo() {
		return Radionuclide2_concentrazioneSimbolo;
	}
	public void setRadionuclide2_concentrazioneSimbolo(String radionuclide2_concentrazioneSimbolo) {
		Radionuclide2_concentrazioneSimbolo = radionuclide2_concentrazioneSimbolo;
	}
	public String getRadionuclide2_concentrazioneMar() {
		return Radionuclide2_concentrazioneMar;
	}
	public void setRadionuclide2_concentrazioneMar(String radionuclide2_concentrazioneMar) {
		Radionuclide2_concentrazioneMar = radionuclide2_concentrazioneMar;
	}
	public String getRadionuclide2_concentrazioneMisura() {
		return Radionuclide2_concentrazioneMisura;
	}
	public void setRadionuclide2_concentrazioneMisura(String radionuclide2_concentrazioneMisura) {
		Radionuclide2_concentrazioneMisura = radionuclide2_concentrazioneMisura;
	}
	public String getRadionuclide2_concentrazioneIncertezza() {
		return Radionuclide2_concentrazioneIncertezza;
	}
	public void setRadionuclide2_concentrazioneIncertezza(String radionuclide2_concentrazioneIncertezza) {
		Radionuclide2_concentrazioneIncertezza = radionuclide2_concentrazioneIncertezza;
	}
	public String getRadionuclide2_concentrazioneDataMisura() {
		return Radionuclide2_concentrazioneDataMisura;
	}
	public void setRadionuclide2_concentrazioneDataMisura(String radionuclide2_concentrazioneDataMisura) {
		Radionuclide2_concentrazioneDataMisura = radionuclide2_concentrazioneDataMisura;
	}
	public String getRadionuclide2_concentrazioneLaboratorio() {
		return Radionuclide2_concentrazioneLaboratorio;
	}
	public void setRadionuclide2_concentrazioneLaboratorio(String radionuclide2_concentrazioneLaboratorio) {
		Radionuclide2_concentrazioneLaboratorio = radionuclide2_concentrazioneLaboratorio;
	}
	public String getRadionuclide2_concentrazioneMetodoProva() {
		return Radionuclide2_concentrazioneMetodoProva;
	}
	public void setRadionuclide2_concentrazioneMetodoProva(String radionuclide2_concentrazioneMetodoProva) {
		Radionuclide2_concentrazioneMetodoProva = radionuclide2_concentrazioneMetodoProva;
	}
	public String getRadionuclide2_concentrazioneDerivata() {
		return Radionuclide2_concentrazioneDerivata;
	}
	public void setRadionuclide2_concentrazioneDerivata(String radionuclide2_concentrazioneDerivata) {
		Radionuclide2_concentrazioneDerivata = radionuclide2_concentrazioneDerivata;
	}
	public String getRadionuclide2_concentrazioneRapporto() {
		return Radionuclide2_concentrazioneRapporto;
	}
	public void setRadionuclide2_concentrazioneRapporto(String radionuclide2_concentrazioneRapporto) {
		Radionuclide2_concentrazioneRapporto = radionuclide2_concentrazioneRapporto;
	}
	public String getRadionuclide3_concentrazioneSimbolo() {
		return Radionuclide3_concentrazioneSimbolo;
	}
	public void setRadionuclide3_concentrazioneSimbolo(String radionuclide3_concentrazioneSimbolo) {
		Radionuclide3_concentrazioneSimbolo = radionuclide3_concentrazioneSimbolo;
	}
	public String getRadionuclide3_concentrazioneMar() {
		return Radionuclide3_concentrazioneMar;
	}
	public void setRadionuclide3_concentrazioneMar(String radionuclide3_concentrazioneMar) {
		Radionuclide3_concentrazioneMar = radionuclide3_concentrazioneMar;
	}
	public String getRadionuclide3_concentrazioneMisura() {
		return Radionuclide3_concentrazioneMisura;
	}
	public void setRadionuclide3_concentrazioneMisura(String radionuclide3_concentrazioneMisura) {
		Radionuclide3_concentrazioneMisura = radionuclide3_concentrazioneMisura;
	}
	public String getRadionuclide3_concentrazioneIncertezza() {
		return Radionuclide3_concentrazioneIncertezza;
	}
	public void setRadionuclide3_concentrazioneIncertezza(String radionuclide3_concentrazioneIncertezza) {
		Radionuclide3_concentrazioneIncertezza = radionuclide3_concentrazioneIncertezza;
	}
	public String getRadionuclide3_concentrazioneDataMisura() {
		return Radionuclide3_concentrazioneDataMisura;
	}
	public void setRadionuclide3_concentrazioneDataMisura(String radionuclide3_concentrazioneDataMisura) {
		Radionuclide3_concentrazioneDataMisura = radionuclide3_concentrazioneDataMisura;
	}
	public String getRadionuclide3_concentrazioneLaboratorio() {
		return Radionuclide3_concentrazioneLaboratorio;
	}
	public void setRadionuclide3_concentrazioneLaboratorio(String radionuclide3_concentrazioneLaboratorio) {
		Radionuclide3_concentrazioneLaboratorio = radionuclide3_concentrazioneLaboratorio;
	}
	public String getRadionuclide3_concentrazioneMetodoProva() {
		return Radionuclide3_concentrazioneMetodoProva;
	}
	public void setRadionuclide3_concentrazioneMetodoProva(String radionuclide3_concentrazioneMetodoProva) {
		Radionuclide3_concentrazioneMetodoProva = radionuclide3_concentrazioneMetodoProva;
	}
	public String getRadionuclide3_concentrazioneDerivata() {
		return Radionuclide3_concentrazioneDerivata;
	}
	public void setRadionuclide3_concentrazioneDerivata(String radionuclide3_concentrazioneDerivata) {
		Radionuclide3_concentrazioneDerivata = radionuclide3_concentrazioneDerivata;
	}
	public String getRadionuclide3_concentrazioneRapporto() {
		return Radionuclide3_concentrazioneRapporto;
	}
	public void setRadionuclide3_concentrazioneRapporto(String radionuclide3_concentrazioneRapporto) {
		Radionuclide3_concentrazioneRapporto = radionuclide3_concentrazioneRapporto;
	}
	public String getDI_MSV_Inferiore() {
		return DI_MSV_Inferiore;
	}
	public void setDI_MSV_Inferiore(String dI_MSV_Inferiore) {
		DI_MSV_Inferiore = dI_MSV_Inferiore;
	}
	public String getDI_MSV_Superiore() {
		return DI_MSV_Superiore;
	}
	public void setDI_MSV_Superiore(String dI_MSV_Superiore) {
		DI_MSV_Superiore = dI_MSV_Superiore;
	}
	public String getRapportoRa226() {
		return rapportoRa226;
	}
	public void setRapportoRa226(String rapportoRa226) {
		this.rapportoRa226 = rapportoRa226;
	}
	public String getRapportoRa228() {
		return rapportoRa228;
	}
	public void setRapportoRa228(String rapportoRa228) {
		this.rapportoRa228 = rapportoRa228;
	}
	public String getRapportoU234() {
		return rapportoU234;
	}
	public void setRapportoU234(String rapportoU234) {
		this.rapportoU234 = rapportoU234;
	}
	public String getRapportoU238() {
		return rapportoU238;
	}
	public void setRapportoU238(String rapportoU238) {
		this.rapportoU238 = rapportoU238;
	}
	public String getRapportoPb210() {
		return rapportoPb210;
	}
	public void setRapportoPb210(String rapportoPb210) {
		this.rapportoPb210 = rapportoPb210;
	}
	public String getRapportoPo210() {
		return rapportoPo210;
	}
	public void setRapportoPo210(String rapportoPo210) {
		this.rapportoPo210 = rapportoPo210;
	}
	public String getRapportoRN1() {
		return rapportoRN1;
	}
	public void setRapportoRN1(String rapportoRN1) {
		this.rapportoRN1 = rapportoRN1;
	}
	public String getRapportoRN2() {
		return rapportoRN2;
	}
	public void setRapportoRN2(String rapportoRN2) {
		this.rapportoRN2 = rapportoRN2;
	}
	public String getRapportoRN3() {
		return rapportoRN3;
	}
	public void setRapportoRN3(String rapportoRN3) {
		this.rapportoRN3 = rapportoRN3;
	}
	public String getApprofondimentoNote() {
		return approfondimentoNote;
	}
	public void setApprofondimentoNote(String approfondimentoNote) {
		this.approfondimentoNote = approfondimentoNote;
	}
	
	public static int getCodeFromLookupDesc(Connection db, String lookup, String codeField, String descField, String descValue, String condAggiuntiva) throws EccezioneDati,Exception
	{
		PreparedStatement pst = null;
		ResultSet rs = null;
		int toRet = -1;
		try
		{
			String query ="select :codefield: from :lookup: where lower(:descfield:) = lower(?) and "+(condAggiuntiva != null && condAggiuntiva.length() > 0 ? condAggiuntiva : "1=1");
			query = query.replace(":codefield:", codeField);
			query = query.replace(":lookup:", lookup);
			query = query.replace(":descfield:",descField);
			
			pst = db.prepareStatement(query);
			pst.setString(1, descValue);
			rs = pst.executeQuery();
			if(rs.next())
			{
				toRet = rs.getInt(1);
			}
			else
				throw new EccezioneDati("Codice Non trovato per lookup "+lookup);
		}
		catch(Exception ex)
		{
			//ex.printStackTrace();
			throw ex;
		}
		finally
		{
			try {rs.close();} catch(Exception ex){}
			try {pst.close();} catch(Exception ex){}
		}
		return toRet;
	}
	
	public static int getCodeFromLookupDesc(Connection db, String lookup, String codeField, String descField, String descValue, String condAggiuntiva, String colonna) throws EccezioneDati,Exception
	{
		PreparedStatement pst = null;
		ResultSet rs = null;
		int toRet = -1;
		try
		{
			String query ="select :codefield: from :lookup: where lower(:descfield:) = lower(?) and "+(condAggiuntiva != null && condAggiuntiva.length() > 0 ? condAggiuntiva : "1=1");
			query = query.replace(":codefield:", codeField);
			query = query.replace(":lookup:", lookup);
			query = query.replace(":descfield:",descField);
			
			pst = db.prepareStatement(query);
			pst.setString(1, descValue);
			rs = pst.executeQuery();
			if(rs.next())
			{
				toRet = rs.getInt(1);
			}
			else
				throw new EccezioneDati("Valore della colonna '"+ colonna.toUpperCase()+ "' non valido.");
		}
		catch(Exception ex)
		{
			//ex.printStackTrace();
			throw ex;
		}
		finally
		{
			try {rs.close();} catch(Exception ex){}
			try {pst.close();} catch(Exception ex){}
		}
		return toRet;
	}
	
	
	public static String getDescFromLookupCode(Connection db, String lookup, String codeField, String descField, int codeValue, String condAggiuntiva ) throws EccezioneDati,Exception
	{
		PreparedStatement pst = null;
		ResultSet rs = null;
		String toRet = null;
		try
		{
			String query ="select :descfield: from :lookup: where :codefield: = ? and "+(condAggiuntiva != null && condAggiuntiva.length() > 0 ? condAggiuntiva : "1=1");
			query = query.replace(":codefield:", codeField);
			query = query.replace(":lookup:", lookup);
			query = query.replace(":descfield:",descField);
			
			pst = db.prepareStatement(query);
			pst.setInt(1, codeValue);
			rs = pst.executeQuery();
			if(rs.next())
			{
				toRet = rs.getString(1);
			}
			else
				throw new EccezioneDati("Descrizione lookup non trovata");
		}
		catch(Exception ex)
		{
//			ex.printStackTrace();
			throw ex;
		}
		finally
		{
			try {rs.close();} catch(Exception ex){}
			try {pst.close();} catch(Exception ex){}
		}
		return toRet;
	}
	
	public static List<ControlloInterno> buildList(ResultSet rs) throws SQLException
	{
		ArrayList<ControlloInterno> toReturn = new ArrayList<ControlloInterno>();
		
		while(rs.next())
		{
			toReturn.add(ControlloInterno.build(rs));
		}
		
		return toReturn;
		
	}
	
	
	public static ControlloInterno build(ResultSet rs)
	{
		ControlloInterno toRet = new ControlloInterno();
		try{toRet.setStatusId(rs.getInt("status_id"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setSiteId(rs.getInt("site_id"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setId(rs.getInt("ticketid"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setEnteredBy(rs.getInt("enteredby"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setModifiedBy(rs.getInt("modifiedby"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setTipologia(rs.getInt("tipologia"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setTipoControllo(rs.getInt("provvedimenti_prescrittivi"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setDataInizioControllo(rs.getTimestamp("assigned_date"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setDataFineControllo(rs.getTimestamp("data_fine_controllo"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setOggettoIspezione(rs.getInt("ispezione"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setOra(rs.getString("ore"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setIdControlloUfficiale(rs.getInt("id_controllo_ufficiale"));} catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setProtocolloRadioattivita(rs.getBoolean("prot_radioattivita")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setProtocolloReplicaChim(rs.getBoolean("prot_replica_chim")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setProtocolloReplicaMicro(rs.getBoolean("prot_replica_micro")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setProtocolloRicercaFitosanitari(rs.getBoolean("prot_ricerca_fitosanitari")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setProtocolloRoutine(rs.getBoolean("prot_routine")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setProtocollVerifica(rs.getBoolean("prot_verifica")); } catch( Exception ex ) { ex.printStackTrace(); } 
		try{toRet.setDescAsl(rs.getString("desc_asl")); } catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setCloro(rs.getString("cloro")); } catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setTemperatura(rs.getString("temperatura")); } catch( Exception ex ) { ex.printStackTrace(); }
//		try{toRet.setDescMotivoIspezione(rs.getString("desc_motivo_ispezione")); } catch( Exception ex ) { ex.printStackTrace(); }
		try{toRet.setEsito(rs.getString("esito"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setNonConformita(rs.getString("nonconformitaformali"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio(rs.getString("trizio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setAlfa(rs.getString("alfa"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setBeta(rs.getString("beta"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDose(rs.getString("dose"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon(rs.getString("radon"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTipoDecreto(rs.getString("tipo_decreto"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setAltro(rs.getString("altro"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setNote(rs.getString("note"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setCampione_finalitaMisura(rs.getString("campione_finalita_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCampione_notaFinalitaMisura(rs.getString("campione_nota_finalita_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCampione_motivoPrelievo(rs.getString("campione_motivo_prelievo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCampione_notaMotivoPrelievo(rs.getString("campione_nota_motivo_prelievo"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setFornitura_denominazioneZona(rs.getString("fornitura_denominazione_zona"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setFornitura_denominazioneGestore(rs.getString("fornitura_denominazione_gestore"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setPunto_tipoAcqua(rs.getString("punto_tipo_acqua"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPunto_note(rs.getString("punto_note"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setCampionamento_numeroPrelievi(rs.getString("campionamento_numero_prelievi"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCampionamento_chi(rs.getString("campionamento_chi"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setDI_alfaTotaleMar(rs.getString("di_alfa_totale_mar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_alfaTotaleMisura(rs.getString("di_alfa_totale_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_alfaTotaleIncertezza(rs.getString("di_alfa_totale_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_alfaTotaleDataMisura(rs.getString("di_alfa_totale_data_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_alfaTotaleLaboratorio(rs.getString("di_alfa_totale_laboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_alfaTotaleMetodoProva(rs.getString("di_alfa_totale_metodo_prova"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setDI_betaTotaleMar(rs.getString("di_beta_totale_mar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaTotaleMisura(rs.getString("di_beta_totale_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaTotaleIncertezza(rs.getString("di_beta_totale_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaTotaleDataMisura(rs.getString("di_beta_totale_data_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaTotaleLaboratorio(rs.getString("di_beta_totale_laboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaTotaleMetodoProva(rs.getString("di_beta_totale_metodo_prova"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setDI_betaResiduaMar(rs.getString("di_beta_residua_mar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduaMisura(rs.getString("di_beta_residua_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduaIncertezza(rs.getString("di_beta_residua_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduaDataMisura(rs.getString("di_beta_residua_data_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduaLaboratorio(rs.getString("di_beta_residua_laboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduaMetodoProva(rs.getString("di_beta_residua_metodo_prova"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setRadon_concentrazioneMar(rs.getString("radon_concentrazione_mar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon_concentrazioneMisura(rs.getString("radon_concentrazione_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon_concentrazioneIncertezza(rs.getString("radon_concentrazione_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon_concentrazioneDataMisura(rs.getString("radon_concentrazione_data_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon_concentrazioneLaboratorio(rs.getString("radon_concentrazione_laboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadon_concentrazioneMetodoProva(rs.getString("radon_concentrazione_metodo_prova"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setTrizio_concentrazioneMar(rs.getString("trizio_concentrazione_mar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio_concentrazioneMisura(rs.getString("trizio_concentrazione_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio_concentrazioneIncertezza(rs.getString("trizio_concentrazione_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio_concentrazioneDataMisura(rs.getString("trizio_concentrazione_data_misura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio_concentrazioneLaboratorio(rs.getString("trizio_concentrazione_laboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTrizio_concentrazioneMetodoProva(rs.getString("trizio_concentrazione_metodo_prova"));}catch(Exception ex){ex.printStackTrace();}
		
		//flusso 326
		
		try{toRet.setIdUnivocoCampione(rs.getString("id_univoco_campione"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCodiceInternoLab(rs.getString("codice_interno_lab"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setAmbitoPrelievo(rs.getString("ambito_prelievo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setNumeroPuntiPrelievo(rs.getString("numero_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setNumeroProgressivoPuntoPrelievo(rs.getString("numero_progressivo_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setNumeroProgressivoPrelievoEffettuatoAnno(rs.getString("numero_progressivo_prelievo_annuo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setTipologiaPuntoPrelievo(rs.getString("tipologia_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCodicePuntoPrelievo(rs.getString("codice_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setComunePuntoPrelievo(rs.getInt("comune_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setIndirizzoPuntoPrelievo(rs.getString("indirizzo_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCoordinateLatitudine(rs.getString("latitudine_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCoordinateLongitudine(rs.getString("longitudine_pdp"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setCampioneNote(rs.getString("campione_note"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setAlfaTotale_superato(rs.getString("di_alfa_totale_superato"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setBetaTotale_superato(rs.getString("di_beta_totale_superato"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setBetaResidua_superato(rs.getString("di_beta_residua_superato"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setMisureApprofondimento(rs.getString("misure_approfondimento"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduoIncertezza(rs.getString("k40_concentrazione_beta_residuo_valore_determinato"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_betaResiduoValoreDeterminato(rs.getString("k40_concentrazione_beta_residuo_incertezza"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setRadio226_concentrazioneMar(rs.getString("Radio226_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneMisura(rs.getString("Radio226_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneIncertezza(rs.getString("Radio226_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneDataMisura(rs.getString("Radio226_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneLaboratorio(rs.getString("Radio226_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneMetodoProva(rs.getString("Radio226_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio226_concentrazioneRapporto(rs.getString("Radio226_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setRadio228_concentrazioneMar(rs.getString("Radio228_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneMisura(rs.getString("Radio228_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneIncertezza(rs.getString("Radio228_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneDataMisura(rs.getString("Radio228_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneLaboratorio(rs.getString("Radio228_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneMetodoProva(rs.getString("Radio228_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadio228_concentrazioneRapporto(rs.getString("Radio228_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setUranio234_concentrazioneMar(rs.getString("Uranio234_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneMisura(rs.getString("Uranio234_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneIncertezza(rs.getString("Uranio234_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneDataMisura(rs.getString("Uranio234_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneLaboratorio(rs.getString("Uranio234_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneMetodoProva(rs.getString("Uranio234_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio234_concentrazioneRapporto(rs.getString("Uranio234_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setUranio238_concentrazioneMar(rs.getString("Uranio238_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneMisura(rs.getString("Uranio238_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneIncertezza(rs.getString("Uranio238_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneDataMisura(rs.getString("Uranio238_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneLaboratorio(rs.getString("Uranio238_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneMetodoProva(rs.getString("Uranio238_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setUranio238_concentrazioneRapporto(rs.getString("Uranio238_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setPiombo210_concentrazioneMar(rs.getString("Piombo210_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneMisura(rs.getString("Piombo210_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneIncertezza(rs.getString("Piombo210_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneDataMisura(rs.getString("Piombo210_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneLaboratorio(rs.getString("Piombo210_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneMetodoProva(rs.getString("Piombo210_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPiombo210_concentrazioneRapporto(rs.getString("Piombo210_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setPolonio210_concentrazioneMar(rs.getString("Polonio210_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneMisura(rs.getString("Polonio210_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneIncertezza(rs.getString("Polonio210_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneDataMisura(rs.getString("Polonio210_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneLaboratorio(rs.getString("Polonio210_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneMetodoProva(rs.getString("Polonio210_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setPolonio210_concentrazioneRapporto(rs.getString("Polonio210_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setRadionuclide1_concentrazioneSimbolo(rs.getString("Radionuclide1_concentrazioneSimbolo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneMar(rs.getString("Radionuclide1_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneMisura(rs.getString("Radionuclide1_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneIncertezza(rs.getString("Radionuclide1_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneDataMisura(rs.getString("Radionuclide1_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneLaboratorio(rs.getString("Radionuclide1_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneMetodoProva(rs.getString("Radionuclide1_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneDerivata(rs.getString("Radionuclide1_concentrazioneDerivata"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide1_concentrazioneRapporto(rs.getString("Radionuclide1_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setRadionuclide2_concentrazioneSimbolo(rs.getString("Radionuclide1_concentrazioneSimbolo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneMar(rs.getString("Radionuclide2_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneMisura(rs.getString("Radionuclide2_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneIncertezza(rs.getString("Radionuclide2_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneDataMisura(rs.getString("Radionuclide2_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneLaboratorio(rs.getString("Radionuclide2_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneMetodoProva(rs.getString("Radionuclide2_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneDerivata(rs.getString("Radionuclide2_concentrazioneDerivata"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide2_concentrazioneRapporto(rs.getString("Radionuclide2_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setRadionuclide3_concentrazioneSimbolo(rs.getString("Radionuclide3_concentrazioneSimbolo"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneMar(rs.getString("Radionuclide3_concentrazioneMar"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneMisura(rs.getString("Radionuclide3_concentrazioneMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneIncertezza(rs.getString("Radionuclide3_concentrazioneIncertezza"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneDataMisura(rs.getString("Radionuclide3_concentrazioneDataMisura"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneLaboratorio(rs.getString("Radionuclide3_concentrazioneLaboratorio"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneMetodoProva(rs.getString("Radionuclide3_concentrazioneMetodoProva"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneDerivata(rs.getString("Radionuclide3_concentrazioneDerivata"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRadionuclide3_concentrazioneRapporto(rs.getString("Radionuclide3_concentrazioneRapporto"));}catch(Exception ex){ex.printStackTrace();}
		
		try{toRet.setDI_MSV_Inferiore(rs.getString("DI_MSV_Inferiore"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setDI_MSV_Superiore(rs.getString("DI_MSV_Superiore"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setRapportoRa226(rs.getString("rapportoRa226"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoRa228(rs.getString("rapportoRa228"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoU234(rs.getString("rapportoU234"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoU238(rs.getString("rapportoU238"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoPb210(rs.getString("rapportoPb210"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoPo210(rs.getString("rapportoPo210"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoRN1(rs.getString("rapportoRN1"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoRN2(rs.getString("rapportoRN2"));}catch(Exception ex){ex.printStackTrace();}
		try{toRet.setRapportoRN3(rs.getString("rapportoRN3"));}catch(Exception ex){ex.printStackTrace();}

		try{toRet.setApprofondimentoNote(rs.getString("approfondimentoNote"));}catch(Exception ex){ex.printStackTrace();}
		
		return toRet;
	}
	
	public static List<ControlloInterno> searchAllPerPuntoPrelievo(Connection db, int idPuntoPrelievo, String tipoDecreto) throws Exception
	{
		 
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try
		{
			/*mettere in join con tcui con idispezione != -1 e stesso ticketid per ottenere vero id ispezione (che cmq e' sempre 19) CABLATO TOGLIERE */
			pst= db.prepareStatement("select ticket.*,tcui.*,cpp.*, asl.description as desc_asl, 19 as ispezione from controlli_punti_di_prelievo_acque_rete cpp join tipocontrolloufficialeimprese tcui"
					+ " on cpp.id_controllo = tcui.idcontrollo join ticket on ticket.ticketid = tcui.idcontrollo join lookup_site_id asl on asl.code = ticket.site_id "
					+ " join lookup_tipo_controllo tc on tc.code = ticket.provvedimenti_prescrittivi "
					+ " where cpp.org_id_pdp = ? and tcui.ispezione = -1 and ticket.tipologia = 3 and (? is null or cpp.tipo_decreto = ? ) "
					);
			
			pst.setInt(1, idPuntoPrelievo);
			pst.setString(2, tipoDecreto);
			pst.setString(3, tipoDecreto);
			rs = pst.executeQuery();
			return buildList(rs);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw ex;
		}
		finally
		{
			try{pst.close();} catch(Exception ex) {}
			try{rs.close();} catch(Exception ex){} 
		}
		
	}
	
	
	public static ControlloInterno searchByOid(Connection db,int idControlloInterno) throws Exception
	{
		ResultSet rs = null;
		PreparedStatement pst = null;
		
		try
		{
			
			/*mettere in join con tcui con idispezione != -1 e stesso ticketid per ottenere vero id ispezione (che cmq e' sempre 19) CABLATO TOGLIERE */
			pst= db.prepareStatement("select ticket.*,tcui.*,cpp.*, asl.description as desc_asl, 19 as ispezione from controlli_punti_di_prelievo_acque_rete cpp join tipocontrolloufficialeimprese tcui"
					+ " on cpp.id_controllo = tcui.idcontrollo join ticket on ticket.ticketid = tcui.idcontrollo join lookup_site_id asl on asl.code = ticket.site_id "
					+ " join lookup_tipo_controllo tc on tc.code = ticket.provvedimenti_prescrittivi "
					+ " where ticket.ticketid = ? and tcui.ispezione = -1 and ticket.tipologia = 3"
					);
			pst.setInt(1, idControlloInterno);
			rs = pst.executeQuery();
			if(rs.next())
			{
				return build(rs);
			}
			return null;
			
		}
		catch(Exception ex)
		{
			throw ex;
		}
		finally
		{
			try{rs.close();} catch(Exception ex){}
			try{pst.close();} catch(Exception ex){}
		}
	}
	
	public static ArrayList<ControlloInterno> search(Connection db,String codiceGisa, Timestamp data, String ora, String tipoDecreto) throws Exception
	{
		ResultSet rs = null;
		PreparedStatement pst = null;
		ArrayList<ControlloInterno> controlli = new ArrayList<ControlloInterno>();
		
		try
		{
			
			/*mettere in join con tcui con idispezione != -1 e stesso ticketid per ottenere vero id ispezione (che cmq e' sempre 19) CABLATO TOGLIERE */
			pst= db.prepareStatement("  select ticket.*,tcui.*,cpp.*, asl.description as desc_asl, 19 as ispezione " +            
									 "  from controlli_punti_di_prelievo_acque_rete cpp     " +                 
									 "  join tipocontrolloufficialeimprese tcui  on cpp.id_controllo = tcui.idcontrollo  " +    
									 "  join ticket on ticket.ticketid = tcui.idcontrollo  " +    
									 "  join lookup_site_id asl on asl.code = ticket.site_id   " +    
									 "  join lookup_tipo_controllo tc on tc.code = ticket.provvedimenti_prescrittivi   " +    
									 "  join gestori_acque_punti_prelievo pdp on pdp.id = cpp.org_id_pdp and pdp.trashed_date is null " +    
									 "  where pdp.codice_gisa = ? and ticket.assigned_date = ? and cpp.ore = ? and tcui.ispezione = -1 and ticket.tipologia = 3 and cpp.tipo_decreto = ? ");
			pst.setString(1, codiceGisa);
			pst.setTimestamp(2, data);
			pst.setString(3, ora);
			pst.setString(4, tipoDecreto);
			rs = pst.executeQuery();
			while(rs.next())
			{
				controlli.add(build(rs));
			}
			return controlli;
			
		}
		catch(Exception ex)
		{
			throw ex;
		}
		finally
		{
			try{rs.close();} catch(Exception ex){}
			try{pst.close();} catch(Exception ex){}
		}
	}
	
	
	
	public String insert(Connection db, UserBean user) throws Exception
	{
		PreparedStatement pst = null;
		ResultSet rs = null;
		String toRet = null;
		try
		{
			/*inserisco il ticket */
			pst = db.prepareStatement("insert into ticket(status_id,site_id,ticketid,enteredby,modifiedby,tipologia,provvedimenti_prescrittivi,assigned_date,data_fine_controllo,problem,esito,nonconformitaformali,note) "
					+ "values (?,?,?,?,?,?,?,?,?,'',?,?,?)  ");
			
			int u = 0;
			
			if(false)
				throw new EccezioneDati();
			 
			int livello=1 ;
			if (user.getUserRecord().getGruppo_ruolo()==2)
				livello=2;
			
			int generatedTicketId =   DatabaseUtils.getNextInt(db,"ticket", "ticketid", livello) ;
			setId(generatedTicketId);
			
			pst.setInt(++u, getStatusId());
			pst.setInt(++u, getSiteId());
			pst.setInt(++u,  getId());
			pst.setInt(++u, getEnteredBy());
			pst.setInt(++u, getModifiedBy());
			pst.setInt(++u, getTipologia());
			pst.setInt(++u, getTipoControllo());
			pst.setTimestamp(++u, getDataInizioControllo());
			pst.setTimestamp(++u, getDataFineControllo());
			pst.setString(++u, getEsito());
			pst.setString(++u, getNonConformita());
			pst.setString(++u, getNote());
			pst.executeUpdate();
			
			pst.close();
			
			pst = db.prepareStatement("insert into tipocontrolloufficialeimprese(idcontrollo,tipoispezione, id_unita_operativa,modifiedby,ispezione)"
					+ " values(?,?,?,?,?)");
			u = 0;
			
			pst.setInt(++u, getId());
			pst.setInt(++u, /*getMotivoIspezione()*/-1);
			pst.setInt(++u, /*getIdUnitaOperativa()*/-1);
			pst.setInt(++u, getModifiedBy());
			pst.setInt(++u, -1); /*qui deve essere messo a -1 altrimenti viene successivamente ricancellata */
			
			pst.executeUpdate();
			
			pst.close();
			
			pst = db.prepareStatement("delete from tipocontrolloufficialeimprese where idcontrollo = ? and ispezione > 0");
			pst.setInt(1, getId());
			pst.executeUpdate();
			
			pst.close();
			
			
			pst = db.prepareStatement("insert into tipocontrolloufficialeimprese(idcontrollo,ispezione) values(?,?)");
			pst.setInt(1, getId());
			pst.setInt(2, getOggettoIspezione());
			pst.executeUpdate();
			
			pst.close();
			
			
			pst = db.prepareStatement("insert into cu_nucleo(id_controllo_ufficiale,id_componente) values(?,?)");
			pst.setInt(1, getId());
			pst.setInt(2, getIdComponenteNucleoIspettivo());
			pst.executeUpdate();
			
			pst.close();
			
			
			pst=db.prepareStatement("update ticket set id_controllo_ufficiale =trim(to_char( "+getId()+", '"+DatabaseUtils.getPaddedFromId(getId())+"')) where ticketid = "+getId());
			pst.executeUpdate();
			
			pst.close();
			
			if(getTipoDecreto().equals("31")){
				pst = db.prepareStatement("insert into controlli_punti_di_prelievo_acque_rete (id_controllo, id_campione, org_id_pdp, temperatura, cloro, trizio, radon, dose, alfa, beta, ore, prot_radioattivita, prot_replica_chim, prot_replica_micro, prot_ricerca_fitosanitari, prot_routine, prot_verifica, tipo_decreto, altro) "
						 + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				u = 0;
				pst.setInt(++u, getId());
				pst.setInt(++u, -1);
				pst.setInt(++u, getPuntoPrelievoPadre().getId());
				pst.setString(++u, getTemperatura());
				pst.setString(++u, getCloro());
				pst.setObject(++u, getTrizio());
				pst.setObject(++u, getRadon());
				pst.setObject(++u, getDose());
				pst.setObject(++u, getAlfa());
				pst.setObject(++u, getBeta());
				pst.setString(++u, getOra());
				pst.setBoolean (++u, isProtocolloRadioattivita());
				pst.setBoolean(++u, isProtocolloReplicaChim());
				pst.setBoolean(++u, isProtocolloReplicaMicro());
				pst.setBoolean(++u, isProtocolloRicercaFitosanitari());
				pst.setBoolean(++u, isProtocolloRoutine());
				pst.setBoolean(++u, isProtocollVerifica());
				pst.setString(++u, getTipoDecreto());
				pst.setString(++u, getAltro());
				
				pst.executeUpdate();
			}
			
			if(getTipoDecreto().equals("28")){
				pst = db.prepareStatement("insert into controlli_punti_di_prelievo_acque_rete (id_controllo, id_campione, org_id_pdp, temperatura, cloro, trizio, radon, dose, alfa, beta, ore, prot_radioattivita, prot_replica_chim, prot_replica_micro, prot_ricerca_fitosanitari, prot_routine, prot_verifica, tipo_decreto, altro, campione_finalita_misura, campione_nota_finalita_misura, campione_motivo_prelievo, campione_nota_motivo_prelievo, fornitura_denominazione_zona, fornitura_denominazione_gestore, punto_tipo_acqua, punto_note, campionamento_numero_prelievi, campionamento_chi,di_alfa_totale_mar, di_alfa_totale_misura, di_alfa_totale_incertezza, di_alfa_totale_data_misura, di_alfa_totale_laboratorio, di_alfa_totale_metodo_prova, di_beta_totale_mar, di_beta_totale_misura, di_beta_totale_incertezza, di_beta_totale_data_misura, di_beta_totale_laboratorio, di_beta_totale_metodo_prova, di_beta_residua_mar, di_beta_residua_misura, di_beta_residua_incertezza, di_beta_residua_data_misura, di_beta_residua_laboratorio, di_beta_residua_metodo_prova,radon_concentrazione_mar, radon_concentrazione_misura, radon_concentrazione_incertezza, radon_concentrazione_data_misura, radon_concentrazione_laboratorio, radon_concentrazione_metodo_prova, trizio_concentrazione_mar, trizio_concentrazione_misura, trizio_concentrazione_incertezza, trizio_concentrazione_data_misura, trizio_concentrazione_laboratorio, trizio_concentrazione_metodo_prova, id_univoco_campione, codice_interno_lab, ambito_prelievo, numero_pdp, numero_progressivo_pdp, numero_progressivo_prelievo_annuo, tipologia_pdp, codice_pdp, comune_pdp, indirizzo_pdp, latitudine_pdp, longitudine_pdp, campione_note, di_alfa_totale_superato, di_beta_totale_superato, di_beta_residua_superato, misure_approfondimento, k40_concentrazione_beta_residuo_valore_determinato, k40_concentrazione_beta_residuo_incertezza, "
				 + "Radio226_concentrazioneMar, Radio226_concentrazioneMisura, Radio226_concentrazioneIncertezza, Radio226_concentrazioneDataMisura, Radio226_concentrazioneLaboratorio, Radio226_concentrazioneMetodoProva, Radio226_concentrazioneRapporto, Radio228_concentrazioneMar, Radio228_concentrazioneMisura, Radio228_concentrazioneIncertezza, Radio228_concentrazioneDataMisura, Radio228_concentrazioneLaboratorio, Radio228_concentrazioneMetodoProva, Radio228_concentrazioneRapporto, Uranio234_concentrazioneMar, Uranio234_concentrazioneMisura, Uranio234_concentrazioneIncertezza, Uranio234_concentrazioneDataMisura, Uranio234_concentrazioneLaboratorio, Uranio234_concentrazioneMetodoProva, Uranio234_concentrazioneRapporto, Uranio238_concentrazioneMar, Uranio238_concentrazioneMisura, Uranio238_concentrazioneIncertezza, Uranio238_concentrazioneDataMisura, Uranio238_concentrazioneLaboratorio, Uranio238_concentrazioneMetodoProva, Uranio238_concentrazioneRapporto, Piombo210_concentrazioneMar, Piombo210_concentrazioneMisura, Piombo210_concentrazioneIncertezza, Piombo210_concentrazioneDataMisura, Piombo210_concentrazioneLaboratorio, Piombo210_concentrazioneMetodoProva, Piombo210_concentrazioneRapporto, Polonio210_concentrazioneMar, Polonio210_concentrazioneMisura, Polonio210_concentrazioneIncertezza, Polonio210_concentrazioneDataMisura, Polonio210_concentrazioneLaboratorio, Polonio210_concentrazioneMetodoProva, Polonio210_concentrazioneRapporto, Radionuclide1_concentrazioneSimbolo, Radionuclide1_concentrazioneMar, Radionuclide1_concentrazioneMisura, Radionuclide1_concentrazioneIncertezza, Radionuclide1_concentrazioneDataMisura, Radionuclide1_concentrazioneLaboratorio, Radionuclide1_concentrazioneMetodoProva, Radionuclide1_concentrazioneDerivata, Radionuclide1_concentrazioneRapporto, Radionuclide2_concentrazioneSimbolo, Radionuclide2_concentrazioneMar, "
				 + "Radionuclide2_concentrazioneMisura, Radionuclide2_concentrazioneIncertezza, Radionuclide2_concentrazioneDataMisura, Radionuclide2_concentrazioneLaboratorio, Radionuclide2_concentrazioneMetodoProva, Radionuclide2_concentrazioneDerivata, Radionuclide2_concentrazioneRapporto, Radionuclide3_concentrazioneSimbolo, Radionuclide3_concentrazioneMar, Radionuclide3_concentrazioneMisura, Radionuclide3_concentrazioneIncertezza, Radionuclide3_concentrazioneDataMisura, Radionuclide3_concentrazioneLaboratorio, Radionuclide3_concentrazioneMetodoProva, Radionuclide3_concentrazioneDerivata, Radionuclide3_concentrazioneRapporto, DI_MSV_Inferiore, DI_MSV_Superiore, rapportoRa226, rapportoRa228, rapportoU234, rapportoU238, rapportoPb210, rapportoPo210, rapportoRN1, rapportoRN2, rapportoRN3, approfondimentoNote) "
				 + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				u = 0;
				pst.setInt(++u, getId());
				pst.setInt(++u, -1);
				pst.setInt(++u, getPuntoPrelievoPadre().getId());
				pst.setString(++u, getTemperatura());
				pst.setString(++u, getCloro());
				pst.setObject(++u, getTrizio());
				pst.setObject(++u, getRadon());
				pst.setObject(++u, getDose());
				pst.setObject(++u, getAlfa());
				pst.setObject(++u, getBeta());
				pst.setString(++u, getOra());
				pst.setBoolean (++u, isProtocolloRadioattivita());
				pst.setBoolean(++u, isProtocolloReplicaChim());
				pst.setBoolean(++u, isProtocolloReplicaMicro());
				pst.setBoolean(++u, isProtocolloRicercaFitosanitari());
				pst.setBoolean(++u, isProtocolloRoutine());
				pst.setBoolean(++u, isProtocollVerifica());
				pst.setString(++u, getTipoDecreto());
				pst.setString(++u, getAltro());
				
				pst.setString(++u, getCampione_finalitaMisura());
				pst.setString(++u, getCampione_notaFinalitaMisura());
				pst.setString(++u, getCampione_motivoPrelievo());
				pst.setString(++u, getCampione_notaMotivoPrelievo());
	
				pst.setString(++u, getFornitura_denominazioneZona());
				pst.setString(++u, getFornitura_denominazioneGestore());
	
				pst.setString(++u, getPunto_tipoAcqua());
				pst.setString(++u, getPunto_note());
	
				pst.setString(++u, getCampionamento_numeroPrelievi());
				pst.setString(++u, getCampionamento_chi());
	
				pst.setString(++u, getDI_alfaTotaleMar());
				pst.setString(++u, getDI_alfaTotaleMisura());
				pst.setString(++u, getDI_alfaTotaleIncertezza());
				pst.setString(++u, getDI_alfaTotaleDataMisura());
				pst.setString(++u, getDI_alfaTotaleLaboratorio());
				pst.setString(++u, getDI_alfaTotaleMetodoProva());
	
				pst.setString(++u, getDI_betaTotaleMar());
				pst.setString(++u, getDI_betaTotaleMisura());
				pst.setString(++u, getDI_betaTotaleIncertezza());
				pst.setString(++u, getDI_betaTotaleDataMisura());
				pst.setString(++u, getDI_betaTotaleLaboratorio());
				pst.setString(++u, getDI_betaTotaleMetodoProva());
	
				pst.setString(++u, getDI_betaResiduaMar());
				pst.setString(++u, getDI_betaResiduaMisura());
				pst.setString(++u, getDI_betaResiduaIncertezza());
				pst.setString(++u, getDI_betaResiduaDataMisura());
				pst.setString(++u, getDI_betaResiduaLaboratorio());
				pst.setString(++u, getDI_betaResiduaMetodoProva());
	
				pst.setString(++u, getRadon_concentrazioneMar());
				pst.setString(++u, getRadon_concentrazioneMisura());
				pst.setString(++u, getRadon_concentrazioneIncertezza());
				pst.setString(++u, getRadon_concentrazioneDataMisura());
				pst.setString(++u, getRadon_concentrazioneLaboratorio());
				pst.setString(++u, getRadon_concentrazioneMetodoProva());
	
				pst.setString(++u, getTrizio_concentrazioneMar());
				pst.setString(++u, getTrizio_concentrazioneMisura());
				pst.setString(++u, getTrizio_concentrazioneIncertezza());
				pst.setString(++u, getTrizio_concentrazioneDataMisura());
				pst.setString(++u, getTrizio_concentrazioneLaboratorio());
				pst.setString(++u, getTrizio_concentrazioneMetodoProva());
				
				//flusso 326
				
				pst.setString(++u, getIdUnivocoCampione());
				pst.setString(++u, getCodiceInternoLab());
				pst.setString(++u, getAmbitoPrelievo());
				pst.setString(++u, getNumeroPuntiPrelievo());
				pst.setString(++u, getNumeroProgressivoPuntoPrelievo());
				pst.setString(++u, getNumeroProgressivoPrelievoEffettuatoAnno());
				pst.setString(++u, getTipologiaPuntoPrelievo());
				pst.setString(++u, getCodicePuntoPrelievo());
				pst.setInt(++u, getComunePuntoPrelievo());
				pst.setString(++u, getIndirizzoPuntoPrelievo());
				pst.setString(++u, getCoordinateLatitudine());
				pst.setString(++u, getCoordinateLongitudine());
				pst.setString(++u, getCampioneNote());
				pst.setString(++u, getAlfaTotale_superato());
				pst.setString(++u, getBetaTotale_superato());
				pst.setString(++u, getBetaResidua_superato());
				pst.setString(++u, getMisureApprofondimento());
				pst.setString(++u, getDI_betaResiduoIncertezza());
				pst.setString(++u, getDI_betaResiduoValoreDeterminato());
				
				pst.setString(++u, getRadio226_concentrazioneMar());
				pst.setString(++u, getRadio226_concentrazioneMisura());
				pst.setString(++u, getRadio226_concentrazioneIncertezza());
				pst.setString(++u, getRadio226_concentrazioneDataMisura());
				pst.setString(++u, getRadio226_concentrazioneLaboratorio());
				pst.setString(++u, getRadio226_concentrazioneMetodoProva());
				pst.setString(++u, getRadio226_concentrazioneRapporto());
				
				pst.setString(++u, getRadio228_concentrazioneMar());
				pst.setString(++u, getRadio228_concentrazioneMisura());
				pst.setString(++u, getRadio228_concentrazioneIncertezza());
				pst.setString(++u, getRadio228_concentrazioneDataMisura());
				pst.setString(++u, getRadio228_concentrazioneLaboratorio());
				pst.setString(++u, getRadio228_concentrazioneMetodoProva());
				pst.setString(++u, getRadio228_concentrazioneRapporto());
				
				pst.setString(++u, getUranio234_concentrazioneMar());
				pst.setString(++u, getUranio234_concentrazioneMisura());
				pst.setString(++u, getUranio234_concentrazioneIncertezza());
				pst.setString(++u, getUranio234_concentrazioneDataMisura());
				pst.setString(++u, getUranio234_concentrazioneLaboratorio());
				pst.setString(++u, getUranio234_concentrazioneMetodoProva());
				pst.setString(++u, getUranio234_concentrazioneRapporto());
				
				pst.setString(++u, getUranio238_concentrazioneMar());
				pst.setString(++u, getUranio238_concentrazioneMisura());
				pst.setString(++u, getUranio238_concentrazioneIncertezza());
				pst.setString(++u, getUranio238_concentrazioneDataMisura());
				pst.setString(++u, getUranio238_concentrazioneLaboratorio());
				pst.setString(++u, getUranio238_concentrazioneMetodoProva());
				pst.setString(++u, getUranio238_concentrazioneRapporto());
				
				pst.setString(++u, getPiombo210_concentrazioneMar());
				pst.setString(++u, getPiombo210_concentrazioneMisura());
				pst.setString(++u, getPiombo210_concentrazioneIncertezza());
				pst.setString(++u, getPiombo210_concentrazioneDataMisura());
				pst.setString(++u, getPiombo210_concentrazioneLaboratorio());
				pst.setString(++u, getPiombo210_concentrazioneMetodoProva());
				pst.setString(++u, getPiombo210_concentrazioneRapporto());
				
				pst.setString(++u, getPolonio210_concentrazioneMar());
				pst.setString(++u, getPolonio210_concentrazioneMisura());
				pst.setString(++u, getPolonio210_concentrazioneIncertezza());
				pst.setString(++u, getPolonio210_concentrazioneDataMisura());
				pst.setString(++u, getPolonio210_concentrazioneLaboratorio());
				pst.setString(++u, getPolonio210_concentrazioneMetodoProva());
				pst.setString(++u, getPolonio210_concentrazioneRapporto());
				
				pst.setString(++u, getRadionuclide1_concentrazioneSimbolo());
				pst.setString(++u, getRadionuclide1_concentrazioneMar());
				pst.setString(++u, getRadionuclide1_concentrazioneMisura());
				pst.setString(++u, getRadionuclide1_concentrazioneIncertezza());
				pst.setString(++u, getRadionuclide1_concentrazioneDataMisura());
				pst.setString(++u, getRadionuclide1_concentrazioneLaboratorio());
				pst.setString(++u, getRadionuclide1_concentrazioneMetodoProva());
				pst.setString(++u, getRadionuclide1_concentrazioneDerivata());
				pst.setString(++u, getRadionuclide1_concentrazioneRapporto());
				
				pst.setString(++u, getRadionuclide2_concentrazioneSimbolo());
				pst.setString(++u, getRadionuclide2_concentrazioneMar());
				pst.setString(++u, getRadionuclide2_concentrazioneMisura());
				pst.setString(++u, getRadionuclide2_concentrazioneIncertezza());
				pst.setString(++u, getRadionuclide2_concentrazioneDataMisura());
				pst.setString(++u, getRadionuclide2_concentrazioneLaboratorio());
				pst.setString(++u, getRadionuclide2_concentrazioneMetodoProva());
				pst.setString(++u, getRadionuclide2_concentrazioneDerivata());
				pst.setString(++u, getRadionuclide2_concentrazioneRapporto());
				
				pst.setString(++u, getRadionuclide3_concentrazioneSimbolo());
				pst.setString(++u, getRadionuclide3_concentrazioneMar());
				pst.setString(++u, getRadionuclide3_concentrazioneMisura());
				pst.setString(++u, getRadionuclide3_concentrazioneIncertezza());
				pst.setString(++u, getRadionuclide3_concentrazioneDataMisura());
				pst.setString(++u, getRadionuclide3_concentrazioneLaboratorio());
				pst.setString(++u, getRadionuclide3_concentrazioneMetodoProva());
				pst.setString(++u, getRadionuclide3_concentrazioneDerivata());
				pst.setString(++u, getRadionuclide3_concentrazioneRapporto());
				
				pst.setString(++u, getDI_MSV_Inferiore());
				pst.setString(++u, getDI_MSV_Superiore());
	
				pst.setString(++u, getRapportoRa226());
				pst.setString(++u, getRapportoRa228());
				pst.setString(++u, getRapportoU234());
				pst.setString(++u, getRapportoU238());
				pst.setString(++u, getRapportoPb210());
				pst.setString(++u, getRapportoPo210());
				pst.setString(++u, getRapportoRN1());
				pst.setString(++u, getRapportoRN2());
				pst.setString(++u, getRapportoRN3());
	
				pst.setString(++u, getApprofondimentoNote());
				
				pst.executeUpdate();
			}
			
			toRet = "<br><font color='green'>Inserito controllo data inizio "+getDataInizioControllo() + "per Punto di prelievo con nome \""+getPuntoPrelievoPadre().getDenominazione() + "\" sito in \""+getPuntoPrelievoPadre().getIndirizzo().getVia() + "\" .... INSERITO CORRETTAMENTE</font>";
			System.out.println("INSERITO CONTROLLO "+getDataInizioControllo());
		}
		 
	    catch(EccezioneDati ex)
		{
			toRet = "<br><font color='red'> Controllo in data inizio "+getDataInizioControllo()+"Punto di prelievo con nome \""+getPuntoPrelievoPadre().getDenominazione() + "\" sito in \""+getPuntoPrelievoPadre().getIndirizzo().getVia() +" ....  NON INSERITO CORRETTAMENTE : <b>"+ex.getMessage()+"</b> </font>";
			System.out.println("CONTROLLO NON INSERITO "+getDataInizioControllo());
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			System.out.println("CONTROLLO NON INSERITO "+getDataInizioControllo());
			toRet = "<br><font color='red'> Controllo in data inizio "+getDataInizioControllo()+"Punto di prelievo con nome \""+getPuntoPrelievoPadre().getDenominazione() + "\" sito in \""+getPuntoPrelievoPadre().getIndirizzo().getVia() + "\" ....  NON INSERITO CORRETTAMENTE : <b>ERRORE DI SISTEMA</b> </font>";
		}
		finally
		{
			try{pst.close();} catch(Exception ex){}
			try{rs.close();} catch(Exception ex){}
		}
		
		return toRet;
		
	}
	public String getCampione_finalitaMisura() {
		return campione_finalitaMisura;
	}
	public void setCampione_finalitaMisura(String campione_finalitaMisura) {
		this.campione_finalitaMisura = campione_finalitaMisura;
	}
	public String getCampione_notaFinalitaMisura() {
		return campione_notaFinalitaMisura;
	}
	public void setCampione_notaFinalitaMisura(String campione_notaFinalitaMisura) {
		this.campione_notaFinalitaMisura = campione_notaFinalitaMisura;
	}
	public String getCampione_motivoPrelievo() {
		return campione_motivoPrelievo;
	}
	public void setCampione_motivoPrelievo(String campione_motivoPrelievo) {
		this.campione_motivoPrelievo = campione_motivoPrelievo;
	}
	public String getCampione_notaMotivoPrelievo() {
		return campione_notaMotivoPrelievo;
	}
	public void setCampione_notaMotivoPrelievo(String campione_notaMotivoPrelievo) {
		this.campione_notaMotivoPrelievo = campione_notaMotivoPrelievo;
	}
	public String getFornitura_denominazioneZona() {
		return fornitura_denominazioneZona;
	}
	public void setFornitura_denominazioneZona(String fornitura_denominazioneZona) {
		this.fornitura_denominazioneZona = fornitura_denominazioneZona;
	}
	public String getFornitura_denominazioneGestore() {
		return fornitura_denominazioneGestore;
	}
	public void setFornitura_denominazioneGestore(String fornitura_denominazioneGestore) {
		this.fornitura_denominazioneGestore = fornitura_denominazioneGestore;
	}
	public String getPunto_tipoAcqua() {
		return punto_tipoAcqua;
	}
	public void setPunto_tipoAcqua(String punto_tipoAcqua) {
		this.punto_tipoAcqua = punto_tipoAcqua;
	}
	public String getPunto_note() {
		return punto_note;
	}
	public void setPunto_note(String punto_note) {
		this.punto_note = punto_note;
	}
	public String getCampionamento_numeroPrelievi() {
		return campionamento_numeroPrelievi;
	}
	public void setCampionamento_numeroPrelievi(String campionamento_numeroPrelievi) {
		this.campionamento_numeroPrelievi = campionamento_numeroPrelievi;
	}
	public String getCampionamento_chi() {
		return campionamento_chi;
	}
	public void setCampionamento_chi(String campionamento_chi) {
		this.campionamento_chi = campionamento_chi;
	}
	public String getDI_alfaTotaleMar() {
		return DI_alfaTotaleMar;
	}
	public void setDI_alfaTotaleMar(String dI_alfaTotaleMar) {
		DI_alfaTotaleMar = dI_alfaTotaleMar;
	}
	public String getDI_alfaTotaleMisura() {
		return DI_alfaTotaleMisura;
	}
	public void setDI_alfaTotaleMisura(String dI_alfaTotaleMisura) {
		DI_alfaTotaleMisura = dI_alfaTotaleMisura;
	}
	public String getDI_alfaTotaleIncertezza() {
		return DI_alfaTotaleIncertezza;
	}
	public void setDI_alfaTotaleIncertezza(String dI_alfaTotaleIncertezza) {
		DI_alfaTotaleIncertezza = dI_alfaTotaleIncertezza;
	}
	public String getDI_alfaTotaleDataMisura() {
		return DI_alfaTotaleDataMisura;
	}
	public void setDI_alfaTotaleDataMisura(String dI_alfaTotaleDataMisura) {
		DI_alfaTotaleDataMisura = dI_alfaTotaleDataMisura;
	}
	public String getDI_alfaTotaleLaboratorio() {
		return DI_alfaTotaleLaboratorio;
	}
	public void setDI_alfaTotaleLaboratorio(String dI_alfaTotaleLaboratorio) {
		DI_alfaTotaleLaboratorio = dI_alfaTotaleLaboratorio;
	}
	public String getDI_alfaTotaleMetodoProva() {
		return DI_alfaTotaleMetodoProva;
	}
	public void setDI_alfaTotaleMetodoProva(String dI_alfaTotaleMetodoProva) {
		DI_alfaTotaleMetodoProva = dI_alfaTotaleMetodoProva;
	}
	public String getDI_betaTotaleMar() {
		return DI_betaTotaleMar;
	}
	public void setDI_betaTotaleMar(String dI_betaTotaleMar) {
		DI_betaTotaleMar = dI_betaTotaleMar;
	}
	public String getDI_betaTotaleMisura() {
		return DI_betaTotaleMisura;
	}
	public void setDI_betaTotaleMisura(String dI_betaTotaleMisura) {
		DI_betaTotaleMisura = dI_betaTotaleMisura;
	}
	public String getDI_betaTotaleIncertezza() {
		return DI_betaTotaleIncertezza;
	}
	public void setDI_betaTotaleIncertezza(String dI_betaTotaleIncertezza) {
		DI_betaTotaleIncertezza = dI_betaTotaleIncertezza;
	}
	public String getDI_betaTotaleDataMisura() {
		return DI_betaTotaleDataMisura;
	}
	public void setDI_betaTotaleDataMisura(String dI_betaTotaleDataMisura) {
		DI_betaTotaleDataMisura = dI_betaTotaleDataMisura;
	}
	public String getDI_betaTotaleLaboratorio() {
		return DI_betaTotaleLaboratorio;
	}
	public void setDI_betaTotaleLaboratorio(String dI_betaTotaleLaboratorio) {
		DI_betaTotaleLaboratorio = dI_betaTotaleLaboratorio;
	}
	public String getDI_betaTotaleMetodoProva() {
		return DI_betaTotaleMetodoProva;
	}
	public void setDI_betaTotaleMetodoProva(String dI_betaTotaleMetodoProva) {
		DI_betaTotaleMetodoProva = dI_betaTotaleMetodoProva;
	}
	public String getDI_betaResiduaMar() {
		return DI_betaResiduaMar;
	}
	public void setDI_betaResiduaMar(String dI_betaResiduaMar) {
		DI_betaResiduaMar = dI_betaResiduaMar;
	}
	public String getDI_betaResiduaMisura() {
		return DI_betaResiduaMisura;
	}
	public void setDI_betaResiduaMisura(String dI_betaResiduaMisura) {
		DI_betaResiduaMisura = dI_betaResiduaMisura;
	}
	public String getDI_betaResiduaIncertezza() {
		return DI_betaResiduaIncertezza;
	}
	public void setDI_betaResiduaIncertezza(String dI_betaResiduaIncertezza) {
		DI_betaResiduaIncertezza = dI_betaResiduaIncertezza;
	}
	public String getDI_betaResiduaDataMisura() {
		return DI_betaResiduaDataMisura;
	}
	public void setDI_betaResiduaDataMisura(String dI_betaResiduaDataMisura) {
		DI_betaResiduaDataMisura = dI_betaResiduaDataMisura;
	}
	public String getDI_betaResiduaLaboratorio() {
		return DI_betaResiduaLaboratorio;
	}
	public void setDI_betaResiduaLaboratorio(String dI_betaResiduaLaboratorio) {
		DI_betaResiduaLaboratorio = dI_betaResiduaLaboratorio;
	}
	public String getDI_betaResiduaMetodoProva() {
		return DI_betaResiduaMetodoProva;
	}
	public void setDI_betaResiduaMetodoProva(String dI_betaResiduaMetodoProva) {
		DI_betaResiduaMetodoProva = dI_betaResiduaMetodoProva;
	}
	public String getRadon_concentrazioneMar() {
		return Radon_concentrazioneMar;
	}
	public void setRadon_concentrazioneMar(String radon_concentrazioneMar) {
		Radon_concentrazioneMar = radon_concentrazioneMar;
	}
	public String getRadon_concentrazioneMisura() {
		return Radon_concentrazioneMisura;
	}
	public void setRadon_concentrazioneMisura(String radon_concentrazioneMisura) {
		Radon_concentrazioneMisura = radon_concentrazioneMisura;
	}
	public String getRadon_concentrazioneIncertezza() {
		return Radon_concentrazioneIncertezza;
	}
	public void setRadon_concentrazioneIncertezza(String radon_concentrazioneIncertezza) {
		Radon_concentrazioneIncertezza = radon_concentrazioneIncertezza;
	}
	public String getRadon_concentrazioneDataMisura() {
		return Radon_concentrazioneDataMisura;
	}
	public void setRadon_concentrazioneDataMisura(String radon_concentrazioneDataMisura) {
		Radon_concentrazioneDataMisura = radon_concentrazioneDataMisura;
	}
	public String getRadon_concentrazioneLaboratorio() {
		return Radon_concentrazioneLaboratorio;
	}
	public void setRadon_concentrazioneLaboratorio(String radon_concentrazioneLaboratorio) {
		Radon_concentrazioneLaboratorio = radon_concentrazioneLaboratorio;
	}
	public String getRadon_concentrazioneMetodoProva() {
		return Radon_concentrazioneMetodoProva;
	}
	public void setRadon_concentrazioneMetodoProva(String radon_concentrazioneMetodoProva) {
		Radon_concentrazioneMetodoProva = radon_concentrazioneMetodoProva;
	}
	public String getTrizio_concentrazioneMar() {
		return Trizio_concentrazioneMar;
	}
	public void setTrizio_concentrazioneMar(String trizio_concentrazioneMar) {
		Trizio_concentrazioneMar = trizio_concentrazioneMar;
	}
	public String getTrizio_concentrazioneMisura() {
		return Trizio_concentrazioneMisura;
	}
	public void setTrizio_concentrazioneMisura(String trizio_concentrazioneMisura) {
		Trizio_concentrazioneMisura = trizio_concentrazioneMisura;
	}
	public String getTrizio_concentrazioneIncertezza() {
		return Trizio_concentrazioneIncertezza;
	}
	public void setTrizio_concentrazioneIncertezza(String trizio_concentrazioneIncertezza) {
		Trizio_concentrazioneIncertezza = trizio_concentrazioneIncertezza;
	}
	public String getTrizio_concentrazioneDataMisura() {
		return Trizio_concentrazioneDataMisura;
	}
	public void setTrizio_concentrazioneDataMisura(String trizio_concentrazioneDataMisura) {
		Trizio_concentrazioneDataMisura = trizio_concentrazioneDataMisura;
	}
	public String getTrizio_concentrazioneLaboratorio() {
		return Trizio_concentrazioneLaboratorio;
	}
	public void setTrizio_concentrazioneLaboratorio(String trizio_concentrazioneLaboratorio) {
		Trizio_concentrazioneLaboratorio = trizio_concentrazioneLaboratorio;
	}
	public String getTrizio_concentrazioneMetodoProva() {
		return Trizio_concentrazioneMetodoProva;
	}
	public void setTrizio_concentrazioneMetodoProva(String trizio_concentrazioneMetodoProva) {
		Trizio_concentrazioneMetodoProva = trizio_concentrazioneMetodoProva;
	}
	
	
	
	
	
}
