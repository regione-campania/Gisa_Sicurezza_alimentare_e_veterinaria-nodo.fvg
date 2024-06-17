package org.aspcfs.modules.buffer.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Comune {
	private int id ;
	private String descrizione ;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public ArrayList<Comune> getComuni (Connection db)
	{
		ArrayList<Comune> lista = new ArrayList<Comune>();
		String sql = "select * from comuni1 where cod_regione='15' and notused is null order by nome ";
		try
		{	
			PreparedStatement pst = db.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next())
			{
				Comune c = new Comune ();
				c.setId(rs.getInt("id"));
				c.setDescrizione(rs.getString("nome"));
				lista.add(c);
				
			}
			
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		return lista ;
		
	}
	

}
