package it.us.web.dao.lookup;

import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.sinantropi.lookup.LookupSinantropiEta;
import it.us.web.bean.vam.Animale;
import it.us.web.bean.vam.Clinica;
import it.us.web.bean.vam.lookup.LookupAccettazioneAttivitaEsterna;
import it.us.web.bean.vam.lookup.LookupAlimentazioni;
import it.us.web.bean.vam.lookup.LookupAsl;
import it.us.web.bean.vam.lookup.LookupAssociazioni;
import it.us.web.bean.vam.lookup.LookupFerite;
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

public class LookupFeriteDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupFeriteDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupFerite getFerite( int id, Connection connection ) throws SQLException
	{
		LookupFerite f = new LookupFerite();
		String sql = "select id,description,level,enabled from lookup_ferite where enabled and id = ? " ;
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			f.setId(rs.getInt("id"));
			f.setDescription(rs.getString("description"));
			f.setEnabled(rs.getBoolean("enabled"));
			f.setLevel(rs.getInt("level"));
		}
		return f;
	}
	
	
	
	public static LookupFerite getFerita( ResultSet rs ) throws SQLException
	{
		LookupFerite f = new LookupFerite();
		f.setId(rs.getInt("id"));
		f.setDescription(rs.getString("description"));
		f.setEnabled(rs.getBoolean("enabled"));
		f.setLevel(rs.getInt("level"));
		return f;
	}
	
	
	
	public static ArrayList<LookupFerite> getFerite(Connection connection) throws SQLException
	{
		ArrayList<LookupFerite> f = new ArrayList<LookupFerite>();
		String sql = "select id,description,level,enabled from lookup_ferite where enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			f.add(getFerita(rs));
		}
		return f;
	}
	
	public static Set<LookupFerite> getFerite(Connection connection, int idCc) throws SQLException
	{
		HashSet<LookupFerite> f = new HashSet<LookupFerite>();
		String sql = "select alim.id,alim.description,alim.level,alim.enabled from lookup_ferite alim join animali_ferite a on a.ferite = alim.id and a.cc =  ? where alim.enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		
		st.setInt(1, idCc);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			f.add(getFerita(rs));
		}
		return f;
	}
	
	
}
