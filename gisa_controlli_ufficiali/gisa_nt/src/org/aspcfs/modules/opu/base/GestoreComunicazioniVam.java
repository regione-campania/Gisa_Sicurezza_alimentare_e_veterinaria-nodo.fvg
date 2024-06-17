package org.aspcfs.modules.opu.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.aspcfs.modules.suap.base.Stabilimento;
import org.aspcfs.utils.GestoreConnessioni;

public class GestoreComunicazioniVam {

	public GestoreComunicazioniVam() {

	}





public void aggiornaIdStabilimentoGisaBdu(int idStabGisa,int idRelStablpBdu) throws SQLException {}
	
	
public static String cessazioneAutomaticaVam(int idCanileBdu, Timestamp dataCessazione, String noteCessazione) throws SQLException {
	String output = "";
	Connection connectionVam =null ; 

		PreparedStatement pst = null;
		String select ="select * from public_functions.cessazione_clinica(-1,?,?,?);";
		
		try {
			connectionVam =GestoreConnessioni.getConnectionVam();
			pst=connectionVam.prepareStatement(select);
			int i = 0;
			pst.setInt(++i, idCanileBdu);
			pst.setTimestamp(++i, dataCessazione);
			pst.setString(++i, noteCessazione);
			System.out.println("CESSAZIONE AUTOMATICA SU VAM ---> "+pst.toString());
			ResultSet rs = pst.executeQuery();
			
			if (rs.next()){
				output = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			connectionVam.close();
		}
		return output;	
	}





public String inserisciNuovaClinicaVam(int stabId, String nome, String nomeBreve, String asl, String comune,
		String indirizzo, String email, String telefono, String noteHd) throws SQLException {
	String output = "";
	Connection connectionVam =null ; 

		PreparedStatement pst = null;
		String select ="select * from public_functions.inserimento_clinica(?,?,?, ?, ?, ?, ?, ?, ?);";
		
		try {
			connectionVam =GestoreConnessioni.getConnectionVam();
			pst=connectionVam.prepareStatement(select);
			int i = 0;
			pst.setInt(++i, stabId);
			pst.setString(++i, nome);
			pst.setString(++i, nomeBreve);
			pst.setString(++i, asl);
			pst.setString(++i, comune);
			pst.setString(++i, indirizzo);
			pst.setString(++i, email);
			pst.setString(++i, telefono);
			pst.setString(++i, noteHd);
			System.out.println("INSERIMENTO SU VAM ---> "+pst.toString());
			ResultSet rs = pst.executeQuery();
			
			if (rs.next()){
				output = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			connectionVam.close();
		}
		return output;	
	}





public void variazioneOperatoreVamSciaNoCessazione(int idStabilimentoTrovato, Stabilimento richiesta, int idUtente) throws SQLException {

	String output = "";
	Connection connectionVam =null ; 

		PreparedStatement pst = null;
		String select ="select * from public_functions.suap_variazione_titolarita(?,?,?);";
		
		try {
			connectionVam =GestoreConnessioni.getConnectionVam();
			pst=connectionVam.prepareStatement(select);
			int i = 0;
			pst.setString(++i, richiesta.getOperatore().getRagioneSociale());
			pst.setInt(++i, idUtente);
			pst.setInt(++i, idStabilimentoTrovato);
			System.out.println("VARIAZIONE SU VAM ---> "+pst.toString());
			ResultSet rs = pst.executeQuery();
			
			if (rs.next()){
				output = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			connectionVam.close();
		}
	
}

}
