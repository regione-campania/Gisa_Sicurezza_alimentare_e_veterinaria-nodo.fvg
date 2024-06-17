package org.aspcfs.modules.macellazionisintesis.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.aspcfs.modules.sintesis.base.SintesisStabilimento;



//AGGIUSTAMENTI:

//SPECIE: "BOVINO" CONVERTITO A 1; "BUFALINO" CONVERTITO A 5
//SESSO: "M" CONVERTITO A TRUE, "F" CONVERTITO A FALSE
//VINCOLO SANITARIO: "S" CONVERTITO A TRUE, "N" CONVERTITO A FALSE
// BSE: "S" CONVERTITO A 1, "N" CONVERTITO A -1
//DATE: CONVERTITE DA YYYY/MM/DD A DD/MM/YYYY
// SALTO LA PRIMA RIGA (INTESTAZIONE)

public class CapoImport2test {
//CONTROLLO DOCUMENTALE
private int idImport = -1;	
private int numeroRiga = -1;
private int id_macello = -1;
private String stato_macellazione = "Incompleto: Inseriti solo i dati sul controllo documentale";
private int progressivo_macellazione;
private String cd_codice_azienda_provenienza;
private String cd_codice_azienda;
private String cd_matricola;
private int cd_specie = -1;
private String cd_categoria;
private int cd_razza;
private String cd_maschio;
private String cd_data_nascita;
private int cd_categoria_rischio = -1;
private String cd_vincolo_sanitario;
private int cd_qualifica_sanitaria_tbc;
private int cd_qualifica_sanitaria_brc;
private String cd_mod4;
private String cd_data_mod4;
private int cd_macell_differita_piani_risanamento;
private String cd_test_bse;
private int cd_info_bse;
private String bse_data_prelievo;
private String bse_data_ricezione;
private int bse_esito;
private String bse_note;
private String cd_disponibili_informazioni_cat_alim;
private String cd_data_arrivo_macello;
private String cd_data_dichiarata_dal_ges;
private String cd_mezzo_di_trasporto_tipo;
private String cd_mezzo_di_trasporto_targa;
private String cd_trasporto_superiore_8_ore;
private String cd_veterinario ="";

private String cd_note="";

//MORTE ANTE MACELLAZIONE
private String mam_data=null;
private int mam_luogo_di_verifica=-1;
private String mam_causa;
private String mam_impianto_termodistruzione;
private String mam_destinazione_carcassa;
private int mam_comunicazione_a;
private String mam_note;
//VISITA ANTE MORTEM
private String vam_data;
private int vam_esito;
private int vam_provvedimento_adottato;
private int vam_comunicazione_a;
private String vam_note;
//VISITA POST MORTEM
private int vpm_tipo_macellazione;
private String vpm_progressivo_macellazione;
private int vpm_esito = -1;
private String vpm_patologie_rilevate_1;


private String vpm_organi_1;




private String vpm_causa_presunta_accertata;
private String vpm_veterinario ="";

private String vpm_destinatario_carni;
//CAMPIONE 1
private int c1_motivo;
private int c1_matrice;
private int c1_tipo_analisi;
private int c1_molecole_agente_etiologico;
private String c1_molecole_agente_etiologico_altro;
private int c1_esito;
private String c1_data_ricezione_esito;
//CAMPIONE 2
private int c2_motivo;
private int c2_matrice;
private int c2_tipo_analisi;
private int c2_molecole_agente_etiologico;
private String c2_molecole_agente_etiologico_altro;
private int c2_esito;
private String c2_data_ricezione_esito;
//CAMPIONE 3
private int c3_motivo;
private int c3_matrice;
private int c3_tipo_analisi;
private int c3_molecole_agente_etiologico;
private String c3_molecole_agente_etiologico_altro;
private int c3_esito;
private String c3_data_ricezione_esito;
//CAMPIONE 4
private int c4_motivo;
private int c4_matrice;
private int c4_tipo_analisi;
private int c4_molecole_agente_etiologico;
private String c4_molecole_agente_etiologico_altro;
private int c4_esito;
private String c4_data_ricezione_esito;
//CAMPIONE 5
private int c5_motivo;
private int c5_matrice;
private int c5_tipo_analisi;
private int c5_molecole_agente_etiologico;
private String c5_molecole_agente_etiologico_altro;
private int c5_esito;
private String c5_data_ricezione_esito;
//TAMPONE
private String tmp_eseguito;
private int tmp_tipo_analisi;
private String tmp_metodo_distruttivo;

private boolean importabile = true;
private String erroreImport = "";

private String vpm_data=null;
private int cd_seduta_macellazione = 0;

private boolean falso_errore=false;

private int id = -1;
private boolean controllodbi=true;

public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}

public int getVpm_esito() {
	return vpm_esito;
}
public void setVpm_esito(int vpm_esito) {
	this.vpm_esito = vpm_esito;
}

public int getId_macello() {
	return id_macello;
}
public void setId_macello(int id_macello) {
	this.id_macello = id_macello;
}
public void setId_macello(String id_macello) {
	try{ this.id_macello = Integer.parseInt(id_macello);}
	catch(Exception e){
		this.id_macello = -1;
	} 
}
public String getStato_macellazione() {
	return stato_macellazione;
}
public void setStato_macellazione(String stato_macellazione) {
	this.stato_macellazione = stato_macellazione.trim();
}
public int getProgressivo_macellazione() {
	return progressivo_macellazione;
}
public void setProgressivo_macellazione(int progressivo_macellazione) {
	this.progressivo_macellazione = progressivo_macellazione;
}
public void setProgressivo_macellazione(String progressivo_macellazione) {
	try{ this.progressivo_macellazione = Integer.parseInt(progressivo_macellazione.trim());}
	catch(Exception e){
		this.progressivo_macellazione = -1;
	} 
}

public int getVam_esito() {
	return vam_esito;
}
public void setVam_esito(int vam_esito) {
	this.vam_esito = vam_esito;
}
public String getCd_codice_azienda() {
	return cd_codice_azienda;
}
public void setCd_codice_azienda(String cd_codice_azienda) {
	this.cd_codice_azienda = cd_codice_azienda;
}
public String getCd_codice_azienda_provenienza() {
	return cd_codice_azienda_provenienza;
}
public void setCd_codice_azienda_provenienza(String cd_codice_azienda_provenienza) {
	this.cd_codice_azienda_provenienza = cd_codice_azienda_provenienza.trim();
}
public String getCd_matricola() {
	return cd_matricola;
}
public void setCd_matricola(String cd_matricola) {
	this.cd_matricola = cd_matricola.trim();
}
public int getCd_specie() {
	return cd_specie;
}
public void setCd_specie(int cd_specie) {
	this.cd_specie = cd_specie;
}




//DECODIFICHE



public void setCd_specie(String cd_specie) {
	try{
		this.cd_specie = Integer.parseInt(cd_specie.trim());
		}
		catch(Exception e){
		this.cd_specie = -1;
		}
}

public void setCd_maschio(String cd_maschio) {
this.cd_maschio = cd_maschio.trim();
}



public void setCd_data_dichiarata_dal_ges(String cd_data_dichiarata_dal_ges) {
	
	this.cd_data_dichiarata_dal_ges = cd_data_dichiarata_dal_ges.trim();
	}
public void setCd_categoria_rischio(String cd_categoria_rischio) {
	try{ this.cd_categoria_rischio = Integer.parseInt(cd_categoria_rischio.trim());}
	catch(Exception e){
		this.cd_categoria_rischio = -1;
	} 
	}


public void setCd_vincolo_sanitario(String cd_vincolo_sanitario) {
	this.cd_vincolo_sanitario = cd_vincolo_sanitario.trim();
	switch(cd_vincolo_sanitario){
		case "BRC":
			this.cd_vincolo_sanitario="1";
		break;
		case "TBC":
			this.cd_vincolo_sanitario="2";
		break;
		case "LEB":
			this.cd_vincolo_sanitario="3";
		break;
	}
}

public void setCd_qualifica_sanitaria_tbc(String cd_qualifica_sanitaria_tbc) {
	try{ this.cd_qualifica_sanitaria_tbc = Integer.parseInt(cd_qualifica_sanitaria_tbc.trim());}
	catch(Exception e){this.cd_qualifica_sanitaria_tbc=-1;}
}

