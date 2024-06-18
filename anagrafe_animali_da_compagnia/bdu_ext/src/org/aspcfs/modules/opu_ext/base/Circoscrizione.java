package org.aspcfs.modules.opu_ext.base;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;


public class Circoscrizione extends GenericBean {

	private int id = -1;
	private int idComune = -1;
	private String nomeCircoscrizione = "";
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdComune() {
		return idComune;
	}
	public void setIdComune(int idComune) {
		this.idComune = idComune;
	}
	public String getNomeCircoscrizione() {
		return nomeCircoscrizione;
	}
	public void setNomeCircoscrizione(String nomeCircoscrizione) {
		this.nomeCircoscrizione = nomeCircoscrizione;
	}
	public Circoscrizione() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ArrayList<Circoscrizione> getListaByIdComune(Connection db, int idComune) throws SQLException {
		ArrayList<Circoscrizione> ret = new ArrayList<Circoscrizione>();
		
		StringBuffer query = new StringBuffer("");
		
		query.append("select * from circoscrizioni");
		
		if (idComune > 0)
			query.append(" where id_comune = ?");
		
		PreparedStatement cs = db.prepareStatement(query.toString());
		if (idComune > 0)
			cs.setInt(1,idComune);
		
		ResultSet rs = cs.executeQuery();
		while (rs.next())
		{
			Circoscrizione circ = new Circoscrizione();
			circ.setId(rs.getInt("id"));
			circ.setNomeCircoscrizione(rs.getString("nome_circoscrizione"));
			ret.add(circ);
		}
//		
		return ret;
	}
	
	
	
	
	
	
	
	
	
}
