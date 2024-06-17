package it.us.web.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginUtil {
	public static void gestioneLogLogin ( Connection conn, String username, String codiceFiscale, boolean accessoSpid, String endPoint) throws SQLException{
		
		PreparedStatement pst = conn.prepareStatement("select * from spid.insert_sca_storico_login(?, ?, ?, ?)");
		pst.setString(1, username);
		pst.setString(2, codiceFiscale);
		pst.setBoolean(3, accessoSpid);
		pst.setString(4, endPoint);
		pst.executeQuery();
		  
	  }
	
public static String gestioneLastLogin ( Connection conn, String username, String codiceFiscale, boolean accessoSpid, String endPoint) throws SQLException{
		
		String esito = "";
		PreparedStatement pst = conn.prepareStatement("select * from spid.check_sca_last_login(?, ?, ?, ?)");
		pst.setString(1, username);
		pst.setString(2, codiceFiscale);
		pst.setBoolean(3, accessoSpid);
		pst.setString(4, endPoint);
		ResultSet rs = pst.executeQuery();
		
		if (rs.next())
			esito = rs.getString(1);
		
		return esito;
		  
	  }
}
