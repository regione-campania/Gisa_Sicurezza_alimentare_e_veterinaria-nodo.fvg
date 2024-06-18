package it.us.web.action.vam.richiesteIstopatologici;

import java.util.ArrayList;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.Detail;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumore;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;

public class ToAdd extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "RICHIESTA_ISTOPATOLOGICO", "ADD_LLPP", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		boolean modify = booleanoFromRequest( "modify" );
		
		if( modify )
		{
			EsameIstopatologico esame = (EsameIstopatologico) persistence.find(EsameIstopatologico.class, interoFromRequest("idEsame") );
			if(esame.getTipoDiagnosi().getId()!=3)
				esame.setDiagnosiNonTumorale("");
			req.setAttribute( "esame", esame );
		}
		
		ArrayList<LookupEsameIstopatologicoInteressamentoLinfonodale> interessamentoLinfonodales
			= (ArrayList<LookupEsameIstopatologicoInteressamentoLinfonodale>) persistence.findAll(LookupEsameIstopatologicoInteressamentoLinfonodale.class);

		ArrayList<LookupEsameIstopatologicoTumore> tumores
			= (ArrayList<LookupEsameIstopatologicoTumore>) persistence.findAll(LookupEsameIstopatologicoTumore.class);
		
		ArrayList<LookupEsameIstopatologicoTumoriPrecedenti> tumoriPrecedentis
			= (ArrayList<LookupEsameIstopatologicoTumoriPrecedenti>) persistence.findAll(LookupEsameIstopatologicoTumoriPrecedenti.class);
		
		ArrayList<LookupEsameIstopatologicoSedeLesione> sediLesioniPadre
			= (ArrayList<LookupEsameIstopatologicoSedeLesione>)persistence.createCriteria( LookupEsameIstopatologicoSedeLesione.class )
				.add( Restrictions.isNull( "padre" ) )
				.addOrder( Order.asc( "level" ) )
				.list();
		
		ArrayList<LookupEsameIstopatologicoTipoDiagnosi> tipoDiagnosis
			= (ArrayList<LookupEsameIstopatologicoTipoDiagnosi>) persistence.findAll(LookupEsameIstopatologicoTipoDiagnosi.class);
		
		ArrayList<LookupEsameIstopatologicoWhoUmana> whoUmanaPadre
			= (ArrayList<LookupEsameIstopatologicoWhoUmana>)persistence.createCriteria( LookupEsameIstopatologicoWhoUmana.class )
				.add( Restrictions.isNull( "padre" ) )
				.addOrder( Order.asc( "level" ) )
				.list();
		
		ArrayList<LookupAutopsiaSalaSettoria>		listAutopsiaSalaSettoria    = (ArrayList<LookupAutopsiaSalaSettoria>) persistence.createCriteria( LookupAutopsiaSalaSettoria.class )
				.add( Restrictions.eq( "enabled", true ) )
				.add( Restrictions.eq( "esameRiferimento", "Istopatologico" ) )
				.addOrder( Order.asc( "esterna" ) )
				.addOrder( Order.asc( "level" ) )
				.addOrder( Order.asc( "description" ) ).list();
		
		req.setAttribute( "listAutopsiaSalaSettoria", listAutopsiaSalaSettoria );
		
			
		
		req.setAttribute( "modify", modify );
		req.setAttribute( "interessamentoLinfonodales", interessamentoLinfonodales );
		req.setAttribute( "tumores", tumores );
		req.setAttribute( "tumoriPrecedentis", tumoriPrecedentis );
		req.setAttribute( "sediLesioniPadre", sediLesioniPadre );
		req.setAttribute( "tipoDiagnosis", tipoDiagnosis );
		req.setAttribute( "whoUmanaPadre", whoUmanaPadre );
		
		gotoPage("onlybody","/jsp/vam/richiesteIstopatologici/editIzsm.jsp");
	}
}

