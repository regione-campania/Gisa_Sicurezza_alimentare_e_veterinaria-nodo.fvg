package org.aspcfs.modules.variazionestati.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class VariazioneWk {
	
	private int idStato = -1;
	private int idOperazione = -1;
	private int idNuovoStato = -1;
	
	public int getIdStato() {
		return idStato;
	}
	public void setIdStato(int idStato) {
		this.idStato = idStato;
	}
	public int getIdOperazione() {
		return idOperazione;
	}
	public void setIdOperazione(int idOperazione) {
		this.idOperazione = idOperazione;
	}

	
	public int getIdNuovoStato() {
		return idNuovoStato;
	}
	public void setIdNuovoStato(int idNuovoStato) {
		this.idNuovoStato = idNuovoStato;
	}
	public ArrayList<Operazione> getListaOperazioniDaStato(Connection db) {
		 ArrayList<Operazione> lista = new ArrayList<Operazione>();
		 PreparedStatement pst;
		try {
			pst = db.prepareStatement("select op.* from variazione_stato_operazioni_wk wk inner join lookup_variazione_stato_operazioni op on op.code = wk.id_operazione where wk.id_stato = ? and wk.enabled");
			pst.setInt(1, idStato);
			ResultSet rs = pst.executeQuery();
		 while (rs.next()){
			 Operazione op = new Operazione(rs);
			 lista.add(op);
		 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return lista;
		 
	}
	
	
	
	
	public int getNuovoStato(Connection db) {
		int nuovo = -1;		 
		PreparedStatement pst;
		try {
			pst = db.prepareStatement("select id_nuovo_stato from variazione_stato_operazioni_wk where id_stato = ? and id_operazione = ? and enabled");
			pst.setInt(1, idStato);
			pst.setInt(2, idOperazione);
	ResultSet rs = pst.executeQuery();
		 if (rs.next()){
			 nuovo = rs.getInt(1);
		 }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return nuovo;
		 
	}
	
	
	
	
	
	
	
}
