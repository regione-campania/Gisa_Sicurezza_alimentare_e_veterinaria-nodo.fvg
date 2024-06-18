package org.aspcfs.modules.anagrafe_animali.gestione_modifiche;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.beans.GenericBean;

public class ModificaStatica extends GenericBean {

	private int idModifica = -1;
	private int idAnimale = -1;
	private int idSpecie = -1;
	private int idUtente = -1;
	private java.sql.Timestamp dataModifica = null;
	private String motivazioneModifica = "";
	private int nrCampiModificati = 0;
	private ArrayList<CampoModificato> listaCampiModificati = new ArrayList<CampoModificato>();

	public ModificaStatica() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getIdModifica() {
		return idModifica;
	}

	public void setIdModifica(int idModifica) {
		this.idModifica = idModifica;
	}

	public int getIdAnimale() {
		return idAnimale;
	}

	public void setIdAnimale(int idAnimale) {
		this.idAnimale = idAnimale;
	}

	public int getIdSpecie() {
		return idSpecie;
	}

	public void setIdSpecie(int idSpecie) {
		this.idSpecie = idSpecie;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}

	public java.sql.Timestamp getDataModifica() {
		return dataModifica;
	}

	public void setDataModifica(java.sql.Timestamp dataModifica) {
		this.dataModifica = dataModifica;
	}

	public int getNrCampiModificati() {
		return nrCampiModificati;
	}

	public void setNrCampiModificati(int nrCampiModificati) {
		this.nrCampiModificati = nrCampiModificati;
	}

	public String getMotivazioneModifica() {
		return motivazioneModifica;
	}

	public void setMotivazioneModifica(String motivazioneModifica) {
		this.motivazioneModifica = motivazioneModifica;
	}

	public ArrayList<CampoModificato> getListaCampiModificati() {
		return listaCampiModificati;
	}

	public void setListaCampiModificati(
			ArrayList<CampoModificato> listaCampiModificati) {
		this.listaCampiModificati = listaCampiModificati;
	}

	public boolean insert(Connection db) throws SQLException {

		StringBuffer sql = new StringBuffer();
		try {
			

			sql
					.append("INSERT INTO modifiche_statiche_animale("
							+ " id_animale, id_specie, id_utente, data_modifica, nr_campi_modificati,"
							+ " motivazione_modifica)"
							+ "VALUES (?, ?, ?, ?, ?, ?)");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idAnimale);
			pst.setInt(++i, idSpecie);
			pst.setInt(++i, idUtente);
			pst.setTimestamp(++i, dataModifica);
			pst.setInt(++i, nrCampiModificati);
			pst.setString(++i, motivazioneModifica);

			pst.execute();
			pst.close();

			this.idModifica = DatabaseUtils.getCurrVal(db,
					"modifiche_statiche_animale_id_seq", idModifica);

			for (int k = 0; k < listaCampiModificati.size(); k++) {
				CampoModificato campo = (CampoModificato) listaCampiModificati
						.get(k);
				campo.setIdModificaStatica(this.idModifica);
				campo.setIdSpecie(idSpecie);
				campo.insert(db);
			}

			

		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} finally {
			
		}
		return true;
	}
	
	
	public ModificaStatica(ResultSet rs) throws SQLException {
		this.buildRecord(rs);
	}
	
	
	public ModificaStatica(Connection db, int idModifica) throws SQLException {
		String sql = "select * from modifiche_statiche_animale where id = ? ";
		PreparedStatement pst = db.prepareStatement(sql);
		pst.setInt(1, idModifica);
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			this.buildRecord(rs);
			this.getListaCampiModificatiDb(db);
		}
	}
	
	
	private void buildRecord(ResultSet rs)  throws SQLException {
		this.idAnimale = rs.getInt("id_animale");
		this.idModifica = rs.getInt("id");
		this.dataModifica = rs.getTimestamp("data_modifica");
		this.idSpecie = rs.getInt("id_specie");
		this.idUtente = rs.getInt("id_utente");
		this.nrCampiModificati = rs.getInt("nr_campi_modificati");
		this.motivazioneModifica = rs.getString("motivazione_modifica");
		
	
	}
	
	
	public void getListaCampiModificatiDb(Connection db) throws SQLException{
		String sqlQuery = "Select * from lista_attributi_modificati_animale where id_modifica_statica = ?";
		
		PreparedStatement pst = db.prepareStatement(sqlQuery);
		pst.setInt(1, idModifica);
		
		ResultSet rs = pst.executeQuery();
		
		while (rs.next()){
			CampoModificato campo = new CampoModificato(db, rs);
			this.listaCampiModificati.add(campo);
		}
	}

}
