package it.us.web.action.validazione;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import it.us.web.action.GenericAction;
import it.us.web.bean.validazione.Richiesta;
import it.us.web.exceptions.AuthorizationException;



public class ToRichiesta extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
		isLogged();
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		String numeroRichiesta = stringaFromRequest("numeroRichiesta");
		Richiesta ric = new Richiesta(db, numeroRichiesta);
		/*
		String sql = "select * from opzioni.get_info_richiesta(?)"; 
		PreparedStatement pst;
		try {
			pst = db.prepareStatement(sql);
			pst.setString(1, numeroRichiesta);
			ResultSet rs = pst.executeQuery();
			while (rs.next()){
				ric.setQualificaId(rs.getInt("id_qualifica"));
				ric.setQualifica(rs.getString("qualifica"));
				ric.setProfiloProfessionaleId(rs.getInt("id_profilo_professionale"));
				ric.setProfiloProfessionale(rs.getString("profilo_professionale"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		req.setAttribute("dettaglioRichiesta", ric);
		gotoPage( "/jsp/validazione/richiesta.jsp" );
		
	}
	

}
