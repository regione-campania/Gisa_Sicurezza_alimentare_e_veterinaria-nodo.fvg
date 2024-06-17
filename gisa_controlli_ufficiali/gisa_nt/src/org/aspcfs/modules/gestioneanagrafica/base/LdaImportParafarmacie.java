package org.aspcfs.modules.gestioneanagrafica.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LdaImportParafarmacie {
	
	private int id;
	private String path_descrizione;
	
	public LdaImportParafarmacie(){}
	
	public LdaImportParafarmacie(int id, String path_descrizione){
		this.setId(id);
		this.setPath_descrizione(path_descrizione);
	}
	
	public String getCodiceUnivoco(Connection db, int id_linea) throws SQLException{

		String codice_linea = "";
	    String sql = "select trim(codice) as codice "
	    		+ " from ml8_linee_attivita_nuove_materializzata "
	    		+ " where id_nuova_linea_attivita = ?";	    
	    PreparedStatement pst = db.prepareStatement(sql);
	    pst.setInt(1, id_linea);
	    ResultSet rs = pst.executeQuery();
	    
	    while(rs.next()){
	    	codice_linea = rs.getString("codice");	    	
	    }
	    rs.close();
	    pst.close();
		return codice_linea;
	}
	
	public String getDescrizioneLinea(Connection db, int id_linea) throws SQLException{

		String path_descr = "";
	    String sql = "select trim(path_descrizione) as path_descrizione "
	    		+ " from ml8_linee_attivita_nuove_materializzata "
	    		+ " where id_nuova_linea_attivita = ?";	    
	    PreparedStatement pst = db.prepareStatement(sql);
	    pst.setInt(1, id_linea);
	    ResultSet rs = pst.executeQuery();
	    
	    while(rs.next()){
	    	path_descr = rs.getString("path_descrizione");	    	
	    }
	    rs.close();
	    pst.close();
		return path_descr;
	}
	
	public boolean isNoScia(Connection db, int id_linea) throws SQLException{
		
		boolean is_no_scia = false;
		String sql = "select no_scia from master_list_flag_linee_attivita where id_linea = ?";	    
	    PreparedStatement pst = db.prepareStatement(sql);
	    pst.setInt(1, id_linea);
	    ResultSet rs = pst.executeQuery();
	    
	    while(rs.next()){
	    	if(rs.getBoolean("no_scia")){
	    		is_no_scia = rs.getBoolean("no_scia");
	    	}
	    }
	    rs.close();
	    pst.close();
	    
		return is_no_scia;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPath_descrizione() {
		return path_descrizione;
	}
	public void setPath_descrizione(String path_descrizione) {
		this.path_descrizione = path_descrizione;
	}

}
