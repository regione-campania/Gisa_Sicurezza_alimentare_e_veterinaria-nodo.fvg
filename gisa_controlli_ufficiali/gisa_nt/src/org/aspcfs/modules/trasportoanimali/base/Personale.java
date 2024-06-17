package org.aspcfs.modules.trasportoanimali.base;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class Personale implements Serializable {

	private String nome;
	private String cognome;
	private String cf;
	private String mansione;
	private int org_id=-1;
	public int getOrg_id() {
		return org_id;
	}
	public void setOrg_id(int org_id) {
		this.org_id = org_id;
	}
	public String getNome() {
		return nome;
	}
	public String getCognome() {
		return cognome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getCf() {
		return cf;
	}
	public String getMansione() {
		return mansione;
	}
	public void setCf(String cf) {
		this.cf = cf;
	}
	public void setMansione(String mansione) {
		this.mansione = mansione;
	}
	
	public static void deletePersona(String cf,int org_id,Connection db){
		
		try{
			String del="delete from  organization_personale where cf=? and org_id="+org_id;
			
			java.sql.PreparedStatement pst=db.prepareStatement(del);
			
			
			pst.setString(1, cf);
			
			pst.execute();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}
	
	public static Map<String, Personale> getPresidentsByUniqueIds(int orgid,Connection db){
		Map<String, Personale> m=new HashMap<String, Personale>();
		
		
		try{
			
			java.sql.PreparedStatement pst=(java.sql.PreparedStatement) db.prepareStatement("select * from organization_personale where org_id=?");
			
			pst.setInt(1, orgid);
			ResultSet rs=pst.executeQuery();
			while(rs.next()){
				String cf=rs.getString("cf");
				String nome=rs.getString("nome");
				String cognome=rs.getString("cognome");
				String mansione=rs.getString("mansione");
								
				Personale dist=new Personale(cf,nome, cognome,mansione);
				m.put(cf, dist);
				
			}
			
			
			
			
			
			
			
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return m;
	}
	
	
	
	public void updatePersonale(Connection db, int org_id){
		
		try{
						
String sql="update organization_personale set cf= ?,nome=? , cognome=? , mansione=? where id=? and org_id=?";
			java.sql.PreparedStatement pst=(java.sql.PreparedStatement) db.prepareStatement(sql);
				pst.setString(1, cf);
				pst.setString(2, nome);
				pst.setString(3, cognome);
				pst.setString(4, mansione);
				pst.setString(5, cf);
				pst.setInt(6, org_id);
			
				pst.execute();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		
	}
	
	
	
	
	
	public boolean checkIfExist(Connection db,String cf,int org_id) {
		
		try{
			
			String sql="select * from organization_personale where cf=? and org_id=?";
			
			java.sql.PreparedStatement pst=(java.sql.PreparedStatement) db.prepareStatement(sql);
				pst.setString(1, cf);
				pst.setInt(2, org_id);
				ResultSet rs=pst.executeQuery();
				
				if(rs.next()){
					return true;
				}
			
		}catch(Exception e){
		
			e.printStackTrace();
			
		}
		return false;
		
	}
	
	
	
	
	
	
	
	
	
	public Personale (String cf,String nome , String cognome, String mansione){
	
		this.setCf(cf);
		this.setNome(nome);
		this.setCognome(cognome);
		this.setMansione(mansione);
				
	}
	
	
public void update(Connection db,int org_id ) {
		
		try{
		
			String sql="UPDATE  organization_personale SET NOME=?, COGNOME=?, MANSONE = ? WHERE  cf=?";
			java.sql.PreparedStatement pst= db.prepareStatement(sql);
			
			pst.setString(1,nome);
			pst.setString(2,cognome );
			pst.setString(3,mansione);
			pst.setString(4,cf );
			
			pst.execute();
		}catch(SQLException e){
			e.printStackTrace();
		}
			
		
		
	}
	

	
	public boolean insert(Connection db,int org_id ) {
		
		try{
		
			
	String verifica="select * from organization_personale where cf=? and org_id=?";
			String sql="INSERT INTO organization_personale (cf,nome,cognome, mansione,org_id) VALUES "+
			" (?,?,?,?,?)";
			java.sql.PreparedStatement pst= db.prepareStatement(sql);
			java.sql.PreparedStatement pst2= db.prepareStatement(verifica);
			pst2.setString(1, cf);
			pst2.setInt(2, org_id);
			ResultSet rs2=pst2.executeQuery();
			if(!rs2.next()){		
			pst.setString(1, cf);
			pst.setString(2, nome);
			pst.setString(3, cognome);
			pst.setString(4, mansione);
			pst.setInt(5, org_id);
			
			
			pst.execute();
		return true;
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
			
		return false;
		
	}
	
}
