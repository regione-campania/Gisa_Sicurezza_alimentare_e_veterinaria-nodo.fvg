package it.us.web.servlet;

import it.us.web.util.properties.Application;

import java.io.IOException;
import java.net.URL;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.slf4j.LoggerFactory;

import ch.qos.logback.access.joran.JoranConfigurator;
import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.core.joran.spi.JoranException;

public class SettaFileLogback extends HttpServlet 
{
	  public void init(ServletConfig config) throws ServletException  
	  { 	
		  
		//CARICA FILE DI LOGBACK PER : SVILUPPO - DEMO - UFFICIALE - CLOUD 
		String a = Application.get("ambiente");
	    String logbackConfigFile =  config.getServletContext().getInitParameter("logback.configurationFile_" + a);
	    
	  
	    
	    URL configFileURL;
	    if (logbackConfigFile != null) 
	    {
	      configFileURL = Thread.currentThread().getContextClassLoader().getResource(logbackConfigFile);
	      if (configFileURL != null)
	      {
	        JoranConfigurator configurator = new JoranConfigurator(); 
	        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory(); 
	        loggerContext.reset(); 
	        configurator.setContext(loggerContext); 
	        try { 
	        	configurator.doConfigure(configFileURL); 
	        } 
	        catch (JoranException ex) { 
	        } 
	      }
	    }
	    
	    
	    //CONTROLLA IL TIPO DI AMBIENTE
	    SettaAmbiente amb = new SettaAmbiente();
	    try {
			amb.check();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  
	  
	    
	    config.getServletContext().setAttribute("ambiente",amb.getAmbiente());
	    config.getServletContext().setAttribute("dbMode",amb.getDbMode());
	    System.out.println("LogbackFile : "+logbackConfigFile);
	  }
	
}