package org.aspcfs.modules.registrocaricoscarico.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegistroUtil {

	public RegistroUtil() {
	}
	
	public static String[] getInfoRegistroAnagrafica(Connection db, int riferimentoId, String riferimentoIdNomeTab, int tipologiaRegistro) throws SQLException{
		
		String[] info = new String[5];
		
		PreparedStatement pst = db.prepareStatement("select * from get_info_registro_carico_scarico_anagrafica(?, ?, ?)");
		pst.setInt(1, riferimentoId);
		pst.setString(2, riferimentoIdNomeTab);
		pst.setInt(3, tipologiaRegistro);
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			info[0] = rs.getString("numero_registrazione");
			info[1] = rs.getString("id_tipologia");
			info[2] = rs.getString("riferimento_id");
			info[3] = rs.getString("riferimento_id_nome_tab");
			info[4] = rs.getString("ragione_sociale");
	}
		return info;
	}
	
	public static String[] getInfoRegistro(Connection db, int idRegistro) throws SQLException{
		
		String[] info = new String[5];
		
		PreparedStatement pst = db.prepareStatement("select * from get_info_registro_carico_scarico(?)");
		pst.setInt(1, idRegistro);
		ResultSet rs = pst.executeQuery();
		
		if (rs.next()){
			info[0] = rs.getString("numero_registrazione");
			info[1] = rs.getString("id_tipologia");
			info[2] = rs.getString("riferimento_id");
			info[3] = rs.getString("riferimento_id_nome_tab");
			info[4] = rs.getString("ragione_sociale");
	}
		return info;
	}
	
	
}
