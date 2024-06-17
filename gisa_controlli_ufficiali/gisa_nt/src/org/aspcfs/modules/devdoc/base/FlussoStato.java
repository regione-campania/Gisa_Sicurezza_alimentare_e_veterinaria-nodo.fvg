package org.aspcfs.modules.devdoc.base;

import java.sql.Timestamp;

import com.darkhorseventures.framework.beans.GenericBean;

public class FlussoStato extends GenericBean {
	private int id = -1;	
	private String note = null;
	private int idFlusso = -1;
	private int idUtente = -1;
	private String data = null;
	private int idStato = -1;
	private Timestamp entered = null;
	
	
	public FlussoStato(int id, int idFlusso, int idStato, String note, String data, Timestamp entered, int idUtente) {
		super();
		this.id = id;
		this.note = note;
		this.idFlusso = idFlusso;
		this.idUtente = idUtente;
		this.data = data;
		this.entered = entered;
		this.idStato = idStato;

	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}


	public int getIdFlusso() {
		return idFlusso;
	}


	public void setIdFlusso(int idFlusso) {
		this.idFlusso = idFlusso;
	}


	public int getIdUtente() {
		return idUtente;
	}


	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}


	public String getData() {
		return data;
	}


	public void setData(String data) {
		this.data = data;
	}


	public int getIdStato() {
		return idStato;
	}


	public void setIdStato(int idStato) {
		this.idStato = idStato;
	}


	public Timestamp getEntered() {
		return entered;
	}


	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}
	
}
