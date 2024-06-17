package org.aspcfs.modules.sintesis.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.diffida.base.Ticket;
import org.aspcfs.modules.gestioneml.base.SuapMasterListLineaAttivita;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.modules.ricercaunica.base.RicercaList;
import org.aspcfs.modules.ricercaunica.base.RicercaOpu;
import org.aspcfs.modules.sintesis.base.SintesisOperatoreMercato;
import org.aspcfs.modules.sintesis.base.SintesisRelazioneLineaProduttiva;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;


public class StabilimentoSintesisMercatoAction extends CFSModule {


public String executeCommandListaOperatoriMercatoLinea(ActionContext context) throws IndirizzoNotFoundException{
	

	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	
	
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		rel.setPathCompleto(db);
		SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());

		context.getRequest().setAttribute("Stabilimento", stab);
		context.getRequest().setAttribute("Relazione", rel);
		
		ArrayList<SintesisOperatoreMercato> listaOperatori = new ArrayList<SintesisOperatoreMercato>();
	
		int idLinea = rel.getIdLineaMasterList();
		SuapMasterListLineaAttivita linea = new SuapMasterListLineaAttivita(db, idLinea);
			
		if (!linea.checkFlags(db, "{\"flagMercato\" : true}")){
			context.getRequest().setAttribute("Errore", "La linea selezionata non prevede la gestione degli operatori al mercato.");
			return "ListaMercatoOK";
		}
		
		ArrayList<SintesisOperatoreMercato> listaOperatoriLinea =  new ArrayList<SintesisOperatoreMercato>();
		listaOperatoriLinea = SintesisOperatoreMercato.getElencoOperatori(db, rel.getIdRelazione());
		listaOperatori.addAll(listaOperatoriLinea);
		context.getRequest().setAttribute("listaOperatori", listaOperatori);
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	context.getRequest().setAttribute("Messaggio", (String) context.getRequest().getAttribute("Messaggio"));

	
	return "ListaOperatoriMercatoOK";
}

public String executeCommandStoricoOperatoriMercatoLinea(ActionContext context) throws IndirizzoNotFoundException{ 
	

	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	String numBox = context.getRequest().getParameter("numBox");
	if (numBox==null)
		numBox = (String) context.getRequest().getAttribute("numBox");
	
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		rel.setPathCompleto(db);
		SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());

		context.getRequest().setAttribute("Stabilimento", stab);
		context.getRequest().setAttribute("Relazione", rel);
		
		ArrayList<SintesisOperatoreMercato> listaOperatoriStorico = new ArrayList<SintesisOperatoreMercato>();
	
		int idLinea = rel.getIdLineaMasterList();
		SuapMasterListLineaAttivita linea = new SuapMasterListLineaAttivita(db, idLinea);
			
		if (!linea.checkFlags(db, "{\"flagMercato\" : true}")){
			context.getRequest().setAttribute("Errore", "La linea selezionata non prevede la gestione degli operatori al mercato.");
			return "ListaMercatoOK";
		}
		
		ArrayList<SintesisOperatoreMercato> listaOperatoriLineaStorico =  new ArrayList<SintesisOperatoreMercato>();
		listaOperatoriLineaStorico = SintesisOperatoreMercato.getStoricoOperatori(db, rel.getIdRelazione(), Integer.parseInt(numBox));
		listaOperatoriStorico.addAll(listaOperatoriLineaStorico);
		context.getRequest().setAttribute("listaOperatoriStorico", listaOperatoriStorico);
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return "StoricoOperatoriMercatoOK";
}

public String executeCommandRicercaOperatoreMercatoLinea(ActionContext context) throws IndirizzoNotFoundException{
	
	if (!hasPermission(context, "sintesis-mercati-ittici-add")) {
		return ("PermissionError");
	}
	
	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	String numBox = context.getRequest().getParameter("numBox");

	
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		rel.setPathCompleto(db);
		SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());
	
		context.getRequest().setAttribute("Stabilimento", stab);
		context.getRequest().setAttribute("Relazione", rel);
		context.getRequest().setAttribute("NumBox", numBox);
		
		LookupList aslList = new LookupList(db, "lookup_site_id");
		aslList.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("AslList", aslList);		
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return "RicercaOperatoriMercatoOK";
}

