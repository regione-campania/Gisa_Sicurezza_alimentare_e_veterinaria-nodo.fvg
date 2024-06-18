package it.us.web.action.vam.izsm.esamiIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.vam.AnimaliUtil;

import java.sql.Connection;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

public class Find extends GenericAction {

	
	public void can() throws AuthorizationException
	{
//		BGuiView gui = GuiViewDAO.getView( "CC", "LIST", "MAIN" );
//		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		String numeroEsame = stringaFromRequest("numeroEsame");
		
		//Recupero di un esame istopatologico a partire dal numero
		ArrayList<EsameIstopatologico> esami = (ArrayList<EsameIstopatologico>) persistence.getNamedQuery("GetEsameIstopatologicoByNumero").setString("numeroEsame", numeroEsame).list();
					
		if (esami.size() == 0) {
			
			setMessaggio("Nessuna Esame con il numero inserito");				
			goToAction(new ToFind());
			
		}
		else {
			
			EsameIstopatologico esame = (EsameIstopatologico) esami.get(0);
			
			/**
			 * COMMENTATO DA VERONICA PER GESTIRE LA VISUALIZZAZIONE DEL DETTAGLIO ANCHE PER GLI ISTOPATOLOGICI CON OUTSIDECC TRUE E SENZA NUMERO CC
			 * VEDI IN ELSE SUCCESSIVO
			**/
			if(esame.getCartellaClinica()!=null)
			{
				session.setAttribute("cc", esame.getCartellaClinica());
				session.setAttribute("idCc", esame.getCartellaClinica().getId());
				cc = esame.getCartellaClinica();
			}

			ArrayList<LookupEsameIstopatologicoTipoDiagnosi> tipoDiagnosis
			= (ArrayList<LookupEsameIstopatologicoTipoDiagnosi>) persistence.findAll(LookupEsameIstopatologicoTipoDiagnosi.class);
		
			ArrayList<LookupEsameIstopatologicoWhoUmana> whoUmanaPadre
				= (ArrayList<LookupEsameIstopatologicoWhoUmana>)persistence.createCriteria( LookupEsameIstopatologicoWhoUmana.class )
					.add( Restrictions.isNull( "padre" ) )
					.addOrder( Order.asc( "level" ) )
					.list();
			
			if (esame.getOutsideCC()==true){
				req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(esame.getAnimale(), persistence, utente, new ServicesStatus(), connection,req));
				req.setAttribute("animale", esame.getAnimale());
			}
			else {
				req.setAttribute("anagraficaAnimale", AnimaliUtil.getAnagrafica(esame.getCartellaClinica().getAccettazione().getAnimale(), persistence, utente, new ServicesStatus(), connection,req));
				req.setAttribute("animale", esame.getCartellaClinica().getAccettazione().getAnimale());
				
				/**
				 * INSERITO QUA DA VERONICA PER GESTIRE LA VISUALIZZAZIONE DEL DETTAGLIO ANCHE PER GLI ISTOPATOLOGICI CON OUTSIDECC TRUE E SENZA NUMERO CC
				**/
				session.setAttribute("cc", esame.getCartellaClinica());
				session.setAttribute("idCc", esame.getCartellaClinica().getId());
				cc = esame.getCartellaClinica();
			}
			req.setAttribute( "esame", esame );	
			req.setAttribute( "tipoDiagnosis", tipoDiagnosis );
			req.setAttribute( "whoUmanaPadre", whoUmanaPadre );

									
			gotoPage("/jsp/vam/izsm/esamiIstopatologici/detail.jsp" );
			
		}
				
			
	}
}