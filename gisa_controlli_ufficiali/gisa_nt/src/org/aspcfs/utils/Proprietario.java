package org.aspcfs.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.darkhorseventures.framework.beans.GenericBean;

public class Proprietario extends GenericBean {
	
	private int 	idAsl 						;
	private String 	tipoProprietarioDetentore	;
	private String 	ragioneSociale				;
	private String 	codiceFiscale				;
	private String 	nome						;
	private String	cognome						;
	private Date 	dataNascita					;
	private String	dataNascitaAsString			;
	private String 	luogoNascita				;
	private String 	documentoIdentita			;
	
	private ArrayList<IndirizzoProprietario> lista_indirizzi = new ArrayList<IndirizzoProprietario>();
	SimpleDateFormat sdf =new SimpleDateFormat("dd/MM/yyyy");
	public int getIdAsl() {
		return idAsl;
	}
	public void setIdAsl(int idAsl) {
		this.idAsl = idAsl;
	}
	public String getTipoProprietarioDetentore() {
		return tipoProprietarioDetentore;
	}
	public void setTipoProprietarioDetentore(String tipoProprietarioDetentore) {
		this.tipoProprietarioDetentore = tipoProprietarioDetentore;
	}
	public String getRagioneSociale() {
		return ragioneSociale;
	}
	public void setRagioneSociale(String ragioneSociale) {
		this.ragioneSociale = ragioneSociale;
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
	public Date getDataNascita() {
		return dataNascita;
	}
	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
		if(dataNascita!=null)
		{
			dataNascitaAsString = sdf.format(dataNascita);
		}
	}
	public String getDataNascitaAsString() {
		return dataNascitaAsString;
	}
	public void setDataNascitaAsString(String dataNascitaAsString) {
		this.dataNascitaAsString = dataNascitaAsString;
	}
	public String getLuogoNascita() {
		return luogoNascita;
	}
	public void setLuogoNascita(String luogoNascita) {
		this.luogoNascita = luogoNascita;
	}
	public String getDocumentoIdentita() {
		return documentoIdentita;
	}
	public void setDocumentoIdentita(String documentoIdentita) {
		this.documentoIdentita = documentoIdentita;
	}
	public ArrayList<IndirizzoProprietario> getLista_indirizzi() {
		return lista_indirizzi;
	}
	public void setLista_indirizzi(ArrayList<IndirizzoProprietario> lista_indirizzi) {
		this.lista_indirizzi = lista_indirizzi;
	}
	
	
	
	
}
