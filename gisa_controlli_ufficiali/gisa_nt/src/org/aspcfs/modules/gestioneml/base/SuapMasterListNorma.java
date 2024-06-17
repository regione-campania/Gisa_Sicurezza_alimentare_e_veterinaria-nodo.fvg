package org.aspcfs.modules.gestioneml.base;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SuapMasterListNorma {
	
	private int id ; 
	private String codiceNorma ;
	private String norma ;
	
	
	public SuapMasterListNorma(ResultSet rs)
	{
		try
		{
			this.id 				=	rs.getInt("code");
			this.codiceNorma 		=	rs.getString("codice_norma");
			this.norma		 		=	rs.getString("description");
		}
		catch(SQLException e)
		{
			System.out.println("##ERRORE COSTRUZIONE BEAN NORMA "+e.getMessage());
		}
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getCodiceNorma() {
		return codiceNorma;
	}
	public void setCodiceNorma(String codiceNorma) {
		this.codiceNorma = codiceNorma;
	}
	public String getNorma() {
		return norma;
	}
	public void setNorma(String norma) {
		this.norma = norma;
	}
	
	
	

}
