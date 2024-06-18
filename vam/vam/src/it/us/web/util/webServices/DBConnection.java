package it.us.web.util.webServices;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
			
	
	public static Connection getConnection() throws ClassNotFoundException {

		Connection con = null;
		
		Class.forName("org.postgresql.Driver");    
		
		try {
		
			con = DriverManager.getConnection ( "jdbc:postgresql://localhost/vam","postgres", "postgres"); 

		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	public static void closeResources(Statement statement){
    	try
    	{
    		if(statement != null)
    			statement.close();
    	}catch(Exception ex)
    	{
    		ex.printStackTrace();
    	}
    }
	
	public static void closeDBServer(Connection con){
    	try
    	{
    		if (con != null) 
    			con.close();
        }
        catch(Exception e)
        {
        	e.printStackTrace();
        	
        }
    }
}
