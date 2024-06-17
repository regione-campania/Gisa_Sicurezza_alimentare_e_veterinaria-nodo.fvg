package it.us.web.action.allineaclinichevam;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import it.us.web.action.GenericAction;
import it.us.web.bean.raggruppabduvam.Utente;
import it.us.web.bean.raggruppabduvam.UtentiList;
import it.us.web.exceptions.AuthorizationException;

public class AllineaTutteClinicheVam extends GenericAction
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
		
		int idUtenteGuc = interoFromRequest("id");
		int idUtenteOperazione = utente.getId();
		
		String esito = "";
		
		PreparedStatement pst = db.prepareStatement("select * from allinea_tutte_cliniche_vam_per_hd (?, ?)");
		int i = 0;
		pst.setInt(++i, idUtenteGuc);
		pst.setInt(++i, idUtenteOperazione);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			esito = rs.getString(1);
		
		req.setAttribute("esito", esito); 
		req.setAttribute("idUtenteGuc", String.valueOf(idUtenteGuc)); 

		gotoPage( "/jsp/allineaclinichevam/esito.jsp" );
	}


}
