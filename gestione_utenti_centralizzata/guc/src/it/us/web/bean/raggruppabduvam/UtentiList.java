package it.us.web.bean.raggruppabduvam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;


public class UtentiList extends Vector  {
	
	public static ArrayList<Utente> creaLista(Connection db, String endpoint){
		
		ArrayList<Utente> lista = new ArrayList<Utente>();
		
		String sql = "select * from lista_utenti(?)"; 
		try {
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setString(1, endpoint);

			ResultSet rs = pst.executeQuery();
			while (rs.next()){
				Utente u = new Utente(rs);
				lista.add(u);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return lista;
		}
		
}
