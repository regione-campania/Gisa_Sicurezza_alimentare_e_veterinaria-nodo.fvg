package org.aspcfs.modules.meeting.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.darkhorseventures.framework.beans.GenericBean;

public class ReferenteApprovazione extends GenericBean{
	
	private Referente referente ;
	private int stato ;
	private String note ;
	private Timestamp dataApprovazione ;
	private String revVerbale;
	public Referente getReferente() {
		return referente;
	}
	public void setReferente(Referente referente) {
		this.referente = referente;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}
	
	public void setStato(String stato) {
		if (stato != null && !"".equals(stato))
		{
			this.stato = Integer.parseInt(stato);
		}
		
	}
	
	
	
	public String getRevVerbale() {
		return revVerbale;
	}
	public void setRevVerbale(String revVerbale) {
		this.revVerbale = revVerbale;
	}
	public String getNote() {
		if(note!=null)
		return note;
		return "" ;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Timestamp getDataApprovazione() {
		return dataApprovazione;
	}
	public void setDataApprovazione(Timestamp dataApprovazione) {
		this.dataApprovazione = dataApprovazione;
	}
	
	public void setDataApprovazione(String dataApprovazione) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		if (dataApprovazione!=null && !"".equals(dataApprovazione))
		{
			this.dataApprovazione = new Timestamp(sdf.parse(dataApprovazione).getTime());
		}
		
	}
	
	
	public void loadResultSet(ResultSet rs) throws SQLException {
		  
		this.setDataApprovazione(rs.getTimestamp("data"));
		this.setStato(rs.getInt("stato"));
		this.setNote(rs.getString("note"));
		this.setRevVerbale(rs.getString("rev_verbale"));
		
		
	}
	
	
	
	public void updateStato(Connection db , int idRiunione,int modifiedby)
	{
		String update = "UPDATE referenti_approvazione_riunioni set note=?, rev_verbale = ? , stato = ?,data=current_timestamp,modified=current_timestamp,modifiedby=? where id_riunione = ? and id_referente = ? ";
		try
		{
			
			PreparedStatement pst = db.prepareStatement(update);
			pst.setString(1, note);
			pst.setString(2, revVerbale);
			pst.setInt(3, stato);
			pst.setInt(4, modifiedby);
			pst.setInt(5, idRiunione);
			pst.setInt(6, this.getReferente().getId());
			pst.execute();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	
	}
	
	

	
}
