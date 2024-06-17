package org.aspcfs.modules.aggiungilineapregressa.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.opu.base.Stabilimento;

import com.darkhorseventures.framework.actions.ActionContext;

public class AggiungiLineaPregressa extends CFSModule{

	Logger logger = Logger.getLogger(AggiungiLineaPregressa.class);


	public String executeCommandAdd(ActionContext context)
	{
		
		if (!(hasPermission(context, "aggiungi_linea_pregressa-add"))) {
			return ("PermissionError");
		}
		
		Connection db = null ;
		try
		{
			db = this.getConnection(context);
		
			int id = -1;
			
			String idString = context.getRequest().getParameter("id");
			if (idString==null)
				idString = (String) context.getRequest().getAttribute("id");
			id = Integer.parseInt(idString);
			
			Stabilimento stab = new Stabilimento(db, id);
			context.getRequest().setAttribute("StabilimentoDettaglio", stab);
			context.getRequest().setAttribute("Operatore", stab.getOperatore());
			
	}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return"AddOK";

	}
	
	public String executeCommandInsert(ActionContext context)
	{
		if (!(hasPermission(context, "aggiungi_linea_pregressa-add"))) {
			return ("PermissionError");
		}
		
		Connection db = null ;
		int codiceUscita = -1;
		String messaggioUscita = "";
		String esitoPregressa = "";
		int idStabilimento =  Integer.parseInt(context.getRequest().getParameter("idStab"));
		int idLinea =  Integer.parseInt(context.getRequest().getParameter("idLinea"));
		String dataInizio =  context.getRequest().getParameter("dataInizioLinea");
		String dataFine =  context.getRequest().getParameter("dataFineLinea");
		String codice_nazionale = context.getRequest().getParameter("codice_nazionale");
		
		Stabilimento stab = null;
		
		try
		{
			db = this.getConnection(context);
			
			stab = new Stabilimento(db, idStabilimento);
			
			PreparedStatement pst = db.prepareStatement("select * from public_functions.aggiungi_linea_pregressa(?, ?, ?, ?, ?, ?)");
			
			int i = 0;
			pst.setInt(++i, idStabilimento);
			pst.setInt(++i, idLinea);
			pst.setString(++i, dataInizio);
			pst.setString(++i, dataFine);
			pst.setString(++i, codice_nazionale);
			pst.setInt(++i, getUserId(context));
			
			System.out.println("AGGIUNGI LINEA PREGRESSA QUERY: "+pst.toString());
			ResultSet rs = pst.executeQuery();
			
			if (rs.next()){
				String esito = rs.getString(1);
				String codici[] = esito.split(";;");
				codiceUscita = Integer.parseInt(codici[0]);
				messaggioUscita = codici[1];
			}
			
			esitoPregressa= messaggioUscita;
			
			if (codiceUscita==1)
				esitoPregressa = "<font color='green'>"+esitoPregressa+"</font>"; 
			
			stab = new Stabilimento(db, idStabilimento);
			}
		
		catch(Exception e)
		{
			e.printStackTrace();
			esitoPregressa ="ERRORE";
		}
		finally
		{
			this.freeConnection(context, db);
		}
		
		context.getRequest().setAttribute("StabilimentoDettaglio", stab);
		context.getRequest().setAttribute("esitoPregressa", esitoPregressa);
		return "InsertOK";
	}


	{}
	

	
}
