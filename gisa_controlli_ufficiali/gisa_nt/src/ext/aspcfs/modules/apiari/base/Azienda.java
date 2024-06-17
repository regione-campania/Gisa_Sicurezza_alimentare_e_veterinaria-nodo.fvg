package ext.aspcfs.modules.apiari.base;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.darkhorseventures.framework.beans.GenericBean;

public class Azienda extends GenericBean {
	private String codiceAzienda ; 
	private int idComune ;
	private int idDistretto ;
	private Timestamp dataInizio ;
	private int id ;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodiceAzienda() {
		return codiceAzienda;
	}
	public void setCodiceAzienda(String codiceAzienda) {
		this.codiceAzienda = codiceAzienda;
	}
	public int getIdComune() {
		return idComune;
	}
	public void setIdComune(int idComune) {
		this.idComune = idComune;
	}
	public void setIdComune(String idComune) {
		if (idComune != null && ! "".equalsIgnoreCase(idComune))
			this.idComune = Integer.parseInt(idComune);
	}
	
	public int getIdDistretto() {
		return idDistretto;
	}
	public void setIdDistretto(int idDistretto) {
		this.idDistretto = idDistretto;
	}
	public void setIdDistretto(String idDistretto) {
		if (idDistretto != null && ! "".equalsIgnoreCase(idDistretto))
			this.idDistretto = Integer.parseInt(idDistretto);
	}
	public Timestamp getDataInizio() {
		return dataInizio;
	}
	public void setDataInizio(Timestamp dataInizio) {
		this.dataInizio = dataInizio;
	}
	
	
	
	public void setDataInizio(String dataInizio) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (dataInizio != null && ! "".equalsIgnoreCase(dataInizio))
		this.dataInizio = new Timestamp(sdf.parse(dataInizio).getTime());
	}
	
	public boolean insert (Connection db )
	{
		return true ;
	}
	
	public void queryRecord(Connection db, int idAzienda)
	{
		
	}
	
	public void buildRecord(ResultSet rs) throws SQLException
	{
		codiceAzienda = rs.getString("codice_azienda");
		idComune = rs.getInt("comune");
		dataInizio = rs.getTimestamp("data_apertura");
		idDistretto = rs.getInt("distretto");
	}
	
}
