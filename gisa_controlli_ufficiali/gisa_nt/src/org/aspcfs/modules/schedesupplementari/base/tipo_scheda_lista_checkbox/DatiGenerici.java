package org.aspcfs.modules.schedesupplementari.base.tipo_scheda_lista_checkbox;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class DatiGenerici {
	
	private int idIstanza = -1;
	private ArrayList<Checkbox> listaCheckbox = new ArrayList<Checkbox>();
	
	public DatiGenerici(){
		
	}
	
	public DatiGenerici(Connection db, int idIstanza){
		
	}
	
	private void buildRecord (ResultSet rs) throws SQLException{}

	public void buildDaRequest(ActionContext context) {
		listaCheckbox = Checkbox.buildDaRequest(context);
	}

	public void insert(Connection db, int idIstanza) throws SQLException {
		for (int j = 0; j<listaCheckbox.size();j++){
			Checkbox cb = (Checkbox) listaCheckbox.get(j);
			cb.insert(db, idIstanza);
		}
	}

	public void queryRecord(Connection db, String numScheda, int idIstanza) throws SQLException {
		listaCheckbox = Checkbox.queryRecord(db, numScheda, idIstanza);
	}

	public int getIdIstanza() {
		return idIstanza;
	}

	public void setIdIstanza(int idIstanza) {
		this.idIstanza = idIstanza;
	}

	public ArrayList<Checkbox> getListaCheckbox() {
		return listaCheckbox;
	}

	public void setListaCheckbox(ArrayList<Checkbox> listaCheckbox) {
		this.listaCheckbox = listaCheckbox;
	}
	
	
	



}