public void setCd_qualifica_sanitaria_brc(String cd_qualifica_sanitaria_brc) {
	try{ this.cd_qualifica_sanitaria_brc = Integer.parseInt(cd_qualifica_sanitaria_brc.trim());}
	catch(Exception e){this.cd_qualifica_sanitaria_brc = -1;}
}

public void setCd_macell_differita_piani_risanamento(String cd_macell_differita_piani_risanamento) {
	try{ this.cd_macell_differita_piani_risanamento = Integer.parseInt(cd_macell_differita_piani_risanamento.trim());}
	catch(Exception e){this.cd_macell_differita_piani_risanamento=-1;}
}



public void setCd_info_bse(String cd_info_bse) {
	try{ this.cd_info_bse = Integer.parseInt(cd_info_bse.trim());}
	catch(Exception e){this.cd_info_bse =-1;}
}




public void setCd_categoria(String cd_categoria) {
	this.cd_categoria = cd_categoria.trim();
	
	
}

public void setBse_esito(String bse_esito) {
	try{ this.bse_esito = Integer.parseInt(bse_esito.trim());}
	catch(Exception e){this.bse_esito=-1;} 
	}

public void setMam_luogo_di_verifica(String mam_luogo_di_verifica) {
	try{ this.mam_luogo_di_verifica = Integer.parseInt(mam_luogo_di_verifica.trim());}
	catch(Exception e){this.mam_luogo_di_verifica =-1;}
	
}

public void setMam_comunicazione_a(String mam_comunicazione_a) {
	try{ this.mam_comunicazione_a = Integer.parseInt(mam_comunicazione_a.trim());}
	catch(Exception e){this.mam_comunicazione_a =-1;} 
}



public void setVpm_tipo_macellazione(String vpm_tipo_macellazione) {
	try{ this.vpm_tipo_macellazione = Integer.parseInt(vpm_tipo_macellazione.trim());}
	catch(Exception e){this.vpm_tipo_macellazione =-1;} 
	
}

public void setVpm_esito(String vpm_esito) {
	
	try{ this.vpm_esito = Integer.parseInt(vpm_esito.trim());}
	catch(Exception e){this.vpm_esito =-1;} 
}







 //FINE DECODIFICHE 




public String getCd_maschio() {
	return cd_maschio;
}


public String getCd_data_nascita() {
	return cd_data_nascita;
}
public void setCd_data_nascita(String cd_data_nascita) {
	this.cd_data_nascita = cd_data_nascita.trim();
}


	
public int getCd_categoria_rischio() {
	return cd_categoria_rischio;
}
public void setCd_categoria_rischio(int cd_categoria_rischio) {
	this.cd_categoria_rischio = cd_categoria_rischio;
}


/*
public boolean isCd_vincolo_sanitario() {
	return cd_vincolo_sanitario;
}
public void setCd_vincolo_sanitario(boolean cd_vincolo_sanitario) {
	this.cd_vincolo_sanitario = cd_vincolo_sanitario;
}
public void setCd_vincolo_sanitario(String cd_vincolo_sanitario) {
	try {
		this.cd_vincolo_sanitario = Boolean.valueOf(cd_vincolo_sanitario);
	} catch (Exception e) {} 
}
public String getCd_vincolo_sanitario_motivo() {
	return cd_vincolo_sanitario_motivo;
}
public void setCd_vincolo_sanitario_motivo(String cd_vincolo_sanitario_motivo) {
	this.cd_vincolo_sanitario_motivo = cd_vincolo_sanitario_motivo;
}

*/
public String getCd_data_mod4() {
	return cd_data_mod4;
}
public void setCd_data_mod4(String cd_data_mod4) {
	this.cd_data_mod4 = cd_data_mod4.trim();
}

public String getCd_data_arrivo_macello() {
	return cd_data_arrivo_macello;
}
public void setCd_data_arrivo_macello(String cd_data_arrivo_macello) {
	this.cd_data_arrivo_macello = cd_data_arrivo_macello.trim();
}

/*
public int getCd_bse() {
	return cd_bse;
}
public void setCd_bse(int cd_bse) {
	this.cd_bse = cd_bse;
} 
public void setCd_bse(String cd_bse) {
	if ("S".equals(cd_bse))
		this.cd_bse = 1;
	else if ("N".equals(cd_bse))
		this.cd_bse = -1;
}
*/
public String getBse_data_prelievo() {
	return bse_data_prelievo;
}

public void setBse_data_prelievo(String bse_data_prelievo) {
	this.bse_data_prelievo = bse_data_prelievo.trim();
}	


/**
 * @return the bse_esito
 */
public int getBse_esito() {
	return bse_esito;
}
/**
 * @param bse_esito the bse_esito to set
 */
public void setBse_esito(int bse_esito) {
	this.bse_esito = bse_esito;
}
public CapoImport2test(){
	
}

public CapoImport2test(String[] valori){

	System.out.println(valori[0]);
	setCd_codice_azienda_provenienza(valori[0]);
	setCd_codice_azienda(valori[1]);
	System.out.println(valori[2]);
	setCd_matricola(valori[2]);
	setCd_specie(valori[3]);
	System.out.println("SPECIE=");

	System.out.println(valori[3]);
	System.out.println(cd_specie);


	setCd_categoria(valori[4]);
	setCd_razza(valori[5]);
	System.out.println(valori[6]);

	setCd_maschio(valori[6]);
	setCd_data_nascita(valori[7]);
	setCd_categoria_rischio(valori[8]);
	setCd_vincolo_sanitario(valori[9]);
	setCd_qualifica_sanitaria_tbc(valori[10]);
	setCd_qualifica_sanitaria_brc(valori[11]);
	System.out.println("MOD4");

	System.out.println(valori[12]);

	setCd_mod4(valori[12]);
	System.out.println("MOD4 G");
	System.out.println(getCd_mod4());

	setCd_data_mod4(valori[13]);
	setCd_macell_differita_piani_risanamento(valori[14]);
	setCd_test_bse(valori[15]);
	setCd_info_bse(valori[16]);
	setBse_data_prelievo(valori[17]);
	setBse_data_ricezione(valori[18]);
	setBse_esito(valori[19]);
	setBse_note(valori[20]);
	setCd_disponibili_informazioni_cat_alim(valori[21]);
	setCd_data_arrivo_macello(valori[22]);
	setCd_data_dichiarata_dal_ges(valori[23]);
	setCd_mezzo_di_trasporto_tipo(valori[24]);
	setCd_mezzo_di_trasporto_targa(valori[25]);
	setCd_trasporto_superiore_8_ore(valori[26]);
	setCd_veterinario(valori[27]);

	setAltriVeterinari(valori[27]);
	System.out.println(valori[27]);

	System.out.println(valori[28]);

	setCd_note(valori[28]);
	
	//MAM
	
	setMam_data(valori[29]);
	setMam_luogo_di_verifica(valori[30]);
	setMam_causa(valori[31]);
	setMam_impianto_termodistruzione(valori[32]);
	setMam_destinazione_carcassa(valori[33]);
	setMam_comunicazione_a(valori[34]);
	setMam_note(valori[35]);
	
	//VAM
	
	setVam_data(valori[36]);
	setVam_esito(valori[37]);
	setVam_provvedimento_adottato(valori[38]);
	setVam_comunicazione_a(valori[39]);
	setVam_note(valori[40]);
	
	//VPM
	setVpm_tipo_macellazione(valori[41]);
	setProgressivo_macellazione(valori[42]);
	setVpm_esito(valori[43]);
	
	setVpm_patologie_rilevate_1(valori[44]);

	setAltrePatologie(valori[44]);
	
	setVpm_organi_1(valori[45]);
	setAltriOrgani(valori[45]);
	
	
	setVpm_causa_presunta_accertata(valori[46]);
	setVpm_veterinario(valori[47]);

	setAltriVeterinariVpm(valori[47]);
	setVpm_destinatario_carni(valori[48]);
	//CAMPIONI 1
	setC1_motivo(valori[49]);
	setC1_matrice(valori[50]);
	setC1_tipo_analisi(valori[51]);
	setC1_molecole_agente_etiologico(valori[52]);
	setC1_molecole_agente_etiologico_altro(valori[53]);
	setC1_esito(valori[54]);
	setC1_data_ricezione_esito(valori[55]);
	
	setC2_motivo(valori[56]);
	setC2_matrice(valori[57]);
	setC2_tipo_analisi(valori[58]);
	setC2_molecole_agente_etiologico(valori[59]);
	setC2_molecole_agente_etiologico_altro(valori[60]);
	setC2_esito(valori[61]);
	setC2_data_ricezione_esito(valori[62]);
	
	setC3_motivo(valori[63]);
	setC3_matrice(valori[64]);
	setC3_tipo_analisi(valori[65]);
	setC3_molecole_agente_etiologico(valori[66]);
	setC3_molecole_agente_etiologico_altro(valori[67]);
	setC3_esito(valori[68]);
	setC3_data_ricezione_esito(valori[69]);
	
	setC4_motivo(valori[70]);
	setC4_matrice(valori[71]);
	setC4_tipo_analisi(valori[72]);
	setC4_molecole_agente_etiologico(valori[73]);
	setC4_molecole_agente_etiologico_altro(valori[74]);
	setC4_esito(valori[75]);
	setC4_data_ricezione_esito(valori[76]);
	
	setC5_motivo(valori[77]);
	setC5_matrice(valori[78]);
	setC5_tipo_analisi(valori[79]);
	setC5_molecole_agente_etiologico(valori[80]);
	setC5_molecole_agente_etiologico_altro(valori[81]);
	setC5_esito(valori[82]);
	setC5_data_ricezione_esito(valori[83]);
	
	setTmp_eseguito(valori[84]);
	setTmp_tipo_analisi(valori[85]);
	setTmp_metodo_distruttivo(valori[86]);
	}


