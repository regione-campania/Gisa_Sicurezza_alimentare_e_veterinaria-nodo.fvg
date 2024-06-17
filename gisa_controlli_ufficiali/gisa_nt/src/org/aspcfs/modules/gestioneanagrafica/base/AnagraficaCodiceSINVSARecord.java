package org.aspcfs.modules.gestioneanagrafica.base;

import java.sql.Date;

public class AnagraficaCodiceSINVSARecord {
	
	private int id;
	private int riferimentoId;
	private String riferimentoIdNomeTab;
	private String codiceSINVSA;
	private Date dataCodiceSINVSA;
	private Date entered;
	private int enteredBy;
	private Date trashedDate;
	private String noteHd;
	
	public AnagraficaCodiceSINVSARecord(int id, int riferimentoId, String riferimentoIdNomeTab, String codiceSINVSA,
			Date dataCodiceSINVSA, Date entered, int enteredBy, Date trashedDate, String noteHd) {
		this.id = id;
		this.riferimentoId = riferimentoId;
		this.riferimentoIdNomeTab = riferimentoIdNomeTab;
		this.codiceSINVSA = codiceSINVSA;
		this.dataCodiceSINVSA = dataCodiceSINVSA;
		this.entered = entered;
		this.enteredBy = enteredBy;
		this.trashedDate = trashedDate;
		this.noteHd = noteHd;
	}
	
	public int getId() {
		return id;
	}
	public int getRiferimentoId() {
		return riferimentoId;
	}
	public String getRiferimentoIdNomeTab() {
		return riferimentoIdNomeTab;
	}
	public String getCodiceSINVSA() {
		return codiceSINVSA;
	}
	public Date getDataCodiceSINVSA() {
		return dataCodiceSINVSA;
	}
	public Date getEntered() {
		return entered;
	}
	public int getEnteredBy() {
		return enteredBy;
	}
	public Date getTrashedDate() {
		return trashedDate;
	}
	public String getNoteHd() {
		return noteHd;
	}
}
