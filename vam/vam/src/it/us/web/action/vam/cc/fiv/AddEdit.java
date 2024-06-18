package it.us.web.action.vam.cc.fiv;

import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Fiv;
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
		setSegnalibroDocumentazione("fiv");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		Fiv fiv;
		
		if(booleanoFromRequest("modify"))
		{
			fiv = (Fiv) persistence.find( Fiv.class, interoFromRequest( "id" ) );
		}
		else
		{
			fiv = new Fiv();
		}
		
		BeanUtils.populate( fiv, req.getParameterMap() );
		
		fiv.setCartellaClinica( cc );
		fiv.setModified( new Date() );
		fiv.setModifiedBy( utente );
		
			
		validaBean( fiv , new ToAddEdit()  );
		
		if( fiv.getId() > 0 )
		{
			persistence.update( fiv );
			setMessaggio( "Esame Fiv modificato con successo" );
		}
		else
		{
			fiv.setEntered( fiv.getModified() );
			fiv.setEnteredBy( utente );
			
			persistence.insert( fiv );			
			setMessaggio( "Esame Fiv inserito con successo" );
		}
		
		cc.setModified( fiv.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		persistence.commit();
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(fiv);
		}
		
		redirectTo( "vam.cc.fiv.List.us" );
		
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta/Modifica Fiv";
	}
}
