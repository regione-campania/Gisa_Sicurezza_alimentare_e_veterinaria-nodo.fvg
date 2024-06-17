package org.aspcf.modules.checklist_benessere.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class Rendicontazione extends GenericBean{
	 
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int idCapitolo;

	private int punteggioA;
	private int punteggioB;
	private int punteggioC;
	private int punteggioTotale;
	
	private String descCap;
	 

	public int getIdCapitolo() {
		return idCapitolo;
	}

	public void setidCapitolo(int idCap) {
		this.idCapitolo = idCap;
	}

	public int getPunteggioA() {
		return punteggioA;
	}

	public void setPunteggioA(int punteggioA) {
		this.punteggioA = punteggioA;
	}

	public int getPunteggioB() {
		return punteggioB;
	}

	public void setPunteggioB(int punteggioB) {
		this.punteggioB = punteggioB;
	}

	public int getPunteggioC() {
		return punteggioC;
	}

	public void setPunteggioC(int punteggioC) {
		this.punteggioC = punteggioC;
	}

	public int getPunteggioTotale() {
		return punteggioTotale;
	}

	public void setPunteggioTotale(int punteggio) {
		this.punteggioTotale = punteggio;
	}
	
	public String getDescCap() {
		return descCap;
	}

	public void setDescCap(String descCap) {
		this.descCap = descCap;
	}



	public Rendicontazione(){ }
		
	
	public static ArrayList<Rendicontazione> buildList(Connection db, String anno, String idSpecie) throws SQLException {
		// TODO Auto-generated method stub
		
		ArrayList<Rendicontazione> rendicontazioneList = new ArrayList<Rendicontazione>();
		PreparedStatement pst = db.prepareStatement(
        "SELECT * FROM get_rendicontazione_chk_bns_animale("+anno+","+idSpecie+")");
		
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			Rendicontazione thisRisposta = new Rendicontazione(rs);
			rendicontazioneList.add(thisRisposta);
		}
		
		return rendicontazioneList;
	}
	  
	protected  void buildRecord(ResultSet rs) throws SQLException {
		 
		 //chk_bns_mod_ist table
		 idCapitolo = rs.getInt("idcapitolo");
		 
		 descCap = rs.getString("capitolo");
		 punteggioA = rs.getInt("punteggioa");
		 punteggioB = rs.getInt("punteggiob");
		 punteggioC = rs.getInt("punteggioc");
		 punteggioTotale = rs.getInt("totaleirr");
		 
		    
	 }
	  
	 public Rendicontazione(ResultSet rs) throws SQLException {
		    buildRecord(rs);
	 }
	
}
