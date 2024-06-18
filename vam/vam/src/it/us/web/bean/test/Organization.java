package it.us.web.bean.test;

import java.io.Serializable;
import java.util.Date;

public class Organization implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String idAsl;
	private Date dataNascita;
	private Indirizzo[] listaIndirizzi;
	
	public Indirizzo[] getListaIndirizzi() {
		return listaIndirizzi;
	}
	public void setListaIndirizzi(Indirizzo[] listaIndirizzi) {
		this.listaIndirizzi = listaIndirizzi;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIdAsl() {
		return idAsl;
	}
	public void setIdAsl(String idAsl) {
		this.idAsl = idAsl;
	}
	public Date getDataNascita() {
		return dataNascita;
	}
	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
	}
	
}