public String executeCommandSearchOperatori(ActionContext context) throws IndirizzoNotFoundException {
	
	if (!hasPermission(context, "sintesis-mercati-ittici-add")) {
		return ("PermissionError");
	}
	
	String ragioneSociale = context.getRequest().getParameter("ragioneSociale");
	String partitaIva = context.getRequest().getParameter("partitaIva");
	String numRegistrazione = context.getRequest().getParameter("numRegistrazione");
	int idAsl = Integer.parseInt(context.getRequest().getParameter("idAsl"));

	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	String numBox = context.getRequest().getParameter("numBox");
	
	ragioneSociale = ragioneSociale.trim();
	partitaIva = partitaIva.trim();
	numRegistrazione = numRegistrazione.trim();
	
	RicercaList ricercaList = new RicercaList();
	
	StringBuffer sql = new StringBuffer();
	sql.append("select distinct on (riferimento_id) riferimento_id, * from ricerche_anagrafiche_old_materializzata o where 1=1 and id_norma=49 and id_stato = 0 and tipo_attivita = 1 and riferimento_id_nome_tab in ('opu_stabilimento') ");
			
	if (ragioneSociale!=null && !ragioneSociale.equals(""))
		sql.append("  and ragione_sociale ilike ? ");
	if (partitaIva!=null && !partitaIva.equals(""))
		sql.append("  and partita_iva  ilike ? ");
	if (numRegistrazione!=null && !numRegistrazione.equals(""))
		sql.append("  and n_reg   ilike ?  ");
	if (idAsl>0)
		sql.append("  and asl_rif = ? ");
		
	sql.append(" ORDER by riferimento_id asc");
	PreparedStatement pst;
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		pst = db.prepareStatement(sql.toString());
	
		int i = 0;
		if (ragioneSociale!=null && !ragioneSociale.equals(""))
			pst.setString(++i, "%"+ragioneSociale+"%");
		if (partitaIva!=null && !partitaIva.equals(""))
			pst.setString(++i, "%"+partitaIva+"%");
		if (numRegistrazione!=null && !numRegistrazione.equals(""))
			pst.setString(++i, "%"+numRegistrazione+"%");
		if (idAsl > 0)
			pst.setInt(++i, idAsl);		
		
		ResultSet rs = pst.executeQuery();
	

		while (rs.next()) {
			RicercaOpu thisopu = ricercaList.getObject(rs);
			ricercaList.add(thisopu);
		}

		context.getRequest().setAttribute("ricercaList", ricercaList);
	
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		rel.setPathCompleto(db);
		SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());
		
		ArrayList<SintesisOperatoreMercato> listaOperatori = new ArrayList<SintesisOperatoreMercato>();
		ArrayList<SintesisOperatoreMercato> listaOperatoriLinea =  new ArrayList<SintesisOperatoreMercato>();
		listaOperatoriLinea = SintesisOperatoreMercato.getElencoOperatori(db, rel.getIdRelazione());
		listaOperatori.addAll(listaOperatoriLinea);
		context.getRequest().setAttribute("listaOperatori", listaOperatori);

		context.getRequest().setAttribute("Stabilimento", stab);
		context.getRequest().setAttribute("Relazione", rel);
		context.getRequest().setAttribute("NumBox", numBox);

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return "SearchOperatoriOK";
}

