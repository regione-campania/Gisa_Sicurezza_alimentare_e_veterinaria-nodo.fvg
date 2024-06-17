package org.aspcf.modules.checklist_biosicurezza.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;

public class Dati extends GenericBean {
										 	

  private static final long serialVersionUID = 1L;
 
  private int id;
  private int idIstanza =-1;
  private String numTotaleAnimali ="";
  private String nomeCognomeProprietario = "";
  private String tipoSuini = "";
  
 
  
public Dati(Connection db, ResultSet rs) throws SQLException {
	buildRecord(rs);
}


public Dati() {
	// TODO Auto-generated constructor stub
}


public Dati(Connection db, int idIstanza) throws SQLException {
	PreparedStatement pst = db.prepareStatement("select * from biosicurezza_dati_ext where id_istanza = ? and trashed_date is null");
	pst.setInt(1, idIstanza);
	ResultSet rs = pst.executeQuery();
	if (rs.next())
		buildRecord(rs);

}


public Dati(ActionContext context) {
	this.numTotaleAnimali = context.getRequest().getParameter("numTotaleAnimali");
	this.nomeCognomeProprietario = context.getRequest().getParameter("nomeCognomeProprietario");
	this.tipoSuini = context.getRequest().getParameter("tipoSuini");
}

private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.idIstanza = rs.getInt("id_istanza");
	this.numTotaleAnimali = rs.getString("num_totale_animali");
	this.nomeCognomeProprietario = rs.getString("nome_cognome_proprietario");
	this.tipoSuini = rs.getString("tipo_suini");

}


public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public int getIdIstanza() {
	return idIstanza;
}


public void setIdIstanza(int idIstanza) {
	this.idIstanza = idIstanza;
}


public String getNumTotaleAnimali() {
	return numTotaleAnimali;
}


public void setNumTotaleAnimali(String numTotaleAnimali) {
	this.numTotaleAnimali = numTotaleAnimali;
}


public String getNomeCognomeProprietario() {
	return nomeCognomeProprietario;
}


public void setNomeCognomeProprietario(String nomeCognomeProprietario) {
	this.nomeCognomeProprietario = nomeCognomeProprietario;
}


public String getTipoSuini() {
	return tipoSuini;
}


public void setTipoSuini(String tipoSuini) {
	this.tipoSuini = tipoSuini;
}


public void insertDati(Connection db, int idIstanza) throws SQLException {
	int i = 0;
	PreparedStatement pst = null;
	pst = db.prepareStatement("insert into biosicurezza_dati_ext (id_istanza, num_totale_animali, nome_cognome_proprietario, tipo_suini) values (?, ?, ?, ?)");
	pst.setInt(++i, idIstanza);
	pst.setString(++i, numTotaleAnimali);
	pst.setString(++i, nomeCognomeProprietario);
	pst.setString(++i, tipoSuini);
	pst.executeUpdate();		
}



  
} 
