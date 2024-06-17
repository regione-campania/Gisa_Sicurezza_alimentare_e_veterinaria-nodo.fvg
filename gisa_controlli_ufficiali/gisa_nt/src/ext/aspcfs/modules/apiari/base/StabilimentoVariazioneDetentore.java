package ext.aspcfs.modules.apiari.base;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.darkhorseventures.framework.beans.GenericBean;

public class StabilimentoVariazioneDetentore extends GenericBean {
	
	private Timestamp dataVariazione ;
	private int idSoggettoFisico ;
	
	private SoggettoFisico soggettoFisico ;

	public Timestamp getDataVariazione() {
		return dataVariazione;
	}

	public void setDataVariazione(Timestamp dataVariazione) {
		this.dataVariazione = dataVariazione;
	}

	public int getIdSoggettoFisico() {
		return idSoggettoFisico;
	}

	public void setIdSoggettoFisico(int idSoggettoFisico) {
		this.idSoggettoFisico = idSoggettoFisico;
	}

	public SoggettoFisico getSoggettoFisico() {
		return soggettoFisico;
	}

	public void setSoggettoFisico(SoggettoFisico soggettoFisico) {
		this.soggettoFisico = soggettoFisico;
	}
	
	public void buildRecord(Connection db , ResultSet rs) throws SQLException
	{
		idSoggettoFisico = rs.getInt("id_soggetto_fisico_nuovo_detentore");
		dataVariazione = rs.getTimestamp("data_assegnazione_detentore");
		
		soggettoFisico=new SoggettoFisico(db,idSoggettoFisico);
	}
	

}
