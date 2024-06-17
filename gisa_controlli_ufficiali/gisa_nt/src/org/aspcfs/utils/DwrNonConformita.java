package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.directwebremoting.extend.LoginRequiredException;

public class DwrNonConformita {
	
	
	public PunteggiNonConformita get_punteggio_non_conformita(int tipoControllo,String dataControllo)
	{
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		String sql="select * from get_punteggio_non_conformita(?,?)";
		Connection db = null;
		PunteggiNonConformita punti = new PunteggiNonConformita();
		try
		{
			db = GestoreConnessioni.getConnection();
			Timestamp dataControlloTime = new Timestamp(sdf.parse(dataControllo).getTime());
			
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setInt(1, tipoControllo);
			pst.setTimestamp(2, dataControlloTime);
			ResultSet rs= pst.executeQuery();
			if(rs.next())
			{
				punti.setPuntiformali( rs.getInt("puntiformali"));
				punti.setPuntisignificativi(rs.getInt("puntisignificativi"));
				punti.setPuntigravi( rs.getInt("puntigravi"));
			}
			
		}catch(LoginRequiredException e)
		{
			throw e;
		}catch(Exception e)
		{
			e.printStackTrace();
		
		}
		finally
		{
			GestoreConnessioni.freeConnection(db);
		}
		
		return punti;
 
	}

}
