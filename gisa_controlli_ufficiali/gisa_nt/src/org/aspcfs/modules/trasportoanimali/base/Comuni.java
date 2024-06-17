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
package org.aspcfs.modules.trasportoanimali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Comuni {
	
  private String codice = null; 	
  private String comune = null; 

  public Comuni() {
  }

  public Comuni(Connection db, String comune) throws SQLException {
    queryRecord(db, comune);
  }
  
  public Comuni(Connection db, int orgId, int type) throws SQLException {
	    queryRecord2(db, orgId, type);
  }

  public String getCodice() {
	return codice;
}

public void setCodice(String codice) {
	this.codice = codice;
}

  public void queryRecord(Connection db, String comune) throws SQLException {
    PreparedStatement st = null;
    ResultSet rs = null;
    StringBuffer sql = new StringBuffer();
    sql.append("SELECT codice FROM comuni c WHERE c.comune ILIKE ? ");
    st = db.prepareStatement(sql.toString());
    st.setString( 1, comune );
    rs = st.executeQuery();
    
    if (rs.next()) {
      codice = rs.getString(1);
    }
    rs.close();
    st.close();
  }
  
  public void queryRecord2(Connection db, int orgId, int type) throws SQLException {
	    PreparedStatement st = null;
	    ResultSet rs = null;
	    StringBuffer sql = new StringBuffer();
	    sql.append("SELECT codice FROM comuni c WHERE c.comune ILIKE (select city from organization_address where org_id=? and enabled=true and address_type=?) ");
	    st = db.prepareStatement(sql.toString());
	    st.setInt( 1, orgId );
	    st.setInt(2, type);
	    rs = st.executeQuery();
	    
	    if (rs.next()) {
	      codice = rs.getString(1);
	    }
	    rs.close();
	    st.close();
	  }
  
  public ArrayList<String> queryRecord2(Connection db) throws SQLException {
	    ArrayList< String> comuni = new ArrayList<String>();
	    PreparedStatement st = null;
	    ResultSet rs = null;
	    StringBuffer sql = new StringBuffer();
	    sql.append("SELECT comune FROM comuni c");
	    st = db.prepareStatement(sql.toString());
	    rs = st.executeQuery();
	    
	    while (rs.next()) {
	     
	      comune = rs.getString(1);
	      comuni.add(comune);
	    }
	    
	    rs.close();
	    st.close();
	    
	    return comuni;
	  }
  
public String getComune() {
	return comune;
}

public void setComune(String comune) {
	this.comune = comune;
}

}

