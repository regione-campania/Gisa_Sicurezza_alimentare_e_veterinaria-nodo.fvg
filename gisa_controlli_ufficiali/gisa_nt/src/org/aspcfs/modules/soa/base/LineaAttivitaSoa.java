package org.aspcfs.modules.soa.base;

import java.sql.Types;


public class LineaAttivitaSoa {

	private static final int INT		= Types.INTEGER;
	private static final int STRING		= Types.VARCHAR;
	private static final int DOUBLE		= Types.DOUBLE;
	private static final int FLOAT		= Types.FLOAT;
	private static final int TIMESTAMP	= Types.TIMESTAMP;
	private static final int DATE		= Types.DATE;
	private static final int BOOLEAN	= Types.BOOLEAN;
	
	private String impianto ;
	private String categoria ;
	public String getImpianto() {
		return impianto;
	}
	public void setImpianto(String impianto) {
		this.impianto = impianto;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
//	public static  ArrayList<String> load_linea_attivita_per_cu(String idCu, Connection db )
//	{
//
//		ArrayList<String>		ret		= new ArrayList<String>();
//		PreparedStatement	stat	= null;
//		ResultSet			res		= null;
//		String temp = null ;
//		if( (idCu != null) && (idCu.trim().length() > 0) )
//		{
//			try
//			{
//				int iid = Integer.parseInt( idCu );
//							
//				String sql = "select * from linee_attivita_controlli_ufficiali_stab_soa where id_controllo_ufficiale =?";
//				stat	= db.prepareStatement( sql );
//				
//				stat.setInt( 1, iid );
//				res		= stat.executeQuery();
//				while( res.next() )
//				{
//					temp = res.getString("linea_attivita_stabilimenti_soa");
//					ret.add(temp);
//				}
//			}
//			catch (Exception e)
//			{
//				e.printStackTrace();
//			}
//			finally
//			{
//				try
//				{
//					if( res != null )
//					{
//						res.close();
//						res = null;
//					}
//					
//					if( stat != null )
//					{
//						stat.close();
//						stat = null;
//					}
//				}
//				catch (Exception e)
//				{
//					e.printStackTrace();
//				}
//			}
//		}
//		
//		return ret;
//	
//	}
//	
	
}
