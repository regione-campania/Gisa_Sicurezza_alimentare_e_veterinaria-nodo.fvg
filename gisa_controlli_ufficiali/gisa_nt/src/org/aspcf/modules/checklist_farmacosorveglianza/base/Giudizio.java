package org.aspcf.modules.checklist_farmacosorveglianza.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class Giudizio extends GenericBean {
										 	

  private static final long serialVersionUID = 1L;
 
  private int id;
  private int ordine =-1;
  private String giudizio = "";
  private int punti = -1;
  private String tipo = "";
  
  private String[] lista = {};
  
  private boolean risposto = false;

public Giudizio(Connection db, ResultSet rs) throws SQLException {
	buildRecord(rs);
}


public Giudizio() {
	// TODO Auto-generated constructor stub
}



private void buildRecord(ResultSet rs) throws SQLException{
	this.id = rs.getInt("id");
	this.ordine = rs.getInt("ordine");
	this.giudizio = rs.getString("giudizio");
	this.tipo = rs.getString("tipo");
	this.punti = rs.getInt("punti");
	setLista(rs.getString("lista"));


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


public String getGiudizio() {
	return giudizio;
}


public void setGiudizio(String giudizio) {
	this.giudizio = giudizio;
}


public int getPunti() {
	return punti;
}


public void setPunti(int punti) {
	this.punti = punti;
}


public String getTipo() {
	return tipo;
}


public void setTipo(String tipo) {
	this.tipo = tipo;
}


public static ArrayList<Giudizio> getListaGiudizi(Connection db, int idDomanda, int idIstanza) throws SQLException {
	ArrayList<Giudizio> listaGiudizi = new ArrayList<Giudizio>();
	PreparedStatement pst = null;
	
	pst = db.prepareStatement("select * from farmacosorveglianza_giudizi where trashed_date is null and id_domanda = ? order by ordine asc");
	pst.setInt(1, idDomanda);
	
	ResultSet rs = pst.executeQuery();
	
	while (rs.next()){
		Giudizio giudizio = new Giudizio();
		giudizio.buildRecord(rs);
		
		if (idIstanza > 0)
			giudizio.setRisposto(db, idDomanda, idIstanza);
		
		listaGiudizi.add(giudizio);
	}
	return listaGiudizi;
}


private void setRisposto(Connection db, int idDomanda, int idIstanza) throws SQLException{
	PreparedStatement pst = null;
	pst = db.prepareStatement("select * from farmacosorveglianza_risposte_giudizi where id_istanza = ? and id_domanda = ? and id_giudizio = ? and trashed_date is null");
	pst.setInt(1, idIstanza);
	pst.setInt(2, idDomanda);
	pst.setInt(3, this.id);
	
	ResultSet rs = pst.executeQuery();
	
	if (rs.next()){
			this.risposto = true;
	}
}


public boolean isRisposto() {
	return risposto;
}


public void setRisposto(boolean risposto) {
	this.risposto = risposto;
}

public void insertGiudizio(Connection db, int idIstanza, int idDomanda, int enteredBy) throws SQLException {
	int i = 0;
	PreparedStatement pst = null;
	pst = db.prepareStatement("insert into farmacosorveglianza_risposte_giudizi (id_istanza, id_domanda, id_giudizio) values (?, ?, ?)");
	pst.setInt(++i, idIstanza);
	pst.setInt(++i, idDomanda);
	pst.setInt(++i, this.id);
	pst.executeUpdate();		
}
  
public String[] getLista() {
	return lista;
}


public void setLista(String[] lista) {
	this.lista = lista;
}
  
public void setLista(String lista) {
	if (lista!=null)
		this.lista =  lista.split(";");
}
} 
