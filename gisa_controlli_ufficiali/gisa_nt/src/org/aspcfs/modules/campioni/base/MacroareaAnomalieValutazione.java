package org.aspcfs.modules.campioni.base;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MacroareaAnomalieValutazione implements Serializable {

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

	public void insert(Connection db,int idScheda)
	{
		try
		{


			String insert = "insert into iuv_campioni_valutazione_comportamentale_anomalie (id_iuv_valutazione,id_anomalia) values (?,?)";
			PreparedStatement pst = db.prepareStatement(insert);
			int i = 0 ;
			pst.setInt(++i, idScheda);
			pst.setInt(++i, id);
			pst.execute();


		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}

	}

	public void update(Connection db,int idScheda)
	{
			
			insert(db, idScheda);


		
		
	}

	public MacroareaAnomalieValutazione(){}
	public MacroareaAnomalieValutazione(int idAnomalie){ id = idAnomalie;}
	public MacroareaAnomalieValutazione(ResultSet rs) throws SQLException{

		this.buildRecord(rs);
	}

	private void buildRecord(ResultSet rs) throws SQLException
	{

		id = rs.getInt("code");
		descrizione = rs.getString("description");


	}
}
