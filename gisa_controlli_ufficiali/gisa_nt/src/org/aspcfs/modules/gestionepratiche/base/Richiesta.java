package org.aspcfs.modules.gestionepratiche.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Richiesta {
	
	private int code;
	private String long_description;
	ArrayList<Richiesta> richieste = new ArrayList<Richiesta>();
	
	
	public ArrayList<Richiesta> getRichieste() {
		return richieste;
	}

	public void setRichieste(ArrayList<Richiesta> richieste) {
		this.richieste = richieste;
	}
	public Richiesta(){};
	
	public Richiesta(int code, String long_description){
		this.setCode(code);
		this.setLong_description(long_description);
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getLong_description() {
		return long_description;
	}

	public void setLong_description(String long_description) {
		this.long_description = long_description;
	};
	

	public void getTipoRichiesta(Connection db)  throws SQLException {
		
		// TODO Auto-generated method stub
		String sql = "select code, long_description from suap_lookup_tipo_richiesta where gins order by code";
    	PreparedStatement st = db.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
		while(rs.next()){
       	 Richiesta richiesta = new Richiesta(rs.getInt("code"), rs.getString("long_description"));
         richieste.add(richiesta);    
        }
	}

	public void insertPratica(Connection db) throws SQLException {
		// TODO Auto-generated method stub
		
	};
}
