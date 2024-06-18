package it.us.web.action.vam.cliniche;


import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.bean.vam.Clinica;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Message;

import java.util.ArrayList;

public class AssociatesUser extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "AMMINISTRAZIONE", "UTENTI", "ASSOCIAZIONE CLINICA" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
	}

	public void execute() throws Exception
	{
		BUtente utente = ( BUtente)persistence.find(BUtente.class,interoFromRequest("idUtente"));
		ArrayList<Clinica> cliniche = (ArrayList<Clinica>)persistence.findAll(Clinica.class);
		ArrayList<Clinica> clinicheDaAssociare = new ArrayList<Clinica>();
		
		//Recupero la clinica da associare
		Clinica clinica = (Clinica)persistence.find(Clinica.class, interoFromRequest("clinica"));
		
		//Aggiorno l'assocaizione clinica all'utente
		utente.setClinica(clinica);
		
		persistence.update(utente);
		
		setMessaggio(Message.get("ASSOCIAZIONE_AVVENUTA"));
		redirectTo( "vam.cliniche.ToAssociatesUser.us" );
	}
}
