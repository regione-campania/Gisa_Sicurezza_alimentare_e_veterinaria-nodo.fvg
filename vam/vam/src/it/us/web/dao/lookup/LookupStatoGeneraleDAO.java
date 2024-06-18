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
import it.us.web.bean.vam.lookup.LookupStatoGenerale;
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

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.criterion.Restrictions;
import org.infinispan.loaders.modifications.Prepare;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LookupStatoGeneraleDAO extends GenericDAO
{
	private static final Logger logger = LoggerFactory.getLogger( LookupStatoGeneraleDAO.class );
	
	/**
	 * Obsoleto
	 * @param un
	 * @param pw
	 * @param persistence
	 * @return
	 */
	public static LookupStatoGenerale getStatoGenerale( int id, Connection connection ) throws SQLException
	{
		LookupStatoGenerale alimentazioni = new LookupStatoGenerale();
		String sql = "select id,description,level,enabled from lookup_stato_generale where enabled and id = ? " ;
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
	
	
	
	public static LookupStatoGenerale getStatoGenerale( ResultSet rs ) throws SQLException
	{
		LookupStatoGenerale alim = new LookupStatoGenerale();
		alim.setId(rs.getInt("id"));
		alim.setDescription(rs.getString("description"));
		alim.setEnabled(rs.getBoolean("enabled"));
		alim.setLevel(rs.getInt("level"));
		return alim;
	}
	
	
	
	public static ArrayList<LookupStatoGenerale> getStatoGenerales(Connection connection) throws SQLException
	{
		ArrayList<LookupStatoGenerale> statoGenerales = new ArrayList<LookupStatoGenerale>();
		String sql = "select id,description,level,enabled from lookup_stato_generale where enabled order by level asc " ;
		PreparedStatement st = connection.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		
		while(rs.next())
		{
			statoGenerales.add(getStatoGenerale(rs));
		}
		return statoGenerales;
	}
	
	
}
