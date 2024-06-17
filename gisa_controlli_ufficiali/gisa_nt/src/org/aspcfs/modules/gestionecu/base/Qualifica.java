package org.aspcfs.modules.gestionecu.base;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.aspcfs.modules.vigilanza.blocchicu.ApplicationProperties;

public class Qualifica {
	
	private int id = -1;
	private String nome = "";
	private boolean viewListaComponenti = false;
	private boolean gruppo = false;
	private ArrayList<Componente> listaComponenti = new ArrayList<Componente>();
	
	
	public Qualifica() {
		// TODO Auto-generated constructor stub
	}


	public Qualifica(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	private void buildRecord(ResultSet rs) throws SQLException{
		this.id = rs.getInt("id");
		this.nome = rs.getString("nome");
		this.viewListaComponenti = rs.getBoolean("view_lista_componenti");
		this.gruppo = rs.getBoolean("gruppo");  
	}

	public Qualifica(Connection db, int idQualifica) throws SQLException {
		String select = "select * from public.get_nucleo_qualifiche(-1) where id = ? and gruppo is false;";  
		PreparedStatement pst = null ;
		ResultSet rs = null;
		pst = db.prepareStatement(select);
		pst.setInt(1, idQualifica);
		rs = pst.executeQuery();
		while (rs.next()){
			buildRecord(rs); 
			}
	}

	public static ArrayList<Qualifica> buildList(Connection db, int userId) {
		ArrayList<Qualifica> lista = new ArrayList<Qualifica>();
		try
		{
			String select = "select * from public.get_nucleo_qualifiche(?);"; 
			PreparedStatement pst = null ;
			ResultSet rs = null;
			pst = db.prepareStatement(select);
			pst.setInt(1, userId);
			rs = pst.executeQuery();
			while (rs.next()){
				Qualifica qual = new Qualifica(rs); 
				lista.add(qual);
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


	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	public boolean isViewListaComponenti() {
		return viewListaComponenti;
	}


	public void setViewListaComponenti(boolean viewListaComponenti) {
		this.viewListaComponenti = viewListaComponenti;
	}


	public boolean isGruppo() {
		return gruppo;
	}


	public void setGruppo(boolean gruppo) {
		this.gruppo = gruppo;
	}

	public ArrayList<Componente> getListaComponenti() {
		return listaComponenti;
	}


	public void setListaComponenti(ArrayList<Componente> listaComponenti) {
		this.listaComponenti = listaComponenti;
	}


	public static ArrayList<Qualifica> getQualificheAutoritaCompetenti(Connection db) {
		ArrayList<Qualifica> listaQualifiche = new ArrayList<Qualifica>();

		PreparedStatement pst = null;
		ResultSet rs = null;
		try
		{
				 
			
			Calendar calCorrente = GregorianCalendar.getInstance();
			Date dataCorrente = new Date(System.currentTimeMillis());
			int tolleranzaGiorni = Integer.parseInt(ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
			dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
			calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
			int anno = calCorrente.get(Calendar.YEAR);
				
				String t = "select * from get_qualifiche_ac(?)"; 				
						
				pst = db.prepareStatement(t);

				pst.setInt(1, anno);

				rs = pst.executeQuery();

				
				while ( rs.next() )
				{
					Qualifica n = new Qualifica(rs);
					listaQualifiche.add(n);

				}
			

		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
		return listaQualifiche  ;
	}
	
	public static ArrayList<Qualifica> getQualificheMacelli(Connection db) {
		ArrayList<Qualifica> listaQualifiche = new ArrayList<Qualifica>();

		PreparedStatement pst = null;
		ResultSet rs = null;
		try
		{
				 
			
			Calendar calCorrente = GregorianCalendar.getInstance();
			Date dataCorrente = new Date(System.currentTimeMillis());
			int tolleranzaGiorni = Integer.parseInt(ApplicationProperties.getProperty("TOLLERANZA_MODIFICA_CU"));
			dataCorrente.setDate(dataCorrente.getDate()- tolleranzaGiorni);
			calCorrente.setTime(new Timestamp(dataCorrente.getTime()));
			int anno = calCorrente.get(Calendar.YEAR);
				
				String t = "select * from get_qualifiche_macelli(?)"; 				
						
				pst = db.prepareStatement(t);

				pst.setInt(1, anno);

				rs = pst.executeQuery();

				
				while ( rs.next() )
				{
					Qualifica n = new Qualifica(rs);
					listaQualifiche.add(n);

				}
			

		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
		return listaQualifiche  ;
	}

}
