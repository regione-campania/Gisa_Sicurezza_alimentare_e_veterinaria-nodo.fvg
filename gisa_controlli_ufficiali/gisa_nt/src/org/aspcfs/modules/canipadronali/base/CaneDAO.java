package org.aspcfs.modules.canipadronali.base;

import java.sql.SQLException;

import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.web.PagedListInfo;

import com.darkhorseventures.framework.actions.ActionContext;

public interface CaneDAO {
	
	//commento al 214
	public CaneList searchCaneByMC( String mc,String cf_prop,String reg , int siteId,PagedListInfo searchListInfo, ActionContext context,String id_canina, String id_gisa, boolean cani_canile) 	;
	public int inserisciCane( Proprietario proprietario,UserBean user ) throws SQLException 																;
	public Proprietario dettaglioProprietario( int orgId , int idControllo ) 											;
	

}
