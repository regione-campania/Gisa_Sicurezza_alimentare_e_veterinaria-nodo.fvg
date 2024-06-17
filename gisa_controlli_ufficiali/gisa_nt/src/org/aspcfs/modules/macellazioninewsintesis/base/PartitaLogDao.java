package org.aspcfs.modules.macellazioninewsintesis.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PartitaLogDao {
	
	private static PartitaLogDao instance;
	private PartitaLogDao(){}
	
	public static PartitaLogDao getInstance(){
		if(instance == null){
			instance = new PartitaLogDao();
		}
		return instance;
	}
	
	public PartitaLog select(Connection db, String partita) throws Exception{
		
		String select = "SELECT * " +
						"FROM m_partite_log " +
						" where partita ilike ?";
		
		PreparedStatement stat = null;
		ResultSet rs = null;
		PartitaLog partitaLog = new PartitaLog();
		
		try{
			stat = db.prepareStatement(select);
			stat.setString 		(1, partita);
			rs = stat.executeQuery();
			
			if(rs.next()){
				partitaLog.setAslSpeditoreFromBdn(rs.getInt("asl_speditore_from_bdn"));
				partitaLog.setCodiceAziendaNascitaFromBdn(rs.getString("codice_azienda_nascita_from_bdn"));
				partitaLog.setComuneSpeditoreFromBdn(rs.getString("comune_speditore_from_bdn"));
				partitaLog.setDataNascitaFromBdn(rs.getTimestamp("data_nascita_from_bdn"));
				partitaLog.setInBdn(rs.getBoolean("in_bdn"));
				partitaLog.setPartita(rs.getString("partita"));
				partitaLog.setSpecieFromBdn(rs.getInt("specie_from_bdn"));
			}
			
			return partitaLog;
			
		}
		finally{
			stat.close();
		}
		
	}
		
	public void insert(Connection db, PartitaLog capoLog) throws Exception{
		
		String insert = "INSERT INTO m_partite_log" +
						"(id_macello, partita, " +
						"codice_azienda_nascita, codice_azienda_nascita_from_bdn, " +
						"comune_speditore, comune_speditore_from_bdn, asl_speditore, asl_speditore_from_bdn, " +
						"in_bdn, entered_by, modified_by, seduta_successiva, entered, modified) " +
						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now() )";
		
		PreparedStatement stat = null;
		int i = 0;
		
		try{
			stat = db.prepareStatement(insert);
			stat.setInt 		(++i, capoLog.getIdMacello());
			stat.setString 		(++i, capoLog.getPartita());
			stat.setString 		(++i, capoLog.getCodiceAziendaNascita());
			stat.setString 		(++i, capoLog.getCodiceAziendaNascitaFromBdn());
			stat.setString 		(++i, capoLog.getComuneSpeditore());
			stat.setString 		(++i, capoLog.getComuneSpeditoreFromBdn());
			stat.setInt 		(++i, capoLog.getAslSpeditore());
			stat.setInt 		(++i, capoLog.getAslSpeditoreFromBdn());
			stat.setBoolean 	(++i, capoLog.isInBdn());
			stat.setInt 		(++i, capoLog.getEnteredBy());
			stat.setInt 		(++i, capoLog.getModifiedBy());
			stat.setBoolean		(++i, capoLog.isSedutaSuccessiva());
			stat.executeUpdate();
		}
		finally{
			stat.close();
		}
		
	}
	
	
	public void update(Connection db, PartitaLog capoLog) throws Exception{
		
		String update = "UPDATE m_partite_log " +
						"SET id_macello=?, " +
						"codice_azienda_nascita=?, codice_azienda_nascita_from_bdn=?, " +
						"comune_speditore=?, comune_speditore_from_bdn=?, asl_speditore=?, asl_speditore_from_bdn=?, " +
						"in_bdn=?, modified_by=?, modified=now(), trashed_date=? " +
						" where partita=?";

		PreparedStatement stat = null;
		int i = 0;
		
		try{
			stat = db.prepareStatement(update);
			stat.setInt 		(++i, capoLog.getIdMacello());
			stat.setString 		(++i, capoLog.getCodiceAziendaNascita());
			stat.setString 		(++i, capoLog.getCodiceAziendaNascitaFromBdn());
			stat.setString 		(++i, capoLog.getComuneSpeditore());
			stat.setString 		(++i, capoLog.getComuneSpeditoreFromBdn());
			stat.setInt 		(++i, capoLog.getAslSpeditore());
			stat.setInt 		(++i, capoLog.getAslSpeditoreFromBdn());
			stat.setBoolean 	(++i, capoLog.isInBdn());
			stat.setInt 		(++i, capoLog.getModifiedBy());
			stat.setTimestamp 	(++i, capoLog.getTrashedDate());
			stat.setString 		(++i, capoLog.getPartita());
			stat.executeUpdate();
		}
		finally{
			stat.close();
		}
		
	}
	
	
	public boolean isCapoLogged(Connection db, PartitaLog capoLog) throws Exception{
		
		boolean isCapoLogged = false;
		
		String count = "SELECT count(partita) " +
					   "FROM m_partite_log " +
					   " where partita ilike ? and trashed_date is null and seduta_successiva = false ";

		PreparedStatement stat = null;
		ResultSet rs = null;
		
		try{
			stat = db.prepareStatement(count);
			stat.setString 		(1, capoLog.getPartita());
			rs = stat.executeQuery();
			if(rs.next()){
				isCapoLogged = rs.getInt(1) > 0;
			}
			return isCapoLogged;
		}
		finally
		{
			if(rs!=null)
				rs.close();
			stat.close();
		}
		
	}
	
	
	
	public void log(Connection db, PartitaLog capoLog) throws Exception
	{
		
			if(this.isCapoLogged(db, capoLog))
				this.update(db, capoLog);
			else
				this.insert(db, capoLog);
	}
}
