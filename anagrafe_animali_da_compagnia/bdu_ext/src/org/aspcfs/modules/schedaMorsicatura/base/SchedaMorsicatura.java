package org.aspcfs.modules.schedaMorsicatura.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.anagrafe_animali.base.Animale;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

import com.darkhorseventures.framework.beans.GenericBean;

public class SchedaMorsicatura extends GenericBean 
{

	private static Logger log = Logger.getLogger(SchedaMorsicatura.class);
	static 
	{
		if (System.getProperty("DEBUG") != null) 
		{
			log.setLevel(Level.DEBUG);
		}
	}
	
	private int id;
	private int idAnimale;
	private Animale animale;
	private java.sql.Timestamp entered;
	private java.sql.Timestamp modified;
	private int enteredBy;
	private User userEnteredBy;
	private int modifiedBy;
	private User userModifiedBy;
	private java.sql.Timestamp trashedDate;
	private ArrayList<SchedaMorsicaturaRecords> records = new ArrayList<SchedaMorsicaturaRecords>();
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public int getIdAnimale() {
		return idAnimale;
	}

	public void setIdAnimale(int idAnimale) {
		this.idAnimale = idAnimale;
	}
	
	public Animale getAnimale() {
		return animale;
	}

	public void setAnimale(Animale animale) {
		this.animale = animale;
	}

	public void setIdAnimale(String idAnimale) {
		this.idAnimale = new Integer(idAnimale).intValue();
	}
	
