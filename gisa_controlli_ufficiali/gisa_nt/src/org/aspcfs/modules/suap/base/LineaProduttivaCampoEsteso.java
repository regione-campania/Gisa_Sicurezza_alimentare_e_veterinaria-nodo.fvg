package org.aspcfs.modules.suap.base;

import com.darkhorseventures.framework.beans.GenericBean;

public class LineaProduttivaCampoEsteso  extends GenericBean{
	
	private int idFieldHtml ;
	private String nomeCampo ; 
	private String tipoCampo ; 
	private String nomeTabella ;
	private boolean multiplo ;
	private int idRelStabLp ;
	private String dbiGenerazione;
	public String getDbiGenerazione() {
		return dbiGenerazione;
	}

	public void setDbiGenerazione(String dbiGenerazione) {
		this.dbiGenerazione = dbiGenerazione;
	}

	private String valore ;

	public int getIdFieldHtml() {
		return idFieldHtml;
	}

	public void setIdFieldHtml(int idFieldHtml) {
		this.idFieldHtml = idFieldHtml;
	}

	public String getNomeCampo() {
		return nomeCampo;
	}

	public void setNomeCampo(String nomeCampo) {
		this.nomeCampo = nomeCampo;
	}

	public String getTipoCampo() {
		return tipoCampo;
	}

	public void setTipoCampo(String tipoCampo) {
		this.tipoCampo = tipoCampo;
	}

	public String getNomeTabella() {
		return nomeTabella;
	}

	public void setNomeTabella(String nomeTabella) {
		this.nomeTabella = nomeTabella;
	}

	public boolean isMultiplo() {
		return multiplo;
	}

	public void setMultiplo(boolean multiplo) {
		this.multiplo = multiplo;
	}

	public int getIdRelStabLp() {
		return idRelStabLp;
	}

	public void setIdRelStabLp(int idRelStabLp) {
		this.idRelStabLp = idRelStabLp;
	}

	public String getValore() {
		return valore;
	}

	public void setValore(String valore) {
		this.valore = valore;
	}
	
	

}
