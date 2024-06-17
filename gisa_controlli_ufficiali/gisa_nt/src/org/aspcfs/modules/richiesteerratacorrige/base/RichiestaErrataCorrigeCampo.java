package org.aspcfs.modules.richiesteerratacorrige.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class RichiestaErrataCorrigeCampo {
	
	private int id = -1;
	private int idErrataCorrige = -1;
	private int idLookupInfoDaModificare = -1;
	private String datoErrato = "";
	private String datoCorretto="";
	


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdErrataCorrige() {
		return idErrataCorrige;
	}

	public void setIdErrataCorrige(int idErrataCorrige) {
		this.idErrataCorrige = idErrataCorrige;
	}

	public int getIdLookupInfoDaModificare() {
		return idLookupInfoDaModificare;
	}

	public void setIdLookupInfoDaModificare(int idLookupInfoDaModificare) {
		this.idLookupInfoDaModificare = idLookupInfoDaModificare;
	}

	public String getDatoErrato() {
		return datoErrato;
	}

	public void setDatoErrato(String datoErrato) {
		this.datoErrato = datoErrato;
	}

	public String getDatoCorretto() {
		return datoCorretto;
	}

	public void setDatoCorretto(String datoCorretto) {
		this.datoCorretto = datoCorretto;
	}

	public RichiestaErrataCorrigeCampo() {
 
	}
	
	public RichiestaErrataCorrigeCampo(ResultSet rs) throws SQLException {

		this.id = rs.getInt("id");
		this.idErrataCorrige = rs.getInt("id_richieste_errata_corrige");
		this.idLookupInfoDaModificare = rs.getInt("id_richieste_errata_corrige_lookup_info_da_modificare");
		this.datoErrato = rs.getString("dato_errato");
		this.datoCorretto = rs.getString("dato_corretto");
	}

	public void insert(Connection db) throws SQLException {
		PreparedStatement pst = db.prepareStatement("insert into richieste_errata_corrige_campi (id_richieste_errata_corrige, id_richieste_errata_corrige_lookup_info_da_modificare, dato_errato, dato_corretto)  values (?, ?, ?, ?)");
		int i = 0;
		pst.setInt(++i, idErrataCorrige);
		pst.setInt(++i, idLookupInfoDaModificare);
		pst.setString(++i, datoErrato);
		pst.setString(++i, datoCorretto);

		if (!datoErrato.equals("") || !datoCorretto.equals(""))
			pst.execute();
		
	}

	
}




	

