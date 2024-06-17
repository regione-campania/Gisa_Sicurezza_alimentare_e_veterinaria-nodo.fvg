package ext.aspcfs.modules.apicolture.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.mycfs.base.Mail;

import com.darkhorseventures.framework.actions.ActionContext;

public class GisaBDA extends CFSModule
{
	public String executeCommandDefault(ActionContext context)
	{
		Connection db = null ;
		try
		{
			db = this.getConnection(context);
			int i = 0 ;
			String insert = "INSERT INTO log_user_reg( nome, cognome, codice_fiscale, "
					+ "sesso, pec, comune_residenza, provincia_residenza, cap_residenza, indirizzo_residenza, telefono)VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);" ;
			
			
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			String nome = context.getRequest().getParameter("nome");
			String cognome = context.getRequest().getParameter("cognome");
			String codice_fiscale = context.getRequest().getParameter("cf");
//			String data_nascita = context.getRequest().getParameter("");
//			String comune_nascita = context.getRequest().getParameter("comune");
			String sesso = context.getRequest().getParameter("sesso");
			String pec = context.getRequest().getParameter("pec");
			String comune_residenza = context.getRequest().getParameter("comune");
			String provincia_residenza = context.getRequest().getParameter("provincia");
			String cap_residenza = context.getRequest().getParameter("cap");
			String indirizzo_residenza = context.getRequest().getParameter("indirizzo");
			String telefono = context.getRequest().getParameter("telefono");
	

			
			if (	nome.trim().equalsIgnoreCase("") || 
					cognome.trim().equalsIgnoreCase("") || 
					codice_fiscale.trim().equalsIgnoreCase("") || 
				
					sesso.trim().equalsIgnoreCase("") || 
					pec.trim().equalsIgnoreCase("") || 
					telefono.trim().equalsIgnoreCase("") || 
					comune_residenza.trim().equalsIgnoreCase("") || 
					provincia_residenza.trim().equalsIgnoreCase("") || 
					cap_residenza.trim().equalsIgnoreCase("") || 
					indirizzo_residenza.trim().equalsIgnoreCase("") 
					
					)
			{
				context.getRequest().setAttribute("Esito", "KO");
				context.getRequest().setAttribute("ErroreValidazione", "Completare tutti campi");
			}
			else
			{
			
			
			PreparedStatement pst = db.prepareStatement(insert);
			pst.setString(++i,nome);
			pst.setString(++i,cognome);
			pst.setString(++i,codice_fiscale);
			pst.setString(++i,sesso);
			pst.setString(++i,pec);
			pst.setString(++i,comune_residenza);
			pst.setString(++i,provincia_residenza);
			pst.setString(++i,cap_residenza);
			pst.setString(++i,indirizzo_residenza);
			pst.setString(++i,telefono);
	
			pst.execute();
			sendMailIzsm("####BDAPI RICHIESTA ISCRIZIONE###",""+nome,context);
			
			}
			
			
		}
		catch(SQLException e)
		{
			context.getRequest().setAttribute("Esito", "KO");
			context.getRequest().setAttribute("ErroreValidazione", ""+e.getMessage());
			return "stampaJson";
		}
		finally{
			this.freeConnection(context, db);
		}
		
		
		return "stampaJson";
		
	}
	
	
	
	public  void sendMailIzsm(String testo,String object,ActionContext context)
	{
	
			// initialize the StringBuffer object within the try/catch loop
			StringBuffer sb = new StringBuffer(testo);
			Mail mail = new Mail();
			mail.setHost(getPref(context, "MAILSERVER"));
			mail.setFrom(getPref(context, "EMAILADDRESS"));
			mail.setUser(getPref(context, "EMAILADDRESS"));
			mail.setPass(getPref(context, "MAILPASSWORD"));
			mail.setPort(Integer.parseInt(getPref(context, "PORTSERVER")));
			mail.setTo(getPref(context, "EMAILADDRESS"));
			mail.setSogg(object);
			mail.setTesto(testo);
			mail.sendMail();

			

	}

}
