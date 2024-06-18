package it.us.web.util.vam;

import java.util.ArrayList;

import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.MagazzinoArticoliSanitari;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.dao.hibernate.Persistence;

public class MagazzinoArticoliSanitariUtil {
	
	public static MagazzinoArticoliSanitari checkArticoloSanitario(Persistence persistence, int idClinica, int idArticoloSanitario) 
	{
		
		MagazzinoArticoliSanitari magazzinoArticoliSanitari = null ;
		
		//Recupero per capire se quella clinica possiade già quell'articolo sanitario
		ArrayList<MagazzinoArticoliSanitari> magazzinoArticoliSanitariList = (ArrayList<MagazzinoArticoliSanitari>) 
			persistence.getNamedQuery("CheckArticoloSanitarioInClinica")
			.setInteger("idClinica", idClinica)
			.setInteger("idArticoloSanitario", idArticoloSanitario)
			.list();
		
		if (magazzinoArticoliSanitariList.size() > 0) 
		{
			magazzinoArticoliSanitari = (MagazzinoArticoliSanitari) magazzinoArticoliSanitariList.get(0);
		}
		
		return magazzinoArticoliSanitari;
					
	}
}
