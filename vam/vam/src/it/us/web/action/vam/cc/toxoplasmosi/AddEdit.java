package it.us.web.action.vam.cc.toxoplasmosi;

import java.util.Date;

import org.apache.commons.beanutils.BeanUtils;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Toxoplasmosi;
import it.us.web.bean.vam.lookup.LookupTipoPrelievoToxoplasmosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class AddEdit extends GenericAction
{
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("toxoplasmosi");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		Toxoplasmosi esame;
		
		if(booleanoFromRequest("modify"))
		{
			esame = (Toxoplasmosi) persistence.find( Toxoplasmosi.class, interoFromRequest( "id" ) );
		}
		else
		{
			esame = new Toxoplasmosi();
		}
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		esame.setCartellaClinica( cc );
		esame.setTipoPrelievo( objectList( LookupTipoPrelievoToxoplasmosi.class, "tp_") );
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
			
		validaBean( esame,new ToAddEdit() );
		
		if( esame.getId() > 0 )
		{
			persistence.update( esame );
			setMessaggio( "Esame Toxoplasmosi modificato con successo" );
		}
		else
		{
			esame.setEntered( esame.getModified() );
			esame.setEnteredBy( utente );
			
			persistence.insert( esame );			
			setMessaggio( "Esame Toxoplasmosi inserito con successo" );
		}
		
		cc.setModified( esame.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		persistence.commit();
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(esame);
		}
		redirectTo( "vam.cc.toxoplasmosi.List.us" );
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta/Modifica Toxoplasmosi";
	}
}
