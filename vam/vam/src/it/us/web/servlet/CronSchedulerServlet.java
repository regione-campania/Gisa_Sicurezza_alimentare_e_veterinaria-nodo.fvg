package it.us.web.servlet;

import it.us.web.util.properties.Application;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

/**
 * Servlet implementation class CronScheduler
 */
public class CronSchedulerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**    
     * @see HttpServlet#HttpServlet()
     */
    public CronSchedulerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
	public void init(ServletConfig config) throws ServletException {
    	if (Application.get("abilitaStoricoOperazioniUtente")!=null &&
    			Application.get("abilitaStoricoOperazioniUtente").equalsIgnoreCase("si") ){  	
        	boolean flag = true;
			try {    
				for (int i=1;i<=3;i++){
					SchedulerFactory sf = new StdSchedulerFactory();
					Scheduler sche = sf.getScheduler();
					sche.start();
				
					String time_interval = (String)Application.get("cleancache_time_interval_"+i);
					JobDetail jDetail = new JobDetail("V_myjob"+i,sche.DEFAULT_GROUP,JobImplement.class);
					jDetail.getJobDataMap().put("config", config);
					jDetail.getJobDataMap().put("type", String.valueOf(i));
		   			CronTrigger crTrigger = new CronTrigger("V_cronTrigger_"+i, sche.DEFAULT_GROUP, time_interval);
					sche.scheduleJob(jDetail, crTrigger);
				}
			} catch (Exception e){
				flag = false;
				e.printStackTrace();
			} finally {
				if (flag==true)
					System.out.println("[VAM] AVVIATO SCHEDULER STORICO OPERAZIONI UTENTE");
				else
					System.out.println("[VAM] ERRORE DURANTE L'AVVIO DELLO SCHEDULER STORICO OPERAZIONI UTENTE");
			} 
    	} else {
    		System.out.println("[VAM] STORICO OPERAZIONI UTENTE DISATTIVATO");
    	}
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
		// TODO Auto-generated method stub
	}

}
