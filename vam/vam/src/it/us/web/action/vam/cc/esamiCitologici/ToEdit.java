package it.us.web.action.vam.cc.esamiCitologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.EsameCoprologico;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameCoprologicoElminti;
import it.us.web.bean.vam.lookup.LookupEsameCoprologicoProtozoi;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class ToEdit extends GenericAction implements Specie
{

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "ADD", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("citologico");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		EsameCitologico esame = (EsameCitologico) persistence.find(EsameCitologico.class, interoFromRequest("idEsame") );
		
		ArrayList<LookupEsameCitologicoTipoPrelievo> tipiPrelievo = (ArrayList<LookupEsameCitologicoTipoPrelievo>) persistence.createCriteria( LookupEsameCitologicoTipoPrelievo.class )
			.list();
		
		ArrayList<LookupEsameCitologicoDiagnosi> diagnosi = (ArrayList<LookupEsameCitologicoDiagnosi>) persistence.createCriteria( LookupEsameCitologicoDiagnosi.class )
			.list();
		
			
		req.setAttribute( "modify", true );
		req.setAttribute( "esame", esame );
		req.setAttribute( "diagnosi", diagnosi );
		req.setAttribute( "tipiPrelievo", tipiPrelievo );
		
		if(Application.get("flusso_287").equals("true"))
			gotoPage("/jsp/vam/cc/esamiCitologici/addEdit.jsp");
		else
			gotoPage("/jsp/vam/cc/esamiCitologici/addEdit_old.jsp");
	}
}

