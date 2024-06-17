package org.aspcfs.utils;

import java.io.Serializable;
import java.sql.Timestamp;

import com.darkhorseventures.framework.beans.GenericBean;

public class Canile extends GenericBean  implements Serializable 
{
	private static final long serialVersionUID = -8622138631789926823L;
	
	private Timestamp dataFine;
	private Timestamp dataRiattivazioneBlocco;
	private Timestamp dataOperazioneBlocco;
	private Timestamp dataSospensioneBlocco;
	private boolean bloccato;
	private int mqDisponibili;
	private float occupazioneAttuale;
	private int numeroCaniVivi;
	
	public Timestamp getDataFine() {
		return dataFine;
	}
	public void setDataFine(Timestamp dataFine) {
		this.dataFine = dataFine;
	}
	
	public Timestamp getDataRiattivazioneBlocco() {
		return dataRiattivazioneBlocco;
	}
	public void setDataRiattivazioneBlocco(Timestamp dataRiattivazioneBlocco) {
		this.dataRiattivazioneBlocco = dataRiattivazioneBlocco;
	}
	
	public Timestamp getDataOperazioneBlocco() {
		return dataOperazioneBlocco;
	}
	public void setDataOperazioneBlocco(Timestamp dataOperazioneBlocco) {
		this.dataOperazioneBlocco = dataOperazioneBlocco;
	}
	
	public Timestamp getDataSospensioneBlocco() {
		return dataSospensioneBlocco;
	}
	public void setDataSospensioneBlocco(Timestamp dataSospensioneBlocco) {
		this.dataSospensioneBlocco = dataSospensioneBlocco;
	}
	
	public boolean isBloccato() {
		return bloccato;
	}
	public void setBloccato(boolean bloccato) {
		this.bloccato = bloccato;
	}
	
	public int getMqDisponibili() {
		return mqDisponibili;
	}
	public void setMqDisponibili(int mqDisponibili) {
		this.mqDisponibili = mqDisponibili;
	}
	
	public float getOccupazioneAttuale() {
		return occupazioneAttuale;
	}
	public void setOccupazioneAttuale(float occupazioneAttuale) {
		this.occupazioneAttuale = occupazioneAttuale;
	}
	
	public int getNumeroCaniVivi() {
		return numeroCaniVivi;
	}
	public void setNumeroCaniVivi(int numeroCaniVivi) {
		this.numeroCaniVivi = numeroCaniVivi;
	}
	
	
}
