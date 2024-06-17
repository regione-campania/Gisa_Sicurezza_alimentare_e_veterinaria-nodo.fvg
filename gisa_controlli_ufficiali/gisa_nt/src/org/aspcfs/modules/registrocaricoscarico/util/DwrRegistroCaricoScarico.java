package org.aspcfs.modules.registrocaricoscarico.util;

	import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.utils.GestoreConnessioni;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.json.JSONObject;

import com.darkhorseventures.database.ConnectionElement;

	public class DwrRegistroCaricoScarico { 


		
		public String getInfoCapo(String matricola, int idRegistro) throws SQLException
		{
						
			Connection db = null ;
			WebContext ctx = WebContextFactory.get();
			ConnectionElement ce = (ConnectionElement) ctx.getSession().getAttribute("ConnectionElement");
			SystemStatus systemStatus = (SystemStatus) ((Hashtable) ctx.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
			HttpServletRequest req = ctx.getHttpServletRequest();
			
			JSONObject json = new JSONObject();
			
			try {
				db = GestoreConnessioni.getConnection();
				String sqlVer = "select * from get_info_registro_carico_scarico_capo(?, ?)";
				PreparedStatement pst = null ;
				ResultSet rs = null ;
				pst = db.prepareStatement(sqlVer);
				pst.setString(1, matricola);
				pst.setInt(2, idRegistro);
				rs = pst.executeQuery();

				if (rs.next())
				{
					json.put("nomeCapo",  rs.getString("nome_capo"));
					json.put("matricola",  rs.getString("matricola"));
					json.put("idSpecie",  rs.getInt("id_specie"));
					json.put("idRazza",  rs.getInt("id_razza"));

				}
				
			} catch (SQLException e) {
				throw e ;
			}
			catch (NumberFormatException g) {
				throw g ;
			}	
			finally
			{
				GestoreConnessioni.freeConnection(db);
			}
			return json.toString();
		}
		
		
		
	}


