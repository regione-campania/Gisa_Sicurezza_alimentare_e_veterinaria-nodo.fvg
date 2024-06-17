package ext.aspcfs.modules.apiari.base;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.darkhorseventures.framework.beans.GenericBean;

public class StabilimentoVariazioneUbicazione extends GenericBean{


	private Timestamp dataVariazione ;
	private int idIndirizzo ;
	
	private Timestamp dataInizio ;
	private Timestamp dataFine ;
	private Indirizzo indirizzo ;
	
	
	public Timestamp getDataVariazione() {
		return dataVariazione;
	}

	public void setDataVariazione(Timestamp dataVariazione) {
		this.dataVariazione = dataVariazione;
	}

	
	public int getIdIndirizzo() {
		return idIndirizzo;
	}

	public void setIdIndirizzo(int idIndirizzo) {
		this.idIndirizzo = idIndirizzo;
	}

	public Timestamp getDataInizio() {
		return dataInizio;
	}

	public void setDataInizio(Timestamp dataInizio) {
		this.dataInizio = dataInizio;
	}

	public Timestamp getDataFine() {
		return dataFine;
	}

	public void setDataFine(Timestamp dataFine) {
		this.dataFine = dataFine;
	}

	public Indirizzo getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(Indirizzo indirizzo) {
		this.indirizzo = indirizzo;
	}

	public void buildRecord(Connection db , ResultSet rs) throws SQLException
	{
		idIndirizzo = rs.getInt("id_opu_indirizzo");
		dataVariazione = rs.getTimestamp("data_assegnazione_ubicazione");
		dataInizio = rs.getTimestamp("data_inizio");
		dataFine = rs.getTimestamp("data_fine");
		indirizzo=new Indirizzo(db,idIndirizzo);
	}
	



}
