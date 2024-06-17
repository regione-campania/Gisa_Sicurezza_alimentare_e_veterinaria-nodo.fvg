package org.aspcfs.modules.gestioneml.base;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SuapMasterListAggregazione {
	
	private int id ; 
	private int idMacroarea ; 
	private String codiceAttivita ; 
	private String aggregazione ;
	
	
	
	public SuapMasterListAggregazione(ResultSet rs)
	{
		try
		{
			this.id 				=	rs.getInt("id");
			this.idMacroarea 		=	rs.getInt("id_macroarea");
			this.codiceAttivita 	=	rs.getString("codice_attivita");
			this.aggregazione		=	rs.getString("aggregazione");
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



	public int getIdMacroarea() {
		return idMacroarea;
	}



	public void setIdMacroarea(int idMacroarea) {
		this.idMacroarea = idMacroarea;
	}



	public String getCodiceAttivita() {
		return codiceAttivita;
	}



	public void setCodiceAttivita(String codiceAttivita) {
		this.codiceAttivita = codiceAttivita;
	}



	public String getAggregazione() {
		return aggregazione;
	}



	public void setAggregazione(String aggregazione) {
		this.aggregazione = aggregazione;
	}


	
	
	

}
