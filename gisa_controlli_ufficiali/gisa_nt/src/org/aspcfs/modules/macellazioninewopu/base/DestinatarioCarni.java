package org.aspcfs.modules.macellazioninewopu.base;

import com.darkhorseventures.framework.beans.GenericBean;

public class DestinatarioCarni  extends GenericBean{
	
	private String nome="";
	private int id = -1;
	private boolean inRegione = true;
	private int numCapiOvini=0;
	private int numCapiCaprini=0;
	private int indice = -1;
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isInRegione() {
		return inRegione;
	}

	public void setInRegione(boolean inRegione) {
		this.inRegione = inRegione;
	}

	public int getNumCapiOvini() {
		return numCapiOvini;
	}

	public void setNumCapiOvini(int numCapiOvini) {
		this.numCapiOvini = numCapiOvini;
	}

	public int getNumCapiCaprini() {
		return numCapiCaprini;
	}

	public void setNumCapiCaprini(int numCapiCaprini) {
		this.numCapiCaprini = numCapiCaprini;
	}

	public DestinatarioCarni(int idDestinatario, boolean inRegione, String destinatario, int ovini, int caprini){
		this.nome = destinatario;
		this.numCapiOvini = ovini;
		this.numCapiCaprini = caprini;
		this.id = idDestinatario;
		this.inRegione = inRegione;
		
	}
	
	public DestinatarioCarni(int idDestinatario, boolean inRegione, String destinatario, int ovini, int caprini, int indice){
		this.nome = destinatario;
		this.numCapiOvini = ovini;
		this.numCapiCaprini = caprini;
		this.id = idDestinatario;
		this.inRegione = inRegione;
		this.setIndice(indice);
		
	}

	public int getIndice() { 
		return indice;
	}

	public void setIndice(int indice) {
		this.indice = indice;
	}

}
