package org.aspcfs.modules.registrocaricoscarico.base.seme;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.aspcfs.modules.registrocaricoscarico.base.Giacenza;

public class RegistroSeme {

	public static final int ID_TIPOLOGIA = 1;
	
	private int id = -1;
	private String numRegistrazioneStab = null;
	private Timestamp entered = null;
	private int enteredBy = -1;

	private ArrayList<CaricoSeme> listaCarico = new ArrayList<CaricoSeme>();
	
	public RegistroSeme() {
	}
	
	public RegistroSeme(Connection db, int id) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_scarico_istanze where id = ? and trashed_date is null and id_tipologia_registro = ?");
		pst.setInt(1, id);
		pst.setInt(2, ID_TIPOLOGIA);
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			this.id = rs.getInt("id");
			ArrayList<CaricoSeme> carico = CaricoSeme.getListaCarico(db, this.id);
			this.listaCarico = carico;
		}
		
	}
	
	public RegistroSeme(Connection db, String numRegistrazioneStab) throws SQLException {
		
		PreparedStatement pst = db.prepareStatement("select * from registro_carico_scarico_istanze where num_registrazione_stab = ? and trashed_date is null and id_tipologia_registro = ?");
		pst.setString(1, numRegistrazioneStab);
		pst.setInt(2, ID_TIPOLOGIA);
		
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			buildRecord(rs);
			ArrayList<CaricoSeme> carico = CaricoSeme.getListaCarico(db, this.id);
			this.listaCarico = carico;
		}
	}

	private void buildRecord(ResultSet rs) throws SQLException{
		this.id = rs.getInt("id");
		this.numRegistrazioneStab = rs.getString("num_registrazione_stab");
		this.entered = rs.getTimestamp("entered");
		this.enteredBy = rs.getInt("enteredby");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumRegistrazioneStab() {
		return numRegistrazioneStab;
	}

	public void setNumRegistrazioneStab(String numRegistrazioneStab) {
		this.numRegistrazioneStab = numRegistrazioneStab;
	}

	public Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}

	public int getEnteredBy() {
		return enteredBy;
	}

	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}

	public ArrayList<CaricoSeme> getListaCarico() {
		return listaCarico; 
	}

	public void setListaCarico(ArrayList<CaricoSeme> listaCarico) {
		this.listaCarico = listaCarico;
	}	
	
	public ArrayList<Giacenza> getGiacenza(Connection db) throws SQLException {
		ArrayList<Giacenza> listaGiacenza = new ArrayList<Giacenza>();
		PreparedStatement pst = db.prepareStatement("select * from get_registro_carico_scarico_giacenza(?)");
		pst.setInt(1, this.id);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			Giacenza g = new Giacenza();
			g.buildRecord(rs);
			listaGiacenza.add(g);
		}
		return listaGiacenza;
	}
	
}
