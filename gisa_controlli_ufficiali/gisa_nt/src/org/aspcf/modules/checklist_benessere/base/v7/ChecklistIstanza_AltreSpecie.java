package org.aspcf.modules.checklist_benessere.base.v7;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;

public class ChecklistIstanza_AltreSpecie extends GenericBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	 /**
	   *  Constructor for the Organization object, creates an empty Organization
	   *
	   * @since    1.0
	   */
	  public ChecklistIstanza_AltreSpecie() { }

	private int id;
	private int idChkBnsModIst;
	private int numAllegato;
	private int codAllegato;
	private int idCu;
	private int idSpecie;
	private int idVersione;
	private int orgId;
	private int enteredBy;
	private int modifiedBy;
	
	private java.sql.Timestamp entered = null;
	private java.sql.Timestamp modified = null;
	private java.sql.Timestamp trashedDate = null;
	private java.sql.Timestamp dataChk = null;
	
	boolean bozza = true;
		
	private ArrayList<Risposta> risposte = new ArrayList<Risposta>();
	private String numCheckList;
	private String veterinarioIspettore;
	private String presenzaManuale;
	private String veterinarioAziendale;
	
	private String numTotaleCapannoni;
	private String numTotaleCapannoniAttivi;
	
	private String capannone1num;
	private String capannone1capacita;
	private String capannone1data;
	private String capannone1accasati;
	private String capannone1presenti;
	private String capannone1ispezionato;
	
	private String capannone2num;
	private String capannone2capacita;
	private String capannone2data;
	private String capannone2accasati;
	private String capannone2presenti;
	private String capannone2ispezionato;
	
	private String capannone3num;
	private String capannone3capacita;
	private String capannone3data;
	private String capannone3accasati;
	private String capannone3presenti;
	private String capannone3ispezionato;
	
	private String capannone4num;
	private String capannone4ispezionato;

	private String capannone5num;
	private String capannone5ispezionato;
	
	private String appartenenteCondizionalita;

	private String criteriUtilizzati;
	private String criteriUtilizzatiAltroDescrizione;
	
	private String esitoControllo;
	private String intenzionalita;
	
	private String evidenze;
	private String evidenzeIr;
	private String evidenzeTse;
	private String evidenzeSv;
	
	private String assegnatePrescrizioni;
	private String prescrizioniDescrizione;
	private String dataPrescrizioni;
	
	private String sanzBlocco;
	private String sanzAmministrativa;
	private String sanzAbbattimento;
	private String sanzSequestro;
	private String sanzInformativa;
	private String sanzAltro;
	private String sanzAltroDesc;
	
	private String noteControllore;
	private String noteProprietario;
	
	private String nomeProprietario;
	private String nomeControllore;

	private String eseguitePrescrizioni;
	private String prescrizioniEseguiteDescrizione;
	private String dataVerifica;
	private String nomeProprietarioPrescrizioniEseguite;
	private String nomeControllorePrescrizioniEseguite;

	private String dataChiusuraRelazione;

	private String ibridoRazzaAllevata;
	private String stimaCapannone1num;
	private String stimaCapannone1numCapi;
	private String stimaCapannone2num;
	private String stimaCapannone2numCapi;
	private String stimaCapannone3num;
	private String stimaCapannone3numCapi;
	
	private String dataPrimoControllo;
	private String capacitaMassima;
	
	private String faseProduttiva;


	public void recuperaDaForm(ActionContext context, Connection db) throws SQLException {
			 
		numCheckList = context.getRequest().getParameter("numChecklist"); 
		veterinarioIspettore = context.getRequest().getParameter("veterinarioIspettore");
		presenzaManuale = context.getRequest().getParameter("presenzaManuale");
		veterinarioAziendale = context.getRequest().getParameter("veterinarioAziendale");

		numTotaleCapannoni = context.getRequest().getParameter("numTotaleCapannoni");
		numTotaleCapannoniAttivi = context.getRequest().getParameter("numTotaleCapannoniAttivi");

		capannone1num = context.getRequest().getParameter("capannone1num");
		capannone1capacita = context.getRequest().getParameter("capannone1capacita");
		capannone1data = context.getRequest().getParameter("capannone1data");
		capannone1accasati = context.getRequest().getParameter("capannone1accasati");
		capannone1presenti = context.getRequest().getParameter("capannone1presenti");
		capannone1ispezionato = context.getRequest().getParameter("capannone1ispezionato");
		
		capannone2num = context.getRequest().getParameter("capannone2num");
		capannone2capacita = context.getRequest().getParameter("capannone2capacita");
		capannone2data = context.getRequest().getParameter("capannone2data");
		capannone2accasati = context.getRequest().getParameter("capannone2accasati");
		capannone2presenti = context.getRequest().getParameter("capannone2presenti");
		capannone2ispezionato = context.getRequest().getParameter("capannone2ispezionato");
		
		capannone3num = context.getRequest().getParameter("capannone3num");
		capannone3capacita = context.getRequest().getParameter("capannone3capacita");
		capannone3data = context.getRequest().getParameter("capannone3data");
		capannone3accasati = context.getRequest().getParameter("capannone3accasati");
		capannone3presenti = context.getRequest().getParameter("capannone3presenti");
		capannone3ispezionato = context.getRequest().getParameter("capannone3ispezionato");
		
		capannone4num = context.getRequest().getParameter("capannone4num");
		capannone4ispezionato = context.getRequest().getParameter("capannone4ispezionato");
		
		capannone5num = context.getRequest().getParameter("capannone5num");
		capannone5ispezionato = context.getRequest().getParameter("capannone5ispezionato");

		appartenenteCondizionalita = context.getRequest().getParameter("appartenenteCondizionalita");
		criteriUtilizzati = context.getRequest().getParameter("criteriUtilizzati");
		criteriUtilizzatiAltroDescrizione = context.getRequest().getParameter("criteriUtilizzatiAltroDescrizione");
	
		esitoControllo = context.getRequest().getParameter("esitoControllo");
		intenzionalita = context.getRequest().getParameter("intenzionalita");
		evidenze = context.getRequest().getParameter("evidenze");
		evidenzeIr = context.getRequest().getParameter("evidenzeIr");
		evidenzeTse = context.getRequest().getParameter("evidenzeTse");
		evidenzeSv = context.getRequest().getParameter("evidenzeSv");
		
		assegnatePrescrizioni = context.getRequest().getParameter("assegnatePrescrizioni");
		prescrizioniDescrizione = context.getRequest().getParameter("prescrizioniDescrizione");
		dataPrescrizioni = context.getRequest().getParameter("dataPrescrizioni");
		
		sanzBlocco = context.getRequest().getParameter("sanzBlocco");
		sanzAmministrativa = context.getRequest().getParameter("sanzAmministrativa");
		sanzAbbattimento = context.getRequest().getParameter("sanzAbbattimento");
		sanzSequestro = context.getRequest().getParameter("sanzSequestro");
		sanzInformativa = context.getRequest().getParameter("sanzInformativa");
		sanzAltro = context.getRequest().getParameter("sanzAltro");
		sanzAltroDesc = context.getRequest().getParameter("sanzAltroDesc");

		noteControllore = context.getRequest().getParameter("noteControllore");
		noteProprietario = context.getRequest().getParameter("noteProprietario");
		nomeProprietario = context.getRequest().getParameter("nomeProprietario");
		nomeControllore = context.getRequest().getParameter("nomeControllore");
		
		eseguitePrescrizioni = context.getRequest().getParameter("eseguitePrescrizioni");
		prescrizioniEseguiteDescrizione = context.getRequest().getParameter("prescrizioniEseguiteDescrizione");
		dataVerifica = context.getRequest().getParameter("dataVerifica");
		nomeProprietarioPrescrizioniEseguite = context.getRequest().getParameter("nomeProprietarioPrescrizioniEseguite");
		nomeControllorePrescrizioniEseguite = context.getRequest().getParameter("nomeControllorePrescrizioniEseguite");
		dataChiusuraRelazione = context.getRequest().getParameter("dataChiusuraRelazione");
		
		ibridoRazzaAllevata = context.getRequest().getParameter("ibridoRazzaAllevata");
		stimaCapannone1num = context.getRequest().getParameter("stimaCapannone1num");
		stimaCapannone1numCapi = context.getRequest().getParameter("stimaCapannone1numCapi");
		stimaCapannone2num = context.getRequest().getParameter("stimaCapannone2num");
		stimaCapannone2numCapi = context.getRequest().getParameter("stimaCapannone2numCapi");
		stimaCapannone3num = context.getRequest().getParameter("stimaCapannone3num");
		stimaCapannone3numCapi = context.getRequest().getParameter("stimaCapannone3numCapi");

		dataPrimoControllo = context.getRequest().getParameter("dataPrimoControllo");
		capacitaMassima = context.getRequest().getParameter("capacitaMassima");

		faseProduttiva = context.getRequest().getParameter("faseProduttiva");

  	    PreparedStatement pst = db.prepareStatement("select * from chk_bns_get_domande_v7(?, ?, ?, ?)");
		pst.setInt(1, idSpecie);
		pst.setInt(2, numAllegato);
		pst.setInt(3, idVersione);
		pst.setInt(4, idCu);
		ResultSet rs = pst.executeQuery();
		while (rs.next()){
			   Domanda domanda = new Domanda(db, rs, -1); 
			   Risposta risposta = new Risposta();
			   risposta.setIdDomanda(domanda.getId());
			   risposta.setRisposta(context.getRequest().getParameter("dom_"+domanda.getId()+"_risposta"));
			   risposta.setEvidenze(context.getRequest().getParameter("dom_"+domanda.getId()+"_evidenze"));
			   risposte.add(risposta);
		   }
		
	}




	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public int getIdChkBnsModIst() {
		return idChkBnsModIst;
	}




	public void setIdChkBnsModIst(int idChkBnsModIst) {
		this.idChkBnsModIst = idChkBnsModIst;
	}




	public int getNumAllegato() {
		return numAllegato;
	}




	public void setNumAllegato(int numAllegato) {
		this.numAllegato = numAllegato;
	}




	public int getIdCu() {
		return idCu;
	}




	public void setIdCu(int idCu) {
		this.idCu = idCu;
	}




	public int getIdSpecie() {
		return idSpecie;
	}




	public void setIdSpecie(int idSpecie) {
		this.idSpecie = idSpecie;
	}




	public int getIdVersione() {
		return idVersione;
	}




	public void setIdVersione(int idVersione) {
		this.idVersione = idVersione;
	}




	public int getOrgId() {
		return orgId;
	}




	public void setOrgId(int orgId) {
		this.orgId = orgId;
	}




	public int getEnteredBy() {
		return enteredBy;
	}




	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}




	public int getModifiedBy() {
		return modifiedBy;
	}




	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}




	public java.sql.Timestamp getEntered() {
		return entered;
	}




	public void setEntered(java.sql.Timestamp entered) {
		this.entered = entered;
	}




	public java.sql.Timestamp getModified() {
		return modified;
	}




	public void setModified(java.sql.Timestamp modified) {
		this.modified = modified;
	}




	public java.sql.Timestamp getTrashedDate() {
		return trashedDate;
	}




	public void setTrashedDate(java.sql.Timestamp trashedDate) {
		this.trashedDate = trashedDate;
	}




	public java.sql.Timestamp getDataChk() {
		return dataChk;
	}




	public void setDataChk(java.sql.Timestamp dataChk) {
		this.dataChk = dataChk;
	}




	public boolean isBozza() {
		return bozza;
	}




	public void setBozza(boolean bozza) {
		this.bozza = bozza;
	}




	public ArrayList<Risposta> getRisposte() {
		return risposte;
	}




	public void setRisposte(ArrayList<Risposta> risposte) {
		this.risposte = risposte;
	}

	public String getNumCheckList() {
		return numCheckList;
	}




	public void setNumCheckList(String numCheckList) {
		this.numCheckList = numCheckList;
	}




	public String getVeterinarioIspettore() {
		return veterinarioIspettore;
	}




	public void setVeterinarioIspettore(String veterinarioIspettore) {
		this.veterinarioIspettore = veterinarioIspettore;
	}

	
	


	public String getPresenzaManuale() {
		return presenzaManuale;
	}




	public void setPresenzaManuale(String presenzaManuale) {
		this.presenzaManuale = presenzaManuale;
	}




	public String getCriteriUtilizzati() {
		return criteriUtilizzati;
	}




	public void setCriteriUtilizzati(String criteriUtilizzati) {
		this.criteriUtilizzati = criteriUtilizzati;
	}




	public String getCriteriUtilizzatiAltroDescrizione() {
		return criteriUtilizzatiAltroDescrizione;
	}




	public void setCriteriUtilizzatiAltroDescrizione(String criteriUtilizzatiAltroDescrizione) {
		this.criteriUtilizzatiAltroDescrizione = criteriUtilizzatiAltroDescrizione;
	}




	public String getAppartenenteCondizionalita() {
		return appartenenteCondizionalita;
	}




	public void setAppartenenteCondizionalita(String appartenenteCondizionalita) {
		this.appartenenteCondizionalita = appartenenteCondizionalita;
	}




	public String getEsitoControllo() {
		return esitoControllo;
	}




	public void setEsitoControllo(String esitoControllo) {
		this.esitoControllo = esitoControllo;
	}




	public String getEvidenze() {
		return evidenze;
	}




	public void setEvidenze(String evidenze) {
		this.evidenze = evidenze;
	}




	public String getEvidenzeTse() {
		return evidenzeTse;
	}




	public void setEvidenzeTse(String evidenzeTse) {
		this.evidenzeTse = evidenzeTse;
	}




	public String getEvidenzeIr() {
		return evidenzeIr;
	}




	public void setEvidenzeIr(String evidenzeIr) {
		this.evidenzeIr = evidenzeIr;
	}




	public String getEvidenzeSv() {
		return evidenzeSv;
	}




	public void setEvidenzeSv(String evidenzeSv) {
		this.evidenzeSv = evidenzeSv;
	}




	public String getPrescrizioniDescrizione() {
		return prescrizioniDescrizione;
	}




	public void setPrescrizioniDescrizione(String prescrizioniDescrizione) {
		this.prescrizioniDescrizione = prescrizioniDescrizione;
	}




	public String getAssegnatePrescrizioni() {
		return assegnatePrescrizioni;
	}




	public void setAssegnatePrescrizioni(String assegnatePrescrizioni) {
		this.assegnatePrescrizioni = assegnatePrescrizioni;
	}




	public String getDataPrescrizioni() {
		return dataPrescrizioni;
	}




	public void setDataPrescrizioni(String dataPrescrizioni) {
		this.dataPrescrizioni = dataPrescrizioni;
	}




	public String getSanzBlocco() {
		return sanzBlocco;
	}




	public void setSanzBlocco(String sanzBlocco) {
		this.sanzBlocco = sanzBlocco;
	}




	public String getSanzAmministrativa() {
		return sanzAmministrativa;
	}




	public void setSanzAmministrativa(String sanzAmministrativa) {
		this.sanzAmministrativa = sanzAmministrativa;
	}




	public String getSanzAbbattimento() {
		return sanzAbbattimento;
	}




	public void setSanzAbbattimento(String sanzAbbattimento) {
		this.sanzAbbattimento = sanzAbbattimento;
	}




	public String getSanzSequestro() {
		return sanzSequestro;
	}




	public void setSanzSequestro(String sanzSequestro) {
		this.sanzSequestro = sanzSequestro;
	}




	public String getSanzAltro() {
		return sanzAltro;
	}




	public void setSanzAltro(String sanzAltro) {
		this.sanzAltro = sanzAltro;
	}




	public String getSanzInformativa() {
		return sanzInformativa;
	}




	public void setSanzInformativa(String sanzInformativa) {
		this.sanzInformativa = sanzInformativa;
	}




	public String getSanzAltroDesc() {
		return sanzAltroDesc;
	}




	public void setSanzAltroDesc(String sanzAltroDesc) {
		this.sanzAltroDesc = sanzAltroDesc;
	}




	public String getNoteControllore() {
		return noteControllore;
	}




	public void setNoteControllore(String noteControllore) {
		this.noteControllore = noteControllore;
	}




	public String getNoteProprietario() {
		return noteProprietario;
	}




	public void setNoteProprietario(String noteProprietario) {
		this.noteProprietario = noteProprietario;
	}




	public String getNomeProprietario() {
		return nomeProprietario;
	}




	public void setNomeProprietario(String nomeProprietario) {
		this.nomeProprietario = nomeProprietario;
	}



	public String getNomeControllore() {
		return nomeControllore;
	}




	public void setNomeControllore(String nomeControllore) {
		this.nomeControllore = nomeControllore;
	}




	public String getEseguitePrescrizioni() {
		return eseguitePrescrizioni;
	}




	public void setEseguitePrescrizioni(String eseguitePrescrizioni) {
		this.eseguitePrescrizioni = eseguitePrescrizioni;
	}




	public String getPrescrizioniEseguiteDescrizione() {
		return prescrizioniEseguiteDescrizione;
	}




	public void setPrescrizioniEseguiteDescrizione(String prescrizioniEseguiteDescrizione) {
		this.prescrizioniEseguiteDescrizione = prescrizioniEseguiteDescrizione;
	}




	public String getNomeProprietarioPrescrizioniEseguite() {
		return nomeProprietarioPrescrizioniEseguite;
	}




	public void setNomeProprietarioPrescrizioniEseguite(String nomeProprietarioPrescrizioniEseguite) {
		this.nomeProprietarioPrescrizioniEseguite = nomeProprietarioPrescrizioniEseguite;
	}




	public String getDataVerifica() {
		return dataVerifica;
	}




	public void setDataVerifica(String dataVerifica) {
		this.dataVerifica = dataVerifica;
	}




	public String getNomeControllorePrescrizioniEseguite() {
		return nomeControllorePrescrizioniEseguite;
	}




	public void setNomeControllorePrescrizioniEseguite(String nomeControllorePrescrizioniEseguite) {
		this.nomeControllorePrescrizioniEseguite = nomeControllorePrescrizioniEseguite;
	}




	public String getDataChiusuraRelazione() {
		return dataChiusuraRelazione;
	}




	public void setDataChiusuraRelazione(String dataChiusuraRelazione) {
		this.dataChiusuraRelazione = dataChiusuraRelazione;
	}




	public int getCodAllegato() {
		return codAllegato;
	}




	public void setCodAllegato(int codAllegato) {
		this.codAllegato = codAllegato;
	}




	public void upsert(Connection db) throws SQLException {

	PreparedStatement pst = null;
	ResultSet rs = null;
	
	String esitoImportPrecedente = null;
	String descrizioneErrorePrecedente = null;
	Timestamp dataImportPrecedente = null;
	int idBdnPrecedente = -1;

	System.out.println("CONTROLLO SE ESISTE GIA' UN'ISTANZA");
	pst = db.prepareStatement("select id,esito_import, descrizione_errore, id_bdn, data_import from chk_bns_mod_ist where id_alleg = ? and idcu = ? and trashed_date is null");
	pst.setInt(1, codAllegato);
	pst.setInt(2, idCu);
	rs = pst.executeQuery();
	if (rs.next()){
		this.idChkBnsModIst = rs.getInt("id");
		esitoImportPrecedente =  rs.getString("esito_import");
		descrizioneErrorePrecedente =  rs.getString("descrizione_errore");
		dataImportPrecedente = rs.getTimestamp("data_import");
		idBdnPrecedente = rs.getInt("id_bdn");
	}
	System.out.println("ID ISTANZA: "+this.idChkBnsModIst);
	
	System.out.println("SE ESISTE, DISABILITO L'ISTANZA");

	if (this.idChkBnsModIst>0){
		pst = db.prepareStatement("update chk_bns_mod_ist set trashed_date = now() where id = ? and trashed_date is null");
		pst.setInt(1, this.idChkBnsModIst);
		pst.executeUpdate();
		
		pst = db.prepareStatement("update chk_bns_mod_ist_v7_broiler set trashed_date = now() where id_chk_bns_mod_ist = ? and trashed_date is null");
		pst.setInt(1, this.idChkBnsModIst);
		pst.executeUpdate();
		
		pst = db.prepareStatement("update chk_bns_risposte_v7 set trashed_date = now() where id_chk_bns_mod_ist = ? and trashed_date is null");
		pst.setInt(1, this.idChkBnsModIst);
		pst.executeUpdate();
		
	}
	
	System.out.println("INSERISCO LA NUOVA ISTANZA");
	pst = db.prepareStatement("insert into chk_bns_mod_ist (id_alleg, idcu, orgid, enteredby, modifiedby, bozza, esito_import, descrizione_errore, id_bdn, data_import) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning id as id_inserito");
	pst.setInt(1, codAllegato);
	pst.setInt(2, idCu);
	pst.setInt(3, orgId);
	pst.setInt(4, enteredBy);
	pst.setInt(5, enteredBy);
	pst.setBoolean(6, bozza);
	pst.setString(7, esitoImportPrecedente);
	pst.setString(8, descrizioneErrorePrecedente);
	pst.setInt(9, idBdnPrecedente);
	pst.setTimestamp(10, dataImportPrecedente);
	
	boolean chkBnsModIstInserita = false;
	int chkBnsModIstInseritaIndex = 0;
	do {
		try {
			System.out.println("PROVO INSERIMENTO IN chk_bns_mod_ist");
			rs = pst.executeQuery();
			chkBnsModIstInserita = true;
			}
		catch (Exception e) {
			System.out.println("ERRORE INSERIMENTO IN chk_bns_mod_ist");
			e.printStackTrace();
		}
		chkBnsModIstInseritaIndex++;
	}
	while (!chkBnsModIstInserita && chkBnsModIstInseritaIndex<10);	
	
	if (chkBnsModIstInserita){
	
	if (rs.next())
		this.idChkBnsModIst = rs.getInt("id_inserito");

	System.out.println("INSERISCO I NUOVI DATI CHECKLIST");
	
	pst = db.prepareStatement("INSERT INTO public.chk_bns_mod_ist_v7_broiler("+
            "id_chk_bns_mod_ist, entered_by, "+
            "num_checklist, veterinario_ispettore, presenza_manuale, veterinario_aziendale, num_totale_capannoni, num_totale_capannoni_attivi, "+
            "capannone_1_num, capannone_1_capacita, capannone_1_data, capannone_1_accasati, capannone_1_presenti, capannone_1_ispezionato, "+
            "capannone_2_num, capannone_2_capacita, capannone_2_data, capannone_2_accasati, capannone_2_presenti, capannone_2_ispezionato, "+
            "capannone_3_num, capannone_3_capacita, capannone_3_data, capannone_3_accasati, capannone_3_presenti, capannone_3_ispezionato, "+
            "capannone_4_num, capannone_4_ispezionato, capannone_5_num, capannone_5_ispezionato, appartenente_condizionalita, criteri_utilizzati, "+
            "criteri_utilizzati_altro_descrizione, esito_controllo, intenzionalita, evidenze, evidenze_ir, evidenze_tse, "+
            "evidenze_sv, assegnate_prescrizioni, prescrizioni_descrizione, data_prescrizioni, sanz_blocco, sanz_amministrativa, "+
            "sanz_abbattimento, sanz_sequestro, sanz_informativa, sanz_altro, sanz_altro_desc, note_controllore, "+
            "note_proprietario, nome_proprietario, nome_controllore, eseguite_prescrizioni, prescrizioni_eseguite_descrizione, data_verifica, "+
            "nome_proprietario_prescrizioni_eseguite, nome_controllore_prescrizioni_eseguite, data_chiusura_relazione, ibrido_razza_allevata, stima_capannone_1_num, stima_capannone_1_num_capi, "+
            "stima_capannone_2_num, stima_capannone_2_num_capi, stima_capannone_3_num, stima_capannone_3_num_capi, data_primo_controllo, capacita_massima, fase_produttiva " +
            ")"+
            "VALUES (?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "+
            "?, ?, ?, ?, ?, ?, "
            + "?);");

		int i = 0;
		pst.setInt(++i, this.idChkBnsModIst);
		pst.setInt(++i, this.enteredBy);
		
		pst.setString(++i, this.numCheckList);
		pst.setString(++i, this.veterinarioIspettore);
		pst.setString(++i, this.presenzaManuale);
		pst.setString(++i, this.veterinarioAziendale);
		pst.setString(++i, this.numTotaleCapannoni);
		pst.setString(++i, this.numTotaleCapannoniAttivi);
		
		pst.setString(++i, this.capannone1num);
		pst.setString(++i, this.capannone1capacita);
		pst.setString(++i, this.capannone1data);
		pst.setString(++i, this.capannone1accasati);
		pst.setString(++i, this.capannone1presenti);
		pst.setString(++i, this.capannone1ispezionato);
		
		pst.setString(++i, this.capannone2num);
		pst.setString(++i, this.capannone2capacita);
		pst.setString(++i, this.capannone2data);
		pst.setString(++i, this.capannone2accasati);
		pst.setString(++i, this.capannone2presenti);
		pst.setString(++i, this.capannone2ispezionato);
		
		pst.setString(++i, this.capannone3num);
		pst.setString(++i, this.capannone3capacita);
		pst.setString(++i, this.capannone3data);
		pst.setString(++i, this.capannone3accasati);
		pst.setString(++i, this.capannone3presenti);
		pst.setString(++i, this.capannone3ispezionato);
		
		pst.setString(++i, this.capannone4num);
		pst.setString(++i, this.capannone4ispezionato);
		pst.setString(++i, this.capannone5num);
		pst.setString(++i, this.capannone5ispezionato);
		pst.setString(++i, this.appartenenteCondizionalita);
		pst.setString(++i, this.criteriUtilizzati);

		pst.setString(++i, this.criteriUtilizzatiAltroDescrizione);
		pst.setString(++i, this.esitoControllo);
		pst.setString(++i, this.intenzionalita);
		pst.setString(++i, this.evidenze);
		pst.setString(++i, this.evidenzeIr);
		pst.setString(++i, this.evidenzeTse);
		
		pst.setString(++i, this.evidenzeSv);
		pst.setString(++i, this.assegnatePrescrizioni);
		pst.setString(++i, this.prescrizioniDescrizione);
		pst.setString(++i, this.dataPrescrizioni);
		pst.setString(++i, this.sanzBlocco);
		pst.setString(++i, this.sanzAmministrativa);
		
		pst.setString(++i, this.sanzAbbattimento);
		pst.setString(++i, this.sanzSequestro);
		pst.setString(++i, this.sanzInformativa);
		pst.setString(++i, this.sanzAltro);
		pst.setString(++i, this.sanzAltroDesc);
		pst.setString(++i, this.noteControllore);
		
		pst.setString(++i, this.noteProprietario);
		pst.setString(++i, this.nomeProprietario);
		pst.setString(++i, this.nomeControllore);
		pst.setString(++i, this.eseguitePrescrizioni);
		pst.setString(++i, this.prescrizioniEseguiteDescrizione);
		pst.setString(++i, this.dataVerifica);
		
		pst.setString(++i, this.nomeProprietarioPrescrizioniEseguite);
		pst.setString(++i, this.nomeControllorePrescrizioniEseguite);
		pst.setString(++i, this.dataChiusuraRelazione);
		pst.setString(++i, this.ibridoRazzaAllevata);
		pst.setString(++i, this.stimaCapannone1num);
		pst.setString(++i, this.stimaCapannone1numCapi);

		pst.setString(++i, this.stimaCapannone2num);
		pst.setString(++i, this.stimaCapannone2numCapi);
		pst.setString(++i, this.stimaCapannone3num);
		pst.setString(++i, this.stimaCapannone3numCapi);
		pst.setString(++i, this.dataPrimoControllo);
		pst.setString(++i, this.capacitaMassima);
		
		pst.setString(++i, this.faseProduttiva);

		pst.executeUpdate();
	
	System.out.println("INSERISCO LE NUOVE RISPOSTE");
	
	for (int r = 0 ; r<risposte.size(); r++) {
		Risposta risposta = (Risposta) risposte.get(r);
		risposta.setEnteredBy(this.enteredBy);
		risposta.setIdChkBnsModIst(this.idChkBnsModIst);
		risposta.insert(db);
	}
	
	}	
		
	}
	
	
	public ChecklistIstanza_AltreSpecie(Connection db, int idControllo, int codAllegato) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select id, bozza from chk_bns_mod_ist where idcu = ? and id_alleg = ? and trashed_date is null");
		pst.setInt(1, idControllo);
		pst.setInt(2, codAllegato);
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			this.idChkBnsModIst = rs.getInt("id");
			this.bozza = rs.getBoolean("bozza");
			queryRecordByIdChkBnsModIst(db);
		}
		
	}

	private void queryRecordByIdChkBnsModIst(Connection db) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from chk_bns_mod_ist_v7_broiler where id_chk_bns_mod_ist = ? and trashed_date is null");
		pst.setInt(1, this.idChkBnsModIst);
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			buildRecord(rs);
			setRisposte(db);
		}
				
	}


	private void setRisposte(Connection db) throws SQLException {
		this.risposte = Risposta.queryListByIdChkBnsModIst(db, this.idChkBnsModIst);
	}




	public String getIntenzionalita() {  
		return intenzionalita;
	}




	public void setIntenzionalita(String intenzionalita) {
		this.intenzionalita = intenzionalita;
	}

 


	private void buildRecord(ResultSet rs) throws SQLException {
		this.id = rs.getInt("id");
		this.idChkBnsModIst = rs.getInt("id_chk_bns_mod_ist");
		this.enteredBy = rs.getInt("entered_by");
		this.numCheckList = rs.getString("num_checklist");
		this.veterinarioIspettore = rs.getString("veterinario_ispettore");
		this.presenzaManuale = rs.getString("presenza_manuale");
		this.veterinarioAziendale = rs.getString("veterinario_aziendale");

		this.numTotaleCapannoni = rs.getString("num_totale_capannoni");
		this.numTotaleCapannoniAttivi = rs.getString("num_totale_capannoni_attivi");
		
		this.capannone1num = rs.getString("capannone_1_num");
		this.capannone1capacita = rs.getString("capannone_1_capacita");
		this.capannone1data = rs.getString("capannone_1_data");
		this.capannone1accasati = rs.getString("capannone_1_accasati");
		this.capannone1presenti = rs.getString("capannone_1_presenti");
		this.capannone1ispezionato = rs.getString("capannone_1_ispezionato");
		
		this.capannone2num = rs.getString("capannone_2_num");
		this.capannone2capacita = rs.getString("capannone_2_capacita");
		this.capannone2data = rs.getString("capannone_2_data");
		this.capannone2accasati = rs.getString("capannone_2_accasati");
		this.capannone2presenti = rs.getString("capannone_2_presenti");
		this.capannone2ispezionato = rs.getString("capannone_2_ispezionato");
		
		this.capannone3num = rs.getString("capannone_3_num");
		this.capannone3capacita = rs.getString("capannone_3_capacita");
		this.capannone3data = rs.getString("capannone_3_data");
		this.capannone3accasati = rs.getString("capannone_3_accasati");
		this.capannone3presenti = rs.getString("capannone_3_presenti");
		this.capannone3ispezionato = rs.getString("capannone_3_ispezionato");
		
		this.capannone4num = rs.getString("capannone_4_num");
		this.capannone4ispezionato = rs.getString("capannone_4_ispezionato");

		this.capannone5num = rs.getString("capannone_5_num");
		this.capannone5ispezionato = rs.getString("capannone_5_ispezionato");
		
		this.appartenenteCondizionalita = rs.getString("appartenente_condizionalita");
		this.criteriUtilizzati = rs.getString("criteri_utilizzati");
		this.criteriUtilizzatiAltroDescrizione = rs.getString("criteri_utilizzati_altro_descrizione");
		this.esitoControllo = rs.getString("esito_controllo");
		this.intenzionalita = rs.getString("intenzionalita");
		this.evidenze = rs.getString("evidenze");
		this.evidenzeTse = rs.getString("evidenze_tse");
		this.evidenzeIr = rs.getString("evidenze_ir");
		this.evidenzeSv = rs.getString("evidenze_sv");
		this.prescrizioniDescrizione = rs.getString("prescrizioni_descrizione");
		this.assegnatePrescrizioni = rs.getString("assegnate_prescrizioni");
		this.dataPrescrizioni = rs.getString("data_prescrizioni");
		this.sanzBlocco = rs.getString("sanz_blocco");
		this.sanzAmministrativa = rs.getString("sanz_amministrativa");
		this.sanzAbbattimento = rs.getString("sanz_abbattimento");
		this.sanzSequestro = rs.getString("sanz_sequestro");
		this.sanzInformativa = rs.getString("sanz_informativa");
		this.sanzAltro = rs.getString("sanz_altro");
		this.sanzAltroDesc = rs.getString("sanz_altro_desc");
		this.noteControllore = rs.getString("note_controllore");
		this.noteProprietario = rs.getString("note_proprietario");
		this.nomeProprietario = rs.getString("nome_proprietario");
		this.nomeControllore = rs.getString("nome_controllore");
		this.eseguitePrescrizioni = rs.getString("eseguite_prescrizioni");
		this.prescrizioniEseguiteDescrizione = rs.getString("prescrizioni_eseguite_descrizione");
		this.nomeProprietarioPrescrizioniEseguite = rs.getString("nome_proprietario_prescrizioni_eseguite");
		this.dataVerifica = rs.getString("data_verifica");
		this.nomeControllorePrescrizioniEseguite = rs.getString("nome_controllore_prescrizioni_eseguite");
		this.dataChiusuraRelazione = rs.getString("data_chiusura_relazione");
		
		this.ibridoRazzaAllevata = rs.getString("ibrido_razza_allevata");
		
		this.stimaCapannone1num = rs.getString("stima_capannone_1_num");
		this.stimaCapannone1numCapi = rs.getString("stima_capannone_1_num_capi");
		
		this.stimaCapannone2num = rs.getString("stima_capannone_2_num");
		this.stimaCapannone2numCapi = rs.getString("stima_capannone_2_num_capi");

		this.stimaCapannone3num = rs.getString("stima_capannone_3_num");
		this.stimaCapannone3numCapi = rs.getString("stima_capannone_3_num_capi");
		
		this.dataPrimoControllo = rs.getString("data_primo_controllo");
		this.capacitaMassima = rs.getString("capacita_massima");

		this.faseProduttiva = rs.getString("fase_produttiva");

		}




	public String getVeterinarioAziendale() {
		return veterinarioAziendale;
	}




	public void setVeterinarioAziendale(String veterinarioAziendale) {
		this.veterinarioAziendale = veterinarioAziendale;
	}




	public String getNumTotaleCapannoni() {
		return numTotaleCapannoni;
	}




	public void setNumTotaleCapannoni(String numTotaleCapannoni) {
		this.numTotaleCapannoni = numTotaleCapannoni;
	}




	public String getNumTotaleCapannoniAttivi() {
		return numTotaleCapannoniAttivi;
	}




	public void setNumTotaleCapannoniAttivi(String numTotaleCapannoniAttivi) {
		this.numTotaleCapannoniAttivi = numTotaleCapannoniAttivi;
	}




	public String getCapannone1num() {
		return capannone1num;
	}




	public void setCapannone1num(String capannone1num) {
		this.capannone1num = capannone1num;
	}




	public String getCapannone1capacita() {
		return capannone1capacita;
	}




	public void setCapannone1capacita(String capannone1capacita) {
		this.capannone1capacita = capannone1capacita;
	}




	public String getCapannone1data() {
		return capannone1data;
	}




	public void setCapannone1data(String capannone1data) {
		this.capannone1data = capannone1data;
	}




	public String getCapannone1accasati() {
		return capannone1accasati;
	}




	public void setCapannone1accasati(String capannone1accasati) {
		this.capannone1accasati = capannone1accasati;
	}




	public String getCapannone1presenti() {
		return capannone1presenti;
	}




	public void setCapannone1presenti(String capannone1presenti) {
		this.capannone1presenti = capannone1presenti;
	}




	public String getCapannone1ispezionato() {
		return capannone1ispezionato;
	}




	public void setCapannone1ispezionato(String capannone1ispezionato) {
		this.capannone1ispezionato = capannone1ispezionato;
	}




	public String getCapannone2num() {
		return capannone2num;
	}




	public void setCapannone2num(String capannone2num) {
		this.capannone2num = capannone2num;
	}




	public String getCapannone2capacita() {
		return capannone2capacita;
	}




	public void setCapannone2capacita(String capannone2capacita) {
		this.capannone2capacita = capannone2capacita;
	}




	public String getCapannone2data() {
		return capannone2data;
	}




	public void setCapannone2data(String capannone2data) {
		this.capannone2data = capannone2data;
	}




	public String getCapannone2accasati() {
		return capannone2accasati;
	}




	public void setCapannone2accasati(String capannone2accasati) {
		this.capannone2accasati = capannone2accasati;
	}




	public String getCapannone2presenti() {
		return capannone2presenti;
	}




	public void setCapannone2presenti(String capannone2presenti) {
		this.capannone2presenti = capannone2presenti;
	}




	public String getCapannone2ispezionato() {
		return capannone2ispezionato;
	}




	public void setCapannone2ispezionato(String capannone2ispezionato) {
		this.capannone2ispezionato = capannone2ispezionato;
	}




	public String getCapannone3num() {
		return capannone3num;
	}




	public void setCapannone3num(String capannone3num) {
		this.capannone3num = capannone3num;
	}




	public String getCapannone3capacita() {
		return capannone3capacita;
	}




	public void setCapannone3capacita(String capannone3capacita) {
		this.capannone3capacita = capannone3capacita;
	}




	public String getCapannone3data() {
		return capannone3data;
	}




	public void setCapannone3data(String capannone3data) {
		this.capannone3data = capannone3data;
	}




	public String getCapannone3accasati() {
		return capannone3accasati;
	}




	public void setCapannone3accasati(String capannone3accasati) {
		this.capannone3accasati = capannone3accasati;
	}




	public String getCapannone3presenti() {
		return capannone3presenti;
	}




	public void setCapannone3presenti(String capannone3presenti) {
		this.capannone3presenti = capannone3presenti;
	}




	public String getCapannone3ispezionato() {
		return capannone3ispezionato;
	}




	public void setCapannone3ispezionato(String capannone3ispezionato) {
		this.capannone3ispezionato = capannone3ispezionato;
	}




	public String getCapannone4num() {
		return capannone4num;
	}




	public void setCapannone4num(String capannone4num) {
		this.capannone4num = capannone4num;
	}




	public String getCapannone4ispezionato() {
		return capannone4ispezionato;
	}




	public void setCapannone4ispezionato(String capannone4ispezionato) {
		this.capannone4ispezionato = capannone4ispezionato;
	}




	public String getCapannone5num() {
		return capannone5num;
	}




	public void setCapannone5num(String capannone5num) {
		this.capannone5num = capannone5num;
	}




	public String getCapannone5ispezionato() {
		return capannone5ispezionato;
	}




	public void setCapannone5ispezionato(String capannone5ispezionato) {
		this.capannone5ispezionato = capannone5ispezionato;
	}




	public String getIbridoRazzaAllevata() {
		return ibridoRazzaAllevata;
	}




	public void setIbridoRazzaAllevata(String ibridoRazzaAllevata) {
		this.ibridoRazzaAllevata = ibridoRazzaAllevata;
	}




	public String getStimaCapannone1num() {
		return stimaCapannone1num;
	}




	public void setStimaCapannone1num(String stimaCapannone1num) {
		this.stimaCapannone1num = stimaCapannone1num;
	}




	public String getStimaCapannone1numCapi() {
		return stimaCapannone1numCapi;
	}




	public void setStimaCapannone1numCapi(String stimaCapannone1numCapi) {
		this.stimaCapannone1numCapi = stimaCapannone1numCapi;
	}




	public String getStimaCapannone2num() {
		return stimaCapannone2num;
	}




	public void setStimaCapannone2num(String stimaCapannone2num) {
		this.stimaCapannone2num = stimaCapannone2num;
	}




	public String getStimaCapannone2numCapi() {
		return stimaCapannone2numCapi;
	}




	public void setStimaCapannone2numCapi(String stimaCapannone2numCapi) {
		this.stimaCapannone2numCapi = stimaCapannone2numCapi;
	}




	public String getStimaCapannone3num() {
		return stimaCapannone3num;
	}




	public void setStimaCapannone3num(String stimaCapannone3num) {
		this.stimaCapannone3num = stimaCapannone3num;
	}




	public String getStimaCapannone3numCapi() {
		return stimaCapannone3numCapi;
	}




	public void setStimaCapannone3numCapi(String stimaCapannone3numCapi) {
		this.stimaCapannone3numCapi = stimaCapannone3numCapi;
	}




	public String getDataPrimoControllo() { 
		return dataPrimoControllo;
	}




	public void setDataPrimoControllo(String dataPrimoControllo) {
		this.dataPrimoControllo = dataPrimoControllo;
	}




	public String getCapacitaMassima() { 
		return capacitaMassima;
	}




	public void setCapacitaMassima(String capacitaMassima) {
		this.capacitaMassima = capacitaMassima;
	}




	public String getFaseProduttiva() {
		return faseProduttiva;
	}




	public void setFaseProduttiva(String faseProduttiva) {
		this.faseProduttiva = faseProduttiva;
	}



	
	
	
}