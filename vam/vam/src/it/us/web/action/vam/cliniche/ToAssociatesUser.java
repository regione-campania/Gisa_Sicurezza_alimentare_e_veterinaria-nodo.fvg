package it.us.web.action.vam.cliniche;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.vam.Accettazione;
import it.us.web.bean.vam.Clinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.DateUtils;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class ToAssociatesUser extends GenericAction {

	
	public void execute() throws Exception
	{
		//Recupero Utenti già associati ad una clinica
		List<BUtente> utentiAssociati = persistence.createCriteria( BUtente.class )
		.add( Restrictions.isNotNull("clinica") )
		.list();
		req.setAttribute("utentiAssociati", utentiAssociati);
		
		//Recupero Utenti senza cliniche associate
		List<BUtente> utentiNonAssociati = persistence.createCriteria( BUtente.class )
		.add( Restrictions.isNull("clinica") )
		.list();
		req.setAttribute("utentiNonAssociati", utentiNonAssociati);

		//Recupero elenco Cliniche
		ArrayList<Clinica> elencoCliniche = (ArrayList<Clinica>)persistence.findAll(Clinica.class);
		req.setAttribute("elencoCliniche", elencoCliniche);
		
		gotoPage( "/jsp/vam/cliniche/associatesUser.jsp" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}
	
	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "AMMINISTRAZIONE", "UTENTI", "ASSOCIAZIONE CLINICA" );
		can( gui, "w" );
	}
}