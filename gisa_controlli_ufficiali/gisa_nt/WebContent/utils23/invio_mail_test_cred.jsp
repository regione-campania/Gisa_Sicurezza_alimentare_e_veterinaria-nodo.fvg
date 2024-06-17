<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.aspcfs.modules.suap.base.PecMailSender"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.aspcfs.utils.GestoreConnessioni"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>

<%!
public static  void sendMailPec(String testo,String object,String toDest)
{

	
	Properties props = new Properties();
	props.put("mail.smtp.starttls.enable","false");
	props.put("mail.smtp.auth","true");
	props.put("mail.smtp.host", "192.168.10.10");
	props.put("mail.smtp.port", "25");
	props.put("mail.smtp.ssl.enable","false");
 	props.put("mail.smtp.ssl.protocols", "");
 	props.put("mail.smtp.socketFactory.class","");
 	props.put("mail.smtp.socketFactory.fallback", "");

	
	Session sess = Session.getInstance(props, new javax.mail.Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication("M3023707", "US9560031.1a");
		}
	 });
	
	sess.setDebug(true);
	
	try
	{
	MimeMessage mimeMsg = new MimeMessage(sess);
	mimeMsg.setFrom(new InternetAddress("gisa.sicurezzalavoro@regione.campania.it"));
	mimeMsg.addRecipient(Message.RecipientType.TO, new InternetAddress(toDest));
	
	
	mimeMsg.setSubject(object);
	StringBuffer sb = new StringBuffer(testo);
	mimeMsg.setText(sb.toString(),"utf-8","html");
	Transport.send(mimeMsg);
	}
	catch(Exception e)
	{
	e.printStackTrace();		
}
}
%>
<%
		
		String body;

		
		

		sendMailPec("nella jsp invio_mail_test_cred.jsp c'è la"  , "##CONFIGURAZIONE CRED CHE FUNZIONA##", "gisadev@usmail.it");

%>


















