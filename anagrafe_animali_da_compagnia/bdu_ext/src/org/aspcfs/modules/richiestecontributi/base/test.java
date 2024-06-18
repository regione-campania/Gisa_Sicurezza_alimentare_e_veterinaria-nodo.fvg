package org.aspcfs.modules.richiestecontributi.base;

import org.apache.commons.mail.EmailException;

public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			GestionePEC pec = new GestionePEC("");
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
