package org.aspcfs.modules.ricercaunica.actions;

import java.sql.Connection;

import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.actions.CFSModule;

import com.darkhorseventures.framework.actions.ActionContext;

public class InterfRicercaUnica extends CFSModule{

	public String executeCommandIntercetta(ActionContext cont)
	{
		boolean nuovaAnagrafica = false;
		boolean isScarto = false;
		String originalActionUrl = null;
		Connection db = null;
		
		try
		{
			originalActionUrl = cont.getRequest().getParameter("action_originale").replace("$", "&");
			
	//		System.out.println(originalAction);
			
			cont.getRequest().setAttribute("isScarto",false);
			//Aggiungere un controllo che se il cavaliere appartiene alla vecchia anagrafica,
			//e se l'impresa e appartenente agli scarti, setta un flag apposito, o viceversa
			//quest'informazione e ottenuta dall'url dell'action originale
			
			nuovaAnagrafica = false; //cablato
			
			if(!nuovaAnagrafica)
			{
				
				db = getConnection(cont);
				
				int tI = -1;
				
				//org id e dato dal valore (dopo l'= ) del parametro di query contenuto nell'originalActionUrl con nome stabId
				//e se questo non esiste allora lo stesso ma per il parametro orgId
				
				String strOrgId = (tI = originalActionUrl.indexOf("stabId")) > -1 ? originalActionUrl.substring(tI+7) : originalActionUrl.substring(originalActionUrl.indexOf("orgId")+6) ;
				
				int orgId = Integer.parseInt(strOrgId);
				Organization newOrg = new Organization(db, orgId);
				
				isScarto = !newOrg.isImportOpu();
				
				if(isScarto)
					cont.getRequest().setAttribute("isScarto",true);
			}
			
			
			cont.getRequest().setAttribute("action_originale", originalActionUrl);
			return "dummyJsp";
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return "SystemError";
		}
		finally
		{
			freeConnection(cont, db);
		}
	}
	
}