	public java.sql.Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) 
	{
		this.entered = entered;
	}
	
	public java.sql.Timestamp getModified() {
		return modified;
	}

	public void setModified(Timestamp modified) 
	{
		this.modified = modified;
	}

	public void setEnteredBy(int enteredBy) 
	{
		this.enteredBy = enteredBy;
	};
	
	public int getEnteredBy() {
		return enteredBy;
	}
	
	public void setUserEnteredBy(User userEnteredBy) 
	{
		this.userEnteredBy = userEnteredBy;
	};
	
	public User getUserEnteredBy() {
		return userEnteredBy;
	}

	
	public int getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) 
	{
		this.modifiedBy = modifiedBy;
	}
	
	public User getUserModifiedBy() {
		return userModifiedBy;
	}

	public void setUserModifiedBy(User userModifiedBy) 
	{
		this.userModifiedBy = userModifiedBy;
	}
	
	public java.sql.Timestamp getTrashedDate() {
		return trashedDate;
	}

	public void setTrashedDate(String trashedDate) 
	{
		this.trashedDate = DateUtils.parseDateStringNew(trashedDate, "dd/MM/yyyy");
	}
	
	public ArrayList<SchedaMorsicaturaRecords> getRecords() {
		return records;
	}

	public void setRecords(ArrayList<SchedaMorsicaturaRecords> records) 
	{
		this.records = records;
	}

	public boolean insert(Connection db) throws SQLIntegrityConstraintViolationException, SQLException 
	{

		StringBuffer sql = new StringBuffer();

		
		id = DatabaseUtils.getNextSeqPostgres(db, "scheda_morsicatura_id_seq");

		sql.append("INSERT INTO scheda_morsicatura( ");

		if (id > -1) 
		{
			sql.append("id, ");
		}

		sql.append("id_animale,entered,modified,entered_by,modified_by ) VALUES (");

		if (id > -1) 
		{
			sql.append("?, ");
		}

		sql.append("?,now(),now(),?,? )");
		
		int i = 0;
		PreparedStatement pst = db.prepareStatement(sql.toString());

		if (id > 0) 
		{
			pst.setInt(++i, id);
		}

		pst.setInt(++i, idAnimale);
		pst.setInt(++i, enteredBy);
		pst.setInt(++i, modifiedBy);

		pst.execute();
		pst.close();

		this.id = DatabaseUtils.getCurrVal(db, "scheda_morsicatura_id_seq", id);

		return true;

	}

	public SchedaMorsicatura() throws SQLException 
	{}
	
	public SchedaMorsicatura getById(Connection db, int id) throws SQLException 
	{
		SchedaMorsicatura scheda = null;
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select * from scheda_morsicatura where id = ?");
		pst.setInt(1, id);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			scheda = buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return scheda;
	}
	
	public ArrayList<SchedaMorsicatura> getByIdAnimale(Connection db, int idAnimale) throws SQLException 
	{
		ArrayList<SchedaMorsicatura> schede = new ArrayList<SchedaMorsicatura>();
		if (idAnimale == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement(" Select * " + 
													" from scheda_morsicatura sc " + 
													" left join evento_morsicatura ev on ev.id_scheda_morsicatura = sc.id " +		
													" where sc.id_animale = ? and sc.trashed_date is null and ev.id_evento is null " + 
													" order by sc.entered desc " );
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		while(rs.next()) 
		{
			schede.add(buildRecord(db, rs));
		}

		rs.close();
		pst.close();
		
		return schede;
	}
	
	public Valutazione getValutazione(Connection db, int idAnimale) throws SQLException 
	{
		Valutazione valutazione = new Valutazione();
		if (idAnimale == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement(" Select * from get_valutazione_scheda_morsicatura(?) ");
		pst.setInt(1, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			valutazione.setPunteggio(rs.getDouble(1));
			valutazione.setRischio(rs.getString(2));
			valutazione.setConsiglio(rs.getString(3));
		}

		rs.close();
		pst.close();
		
		return valutazione;
	}
	
	public SchedaMorsicatura(Connection db, ResultSet rs) throws SQLException 
	{
		this.buildRecord(db, rs);
	}

	private SchedaMorsicatura buildRecord(Connection db, ResultSet rs) throws SQLException 
	{
		SchedaMorsicatura scheda = new SchedaMorsicatura();
		if (rs.getInt("id_animale") > 0) 
		{
			scheda.animale = new Animale(db,rs.getInt("id_animale"));
		}
		if (rs.getInt("entered_by") > 0) 
		{
			scheda.userEnteredBy = new User(db, rs.getInt("entered_by"));
		}
		if (rs.getInt("modified_by") > 0) 
		{
			scheda.userModifiedBy = new User(db, rs.getInt("modified_by"));
		}

		scheda.setAnimale(animale);
		scheda.setUserEnteredBy(userEnteredBy);
		scheda.setUserModifiedBy(userModifiedBy);
		scheda.setId(rs.getInt("id"));
		scheda.setIdAnimale(rs.getInt("id_animale"));
		scheda.setEntered(rs.getTimestamp("entered"));
		scheda.setModified(rs.getTimestamp("modified"));
		scheda.setEnteredBy(rs.getInt("entered_by"));
		scheda.setModifiedBy(rs.getInt("modified_by"));
		
		return scheda;
	}

	
	public int update(Connection conn) throws SQLException 
	{
		int result = -1;
		
		try 
		{
			
			StringBuffer sql = new StringBuffer();

			sql.append("UPDATE scheda_morsicatura SET modified=now(), modified_by=?  where id = ?");

			PreparedStatement pst = conn.prepareStatement(sql.toString());

			int i = 0;
			pst.setInt(++i, this.getModifiedBy());
			pst.setInt(++i, this.getId());
			
			result = pst.executeUpdate();
			pst.close();
			
		} 
		catch (Exception e) 
		{
			throw new SQLException(e.getMessage());
		}

		return result;
	}
	
	public boolean insertStorico(Connection db) throws SQLIntegrityConstraintViolationException, SQLException 
	{

		StringBuffer sql = new StringBuffer();
		
		
		int nextval = DatabaseUtils.getNextSeqPostgres(db, "scheda_morsicatura_storico_id_seq");
		
		
		sql.append("INSERT INTO scheda_morsicatura_storico ( select ?, * from scheda_morsicatura where id = ? )");

		int i = 0;
		PreparedStatement pst = db.prepareStatement(sql.toString());

		pst.setInt(++i, nextval);
		
		if (id > 0) 
		{
			pst.setInt(++i, id);
		}

		pst.execute();
		pst.close();

		return true;

	}
	
	public SchedaMorsicatura get(Connection db, int idCriterio, int idAnimale) throws SQLException 
	{
		SchedaMorsicatura scheda = null;
		if (id == -1) 
		{
			throw new SQLException("Invalid Account");
		}

		PreparedStatement pst = db.prepareStatement("Select scheda.* from scheda_morsicatura scheda, lookup_scheda_morsicatura_indici indice where indice.id = scheda.id_indice and indice.id_criterio = ? and scheda.id_animale = ? ");
		pst.setInt(1, idCriterio);
		pst.setInt(2, idAnimale);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst);
		if (rs.next()) 
		{
			scheda = buildRecord(db, rs);
		}

		rs.close();
		pst.close();
		
		return scheda;
	}

}