private void setVpm_patologie_rilevate_1(String patologie) {
	this.vpm_patologie_rilevate_1 = patologie.trim();
}
public void setC1_esito(String c1_esito){
	try {
		this.c1_esito = Integer.parseInt(c1_esito.trim());
		}
	catch (Exception e){this.c1_esito =-1;}
}
public void setC2_esito(String c2_esito){
	try {
		this.c2_esito = Integer.parseInt(c2_esito.trim());
		}
	catch (Exception e){this.c2_esito =-1;}
}
public void setC3_esito(String c3_esito){
	try {
		this.c3_esito = Integer.parseInt(c3_esito.trim());
		}
	catch (Exception e){this.c3_esito =-1;}
}
public void setC4_esito(String c4_esito){
	try {
		this.c4_esito = Integer.parseInt(c4_esito.trim());
		}
	catch (Exception e){this.c4_esito =-1;}
}
public void setC5_esito(String c5_esito){
	try {
		this.c5_esito = Integer.parseInt(c5_esito.trim());
		}
	catch (Exception e){this.c5_esito =-1;}
}
public void setCd_razza(String cd_razza) {
	try {
		this.cd_razza = Integer.parseInt(cd_razza.trim());
		}
	catch (Exception e){this.cd_razza =-1;}
	
}
public void setTmp_metodo_distruttivo(String tmp_metodo_distruttivo) {
	
		this.tmp_metodo_distruttivo=tmp_metodo_distruttivo.trim();
}
public void setTmp_tipo_analisi(String tmp_tipo_analisi) {
	try {
		this.tmp_tipo_analisi = Integer.parseInt(tmp_tipo_analisi.trim());
		}
	catch (Exception e){this.tmp_tipo_analisi =-1;}
	
}
public void setTmp_eseguito(String tmp_eseguito) {

		this.tmp_eseguito= tmp_eseguito.trim();
}

public void setC1_tipo_analisi(String c1_tipo_analisi) {
	try {
		this.c1_tipo_analisi = Integer.parseInt(c1_tipo_analisi.trim());
		}
	catch (Exception e){this.c1_tipo_analisi =-1;}
	
}
public void setC1_molecole_agente_etiologico(String c1_molecole_agente_etiologico) {
	try {
		this.c1_molecole_agente_etiologico = Integer.parseInt(c1_molecole_agente_etiologico.trim());
		}
	catch (Exception e){this.c1_molecole_agente_etiologico =-1;}
	
}
	

public void setC1_matrice(String c1_matrice) {
	try {
		this.c1_matrice = Integer.parseInt(c1_matrice.trim());
		}
	catch (Exception e){this.c1_matrice =-1;}
	
}
public void setC1_motivo(String c1_motivo) {
	try {
		this.c1_motivo = Integer.parseInt(c1_motivo.trim());
		}
	catch (Exception e){this.c1_motivo =-1;}
	
}


public void setC2_tipo_analisi(String c2_tipo_analisi) {
	try {
		this.c2_tipo_analisi = Integer.parseInt(c2_tipo_analisi.trim());
		}
	catch (Exception e){this.c2_tipo_analisi =-1;}
	
}
public void setC2_molecole_agente_etiologico(String c2_molecole_agente_etiologico) {
	try {
		this.c2_molecole_agente_etiologico = Integer.parseInt(c2_molecole_agente_etiologico.trim());
		}
	catch (Exception e){this.c2_molecole_agente_etiologico =-1;}
	
}

	

public void setC2_matrice(String c2_matrice) {
	try {
		this.c2_matrice = Integer.parseInt(c2_matrice.trim());
		}
	catch (Exception e){this.c2_matrice =-1;}
	
}
public void setC2_motivo(String c2_motivo) {
	try {
		this.c2_motivo = Integer.parseInt(c2_motivo.trim());
		}
	catch (Exception e){this.c2_motivo =-1;}
	
}




public void setC3_tipo_analisi(String c3_tipo_analisi) {
	try {
		this.c3_tipo_analisi = Integer.parseInt(c3_tipo_analisi.trim());
		}
	catch (Exception e){this.c3_tipo_analisi =-1;}
	
}
public void setC3_molecole_agente_etiologico(String c3_molecole_agente_etiologico) {
	try {
		this.c3_molecole_agente_etiologico = Integer.parseInt(c3_molecole_agente_etiologico.trim());
		}
	catch (Exception e){this.c3_molecole_agente_etiologico =-1;}
	
}
	

public void setC3_matrice(String c3_matrice) {
	try {
		this.c3_matrice = Integer.parseInt(c3_matrice.trim());
		}
	catch (Exception e){this.c3_matrice =-1;}
	
}
public void setC3_motivo(String c3_motivo) {
	try {
		this.c3_motivo = Integer.parseInt(c3_motivo.trim());
		}
	catch (Exception e){this.c3_motivo =-1;}
}




public void setC4_tipo_analisi(String c4_tipo_analisi) {
	try {
		this.c4_tipo_analisi = Integer.parseInt(c4_tipo_analisi.trim());
		}
	catch (Exception e){this.c4_tipo_analisi =-1;}
	
}
public void setC4_molecole_agente_etiologico(String c4_molecole_agente_etiologico) {
	try {
		this.c4_molecole_agente_etiologico = Integer.parseInt(c4_molecole_agente_etiologico.trim());
		}
	catch (Exception e){this.c4_molecole_agente_etiologico =-1;}
	
}
	

public void setC4_matrice(String c4_matrice) {
	try {
		this.c4_matrice = Integer.parseInt(c4_matrice.trim());
		}
	catch (Exception e){this.c4_matrice =-1;}
	
}
public void setC4_motivo(String c4_motivo) {
	try {
		this.c4_motivo = Integer.parseInt(c4_motivo.trim());
		}
	catch (Exception e){this.c4_motivo =-1;}
}



public void setC5_tipo_analisi(String c5_tipo_analisi) {
	try {
		this.c5_tipo_analisi = Integer.parseInt(c5_tipo_analisi.trim());
		}
	catch (Exception e){this.c5_tipo_analisi =-1;}
	
}
public void setC5_molecole_agente_etiologico(String c5_molecole_agente_etiologico) {
	try {
		this.c5_molecole_agente_etiologico = Integer.parseInt(c5_molecole_agente_etiologico.trim());
		}
	catch (Exception e){this.c5_molecole_agente_etiologico =-1;}
	
}
	

public void setC5_matrice(String c5_matrice) {
	try {
		this.c5_matrice = Integer.parseInt(c5_matrice.trim());
		}
	catch (Exception e){this.c5_matrice = -1;}
	
}
public void setC5_motivo(String c5_motivo) {
	try {
		this.c5_motivo = Integer.parseInt(c5_motivo.trim());
		}
	catch (Exception e){this.c5_motivo =-1;}
}





