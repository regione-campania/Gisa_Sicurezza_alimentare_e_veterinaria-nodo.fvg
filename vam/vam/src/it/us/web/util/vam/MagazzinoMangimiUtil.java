package it.us.web.util.vam;

import java.util.ArrayList;

import it.us.web.bean.vam.MagazzinoMangimi;
import it.us.web.dao.hibernate.Persistence;

public class MagazzinoMangimiUtil {
	
	public static MagazzinoMangimi checkMangime(Persistence persistence, int idClinica, int idTipoAnimale, int idEtaAnimale, int idMangime) 
	{
		
		MagazzinoMangimi magazzinoMangime = null ;
		
		//Recupero per capire se quella clinica possiade già quel mangime
		ArrayList<MagazzinoMangimi> magazzinoMangimiList = (ArrayList<MagazzinoMangimi>) 
			persistence.getNamedQuery("CheckMangimeInClinica")
			.setInteger("idClinica",     idClinica)
			.setInteger("idTipoAnimale", idTipoAnimale)
			.setInteger("idEtaAnimale",  idEtaAnimale)
			.setInteger("idMangime",     idMangime)
			.list();
		
		if (magazzinoMangimiList.size() > 0) 
		{
			magazzinoMangime = (MagazzinoMangimi) magazzinoMangimiList.get(0);
		}
		
		return magazzinoMangime;
					
	}
}
