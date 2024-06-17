package org.aspcfs.modules.macellazioniopu.base;

import java.sql.Timestamp;

public class StampeModuli {
	
	private int id;
	private int tipoModulo;
	private Timestamp dataModulo;
	private int aslMacello;
	private int idMacello;
	private int progressivo;
	private int oldProgressivo;
	private int hashCode;
	private String matricolaCapo;
	private int idSpeditore;
	private String malattiaCapo;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTipoModulo() {
		return tipoModulo;
	}
	public void setTipoModulo(int tipoModulo) {
		this.tipoModulo = tipoModulo;
	}
	public Timestamp getDataModulo() {
		return dataModulo;
	}
	public void setDataModulo(Timestamp dataModulo) {
		this.dataModulo = dataModulo;
	}
	public int getAslMacello() {
		return aslMacello;
	}
	public void setAslMacello(int aslMacello) {
		this.aslMacello = aslMacello;
	}
	public int getIdMacello() {
		return idMacello;
	}
	public void setIdMacello(int idMacello) {
		this.idMacello = idMacello;
	}
	public int getProgressivo() {
		return progressivo;
	}
	public void setProgressivo(int progressivo) {
		this.progressivo = progressivo;
	}
	public String getMatricolaCapo() {
		return matricolaCapo;
	}
	public void setMatricolaCapo(String matricolaCapo) {
		this.matricolaCapo = matricolaCapo;
	}
	public int getIdSpeditore() {
		return idSpeditore;
	}
	public void setIdSpeditore(int idSpeditore) {
		this.idSpeditore = idSpeditore;
	}
	public String getMalattiaCapo() {
		return malattiaCapo;
	}
	public void setMalattiaCapo(String malattiaCapo) {
		this.malattiaCapo = malattiaCapo;
	}
	public int getOldProgressivo() {
		return oldProgressivo;
	}
	public void setOldProgressivo(int oldProgressivo) {
		this.oldProgressivo = oldProgressivo;
	}
	public int getHashCode() {
		return hashCode;
	}
	public void setHashCode(int hashCode) {
		this.hashCode = hashCode;
	}
	
	
	
}