public String executeCommandClonaOperatoreMercatoLinea(ActionContext context) throws IndirizzoNotFoundException {
	
	if (!hasPermission(context, "sintesis-mercati-ittici-add")) {
		return ("PermissionError");
	}
	
	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	String numBox = context.getRequest().getParameter("numBox");
	String riferimentoIdOperatoreDaClonare = context.getRequest().getParameter("riferimentoIdOperatoreDaClonare");
	String riferimentoIdNomeTabOperatoreDaClonare = context.getRequest().getParameter("riferimentoIdNomeTabOperatoreDaClonare");
	String riferimentoIdOperatore = null;
	
	PreparedStatement pst;
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		
		pst = db.prepareStatement("select * from clona_opu_sintesis_gins(?, ?, ?)");
		pst.setInt(1, Integer.parseInt(riferimentoIdOperatoreDaClonare));
		pst.setInt(2, rel.getIdStabilimento() );
		pst.setInt(3, getUserId(context));
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			riferimentoIdOperatore = rs.getString(1);
		
		context.getRequest().setAttribute("riferimentoIdOperatore", riferimentoIdOperatore);
		context.getRequest().setAttribute("riferimentoIdNomeTabOperatore", riferimentoIdNomeTabOperatoreDaClonare);
		context.getRequest().setAttribute("numBox", numBox);
		context.getRequest().setAttribute("idRelazione", idRelazione);

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return executeCommandInserisciOperatoreMercatoLinea(context);
}

public String executeCommandInserisciOperatoreMercatoLinea(ActionContext context) throws IndirizzoNotFoundException {
	
	if (!hasPermission(context, "sintesis-mercati-ittici-add")) {
		return ("PermissionError");
	}
	
	String idRelazione = context.getRequest().getParameter("idRelazione");
	if (idRelazione==null)
		idRelazione = (String) context.getRequest().getAttribute("idRelazione");
	String numBox = context.getRequest().getParameter("numBox");
	if (numBox==null)
		numBox = (String) context.getRequest().getAttribute("numBox");
	String riferimentoIdOperatore = context.getRequest().getParameter("riferimentoIdOperatore");
	if (riferimentoIdOperatore==null)
		riferimentoIdOperatore = (String) context.getRequest().getAttribute("riferimentoIdOperatore");
	String riferimentoIdNomeTabOperatore = context.getRequest().getParameter("riferimentoIdNomeTabOperatore");
	if (riferimentoIdNomeTabOperatore==null)
		riferimentoIdNomeTabOperatore = (String) context.getRequest().getAttribute("riferimentoIdNomeTabOperatore");

	PreparedStatement pst;
	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
		rel.setPathCompleto(db);
		
		SintesisOperatoreMercato operatore = new SintesisOperatoreMercato();
		operatore.setIdRelazioneSintesisMercato(Integer.parseInt(idRelazione));
		operatore.setIdStabilimentoSintesisMercato(rel.getIdStabilimento());
		operatore.setRiferimentoIdOperatore(Integer.parseInt(riferimentoIdOperatore));
		operatore.setRiferimentoIdNomeTabOperatore(riferimentoIdNomeTabOperatore);
		operatore.setNumBox(Integer.parseInt(numBox));
		operatore.setIdentificativo(db);
		operatore.insert(db, getUserId(context));
		
		context.getRequest().setAttribute("idRelazione", idRelazione);


	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return executeCommandListaOperatoriMercatoLinea(context);
}

public String executeCommandEliminaOperatoreMercatoLinea(ActionContext context) throws IndirizzoNotFoundException {
	
	if (!hasPermission(context, "sintesis-mercati-ittici-delete")) {
		return ("PermissionError");
	}
	
	int idOperatore = Integer.parseInt(context.getRequest().getParameter("idOperatore"));

	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisOperatoreMercato operatore = new SintesisOperatoreMercato(db, idOperatore);
		
		
		//Verifico se possibile la cancellazione
		
		Ticket t = new Ticket();
		int numCU = 0;
		numCU = t.contaCU(db,operatore.getOpuStabilimento().getIdStabilimento(),operatore.getOpuStabilimento().getAltId());
		
		if (numCU > 0) {
			context.getRequest().setAttribute("idRelazione", String.valueOf(operatore.getIdRelazioneSintesisMercato()));
			context.getRequest().setAttribute("Messaggio", "Impossibile procedere all'eliminazione. Sull'operatore " + operatore.getRagioneSocialeOperatore() + " presente in questo box sono stati effettuati " + numCU + " controlli ufficiali. Eliminarli prima di riprovare.");
			return executeCommandListaOperatoriMercatoLinea(context);

		}
		operatore.delete(db, getUserId(context));
		context.getRequest().setAttribute("idRelazione", String.valueOf(operatore.getIdRelazioneSintesisMercato()));


	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return executeCommandListaOperatoriMercatoLinea(context);
}

