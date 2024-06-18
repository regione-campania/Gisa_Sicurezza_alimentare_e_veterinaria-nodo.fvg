package it.us.web.bean.remoteBean;

public class Indirizzo {
	private String citta;
	private String nazione;
	private String via;
	private String tipologia;
	private String provincia;
	private String cap;

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getTipologia() {
		return tipologia;
	}

	public void setTipologia(String tipologia) {
		this.tipologia = tipologia;
	}

	public Indirizzo() {
	}

	public String getCitta() {
		return citta;
	}

	public void setCitta(String citta) {
		this.citta = citta;
	}

	public String getNazione() {
		return nazione;
	}

	public void setNazione(String nazione) {
		this.nazione = nazione;
	}

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}
}