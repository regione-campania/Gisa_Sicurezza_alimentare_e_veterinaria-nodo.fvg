/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.oia.base.OiaNodo;
import org.aspcfs.modules.vigilanza.base.MotivoIspezione;
import org.aspcfs.modules.vigilanza.base.Ticket;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;



/**
 * Maintains Tickets related to an Account
 *
 * @author chris
 * @version $Id: AccountTickets.java,v 1.13 2002/12/24 14:53:03 mrajkowski Exp
 *          $
 * @created August 15, 2001
 */
public final class Vigilanza extends CFSModule {

	public String executeCommandTicketDetails(ActionContext context) {
		
		int idControllo = -1;
		int tipologiaOperatore = -1;
		int orgId = -1;
		int idStabilimento = -1;
		int idApiario = -1;
		int altId = -1;
	
		Connection db = null;

		String ticketId = null;
		ticketId = context.getRequest().getParameter("id");
		if (ticketId == null)
			ticketId = (String) context.getRequest().getAttribute("id");

		PreparedStatement pst = null;
		String sql = null;
		ResultSet rs = null;
		try {
			db = this.getConnection(context);
			// Load the ticket
			sql="select * from get_dettaglio_cu(?)";
			pst = db.prepareStatement(sql);
			pst.setInt(1, Integer.parseInt(ticketId));
			rs = pst.executeQuery();
			
			while (rs.next()){
				idControllo = rs.getInt("ticketid");
				tipologiaOperatore = rs.getInt("tipologia_operatore");
				orgId = rs.getInt("org_id");
				idStabilimento = rs.getInt("id_stabilimento");
				idApiario = rs.getInt("id_apiario");
				altId = rs.getInt("alt_Id");
			}
			
			 org.aspcfs.modules.troubletickets.base.Ticket t = new org.aspcfs.modules.troubletickets.base.Ticket();
			 t.setId(idControllo);
			 t.setOrgId(orgId);
			 t.setIdStabilimento(idStabilimento);
			 t.setIdApiario(idApiario);
			 t.setAltId(altId);
			 t.setTipologia_operatore(tipologiaOperatore);
	
			 context.getRequest().setAttribute("TicketDetails", t);
		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		//return getReturn(context, "TicketDetails");
		
		return "DettaglioOK";
	}
	
public String executeCommandCampioneDetails(ActionContext context) {
		
		int idControllo = -1;
		int idCampione = -1;
		int tipologiaOperatore = -1;
		int orgId = -1;
		int idStabilimento = -1;
		int idApiario = -1;
		int altId = -1;
	
		Connection db = null;

		String ticketId = null;
		ticketId = context.getRequest().getParameter("id");
		if (ticketId == null)
			ticketId = (String) context.getRequest().getAttribute("id");
		
		try {idCampione = Integer.parseInt(ticketId);} catch (Exception e){}

		PreparedStatement pst = null;
		String sql = null;
		ResultSet rs = null;
		try {
			db = this.getConnection(context);
			// Load the ticket
			sql="select * from get_dettaglio_cu_da_campione(?)";
			pst = db.prepareStatement(sql);
			pst.setInt(1, Integer.parseInt(ticketId));
			rs = pst.executeQuery();
			
			while (rs.next()){
				idControllo = rs.getInt("ticketid");
				tipologiaOperatore = rs.getInt("tipologia_operatore");
				orgId = rs.getInt("org_id");
				idStabilimento = rs.getInt("id_stabilimento");
				idApiario = rs.getInt("id_apiario");
				altId = rs.getInt("alt_Id");
			}
			
			 org.aspcfs.modules.troubletickets.base.Ticket t = new org.aspcfs.modules.troubletickets.base.Ticket();
			 t.setId(idControllo);
			 t.setOrgId(orgId);
			 t.setIdStabilimento(idStabilimento);
			 t.setIdApiario(idApiario);
			 t.setAltId(altId);
			 t.setTipologia_operatore(tipologiaOperatore);
	
			 context.getRequest().setAttribute("TicketDetails", t);
			 context.getRequest().setAttribute("idCampione", String.valueOf(idCampione));

		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		//return getReturn(context, "TicketDetails");
		
		return "DettaglioCampioneOK";
	}
	
	
	public String executeCommandAddMotivoCU(ActionContext context) {
		
		int idControlloUfficiale = -1;
		try { idControlloUfficiale = Integer.parseInt(context.getRequest().getParameter("idControlloUfficiale")); } catch (Exception e) {}
		if (idControlloUfficiale==-1)
			try { idControlloUfficiale = Integer.parseInt((String)context.getRequest().getAttribute("idControlloUfficiale")); } catch (Exception e) {}
		
		if (idControlloUfficiale==-1)
			return "Error";
		int tipologiaOperatore = -1;
		
		Calendar calCorrente = GregorianCalendar.getInstance();
		Date dataCorrente = new Date(System.currentTimeMillis());
		int tolleranzaGiorni = Integer.parseInt(org.aspcfs.modules.vigilanza.blocchicu.ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
		dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
		calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
		int anno_corrente = calCorrente.get(Calendar.YEAR);
		
		ArrayList<MotivoIspezione> listaMotiviIspezione = new ArrayList<MotivoIspezione>();

		Connection db = null;

		try {
				db = this.getConnection(context);
				
				Ticket cu = new Ticket(db,idControlloUfficiale);
				
				//Motivi
			
				PreparedStatement pst = null;
				ResultSet rs = null;
		
				// Load the ticket
				pst = db.prepareStatement("select tipologia_operatore from get_dettaglio_cu(?)");
				pst.setInt(1, idControlloUfficiale);
				rs = pst.executeQuery();
				
				while (rs.next()){
					tipologiaOperatore = rs.getInt("tipologia_operatore");
				}
			
				pst = db.prepareStatement("select * from get_motivi_cu_per_aggiunta_motivo(?, ?, ?);"); 
				pst.setInt(1, tipologiaOperatore);
				pst.setInt(2, anno_corrente);
				pst.setInt(3, idControlloUfficiale);
				rs = pst.executeQuery();
				
				while (rs.next()){
					MotivoIspezione motivo = new MotivoIspezione();
					motivo.setIdMotivoIspezione(rs.getInt("id_tipo_ispezione"));
					motivo.setIdPiano(rs.getInt("id_piano"));
					motivo.setDescrizioneMotivoIspezione(rs.getString("descrizione_tipo_ispezione"));
					motivo.setDescrizionePiano(rs.getString("descrizione_piano"));
					motivo.setCodiceInternoMotivoIspezione(rs.getString("codice_int_tipo_ispe"));
					motivo.setCodiceInternoPiano(rs.getString("codice_int_piano"));
					listaMotiviIspezione.add(motivo);
					}
				
			 context.getRequest().setAttribute("idControlloUfficiale", String.valueOf(idControlloUfficiale));
			 context.getRequest().setAttribute("listaMotiviIspezione", listaMotiviIspezione);
			 context.getRequest().setAttribute("Errore", context.getRequest().getParameter("Errore"));

			 
			 // Per conto di
			 
			 
			 int idAsl = cu.getSiteId();
			 
				ArrayList<OiaNodo> nodi = new ArrayList<OiaNodo>();

					db = this.getConnection(context);
					UserBean user=(UserBean)context.getSession().getAttribute("User");
					int idAslnodo = idAsl > 0 ? idAsl : user.getSiteId() ;
					HashMap<Integer,ArrayList<OiaNodo>> strutture = (HashMap<Integer,ArrayList<OiaNodo>>) context.getServletContext().getAttribute("StruttureOIA");
					if(idAslnodo>0)
					{
						ArrayList<OiaNodo> nodiTemp = strutture.get(idAslnodo);
						if (nodiTemp != null)
							nodi = nodiTemp;
					}
					else
					{
						Iterator<Integer> itK = strutture.keySet().iterator();
						while (itK.hasNext())
						{
							int k = itK.next();
							if (k!=8) { //NON CARICO I NODI REGIONALI
							ArrayList<OiaNodo> nodiTemp = strutture.get(k);
							for(OiaNodo nodotemp : nodiTemp)
							{
								nodi.add(nodi.size(), nodotemp);
							}
							}
						}
					}
					
					if (user.getSiteId()<=0){
						ArrayList<OiaNodo> nodiTemp = strutture.get(8);
						for(OiaNodo nodotemp : nodiTemp)
						{
							nodi.add(nodi.size(), nodotemp);
						}			
						}
					
					LookupList SiteIdList = new LookupList();
					SiteIdList.setTable("lookup_site_id");
					SiteIdList.buildListWithEnabled(db);
					SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
					context.getRequest().setAttribute("SiteIdList", SiteIdList);
					
				
				
				context.getRequest().setAttribute("StrutturaAsl", nodi);
			 	 
			 
			 

		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		
		return "AddMotivoCUOK";
		}
	
public String executeCommandInsertMotivoCU(ActionContext context) {
		
		int idControllo = -1;
		try { idControllo = Integer.parseInt(context.getRequest().getParameter("idControlloUfficiale")); } catch (Exception e) {}
		
		if (idControllo==-1)
			return "Error";
		
		context.getRequest().setAttribute("idControlloUfficiale", String.valueOf(idControllo));

		Connection db = null;

		try {
				db = this.getConnection(context);
				
			
				PreparedStatement pst = null;
				ResultSet rs = null;
		
				String[] idMotiviIspezione = context.getRequest().getParameterValues("idMotivoIspezione");
				String[] idPiani = context.getRequest().getParameterValues("idPiano");
				String[] perContoDi = context.getRequest().getParameterValues("perContoDi");
				
				int sizeMotivi = idMotiviIspezione.length;
				int sizePiani = idPiani.length;
				int sizePerContoDi = perContoDi.length;

				if (sizeMotivi!=sizePiani || sizePiani!=sizePerContoDi || sizeMotivi!=sizePerContoDi){
					context.getRequest().setAttribute("Errore", "Errore generico.");
					return executeCommandAddMotivoCU(context);
				}
				
				for (int i = 0; i<sizeMotivi; i++){
					pst = db.prepareStatement("select * from get_motivi_cu_insert_motivo ( ?, ?, ?, ?, ?, ?)");
					pst.setInt(1, idControllo);
					pst.setInt(2, Integer.parseInt(idMotiviIspezione[i]));
					pst.setInt(3, Integer.parseInt(idPiani[i])>0 ? Integer.parseInt(idPiani[i]) : -1);
					pst.setInt(4, Integer.parseInt(perContoDi[i]));
					pst.setString(5, "Motivo inserito tramite funzione di AGGIUNGI PIANO/ATTIVITA da utente "+getUserId(context) + " in data ");
					pst.setInt(6, getUserId(context));
					pst.execute();

				}
	
		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		
		return "InsertMotivoCUOK";
		}
	
public String executeCommandDetailsMotivoCU(ActionContext context) {
	
	Connection db = null;

	String jsonMotivi = "";
	
	String idControllo = null;
	idControllo = context.getRequest().getParameter("idControllo");
	if (idControllo == null)
		idControllo = (String) context.getRequest().getAttribute("idControllo");
	

	PreparedStatement pst = null;
	String sql = null;
	ResultSet rs = null;
	try {
		db = this.getConnection(context);
		// Load the ticket
		sql="select * from get_motivi_controllo_ufficiale(?)";
		pst = db.prepareStatement(sql);
		pst.setInt(1, Integer.parseInt(idControllo));
		rs = pst.executeQuery();
		
		while (rs.next()){
			jsonMotivi = rs.getString(1);
			}
		
		context.getRequest().setAttribute("jsonMotivi", jsonMotivi);

	} catch (Exception errorMessage) {
		errorMessage.printStackTrace();
		context.getRequest().setAttribute("Error", errorMessage);
		return ("SystemError");
	} finally {
		this.freeConnection(context, db);
	}
	//return getReturn(context, "TicketDetails");
	
	return "DetailsMotivoCUOK";
}

public String executeCommandAddMotivoCUSeduta(ActionContext context) { 
	
	int idAsl = -1;
	try { idAsl = Integer.parseInt(context.getRequest().getParameter("idAsl")); } catch (Exception e) {}
	if (idAsl==-1)
		try { idAsl = Integer.parseInt((String)context.getRequest().getAttribute("idAsl")); } catch (Exception e) {}
	
	int idMacello = -1;
	try { idMacello = Integer.parseInt(context.getRequest().getParameter("idMacello")); } catch (Exception e) {}
	if (idMacello==-1)
		try { idMacello = Integer.parseInt((String)context.getRequest().getAttribute("idMacello")); } catch (Exception e) {}
	
	String data = "";
	try { data = context.getRequest().getParameter("data"); } catch (Exception e) {}
	if (data=="")
		try { data = (String)context.getRequest().getAttribute("data"); } catch (Exception e) {}
	
	int numero = -1;
	try { numero = Integer.parseInt(context.getRequest().getParameter("numero")); } catch (Exception e) {}
	if (numero==-1)
		try { numero = Integer.parseInt((String)context.getRequest().getAttribute("numero")); } catch (Exception e) {}
	
	
	if (idAsl==-1 || idMacello ==-1 || data == "" || numero == -1)
		return "Error";
	
	Calendar calCorrente = GregorianCalendar.getInstance();
	Date dataCorrente = new Date(System.currentTimeMillis());
	int tolleranzaGiorni = Integer.parseInt(org.aspcfs.modules.vigilanza.blocchicu.ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
	dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
	calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
	int anno_corrente = calCorrente.get(Calendar.YEAR);
	
	ArrayList<MotivoIspezione> listaMotiviIspezione = new ArrayList<MotivoIspezione>();

	Connection db = null;

	try {
			db = this.getConnection(context);
			
			
			//Motivi
		
			PreparedStatement pst = null;
			ResultSet rs = null;
	
			pst = db.prepareStatement("select * from get_motivi_cu_per_aggiunta_motivo_seduta(?, ?, ?, ?);"); 
			pst.setInt(1, anno_corrente);
			pst.setInt(2, idMacello);
			pst.setString(3,  data);
			pst.setInt(4, numero);
			
			rs = pst.executeQuery();
			
			while (rs.next()){
				MotivoIspezione motivo = new MotivoIspezione();
				motivo.setIdMotivoIspezione(rs.getInt("id_tipo_ispezione") > 0 ? rs.getInt("id_tipo_ispezione") : -1);
				motivo.setIdPiano(rs.getInt("id_piano") > 0 ? rs.getInt("id_piano") : -1); 
				motivo.setDescrizioneMotivoIspezione(rs.getString("descrizione_tipo_ispezione"));
				motivo.setDescrizionePiano(rs.getString("descrizione_piano"));
				motivo.setCodiceInternoMotivoIspezione(rs.getString("codice_int_tipo_ispe"));
				motivo.setCodiceInternoPiano(rs.getString("codice_int_piano"));
				motivo.setTipoAttivita(rs.getString("tipo_attivita"));
				listaMotiviIspezione.add(motivo);
				}
			
		 context.getRequest().setAttribute("listaMotiviIspezione", listaMotiviIspezione);
		 context.getRequest().setAttribute("Errore", context.getRequest().getParameter("Errore"));

		 
		 // Per conto di
		 
		 
		 
			ArrayList<OiaNodo> nodi = new ArrayList<OiaNodo>();

				UserBean user=(UserBean)context.getSession().getAttribute("User");
				int idAslnodo = idAsl > 0 ? idAsl : user.getSiteId() ;
				HashMap<Integer,ArrayList<OiaNodo>> strutture = (HashMap<Integer,ArrayList<OiaNodo>>) context.getServletContext().getAttribute("StruttureOIA");
				if(idAslnodo>0)
				{
					ArrayList<OiaNodo> nodiTemp = strutture.get(idAslnodo);
					if (nodiTemp != null)
						nodi = nodiTemp;
				}
				else
				{
					Iterator<Integer> itK = strutture.keySet().iterator();
					while (itK.hasNext())
					{
						int k = itK.next();
						if (k!=8) { //NON CARICO I NODI REGIONALI
						ArrayList<OiaNodo> nodiTemp = strutture.get(k);
						for(OiaNodo nodotemp : nodiTemp)
						{
							nodi.add(nodi.size(), nodotemp);
						}
						}
					}
				}
				
				if (user.getSiteId()<=0){
					ArrayList<OiaNodo> nodiTemp = strutture.get(8);
					for(OiaNodo nodotemp : nodiTemp)
					{
						nodi.add(nodi.size(), nodotemp);
					}			
					}
				
				LookupList SiteIdList = new LookupList();
				SiteIdList.setTable("lookup_site_id");
				SiteIdList.buildListWithEnabled(db);
				SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
				context.getRequest().setAttribute("SiteIdList", SiteIdList);
			
			context.getRequest().setAttribute("StrutturaAsl", nodi);
	
	} catch (Exception errorMessage) {
		errorMessage.printStackTrace();
		context.getRequest().setAttribute("Error", errorMessage);
		return ("SystemError");
	} finally {
		this.freeConnection(context, db);
	}
	
	return "AddMotivoCUSedutaOK";
	}

public String executeCommandAddRettificaCampione(ActionContext context) {
	
	int idCampione = -1;
	try { idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione")); } catch (Exception e) {}
	if (idCampione == -1)
		try { idCampione = (int) context.getRequest().getAttribute("idCampione"); } catch (Exception e) {}

	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		org.aspcfs.modules.campioni.base.Ticket campione = new org.aspcfs.modules.campioni.base.Ticket(db, idCampione);
		context.getRequest().setAttribute("Campione", campione);
		
		org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket(db, Integer.parseInt(campione.getIdControlloUfficiale()));
		context.getRequest().setAttribute("CU", cu);

//		LookupList quesiti_diagn = new LookupList(db, "quesiti_diagnostici_sigla");
//        quesiti_diagn.addItem(-1, "-- SELEZIONA VOCE --");
//        context.getRequest().setAttribute("QuesitiList", quesiti_diagn);
        
        LookupList lookup_piani12= new LookupList();
        lookup_piani12.setTableName("lookup_piano_monitoraggio");
        lookup_piani12.buildListWithEnabled(db);
        context.getRequest().setAttribute("Piani2", lookup_piani12);
        
		LookupList motivazioni_list = new LookupList(db, "(select * from get_lista_motivazione_campione())");
		motivazioni_list.addItem(-1, "-- SELEZIONA VOCE --");
        context.getRequest().setAttribute("MotivazioniList", motivazioni_list);
        
        LookupList motivazioni_piani_list = new LookupList(db, "(select * from get_lista_motivazione_piano_campione("+idCampione+"))");
        motivazioni_piani_list.addItem(-1, "-- SELEZIONA VOCE --");
        context.getRequest().setAttribute("MotivazioniPianiList", motivazioni_piani_list);
       
        
//        LookupList lookup_tipo_ispezione = new LookupList();
//        lookup_tipo_ispezione.setTable("lookup_tipo_ispezione");
//        lookup_tipo_ispezione.buildListWithEnabled(db);                        
//        
//        HashMap<Integer, String> tipo_ispezone_valori = cu.getTipoIspezione();
//
//        int size = lookup_tipo_ispezione.size();
//        int ind = 0 ;
//        for ( ind = 0 ; ind<size;ind++)
//        {
//                LookupElement el = (LookupElement)lookup_tipo_ispezione.get(ind) ;
//                
//               
//                		 if ((tipo_ispezone_valori.containsKey(el.getCode())==false) &&  
//                         		!el.getCodiceInterno().equalsIgnoreCase("22a") &&
//                         		!el.getCodiceInterno().equalsIgnoreCase("24a")&& 
//                         		!el.getCodiceInterno().equalsIgnoreCase("41a") &&
//                         		!el.getCodiceInterno().equalsIgnoreCase("42a") && 
//                         		!el.getCodiceInterno().equalsIgnoreCase("43a"))
//                		
//                {
//                        lookup_tipo_ispezione.remove(ind);
//                        size-=1 ;
//                        ind =-1 ;
//                }else
//                {
//                	if (el.getCodiceInterno().equalsIgnoreCase("24a")&& context.getServletContext().getAttribute("SUFFISSO_TAB_ACCESSI")!= null && "_ext".equalsIgnoreCase((String)context.getServletContext().getAttribute("SUFFISSO_TAB_ACCESSI")))
//                	{
//                		lookup_tipo_ispezione.remove(ind);
//                        size-=1 ;
//                        ind =-1 ;
//                	}
//                }
//           }
//        
//        for ( ind = 0 ; ind<size;ind++)
//        {
//                LookupElement el = (LookupElement)lookup_tipo_ispezione.get(ind) ;
//                if( (el.getCode()== 22  || el.getCode()==24 || el.getCode()==41 || el.getCode()==42 || el.getCode()==43) && el.isEnabled()==false)
//                {
//                        lookup_tipo_ispezione.remove(ind);
//                        el.setEnabled(true);
//                        lookup_tipo_ispezione.add(ind, el);
//                }
//        }
//        lookup_tipo_ispezione.addItem(-1, "-- SELEZIONA VOCE --");
//        context.getRequest().setAttribute("MotivazioniList", lookup_tipo_ispezione);
//        
//        String sqlPiani ="(select" +
//                " lp.* " +
//               "from tipocontrolloufficialeimprese t " +
//               " JOIN lookup_piano_monitoraggio lp on lp.code = t.pianomonitoraggio  and t.enabled = true " +
//               " where idcontrollo = "+cu.getId()+")  "  ;
//               LookupList lookup_piani = new LookupList(db,sqlPiani,true);
//               ArrayList<Piano> piani_selezionati = cu.getPianoMonitoraggio();
//               
//               size = lookup_piani.size();
//               int i = 0 ;
//               boolean trovato = false ;
//               for ( i = 0 ; i<size;i++)
//               {
//                       LookupElement el = (LookupElement)lookup_piani.get(i) ;
//                       trovato = false ;
//                       for (Piano p : piani_selezionati)
//                       {
//                               if (p.getId()==el.getCode())
//                               {
//                                       trovato = true ;
//                                       break ;
//                               }
//                           }
//                       if (trovato == false)
//                       {
//                               lookup_piani.remove(i);
//                               size-=1 ;
//                               i=-1;
//
//                       }
//
//               }
//               lookup_piani.addItem(-1, "-- SELEZIONA VOCE --");
//               context.getRequest().setAttribute("MotivazioniPianiList", lookup_piani);
	
	} catch (Exception e) 
	{
		context.getRequest().setAttribute("Error", e);
		return ("SystemError");
	} finally {
		this.freeConnection(context, db);
	}
	
	return ("AddRettificaCampioneOK");
}

public String executeCommandInsertRettificaCampione(ActionContext context) {
	
	int idCampione = -1;
	try { idCampione = Integer.parseInt(context.getRequest().getParameter("idCampione")); } catch (Exception e) {}
	
	if (idCampione==-1)
		return "Error";
	
	int idMotivazione = -1;
	try { idMotivazione = Integer.parseInt(context.getRequest().getParameter("idMotivazioneCampione")); } catch (Exception e) {}
	
	int idMotivazionePiano = -1;
	try { idMotivazionePiano = Integer.parseInt(context.getRequest().getParameter("idMotivazionePianoCampione")); } catch (Exception e) {}
	
	int idMatrice = -1;
	try { idMatrice = Integer.parseInt(context.getRequest().getParameter("idMatrice_1")); } catch (Exception e) {}
	
	int sizeAnaliti = -1;
	try { sizeAnaliti = Integer.parseInt(context.getRequest().getParameter("size")); } catch (Exception e) {}
	
	ArrayList<Integer> analiti = new ArrayList<Integer>();
	
	for (int i = 1; i <= sizeAnaliti; i++){
		analiti.add(Integer.parseInt(context.getRequest().getParameter("analitiId_"+i)));
	}
	String analitiList = analiti.toString();
	
	String messaggio = "KO. Modifica non eseguita a causa di un errore interno. Contattare l'Help Desk.";
	
	Connection db = null;

	try {
			db = this.getConnection(context);
		
			PreparedStatement pst = null;
			ResultSet rs = null;
	
			pst = db.prepareStatement("select * from rettifica_campione ( ?, ?, ?, ?, ?, ?)");
			pst.setInt(1, idCampione);
			pst.setInt(2, idMotivazione);
			pst.setInt(3, idMotivazionePiano);
			pst.setInt(4, idMatrice);
			pst.setString(5, analitiList);
			pst.setInt(6, getUserId(context));
			
			System.out.println("[RETTIFICA CAMPIONE" + pst.toString());
			
			rs = pst.executeQuery();
			
			if (rs.next())
				messaggio = rs.getString(1);

	} catch (Exception errorMessage) {
		errorMessage.printStackTrace();
		context.getRequest().setAttribute("Error", errorMessage);
	} finally {
		this.freeConnection(context, db);
	}
	
    context.getRequest().setAttribute("messaggio", messaggio);
    context.getRequest().setAttribute("idCampione", idCampione);
    
	return executeCommandAddRettificaCampione(context);
	}
	
}
