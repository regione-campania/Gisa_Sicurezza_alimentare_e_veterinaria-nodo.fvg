package org.aspcfs.modules.sanzioni.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Competenza {

	private int idSanzione = -1;
	private int idAutoritaCompetente = -1;
	private String descrizioneAutoritaCompetente = null;
	private int idEnteDestinatario = -1;
	private String descrizioneEnteDestinatario = null;
	
	public int getIdSanzione() {
		return idSanzione;
	}
	public void setIdSanzione(int idSanzione) {
		this.idSanzione = idSanzione;
	}
	public int getIdAutoritaCompetente() {
		return idAutoritaCompetente;
	}
	public void setIdAutoritaCompetente(int idAutoritaCompetente) {
		this.idAutoritaCompetente = idAutoritaCompetente;
	}
	public String getDescrizioneAutoritaCompetente() {
		return descrizioneAutoritaCompetente;
	}
	public void setDescrizioneAutoritaCompetente(String descrizioneAutoritaCompetente) {
		this.descrizioneAutoritaCompetente = descrizioneAutoritaCompetente;
	}
	public int getIdEnteDestinatario() {
		return idEnteDestinatario;
	}
	public void setIdEnteDestinatario(int idEnteDestinatario) {
		this.idEnteDestinatario = idEnteDestinatario;
	}
	public String getDescrizioneEnteDestinatario() {
		return descrizioneEnteDestinatario;
	}
	public void setDescrizioneEnteDestinatario(String descrizioneEnteDestinatario) {
		this.descrizioneEnteDestinatario = descrizioneEnteDestinatario;
	}
	
	public Competenza(){
		
	}
	
	public Competenza(ResultSet rs) throws SQLException{
		this.idSanzione = rs.getInt("id_sanzione");
		this.idAutoritaCompetente = rs.getInt("id_autorita_competente");
		this.idEnteDestinatario = rs.getInt("id_ente_destinatario");
		this.descrizioneAutoritaCompetente = rs.getString("descrizione_autorita_competente");
		this.descrizioneEnteDestinatario = rs.getString("descrizione_ente_destinatario");

		
	}
	public void upsert(Connection db, int userId) throws SQLException {
		PreparedStatement pst = db.prepareStatement("update sanzioni_competenze set trashed_date = now() where id_sanzione = ? and trashed_date is null");
		pst.setInt(1, idSanzione);
		pst.executeUpdate();
		
		pst = db.prepareStatement("insert into sanzioni_competenze (id_sanzione, id_autorita_competente, id_ente_destinatario, descrizione_autorita_competente, descrizione_ente_destinatario, enteredby) values (?, ?, ?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idSanzione);
		pst.setInt(++i, idAutoritaCompetente);
		pst.setInt(++i, idEnteDestinatario);
		pst.setString(++i, descrizioneAutoritaCompetente);
		pst.setString(++i, descrizioneEnteDestinatario);
		pst.setInt(++i, userId);
		pst.execute();
		
	}
}
