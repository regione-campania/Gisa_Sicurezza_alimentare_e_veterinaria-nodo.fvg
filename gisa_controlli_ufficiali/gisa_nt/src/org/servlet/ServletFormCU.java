package org.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspcfs.utils.GestoreConnessioni;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class ServletForm
 */
public class ServletFormCU extends HttpServlet {
        private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletFormCU() {
        super();
        // TODO Auto-generated constructor stub
    }

        /**
         * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
         */
        protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        	
        	Connection db = null;
        	PreparedStatement pst = null;
            JSONArray json_arr=null;
            json_arr = new JSONArray();

    		try {
    			
//    			String dbName = ApplicationProperties.getProperty("dbnameBdu");
//    			String username = ApplicationProperties.getProperty("usernameDbbdu");
//    			String pwd =ApplicationProperties.getProperty("passwordDbbdu");
//    			String host = InetAddress.getByName("hostDbBdu").getHostAddress();
//    			
//
//    			db = DbUtil.getConnection(dbName, username,
//    					pwd, host);
    			
    			
    			db = GestoreConnessioni.getConnection();
    			
    			
		
                // TODO Auto-generated method stub
               // System.out.println("nella servlet");

                String idPiano = request.getParameter("motivazione_piano_campione");
                String idControllo = request.getParameter("idControllo");
                String codiceInterno = request.getParameter("codice_interno");
                
                        // String test = "<input type= \"text\" value=\"ihih\" />";
                JSONObject json_obj = null ;
             
                	ArrayList fields = new ArrayList();
                	
              
                	
                	//fields = GestoreEventi.getFieldsByPianoMonitoraggio(db, new Integer(idPiano));
                	//fields = GestoreEventi.getFieldsByPianoMonitoraggioAndIdControllo(db, new Integer(idPiano), new Integer(idControllo));
                	fields = GestoreEventi.getFieldsByCodiceInternoAndIdControllo(db, codiceInterno, new Integer(idControllo));
                	
                	for (int i = 0; i < fields.size(); i++){
                		json_obj=new JSONObject(((HashMap)fields.get(i)));
                		 json_arr.put(json_obj);
                	}
                	
                	
        }catch (Exception e){
                System.out.println(e);
        }finally {
        	GestoreConnessioni.freeConnection(db);
		}
        
       
		//GestoreConnessioni.freeConnection(db);
		//db = null;
        response.getWriter().println(json_arr);
        }
        /**
         * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
         */
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                // TODO Auto-generated method stub
                System.out.println("nella servlet GET");
        }

        /**
         * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
         */
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                // TODO Auto-generated method stub
        }

}