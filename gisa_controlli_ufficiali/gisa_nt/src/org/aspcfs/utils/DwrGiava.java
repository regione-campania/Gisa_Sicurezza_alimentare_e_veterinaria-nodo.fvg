package org.aspcfs.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.directwebremoting.extend.LoginRequiredException;

public class DwrGiava {

	public String inserisciUtenteGiava(String nome, String cognome, String cf, String username, 
									   String password, String riferimento_id, String riferimento_id_nome_tab){
		
		String output = "";
		String sql = "select dbi_insert_utente_giava::text from giava.dbi_insert_utente_giava(?,?,?,?,?,?,?)";
		Connection db = null;
		try{
			db = GestoreConnessioni.getConnection();
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setString(1, nome);
			pst.setString(2, cognome);
			pst.setString(3, cf);
			pst.setString(4, username);
			pst.setString(5, password);
			pst.setInt(6, Integer.parseInt(riferimento_id));
			pst.setString(7, riferimento_id_nome_tab);
			ResultSet rs= pst.executeQuery();
			
			System.out.println("query dbi_insert_utente_giava " + pst);
			while(rs.next())
			{
				output = rs.getString("dbi_insert_utente_giava");
			}
		
		}catch(LoginRequiredException e)
		{
			throw e;
		}catch(Exception e)
		{
			e.printStackTrace();		
		}
		finally
		{
			GestoreConnessioni.freeConnection(db);
		}
		
		return output;
		
	}
	
	
	public String verificaEsistenzaStabGiava(String riferimento_id, String riferimento_id_nome_tab){

		String output = "";
		String sql = "select dbi_verifica_esistenza_stab_giava::text from giava.dbi_verifica_esistenza_stab_giava(?,?)";
		Connection db = null;
		try{
			db = GestoreConnessioni.getConnection();
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setInt(1, Integer.parseInt(riferimento_id));
			pst.setString(2, riferimento_id_nome_tab);
			ResultSet rs= pst.executeQuery();
			
			System.out.println("query dbi_verifica_esistenza_stab_giava " + pst);
			while(rs.next())
			{
				output = rs.getString("dbi_verifica_esistenza_stab_giava");
			}
		
		}catch(LoginRequiredException e)
		{
			throw e;
		}catch(Exception e)
		{
			e.printStackTrace();		
		}
		finally
		{
			GestoreConnessioni.freeConnection(db);
		}
		
		return output;
		
	}
	
	
}
