package it.us.web.dao.sinantropi;

import it.us.web.bean.sinantropi.Catture;
import it.us.web.bean.sinantropi.Reimmissioni;
import it.us.web.dao.GenericDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Vector;

import javax.persistence.Column;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.annotations.Type;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReimmissioniDAO extends GenericDAO 
{
	public static final Logger logger = LoggerFactory.getLogger(ReimmissioniDAO.class);

	
	
	
	
	public static Reimmissioni getReimmissione( Catture c, Connection connection) throws SQLException
	{
		Reimmissioni r = null;
		String sql = " select * "
				+ " from sinantropo_reimmissioni "
				+ " where catture = ? ";
		PreparedStatement st = connection.prepareStatement(sql);
		st.setInt(1, c.getId());
		
		ResultSet rs = st.executeQuery();
		
		if(rs.next())
		{
			r = new Reimmissioni();
			r.setId( rs.getInt("id"));
			r.setDataReimmissione(rs.getDate("data_reimmissione"));
			r.setCatture(c);
		}
		return r;
	}
	
	
}
