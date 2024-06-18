package it.us.web.action.vam.cc.esamiCitologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameCitologico;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameCitologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupHabitat;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;

import java.sql.Connection;
import java.util.Date;
import java.util.HashSet;

import javax.naming.Context;
import javax.naming.InitialContext;

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
		setSegnalibroDocumentazione("citologico");
	}

	@SuppressWarnings("unchecked")
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
			
		EsameCitologico esame;
		
		if (booleanoFromRequest("modify")) {
			esame = (EsameCitologico) persistence.find( EsameCitologico.class, interoFromRequest( "id" ) );
		}
		else {
			esame = new EsameCitologico();
			esame.setEntered(new Date());
			esame.setEnteredBy(UtenteDAO.getUtenteAll(utente.getId(),connection));
		}
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		esame.setCartellaClinica( cc );
		
		

		
		int idDiagnosi = interoFromRequest("idDiagnosi");
		LookupEsameCitologicoDiagnosi diagnosi = null;
		if(idDiagnosi>0)
		{
			diagnosi = (LookupEsameCitologicoDiagnosi) persistence.find( LookupEsameCitologicoDiagnosi.class, interoFromRequest( "idDiagnosi" ) );
		}
		
		int padreDiagnosi = interoFromRequest("padreDiagnosi");
		LookupEsameCitologicoDiagnosi diagnosiPadre = null;
		if(padreDiagnosi>0)
		{
			diagnosiPadre = (LookupEsameCitologicoDiagnosi) persistence.find( LookupEsameCitologicoDiagnosi.class, interoFromRequest( "padreDiagnosi" ) );
		}
		
		
		esame.setDiagnosiPadre( diagnosiPadre );
		
		esame.setDiagnosi( diagnosi );
		
		
		
		
		LookupEsameCitologicoTipoPrelievo tipoPrelievo = (interoFromRequest("idTipoPrelievo")>0)?((LookupEsameCitologicoTipoPrelievo)persistence.find(LookupEsameCitologicoTipoPrelievo.class, interoFromRequest("idTipoPrelievo"))):(null);
		esame.setTipoPrelievo(tipoPrelievo);
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
		if( esame.getId() > 0 )
			validaBean( esame , new ToEdit());
		else
			validaBean( esame , new ToAdd());
		
		if( esame.getId() > 0 )
		{
			persistence.update( esame );
			setMessaggio( "Esame Citologico modificato con successo" );
		}
		else
		{
			esame.setEntered( esame.getModified() );
			esame.setEnteredBy( utente );
			
			persistence.insert( esame );
			setMessaggio( "Esame Citologico inserito con successo" );
		}
		
		if(cc.getDataChiusura()!=null)
		{
			beanModificati.add(esame);
		}
		
		cc.setModified( esame.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		persistence.commit();

		
		redirectTo( "vam.cc.esamiCitologici.Detail.us?id=" + esame.getId() );
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta/Modifica Citologico";
	}
}
