package org.aspcfs.modules.registrazioniAnimali.actions;

import java.sql.Connection;
import java.sql.SQLException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.praticacontributi.base.Pratica;
import org.aspcfs.modules.registrazioniAnimali.base.EventoSterilizzazione;
import org.aspcfs.modules.sinaaf.Sinaaf;
import org.aspcfs.modules.ws.WsPost;

import com.darkhorseventures.framework.actions.ActionContext;

public class SterilizzazioneLP  extends CFSModule {
	
	
	public String executeCommandDefault(ActionContext context) {
		
		if (hasPermission(context, "sterilizzazioniLP-add")) {
			
			return executeCommandAdd(context);
	}else{
		return executeCommandAdd(context);
	}
		
	}
	
	
	public String executeCommandAdd(ActionContext context) {
		if (!hasPermission(context, "sterilizzazioniLP-add")) {
			
				return ("PermissionError");
		}


		Connection db = null;
		try {
			db = this.getConnection(context);

			

		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}

		return getReturn(context, "Add");
		
	}
	
	
	
	public String executeCommandInsert(ActionContext context) throws SQLException {
		if (!hasPermission(context, "sterilizzazioniLP-add")) 
				return ("PermissionError");


		Connection db = null;
		try {
			
			db = this.getConnection(context);
			db.setAutoCommit(false);
			
			EventoSterilizzazione ster = new EventoSterilizzazione();
			
			ster.setEnteredby(this.getUserId(context));
			ster.setModifiedby(this.getUserId(context));
			
			Animale thisAnimale = new Animale(db, context.getParameter("microchip"));
			ster.setMicrochip(context.getParameter("microchip"));
			ster.setFlagContributoRegionale(true);
			ster.setIdProgettoSterilizzazioneRichiesto(Integer.parseInt(context.getParameter("progetto")));
			ster.setIdAnimale(thisAnimale.getIdAnimale());
			ster.setIdAslRiferimento(thisAnimale.getIdAslRiferimento()); //ASL INSERIMENTO EVENTO UGUALE ASL ANIMALE ???
			ster.setIdStatoOriginale(thisAnimale.getStato());
			ster.setIdProprietarioCorrente(thisAnimale.getIdProprietario());
			ster.setIdDetentoreCorrente(thisAnimale.getIdDetentore());
			ster.setSpecieAnimaleId(thisAnimale.getIdSpecie());
			ster.setDataSterilizzazione(context.getParameter("dataSterilizzazione"));
			ster.setIdTipologiaEvento(EventoSterilizzazione.idTipologiaDB);
			ster.setIdSoggettoSterilizzante(context.getParameter("idSoggettoSterilizzante"));
			ster.setIdTipologiaSoggettoSterilizzante(context.getParameter("idTipologiaSoggettoSterilizzante"));
			ster.setNote(context.getParameter("note"));
			thisAnimale.setDataSterilizzazione(ster.getDataSterilizzazione());
			thisAnimale.update(db);
			ster.salvaRegistrazione(this.getUserId(context), this.getUserRole(context), this.getUserAsl(context), thisAnimale, db);
			
			if(new WsPost().getPropagabilita(db, ster.getIdEvento()+"", "evento"))
			{
				String esitoInvioSinaaf[] = new Sinaaf().inviaInSinaaf(db, getUserId(context),ster.getIdEvento()+"", "evento");
				//context.getRequest().setAttribute("messaggio", "Registrazione di sterilizzazione" + esitoInvioSinaaf[0]);
				//context.getRequest().setAttribute("errore", "Registrazione di sterilizzazione" + esitoInvioSinaaf[1]);
			}
			
			Pratica.aggiornaMaschiFemmina(db, Integer.parseInt(context.getParameter("progetto")), thisAnimale.getSesso(), 1);
			
			context.getRequest().setAttribute("EventoSterilizzazione", ster);
			context.getRequest().setAttribute("animale", thisAnimale);
			context.getRequest().setAttribute("avvisoCertificati", "Attenzione, non potrai più stampare questo certificato dopo aver abbandonato la pagina");
			


		} catch (Exception e) {
			db.rollback();
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			db.setAutoCommit(true);
			db.close();
			this.freeConnection(context, db);
			
		}
		

		return getReturn(context, "StampaCertificatiSterLP");
		
	}
}
