package org.aspcfs.modules.registrazioniAnimali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.modules.anagrafe_animali.base.Cane;
import org.aspcfs.modules.anagrafe_animali.base.Furetto;
import org.aspcfs.modules.anagrafe_animali.base.Gatto;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

public class EventoCambioUbicazione extends Evento {

	public static final int idTipologiaDB = 69;

	public EventoCambioUbicazione() {
		super();
		this.setIdTipologiaEvento(idTipologiaDB);
		// TODO Auto-generated constructor stub
	}

	private int id = -1;
	private int idEvento = -1;

	private java.sql.Timestamp data;
	private int idIndirizzo = -1;
	
	public int getIdTipologiaDB() {
		return idTipologiaDB;
	}
	
	


	public int getIdIndirizzo() {
		return idIndirizzo;
	}

	public void setIdIndirizzo(int idIndirizzo) {
		this.idIndirizzo = idIndirizzo;
	}

	public void setIdIndirizzo(String idIndirizzo) {
		this.idIndirizzo = new Integer(idIndirizzo).intValue();
	}

	public java.sql.Timestamp getData() {
		return data;
	}

	public void setData(java.sql.Timestamp data) {
		this.data = data;
	}

	public void setData(String dataTrasferimento) {
		this.data = DateUtils.parseDateStringNew(dataTrasferimento, "dd/MM/yyyy");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdEvento() {
		return idEvento;
	}

	public void setIdEvento(int idEvento) {
		this.idEvento = idEvento;
	}

	public boolean insert(Connection db) throws SQLException {

		StringBuffer sql = new StringBuffer();
		try {
			
			super.insert(db);
			idEvento = super.getIdEvento();

			id = DatabaseUtils.getNextSeq(db, "evento_cambio_ubicazione_id_seq");
			// sql.append("INSERT INTO animale (");

			sql.append("INSERT INTO evento_cambio_ubicazione("
					+ "id_evento, data, id_indirizzo  ");
			sql.append(")VALUES(?,?,?");

			sql.append(")");

			int i = 0;
			PreparedStatement pst = db.prepareStatement(sql.toString());

			pst.setInt(++i, idEvento);

			pst.setTimestamp(++i, data);

			pst.setInt(++i, idIndirizzo);


			pst.execute();
			pst.close();

			this.id = DatabaseUtils.getCurrVal(db, "evento_cambio_ubicazione_id_seq", id);

			

		} catch (SQLException e) {
			
			throw new SQLException(e.getMessage());
		} finally {
			
		}
		return true;

	}

	public EventoCambioUbicazione(ResultSet rs) throws SQLException {
		buildRecord(rs);
	}

	protected void buildRecord(ResultSet rs) throws SQLException {

		super.buildRecord(rs);
		this.idEvento = rs.getInt("idevento");
		this.id = rs.getInt("id");
		this.data = rs.getTimestamp("data");
		this.idIndirizzo = rs.getInt("id_indirizzo");
	}

	public EventoCambioUbicazione(Connection db, int idEventoPadre) throws SQLException 
	{
		PreparedStatement pst = db.prepareStatement("Select *, e.id_evento as idevento, e.id_asl as idaslinserimentoevento from evento e left join evento_cambio_ubicazione f on (e.id_evento = f.id_evento) where e.id_evento = ?");
		pst.setInt(1, idEventoPadre);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
			buildRecord(rs);

		if (idEventoPadre == -1) 
			throw new SQLException(Constants.NOT_FOUND_ERROR);

		rs.close();
		pst.close();
	}


	public EventoCambioUbicazione salvaRegistrazione(int userId, int userRole, int userAsl,
			Animale thisAnimale, Connection db) throws Exception {
		try {

			super.salvaRegistrazione(userId, userRole, userAsl, thisAnimale, db);
			
			Animale oldAnimale = new Animale(db, this.getIdAnimale());

			switch (this.getSpecieAnimaleId()) {
			case Cane.idSpecie:
				thisAnimale = new Cane(db, this.getIdAnimale());
				break;
			case Gatto.idSpecie:
				thisAnimale = new Gatto(db, this.getIdAnimale());
				break;
			case Furetto.idSpecie:
				thisAnimale = new Furetto(db, this.getIdAnimale());
				break;
			default:
				break;
			}

			this.setIdIndirizzo(oldAnimale.getIdProprietario());

			
			this.insert(db);


		} catch (Exception e) {
			throw e;
		}

		return this;

	}
	
	
	public EventoCambioUbicazione build(ResultSet rs) throws Exception {
		try {

			super.build(rs);
			buildRecord(rs);

		} catch (Exception e) {
			throw e;
		}
		return this;
	}

}
