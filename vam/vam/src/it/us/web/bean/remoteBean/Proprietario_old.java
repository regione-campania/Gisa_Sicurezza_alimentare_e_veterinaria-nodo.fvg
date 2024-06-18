package it.us.web.bean.remoteBean;

import java.io.Serializable;

public class Proprietario_old implements Serializable
{
	private static final long serialVersionUID = 8921544993066724951L;
	
	private int id;
	private String codiceFiscale;
	private String nome;
	private String cognome;
	private String documentoIdentita;
	private String aslString;
	private Indirizzo[] listaIndirizzi;
	private Telefono[] listaNumeriDiTelefono;
	
	private String errorDescription;
	private int errorCode;
		
	
	public String getErrorDescription() {
		return errorDescription;
	}
	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
	}
	public int getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
	
	public String getAslString() {
		return aslString;
	}
	public void setAslString(String aslString) {
		this.aslString = aslString;
	}
	public Telefono[] getListaNumeriDiTelefono() {
		return listaNumeriDiTelefono;
	}
	public void setListaNumeriDiTelefono(Telefono[] listaNumeriDiTelefono) {
		this.listaNumeriDiTelefono = listaNumeriDiTelefono;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodiceFiscale() {
		return codiceFiscale;
	}
	public void setCodiceFiscale(String codiceFiscale) {
		this.codiceFiscale = codiceFiscale;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getDocumentoIdentita() {
		return documentoIdentita;
	}
	public void setDocumentoIdentita(String documentoIdentita) {
		this.documentoIdentita = documentoIdentita;
	}
	public Indirizzo[] getListaIndirizzi() {
		return listaIndirizzi;
	}
	public void setListaIndirizzi(Indirizzo[] listaIndirizzi) {
		this.listaIndirizzi = listaIndirizzi;
	}
	
}
