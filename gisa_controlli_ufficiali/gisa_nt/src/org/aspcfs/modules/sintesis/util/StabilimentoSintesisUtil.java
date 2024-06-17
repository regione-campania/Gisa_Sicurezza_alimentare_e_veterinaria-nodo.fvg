package org.aspcfs.modules.sintesis.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StabilimentoSintesisUtil {

	
	public static int codificaLinea(Connection db, String attivita, String sezione) throws SQLException {
		
		int idLinea = -1;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		int prioritaRev[] = {10, 11, 8};
		
		for (int i = 0; i<prioritaRev.length; i++){
			int rev = prioritaRev[i];
			
			pst = db.prepareStatement("select * from mapping_linea_attivita_sintesis(?, ?, ?)");  
			pst.setInt(1,  rev);
			pst.setString(2, attivita);
			pst.setString(3, sezione);
			System.out.println("[SINTESIS] Tentativo di mapping in rev "+rev+" linea: "+pst.toString());
			rs = pst.executeQuery();
			while (rs.next()){
				idLinea = rs.getInt(1);
			}
			if (idLinea>0){
				System.out.println("[SINTESIS] Trovata in rev "+rev+" id: "+idLinea);
				break;
			}
		}
		
		return idLinea;
		
	}
	
}
