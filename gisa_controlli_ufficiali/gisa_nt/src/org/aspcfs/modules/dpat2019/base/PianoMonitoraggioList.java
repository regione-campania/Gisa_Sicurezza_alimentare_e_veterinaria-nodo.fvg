package org.aspcfs.modules.dpat2019.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PianoMonitoraggioList extends org.aspcfs.modules.troubletickets.base.TicketList
{
	private int tipo;
	private String descrizione ;
	
	public int getTipo() {
		return tipo;
	}


	public void setTipo(int tipo) {
		this.tipo = tipo;
	}


	public String getDescrizione() {
		return descrizione;
	}


	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}


	public void buildList(Connection db) throws SQLException {
	    PreparedStatement pst = null;
	    ResultSet rs = null;
	    int items = -1;
	    StringBuffer sqlSelect = new StringBuffer();
	    StringBuffer sqlCount = new StringBuffer();
	    StringBuffer sqlFilter = new StringBuffer();
	    StringBuffer sqlOrder = new StringBuffer();
	    //Need to build a base SQL statement for counting records
	    sqlCount.append(
	        "SELECT COUNT( code ) AS recordcount " +
	        "FROM lookup_piano_monitoraggio t " +
	        " where t.enabled=true ");
	    createFilter(sqlFilter, db);
	    if (pagedListInfo != null) 
	    {
	    	pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
	    	items = prepareFilter(pst);
		    rs = pst.executeQuery();
		    if (rs.next()) 
		    {
		    	int maxRecords = rs.getInt("recordcount");
		    	pagedListInfo.setMaxRecords(maxRecords);
		    }
	      rs.close();
	      pst.close();
	      // Declare default sort, if unset
	      pagedListInfo.setDefaultSort("t.ordinamento", "desc");
	      pagedListInfo.appendSqlTail(db, sqlOrder);
	    
	      } else {
	      sqlOrder.append(" ORDER BY t.ordinamento asc ");
	    }

	    //Need to build a base SQL statement for returning records
	    if (pagedListInfo != null) {
	      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
	    } else {
	      sqlSelect.append("SELECT ");
	    }
	    sqlSelect.append(" distinct  ");
	    sqlSelect.append(
		        "t.* " +
		        "FROM lookup_piano_monitoraggio t " +
			    " where t.enabled = true  and id_padre = -1 ");
	       
	    pst = db.prepareStatement( sqlSelect.toString() + sqlFilter.toString() +sqlOrder.toString() );
	    
	  
	    if (pagedListInfo != null) {
	      pagedListInfo.doManualOffset(db, pst);
	    }
		
	    rs = pst.executeQuery();
	    if (pagedListInfo != null) {
	      pagedListInfo.doManualOffset(db, rs);
	    }
	    while (rs.next()) {
	      PianoMonitoraggio thisTicket = new PianoMonitoraggio(rs);
	      thisTicket.buildSottopiani(db);
	      
	      this.add(thisTicket);
	    }
	    rs.close();
	    pst.close();
	 
	  }
	
	
	 protected void createFilter(StringBuffer sqlFilter, Connection db) {
		    if (tipo != -1 && tipo!=0 ) {
		      sqlFilter.append(" AND t.level = "+tipo);
		    }
		    if (descrizione != null && !descrizione.equals("")  ) {
			      sqlFilter.append(" AND t.description ilike '%"+descrizione.replaceAll("'", "''")+"%' ");
			    }
		    
	 }

}
