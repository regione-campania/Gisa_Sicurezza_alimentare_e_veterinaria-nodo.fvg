package org.aspcfs.modules.allevamenti.base;

import java.io.Serializable;
import java.sql.Timestamp;

public class InformazioniSanitarie implements Serializable {

	private String codiceMalattia;
	private String qualifica 	;
	private String descrizioneCodiceMalattia;
	private String descrizioneQualifica 	;
	private Timestamp dataRilevazione;
	
	
	public Timestamp getDataRilevazione() {
		return dataRilevazione;
	}
	public void setDataRilevazione(Timestamp dataRilevazione) {
		this.dataRilevazione = dataRilevazione;
	}
	public String getCodiceMalattia() {
		return codiceMalattia;
	}
	public void setCodiceMalattia(String codiceMalattia) {
		this.codiceMalattia = codiceMalattia;
	}
	public String getQualifica() {
		return qualifica;
	}
	public void setQualifica(String qualifica) {
		this.qualifica = qualifica;
	}
	public String getDescrizioneCodiceMalattia() {
		return descrizioneCodiceMalattia;
	}
	public void setDescrizioneCodiceMalattia(String descrizioneCodiceMalattia) {
		this.descrizioneCodiceMalattia = descrizioneCodiceMalattia;
	}
	public String getDescrizioneQualifica() {
		return descrizioneQualifica;
	}
	public void setDescrizioneQualifica(String descrizioneQualifica) {
		this.descrizioneQualifica = descrizioneQualifica;
	}
	
	
}
