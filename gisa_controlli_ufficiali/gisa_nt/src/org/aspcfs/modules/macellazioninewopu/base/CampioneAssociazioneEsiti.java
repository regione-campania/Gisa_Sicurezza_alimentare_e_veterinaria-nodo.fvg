package org.aspcfs.modules.macellazioninewopu.base;

import java.sql.Timestamp;

public class CampioneAssociazioneEsiti extends Campione
{
	private static final long serialVersionUID = 8313006891554941893L;
	
	private int id;
	private int idCapo;
	private int idSeduta; 
	private String matricola;
	private String numeroMacellazione;
	private String tipoMacellazione;
	private Timestamp dataMacellazione;
	private String impresa;
	private String motivo;
	private String matriceDesc;
	private String tipoAnalisi;
	private String molecole;
	private String noteMolecole;
	
	public int getIdCapo() {
		return idCapo;
	}

	public void setIdCapo(int idCapo) {
		this.idCapo = idCapo;
	}
	
	public int getIdSeduta() {
		return idSeduta;
	}
	public void setIdSeduta(int idSeduta) {
		this.idSeduta = idSeduta;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getMatricola() {
		return matricola;
	}

	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}

	public String getNumeroMacellazione() {
		return numeroMacellazione;
	}

	public void setNumeroMacellazione(String numeroMacellazione) {
		this.numeroMacellazione = numeroMacellazione;
	}

	public String getTipoMacellazione() {
		return tipoMacellazione;
	}

	public void setTipoMacellazione(String tipoMacellazione) {
		this.tipoMacellazione = tipoMacellazione;
	}

	public Timestamp getDataMacellazione() {
		return dataMacellazione;
	}

	public void setDataMacellazione(Timestamp dataMacellazione) {
		this.dataMacellazione = dataMacellazione;
	}

	public String getImpresa() {
		return impresa;
	}

	public void setImpresa(String impresa) {
		this.impresa = impresa;
	}

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public String getMatriceDesc() {
		return matriceDesc;
	}

	public void setMatriceDesc(String matriceDesc) {
		this.matriceDesc = matriceDesc;
	}

	public String getTipoAnalisi() {
		return tipoAnalisi;
	}

	public void setTipoAnalisi(String tipoAnalisi) {
		this.tipoAnalisi = tipoAnalisi;
	}

	public String getMolecole() {
		return molecole;
	}

	public void setMolecole(String molecole) {
		this.molecole = molecole;
	}
	
	public String getNoteMolecole() {
		return noteMolecole;
	}

	public void setNoteMolecole(String noteMolecole) {
		this.noteMolecole = noteMolecole;
	}


	

}
