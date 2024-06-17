package org.aspcf.modules.checklist_benessere.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.aspcf.modules.report.util.ApplicationProperties;

import com.darkhorseventures.framework.beans.GenericBean;



public class Capitolo extends GenericBean {
										 	
	
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int code;
	private String description = "";
	private int level;
	private boolean enabled;
	private int domandePerCapitolo;
	private int idmod; //chiave esterna alla lookup_chk_bns_mod
	private String tipoCapitolo ="" ;
	
	
	
	public String getTipoCapitolo() {
		return tipoCapitolo;
	}
	public void setTipoCapitolo(String tipoCapitolo) {
		this.tipoCapitolo = tipoCapitolo;
	}

	private ArrayList<Domanda> domandeList = new ArrayList<Domanda>();
  	   
	public ArrayList<Domanda> getDomandeList() {
		return domandeList;
	}
	public void setDomandeList(ArrayList<Domanda> domandeList) {
		this.domandeList = domandeList;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public int getIdMod() {
		return idmod;
	}
	public void setIdMod(int idMod) {
		this.idmod = idMod;
	}
  
    public int getDomandePerCapitolo() {
		return domandePerCapitolo;
	}
    
	public void setDomandePerCapitolo(int domandePerCapitolo) {
		this.domandePerCapitolo = domandePerCapitolo;
	}
	
	public static ArrayList<Capitolo> buildRecordCapitoli(Connection db, int specie, int versione) throws SQLException {
	    
		ArrayList<Capitolo> capitoli = new ArrayList<Capitolo>();
		ResultSet rs = null;
		try{
			 String qry = ApplicationProperties.getProperty("GET_CHK_BNS_CAP");
			 PreparedStatement pst = db.prepareStatement(qry);
			 pst.setInt(1,specie);
			 pst.setInt(2, versione);
			 System.out.println("GISA: query lista capitoli liste di riscontro: "+pst.toString());
			 rs=pst.executeQuery();
			 while(rs.next()){
				 
				 int codice = rs.getInt("code");
				 String descrizione = rs.getString("description");
				 int idMod = rs.getInt("idmod");
				 Capitolo c = new Capitolo();
				 c.setCode(codice);
				 c.setDescription(descrizione);
				 c.setTipoCapitolo(rs.getString("tipo_capitolo"));
				 c.setIdMod(idMod);
				 ArrayList<Domanda> domande = Domanda.buildRecordDomande(db, codice);
				 c.setDomandeList(domande);
				 c.setDomandePerCapitolo(domande.size());
				 capitoli.add(c);
			 }
			 
			  
		 } catch ( SQLException e) {
		      throw new SQLException(e.getMessage());
		    }
		return capitoli;
		}
  
   public static ArrayList<Capitolo> buildRecordCapitoliGiaInseriti(Connection db, int idCU, int specie) throws SQLException {
	    
		ArrayList<Capitolo> capitoli = new ArrayList<Capitolo>();
		ResultSet rs = null;
		try{
			 String qry = "select distinct(idcap),tipo_capitolo,desccap, idmodist,risp.idcap_fkey from chk_bns_risposte risp  " +
			 			  " left join chk_bns_mod_ist ist on ist.id = risp.idmodist  " +
			 			  " left join lookup_chk_bns_mod mod on mod.code = ist.id_alleg " + 
			 			  " where ist.idcu = ? and mod.codice_specie = ? "+  
				 		  " and ist.trashed_date is null order by idcap";
			 PreparedStatement pst = db.prepareStatement(qry);
			 pst.setInt(1,idCU);
			 pst.setInt(2,specie);
			 rs=pst.executeQuery();
			 while(rs.next()){
				 String descrizione = rs.getString("desccap");
				 int idMod = rs.getInt("idmodist");
				 int idCap = rs.getInt("idcap");
				 Capitolo c = new Capitolo();
				 c.setTipoCapitolo(rs.getString("tipo_capitolo"));
				 c.setCode(rs.getInt("idcap_fkey"));
				 c.setDescription(descrizione);
				 c.setIdMod(idMod);
				 ArrayList<Domanda> domande = Domanda.buildRecordDomandeGiaInseriti(db, idCap,idMod);
				 c.setDomandeList(domande);
				 c.setDomandePerCapitolo(domande.size());
				 capitoli.add(c);
			 }
			  
		 } catch ( SQLException e) {
		      throw new SQLException(e.getMessage());
		    }
		return capitoli;
		} 
	
    public static int getIdAllegato(Connection db, int specie, int versione) throws SQLException {
	    
    	 String qry = "select * from lookup_chk_bns_mod where codice_specie = ? and enabled and versione = ? ";
    	 int idAllegato = 15;
    	 try {
    		 PreparedStatement pst = db.prepareStatement(qry);
    		 pst.setInt(1,specie);
    		 pst.setInt(2,versione);
    		 ResultSet rs = null;
    		 rs = pst.executeQuery();
    		 while(rs.next()){
    			 idAllegato = rs.getInt("code");
    		 }
    	 }catch(SQLException s){
    		s.printStackTrace(); 
    	 }
		return idAllegato;
    }
    	 	
} 
