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
import it.us.web.bean.vam.lookup.LookupHabitat;
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

public class LookupHabitatDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupHabitatDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupHabitat getHabitats( int id, Connection connection ) throws SQLException
	{
		LookupHabitat h = new LookupHabitat();
		String sql = "select id,description,level,enabled from lookup_habitat where enabled and id = ? " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			h.setId(rs.getInt("id"));
			h.setDescription(rs.getString("description"));
			h.setEnabled(rs.getBoolean("enabled"));
			h.setLevel(rs.getInt("level"));
		}
		return h;
	}
	
	
	
	public static LookupHabitat getHabitat( ResultSet rs ) throws SQLException
	{
		LookupHabitat h = new LookupHabitat();
		h.setId(rs.getInt("id"));
		h.setDescription(rs.getString("description"));
		h.setEnabled(rs.getBoolean("enabled"));
		h.setLevel(rs.getInt("level"));
		return h;
	}
	
	
	
	public static ArrayList<LookupHabitat> getHabitat(Connection connection) throws SQLException
	{
		ArrayList<LookupHabitat> h = new ArrayList<LookupHabitat>();
		String sql = "select id,description,level,enabled from lookup_habitat where enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			h.add(getHabitat(rs));
		}
		return h;
	}
	
	
	public static Set<LookupHabitat> getHabitat(Connection connection, int idCc) throws SQLException
	{
		HashSet<LookupHabitat> h = new HashSet<LookupHabitat>();
		String sql = "select alim.id,alim.description,alim.level,alim.enabled from lookup_habitat alim join animali_habitat a on a.habitat = alim.id and a.cc =  ? where alim.enabled order by level asc  " ;
		PreparedStatement st = connection.prepareStatement(sql);
		
		st.setInt(1, idCc);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			h.add(getHabitat(rs));
		}
		return h;
	}
	
	
}
