package it.us.web.action.vam.cc.esamiCoprologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCoprologico;
import it.us.web.bean.vam.lookup.LookupEsameCoprologicoElminti;
import it.us.web.bean.vam.lookup.LookupEsameCoprologicoProtozoi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;

public class AddEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("coprologico");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		
			
		EsameCoprologico esame;
		
		if (booleanoFromRequest("modify")) {
			esame = (EsameCoprologico) persistence.find( EsameCoprologico.class, interoFromRequest( "id" ) );
		}
		else {
			esame = new EsameCoprologico();
		}
		
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		esame.setCartellaClinica( cc );
		esame.setElminti( objectList(LookupEsameCoprologicoElminti.class, "el_") );
		esame.setProtozoi( objectList( LookupEsameCoprologicoProtozoi.class, "pr_") );
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
		if( esame.getId() > 0 )
		{
			persistence.update( esame );
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(esame);
			}
			setMessaggio( "Esame Coprologico modificato con successo" );
		}
		else
		{
			esame.setEntered( esame.getModified() );
			esame.setEnteredBy( utente );
			
			persistence.insert( esame );			
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(esame);
			}
			setMessaggio( "Esame Coprologico inserito con successo" );
		}
		
		cc.setModified( esame.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		persistence.commit();
			
		
		redirectTo( "vam.cc.esamiCoprologici.Detail.us?id=" + esame.getId() );
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta/Modifica Coprologico";
	}
}
