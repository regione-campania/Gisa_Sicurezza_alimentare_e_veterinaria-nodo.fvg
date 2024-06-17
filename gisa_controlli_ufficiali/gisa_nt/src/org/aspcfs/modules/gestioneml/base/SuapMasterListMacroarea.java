package org.aspcfs.modules.gestioneml.base;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SuapMasterListMacroarea {
	
	private int id ; 
	private String codiceSezione ; 
	private String codiceNorma ;
	private String norma ;
	private String macroarea;
	
	
	public SuapMasterListMacroarea(ResultSet rs)
	{
		try
		{
			this.id 				=	rs.getInt("id");
			this.codiceSezione 		=	rs.getString("codice_sezione");
			this.codiceNorma 		=	rs.getString("codice_norma");
			this.norma		 		=	rs.getString("norma");
			this.macroarea		 	=	rs.getString("macroarea");
		}
		catch(SQLException e)
		{
			System.out.println("##ERRORE COSTRUZIONE BEAN MACROAREA "+e.getMessage());
		}
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodiceSezione() {
		return codiceSezione;
	}
	public void setCodiceSezione(String codiceSezione) {
		this.codiceSezione = codiceSezione;
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
	public String getMacroarea() {
		return macroarea;
	}
	public void setMacroarea(String macroarea) {
		this.macroarea = macroarea;
	}
	
	

}
