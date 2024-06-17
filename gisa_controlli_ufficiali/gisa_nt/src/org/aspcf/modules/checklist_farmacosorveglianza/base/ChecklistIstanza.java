package org.aspcf.modules.checklist_farmacosorveglianza.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;

public class ChecklistIstanza extends GenericBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	 /**
	   *  Constructor for the Organization object, creates an empty Organization
	   *
	   * @since    1.0
	   */
	  public ChecklistIstanza() { }
	  
	private int id;
	private int idControllo;
	private int idChkClassyfarmMod;
	private int orgId;
	private int enteredBy;
	private int modifiedBy;
	private boolean bozza = true;
	
	private java.sql.Timestamp entered = null;
	private java.sql.Timestamp modified = null;
	private java.sql.Timestamp trashedDate = null;
	
	private ArrayList<Sezione> sezioni = new ArrayList<Sezione>();
	private Dati dati = new Dati();
    
	protected void buildRecord(ResultSet rs) throws SQLException {
		 
		 id = rs.getInt("id");
		 idControllo = rs.getInt("id_controllo");
		 idChkClassyfarmMod = rs.getInt("id_lookup_chk_classyfarm_mod");
		 orgId = rs.getInt("org_id");
		 entered = rs.getTimestamp("entered");
		 enteredBy = rs.getInt("enteredby");
		 modified = rs.getTimestamp("modified");
		 modifiedBy = rs.getInt("modifiedBy");	 
		 bozza = rs.getBoolean("bozza");
			
		    
	 }
	

	public ChecklistIstanza(Connection db, int idControllo, int idChkClassyfarmMod) 
		throws SQLException {
			
			  
		    if (idControllo == -1) {
		      throw new SQLException("Invalid TicketID");
		    } 
		    PreparedStatement pst = db.prepareStatement("select * from farmacosorveglianza_istanze where id_controllo = ? and id_lookup_chk_classyfarm_mod = ? and trashed_date is null");

		    pst.setInt(1, idControllo);
		    pst.setInt(2, idChkClassyfarmMod);

		    ResultSet rs = pst.executeQuery();
		    if (rs.next()) {
		      buildRecord(rs);
		      setDati(db);
		    }
		    
		    rs.close();
		    pst.close();
		    
		    this.setSezioni(Sezione.getListaSezioni(db, this.id, idChkClassyfarmMod));
		  
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getIdControllo() {
		return idControllo;
	}


	public void setIdControllo(int idControllo) {
		this.idControllo = idControllo;
	}


	public int getOrgId() {
		return orgId;
	}


	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}


	public int getEnteredBy() {
		return enteredBy;
	}


	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}


	public int getModifiedBy() {
		return modifiedBy;
	}


	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}


	public boolean isBozza() {
		return bozza;
	}


	public void setBozza(boolean bozza) {
		this.bozza = bozza;
	}


	public java.sql.Timestamp getEntered() {
		return entered;
	}


	public void setEntered(java.sql.Timestamp entered) {
		this.entered = entered;
	}


	public java.sql.Timestamp getModified() {
		return modified;
	}


	public void setModified(java.sql.Timestamp modified) {
		this.modified = modified;
	}


	public java.sql.Timestamp getTrashedDate() {
		return trashedDate;
	}


	public void setTrashedDate(java.sql.Timestamp trashedDate) {
		this.trashedDate = trashedDate;
	}


	public ArrayList<Sezione> getSezioni() {
		return sezioni;
	}


	public void setSezioni(ArrayList<Sezione> sezioni) {
		this.sezioni = sezioni;
	}


	public Dati getDati() {
		return dati;
	}


	public void setDati(Dati dati) {
		this.dati = dati;
	}
	  
	private void setDati (Connection db) throws SQLException {
		Dati dati = new Dati();
		dati.queryRecordByIdIstanza(db, id);
		this.dati = dati;
	}
	
	
	public void recuperaDaForm(ActionContext context, Connection db) throws SQLException {
	 
		Dati dati = new Dati();
		dati.recuperaDaForm(context);
		this.setDati(dati);
		
	
//		ArrayList<Sezione> sezioniConRisposta = new ArrayList<Sezione>();
		for (int s = 0; s<sezioni.size(); s++){
			   Sezione sezione = (Sezione) sezioni.get(s);
			   for (int d = 0; d<sezione.getListaDomande().size(); d++){
					Domanda domanda = (Domanda) sezione.getListaDomande().get(d);
					domanda.setEvidenze(context.getRequest().getParameter("risposta_evidenze_"+domanda.getId()));
					for (int g = 0; g<domanda.getListaGiudizi().size(); g++){
						Giudizio giudizio = (Giudizio) domanda.getListaGiudizi().get(g);
						giudizio.setRisposto(false);
						if (giudizio.getTipo().equals("radio")){
							if (context.getRequest().getParameter("risposta_radio_"+domanda.getId())!=null && context.getRequest().getParameter("risposta_radio_"+domanda.getId()).equals(giudizio.getGiudizio()))
								giudizio.setRisposto(true);
						}
						else if (giudizio.getTipo().equals("checkbox")){
							if (context.getRequest().getParameter("risposta_check_"+domanda.getId()+"_"+giudizio.getId())!=null)
								giudizio.setRisposto(true);
						}
					}
	
			   }
		}	
	
	}


	public void upsert(Connection db) throws SQLException {

		PreparedStatement pst = null;
		ResultSet rs = null;
		
		int idEsitoClassyfarmPrecedente = -1;
		String descrizioneErroreClassyfarmPrecedente = null;
		String descrizioneMessaggioClassyfarmPrecedente = null;
		Timestamp dataInvioPrecedente = null;
		boolean riapertaPrecedente = false;
			
		System.out.println("CONTROLLO SE ESISTE GIA' UN'ISTANZA");
		pst = db.prepareStatement("select id, id_esito_classyfarm, descrizione_errore_classyfarm, descrizione_messaggio_classyfarm, data_invio, riaperta from farmacosorveglianza_istanze where id_controllo = ? and id_lookup_chk_classyfarm_mod = ? and trashed_date is null");
		pst.setInt(1, idControllo);
		pst.setInt(2, idChkClassyfarmMod);

		rs = pst.executeQuery();
		if (rs.next()){
			this.id = rs.getInt("id");
			idEsitoClassyfarmPrecedente =  (rs.getObject("id_esito_classyfarm") != null ? rs.getInt("id_esito_classyfarm") : -1);
			descrizioneErroreClassyfarmPrecedente =  rs.getString("descrizione_errore_classyfarm");
			descrizioneMessaggioClassyfarmPrecedente = rs.getString("descrizione_messaggio_classyfarm");
			dataInvioPrecedente = rs.getTimestamp("data_invio");
			riapertaPrecedente = rs.getBoolean("riaperta");
		}
		System.out.println("ID ISTANZA: "+this.id);
		
		System.out.println("SE ESISTE, DISABILITO L'ISTANZA");

		if (this.id>0){
			pst = db.prepareStatement("update farmacosorveglianza_istanze set trashed_date = now() where id = ? and trashed_date is null");
			pst.setInt(1, this.id);
			pst.executeUpdate();
					
			pst = db.prepareStatement("update farmacosorveglianza_dati set trashed_date = now() where id_istanza = ? and trashed_date is null");
			pst.setInt(1, this.id);
			pst.executeUpdate();
			
			pst = db.prepareStatement("update farmacosorveglianza_risposte_giudizi set trashed_date = now() where id_istanza = ? and trashed_date is null");
			pst.setInt(1, this.id);
			pst.executeUpdate();
			
			pst = db.prepareStatement("update farmacosorveglianza_risposte_evidenze set trashed_date = now() where id_istanza = ? and trashed_date is null");
			pst.setInt(1, this.id);
			pst.executeUpdate();
		}
		
		System.out.println("INSERISCO LA NUOVA ISTANZA");
		pst = db.prepareStatement("insert into farmacosorveglianza_istanze (id_controllo, id_lookup_chk_classyfarm_mod, org_id, enteredby, modifiedby, bozza, id_esito_classyfarm, descrizione_errore_classyfarm, descrizione_messaggio_classyfarm, data_invio, riaperta) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning id as id_inserito");
		pst.setInt(1, idControllo);
		pst.setInt(2, idChkClassyfarmMod);
		pst.setInt(3, orgId);
		pst.setInt(4, enteredBy);
		pst.setInt(5, enteredBy);
		pst.setBoolean(6, bozza);
		pst.setInt(7, idEsitoClassyfarmPrecedente);
		pst.setString(8, descrizioneErroreClassyfarmPrecedente);
		pst.setString(9, descrizioneMessaggioClassyfarmPrecedente);
		pst.setTimestamp(10, dataInvioPrecedente);
		pst.setBoolean(11, riapertaPrecedente);
		rs = pst.executeQuery();
		
		if (rs.next())
			this.id = rs.getInt("id_inserito");
		
		System.out.println("INSERISCO I NUOVI DATI");
		dati.insertDati(db, id);

		System.out.println("INSERISCO LE NUOVE RISPOSTE");
		
		for (int s = 0; s<sezioni.size(); s++){
			   Sezione sezione = (Sezione) sezioni.get(s);
			   for (int d = 0; d<sezione.getListaDomande().size(); d++){
					Domanda domanda = (Domanda) sezione.getListaDomande().get(d);
					domanda.insertEvidenza(db, id, enteredBy);
					for (int g = 0; g<domanda.getListaGiudizi().size(); g++){
						Giudizio giudizio = (Giudizio) domanda.getListaGiudizi().get(g);
						if (giudizio.isRisposto())
							giudizio.insertGiudizio(db, id, domanda.getId(), enteredBy);
					}
	
			   }
		}
		
		}


	public int getIdChkClassyfarmMod() {
		return idChkClassyfarmMod;
	}


	public void setIdChkClassyfarmMod(int idChkClassyfarmMod) {
		this.idChkClassyfarmMod = idChkClassyfarmMod;
	}
	
	
	
	
	
	    
}
