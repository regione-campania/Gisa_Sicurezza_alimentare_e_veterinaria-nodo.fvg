package org.aspcfs.modules.schedesupplementari.base.tipo_scheda_formazione_iaa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;

public class ComponenteSegreteria {
	
	private int idIstanza = -1;
	private int indice = -1;

	private String nome = null;
	private String cognome = null;
	
	public ComponenteSegreteria() {
		// TODO Auto-generated constructor stub
	}
	
	public ComponenteSegreteria(ResultSet rs) throws SQLException {
		this.idIstanza = rs.getInt("id_istanza");
		this.indice = rs.getInt("indice");
		this.nome = rs.getString("nome");
		this.cognome = rs.getString("cognome");
	}

	
	public int getIndice() {
		return indice;
	}

	public void setIndice(int indice) {
		this.indice = indice;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	
	public static ArrayList<ComponenteSegreteria> buildDaRequest(ActionContext context) {
		 ArrayList<ComponenteSegreteria> lista = new  ArrayList<ComponenteSegreteria>();
		for (int i = 1; i<=5; i++){
			ComponenteSegreteria elem = new ComponenteSegreteria();
			elem.setIndice(i);
			elem.setNome(context.getRequest().getParameter("segreteriaNome_"+i));
			elem.setCognome(context.getRequest().getParameter("segreteriaCognome_"+i));
			lista.add(elem);
		}
		return lista;
	}

	public void insert(Connection db, int idIstanza) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from schede_supplementari.insert_componenti_segreteria(?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idIstanza);
		pst.setInt(++i, indice);
		pst.setString(++i, nome);
		pst.setString(++i, cognome);
		pst.executeQuery();				
	}
	
	public static ArrayList<ComponenteSegreteria> queryRecord(Connection db, int idIstanza) throws SQLException {
		ArrayList<ComponenteSegreteria> lista = new  ArrayList<ComponenteSegreteria>();
		PreparedStatement pst = db.prepareStatement("select * from schede_supplementari.get_componente_segreteria(?)");
		pst.setInt(1, idIstanza);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			ComponenteSegreteria comp = new ComponenteSegreteria(rs);
			lista.add(comp);
		}
		return lista;
	}

	public int getIdIstanza() {
		return idIstanza;
	}

	public void setIdIstanza(int idIstanza) {
		this.idIstanza = idIstanza;
	}

}
