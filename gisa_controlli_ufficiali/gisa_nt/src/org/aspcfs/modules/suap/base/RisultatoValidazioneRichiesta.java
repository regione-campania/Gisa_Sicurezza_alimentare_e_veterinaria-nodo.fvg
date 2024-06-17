package org.aspcfs.modules.suap.base;

import java.util.HashMap;

import com.darkhorseventures.framework.beans.GenericBean;

public class RisultatoValidazioneRichiesta extends GenericBean {
	
	private int idRisultato ;
	private String descrizioneErrore ;
	private HashMap<Integer, Stabilimento> listaAnagraficheCandidate = new HashMap<Integer,Stabilimento>();
	private int idStabilimentoTrovato =-1 ;
	private boolean altEseguitaRicercaGlobale;
	
	private String color;
	
	
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public boolean isAltEseguitaRicercaGlobale() {
		return altEseguitaRicercaGlobale;
	}
	public void setAltEseguitaRicercaGlobale(boolean altEseguitaRicercaGlobale) {
		this.altEseguitaRicercaGlobale = altEseguitaRicercaGlobale;
	}
	public int getIdRisultato() {
		return idRisultato;
	}
	public void setIdRisultato(int idRisultato) {
		this.idRisultato = idRisultato;
	}
	public String getDescrizioneErrore() {
		return descrizioneErrore;
	}
	public void setDescrizioneErrore(String descrizioneErrore) {
		this.descrizioneErrore = descrizioneErrore;
	}
	public HashMap<Integer, Stabilimento> getListaAnagraficheCandidate() {
		return listaAnagraficheCandidate;
	}
	public void setListaAnagraficheCandidate(HashMap<Integer, Stabilimento> listaAnagraficheCandidate) {
		this.listaAnagraficheCandidate = listaAnagraficheCandidate;
	}
	public int getIdStabilimentoTrovato() {
		return idStabilimentoTrovato;
	}
	public void setIdStabilimentoTrovato(int idStabilimentoTrovato) {
		this.idStabilimentoTrovato = idStabilimentoTrovato;
	}
	
	

}
