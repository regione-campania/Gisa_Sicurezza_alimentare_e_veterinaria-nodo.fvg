package org.aspcfs.modules.gestionecu.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Componente {
	
	private int id = -1;
	private String nominativo = "";
	private int idStruttura = -1;
	private String nomeStruttura = "";
	private int idQualifica = -1;
	private String nomeQualifica = "";

	
	public Componente() {
		// TODO Auto-generated constructor stub
	}


	public Componente(ResultSet rs) throws SQLException {
		try { this.id = rs.getInt("id"); } catch (Exception e) {}
		try { this.nominativo = rs.getString("nominativo"); } catch (Exception e) {}
		try { this.idStruttura = rs.getInt("id_struttura"); } catch (Exception e) {}
		try { this.nomeStruttura = rs.getString("nome_struttura"); } catch (Exception e) {}
		try { this.idQualifica = rs.getInt("id_qualifica"); } catch (Exception e) {}
		try { this.nomeQualifica = rs.getString("nome_qualifica"); } catch (Exception e) {}
	}


	public static ArrayList<Componente> buildList(Connection db, int idQualifica, int anno, String idStrutture) {
		ArrayList<Componente> lista = new ArrayList<Componente>();
		try
		{
			String select = "select * from public.get_nucleo_componenti(?, ?, ?);";  
			PreparedStatement pst = null ;
			ResultSet rs = null;
			pst = db.prepareStatement(select);
			pst.setInt(1, anno);
			pst.setInt(2, idQualifica);
			pst.setString(3, idStrutture);
			rs = pst.executeQuery();
			while (rs.next()){
				Componente com = new Componente(rs);
				lista.add(com);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		return lista;
	}

	
	public static ArrayList<Componente> buildListAutoritaCompetenti(Connection db, int anno, int idQualifica, int idAsl) {
		ArrayList<Componente> lista = new ArrayList<Componente>();
		try
		{
			String select = "select * from public.get_nominativi_by_qualifica_ac(?, ?, ?);";  
			PreparedStatement pst = null ;
			ResultSet rs = null;
			pst = db.prepareStatement(select);
			pst.setInt(1, anno);
			pst.setInt(2, idQualifica);
			pst.setInt(3, idAsl);
			rs = pst.executeQuery();
			while (rs.next()){
				Componente com = new Componente(rs);
				lista.add(com);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		return lista;
	}
	
	public static ArrayList<Componente> buildListMacelli(Connection db, int anno, int idQualifica, int idAsl) {
		ArrayList<Componente> lista = new ArrayList<Componente>();
		try
		{
			String select = "select * from public.get_nominativi_by_qualifica_macelli(?, ?, ?);";  
			PreparedStatement pst = null ;
			ResultSet rs = null;
			pst = db.prepareStatement(select);
			pst.setInt(1, anno);
			pst.setInt(2, idQualifica);
			pst.setInt(3, idAsl);
			rs = pst.executeQuery();
			while (rs.next()){
				Componente com = new Componente(rs);
				lista.add(com);
			}
		}
		catch(SQLException e)
		{	e.printStackTrace();
		}
		return lista;
	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getNominativo() {
		return nominativo;
	}


	public void setNominativo(String nominativo) {
		this.nominativo = nominativo;
	}


	public int getIdStruttura() {
		return idStruttura;
	}


	public void setIdStruttura(int idStruttura) {
		this.idStruttura = idStruttura;
	}


	public String getNomeStruttura() {
		return nomeStruttura;
	}


	public void setNomeStruttura(String nomeStruttura) {
		this.nomeStruttura = nomeStruttura;
	}


	public int getIdQualifica() {
		return idQualifica;
	}


	public void setIdQualifica(int idQualifica) {
		this.idQualifica = idQualifica;
	}


	public String getNomeQualifica() {
		return nomeQualifica;
	}


	public void setNomeQualifica(String nomeQualifica) {
		this.nomeQualifica = nomeQualifica;
	}


	

}
