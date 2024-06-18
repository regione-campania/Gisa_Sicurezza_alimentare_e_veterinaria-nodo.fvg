package org.aspcfs.modules.barcodecanicanile.base;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import com.darkhorseventures.framework.beans.GenericBean;

public class BarcodeAnimale extends GenericBean {

	private static Logger log = Logger
			.getLogger(org.aspcfs.modules.anagrafe_animali.base.Animale.class);
	static {
		if (System.getProperty("DEBUG") != null) {
			log.setLevel(Level.DEBUG);
		}
	}

	private int idAnimale = -1;
	private String proprietario = null;
	private String detentore = null;
	private String mantello = null;
	private String microchip = null;
	private String tatuaggio = null;
	private String specie = null;
	private String sesso = null;
	private Timestamp dataPrelievoLeish = null;
	private Timestamp dataEsitoLeish = null;
	private String esitoLeish = null;

	
	public BarcodeAnimale(ResultSet rs) throws SQLException {
		this.buildRecord(rs);
	}

	public BarcodeAnimale() {
		// TODO Auto-generated constructor stub
	}


	private void buildRecord(ResultSet rs) throws SQLException {

		this.idAnimale = rs.getInt("id");
		this.specie = rs.getString("specie");
		this.proprietario = rs.getString("proprietario");
		this.detentore = rs.getString("detentore");
		this.dataPrelievoLeish = rs.getTimestamp("data_prelievo_leish");
		this.dataEsitoLeish = rs.getTimestamp("data_esito_leish");
		this.esitoLeish = rs.getString("esito_leish");
		this.microchip = rs.getString("microchip");
		this.tatuaggio = rs.getString("tatuaggio");
		this.mantello = (rs.getString("mantello"));
		this.sesso = (rs.getString("sesso"));
		}

	public int getIdAnimale() {
		return idAnimale;
	}

	public void setIdAnimale(int idAnimale) {
		this.idAnimale = idAnimale;
	}

	public String getProprietario() {
		return proprietario;
	}

	public void setProprietario(String proprietario) {
		this.proprietario = proprietario;
	}

	public String getDetentore() {
		return detentore;
	}

	public void setDetentore(String detentore) {
		this.detentore = detentore;
	}

	public String getMantello() {
		return mantello;
	}

	public void setMantello(String mantello) {
		this.mantello = mantello;
	}

	public String getMicrochip() {
		return microchip;
	}

	public void setMicrochip(String microchip) {
		this.microchip = microchip;
	}

	public String getTatuaggio() {
		return tatuaggio;
	}

	public void setTatuaggio(String tatuaggio) {
		this.tatuaggio = tatuaggio;
	}

	public String getSesso() {
		return sesso;
	}

	public void setSesso(String sesso) {
		this.sesso = sesso;
	}
	
	public String getSpecie() {
		return specie;
	}

	public void setSpecie(String specie) {
		this.specie = specie;
	}

	public Timestamp getDataPrelievoLeish() {
		return dataPrelievoLeish;
	}

	public void setDataPrelievoLeish(Timestamp dataPrelievoLeish) {
		this.dataPrelievoLeish = dataPrelievoLeish;
	}

	public Timestamp getDataEsitoLeish() {
		return dataEsitoLeish;
	}

	public void setDataEsitoLeish(Timestamp dataEsitoLeish) {
		this.dataEsitoLeish = dataEsitoLeish;
	}

	public String getEsitoLeish() {
		return esitoLeish;
	}

	public void setEsitoLeish(String esitoLeish) {
		this.esitoLeish = esitoLeish;
	}

	
}
