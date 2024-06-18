package it.us.web.util.vam;

import java.util.ArrayList;

import it.us.web.bean.vam.CartellaClinica;
import it.us.web.bean.vam.MagazzinoFarmaci;
import it.us.web.dao.hibernate.Persistence;

public class MagazzinoFarmaciUtil {
	
	public static MagazzinoFarmaci checkFarmaco (Persistence persistence, int idClinica, int idFarmaco, int idTipoFarmaco) {
		
		MagazzinoFarmaci mf = null ;
		
		//Recupero fper capire se quella clinica possiade già quel farmaco di quel tipo
		ArrayList<MagazzinoFarmaci> mfList = (ArrayList<MagazzinoFarmaci>) 
			persistence.getNamedQuery("CheckFarmacoInClinica")
			.setInteger("idClinica", idClinica)
			.setInteger("idFarmaco", idFarmaco)
			.setInteger("idTipoFarmaco", idTipoFarmaco)
			.list();
		
		if (mfList.size() > 0) {
			mf = (MagazzinoFarmaci) mfList.get(0);
		}
		
		return mf;
					
	}
}
