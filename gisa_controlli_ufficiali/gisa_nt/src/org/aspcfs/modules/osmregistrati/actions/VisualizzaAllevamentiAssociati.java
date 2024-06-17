package org.aspcfs.modules.osmregistrati.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Logger;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.osmregistrati.base.Comuni;
import org.aspcfs.modules.osmregistrati.base.Organization;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Actions for the 'Visualizzazione allevamenti associati all'OSM corrente'
 * 
 * @author Maria
 * @created Luglio 2012
 */
public final class VisualizzaAllevamentiAssociati extends CFSModule {

	Logger logger = Logger.getLogger("MainLogger");
	
	
	public String executeCommandView(ActionContext context) {
		// verifica permessi  
		if (!(hasPermission(context, "osmregistrati-associazioneaziendazootecnica-view"))) {
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
		String codAzienda = null;
		int idAssociazione;
		boolean flagTrovatoComune = false;
		String codiceComuneOsm = null;
		
		try {
			// recupero connessione al DB
			db = getConnection(context);

			// verifica permessi di accesso al record di organization
			if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
				return ("PermissionError");
			}

			// lettura record di organization
			thisOrg = new Organization(db, Integer.parseInt(orgId));
			context.getRequest().setAttribute("OrgDetails", thisOrg);
			
			logger.info("Visualizzazione allevamenti associati all'OSM registrato [" + thisOrg.getName() + "].....");
			
			PreparedStatement pst = db.prepareStatement(
					"SELECT azosm.* FROM organization org " +
					"INNER JOIN aziendezootecniche_osm azosm ON org.org_id = azosm.id_osm " +
					" where org.org_id = ?"
			);

			pst.setInt(1, thisOrg.getOrgId());

			ResultSet rs = pst.executeQuery();
			
			if (rs.next()) {	// deve esistere un unico record ?????????				
				codAzienda = rs.getString("cod_azienda");
				idAssociazione = rs.getInt("id");
				
				if (codAzienda == null || codAzienda.trim().equals("")) {
					// e' presente un record in aziendezootecniche_osm, ma il codice azienda e' vuoto o nullo
					logger.warning("All'OSM [" + thisOrg.getName() + "] e' associata un'azienda zootecnica con codice vuoto o nullo.");
					rs.close();
					pst.close();
					throw new SQLException(Constants.NOT_FOUND_ERROR);
				}
				
				context.getRequest().setAttribute("codAziendaZootecnica", codAzienda);
				context.getRequest().setAttribute("idAssociazione", idAssociazione +"");
				logger.info("All'OSM [" + thisOrg.getName() + "] e' associata un'azienda zootecnica con codice [" + codAzienda + "]");
			}
			else {
				// non e' presente alcun record in aziendezootecniche_osm
				logger.info("All'OSM [" + thisOrg.getName() + "] non e' associata nessuna azienda zootecnica.");
				
				// verifica presenza comune OSM nella lista dei comuni				
				Comuni c = new Comuni();
				ArrayList<Comuni> listaComuni = (ArrayList<Comuni>)c.buildList(db, thisOrg.getSiteId());
				
				Iterator<Comuni> iterator = listaComuni.iterator();
				while (iterator.hasNext())
				{
					Comuni comuneCorrente = iterator.next();
					if (thisOrg.getCity().trim().toUpperCase().equals(comuneCorrente.getComune().toUpperCase())) {
						codiceComuneOsm = comuneCorrente.getCodice();
						flagTrovatoComune = true;
						break;
					}		
				}
			}
			rs.close();
			pst.close();
		} catch (Exception e) {
			errorMessage = e;
		} finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) { //nessuna eccezione
			if (codAzienda != null && !codAzienda.trim().equals("")) {
				// esiste un allevamento associato all'OSM
				return (getReturn(context, "visualizzaAllevamenti"));
			}
			else {
				// nessun allevamento associato all'OSM
				context.getRequest().setAttribute("ricercaAllevamentiAssociabiliAttribute", true);
				
				if (flagTrovatoComune) {
					// OSM associabile
					// metto in sessione l'OSM corrente
					context.getSession().setAttribute("osmACuiAssociareAllevamento", thisOrg);
					context.getSession().setAttribute("codiceComuneOsmPerRicercaAllevamenti", codiceComuneOsm);
					return (getReturn(context, "associaAllevamenti"));
				} else {
					// OSM non associabile: comune non ricadente nell'ASL di appartenenza dell'OSM.
					logger.warning("OSM non associabile: comune [" + thisOrg.getCity() + "] non ricadente nell'ASL di appartenenza dell'OSM.");
					return (getReturn(context, "osmComuneNonPresenteInLista"));
				}
			}
		}
		
		logger.severe(errorMessage.getMessage());
		context.getRequest().setAttribute("Error", errorMessage.getMessage());
		return ("SystemError");
	}
}
