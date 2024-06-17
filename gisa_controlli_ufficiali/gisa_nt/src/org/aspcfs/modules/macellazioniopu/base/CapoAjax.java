package org.aspcfs.modules.macellazioniopu.base;

public class CapoAjax
{
	private String matricola;
	private int asl;
	private String comune;
	private int regione;
	private String codice_azienda;
	private int specie;
	private boolean sesso;
	private int razza;
	private String data_nascita;
	private boolean esistente;
	private boolean inBDN;
	private int errore;
	
	
	public String getMatricola() {
		return matricola;
	}
	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}
	public String getCodice_azienda() {
		return codice_azienda;
	}
	public void setCodice_azienda(String codice_azienda) {
		this.codice_azienda = codice_azienda;
	}
	public int getSpecie() {
		return specie;
	}
	public void setSpecie(int specie) {
		this.specie = specie;
	}
	public boolean getSesso() {
		return sesso;
	}
	public void setSesso(boolean b) {
		this.sesso = b;
	}
	public int getRazza() {
		return razza;
	}
	public void setRazza(int razza) {
		this.razza = razza;
	}
	public String getData_nascita() {
		return data_nascita;
	}
	public void setData_nascita(String data_nascita) {
		this.data_nascita = data_nascita;
	}
	public boolean isEsistente() {
		return esistente;
	}
	public void setEsistente(boolean esistente) {
		this.esistente = esistente;
	}
	public boolean getInBDN() {
		return inBDN;
	}
	public void setInBDN(boolean inBDN) {
		this.inBDN = inBDN;
	}
	public int getAsl() {
		return asl;
	}
	public void setAsl(int asl) {
		this.asl = asl;
	}
	public String getComune() {
		return comune;
	}
	public void setComune(String comune) {
		this.comune = comune;
	}
	public int getErrore() {
		return errore;
	}
	public void setErrore(int errore) {
		this.errore = errore;
	}
	public int getRegione() {
		return regione;
	}
	public void setRegione(int regione) {
		this.regione = regione;
	}
	
	
	
	
	
}
