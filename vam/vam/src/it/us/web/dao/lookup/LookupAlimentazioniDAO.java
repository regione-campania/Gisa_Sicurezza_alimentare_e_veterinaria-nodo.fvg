package it.us.web.dao.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.lookup.LookupAccettazioneAttivitaEsterna;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAlimentazioniQualita;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAssociazioni;
import it.us.web.bean.vam.lookup.LookupTipiRichiedente;
import it.us.web.constants.Sql;
import it.us.web.dao.GenericDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.util.Md5;
import it.us.web.util.bean.Bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Restrictions;
import org.infinispan.loaders.modifications.Prepare;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cacheonix.util.array.HashSet;

public class LookupAlimentazioniDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupAlimentazioniDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupAlimentazioni getAlimentazione( int id, Connection connection ) throws SQLException
	{
		LookupAlimentazioni alimentazioni = new LookupAlimentazioni();
		String sql = "select id,description,level,enabled from lookup_tipi_richiedente where enabled and id = ? " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			alimentazioni.setId(rs.getInt("id"));
			alimentazioni.setDescription(rs.getString("description"));
			alimentazioni.setEnabled(rs.getBoolean("enabled"));
			alimentazioni.setLevel(rs.getInt("level"));
		}
		return alimentazioni;
	}
	
	
	
	public static LookupAlimentazioni getAlimentazione( ResultSet rs ) throws SQLException
	{
		LookupAlimentazioni alim = new LookupAlimentazioni();
		alim.setId(rs.getInt("id"));
		alim.setDescription(rs.getString("description"));
		alim.setEnabled(rs.getBoolean("enabled"));
		alim.setLevel(rs.getInt("level"));
		return alim;
	}
	
	public static LookupAlimentazioniQualita getAlimentazioneQ( ResultSet rs ) throws SQLException
	{
		LookupAlimentazioniQualita alim = new LookupAlimentazioniQualita();
		alim.setId(rs.getInt("id"));
		alim.setDescription(rs.getString("description"));
		alim.setEnabled(rs.getBoolean("enabled"));
		alim.setLevel(rs.getInt("level"));
		return alim;
	}
	
	
	
	public static ArrayList<LookupAlimentazioni> getAlimentazioni(Connection connection) throws SQLException
	{
		ArrayList<LookupAlimentazioni> alimentazioni = new ArrayList<LookupAlimentazioni>();
		String sql = "select id,description,level,enabled from lookup_alimentazioni where enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			alimentazioni.add(getAlimentazione(rs));
		}
		return alimentazioni;
	}
	
	public static Set<LookupAlimentazioni> getAlimentazioni(Connection connection, int idCc) throws SQLException
	{
		HashSet<LookupAlimentazioni> alimentazioni = new HashSet<LookupAlimentazioni>();
		String sql = "select alim.id,alim.description,alim.level,alim.enabled from lookup_alimentazioni alim join animali_alimentazioni a on a.alimentazione = alim.id and a.cc =  ? where alim.enabled order by level asc   " ;
		PreparedStatement st = connection.prepareStatement(sql);
		
		st.setInt(1, idCc);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			alimentazioni.add(getAlimentazione(rs));
		}
		return alimentazioni;
	}
	
	
	public static Set<LookupAlimentazioniQualita> getAlimentazioniQ(Connection connection, int idCc) throws SQLException
	{
		HashSet<LookupAlimentazioniQualita> alimentazioni = new HashSet<LookupAlimentazioniQualita>();
		String sql = "select alim.id,alim.description,alim.level,alim.enabled from lookup_alimentazioni_qualita alim join animali_alimentazioni_qualita a on a.alimentazione_qualita = alim.id and a.cc =  ? where alim.enabled order by level asc   " ;
		PreparedStatement st = connection.prepareStatement(sql);
		
		st.setInt(1, idCc);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			alimentazioni.add(getAlimentazioneQ(rs));
		}
		return alimentazioni;
	}
	
	
}
