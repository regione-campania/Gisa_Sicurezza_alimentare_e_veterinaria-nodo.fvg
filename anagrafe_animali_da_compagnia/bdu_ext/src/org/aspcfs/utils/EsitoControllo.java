package org.aspcfs.utils;

import org.aspcfs.modules.anagrafe_animali.base.Animale;

public class EsitoControllo {

	private int idEsito ; 
	private Animale animale ; 
	private String descrizione ;
	private String dataRegistrazioneAnimale = null;
	private String comune ;
	private int comuneId;
	private String sesso ;
	private String specie;
	private String razza;
	private String datanascita;
	private String mantello;
	private String taglia;
	private String sterilizzato;
	private String indirizzo;
	private String idAnimale;
	
	
	
	public int getIdEsito() {
		return idEsito;
	}
	public void setIdEsito(int idEsito) {
		this.idEsito = idEsito;
	}
	public Animale getAnimale() {
		return animale;
	}
	public void setAnimale(Animale animale) {
		this.animale = animale;
	}
	public String getIdAnimale() {
		return idAnimale;
	}
	public void setIdAnimale(String idAnimale) {
		this.idAnimale = idAnimale;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getComune() {
		return comune;
	}
	public void setComune(String comune) {
		this.comune = comune;
	}
	public String getSesso() {
		return sesso;
	}
	public void setSesso(String sesso) {
		this.sesso = sesso;
	}
	
	public void setindirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
	
	public String getindirizzo() {
		return indirizzo;
	}
	public void setsterilizzato(String sterilizzato) {
		this.sterilizzato = sterilizzato;
	}
	
	public String getsterilizzato() {
		return sterilizzato;
	}
	public void settaglia(String taglia) {
		this.taglia = taglia;
	}
	
	public String gettaglia() {
		return taglia;
	}
	public void setmantello(String mantello) {
		this.mantello = mantello;
	}
	public String getmantello() {
		return mantello;
	}
	
	public String getdatanascita() {
		return datanascita;
	}
	public void setdatanascita(String datanascita) {
		this.datanascita = datanascita;
	}
	
	public String getrazza() {
		return razza;
	}
	public void setrazza(String razza) {
		this.razza = razza;
	}
	
	public String getspecie() {
		return specie;
	}
	public void setspecie(String specie) {
		this.specie = specie;
	}
	
	public int getComuneId() {
		return comuneId;
	}
	public void setComuneId(int comuneId) {
		this.comuneId = comuneId;
	}
	public String getDataRegistrazioneAnimale() {
		return dataRegistrazioneAnimale;
	}
	public void setDataRegistrazioneAnimale(String dataRegistrazioneAnimale) {
		this.dataRegistrazioneAnimale = dataRegistrazioneAnimale;
	}

	
	
}