public void setVam_esito(String vam_esito) {
	try {
		this.vam_esito = Integer.parseInt(vam_esito.trim());
		}
	catch (Exception e){this.vam_esito =-1;}
	
}
public void setVam_comunicazione_a(String vam_comunicazione_a) {
	try {
		this.vam_comunicazione_a = Integer.parseInt(vam_comunicazione_a.trim());
		}
	catch (Exception e){this.vam_comunicazione_a =-1;}
	
}
public void setVam_provvedimento_adottato(String vam_provvedimento_adottato) {
	try {
		this.vam_provvedimento_adottato = Integer.parseInt(vam_provvedimento_adottato.trim());
		}
	catch (Exception e){this.vam_provvedimento_adottato =-1;}
	
}








public void setCd_disponibili_informazioni_cat_alim(String cd_disponibili_informazioni_cat_alim) {

		this.cd_disponibili_informazioni_cat_alim = cd_disponibili_informazioni_cat_alim.trim() ;
}
public void setCd_trasporto_superiore_8_ore(String cd_trasporto_superiore_8_ore) {
	
		this.cd_trasporto_superiore_8_ore = cd_trasporto_superiore_8_ore.trim();
}

public String getVpm_data() {
	return vpm_data;
}
public void setVpm_data(String vpm_data) {
	this.vpm_data = vpm_data.trim();
}




/*
public String getVpm_dataString() {
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yy");
	Date date = vpm_data;
	String time = sdf.format(date);
	return time;
	
}*/
public int getCd_seduta_macellazione() {
	return cd_seduta_macellazione;
}
public void setCd_seduta_macellazione(int cd_seduta_macellazione) {
	this.cd_seduta_macellazione = cd_seduta_macellazione;
}
public void setCd_seduta_macellazione(String cd_seduta_macellazione) {
	try {
		this.cd_seduta_macellazione = Integer.parseInt(cd_seduta_macellazione);
		}
	catch (Exception e){}
	
}
public void insert(Connection db) throws SQLException{

	StringBuffer sql = new StringBuffer();
	
	sql.append("INSERT INTO import_capi_macello("
			+ "__codice_azienda_di_provenienza ,__codice_azienda_di_nascita ,__matricola ,__specie ,__categoria ,"
			+ "__razza ,__sesso ,__data_di_nascita ,__categoria_di_rischio_msr ,__vincolo_sanitario ,"
			+ "__qualifica_sanitaria_tbc ,__qualifica_sanitaria_brc ,__mod_4 ,__data_mod_4 ,__macell_differita_piani_risanamento ,"
			+ "__test_bse ,__informazioni_test_bse ,__data_prelievo_test_bse ,__data_ricezione_esito_test_bse ,__esito_test_bse ,"
			+ "__note_test_bse ,__disponibili_informazioni_catena_alimentare ,__data_arrivo_al_macello ,__data_dichiararata_dal_gestore ,__mezzo_di_trasporto_tipo ,"
			+ "__mezzo_di_trasporto_targa ,__trasporto_superiore_a_8_ore ,__veterinari_addetti_cd ,__note_cd ,__data_mam ,"
			+ "__luogo_di_verifica ,__causa ,__impianto_di_termodistruzione ,__destinazione_della_carcassa ,__comunicazione_a_mam ,"
			+ "__note_mam ,__data_vam ,__esito ,__provvedimento_adottato ,__comunicazione_a_vam ,"
			+ "__note_vam ,__tipo_macellazione ,__progressivo_macellazione,__esito_vpm ,__patologie_rilevate ,"
			+ "__organi ,__causa_presunta_o_accertata ,__veterinari_addetti_vpm ,__destinatario_carni ,__motivo_c_1 ,"
			+ "__matrice_c_1 ,__tipo_analisi_c_1 ,__molecole_agente_etiologico_c_1 ,__molecole_agente_etiologico_altro_c_1 ,__esito_c_1 ,"
			+ "__data_ricezione_esito_c_1 ,__motivo_c_2 ,__matrice_c_2 ,__tipo_analisi_c_2 ,__molecole_agente_etiologico_c_2 ,"
			+ "__molecole_agente_etiologico_altro_c_2 ,__esito_c_2 ,__data_ricezione_esito_c_2 ,__motivo_c_3 ,__matrice_c_3 ,"
			+ "__tipo_analisi_c_3 ,__molecole_agente_etiologico_c_3 ,__molecole_agente_etiologico_altro_c_3 ,__esito_c_3 ,__data_ricezione_esito_c_3 ,"
			+ "__motivo_c_4 ,__matrice_c_4 ,__tipo_analisi_c_4 ,__molecole_agente_etiologico_c_4 ,__molecole_agente_etiologico_altro_c_4 ,"
			+ "__esito_c_4 ,__data_ricezione_esito_c_4 ,__motivo_c_5 ,__matrice_c_5 ,__tipo_analisi_c_5 ,"
			+ "__molecole_agente_etiologico_c_5 ,__molecole_agente_etiologico_altro_c_5,__esito_c_5,__data_ricezione_esito_c_5 ,__eseguito_t ,"
			+ "__tipo_analisi_t ,__metodo_distruttivo_t,__id_macello,__destinatario_1_id,__data_sessione,__cd_seduta_macellazione,id_import "
			+ ") values ("
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+ "?, ?, ?, ?, ?, "
			+"?,?"
			+ "); ");
	int i = 0;
	PreparedStatement pst = db.prepareStatement(sql.toString());
	pst.setString(++i, this.getCd_codice_azienda_provenienza());
	pst.setString(++i, this.getCd_codice_azienda());
	pst.setString(++i, this.getCd_matricola());
	pst.setInt(++i, this.getCd_specie());
	pst.setString(++i, this.getCd_categoria());
	pst.setInt(++i, this.getCd_razza());
	pst.setString(++i, this.getCd_maschio());
	System.out.println("SESSO: "+this.getCd_maschio());
	pst.setString(++i, this.getCd_data_nascita());
	pst.setInt(++i, this.getCd_categoria_rischio());
	pst.setString(++i, this.getCd_vincolo_sanitario());
	pst.setInt(++i, this.getCd_qualifica_sanitaria_tbc());
	pst.setInt(++i, this.getCd_qualifica_sanitaria_brc());
	pst.setString(++i, this.getCd_mod4());
	pst.setString(++i, this.getCd_data_mod4());
	pst.setInt(++i, this.getCd_macell_differita_piani_risanamento());
	pst.setString(++i, this.getCd_test_bse());
	pst.setInt(++i, this.getCd_info_bse());
	pst.setString(++i, this.getBse_data_prelievo());
	pst.setString(++i, this.getBse_data_ricezione());
	pst.setInt(++i, this.getBse_esito());
	pst.setString(++i, this.getBse_note());
	pst.setString(++i, this.getCd_disponibili_informazioni_cat_alim());
	pst.setString(++i, this.getCd_data_arrivo_macello());
	pst.setString(++i, this.getCd_data_dichiarata_dal_ges());
	pst.setString(++i, this.getCd_mezzo_di_trasporto_tipo());
	pst.setString(++i, this.getCd_mezzo_di_trasporto_targa());
	pst.setString(++i, this.getCd_trasporto_superiore_8_ore());
	pst.setString(++i, this.getCd_veterinario());
	pst.setString(++i, this.getCd_note());
	pst.setString(++i, this.getMam_data());
	pst.setInt(++i, this.getMam_luogo_di_verifica());
	pst.setString(++i, this.getMam_causa());
	pst.setString(++i, this.getMam_impianto_termodistruzione());
	pst.setString(++i, this.getMam_destinazione_carcassa());
	pst.setInt(++i, this.getMam_comunicazione_a());
	pst.setString(++i, this.getMam_note());
	
	pst.setString(++i, this.getVam_data());
	pst.setInt(++i, this.getVam_esito());
	pst.setInt(++i, this.getVam_provvedimento_adottato());
	pst.setInt(++i, this.getVam_comunicazione_a());
	pst.setString(++i, this.getVam_note());


	
	pst.setInt(++i, this.getVpm_tipo_macellazione());
	pst.setInt(++i, this.getProgressivo_macellazione());
	pst.setInt(++i, this.getVpm_esito());
	pst.setString(++i, this.getVpm_patologie_rilevate());
	pst.setString(++i, this.getVpm_organi_1());
	pst.setString(++i, this.getVpm_causa_presunta_accertata());
	pst.setString(++i, this.getVpm_veterinario());
	pst.setString(++i, this.getVpm_destinatario_carni());
	pst.setInt(++i, this.getC1_motivo());
	pst.setInt(++i, this.getC1_matrice());
	pst.setInt(++i, this.getC1_tipo_analisi());
	pst.setInt(++i, this.getC1_molecole_agente_etiologico());
	pst.setString(++i, this.getC1_molecole_agente_etiologico_altro());
	pst.setInt(++i, this.getC1_esito());
	pst.setString(++i, this.getC1_data_ricezione_esito());
	pst.setInt(++i, this.getC2_motivo());
	pst.setInt(++i, this.getC2_matrice());
	pst.setInt(++i, this.getC2_tipo_analisi());
	pst.setInt(++i, this.getC2_molecole_agente_etiologico());
	pst.setString(++i, this.getC2_molecole_agente_etiologico_altro());
	pst.setInt(++i, this.getC2_esito());
	pst.setString(++i, this.getC2_data_ricezione_esito());
	pst.setInt(++i, this.getC3_motivo());
	pst.setInt(++i, this.getC3_matrice());
	pst.setInt(++i, this.getC3_tipo_analisi());
	pst.setInt(++i, this.getC3_molecole_agente_etiologico());
	pst.setString(++i, this.getC3_molecole_agente_etiologico_altro());
	pst.setInt(++i, this.getC3_esito());
	pst.setString(++i, this.getC3_data_ricezione_esito());
	pst.setInt(++i, this.getC4_motivo());
	pst.setInt(++i, this.getC4_matrice());
	pst.setInt(++i, this.getC4_tipo_analisi());
	pst.setInt(++i, this.getC4_molecole_agente_etiologico());
	pst.setString(++i, this.getC4_molecole_agente_etiologico_altro());
	pst.setInt(++i, this.getC4_esito());
	pst.setString(++i, this.getC4_data_ricezione_esito());
	pst.setInt(++i, this.getC5_motivo());
	pst.setInt(++i, this.getC5_matrice());
	pst.setInt(++i, this.getC5_tipo_analisi());
	pst.setInt(++i, this.getC5_molecole_agente_etiologico());
	pst.setString(++i, this.getC5_molecole_agente_etiologico_altro());
	pst.setInt(++i, this.getC5_esito());
	pst.setString(++i, this.getC5_data_ricezione_esito());
	pst.setString(++i, this.getTmp_eseguito());
	pst.setInt(++i, this.getTmp_tipo_analisi());
	pst.setString(++i, this.getTmp_metodo_distruttivo());
	pst.setInt(++i, this.getId_macello());
	pst.setInt(++i, this.getId_macello());
	pst.setString(++i, this.getVpm_data());
	pst.setInt(++i, this.getCd_seduta_macellazione());
	pst.setInt(++i, this.getIdImport());




	System.out.println("slq1="+ sql);

	pst.execute();
	sql.delete(0, sql.length());
	pst.close();
	System.out.println("sql2="+sql);
 }

