package org.aspcfs.modules.macellazionisintesis.base;







import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class RegistroTumoriRemoteUtil {
	

	
	
	public static void aggiuntiEsitoTumorale( String identificativoIstopatologico, Connection con ) throws Exception
	{

		


			
			
			ArrayList parameters = new ArrayList();
			PreparedStatement st = null;
			ResultSet rs = null;
			//parameters.add(identificativo);
			try {
				

					String query = "select * from public_functions.inserisciesitotumorale('"+identificativoIstopatologico+"')";
					st = con.prepareStatement(query);
					rs = st.executeQuery();
	
				
				/*while (it.hasNext()){
					System.out.println("Record: "+it.next());
				}*/
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			} catch (IllegalAccessException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (InstantiationException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
			
		
	}
		
	}
