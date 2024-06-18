package it.us.web.action.vam.cc.covid;

import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Covid;
import it.us.web.bean.vam.Fip;
import it.us.web.bean.vam.lookup.LookupCovidTipoTest;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class AddEdit extends GenericAction
{
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("covid");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		Covid covid;
		
		if(booleanoFromRequest("modify"))
		{
			covid = (Covid) persistence.find( Covid.class, interoFromRequest( "id" ) );
		}
		else
		{
			covid = new Covid();
		}
		
		BeanUtils.populate( covid, req.getParameterMap() );
		
		if(req.getParameter("esito")==null || req.getParameter("esito").equals(""))
			covid.setEsito(null);
		
		LookupCovidTipoTest tipoTest = (LookupCovidTipoTest) persistence.find( LookupCovidTipoTest.class, interoFromRequest( "idTipoTest" ) );
		covid.setTipoTest(tipoTest);
		
		covid.setCartellaClinica( cc );
		covid.setModified( new Date() );
		covid.setModifiedBy( utente );
		
			
		validaBean( covid , new ToAddEdit() );
		
		if( covid.getId() > 0 )
		{
			persistence.update( covid );
			setMessaggio( "Esame SARS CoV 2 modificato con successo" );
		}
		else
		{
			covid.setEntered( covid.getModified() );
			covid.setEnteredBy( utente );
			
			persistence.insert( covid );			
			setMessaggio( "Esame SARS CoV 2 inserito con successo" );
		}
		
		cc.setModified( covid.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		persistence.commit();
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(covid);
		}
		
		redirectTo( "vam.cc.covid.List.us" );
		
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta/Modifica SARS CoV 2";
	}
}
