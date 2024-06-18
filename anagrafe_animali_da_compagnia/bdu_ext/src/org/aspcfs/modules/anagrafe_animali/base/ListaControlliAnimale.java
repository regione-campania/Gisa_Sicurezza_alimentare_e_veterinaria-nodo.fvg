package org.aspcfs.modules.anagrafe_animali.base;

import java.sql.Timestamp;
import java.util.Vector;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.modules.base.SyncableList;


public class ListaControlliAnimale extends Vector implements SyncableList {




	  private static Logger log = Logger.getLogger(org.aspcfs.modules.anagrafe_animali.base.ListaControlliAnimale.class);
	  static {
	    if (System.getProperty("DEBUG") != null) {
	      log.setLevel(Level.DEBUG);
	    }
	  }
	  
	@Override
	public String getTableName() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getUniqueField() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void setLastAnchor(Timestamp tmp) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setLastAnchor(String tmp) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setNextAnchor(Timestamp tmp) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setNextAnchor(String tmp) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setSyncType(int tmp) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void setSyncType(String tmp) {
		// TODO Auto-generated method stub
		
	}

	  

	public final static String tableName = "controlli";
	
	
	private int idAnimale = -1;
	private int tipoControllo; //leishmaniosi, ricketsiosi ecc
	private int numeroControllo;
	private java.sql.Timestamp dataPrelievo; //leish_data_prelievo_#
	private java.sql.Timestamp dataAccettazione; //leish_data_accettazione_#
	private int esito; //esito#




	}