public boolean insertdbi (Connection db){
	boolean inserito = true;

	StringBuffer sql = new StringBuffer();
	sql.append("select * from import_capi_macello where __matricola = ? and __data_import is null ORDER BY id DESC LIMIT 1");
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
	pst.setString(1, this.getCd_matricola() );
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		int id_prova=rs.getInt("id");
		System.out.println("ID PROVA"+id_prova);
		
		StringBuffer sql2 = new StringBuffer();
		sql2.append("select * from import_capo_macello(?)");
		PreparedStatement pst2;
			pst2 = db.prepareStatement(sql2.toString());
		pst2.setInt(1, id_prova );
		System.out.println("PST2"+pst2);

		ResultSet rs2 = pst2.executeQuery();

		rs2.next();
		System.out.println("RS222"+rs2.getString("import_capo_macello"));

		
		
		
	}
	
	
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return inserito;
}	

public boolean insertdbiControl (Connection db){
	boolean inserito = true;

	StringBuffer sql = new StringBuffer();
	sql.append("select * from import_capi_macello where __matricola = ? and __data_import is null ORDER BY id DESC LIMIT 1");
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
	pst.setString(1, this.getCd_matricola() );
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		int id_prova=rs.getInt("id");
		System.out.println("ID PROVA"+id_prova);
		
		StringBuffer sql2 = new StringBuffer();
		sql2.append("select * from import_capo_macello_control(?)");
		PreparedStatement pst2;
			pst2 = db.prepareStatement(sql2.toString());
		pst2.setInt(1, id_prova );
		System.out.println("PST2"+pst2);

		ResultSet rs2 = pst2.executeQuery();

		rs2.next();
		System.out.println("RS222"+rs2.getString("import_capo_macello_control"));

		if (rs2.getString("import_capo_macello_control").contains("KO") && !rs2.getString("import_capo_macello_control").contains("matri_dupl")){
			if (rs2.getString("import_capo_macello_control").contains("dataMac"))
						setErroreImport("Errore, data arrivo al macello non coerente con data mod.4 o con data sessione");
			if (rs2.getString("import_capo_macello_control").contains("datamod"))
				setErroreImport("Errore, data mod non puo' essere seguente alla data sessione");
			if (rs2.getString("import_capo_macello_control").contains("cdVet"))
				setErroreImport("Errore, Veterinario Controllo Documentale non presente o non autorizzato");
			if (rs2.getString("import_capo_macello_control").contains("vpmVet"))
				setErroreImport("Errore, Veterinario Visita Post Mortem non presente o non autorizzato");
			if (rs2.getString("import_capo_macello_control").contains("Sesso"))
				setErroreImport("Errore, Sesso mancante");
			if (rs2.getString("import_capo_macello_control").contains("data nascita"))
				setErroreImport("Errore, data di nascita seguente a data mod.4");
			if (rs2.getString("import_capo_macello_control").contains("mam_obb"))
				setErroreImport("Errore, Completare dati morte ante macellazione (data, luogo di verifica, causa");
			if (rs2.getString("import_capo_macello_control").contains("mam_vpm"))
			setErroreImport("Errore, morte ante macellazione e visita post mortem non possono essere valorizzati entrambi per lo stesso capo");
			if (rs2.getString("import_capo_macello_control").contains("specie_null"))
				setErroreImport("Errore, Non e' possibile importate la specie scelta nel modulo Bovini/bufalini/equidi");
			if (rs2.getString("import_capo_macello_control").contains("datavam_provv"))
				setErroreImport("Errore, Completare dati visita ante mortem (data, esito, provvedimento");
			if (rs2.getString("import_capo_macello_control").contains("progress"))
				setErroreImport("Errore, Progressivo macellazione mancante o gia' presente");
			
			this.importabile = false;
			inserito = false;
			
			System.out.println("RS2"+getErroreImport());
			return false;
		}else{
			if (rs2.getString("import_capo_macello_control").contains("NO")){
				String controlloValori = rs2.getString("import_capo_macello_control").substring(3);
				 setErroreImport("Errore, "+controlloValori+" non decodificato correttamente");
					inserito = false;
				System.out.println("RS2"+getErroreImport());
				return false;
			}else{
				if (rs2.getString("import_capo_macello_control").contains("matri_dupl")){
				
					setErroreImport("ATTENZIONE: CAPO IGNORATO, GIA' PRESENTE SUL SISTEMA.");
					setFalso_errore(true);
				}
					
			}

		
		}
		
	}
	
	
	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return true;
}	





public int logStato (Connection db){

	StringBuffer sql = new StringBuffer();
	sql.append("select * from m_capi where id_import=? and cd_matricola = ?");
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
	pst.setInt(1, this.getIdImport() );
	pst.setString(2, this.getCd_matricola() );
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		String stato_mac =rs.getString("stato_macellazione");
		System.out.println("STATO"+stato_mac);
		if(stato_mac.contains("Incompleto: Veterinario mancante") ){
		  return 1;
		  }else{
			  if(stato_mac.contains("OK-Non Macellato")) {
			  return 2;}
			  else{if (stato_mac.contains("OK.")){
				  return 3;
			  }
			  }
		  }
	}
	

	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return 4;
	}