public String executeCommandCessazioneOperatoreMercatoLinea(ActionContext context) throws IndirizzoNotFoundException {
	
	if (!hasPermission(context, "sintesis-mercati-ittici-edit")) {
		return ("PermissionError");
	}
	
	int idOperatore = Integer.parseInt(context.getRequest().getParameter("idOperatore"));

	Connection db = null;
	
	try {
		db = this.getConnection(context);
		
		SintesisOperatoreMercato operatore = new SintesisOperatoreMercato(db, idOperatore);
		operatore.cessazione(db, getUserId(context));
		context.getRequest().setAttribute("idRelazione", String.valueOf(operatore.getIdRelazioneSintesisMercato()));


	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {
		this.freeConnection(context, db);
	}
	
	return executeCommandListaOperatoriMercatoLinea(context);
}

public String executeCommandDetailsOperatore(ActionContext context) throws IndirizzoNotFoundException{
	
	context.getRequest().setAttribute("Messaggio", (String)context.getRequest().getAttribute("Messaggio"));
	
	int altId = -1;
	int stabId = -1;
	
	try {altId = (Integer) context.getRequest().getAttribute("altId");} catch (Exception e){}
	if (altId==-1)
		try {altId = Integer.parseInt(context.getRequest().getParameter("altId"));} catch (Exception e){}
	//context.getRequest().setAttribute("altId", String.valueOf(altId));
	
	try {stabId = (Integer) context.getRequest().getAttribute("stabId");} catch (Exception e){}
	if (stabId==-1)
		try {stabId = Integer.parseInt(context.getRequest().getParameter("stabId"));} catch (Exception e){}
	//context.getRequest().setAttribute("stabId", String.valueOf(stabId));
	
	Connection db = null;  
    
    try{
        db = this.getConnection(context);
        org.aspcfs.modules.opu.base.Stabilimento stab = null;
        
        if (stabId>0)
        	stab = new org.aspcfs.modules.opu.base.Stabilimento(db, stabId);
        else if (altId>0)
        	stab = new org.aspcfs.modules.opu.base.Stabilimento(db, altId, true);
        
        SintesisOperatoreMercato infoOperatoreMercato = new SintesisOperatoreMercato();
        infoOperatoreMercato.loadByIdStabilimentoOperatore(db, stab.getIdStabilimento());
    	context.getRequest().setAttribute("InfoOperatoreMercato", infoOperatoreMercato);
    	
    	SintesisStabilimento infoMercato = new SintesisStabilimento(db, infoOperatoreMercato.getIdStabilimentoSintesisMercato());
    	context.getRequest().setAttribute("InfoMercato", infoMercato);

		 //Caricamento Diffide
		Ticket t = new Ticket();
		context.getRequest().setAttribute("DiffideList", t.getDiffide(db,false,stab.getIdStabilimento(),null,null,null,null)); 
		context.getRequest().setAttribute("DiffideListStorico", t.getDiffide(db,true,stab.getIdStabilimento(),null,null,null,null));
	
    	context.getRequest().setAttribute("id_stabilimento", stab.getIdStabilimento());
    	context.getRequest().setAttribute("stabId", String.valueOf(stab.getIdStabilimento()));
    	context.getRequest().setAttribute("altId", String.valueOf(stab.getAltId()));
    	stab.getDatiByAltId(db, stab.getAltId());  
    	context.getRequest().setAttribute("StabilimentoDettaglio", stab);
    	
    }catch (SQLException e) {
    	e.printStackTrace();
    } finally {
        this.freeConnection(context, db);
    }
	
    //return "DetailsInsertOK";
    //return "DetailsOK";
    return getReturn(context, "DetailsOperatore");
    
}

}

