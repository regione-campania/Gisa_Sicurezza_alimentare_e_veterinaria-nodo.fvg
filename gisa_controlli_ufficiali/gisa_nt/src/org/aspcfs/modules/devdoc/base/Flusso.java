package org.aspcfs.modules.devdoc.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.aspcfs.utils.DatabaseUtils;

import com.darkhorseventures.framework.beans.GenericBean;

public class Flusso extends GenericBean {

	private int id;
	private int idFlusso;
	private int idPriorita;
	private Timestamp data;
	private Timestamp dataUltimaModifica;
	private String descrizione;
	private String tags;
	private int idReferente;
	private int idStato;
	private String ambito = null;
	private String noteAggiornamentiPriorita;
	private Integer giornateEffort;
	private Integer giornateElapsed;
	private String dataInizioSviluppo;
	private String dataPrevistaCollaudo;
	
	private ModuloList moduli = new ModuloList();
	private ArrayList<FlussoNota> note = new ArrayList<FlussoNota>();
	private ArrayList<FlussoStato> stati = new ArrayList<FlussoStato>();

	public static final int STATO_APERTO = 1;
	public static final int STATO_CONSEGNATO = 2;
	public static final int STATO_COLLAUDATO = 3;
	public static final int STATO_STANDBY = 4;
	public static final int STATO_ANNULLATO = 5;
	public static final int STATO_CHIARIMENTI = 6;
	public static final int STATO_SVILUPPO_IN_CORSO = 7;

	

	public Flusso(ResultSet rs) throws SQLException {
		// TODO Auto-generated constructor stub
		loadResultSet(rs);
	}

	public Flusso(ResultSet rs, Connection db) throws SQLException {
		// TODO Auto-generated constructor stub
		loadResultSet(rs);
		ModuloList moduli = new ModuloList();
		moduli.buildList(db, idFlusso);
		this.setModuli(moduli);
	}

