package org.aspcfs.modules.mu.operazioni.base;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		MacellazioneLiberoConsumo lbc = new MacellazioneLiberoConsumo();
		lbc.setIdCapo(1);
		
		lbc.getDettaglioMacellazioneByIdCapo(1, null);
		
		try {
		//	lbc.store(null, null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
