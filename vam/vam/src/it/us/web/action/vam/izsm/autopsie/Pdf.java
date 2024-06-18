package it.us.web.action.vam.izsm.autopsie;


import java.awt.Color;
import java.io.InputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletOutputStream;

import sun.security.krb5.internal.ccache.CCacheInputStream;

import com.itextpdf.text.Element;



import it.us.web.action.GenericAction;
import it.us.web.action.vam.cc.decessi.ToAdd;
import it.us.web.bean.BGuiView;
import it.us.web.bean.ServicesStatus;
import it.us.web.bean.remoteBean.Cane;
import it.us.web.bean.remoteBean.Gatto;
import it.us.web.bean.remoteBean.RegistrazioniCaninaResponse;
import it.us.web.bean.remoteBean.RegistrazioniFelinaResponse;
import it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Autopsia;
import it.us.web.bean.vam.AutopsiaOrganoPatologie;
import it.us.web.bean.vam.lookup.LookupTaglie;
import it.us.web.constants.Specie;
import it.us.web.dao.GuiViewDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.PdfUtil;
import it.us.web.util.report.PdfReport;
import it.us.web.util.sinantropi.SinantropoUtil;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.FelinaRemoteUtil;


public class Pdf extends GenericAction 
{

	@Override
	public void can() throws AuthorizationException
	{
		BGuiView gui = GuiViewDAO.getView( "CC", "DETAIL", "MAIN" );
		can( gui, "w" );
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("esameNecroscopico");
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		aggiornaConnessioneApertaSessione(req);
		setConnectionBdu(connection);
		Autopsia autopsia = (Autopsia) persistence.find (Autopsia.class, interoFromRequest("id") );	
		Animale animale = autopsia.getCartellaClinica().getAccettazione().getAnimale();
		
		//PARTE STATICA - I PARTE
		Map<String, Object> mappaProprietaAddizionali = new Hashtable<String, Object>();
		ServicesStatus status = new ServicesStatus();
		if(!animale.getDecedutoNonAnagrafe())
		{
			if (animale.getLookupSpecie().getId() == Specie.CANE) 
			{
				RegistrazioniCaninaResponse res	= CaninaRemoteUtil.getInfoDecesso( animale.getIdentificativo(), utente, null, connection, req );
				mappaProprietaAddizionali.put("dataMorte", (res==null || res.getDataEvento()==null)?(""):(res.getDataEvento()));
				mappaProprietaAddizionali.put("dataMorteCertezza", (res==null)?(""):(res.getDataMorteCertezza()));
				mappaProprietaAddizionali.put("causaMorte", (res==null || res.getDecessoValue()==null)?(""):(res.getDecessoValue()));
				//
				Cane cane = CaninaRemoteUtil.findCane(animale.getIdentificativo(), utente, status, connection, req);
				if(animale.getTaglia()!=null)
					mappaProprietaAddizionali.put("tagliaAnimale", (cane.getDescrizioneTaglia()==null)?(""):(cane.getDescrizioneTaglia()));
				if(animale.getRazza()!=null)
					mappaProprietaAddizionali.put("razzaAnimale", (CaninaRemoteUtil.getRazza(animale.getRazza(), connection, req)==null)?(""):(CaninaRemoteUtil.getRazza(animale.getRazza(), connection, req)));
				if(animale.getMantello()!=null)
					mappaProprietaAddizionali.put("mantelloAnimale", (CaninaRemoteUtil.getMantello(animale.getMantello(), connection, req)==null)?(""):(CaninaRemoteUtil.getMantello(animale.getMantello(), connection, req)));
				mappaProprietaAddizionali.put("sterilizzato", (cane.getSterilizzato()?("Si"):("No")));
				mappaProprietaAddizionali.put("randagio", "Non previsto");
			}
			else if (animale.getLookupSpecie().getId() == Specie.GATTO)
			{
				RegistrazioniFelinaResponse rfr = FelinaRemoteUtil.getInfoDecesso(animale.getIdentificativo(), utente, null, connection, req );
				mappaProprietaAddizionali.put("dataMorte", (rfr==null || rfr.getDataEvento()==null)?(""):(rfr.getDataEvento()));
				mappaProprietaAddizionali.put("dataMorteCertezza", (rfr==null)?(""):(rfr.getDataMorteCertezza()));
				mappaProprietaAddizionali.put("causaMorte", (rfr==null || rfr.getDecessoValue()==null)?(""):(rfr.getDecessoValue()));
				//
				Gatto gatto = FelinaRemoteUtil.findGatto(animale.getIdentificativo(), utente, status, connection, req);
				if(animale.getTaglia()!=null)
					mappaProprietaAddizionali.put("tagliaAnimale", (gatto.getDescrizioneTaglia()==null)?(""):(gatto.getDescrizioneTaglia()));
				if(animale.getRazza()!=null)
					mappaProprietaAddizionali.put("razzaAnimale", (FelinaRemoteUtil.getRazza(animale.getRazza(), connection, req)==null)?(""):(FelinaRemoteUtil.getRazza(animale.getRazza(), connection, req)));
				if(animale.getMantello()!=null)
					mappaProprietaAddizionali.put("mantelloAnimale", (FelinaRemoteUtil.getMantello(animale.getMantello(), connection, req)==null)?(""):(FelinaRemoteUtil.getMantello(animale.getMantello(), connection, req)));
				mappaProprietaAddizionali.put("sterilizzato", (gatto.getSterilizzato()?("Si"):("No")));
				mappaProprietaAddizionali.put("randagio", "Non previsto");
			}
			else if (animale.getLookupSpecie().getId() == Specie.SINANTROPO)
			{
				RegistrazioniSinantropiResponse rsr = SinantropoUtil.getInfoDecesso(persistence, animale);
				mappaProprietaAddizionali.put("dataMorte", (rsr==null || rsr.getDecessoValue()==null)?(""):(rsr.getDecessoValue()));
				mappaProprietaAddizionali.put("dataMorteCertezza", (rsr==null)?(""):(rsr.getDataMorteCertezza()));
				mappaProprietaAddizionali.put("causaMorte", (rsr==null || rsr.getDecessoValue()==null)?(""):(rsr.getDecessoValue()));
				//
				
				if(animale.getTaglia()!=null && animale.getTaglia()>0)
					mappaProprietaAddizionali.put("tagliaAnimale", ((LookupTaglie)persistence.find(LookupTaglie.class, animale.getTaglia())).getDescription());
				mappaProprietaAddizionali.put("mantelloAnimale", animale.getMantelloSinantropo());
				mappaProprietaAddizionali.put("razzaAnimale", animale.getSpecieSinantropoString() + " - " + animale.getRazzaSinantropo());
				mappaProprietaAddizionali.put("sterilizzato", "Non previsto");
				mappaProprietaAddizionali.put("randagio", "Non previsto");
			}
		}
		else
		{
			mappaProprietaAddizionali.put("dataMorte", (animale==null || animale.getDataMorte()==null)?(""):(animale.getDataMorte()));
			mappaProprietaAddizionali.put("dataMorteCertezza", (animale==null)?(""):(animale.getDataMorteCertezza()));
			mappaProprietaAddizionali.put("causaMorte", (animale==null || animale.getCausaMorte()==null)?(""):(animale.getCausaMorte().getDescription()));
			//
			
			if(animale.getTaglia()!=null && animale.getTaglia()>=0 && animale.getLookupSpecie().getId()==Specie.CANE){
				mappaProprietaAddizionali.put("tagliaAnimale", (CaninaRemoteUtil.getTaglia(animale.getTaglia(), connection, req).getDescription()));
			}
			else if(animale.getTaglia()!=null && animale.getTaglia()>=0 && animale.getLookupSpecie().getId()==Specie.SINANTROPO){
				mappaProprietaAddizionali.put("tagliaAnimale", ((LookupTaglie)persistence.find(LookupTaglie.class, autopsia.getCartellaClinica().getAccettazione().getAnimale().getTaglia())).getDescription() );
			}
			
			if(animale.getMantello()!=null && animale.getMantello()>=0 && animale.getLookupSpecie().getId()==Specie.CANE)
				mappaProprietaAddizionali.put("mantelloAnimale", (CaninaRemoteUtil.getMantello(animale.getMantello(), connection, req).getDescription()));
			else if(animale.getMantello()!=null && animale.getMantello()>=0 && animale.getLookupSpecie().getId()==Specie.GATTO)
				mappaProprietaAddizionali.put("mantelloAnimale",(FelinaRemoteUtil.getMantello(animale.getMantello(), connection, req).getDescription()));
			else if(animale.getMantello()!=null && animale.getMantello()>=0 && animale.getLookupSpecie().getId()==Specie.SINANTROPO)
				mappaProprietaAddizionali.put("mantelloAnimale", autopsia.getCartellaClinica().getAccettazione().getAnimale().getMantelloSinantropo());
			
			if(animale.getRazza()!=null && animale.getRazza()>0 && animale.getLookupSpecie().getId()==Specie.CANE)
				mappaProprietaAddizionali.put("razzaAnimale", (CaninaRemoteUtil.getRazza(animale.getRazza(), connection, req).getDescription()));
			else if(animale.getRazza()!=null && animale.getRazza()>0 && animale.getLookupSpecie().getId()==Specie.GATTO)
				mappaProprietaAddizionali.put("razzaAnimale", (FelinaRemoteUtil.getRazza(animale.getRazza(), connection, req).getDescription()));
			else if(animale.getRazza()!=null && animale.getLookupSpecie().getId()==Specie.SINANTROPO)
			{
				System.out.println(animale.getSpecieSinantropoString() + " - " + animale.getRazzaSinantropo());
				mappaProprietaAddizionali.put("razzaAnimale", animale.getSpecieSinantropoString() + " - " + animale.getRazzaSinantropo());
			}
			mappaProprietaAddizionali.put("sterilizzato", autopsia.getCartellaClinica().getAccettazione().getSterilizzatoString());
			mappaProprietaAddizionali.put("randagio", (autopsia.getCartellaClinica().getAccettazione().getAnimale().getRandagio()?("Si"):("No")));
		}	
		InputStream template = this.getClass().getResourceAsStream( "RefertoEsameNecroscopico1.pdf" );
		byte[] parteStatica =  PdfReport.fillDocument( template, autopsia, mappaProprietaAddizionali ) ;
		
		//PARTE DINAMICA
		PdfReport pdfReport = new PdfReport();
		
		//Parte pdf per le patologie
		List<Object> patologieList = new ArrayList<Object>((ArrayList<AutopsiaOrganoPatologie>) persistence.getNamedQuery("GetAutopsiaOrganoPatologiaFromAutopsia").setInteger("idAutopsia", autopsia.getId()).list());
		byte[] patologie = null;
		if(!patologieList.isEmpty())
		{
			pdfReport.setColoreIntestazione(new Color(0,0,0));
			pdfReport.setIntestazione("Esame morfologico degli organi");
			pdfReport.addColonna("lookupOrganiAutopsia.description", "Organo",   3000, 3000);
			pdfReport.addColonna("descrizioneReferto", "Patologia", 3000, 3000);
			pdfReport.addColonna("noteReferto", "", 3000, 3000);
			pdfReport.setCellaTabAllineamentoOrizzontale(Element.ALIGN_LEFT);
			pdfReport.setPrintDataReport(false);
			pdfReport.setPrintNumeroPagina(false);
			pdfReport.setItems(patologieList);
			patologie = pdfReport.renderItems();
		}
		
		//Parte pdf per la sezione dettaglio esami
		List<Object> listSde = new ArrayList<Object>(autopsia.getDettaglioEsamiReferto());
		byte[] dettaglioEsami = null;
		if(!listSde.isEmpty())
		{
			pdfReport = new PdfReport();
			pdfReport.setColoreIntestazione(new Color(0,0,0));
			pdfReport.setIntestazione("Sezione dettaglio esami");
			pdfReport.addColonna("organo", "Organo",   3000, 3000);
			pdfReport.addColonna("tipo", "Tipologia", 3000, 3000);
			pdfReport.addColonna("dettaglio", "Dettaglio richiesta", 3000, 3000);
			pdfReport.addColonna("esiti", "Esiti", 3000, 3000);
			pdfReport.setCellaTabAllineamentoOrizzontale(Element.ALIGN_LEFT);
			pdfReport.setPrintDataReport(false);
			pdfReport.setPrintNumeroPagina(false);
			pdfReport.setItems(listSde);
			dettaglioEsami = pdfReport.renderItems();
		}
		
		//Parte pdf per esami istopatologici
		List<Object> esamiIstopatologiciList = new ArrayList<Object>(autopsia.getCartellaClinica().getEsameIstopatologicos());
		byte[] esamiIstopatologici = null;
		if(!esamiIstopatologiciList.isEmpty())
		{
			pdfReport = new PdfReport();
			pdfReport.setColoreIntestazione(new Color(0,0,0));
			pdfReport.setIntestazione("Sezione esami istopatologici");
			pdfReport.addColonna("dataRichiesta", "Data",   3000, 3000);
			pdfReport.addColonna("numero", "Numero",   3000, 3000);
			pdfReport.addColonna("sedeLesione", "Sede Lesione", 3000, 3000);
			pdfReport.addColonna("diagnosiReferto", "Diagnosi", 3000, 3000);
			pdfReport.setCellaTabAllineamentoOrizzontale(Element.ALIGN_LEFT);
			pdfReport.setPrintDataReport(false);
			pdfReport.setPrintNumeroPagina(false);
			pdfReport.setItems(esamiIstopatologiciList);
			esamiIstopatologici = pdfReport.renderItems();
		}
		
		//Parte pdf per cause morte finale
		List<Object> cmfList = new ArrayList<Object>(autopsia.getCmf());
		byte[] cmf = null;
		if(!cmfList.isEmpty())
		{
			pdfReport = new PdfReport();
			pdfReport.setColoreIntestazione(new Color(0,0,0));
			pdfReport.setIntestazione("Cause del decesso finale");
			pdfReport.addColonna("lookupCMF.description", "Descrizione",   3000, 3000);
			pdfReport.addColonna("provataReferto", "Provata/Sospetta", 3000, 3000);
			pdfReport.setCellaTabAllineamentoOrizzontale(Element.ALIGN_LEFT);
			pdfReport.setPrintDataReport(false);
			pdfReport.setPrintNumeroPagina(false);
			pdfReport.setItems(cmfList);
			cmf = pdfReport.renderItems();
		}
		
		//PARTE STATICA - II PARTE
		template = this.getClass().getResourceAsStream( "RefertoEsameNecroscopico2.pdf" );
		byte[] parteStatica2 =  PdfReport.fillDocument( template, autopsia, mappaProprietaAddizionali ) ;
		
		//Concatenazione dei pdf generati
		byte[] pdfFinale = parteStatica;
		if(!patologieList.isEmpty())
			pdfFinale= PdfUtil.join( parteStatica, patologie );
		if(!listSde.isEmpty())
			pdfFinale = PdfUtil.join( pdfFinale, dettaglioEsami);
		if(!esamiIstopatologiciList.isEmpty())
			pdfFinale = PdfUtil.join( pdfFinale, esamiIstopatologici);
		if(!cmfList.isEmpty())
			pdfFinale = PdfUtil.join( pdfFinale, cmf);
		pdfFinale = PdfUtil.join( pdfFinale, parteStatica2 );
		
		//Stampa su standard output
		String outputFileName = "Referto esame necroscopico - " + autopsia.getId() + ".pdf";
		res.setContentType( "application/pdf" );
		res.setHeader( "Content-Disposition","attachment; filename=\"" + outputFileName + "\";" );
		ServletOutputStream sout = res.getOutputStream();	
		sout.write( pdfFinale );
		sout.flush();
		
	}

}



















