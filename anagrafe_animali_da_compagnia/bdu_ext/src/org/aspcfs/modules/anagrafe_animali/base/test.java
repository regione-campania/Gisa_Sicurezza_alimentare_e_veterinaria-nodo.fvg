package org.aspcfs.modules.anagrafe_animali.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.utils.ApplicationProperties;

public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub

ResultSet rs = null;
PreparedStatement pst = null;
		for (int i = 0; i < 1000; i++){
			Connection conn = null;
		//	System.out.println(i);
			String dbName = ApplicationProperties.getProperty("dbnameBdu");
			String username = ApplicationProperties
					.getProperty("usernameDbbdu");
			String pwd = ApplicationProperties.getProperty("passwordDbbdu"); 
			String host = "172.16.3.250";

//			try {
//			//	conn = DbUtil.getConnection(dbName, username, pwd, host);
//				
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}		finally {
//			//	DbUtil.chiudiConnessioneJDBC(rs, pst, conn);
//			}
		}
	}

}
