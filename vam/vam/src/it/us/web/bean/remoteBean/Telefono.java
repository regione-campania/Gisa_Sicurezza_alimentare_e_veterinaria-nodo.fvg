package it.us.web.bean.remoteBean;

import java.io.Serializable;

public class Telefono implements Serializable
{
	private static final long serialVersionUID = -6873747518936624563L;
	
	private String numero;
	private int tipologia;

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}
	
	public int getTipologia() {
		return tipologia;
	}

	public void setTipologia(int tipologia) {
		this.tipologia = tipologia;
	}
	
}
