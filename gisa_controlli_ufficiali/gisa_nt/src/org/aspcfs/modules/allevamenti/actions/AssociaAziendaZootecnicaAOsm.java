package org.aspcfs.modules.allevamenti.actions;

import java.sql.Connection;
import java.util.logging.Logger;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.allevamenti.base.Organization;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Actions for the 'Associazione azienda zootecnica a OSM'
 * 
 * @author Maria
 * @created Luglio 2012
 */
public final class AssociaAziendaZootecnicaAOsm extends CFSModule {

	Logger logger = Logger.getLogger("MainLogger");
	
	public String executeCommandView(ActionContext context) {
		// verifica permessi  
		if (!(hasPermission(context, "allevamenti-associazioneosmregistrati-add"))) {
			return ("PermissionError");
		}

		// lettura parametri
		String orgId = (String) context.getRequest().getParameter("orgId");
		if (orgId == null && !"".equals(orgId)) {
			orgId = (String) context.getRequest().getAttribute("orgId");
		}

		// inizializzazione
		Exception errorMessage = null;
		Connection db = null;
		Organization thisOrg = null;
		
		try {
			logger.info("Creazione collegamento fra azienda zootecnica e OSM registrato.....");
			
			// recupero connessione al DB
			db = getConnection(context);

			// verifica permessi di accesso al record di organization
			if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
				return ("PermissionError");
			}

			// lettura record di organization
			thisOrg = new Organization(db, Integer.parseInt(orgId));
			context.getRequest().setAttribute("OrgDetails", thisOrg);
			
			if (thisOrg.getAccountNumber() == null || 
				thisOrg.getAccountNumber().trim().isEmpty()) {
					logger.warning("Impossibile effettuare l'associazione. Codice azienda zootecnica non presente.");
					throw new Exception("Impossibile effettuare l'associazione. Codice azienda zootecnica non presente.");
			}
			logger.info("Codice azienda zootecnica da associare = [" + thisOrg.getAccountNumber() + "]");
			
			String idOsmDaAssociare = (String)context.getRequest().getParameter("idOsmDaAssociare");
			String accountNumberOsmDaAssociare = (String)context.getRequest().getParameter("accountNumberOsmDaAssociare");
			
			if (accountNumberOsmDaAssociare == null || 
				accountNumberOsmDaAssociare.trim().isEmpty()) {
				logger.warning("Impossibile effettuare l'associazione. Numero registrazione OSM non presente.");
				throw new Exception("Impossibile effettuare l'associazione. Numero registrazione OSM non presente.");
			}
			logger.info("Numero registrazione OSM da associare = [" + accountNumberOsmDaAssociare + "]");
			
			//inserimento associazione in aziendezootecniche_osm
			thisOrg.associaOsm(db, getUserId(context), idOsmDaAssociare, accountNumberOsmDaAssociare);

		} catch (Exception e) {
			errorMessage = e;
		} finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			String messaggio = "Associazione effettuata con successo.";
			logger.info(messaggio);
			context.getRequest().setAttribute("orgId", thisOrg.getOrgId());
			context.getRequest().setAttribute( "messaggioAssociazioneAziendaZootecnicaEffettuata", messaggio);
			return ("InserimentoAssociazioneOK");
		}
		
		logger.severe("Associazione non effettuata. " + errorMessage.getMessage());
		context.getRequest().setAttribute("Error", errorMessage.getMessage());
		return ("SystemError");
	}
}
