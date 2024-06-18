package it.us.web.util.webServices;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Services {

	public static final String GET_RUOLI 		= "SELECT * FROM permessi_ruoli";
	
	public static final String GET_CLINICHE		= "SELECT * FROM clinica";
	
	public static final String INSERT_UTENTE 	= "INSERT INTO utenti (cap, codice_fiscale, cognome, comune, comune_nascita, data_nascita, email, entered, entered_by, fax, indirizzo, modified, modified_by, nome, password, provincia, stato, telefono1, telefono2, username, clinica) " +
													"VALUES ( ?, ?, ?, ?, ?, ?,?, current_timestamp, 1, ?, ?, current_timestamp, 1, ?, MD5(?), ?, ?, ?, ?, ?, ?)";
    		
	/* Per ottenere i ruoli configurati nell'applicazione*/
    public static ArrayList<String> getRuoli() throws ClassNotFoundException{
    	
    	Connection con = DBConnection.getConnection();
    	
    	ArrayList<String> ruoli = new ArrayList<String>();
    	ResultSet rs = null;
    	PreparedStatement ps = null;
    	
    	try
    	{
    		ps = con.prepareStatement(GET_RUOLI);
    		
    		rs = ps.executeQuery();
    		
    		while (rs.next()){
    			ruoli.add(rs.getString("nome"));
    		}
    	}
    	catch(Exception ex)
    	{
    		DBConnection.closeDBServer(con);
    		ex.printStackTrace();
    	}
    	finally
    	{
    		DBConnection.closeResources(ps);
    	}
    	return ruoli;
    }
   
    
    public static int insertUtente () throws ClassNotFoundException{
    	
    	Connection con = DBConnection.getConnection();
    	
    	PreparedStatement ps = null;
    	int res = 0;
    	
    	try{
    		ps = con.prepareStatement(INSERT_UTENTE);
    		
    		res = ps.executeUpdate();
    		
    	}catch(Exception e)
    	{
    		DBConnection.closeDBServer(con);
    		e.printStackTrace();
    	}finally
    	{
    		DBConnection.closeResources(ps);
    	}
    	return res;
    }
    	
  
	
}
