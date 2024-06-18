package it.us.web.action.utenti;

import java.sql.SQLException;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.permessi.Permessi;

public class List extends GenericAction
{

	@Override
	public void can() throws AuthorizationException, SQLException
	{
		BGuiView gui = GuiViewDAO.getView( "AMMINISTRAZIONE", "UTENTI", "MAIN" );
		Permessi.can( connection, utente, gui, "r" );
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
 		java.util.List utenti = persistence.createCriteria( BUtente.class )
		.add( Restrictions.eq( "enabled", true ) )
		.list();//getNamedQuery("GetListaUtenti").list();
 		persistence.commit();

		req.setAttribute( "lista_utenti", utenti );
		gotoPage( "/jsp/amministrazione/utenti/list.jsp" );
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}

}
