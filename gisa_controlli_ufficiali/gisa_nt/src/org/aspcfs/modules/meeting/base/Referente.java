package org.aspcfs.modules.meeting.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.darkhorseventures.framework.beans.GenericBean;

public class Referente extends GenericBean {
	
	private int id ;
	private String nominativo ;
	private int userId ;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNominativo() {
		return nominativo;
	}
	public void setNominativo(String nominativo) {
		this.nominativo = nominativo;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Referente(){}
	public Referente(Connection db,int id){ queryRecord(db, id); }
	
	public void queryRecord(Connection db , int id)
	{
		try
		{
			String select = "select id as id_referente ,nominativo as nominativo_referente,user_id_access from referenti_riunioni where id = ?";
			PreparedStatement pst = db.prepareStatement(select);
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();
			if (rs.next())
			{
				loadResultSet(rs);
			}
		}
		catch(SQLException e)
		{
			
		}
		
	}
	
	public void loadResultSet(ResultSet rs) throws SQLException {
		  
		this.setId(rs.getInt("id_referente"));
		this.setNominativo(rs.getString("nominativo_referente"));
		this.setUserId(rs.getInt("user_id_access"));
		
	}
	
}
