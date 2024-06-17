package org.aspcf.modules.checklist_farmacosorveglianza.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class Sezione extends GenericBean {
										 	

  private static final long serialVersionUID = 1L;
 
  private int id;
  private int ordine =-1;
  private String sezione = "";
  private ArrayList<Domanda> listaDomande = new ArrayList<Domanda>();
  
  
public Sezione(Connection db, ResultSet rs) throws SQLException {
	buildRecord(rs);
}


public Sezione() {
	// TODO Auto-generated constructor stub
}



private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.ordine = rs.getInt("ordine");
	this.sezione = rs.getString("sezione");
}


public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public int getOrdine() {
	return ordine;
}


public void setOrdine(int ordine) {
	this.ordine = ordine;
}


public String getSezione() {
	return sezione;
}


public void setSezione(String sezione) {
	this.sezione = sezione;
}



public static ArrayList<Sezione> getListaSezioni (Connection db, int idIstanza, int idChkClassyfarmMod) throws SQLException {
	ArrayList<Sezione> listaSezioni = new ArrayList<Sezione>();
	PreparedStatement pst = null;
	
	pst = db.prepareStatement("select * from farmacosorveglianza_sezioni where trashed_date is null and id_lookup_chk_classyfarm_mod = ? order by ordine asc");
	pst.setInt(1, idChkClassyfarmMod);
	
	ResultSet rs = pst.executeQuery();
	
	while (rs.next()){
		Sezione sezione = new Sezione();
		sezione.buildRecord(rs);
		sezione.setListaDomande(Domanda.getListaDomande(db, sezione.getId(), idIstanza));
		listaSezioni.add(sezione);
	}
	return listaSezioni;
}


public ArrayList<Domanda> getListaDomande() {
	return listaDomande;
}


public void setListaDomande(ArrayList<Domanda> listaDomande) {
	this.listaDomande = listaDomande;
}


  
  
} 
