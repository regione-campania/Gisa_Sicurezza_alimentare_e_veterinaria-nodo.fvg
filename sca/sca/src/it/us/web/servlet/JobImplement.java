package it.us.web.servlet;

import it.us.web.action.GenericAction;
import it.us.web.bean.UserOperation;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;


public class JobImplement implements Job {

	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDataMap jdMap = context.getJobDetail().getJobDataMap();
		ServletConfig config = (ServletConfig) jdMap.get("config");
		String type = (String)jdMap.get("type");
		switch (type) {
			case "1" : type = "(Orario Lavorativo)"; break;
			case "2" : type = "(Orario Notturno)"; break;
			case "3" : type = "(Festivo)"; break;
			default : type ="";
		} 
		
		System.out.println("[SCA] Inizio Procedura Automatica di LOG OPERAZIONI UTENTE ["+new Date()+"] - "+type);
		
		HashMap<String, HttpSession> utenti = (HashMap<String, HttpSession>)config.getServletContext().getAttribute("utenti");
		if(utenti != null && utenti.size() > 0){
			Iterator it = utenti.entrySet().iterator();
			try{
				while (it.hasNext()){
					Entry entry = (Entry) it.next();
					HttpSession sessione = (HttpSession)entry.getValue();
					ArrayList<UserOperation> op =  (ArrayList<UserOperation>)sessione.getAttribute("operazioni");
					sessione.removeAttribute("operazioni");
					GenericAction.writeStorico(op, true);  
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		System.out.println("[SCA] Fine Procedura Automatica di LOG OPERAZIONI UTENTE ["+new Date()+"] - "+type);
	}
}
