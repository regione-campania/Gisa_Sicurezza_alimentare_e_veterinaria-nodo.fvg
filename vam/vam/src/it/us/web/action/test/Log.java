package it.us.web.action.test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.LoggerContext;
import ch.qos.logback.core.util.StatusPrinter;


public class Log
{
	 final Logger logger = LoggerFactory.getLogger(Log.class);
	 
	 public void example()
	 {
		 logger.debug("Enter oggi");
		 
		// print internal state
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
		StatusPrinter.print(lc);

	 }
	 
	 
	 public static void main(String[] argv)
	 {
		 Log l = new Log();
		 l.example();
	 }
}