/*
public boolean controllaUnivocitaProg (Connection db){
	boolean nonEsiste = true;
	StringBuffer sql = new StringBuffer();
	sql.append("select * from m_capi where trashed_date is null and progressivo_macellazione = ? and vpm_data = ? and cd_seduta_macellazione = ? and (progressivo_macellazione != 0 and progressivo_macellazione != '-1' ");
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
	pst.setString(1, this.getCd_matricola() );
	pst.setString(2, this.getVpm_data() );
	pst.setInt(3, this.getCd_seduta_macellazione() );

	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		nonEsiste=false;
		this.erroreImport = "Progressivo gia' presente in banca dati";
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return nonEsiste;
}
*/
public boolean controllaUnivocitaMatricolaNelFile (ArrayList<String> matricole){
	boolean nonEsiste = true;
	
	if (presentiMatricoleDuplicate(this.getCd_matricola(), matricole)){
		nonEsiste = false;
		this.erroreImport = "Matricola duplicata nel file.";
	}
	
	return nonEsiste;
}
/*
public boolean controllaUnivocitaProgNelFile (ArrayList<Integer> progressivi){
	boolean nonEsiste = true;
	
	if (presentiProgDuplicati(this.getProgressivo_macellazione(), progressivi)){
		nonEsiste = false;
		this.erroreImport = "Matricola duplicata nel file.";
	}
	
	return nonEsiste;
}
*/
public boolean controllaValiditaRiga (Connection db, ArrayList<String> matricole){
	
	boolean flagCampiObbligatori = true; 	//CI SONO TUTTI I CAMPI OBBLIGATORI?
	boolean flagUnivocitaMatricolaNelFile = true;	//LA MATRICOLA E' UNIVOCA NEL FILE?
	//boolean flagControllaUnivocitaProg = true;
	
	flagCampiObbligatori = controllaCampiObbligatori();
	
	if (flagCampiObbligatori){
		//flagControllaUnivocitaProg=  controllaUnivocitaProg(db);
			flagUnivocitaMatricolaNelFile = controllaUnivocitaMatricolaNelFile(matricole);
		
	}
	
	if (!flagCampiObbligatori  || !flagUnivocitaMatricolaNelFile){
		this.importabile = false;
		return false;
	}
	return true;
}


public boolean controllaCampiObbligatori (){
	boolean esito = true;
	
	if (!stringaOk(this.getCd_matricola())){
		esito = false;
		this.erroreImport+=" Matricola mancante.";
	}
	if (!stringaOk(this.getCd_codice_azienda_provenienza())){
		esito = false;
		this.erroreImport+=" Codice azienda provenienza mancante.";
	}
	if (!numeroOk(this.getCd_specie())){
		esito = false;
		this.erroreImport+=" Specie mancante.";
	}
	if (!dataOk(this.getCd_data_nascita())){
		esito = false;
		this.erroreImport+=" Data di nascita mancante.";
	}
	if (!dataOk(this.getCd_data_arrivo_macello())){
		esito = false;
		this.erroreImport+=" Data di arrivo al macello mancante.";
	}
	if (!dataOk(this.getCd_data_mod4())){
		esito = false;
		this.erroreImport+=" Data mod 4 mancante.";
	}
	
	
	if (!checkData(this.getCd_data_nascita(),true)){
		esito = false;
		this.erroreImport+=" Formato Data di nascita errato, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getCd_data_arrivo_macello(),true)){
		esito = false;
		this.erroreImport+=" Formato Data di arrivo al macello errato, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getCd_data_mod4(),true)){
		esito = false;
		this.erroreImport+=" Formato Data mod 4 errato, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getBse_data_prelievo(),false)){
		esito = false;
		this.erroreImport+="Formato Data prelievo BSE errato, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getBse_data_ricezione(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione BSE errato, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy) ";
	}
	if (!checkData(this.getMam_data(),false)){
		esito = false;
		this.erroreImport+="Formato Data Mam, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}if (!checkData(this.getVam_data(),false)){
		esito = false;
		this.erroreImport+="Formato Data Vam, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getC1_data_ricezione_esito(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione esito campione 1, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getC2_data_ricezione_esito(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione esito campione 2, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getC3_data_ricezione_esito(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione esito campione 3, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getC4_data_ricezione_esito(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione esito campione 4, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	if (!checkData(this.getC5_data_ricezione_esito(),false)){
		esito = false;
		this.erroreImport+="Formato Data ricezione esito campione 5, il formato corretto e' (yyyy/mm/dd) o (dd/mm/yyyy)";
	}
	
		return esito;
}


private boolean stringaOk (String stringa){
	if (stringa!=null && !stringa.equals("") && !stringa.equals("null"))
		return true;
	return false;
}
private boolean numeroOk (int numero){
	if (numero>-1)
		return true;
	return false;
}
private boolean dataOk (String data){
	if (data=="")
	return false;
	 return true;
	
}

private boolean checkData(String data,boolean obbl){
try {
	if (!("".equals(data.trim()))){
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
	formatter .setLenient(false) ;
	formatter.parse(data.trim()) ;
	System.out.println("DATA 1"+data.trim());
	return true;
	}else
		if (obbl == true){
			System.out.println("DATA 2"+data.trim());
			return false;}else{
				System.out.println("DATA 3"+data.trim());return true;}
	} catch ( Exception exception) {
		
		try {
			if (!("".equals(data.trim()))){
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			formatter .setLenient(false) ;
			formatter.parse(data.trim()) ;
			System.out.println("DATA 1"+data.trim());
			return true;
			}else
				if (obbl == true){
					System.out.println("DATA 2"+data.trim());
					return false;}else{
						System.out.println("DATA 3"+data.trim());return true;}
		} catch ( Exception exception1) {
			System.out.println("DATA 4"+data.trim());
	return false;
	}
	}
}

public String getErroreImport() {
	return erroreImport;
}
public void setErroreImport(String erroreImport) {
	this.erroreImport = erroreImport;
}
public String getCd_veterinario() {
	return cd_veterinario;
}
public void setCd_veterinario(String cd_veterinario_1) {
	this.cd_veterinario = cd_veterinario_1;
}

public void setAltriVeterinari(String listaVet) {
	try {
	String lista[] = listaVet.split("/");
	if (lista.length>3)
		this.erroreImport += "Veterinari addetti al controllo oltre il terzo ignorati nell'import.";
	}
	catch (Exception e){}
}
public void setAltriVeterinariVpm(String listaVet) {
	try {
	String lista[] = listaVet.split("/");
	if (lista.length>3)
		this.erroreImport += "Veterinari addetti al controllo oltre il terzo ignorati nell'import.";
	}
	catch (Exception e){}
}

public void setAltrePatologie(String listaPat) {
	try {
	String lista[] = listaPat.split("/");
	if (lista.length>3)
		this.erroreImport += "Patologie rilevate oltre la terza ignorate nell'import.";
	}
	catch (Exception e){}
}
public void setAltriOrgani(String listaOrg) {
	try {
	String lista[] = listaOrg.split("/");
	if (lista.length>3)
		this.erroreImport += "Organi oltre al terzo ignorati nell'import.";
	}
	catch (Exception e){}
}



public boolean isImportabile() {
	return importabile;
}
public void setImportabile(boolean importabile) {
	this.importabile = importabile;
}
public int getIdImport() {
	return idImport;
}
public void setIdImport(int idImport) {
	this.idImport = idImport;
}


public boolean presentiMatricoleDuplicate(String str, ArrayList<String> list){
	int count = 0;
    for(String i : list){
        if(i.equalsIgnoreCase(str)){
        	count++;
        	if (count>1)
        		 return true;
        }
    }
    return false;
}

public boolean presentiProgDuplicati(int str, ArrayList<Integer> list){
	int count = 0;
    for(int i : list){
        if(i  == str){
        	count++;
        	if (count>1)
        		 return true;
        }
    }
    return false;
}
public int getNumeroRiga() {
	return numeroRiga;
}
public void setNumeroRiga(int numeroRiga) {
	this.numeroRiga = numeroRiga+1;
}