	public Flusso() {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdFlusso() {
		return idFlusso;
	}

	public void setIdFlusso(int idFlusso) {
		this.id = idFlusso;
	}

	public int getIdPriorita() {
		return idPriorita;
	}

	public void setIdPriorita(int idPriorita) {
		this.idPriorita = idPriorita;
	}

	public Timestamp getData() {
		return data;
	}

	public void setData(Timestamp data) {
		this.data = data;
	}

	public Timestamp getDataUltimaModifica() {
		return dataUltimaModifica;
	}

	public void setDataUltimaModifica(Timestamp dataUltimaModifica) {
		this.dataUltimaModifica = dataUltimaModifica;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public ModuloList getModuli() {
		return moduli;
	}

	public void setModuli(ModuloList moduli) {
		this.moduli = moduli;
	}

	public void setIdFlusso(String idFlusso) {
		try {
			this.idFlusso = Integer.parseInt(idFlusso);
		} catch (Exception e) {
		}
	}

	public String getNoteAggiornamentiPriorita() {
		return noteAggiornamentiPriorita;
	}

	public void setNoteAggiornamentiPriorita(String noteAggiornamentiPriorita) {
		this.noteAggiornamentiPriorita = noteAggiornamentiPriorita;
	}

	public ArrayList<FlussoNota> getNote() {
		return note;
	}

	public void setNote(ArrayList<FlussoNota> note) {
		this.note = note;
	}

	public void gestioneInserimento(Connection db) throws SQLException {
		Flusso flusso = new Flusso();
		flusso.queryRecord(db, idFlusso);
		if (flusso.getId() > 0) {
			this.id = flusso.getId();
			updateTags(db);
			if (idReferente > 0)
				updateReferente(db, -1);
		} else{
			insert(db);
		}
	}

	public void insert(Connection db) {
		String insert = "INSERT INTO sviluppo_flussi (id,id_flusso, data, data_ultima_modifica, descrizione, tags, id_referente, id_stato,id_priorita,ambito) values ( ?, ?, now(), now(), ?,?, ?, ?,?,'')";
		PreparedStatement pst = null;
		try {
			this.id = DatabaseUtils.getNextSeq(db, "sviluppo_flussi_id_seq");

			int i = 0;
			pst = db.prepareStatement(insert);

			pst.setInt(++i, id);
			pst.setInt(++i, idFlusso);
			pst.setString(++i, descrizione);
			pst.setString(++i, tags);
			pst.setInt(++i, idReferente);
			pst.setInt(++i, STATO_APERTO);
			pst.setInt(++i, 2);

			pst.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void queryRecord(Connection db, int idFlusso) {
		String select = "select * from sviluppo_flussi where id_flusso =? and data_cancellazione is null";

		try {
			PreparedStatement pst = db.prepareStatement(select);
			pst.setInt(1, idFlusso);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				loadResultSet(rs);
				ModuloList moduli = new ModuloList();
				moduli.buildList(db, idFlusso);
				this.setModuli(moduli);
				this.setNote(this.fetchNote(db));
				this.setStati(this.fetchStati(db));

			}
		} catch (SQLException e) {

		}

	}

	public void loadResultSet(ResultSet rs) throws SQLException {

		try {
			id = rs.getInt("id");
			idFlusso = rs.getInt("id_flusso");
			idPriorita = rs.getInt("id_priorita");
			idReferente = rs.getInt("id_referente");
			ambito = rs.getString("ambito");
			giornateEffort = rs.getInt("giornate_stimate_effort");
			giornateElapsed =rs.getInt("giornate_stimate_elapsed");
			dataInizioSviluppo = rs.getString("data_inizio_sviluppo");
			dataPrevistaCollaudo = rs.getString("data_previsto_collaudo");
			idStato = rs.getInt("id_stato");
			data = rs.getTimestamp("data");
			dataUltimaModifica = rs.getTimestamp("data_ultima_modifica");
			descrizione = rs.getString("descrizione");
			tags = rs.getString("tags");
			noteAggiornamentiPriorita = rs.getString("note_aggiornamenti_priorita");
		} catch (SQLException e) {
			throw e;
		}
	}

	public void updateTags(Connection db) {
		String update = "UPDATE sviluppo_flussi set tags = ?, data_ultima_modifica = now() where id = ? ";
		PreparedStatement pst = null;
		try {

			int i = 0;
			pst = db.prepareStatement(update);
			pst.setString(++i, tags);
			pst.setInt(++i, id);
			pst.execute();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updatePriorita(Connection db, int userId) throws SQLException {
		String query = "UPDATE sviluppo_flussi "
				     + "set id_priorita = ?,"
				     + "note_aggiornamenti_priorita = concat(note_aggiornamenti_priorita, 'user: ', ?, ' priorita: ', ?, ' data: ', now(), ';;')  "
				     + " where id_flusso = ?";
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, idPriorita);
			pst.setInt(2, userId);
			pst.setInt(3, idPriorita);
			pst.setInt(4, idFlusso);
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateReferente(Connection db, int userId) throws SQLException {
		String query = "UPDATE sviluppo_flussi "
				     + "set id_referente = ?,"
				     + "note_aggiornamenti_referente = concat(note_aggiornamenti_referente, 'user: ', ?, ' referente: ', ?, ' data: ', now(), ';;')  "
				     + " where id_flusso = ?";
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, idReferente);
			pst.setInt(2, userId);
			pst.setInt(3, idReferente);
			pst.setInt(4, idFlusso);
			pst.executeUpdate();
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}

	public boolean hasModulo(int tipoModulo) {
		ModuloList listaModuli = this.getModuli();
		for (int i = 0; i < listaModuli.size(); i++) {
			if (((Modulo) listaModuli.get(i)).getIdTipo() == tipoModulo)
				return true;
		}
		return false;
	}
	
	public boolean aggiungiNota(Connection db, int userId, String nota) throws SQLException {
		String query = "insert into sviluppo_note_flusso(nota, id_flusso, id_utente)"
					 + "values(?,?,?)";
		
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setString(1, nota);
			pst.setInt(2, this.idFlusso);
			pst.setInt(3, userId);
			pst.execute();
			return true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	public ArrayList<FlussoNota> fetchNote(Connection db) throws SQLException {
		String query = "select * from sviluppo_note_flusso where id_flusso = ? order by data_inserimento desc";
		PreparedStatement pst = null;
		ResultSet set = null;
		ArrayList<FlussoNota> note = new ArrayList<FlussoNota>();
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, this.idFlusso);
			set = pst.executeQuery();
			while(set.next()) {
				note.add(new FlussoNota(
							set.getInt("id"),
							set.getString("nota"),
							set.getInt("id_flusso"),
							set.getInt("id_utente"),
							set.getTimestamp("data_inserimento"),
							set.getTimestamp("data_cancellazione")
						)
				);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return note;
	}
	
	public ArrayList<FlussoStato> fetchStati(Connection db) throws SQLException {
		String query = "select * from sviluppo_stati_flusso where id_flusso = ? and enabled order by entered desc";
		PreparedStatement pst = null;
		ResultSet set = null;
		ArrayList<FlussoStato> stati = new ArrayList<FlussoStato>();
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, this.idFlusso);
			set = pst.executeQuery();
			while(set.next()) {
				stati.add(new FlussoStato(
							set.getInt("id"),
							set.getInt("id_flusso"),
							set.getInt("id_stato"),
							set.getString("note"),
							set.getString("data"),
							set.getTimestamp("entered"),
							set.getInt("id_utente")
						)
				);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return stati;
	}

	public int getIdReferente() {
		return idReferente;
	}

	public void setIdReferente(int idReferente) {
		this.idReferente = idReferente;
	}
	public void setIdReferente(String idReferente) {
		try {
			this.idReferente = Integer.parseInt(idReferente);
		} catch (Exception e) {
		}
	}

	public int getIdStato() {
		return idStato;
	}

	public void setIdStato(int idStato) {
		this.idStato = idStato;
	}

	public ArrayList<FlussoStato> getStati() {
		return stati;
	}

	public void setStati(ArrayList<FlussoStato> stati) {
		this.stati = stati;
	}

	public void updateStato(Connection db, int idStato, String noteCambioStato, String dataCambioStato, int userId) {

			String query = "UPDATE sviluppo_flussi "
					     + "set id_stato = ?,"
					     + "data_ultima_modifica = now()  "
					     + " where id_flusso = ?";
			PreparedStatement pst = null;
			try {
				pst = db.prepareStatement(query);
				pst.setInt(1, idStato);
				pst.setInt(2, idFlusso);
				pst.executeUpdate();
			} catch (Exception e) { 
				e.printStackTrace();
			}
		
			 query = "insert into sviluppo_stati_flusso(id_flusso, id_stato, id_utente, note, data)"
					 + "values(?,?,?, ?, ?)";
		
		 pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, this.idFlusso);
			pst.setInt(2, idStato);
			pst.setInt(3, userId);
			pst.setString(4, noteCambioStato);
			pst.setString(5, dataCambioStato);

			pst.execute();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	
	
	
	
	public void updateAmbito(Connection db, String ambito) {

		String query = "UPDATE sviluppo_flussi "
				     + "set ambito = ?"
				     + " where id_flusso = ?";
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setString(1, ambito);
			pst.setInt(2, idFlusso);
			pst.executeUpdate();
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	
	public void updateGiorni(Connection db, Integer giorni_effort,Integer giorni_elapsed,String dataSviluppo,String dataCollaudo,Boolean full) {
		
		if (full ==true){
		String query = "UPDATE sviluppo_flussi "
				     + "set giornate_stimate_effort = ?, giornate_stimate_elapsed=?, data_inizio_sviluppo=?::timestamp,data_previsto_collaudo=?::timestamp "
				     + " where id_flusso = ?";
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setInt(1, giorni_effort);
			pst.setInt(2, giorni_elapsed);
			pst.setString(3, dataSviluppo);
			pst.setString(4, dataCollaudo);

			pst.setInt(5, idFlusso);
			pst.executeUpdate();
			
			
			
			
		
		} catch (Exception e) { 
			e.printStackTrace();
		}
		}else{
			String query = "UPDATE sviluppo_flussi "
				     + "set data_inizio_sviluppo=?::timestamp,data_previsto_collaudo=?::timestamp "
				     + " where id_flusso = ?";
		PreparedStatement pst = null;
		try {
			pst = db.prepareStatement(query);
			pst.setString(1, dataSviluppo);
			pst.setString(2, dataCollaudo);

			pst.setInt(3, idFlusso);
			pst.executeUpdate();
			
			
			
			
		
		} catch (Exception e) { 
			e.printStackTrace();
		}
			
			
			
		}
	}
	
	
	
	public String getAmbito() {
		return ambito;
	}

	public void setAmbito(String ambito) {
		this.ambito = ambito;
	}

	public Integer getGiornateEffort() {
		return giornateEffort;
	}

	public void setGiornateEffort(Integer giornateEffort) {
		this.giornateEffort = giornateEffort;
	}

	public Integer getGiornateElapsed() {
		return giornateElapsed;
	}

	public void setGiornateElapsed(Integer giornateElapsed) {
		this.giornateElapsed = giornateElapsed;
	}

	public String getDataInizioSviluppo() {
		return dataInizioSviluppo;
	}

	public void setDataInizioSviluppo(String dataInizioSviluppo) {
		this.dataInizioSviluppo = dataInizioSviluppo;
	}

	public String getDataPrevistaCollaudo() {
		return dataPrevistaCollaudo;
	}

	public void setDataPrevistaCollaudo(String dataPrevistaCollaudo) {
		this.dataPrevistaCollaudo = dataPrevistaCollaudo;
	}
}
