package it.us.web.action.vam.cc.diarioClinico;

import org.apache.commons.beanutils.BeanUtils;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.DiarioClinico;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class OsservazioniEdit extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("diarioClinico");
	}

	public void execute() throws Exception
	{
		int idDc = interoFromRequest( "idDc" );
		DiarioClinico dc = (DiarioClinico) persistence.find( DiarioClinico.class, idDc );
		
		BeanUtils.populate( dc, req.getParameterMap() );
		
		persistence.update( dc );
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(dc);
		}
		
		setMessaggio( "Osservazione modificata con successo" );
		
		redirectTo( "vam.cc.diarioClinico.Detail.us" );
	}
	
	@Override
	public String getDescrizione()
	{
		return "Modifica Diario clinico";
	}
}



