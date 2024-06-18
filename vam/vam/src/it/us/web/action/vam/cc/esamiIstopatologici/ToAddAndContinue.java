package it.us.web.action.vam.cc.esamiIstopatologici;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAddAndContinue extends GenericAction {

	
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{
		EsameIstopatologico esame = (EsameIstopatologico) persistence.find(EsameIstopatologico.class, interoFromRequest("id") );	
		if(esame.getTipoDiagnosi().getId()!=3)
			esame.setDiagnosiNonTumorale("");
		
		//Recupero Bean CartellaClinica
		CartellaClinica cc = (CartellaClinica) esame.getCartellaClinica();

			
		req.setAttribute( "esame", esame );		

		
		ArrayList<LookupEsameIstopatologicoSedeLesione> sediLesioniPadre
		= (ArrayList<LookupEsameIstopatologicoSedeLesione>)persistence.createCriteria( LookupEsameIstopatologicoSedeLesione.class )
			.add( Restrictions.isNull( "padre" ) )
			.addOrder( Order.asc( "level" ) )
			.list();
		
		req.setAttribute( "sediLesioniPadre", sediLesioniPadre );
		
		
		gotoPage( "/jsp/vam/cc/esamiIstopatologici/addAndContinue.jsp" );
	}
}

