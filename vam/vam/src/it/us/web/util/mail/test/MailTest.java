package it.us.web.util.mail.test;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import it.us.web.util.mail.EmailException;
import it.us.web.util.mail.Mailer;


public class MailTest {

	public static void main(String[] args) throws AddressException, MessagingException
	{
		try
		{
			Mailer.send( "a.donatiello@u-s.it", "", "chissà se va", "prova" );
		}
		catch (EmailException e)
		{
			e.printStackTrace();
		}
	}

}
