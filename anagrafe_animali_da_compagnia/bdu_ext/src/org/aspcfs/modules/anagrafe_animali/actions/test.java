package org.aspcfs.modules.anagrafe_animali.actions;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class test
 */
public class test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public test() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			  
	 
		String s = "ABC";

		byte[] content = s.getBytes();
	       
	        
	  
	        HttpServletResponse resp = null; 
	        
	          
	        try{  
	         //   resp = (HttpServletResponse)FacesContext.getCurrentInstance().getExternalContext().getResponse();     
	  
	            response.reset();  
	  
	            response.setHeader("Content-Disposition","attachment; filename=\"archive.pdf\"");  
	  
	            response.setContentType("application/pdf");  
	  
	            ServletOutputStream outStream = response.getOutputStream();
	            
	  
	            if(content != null){  
	                outStream.write(content);  
	            }  
	              
	            outStream.flush();  
	  
	            outStream.close();  
	        }  
	        catch(Exception e){  
	            System.err.println("PROBLEM STREAMING DAILY REPORT PDF THROUGH RESPONSE!" + e);  
	              
	            e.printStackTrace();  
	              
	    
	  
	          //  return "";  
	        }  
	  
	     //   FacesContext.getCurrentInstance().responseComplete();  
	  
	     //   return "";
	}
	
	
	

}
