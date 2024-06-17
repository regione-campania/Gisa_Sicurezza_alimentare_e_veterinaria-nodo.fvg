package org.aspcfs.utils;

import java.sql.Timestamp;

public class DocumentoPrelievoCampione {
	
	private int idDocumento;
	private int idCanile;
	private String nomeCanile;
	private Timestamp dataDocumento;
	private int numeroMC;
	public int getIdDocumento() {
		return idDocumento;
	}
	public void setIdDocumento(int idDocumento) {
		this.idDocumento = idDocumento;
	}
	public int getIdCanile() {
		return idCanile;
	}
	public void setIdCanile(int idCanile) {
		this.idCanile = idCanile;
	}
	public String getNomeCanile() {
		return nomeCanile;
	}
	public void setNomeCanile(String nomeCanile) {
		this.nomeCanile = nomeCanile;
	}
	public Timestamp getDataDocumento() {
		return dataDocumento;
	}
	public void setDataDocumento(Timestamp dataDocumento) {
		this.dataDocumento = dataDocumento;
	}
	public int getNumeroMC() {
		return numeroMC;
	}
	public void setNumeroMC(int numeroMC) {
		this.numeroMC = numeroMC;
	}
	
	

}
