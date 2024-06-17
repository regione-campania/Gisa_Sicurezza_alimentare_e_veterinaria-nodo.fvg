package org.aspcfs.modules.devdoc.action;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.log4j.Logger;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.devdoc.base.Flusso;
import org.aspcfs.modules.devdoc.base.FlussoList;
import org.aspcfs.modules.devdoc.base.Modulo;
import org.aspcfs.modules.devdoc.base.ModuloNote;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiModuli;
import org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegatoModuloList;
import org.aspcfs.modules.gestioneDocumenti.util.DocumentaleUtil;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.meeting.action.GestioneRiunioni;
import org.aspcfs.modules.suap.base.PecMailSender;
import org.aspcfs.modules.util.imports.ApplicationProperties;
import org.aspcfs.utils.web.LookupElement;
import org.aspcfs.utils.web.LookupList;
import org.exolab.castor.types.Date;

import com.darkhorseventures.framework.actions.ActionContext;
import com.oreilly.servlet.MultipartRequest;

public class GestioneFlussoSviluppo extends CFSModule{

	Logger logger = Logger.getLogger(GestioneFlussoSviluppo.class);



	private static final int MAX_SIZE_REQ = 50000000;


	public String executeCommandDashboard(ActionContext context)
	{
		
		if (!hasPermission(context, "devdoc-view")) {
			GestioneRiunioni gr = new GestioneRiunioni();
		    return gr.executeCommandSearchForm(context);
		}
		
		Connection db = null ;
		try
		{
			db = this.getConnection(context);

			LookupList listaTipiModulo = new LookupList(db,"lookup_tipo_modulo_sviluppo");
			context.getRequest().setAttribute("listaTipiModulo", listaTipiModulo);

			FlussoList listaFlussi = new FlussoList();
			listaFlussi.buildList(db);
			context.getRequest().setAttribute("listaFlussi", listaFlussi);
			
			LookupList listaTipiPriorita = new LookupList(db,"lookup_priorita_flusso");
			context.getRequest().setAttribute("listaTipiPriorita", listaTipiPriorita);
			
			LookupList listaReferenti = new LookupList(db,"lookup_referenti_flusso");
			context.getRequest().setAttribute("listaReferenti", listaReferenti);
			
			LookupList listaStati = new LookupList(db,"lookup_stati_flusso");
			context.getRequest().setAttribute("listaStati", listaStati); 
			
			String idModulo = null;
			idModulo = context.getRequest().getParameter("idModulo");
			if (idModulo==null)
				idModulo = (String)context.getRequest().getAttribute("idModulo");
			context.getRequest().setAttribute("idModulo", idModulo);
			
			String idFlusso = null;
			idFlusso = context.getRequest().getParameter("idFlusso");
			if (idFlusso==null)
				idFlusso = (String)context.getRequest().getAttribute("idFlusso");
			context.getRequest().setAttribute("idFlusso", idFlusso);

			context.getRequest().setAttribute("Errore", (String)context.getRequest().getAttribute("Errore"));

		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Sviluppo Moduli Errore Ricerca");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return "dashboardOK";
	}
	
	public String executeCommandInsert(ActionContext  context)
	{
		
		if (!hasPermission(context, "devdoc-mod-a-add") &&
			!hasPermission(context, "devdoc-mod-b-add") &&
			!hasPermission(context, "devdoc-mod-c-add") &&
			!hasPermission(context, "devdoc-mod-ch-add") &&
			!hasPermission(context, "devdoc-mod-d-add") &&
			!hasPermission(context, "devdoc-mod-vce-add")
		) 
			return ("PermissionError");
	
		Connection db = null ;
		try
		{

			db = this.getConnection(context);

			LookupList listaTipiModulo = new LookupList(db,"lookup_tipo_modulo_sviluppo");
			
//			String filePath = this.getPath(context, "modulisviluppo");
//			File theDir = new File(filePath);
//	        theDir.mkdirs();
			
			String filePath = getWebInfPath(context,"tmp_moduli_sviluppo");

			MultipartRequest multi = new MultipartRequest(context.getRequest(), filePath,MAX_SIZE_REQ,"UTF-8");
			
			

			db = this.getConnection(context);
			
			Flusso flusso = new Flusso();
			flusso.setIdFlusso(multi.getParameter("idFlusso"));
			flusso.setDescrizione(multi.getParameter("descrizione"));
			flusso.setTags(multi.getParameter("tags"));
			flusso.setIdReferente(multi.getParameter("idReferente"));
			System.out.println("DEBUG AMBIENTE MODULO2: "+multi.getParameter("ambito-gisa"));
		
			
			
			
			if(multi.getParameter("giornate-elapsed")!= null && !("").equals(multi.getParameter("giornate-elapsed"))){
			flusso.setGiornateElapsed(Integer.parseInt(multi.getParameter("giornate-elapsed")));
			}
			if(multi.getParameter("giornate-effort")!= null && !("").equals(multi.getParameter("giornate-effort"))){
			flusso.setGiornateEffort(Integer.parseInt(multi.getParameter("giornate-effort")));
			}
			if(multi.getParameter("data-sviluppo")!= null && !("").equals(multi.getParameter("data-sviluppo"))){
				flusso.setDataInizioSviluppo(multi.getParameter("data-sviluppo"));
				}
			if(multi.getParameter("data-collaudo")!= null && !("").equals(multi.getParameter("data-collaudo"))) {
				flusso.setDataPrevistaCollaudo(multi.getParameter("data-collaudo"));
				}
			if(multi.getParameter("data-sviluppo")!= null && !("").equals(multi.getParameter("data-sviluppo"))&& multi.getParameter("giornate-elapsed")!= null && !("").equals(multi.getParameter("giornate-elapsed"))) {
				
				flusso.updateGiorni(db, flusso.getGiornateEffort(), flusso.getGiornateElapsed(), flusso.getDataInizioSviluppo(), flusso.getDataPrevistaCollaudo(),true);
				}else if(multi.getParameter("data-collaudo")!= null && !("").equals(multi.getParameter("data-collaudo"))){
					flusso.updateGiorni(db, flusso.getGiornateEffort(), flusso.getGiornateElapsed(), flusso.getDataInizioSviluppo(), flusso.getDataPrevistaCollaudo(),false);

				}
			
			flusso.gestioneInserimento(db);
			if (multi.getParameter("ambito-gisa") != null){
			if(multi.getParameter("ambito-gisa").equals("true")){
				flusso.setAmbito("GISA");
				}else{
				flusso.setAmbito("EXTRA");
				}
				flusso.updateAmbito(db, flusso.getAmbito());
			}
			int idFlusso = flusso.getIdFlusso();
			flusso.queryRecord(db, idFlusso);
			
			Modulo modulo = new Modulo();
			modulo.setIdTipo(multi.getParameter("idTipo"));
			modulo.setIdFlusso(flusso.getIdFlusso());
			modulo.setIdUtente(getUserId(context));
			
			boolean invioMailAbilitato = multi.getParameter("flag-invio-mail") != null ? true : false;
			
			boolean moduloInseribileFlussoAperto = (flusso.getIdStato()==Flusso.STATO_APERTO || flusso.getIdStato()==Flusso.STATO_CHIARIMENTI);
			boolean moduloInseribileModuloDisponibile= modulo.isModuloDisponibile(db);
			
			if ( (modulo.getIdTipo()== Modulo.MODULO_AL || modulo.getIdTipo()== Modulo.MODULO_VCE ) || (moduloInseribileFlussoAperto && moduloInseribileModuloDisponibile)){ //SE STO INSERENDO MODULO AL O VCE CONTINUA COMUNQUE. ALTRIMENTI VERIFICA SE IL FLUSSO E' APERTO/CHIARIMENTI E SE IL MODULO NON E' ND
							
				modulo.gestioneInserimento(db);
				
				modulo.queryRecord(db, modulo.getId());
	
				UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
				
				//String toDest="gisadev@u-s.it;gisaref@u-s.it;orsacampania@izsmportici.it;izshd@u-s.it";
				String toDest=ApplicationProperties.getProperty("DEST_EMAIL_FLUSSO_SVILUPPO");
				String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_FLUSSO_SVILUPPO");

				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
				String testo = "E' stato inserito un nuovo modulo nel flusso documentale di sviluppo.<br/><br/>"
						+ "Flusso: "+flusso.getIdFlusso()+"<br/>"
						+ "Descrizione: "+ flusso.getDescrizione()+"<br/><br/>"
						+ "Modulo: "+listaTipiModulo.getSelectedValue(modulo.getIdTipo())+"<br/><br/>"
						+ "Data: "+ dateFormat.format(modulo.getData())+" <br/>"
						+ "Inserito da: "+u.getUsername(); 
				
				File allegato = null;
				
				try {allegato =		(File) multi.getFile("file1"); } catch (Exception e) {}
				if (invioMailAbilitato && modulo.getIdTipo() != Modulo.MODULO_VCE) //modulo tipo VCE interno (non deve partire la mail)
					sendMailNuovoModulo(db, context.getRequest(), testo, oggetto + flusso.getIdFlusso() + " (" + listaTipiModulo.getSelectedValue(modulo.getIdTipo()) + ") - "+ flusso.getDescrizione(), toDest, allegato);

				int esito= caricaFile(context, modulo, db, multi);
				if(esito<1){
					context.getRequest().setAttribute("Errore", "Errore! Formato file non valido");
					return executeCommandDashboard(context);
				}

			}
			else {
				String errore = "Impossibile caricare il modulo in oggetto. ";
				
				if (!moduloInseribileFlussoAperto)
					errore+=" La richiesta "+flusso.getIdFlusso() + " non risulta nello stato APERTO.";
				else if (!moduloInseribileModuloDisponibile)	
					errore+=" Il modulo "+ listaTipiModulo.getSelectedValue(modulo.getIdTipo()) + " per la richiesta " + flusso.getIdFlusso() + " risulta contrassegnato come NON DISPONIBILE.";
				context.getRequest().setAttribute("Errore", errore);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Ricerca");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return executeCommandDashboard(context);
	}
	
	private int caricaFile(ActionContext context, Modulo modulo, Connection db,  MultipartRequest parts) throws IllegalArgumentException, IOException, IllegalStateException, SQLException, ServletException, FileUploadException, MagicParseException, MagicMatchNotFoundException, MagicException{

		//Sintassi: Modulo_B-XXX.doc


		if ( parts.getFile("file1") != null && (Object)  parts.getFile("file1") instanceof File) {
			GestioneAllegatiModuli moduli = new GestioneAllegatiModuli();
			moduli.setIdModulo(modulo.getId());
			moduli.setIdFlusso(modulo.getIdFlusso());
			moduli.setIdTipo(modulo.getIdTipo());
			moduli.setTipoAllegato("Modulo");
			File file1 = (File) parts.getFile("file1");
			ArrayList<String> listaFile = new ArrayList<String>();
			listaFile.add("application/vnd.ms-excel");
			listaFile.add("application/msword");
			listaFile.add("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			listaFile.add("image/jpeg");
			listaFile.add("image/png");
			listaFile.add("application/pdf");
			listaFile.add("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			listaFile.add("application/xml");
			listaFile.add("text/xml");
			String esito = DocumentaleUtil.mimeType(file1.getPath(), listaFile);
			if(esito != null)
				if(esito.equals("errore")){
					return -1;
				}
			moduli.setFileDaCaricare(file1);
			moduli.allegaFile(context);
		}



		return 1;
	}
	
	private int caricaFileConsegna(ActionContext context, Flusso flusso, Connection db,  MultipartRequest parts) throws IllegalArgumentException, IOException, IllegalStateException, SQLException, ServletException, FileUploadException, MagicParseException, MagicMatchNotFoundException, MagicException{
		//Sintassi: Modulo_B-XXX.doc

		if ( parts.getFile("fileConsegna1") != null && (Object)  parts.getFile("fileConsegna1") instanceof File) {
			GestioneAllegatiModuli moduli = new GestioneAllegatiModuli();
			moduli.setIdFlusso(flusso.getIdFlusso());
			moduli.setTipoAllegato("AllegatoConsegna");
			File file1 = (File) parts.getFile("fileConsegna1");
			ArrayList<String> listaFile = new ArrayList<String>();
			listaFile.add("application/vnd.ms-excel");
			listaFile.add("application/msword");
			listaFile.add("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
			listaFile.add("image/jpeg");
			listaFile.add("image/png");
			listaFile.add("application/pdf");
			listaFile.add("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			listaFile.add("application/xml");
			listaFile.add("text/xml");
			String esito = DocumentaleUtil.mimeType(file1.getPath(), listaFile);
			if(esito != null)
				if(esito.equals("errore")){
					return -1;
				}
			moduli.setFileDaCaricare(file1);
			moduli.allegaFile(context);
		}
		return 1;
	}
	public String executeCommandDettaglioModulo(ActionContext  context)
	{
		
		String idModuloString = null;
		int idModulo = -1;
		
		idModuloString = context.getParameter("id");
		if (idModuloString==null)
			idModulo = (int) context.getRequest().getAttribute("id");
		else
			idModulo = Integer.parseInt(idModuloString);
		
		Connection db = null ;
		try
		{
			db = this.getConnection(context);

			Modulo modulo = new Modulo();
			modulo.queryRecord(db, idModulo);
			SystemStatus system= this.getSystemStatus(context);
			
			LookupList listaTipiModulo = new LookupList(db,"lookup_tipo_modulo_sviluppo");
			context.getRequest().setAttribute("listaTipiModulo", listaTipiModulo);
				
			context.getRequest().setAttribute("Modulo", modulo);
			
			context.getRequest().setAttribute("listaAllegati",listaAllegati(context,modulo.getIdFlusso(), modulo.getIdTipo(), modulo.getId()));
			
	}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Dettaglio");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		if (context.getParameter("popup")!=null && context.getParameter("popup").equals("true"))
			return "DettaglioModuloPopupOK";
		return "DettaglioModuloOK";
	}
	
	private DocumentaleAllegatoModuloList listaAllegati(ActionContext context, int idFlusso, int idTipo, int idModulo) throws SQLException, IOException
	{
		GestioneAllegatiModuli moduli = new GestioneAllegatiModuli();
//		moduli.setIdFlusso(idFlusso);
//		moduli.setIdTipo(idTipo);
		moduli.setIdModulo(idModulo);
		return moduli.listaAllegati(context);
	}
	private DocumentaleAllegatoModuloList listaAllegatiConsegna(ActionContext context, int idFlusso) throws SQLException, IOException
	{
		GestioneAllegatiModuli moduli = new GestioneAllegatiModuli();
		moduli.setIdFlusso(idFlusso);
		moduli.setTipoAllegato("AllegatoConsegna");
		return moduli.listaAllegatiConsegna(context);
	}
	
	
	public String executeCommandUpdateNote(ActionContext  context){
		
		if (!hasPermission(context, "devdoc-edit")) {
		      return ("PermissionError");
		}
	
		Connection db = null;
		String idUtente = context.getRequest().getParameter("idUtente");
		String idModulo = context.getRequest().getParameter("idModulo");
		String note = context.getRequest().getParameter("note"+idUtente);
		try
		{
			db = this.getConnection(context);

			Timestamp time = new Timestamp(System.currentTimeMillis());
			
			ModuloNote notes = new ModuloNote();
			notes.setIdUtente(idUtente);
			notes.setIdModulo(idModulo);
			notes.setNote(note);
			notes.setDataCancellazione( time );
			notes.store(db);
			
			
	}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Aggiorna note");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("idModulo", idModulo);
		return executeCommandDashboard(context);
	}

	
	public String executeCommandDettaglioFlusso(ActionContext  context)
	{
		
		String idFlussoString = null;
		int idFlusso = -1;
		
		idFlussoString = context.getParameter("id");
		if (idFlussoString==null)
			idFlusso = (int) context.getRequest().getAttribute("id");
		else
			idFlusso = Integer.parseInt(idFlussoString);
		
		UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
		
		Connection db = null ;
		try
		{
			db = this.getConnection(context);
			
			LookupList listaTipiPriorita = new LookupList(db,"lookup_priorita_flusso");
			context.getRequest().setAttribute("listaTipiPriorita", listaTipiPriorita);
			
			LookupList listaReferenti = new LookupList(db,"lookup_referenti_flusso");
			context.getRequest().setAttribute("listaReferenti", listaReferenti);
			
			LookupList listaStati = new LookupList(db,"lookup_stati_flusso");
			context.getRequest().setAttribute("listaStati", listaStati);
			
			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);
			SystemStatus system= this.getSystemStatus(context);
			context.getRequest().setAttribute("Flusso", flusso);
			
			LookupList listaStatiModifica = new LookupList(db,"lookup_stati_flusso");
			LookupElement referente = (LookupElement) listaReferenti.getElementfromValue(flusso.getIdReferente());
			
			// GESTIONE FLUSSO STATI
			
			// Per permesso
			if (!hasPermission(context, "devdoc-modifica-stato-aperto-view")) 
			      listaStatiModifica.removeElementByCode(Flusso.STATO_APERTO);
			if (!hasPermission(context, "devdoc-modifica-stato-consegnato-view")) 
			      listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
			if (!hasPermission(context, "devdoc-modifica-stato-standby-view")) 
			      listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
			if (!hasPermission(context, "devdoc-modifica-stato-annullato-view")) 
			      listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
			if (!hasPermission(context, "devdoc-modifica-stato-collaudato-view") && (referente==null || !referente.getCodice_fiscale().equalsIgnoreCase(u.getContact().getCodiceFiscale()))){
      			  listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
			}
			if (!hasPermission(context, "devdoc-modifica-stato-chiarimenti-view")) 
			      listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
			
			// Per flusso
			if (flusso.getIdStato() == Flusso.STATO_APERTO){
				listaStatiModifica.removeElementByCode(Flusso.STATO_APERTO); 
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO); 
			} else if (flusso.getIdStato() == Flusso.STATO_CONSEGNATO) {
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
				listaStatiModifica.removeElementByCode(Flusso.STATO_SVILUPPO_IN_CORSO);

				if (!hasPermission(context, "devdoc-modifica-stato-ripristina-view")) 
				      listaStatiModifica.removeElementByCode(Flusso.STATO_APERTO);
			} else if (flusso.getIdStato() == Flusso.STATO_COLLAUDATO) { 
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
				listaStatiModifica.removeElementByCode(Flusso.STATO_SVILUPPO_IN_CORSO);

				if (!hasPermission(context, "devdoc-modifica-stato-ripristina-view")) 
				      listaStatiModifica.removeElementByCode(Flusso.STATO_APERTO);
				
			} else if (flusso.getIdStato() == Flusso.STATO_STANDBY) { 
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
				listaStatiModifica.removeElementByCode(Flusso.STATO_SVILUPPO_IN_CORSO);

			} else if (flusso.getIdStato() == Flusso.STATO_ANNULLATO) { 
				listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
				listaStatiModifica.removeElementByCode(Flusso.STATO_SVILUPPO_IN_CORSO);

			} else if (flusso.getIdStato() == Flusso.STATO_CHIARIMENTI) {  
				listaStatiModifica.removeElementByCode(Flusso.STATO_CHIARIMENTI);
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
			}  else if (flusso.getIdStato() == Flusso.STATO_SVILUPPO_IN_CORSO) {  
				listaStatiModifica.removeElementByCode(Flusso.STATO_SVILUPPO_IN_CORSO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_STANDBY);
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_ANNULLATO);
			    listaStatiModifica.removeElementByCode(Flusso.STATO_APERTO);
			}  
			
			// Per disponibilita moduli
			if (!flusso.hasModulo(Modulo.MODULO_D)){
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
			}
			if (!flusso.hasModulo(Modulo.MODULO_C)){
				listaStatiModifica.removeElementByCode(Flusso.STATO_COLLAUDATO);
				listaStatiModifica.removeElementByCode(Flusso.STATO_CONSEGNATO);
			}
			
			context.getRequest().setAttribute("listaStatiModifica", listaStatiModifica);
			
			context.getRequest().setAttribute("listaAllegatiConsegna",listaAllegatiConsegna(context,flusso.getIdFlusso()));

				
	}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Dettaglio");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		if (context.getParameter("popup")!=null && context.getParameter("popup").equals("true"))
			return "DettaglioFlussoPopupOK";
		return "DettaglioFlussoOK";
	}
	

	public  void sendMailNuovoModulo(Connection db, HttpServletRequest req,String testo,String object,String toDest, File allegato)
	{

		PreparedStatement pst;
		try {
			pst = db.prepareStatement("insert into sviluppo_mail(oggetto, testo, destinatario, file) values (?, ?, ?, ?);");
			pst.setString(1, object);
			pst.setString(2, testo);
			pst.setString(3, toDest);
			pst.setString(4, allegato!=null ? allegato.getName() : ""); 
			pst.execute();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String[] toDestArray = toDest.split(";");
		HashMap<String,String> configs = new HashMap<String,String>();
		configs.put("mail.smtp.starttls.enable",ApplicationProperties.getProperty("mail.smtp.starttls.enable"));
		configs.put("mail.smtp.auth", ApplicationProperties.getProperty("mail.smtp.auth"));
		configs.put("mail.smtp.host", ApplicationProperties.getProperty("mail.smtp.host"));
		configs.put("mail.smtp.port", ApplicationProperties.getProperty("mail.smtp.port"));
		configs.put("mail.smtp.ssl.enable",ApplicationProperties.getProperty("mail.smtp.ssl.enable"));
		configs.put("mail.smtp.ssl.protocols", ApplicationProperties.getProperty("mail.smtp.ssl.protocols"));
		configs.put("mail.smtp.socketFactory.class", ApplicationProperties.getProperty("mail.smtp.socketFactory.class"));
		configs.put("mail.smtp.socketFactory.fallback", ApplicationProperties.getProperty("mail.smtp.socketFactory.fallback"));
		
		PecMailSender sender = new PecMailSender(configs,ApplicationProperties.getProperty("username"), ApplicationProperties.getProperty("password"));
		try {
			sender.sendMailConAllegato(object,testo,ApplicationProperties.getProperty("mail.smtp.from"), toDestArray, allegato);
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}



	}
	
	
	public String executeCommandScadenzario(ActionContext context)
	{
		
		ArrayList<String> listaFlussiAperti = new ArrayList<String>();
		Connection db = null ;
		try
		{
			db = this.getConnection(context);

		PreparedStatement pst = db.prepareStatement("select * from scadenzario_flussi_aperti()");
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			String riga = "";
			riga= riga+";;"+rs.getString("id_flusso")+";;"+rs.getString("data")+";;"+rs.getString("data_ultima_modifica")+";;"+rs.getString("descrizione")+";;"+rs.getString("situazione");
			listaFlussiAperti.add(riga);
		}
		context.getRequest().setAttribute("listaFlussiAperti", listaFlussiAperti);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Sviluppo Moduli Errore Ricerca");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return "scadenzarioFlussiOK";
	}
	
	public String executeCommandPrepareConsegna(ActionContext  context)
	{
		
		String idFlussoString = null;
		int idFlusso = -1;
		
		idFlussoString = context.getParameter("id");
		if (idFlussoString==null)
			idFlusso = (int) context.getRequest().getAttribute("id");
		else
			idFlusso = Integer.parseInt(idFlussoString);
		
		Connection db = null ;
		try
		{
			db = this.getConnection(context);

			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);
			SystemStatus system= this.getSystemStatus(context);
					
			context.getRequest().setAttribute("Flusso", flusso);
				
	}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Dettaglio");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return "ConsegnaFlussoOK";
	}
	
	
	public String executeCommandUpdatePriorita(ActionContext context) throws IOException{
		if (!hasPermission(context, "devdoc-priorita-view")) {
		      return ("PermissionError");
		}
		
		int idFlusso = -1;
		int idPriorita = -1;
		
		idFlusso = Integer.parseInt(context.getRequest().getParameter("idFlusso"));
		idPriorita = Integer.parseInt(context.getRequest().getParameter("idPriorita"));
		
		Connection db = null ;
		
		try {
			db = this.getConnection(context);
			
			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);
			
			LookupList listaTipiPriorita = new LookupList(db,"lookup_priorita_flusso");
			String oldPriorita = listaTipiPriorita.getSelectedValue(flusso.getIdPriorita());
			
			flusso.setIdPriorita(idPriorita);
			flusso.updatePriorita(db, getUserId(context));
			
			UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
			
			String toDest=ApplicationProperties.getProperty("DEST_EMAIL_FLUSSO_SVILUPPO_INTERNO");
			String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_FLUSSO_SVILUPPO");
			
			String testo = "E' stata aggiornata una priorita' nel flusso documentale di sviluppo.<br/><br/>"
					+ "Flusso: "+flusso.getIdFlusso()+"<br/>"
					+ "Descrizione: "+ flusso.getDescrizione()+"<br/><br/>"
					+ "Priorita': "+ oldPriorita + " -> " + listaTipiPriorita.getSelectedValue(flusso.getIdPriorita()) +"<br/>"
					+ "Aggiornato da: "+u.getUsername(); 
			
			sendMailNuovoModulo(db, context.getRequest(), testo, oggetto + flusso.getIdFlusso() + " (AGGIORNAMENTO PRIORITA) - "+ flusso.getDescrizione(), toDest, null);
		
		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Update Priorita'");
		}
		finally {
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("idFlusso", idFlusso);
		
		return executeCommandDashboard(context);
	}
	
	public String executeCommandUpdateReferente(ActionContext context) throws IOException{
		if (!hasPermission(context, "devdoc-referente-view")) {
		      return ("PermissionError");
		}
		
		int idFlusso = -1;
		int idReferente = -1;
		
		idFlusso = Integer.parseInt(context.getRequest().getParameter("idFlusso"));
		idReferente = Integer.parseInt(context.getRequest().getParameter("idReferente"));
		
		Connection db = null ;
		
		try {
			db = this.getConnection(context);
			
			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);

			LookupList listaReferenti = new LookupList(db,"lookup_referenti_flusso");
			String oldReferente = listaReferenti.getSelectedValue(flusso.getIdReferente());
			
			flusso.setIdReferente(idReferente);
			flusso.updateReferente(db, getUserId(context));
			
			UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
			
			String toDest=ApplicationProperties.getProperty("DEST_EMAIL_FLUSSO_SVILUPPO_INTERNO");
			String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_FLUSSO_SVILUPPO");
			
			String testo = "E' stato aggiornato un referente nel flusso documentale di sviluppo.<br/><br/>"
					+ "Flusso: "+flusso.getIdFlusso()+"<br/>"
					+ "Descrizione: "+ flusso.getDescrizione()+"<br/><br/>"
					+ "Referente: "+ oldReferente + " -> " + listaReferenti.getSelectedValue(flusso.getIdReferente()) +"<br/>"
					+ "Aggiornato da: "+u.getUsername(); 
			
			sendMailNuovoModulo(db, context.getRequest(), testo, oggetto + flusso.getIdFlusso() + " (AGGIORNAMENTO REFERENTE) - "+ flusso.getDescrizione(), toDest, null);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Update Referente'");
		}
		finally {
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("idFlusso", idFlusso);
		
		return executeCommandDashboard(context);
	}
	
	public String executeCommandUpdateStato(ActionContext context) throws IOException{ 
		
		
		int idFlusso = -1; 
		int idStato = -1;
		String noteCambioStato = null;
		String dataCambioStato = null;
		
		idFlusso = Integer.parseInt(context.getRequest().getParameter("idFlusso"));
		idStato = Integer.parseInt(context.getRequest().getParameter("idStato"));
		noteCambioStato = context.getRequest().getParameter("noteCambioStato");
		dataCambioStato = context.getRequest().getParameter("dataCambioStato");

		Connection db = null ;
		
		try {
			db = this.getConnection(context);
			
			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);
			
			LookupList listaStati = new LookupList(db,"lookup_stati_flusso");
			String oldStato = listaStati.getSelectedValue(flusso.getIdStato());
			
			flusso.updateStato(db, idStato, noteCambioStato, dataCambioStato, getUserId(context));
			
			Flusso newFlusso = new Flusso();
			newFlusso.queryRecord(db, idFlusso);
			
			UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
			
			String toDest=ApplicationProperties.getProperty("DEST_EMAIL_FLUSSO_SVILUPPO_INTERNO");
			String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_FLUSSO_SVILUPPO");
			
			String testo = "E' stato aggiornato uno stato nel flusso documentale di sviluppo.<br/><br/>"
					+ "Flusso: "+flusso.getIdFlusso()+"<br/>"
					+ "Descrizione: "+ flusso.getDescrizione()+"<br/><br/>"
					+ "Stato: "+ oldStato +" -> " + listaStati.getSelectedValue(newFlusso.getIdStato())+"<br/>"
					+ "Aggiornato da: "+u.getUsername(); 
			
			sendMailNuovoModulo(db, context.getRequest(), testo, oggetto + flusso.getIdFlusso() + " (AGGIORNAMENTO STATO) - "+ flusso.getDescrizione(), toDest, null);

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Update Priorita'");
		}
		finally {
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("idFlusso", idFlusso);
		
		return executeCommandDashboard(context);
	}
	
	public String executeCommandAggiungiNota(ActionContext context) throws IOException {
		int idFlusso = Integer.parseInt(context.getRequest().getParameter("idFlusso"));
		String nota = context.getRequest().getParameter("nuova-nota");
		Connection db = null;
		try {
			db = this.getConnection(context);
			Flusso flusso = new Flusso();
			flusso.queryRecord(db, idFlusso);
			flusso.aggiungiNota(db, getUserId(context), nota);
			
			UserBean u =((UserBean) context.getRequest().getSession().getAttribute("User"));
			
			String toDest=ApplicationProperties.getProperty("DEST_EMAIL_FLUSSO_SVILUPPO_INTERNO");
			String oggetto=ApplicationProperties.getProperty("OGGETTO_EMAIL_FLUSSO_SVILUPPO");
			
			String testo = "E' stata aggiunta una nota nel flusso documentale di sviluppo.<br/><br/>"
					+ "Flusso: "+flusso.getIdFlusso()+"<br/>"
					+ "Descrizione: "+ flusso.getDescrizione()+"<br/><br/>"
					+ "Nota: "+nota+"<br/>"
					+ "Aggiornato da: "+u.getUsername(); 
			
			sendMailNuovoModulo(db, context.getRequest(), testo, oggetto + flusso.getIdFlusso() + " (AGGIORNAMENTO NOTE) - "+ flusso.getDescrizione(), toDest, null);

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error("Gestione Flusso Sviluppo Errore Aggiungi Nota");
		}
		finally {
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("idFlusso", idFlusso);
		
		return executeCommandDashboard(context);
	}
	
	
}
