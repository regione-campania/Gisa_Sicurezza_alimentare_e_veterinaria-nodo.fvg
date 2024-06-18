package it.us.web.bean.test;

import java.io.Serializable;

public class Indirizzo implements Serializable
{
	private static final long serialVersionUID = -6554852764021770011L;
	
	private String citta;
	private String provincia;
	private String via;
	private int cap;

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public Indirizzo() {
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public int getCap() {
		return cap;
	}

	public void setCap(int cap) {
		this.cap = cap;
	}
}
