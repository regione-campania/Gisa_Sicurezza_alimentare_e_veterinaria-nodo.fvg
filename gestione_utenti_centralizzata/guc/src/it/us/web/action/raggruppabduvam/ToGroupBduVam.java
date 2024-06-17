package it.us.web.action.raggruppabduvam;

import it.us.web.action.GenericAction;
import it.us.web.bean.raggruppabduvam.Utente;
import it.us.web.bean.raggruppabduvam.UtentiList;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;



public class ToGroupBduVam extends GenericAction
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
		
		ArrayList<Utente> listaUtentiBDU = UtentiList.creaLista(db, "bdu");
		req.setAttribute("listaUtentiBDU", listaUtentiBDU);
		
		ArrayList<Utente> listaUtentiVAM = UtentiList.creaLista(db, "vam");
		req.setAttribute("listaUtentiVAM", listaUtentiVAM);
		
		gotoPage( "/jsp/raggruppabduvam/utentilist.jsp" );
		
	}
	

}
