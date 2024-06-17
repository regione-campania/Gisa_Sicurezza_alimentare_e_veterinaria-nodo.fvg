package org.aspcfs.modules.gestionecu.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.darkhorseventures.framework.beans.GenericBean;

public class Asl extends GenericBean {

	private String nome;
	private int id;

	public Asl() { 

	}

	public Asl(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	public Asl(Connection db, int id) throws SQLException {
		String select = "select * from public.get_asl_controllo(-1, null, -1, ?);";
		PreparedStatement pst = null ;
		ResultSet rs = null;
		pst = db.prepareStatement(select);
		pst.setInt(1, id);
		rs = pst.executeQuery();
		if (rs.next()){
			buildRecord(rs);
		}
		}

	private void buildRecord(ResultSet rs) throws SQLException{

		this.id = rs.getInt("id");
		this.nome = rs.getString("nome");
	}

	public static ArrayList<Asl> buildLista(Connection db, int riferimentoId, String riferimentoIdNomeTab, int idUtente) {
		ArrayList<Asl> lista = new ArrayList<Asl>();
		try
		{
			String select = "select * from public.get_asl_controllo(?, ?, ?, -1);"; 
			PreparedStatement pst = null ;
			ResultSet rs = null;
			pst = db.prepareStatement(select);
			pst.setInt(1, riferimentoId);
			pst.setString(2, riferimentoIdNomeTab);
			pst.setInt(3, idUtente);
			rs = pst.executeQuery();
			while (rs.next()){
				Asl asl = new Asl(rs);
				lista.add(asl);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		return lista;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}


}
