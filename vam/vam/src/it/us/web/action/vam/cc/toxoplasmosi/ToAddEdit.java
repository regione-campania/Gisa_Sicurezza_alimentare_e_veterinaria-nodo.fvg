package it.us.web.action.vam.cc.toxoplasmosi;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.trasferimenti.List;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.Toxoplasmosi;
import it.us.web.bean.vam.lookup.LookupTipoPrelievoToxoplasmosi;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

import java.util.ArrayList;

public class ToAddEdit extends GenericAction
{
	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
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
		
			boolean modify = booleanoFromRequest( "modify" );
			
			if( modify )
			{
				Toxoplasmosi esame = (Toxoplasmosi) persistence.find( Toxoplasmosi.class, interoFromRequest("idEsame"));
				req.setAttribute( "esame", esame );
				req.setAttribute( "modify", true );
			}
			
			ArrayList<LookupTipoPrelievoToxoplasmosi> tipoPrelievo = (ArrayList<LookupTipoPrelievoToxoplasmosi>) persistence.findAll(LookupTipoPrelievoToxoplasmosi.class);
			CartellaClinica cc = (CartellaClinica)persistence.find (CartellaClinica.class, (Integer)session.getAttribute("idCc"));
		
			req.setAttribute( "tipoPrelievo", tipoPrelievo );		
			
			gotoPage("/jsp/vam/cc/toxoplasmosi/addEdit.jsp");
	}
}