public CapoImport2test(Connection db, int idCapo){
	
	StringBuffer sql = new StringBuffer();
	sql.append("select * from m_capi where id =  ?");
	PreparedStatement pst;
	try {
		pst = db.prepareStatement(sql.toString());
	
	pst.setInt(1, idCapo );
	ResultSet rs = pst.executeQuery();
	if (rs.next()){
		buildRecord(rs);
	}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
}

private void buildRecord(ResultSet rs) throws SQLException{
	
	this.id=rs.getInt("id");
	this.id_macello = rs.getInt("id_macello");
	this.idImport = rs.getInt("id_import");
	this.vpm_data = rs.getString("vpm_data");
	this.cd_matricola = rs.getString("cd_matricola");
	
}

public void aggiornaLiberoConsumo(Connection db) throws SQLException{
	
	SintesisStabilimento org = new SintesisStabilimento (db, id_macello, true);
	String nome= org.getOperatore().getRagioneSociale();
	
	
	StringBuffer sqlBuffer = new StringBuffer();
	sqlBuffer.append("update m_capi set stato_macellazione = ?, vpm_esito = ?, destinatario_1_id = ?, destinatario_1_nome = ?, destinatario_1_in_regione = ?, "
			+ "destinatario_2_id = ?, destinatario_2_nome = ?, destinatario_2_in_regione = ?, solo_cd = ? where id = ? ");
	int i = 0;
	PreparedStatement pst;
	pst = db.prepareStatement(sqlBuffer.toString());
	
	pst.setString(++i, this.getStato_macellazione() );
	pst.setInt(++i, this.getVpm_esito());
	pst.setInt(++i, this.getId_macello());
	pst.setString(++i, nome);
	pst.setBoolean(++i, true);
	pst.setInt(++i, this.getId_macello());
	pst.setString(++i, nome);
	pst.setBoolean(++i, true);
	pst.setBoolean(++i, false);
	pst.setInt(++i,  this.getId());
	pst.executeUpdate();
	
}
public String getCd_categoria() {
	return cd_categoria;
}

public int getCd_razza() {
	return cd_razza;
}
public void setCd_razza(int cd_razza) {
	this.cd_razza = cd_razza;
}
public int getCd_qualifica_sanitaria_tbc() {
	return cd_qualifica_sanitaria_tbc;
}
public void setCd_qualifica_sanitaria_tbc(int cd_qualifica_sanitaria_tbc) {
	this.cd_qualifica_sanitaria_tbc = cd_qualifica_sanitaria_tbc;
}
public int getCd_qualifica_sanitaria_brc() {
	return cd_qualifica_sanitaria_brc;
}
public void setCd_qualifica_sanitaria_brc(int cd_qualifica_sanitaria_brc) {
	this.cd_qualifica_sanitaria_brc = cd_qualifica_sanitaria_brc;
}
public String getCd_vincolo_sanitario() {
	return cd_vincolo_sanitario;
}

public String getCd_mod4() {
	return cd_mod4;
}
public void setCd_mod4(String cd_mod4) {
	this.cd_mod4 = cd_mod4.trim();
}
public String getCd_test_bse() {
	return cd_test_bse;
}
public void setCd_test_bse(String cd_test_bse) {
	this.cd_test_bse = cd_test_bse.trim();
}
public int getCd_macell_differita_piani_risanamento() {
	return cd_macell_differita_piani_risanamento;
}
public void setCd_macell_differita_piani_risanamento(int cd_macell_differita_piani_risanamento) {
	this.cd_macell_differita_piani_risanamento = cd_macell_differita_piani_risanamento;
}
public int getCd_info_bse() {
	return cd_info_bse;
}

public String getBse_data_ricezione() {
	return bse_data_ricezione;
}
public void setBse_data_ricezione(String bse_data_ricezione) {
	this.bse_data_ricezione = bse_data_ricezione;
}
public String getBse_note() {
	return bse_note;
}
public void setBse_note(String bse_note) {
	this.bse_note = bse_note;
}
public String getCd_disponibili_informazioni_cat_alim() {
	return cd_disponibili_informazioni_cat_alim;
}

public String getCd_data_dichiarata_dal_ges() {
	return cd_data_dichiarata_dal_ges;
}

public String getCd_mezzo_di_trasporto_tipo() {
	return cd_mezzo_di_trasporto_tipo;
}
public void setCd_mezzo_di_trasporto_tipo(String cd_mezzo_di_trasporto_tipo) {
	this.cd_mezzo_di_trasporto_tipo = cd_mezzo_di_trasporto_tipo;
}
public String getCd_mezzo_di_trasporto_targa() {
	return cd_mezzo_di_trasporto_targa;
}
public void setCd_mezzo_di_trasporto_targa(String cd_mezzo_di_trasporto_targa) {
	this.cd_mezzo_di_trasporto_targa = cd_mezzo_di_trasporto_targa;
}
public String getCd_trasporto_superiore_8_ore() {
	return cd_trasporto_superiore_8_ore;
}

public String getCd_note() {
	return cd_note;
}
public void setCd_note(String cd_note) {
	this.cd_note = cd_note;
}
public String getMam_data() {
	return mam_data;
}
public void setMam_data(String mam_data) {
	this.mam_data = mam_data;
}
public int getMam_luogo_di_verifica() {
	return mam_luogo_di_verifica;
}
public void setMam_luogo_di_verifica(int mam_luogo_di_verifica) {
	this.mam_luogo_di_verifica = mam_luogo_di_verifica;
}
public String getMam_causa() {
	return mam_causa;
}
public void setCd_info_bse(int cd_info_bse) {
	this.cd_info_bse=cd_info_bse;
}

public void setMam_causa(String mam_causa) {
	this.mam_causa = mam_causa;
}
public String getMam_impianto_termodistruzione() {
	return mam_impianto_termodistruzione;
}
public void setMam_impianto_termodistruzione(String mam_impianto_termodistruzione) {
	this.mam_impianto_termodistruzione = mam_impianto_termodistruzione;
}
public String getMam_destinazione_carcassa() {
	return mam_destinazione_carcassa;
}
public void setMam_destinazione_carcassa(String mam_destinazione_carcassa) {
	this.mam_destinazione_carcassa = mam_destinazione_carcassa;
}
public int getMam_comunicazione_a() {
	return mam_comunicazione_a;
}
public void setMam_comunicazione_a(int mam_comunicazione_a) {
	this.mam_comunicazione_a = mam_comunicazione_a;
}
public String getMam_note() {
	return mam_note;
}
public void setMam_note(String mam_note) {
	this.mam_note = mam_note;
}
public String getVam_data() {
	return vam_data;
}
public void setVam_data(String vam_data) {
	this.vam_data = vam_data;
}
public int getVam_provvedimento_adottato() {
	return vam_provvedimento_adottato;
}
public void setVam_provvedimento_adottato(int vam_provvedimento_adottato) {
	this.vam_provvedimento_adottato = vam_provvedimento_adottato;
}
public int getVam_comunicazione_a() {
	return vam_comunicazione_a;
}
public void setVam_comunicazione_a(int vam_comunicazione_a) {
	this.vam_comunicazione_a = vam_comunicazione_a;
}
public String getVam_note() {
	return vam_note;
}
public void setVam_note(String vam_note) {
	this.vam_note = vam_note;
}
public int getVpm_tipo_macellazione() {
	return vpm_tipo_macellazione;
}
public void setVpm_tipo_macellazione(int vpm_tipo_macellazione) {
	this.vpm_tipo_macellazione = vpm_tipo_macellazione;
}
public String getVpm_progressivo_macellazione() {
	return vpm_progressivo_macellazione;
}
public void setVpm_progressivo_macellazione(String vpm_progressivo_macellazione) {
	this.vpm_progressivo_macellazione = vpm_progressivo_macellazione;
}
public String getVpm_patologie_rilevate() {
	return vpm_patologie_rilevate_1;
}
public void setVpm_patologie_rilevate(String vpm_patologie_rilevate) {
	this.vpm_patologie_rilevate_1 = vpm_patologie_rilevate;
}
public String getVpm_organi_1() {
	return vpm_organi_1;
}

public void setVpm_organi_1(String vpm_organi) {
	this.vpm_organi_1 = vpm_organi;
}

public String getVpm_causa_presunta_accertata() {
	return vpm_causa_presunta_accertata;
}
public void setVpm_causa_presunta_accertata(String vpm_causa_presunta_accertata) {
	this.vpm_causa_presunta_accertata = vpm_causa_presunta_accertata;
}
public String getVpm_destinatario_carni() {
	return vpm_destinatario_carni;
}
public void setVpm_destinatario_carni(String vpm_destinatario_carni) {
	this.vpm_destinatario_carni = vpm_destinatario_carni;
}
public int getC1_motivo() {
	return c1_motivo;
}
public void setC1_motivo(int c1_motivo) {
	this.c1_motivo = c1_motivo;
}
public int getC1_matrice() {
	return c1_matrice;
}
public void setC1_matrice(int c1_matrice) {
	this.c1_matrice = c1_matrice;
}
public int getC1_tipo_analisi() {
	return c1_tipo_analisi;
}
public void setC1_tipo_analisi(int c1_tipo_analisi) {
	this.c1_tipo_analisi = c1_tipo_analisi;
}
public int getC1_molecole_agente_etiologico() {
	return c1_molecole_agente_etiologico;
}
public void setC1_molecole_agente_etiologico(int c1_molecole_agente_etiologico) {
	this.c1_molecole_agente_etiologico = c1_molecole_agente_etiologico;
}
public String getC1_molecole_agente_etiologico_altro() {
	return c1_molecole_agente_etiologico_altro;
}
public void setC1_molecole_agente_etiologico_altro(String c1_molecole_agente_etiologico_altro) {
	this.c1_molecole_agente_etiologico_altro = c1_molecole_agente_etiologico_altro;
}
public int getC1_esito() {
	return c1_esito;
}
public void setC1_esito(int c1_esito) {
	this.c1_esito = c1_esito;
}
public String getC1_data_ricezione_esito() {
	return c1_data_ricezione_esito;
}
public void setC1_data_ricezione_esito(String c1_data_ricezione_esito) {
	this.c1_data_ricezione_esito = c1_data_ricezione_esito;
}
public int getC2_motivo() {
	return c2_motivo;
}
public void setC2_motivo(int c2_motivo) {
	this.c2_motivo = c2_motivo;
}
public int getC2_matrice() {
	return c2_matrice;
}
public void setC2_matrice(int c2_matrice) {
	this.c2_matrice = c2_matrice;
}
public int getC2_tipo_analisi() {
	return c2_tipo_analisi;
}
public void setC2_tipo_analisi(int c2_tipo_analisi) {
	this.c2_tipo_analisi = c2_tipo_analisi;
}
public int getC2_molecole_agente_etiologico() {
	return c2_molecole_agente_etiologico;
}
public void setC2_molecole_agente_etiologico(int c2_molecole_agente_etiologico) {
	this.c2_molecole_agente_etiologico = c2_molecole_agente_etiologico;
}
public String getC2_molecole_agente_etiologico_altro() {
	return c2_molecole_agente_etiologico_altro;
}
public void setC2_molecole_agente_etiologico_altro(String c2_molecole_agente_etiologico_altro) {
	this.c2_molecole_agente_etiologico_altro = c2_molecole_agente_etiologico_altro;
}
public int getC2_esito() {
	return c2_esito;
}
public void setC2_esito(int c2_esito) {
	this.c2_esito = c2_esito;
}
public String getC2_data_ricezione_esito() {
	return c2_data_ricezione_esito;
}
public void setC2_data_ricezione_esito(String c2_data_ricezione_esito) {
	this.c2_data_ricezione_esito = c2_data_ricezione_esito;
}
public int getC3_motivo() {
	return c3_motivo;
}
public void setC3_motivo(int c3_motivo) {
	this.c3_motivo = c3_motivo;
}
public int getC3_matrice() {
	return c3_matrice;
}
public void setC3_matrice(int c3_matrice) {
	this.c3_matrice = c3_matrice;
}
public int getC3_tipo_analisi() {
	return c3_tipo_analisi;
}
public void setC3_tipo_analisi(int c3_tipo_analisi) {
	this.c3_tipo_analisi = c3_tipo_analisi;
}
public int getC3_molecole_agente_etiologico() {
	return c3_molecole_agente_etiologico;
}
public void setC3_molecole_agente_etiologico(int c3_molecole_agente_etiologico) {
	this.c3_molecole_agente_etiologico = c3_molecole_agente_etiologico;
}
public String getC3_molecole_agente_etiologico_altro() {
	return c3_molecole_agente_etiologico_altro;
}
public void setC3_molecole_agente_etiologico_altro(String c3_molecole_agente_etiologico_altro) {
	this.c3_molecole_agente_etiologico_altro = c3_molecole_agente_etiologico_altro;
}
public int getC3_esito() {
	return c3_esito;
}
public void setC3_esito(int c3_esito) {
	this.c3_esito = c3_esito;
}
public String getC3_data_ricezione_esito() {
	return c3_data_ricezione_esito;
}
public void setC3_data_ricezione_esito(String c3_data_ricezione_esito) {
	this.c3_data_ricezione_esito = c3_data_ricezione_esito;
}
public int getC4_motivo() {
	return c4_motivo;
}
public void setC4_motivo(int c4_motivo) {
	this.c4_motivo = c4_motivo;
}
public int getC4_matrice() {
	return c4_matrice;
}
public void setC4_matrice(int c4_matrice) {
	this.c4_matrice = c4_matrice;
}
public int getC4_tipo_analisi() {
	return c4_tipo_analisi;
}
public void setC4_tipo_analisi(int c4_tipo_analisi) {
	this.c4_tipo_analisi = c4_tipo_analisi;
}
public int getC4_molecole_agente_etiologico() {
	return c4_molecole_agente_etiologico;
}
public void setC4_molecole_agente_etiologico(int c4_molecole_agente_etiologico) {
	this.c4_molecole_agente_etiologico = c4_molecole_agente_etiologico;
}
public String getC4_molecole_agente_etiologico_altro() {
	return c4_molecole_agente_etiologico_altro;
}
public void setC4_molecole_agente_etiologico_altro(String c4_molecole_agente_etiologico_altro) {
	this.c4_molecole_agente_etiologico_altro = c4_molecole_agente_etiologico_altro;
}
public int getC4_esito() {
	return c4_esito;
}
public void setC4_esito(int c4_esito) {
	this.c4_esito = c4_esito;
}
public String getC4_data_ricezione_esito() {
	return c4_data_ricezione_esito;
}
public void setC4_data_ricezione_esito(String c4_data_ricezione_esito) {
	this.c4_data_ricezione_esito = c4_data_ricezione_esito;
}
public int getC5_motivo() {
	return c5_motivo;
}
public void setC5_motivo(int c5_motivo) {
	this.c5_motivo = c5_motivo;
}
public int getC5_matrice() {
	return c5_matrice;
}
public void setC5_matrice(int c5_matrice) {
	this.c5_matrice = c5_matrice;
}
public int getC5_tipo_analisi() {
	return c5_tipo_analisi;
}
public void setC5_tipo_analisi(int c5_tipo_analisi) {
	this.c5_tipo_analisi = c5_tipo_analisi;
}
public int getC5_molecole_agente_etiologico() {
	return c5_molecole_agente_etiologico;
}
public void setC5_molecole_agente_etiologico(int c5_molecole_agente_etiologico) {
	this.c5_molecole_agente_etiologico = c5_molecole_agente_etiologico;
}
public String getC5_molecole_agente_etiologico_altro() {
	return c5_molecole_agente_etiologico_altro;
}
public void setC5_molecole_agente_etiologico_altro(String c5_molecole_agente_etiologico_altro) {
	this.c5_molecole_agente_etiologico_altro = c5_molecole_agente_etiologico_altro;
}
public int getC5_esito() {
	return c5_esito;
}
public void setC5_esito(int c5_esito) {
	this.c5_esito = c5_esito;
}
public String getC5_data_ricezione_esito() {
	return c5_data_ricezione_esito;
}
public void setC5_data_ricezione_esito(String c5_data_ricezione_esito) {
	this.c5_data_ricezione_esito = c5_data_ricezione_esito;
}
public String getTmp_eseguito() {
	return tmp_eseguito;
}

public int getTmp_tipo_analisi() {
	return tmp_tipo_analisi;
}
public void setTmp_tipo_analisi(int tmp_tipo_analisi) {
	this.tmp_tipo_analisi = tmp_tipo_analisi;
}
public String getTmp_metodo_distruttivo() {
	return tmp_metodo_distruttivo;
}



public String getVpm_veterinario() {
	return vpm_veterinario;
}
public void setVpm_veterinario(String vpm_veterinario) {
	this.vpm_veterinario = vpm_veterinario;
}
public boolean isFalso_errore() {
	return falso_errore;
}
public void setFalso_errore(boolean falso_errore) {
	this.falso_errore = falso_errore;
}





}
