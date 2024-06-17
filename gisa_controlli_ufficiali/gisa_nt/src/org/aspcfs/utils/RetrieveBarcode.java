package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class RetrieveBarcode {
		
	public static int getGeneratedBarcode (String orgId, String ticketId){
		
		Connection db = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		int value = -1;
		String select = "";
				
		try
		{
			db = GestoreConnessioni.getConnection()	;
			select = " select count(*) as recordcount from etichette_verbali_prelievo where org_id = ? and ticket_id = ? ";
			pst = db.prepareStatement(select);
			int i=0;
			pst.setInt(++i,Integer.parseInt(orgId));
			pst.setInt(++i,Integer.parseInt(ticketId));
			rs = pst.executeQuery();
			while ( rs.next() )
			{
				value	= rs.getInt("recordcount")	;
									
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		finally
		{
			GestoreConnessioni.freeConnection(db);
			
		}
		
		return value;
		
	}
	
	
}
	
	   
