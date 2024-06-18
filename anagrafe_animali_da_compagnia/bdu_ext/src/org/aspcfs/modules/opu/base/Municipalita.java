package org.aspcfs.modules.opu.base;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;


public class Municipalita extends GenericBean {

	private int id = -1;
	private int idComune = -1;
	private String nomeMunicipalita = "";
	
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

	public String getNomeMunicipalita() {
		return nomeMunicipalita;
	}
	public void setNomeMunicipalita(String nomeMunicipalita) {
		this.nomeMunicipalita = nomeMunicipalita;
	}
	public Municipalita() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ArrayList<Municipalita> getListaByIdComune(Connection db, int idComune) throws SQLException {
		ArrayList<Municipalita> ret = new ArrayList<Municipalita>();
		
		StringBuffer query = new StringBuffer("");
		
		query.append("select * from municipalita");
		
		if (idComune > 0)
			query.append(" where id_comune = ?");
		
		PreparedStatement cs = db.prepareStatement(query.toString());
		if (idComune > 0)
			cs.setInt(1,idComune);
		
		ResultSet rs = cs.executeQuery();
		while (rs.next())
		{
			Municipalita circ = new Municipalita();
			circ.setId(rs.getInt("id"));
			circ.setNomeMunicipalita(rs.getString("nome_municipalita"));
			ret.add(circ);
		}
//		
		return ret;
	}
	
	
	
	
	
	
	
	
	
}
