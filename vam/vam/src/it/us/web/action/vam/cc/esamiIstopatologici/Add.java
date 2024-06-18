package it.us.web.action.vam.cc.esamiIstopatologici;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.EsameIstopatologico;
import it.us.web.bean.vam.Immagine;
import it.us.web.bean.vam.lookup.LookupAutopsiaSalaSettoria;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoInteressamentoLinfonodale;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoSedeLesione;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoDiagnosi;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTipoPrelievo;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumore;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoTumoriPrecedenti;
import it.us.web.bean.vam.lookup.LookupEsameIstopatologicoWhoUmana;
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.IstopatologicoUtil;
       
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Restrictions;

public class Add extends GenericAction {

	
	public void can() throws Exception
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "EDIT", "MAIN" );
		can( gui, "w" );
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("istopatologico");
	}

	public void execute() throws Exception
	{
		
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		EsameIstopatologico esame;
		
		if (booleanoFromRequest("modify")) {
			esame = (EsameIstopatologico) persistence.find( EsameIstopatologico.class, interoFromRequest( "id" ) );
			if(esame.getTipoDiagnosi().getId()!=3)
				esame.setDiagnosiNonTumorale("");
		}
		else {
			esame = new EsameIstopatologico();
		}
		
		
		BeanUtils.populate( esame, req.getParameterMap() );
		
		esame.setOutsideCC(false);
		
		LookupEsameIstopatologicoSedeLesione sedeLesione
			= (LookupEsameIstopatologicoSedeLesione) persistence.find( LookupEsameIstopatologicoSedeLesione.class, interoFromRequest( "idSedeLesione" ) );
		LookupEsameIstopatologicoTumoriPrecedenti tumoriPrecedenti
			= (LookupEsameIstopatologicoTumoriPrecedenti) persistence.find( LookupEsameIstopatologicoTumoriPrecedenti.class, interoFromRequest( "idTumoriPrecedenti" ) );
		LookupEsameIstopatologicoInteressamentoLinfonodale interessamentoLinfonodale
			= (LookupEsameIstopatologicoInteressamentoLinfonodale) persistence.find( LookupEsameIstopatologicoInteressamentoLinfonodale.class, interoFromRequest( "idInteressamentoLinfonodale" ) );
		LookupEsameIstopatologicoTipoPrelievo tipoPrelievo
			= (LookupEsameIstopatologicoTipoPrelievo) persistence.find( LookupEsameIstopatologicoTipoPrelievo.class, interoFromRequest( "idTipoPrelievo" ) );
		LookupEsameIstopatologicoTipoDiagnosi tipoDiagnosi
			= (LookupEsameIstopatologicoTipoDiagnosi) persistence.find( LookupEsameIstopatologicoTipoDiagnosi.class, interoFromRequest( "idTipoDiagnosi" ) );

		LookupEsameIstopatologicoWhoUmana whoUmana = null;
		//LookupEsameIstopatologicoWhoAnimale whoAnimale = null;
		if( tipoDiagnosi.getId() == 1 )
		{
			whoUmana = (LookupEsameIstopatologicoWhoUmana) persistence.find( LookupEsameIstopatologicoWhoUmana.class, interoFromRequest( "idWhoUmana" ) );
		}
		else if( tipoDiagnosi.getId() == 2 )
		{
			//
		}
		
		/* Gestione del Laboratorio Destinazione */
		int idNcp = interoFromRequest("lookupAutopsiaSalaSettoria");
		
		ArrayList<LookupAutopsiaSalaSettoria> ltsList = (ArrayList<LookupAutopsiaSalaSettoria>) persistence.createCriteria( LookupAutopsiaSalaSettoria.class )
		.add( Restrictions.eq( "esameRiferimento", "Istopatologico" ) )
		.list();		
		
		LookupAutopsiaSalaSettoria lass = null;
		
		Iterator lassIterator = ltsList.iterator();
		
		while(lassIterator.hasNext()) {			
			lass = (LookupAutopsiaSalaSettoria) lassIterator.next();			
			if (lass.getId() == idNcp) 
				esame.setLass(lass);						
		}
		

//		LookupEsameIstopatologicoTumore tumore
//			= (LookupEsameIstopatologicoTumore) persistence.find( LookupEsameIstopatologicoTumore.class, interoFromRequest( "idTumore" ) );
//		esame.setTumore( tumore );
		
		esame.setCartellaClinica( cc );
		esame.setTumoriPrecedenti( tumoriPrecedenti );

		if(stringaFromRequest( "idStatoGeneraleLookup" )!=null && !stringaFromRequest( "idStatoGeneraleLookup" ).equals(""))
		{
			LookupStatoGenerale statoGenerale = (LookupStatoGenerale) persistence.find( LookupStatoGenerale.class, interoFromRequest( "idStatoGeneraleLookup" ) );
			esame.setStatoGeneraleLookup(statoGenerale);
		}
		
		if(stringaFromRequest( "idTumore" )!=null && !stringaFromRequest( "idTumore" ).equals(""))
		{
			LookupEsameIstopatologicoTumore tumore = (LookupEsameIstopatologicoTumore) persistence.find( LookupEsameIstopatologicoTumore.class, interoFromRequest( "idTumore" ) );
			esame.setTumore(tumore);
		}
		
		
		esame.setTipoPrelievo( tipoPrelievo );
		esame.setInteressamentoLinfonodale( interessamentoLinfonodale );
		esame.setSedeLesione( sedeLesione );
		esame.setTipoDiagnosi( tipoDiagnosi );
		esame.setWhoUmana( whoUmana );
		
		
		esame.setModified( new Date() );
		esame.setModifiedBy( utente );
		
		if( esame.getId() > 0 )
		{
			persistence.update( esame );
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(esame);
			}
			setMessaggio( "Esame Istopatologico modificato con successo" );
		}
		else
		{
			esame.setEntered( new Date() );
			esame.setEnteredBy( utente );
			
			esame.setNumero(IstopatologicoUtil.getNumero(connection));
			persistence.insert( esame );			
			if(cc.getDataChiusura()!=null)
			{
				beanModificati.add(esame);
			}
			setMessaggio( "Esame Istopatologico inserito con successo" );
		}

		cc.setModified( esame.getModified() );
		cc.setModifiedBy( utente );
		persistence.update( cc );
		
		ArrayList<Immagine> imm = (ArrayList<Immagine>) persistence.createCriteria( Immagine.class )
				 .add( Restrictions.eq( "accettazione", cc.getAccettazione() ))
				 .add( Restrictions.eq( "idRefClass", -1))
				 .list();
		 Iterator i = imm.iterator();
		 while(i.hasNext()){
			 Immagine im = (Immagine)i.next();
			 im.setIdRefClass(esame.getId());
			 persistence.update(im);
		 }
		 
		 
		persistence.commit();
		
	
		String mess = "";
		if (esame.getCartellaClinica().getPeso()==null || esame.getCartellaClinica().getPeso().equals("")){
			mess = mess+" peso,";
		}
		if (esame.getCartellaClinica().getLookupAlimentazionis().size() == 0){
			mess = mess+" alimentazione,";
		}
		if (esame.getCartellaClinica().getLookupHabitats().size() == 0){
			mess = mess+" habitat,";
		}
		
		if (!mess.equals("")) 
		{
			setMessaggio( "Potresti aggiungere i seguenti dettagli alla richiesta :" + mess+" cliccando sull'apposito bottone nella home dalla cc." );
		}
		redirectTo( "vam.cc.esamiIstopatologici.Detail.us?id=" + esame.getId() );
	}
	
	@Override
	public String getDescrizione()
	{
		return "Aggiunta Istopatologico";
	}
}
