package it.us.web.bean.vam;

import java.util.Set;

public class AutopsiaSezioneDettaglioEsami implements java.io.Serializable{
	
	private String organo;
	private String tipo;
	private String dettaglio;
	private Set<String> esiti;
	
	public String getOrgano() {
		return organo;
	}
	public void setOrgano(String organo) {
		this.organo = organo;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getDettaglio() {
		return dettaglio;
	}
	public void setDettaglio(String dettaglio) {
		this.dettaglio = dettaglio;
	}
	public Set<String> getEsiti() {
		return esiti;
	}
	public void setEsiti(Set<String> esiti) {
		this.esiti = esiti;
	}
	
	@Override
	public String toString()
	{
		return organo + ", " + tipo + ", " + dettaglio;
	}
	

}
