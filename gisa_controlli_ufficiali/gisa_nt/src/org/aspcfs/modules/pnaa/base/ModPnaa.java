package org.aspcfs.modules.pnaa.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.aspcfs.utils.DatabaseUtils;
import org.json.JSONObject;

import com.darkhorseventures.framework.actions.ActionContext;

public class ModPnaa{
	
	private int id = -1;
	private Timestamp entered = null;
	private int enteredBy = -1;
	
	//campione
	private int idCampione = -1;
	private String campioneMotivazione = null;
	private Timestamp campioneData = null;
	private String campioneVerbale= null;
	private String campioneCodicePreaccettazione = null;
	private String campioneAsl = null;
	private String campionePerContoDi = null;
	private String campioneAnno = null;
	private String campioneMese  = null;
	private String campioneGiorno  = null;
	private String campioneOre  = null;
	private String campionePresente  = null;
	private String campioneSottoscritto  = null;
	private String campioneNumPrelevati  = null;
	
	private String campioneMangime = null;
	private String campioneSottoprodotti = null;
	
	private String campioneCodiceEsame = null;
	private String campioneCodiceOsa = null;
	private String campioneListaCodiceMatrice = "";
	
	private String campioneCodiceSinvsa = null;
	
	//pnaa
	private String numeroScheda = null;
	
	//PNAA A
	private int idDpa = -1;
	private int idStrategiaCampionamento = -1;
	private int idMetodoCampionamento = -1;
	private int idProgrammaControllo = -1;
	private int idPrincipiAdditivi = -1;
	private int idPrincipiAdditiviCO = -1;
	private String quantitaPa = null;
	private int idContaminanti = -1;
	private String prelevatore = null;
	private int idLuogoPrelievo = -1;
	private String codiceLuogoPrelievo = null;
	private String targaMezzo = null;
	private String indirizzoLuogoPrelievo = null;
	private String comuneLuogoPrelievo = null;
	private String provinciaLuogoPrelievo = null;
	private String latLuogoPrelievo = null;
	private String lonLuogoPrelievo = null;
	private String ragioneSociale = null;
	private String codiceFiscale = null;
	private String rappresentanteLegale = null;
	private String detentore = null;
	private String telefono = null;
	private String micotossineSpecifica = null;
	private String additiviNutrizionaliSpecifica = null;
	private String altroSpecifica = null;
	private String programmaControlloFASpecifica = null;
	private String programmaControlloANSpecifica = null;
	private String programmaControlloCISpecifica = null;
	private String programmaControlloATSpecifica = null;
	private String programmaControlloAOSpecifica = null;
	private String programmaControlloAZSpecifica = null;
	private String programmaControlloCOFASpecifica = null;
	private String programmaControlloCOCISpecifica = null;
	private String programmaControlloINCISpecifica = null;
	private String programmaControlloINRASpecifica = null;
	private String programmaControlloINPESpecifica = null;
	
	private String aliquotaConoscitivaCromo = null;
	private String aliquotaConoscitivaMicotossine = null;
	private String aliquotaConoscitivaNitrati = null;
	private String aliquotaConoscitivaRadionuclidi = null;
	
	private int idMicotossineTipo = -1;
	
	//PNAA B
	private int idCategoriaSottoprodotti = -1;
	private String trattamentoMangime = null;
	private int idConfezionamento = -1;
	private String ragioneSocialeDittaProduttrice = null;
	private String indirizzoDittaProduttrice = null;
	private String nomeCommercialeMangime = null;
	private String responsabileEtichettatura = null;
	private String indirizzoResponsabileEtichettatura = null;
	private String paeseProduzione = null;
	private String dataProduzione = null;
	private String dataScadenza = null;
	private String numLotto = null;
	private String dimensioneLotto = null;
	private String dimensionePorzione = null;
	private String ingredienti = null;
	private String commentiMangimePrelevato = null;
	
	private int idMatriceCampione = -1;
	private String mangimeSempliceSpecifica = null;
	private int idMangimeComposto = -1;
	private int idPremiscelaAdditivi = -1;
	private int idMetodoProduzione = -1;
	private String listaSpecieVegetaleDichiarata = "";
	private String listaSpecieAlimentoDestinato = "";
	private String listaStatoProdottoPrelievo = "";

	//PNAA C
	
	private String laboratorioDestinazione = null;

	//PNAA D
	
	private int idAllegaCartellino= -1;
	private String descrizioneAttrezzature= null;
	private String numPunti= null;
	private String numCE= null;
	private String volume= null;
	private String operazioni= null;
	private String volume2= null;
	private String volume3= null;
	private String operazioni2= null;
	private String numeroCF= null;
	private String quantitaGML= null;
	
	private String cf1Peso = null;
	private String cf1Sigillo = null;
	private String cf2Peso = null;
	private String cf2Sigillo = null;
	private String cf3Peso = null;
	private String cf3Sigillo = null;
	private String cf4Peso = null;
	private String cf4Sigillo = null;
	private String cf5Peso = null;
	private String cf5Sigillo = null;
	private String cfUlteriore = null;
	private String cfUlteriorePeso = null;
	private String cfUlterioreRicerca = null;
	
	private String dichiarazione= null;
	private String conservazioneCampione= null;
	private String numCopie= null;
	private String numCampioniFinali= null;
	private String custode= null;
	private int idRinunciaCampione= -1;
	private int idCampioneFinale= -1;
	private String numCampioniFinaliInvio = null;
	private String numCopieInvio = null;
	private String destinazioneInvio = null;
	private String dataInvio = null;
	
	private int idCgRidotto = -1;
	private int idCgCr = -1;
	private int idSequestroPartita = -1;
	
	private boolean bozza;
	
	//Flusso 358
	
	private String numAliquoteCF;
	private String numUnitaCampionarie;
	private String pesoUnitaCampionaria;
	private String dataInizioAnalisi;
	private String oraInizioAnalisi;

	public ModPnaa() {
 
	}
	
	public ModPnaa(ResultSet rs, Connection db) throws SQLException {
		buildRecord(rs, db);
		} 
	
	public ModPnaa(Connection db, int idCampione) throws SQLException {
		PreparedStatement pst = db.prepareStatement("select * from get_modello_pnaa(?)");
		pst.setInt(1, idCampione);
		ResultSet rs = DatabaseUtils.executeQuery(db, pst); 
		 while (rs.next()){
				 buildRecord(rs, db);
	}
	}

	private void buildRecord(ResultSet rs, Connection db) throws SQLException {
		
		this.id = rs.getInt("id");
		this.enteredBy = rs.getInt("enteredby");
		this.entered = rs.getTimestamp("entered");
			
		this.idCampione = rs.getInt("id_campione");
		this.campioneMotivazione = rs.getString("campione_motivazione");
		this.campioneData = rs.getTimestamp("campione_data");
		this.campioneVerbale = rs.getString("campione_verbale");
		this.campioneCodicePreaccettazione = rs.getString("campione_codice_preaccettazione");
		this.campioneAsl = rs.getString("campione_asl");
		this.campionePerContoDi = rs.getString("campione_percontodi");
		this.campioneAnno = rs.getString("campione_anno");
		this.campioneMese  = rs.getString("campione_mese");
		this.campioneGiorno  = rs.getString("campione_giorno");
		this.campioneOre  = rs.getString("campione_ore");
		this.campionePresente  = rs.getString("campione_presente");
		this.campioneSottoscritto  = rs.getString("campione_sottoscritto");
		this.campioneNumPrelevati  = rs.getString("campione_num_prelevati");
		try {this.campioneMangime = rs.getString("campione_mangime"); } catch (Exception e){}
		try {this.campioneSottoprodotti = rs.getString("campione_sottoprodotti"); } catch (Exception e){}

		this.campioneCodiceEsame  = rs.getString("codice_esame");
		this.campioneCodiceOsa  = rs.getString("codice_osa");
		this.campioneListaCodiceMatrice  = rs.getString("lista_codice_matrice"); 
		
		this.campioneCodiceSinvsa = rs.getString("codice_sinvsa");

		this.numeroScheda = rs.getString("numero_scheda");
		this.idDpa = rs.getInt("id_dpa");
		this.idStrategiaCampionamento = rs.getInt("id_strategia_campionamento");
		
		this.idMetodoCampionamento = rs.getInt("id_metodo_campionamento");
		this.idProgrammaControllo = rs.getInt("id_programma_controllo");
		this.idPrincipiAdditivi = rs.getInt("id_principi_additivi");
		this.idPrincipiAdditiviCO = rs.getInt("id_principi_additivi_co");
		this.quantitaPa = rs.getString("quantita_pa");
		this.idContaminanti = rs.getInt("id_contaminanti");
		this.prelevatore = rs.getString("prelevatore");
		this.idLuogoPrelievo = rs.getInt("id_luogo_prelievo");
		this.codiceLuogoPrelievo = rs.getString("codice_luogo_prelievo");
		this.targaMezzo = rs.getString("targa_mezzo");
		this.indirizzoLuogoPrelievo = rs.getString("indirizzo_luogo_prelievo");
		this.comuneLuogoPrelievo = rs.getString("comune_luogo_prelievo");
		this.provinciaLuogoPrelievo = rs.getString("provincia_luogo_prelievo");
		this.latLuogoPrelievo = rs.getString("lat_luogo_prelievo");
		this.lonLuogoPrelievo = rs.getString("lon_luogo_prelievo");
		this.ragioneSociale = rs.getString("ragione_sociale");
		this.codiceFiscale = rs.getString("codice_fiscale");
		this.rappresentanteLegale = rs.getString("rappresentante_legale");
		this.detentore = rs.getString("detentore");
		this.telefono = rs.getString("telefono");
		this.micotossineSpecifica = rs.getString("micotossine_specifica");

		try {this.additiviNutrizionaliSpecifica = rs.getString("additivi_nutrizionali_specifica"); } catch (Exception e){}

		this.altroSpecifica = rs.getString("altro_specifica");
		this.programmaControlloFASpecifica = rs.getString("programma_controllo_fa_specifica");
		this.programmaControlloANSpecifica = rs.getString("programma_controllo_an_specifica");
		this.programmaControlloCISpecifica = rs.getString("programma_controllo_ci_specifica");
		this.programmaControlloATSpecifica = rs.getString("programma_controllo_at_specifica");
		this.programmaControlloAOSpecifica = rs.getString("programma_controllo_ao_specifica");
		this.programmaControlloAZSpecifica = rs.getString("programma_controllo_az_specifica");
		this.programmaControlloCOFASpecifica = rs.getString("programma_controllo_co_fa_specifica");
		this.programmaControlloCOCISpecifica = rs.getString("programma_controllo_co_ci_specifica");
		this.programmaControlloINCISpecifica = rs.getString("programma_controllo_in_ci_specifica");
		this.programmaControlloINRASpecifica = rs.getString("programma_controllo_in_ra_specifica");
		this.programmaControlloINPESpecifica = rs.getString("programma_controllo_in_pe_specifica");
		
		this.aliquotaConoscitivaCromo = rs.getString("aliquota_conoscitiva_cromo");
		this.aliquotaConoscitivaMicotossine = rs.getString("aliquota_conoscitiva_micotossine");
		this.aliquotaConoscitivaNitrati = rs.getString("aliquota_conoscitiva_nitrati");
		this.aliquotaConoscitivaRadionuclidi = rs.getString("aliquota_conoscitiva_radionuclidi");

		this.idMicotossineTipo = rs.getInt("id_micotossine_tipo");

		this.idCategoriaSottoprodotti = rs.getInt("id_categoria_sottoprodotti");
		this.trattamentoMangime = rs.getString("trattamento_mangime");
		this.idConfezionamento = rs.getInt("id_confezionamento");
		this.ragioneSocialeDittaProduttrice = rs.getString("ragione_sociale_ditta_produttrice"); 
		this.indirizzoDittaProduttrice = rs.getString("indirizzo_ditta_produttrice");
		this.nomeCommercialeMangime = rs.getString("nome_commerciale_mangime");
		this.responsabileEtichettatura = rs.getString("responsabile_etichettatura");
		this.indirizzoResponsabileEtichettatura = rs.getString("indirizzo_responsabile_etichettatura");
		this.paeseProduzione = rs.getString("paese_produzione");
		this.dataProduzione = rs.getString("data_produzione");
		this.dataScadenza = rs.getString("data_scadenza");
		this.numLotto = rs.getString("num_lotto");
		this.dimensioneLotto = rs.getString("dimensione_lotto");
		try {this.dimensionePorzione = rs.getString("dimensione_porzione"); } catch (Exception e){}

		this.ingredienti = rs.getString("ingredienti");
		this.commentiMangimePrelevato = rs.getString("commenti_mangime_prelevato");
		
		this.idMatriceCampione = rs.getInt("id_matrice_campione");
		this.mangimeSempliceSpecifica = rs.getString("mangime_semplice_specifica");
		this.idMangimeComposto = rs.getInt("id_mangime_composto");
		this.idPremiscelaAdditivi = rs.getInt("id_premiscela_additivi");
		this.idMetodoProduzione = rs.getInt("id_metodo_produzione");
		this.listaSpecieVegetaleDichiarata = rs.getString("lista_specie_vegetale_dichiarata"); 
		this.listaSpecieAlimentoDestinato = rs.getString("lista_specie_alimento_destinato");
		this.listaStatoProdottoPrelievo = rs.getString("lista_stato_prodotto_prelievo");
		
		this.laboratorioDestinazione = rs.getString("laboratorio_destinazione");
		
		this.idAllegaCartellino= rs.getInt("id_allega_cartellino");
		this.descrizioneAttrezzature= rs.getString("descrizione_attrezzature");
		this.numPunti= rs.getString("num_punti");
		this.numCE= rs.getString("num_ce");
		this.volume= rs.getString("volume");
		this.operazioni= rs.getString("operazioni");
		this.volume2= rs.getString("volume_2");
		this.volume3= rs.getString("volume_3");
		this.operazioni2= rs.getString("operazioni_2");
		this.numeroCF= rs.getString("numero_cf");
		this.quantitaGML= rs.getString("quantita_gml");
		
		try {this.cf1Peso = rs.getString("cf1_peso"); } catch (Exception e){}
		try {this.cf1Sigillo = rs.getString("cf1_sigillo"); } catch (Exception e){}
		try {this.cf2Peso = rs.getString("cf2_peso"); } catch (Exception e){}
		try {this.cf2Sigillo = rs.getString("cf2_sigillo"); } catch (Exception e){}
		try {this.cf3Peso = rs.getString("cf3_peso"); } catch (Exception e){}
		try {this.cf3Sigillo = rs.getString("cf3_sigillo"); } catch (Exception e){}
		try {this.cf4Peso = rs.getString("cf4_peso"); } catch (Exception e){}
		try {this.cf4Sigillo = rs.getString("cf4_sigillo"); } catch (Exception e){}
		try {this.cf5Peso = rs.getString("cf5_peso"); } catch (Exception e){}
		try {this.cf5Sigillo = rs.getString("cf5_sigillo"); } catch (Exception e){}
		try {this.cfUlteriore = rs.getString("cf_ulteriore"); } catch (Exception e){}
		try {this.cfUlteriorePeso = rs.getString("cf_ulteriore_peso"); } catch (Exception e){}
		try {this.cfUlterioreRicerca = rs.getString("cf_ulteriore_ricerca"); } catch (Exception e){}
		
		this.dichiarazione= rs.getString("dichiarazione");
		this.conservazioneCampione= rs.getString("conservazione_campione");
		this.numCopie= rs.getString("num_copie");
		this.numCampioniFinali= rs.getString("num_campioni_finali");
		this.custode= rs.getString("custode");
		this.idRinunciaCampione= rs.getInt("id_rinuncia_campione");
		this.idCampioneFinale= rs.getInt("id_campione_finale");
		this.numCampioniFinaliInvio= rs.getString("num_campioni_finali_invio");
		this.numCopieInvio= rs.getString("num_copie_invio");
		this.destinazioneInvio= rs.getString("destinazione_invio");
		this.dataInvio= rs.getString("data_invio");
		this.idCgRidotto = rs.getInt("id_cg_ridotto");
		this.idCgCr = rs.getInt("id_cg_cr");
		this.idSequestroPartita = rs.getInt("id_sequestro_Partita");
		this.bozza = rs.getBoolean("bozza");
		
		//Flusso 358
		this.numAliquoteCF = rs.getString("num_aliquote_cf");
		this.numUnitaCampionarie = rs.getString("num_unita_campionarie");
		this.pesoUnitaCampionaria = rs.getString("peso_unita_campionaria");
		this.dataInizioAnalisi = rs.getString("data_inizio_analisi");
		this.oraInizioAnalisi = rs.getString("ora_inizio_analisi");
	}

		
	public void buildDaRequest(ActionContext context) {
	
		try { this.campioneOre  = context.getRequest().getParameter("ore"); } catch (Exception e) {}
		try { this.campionePresente  = context.getRequest().getParameter("campionePresente"); } catch (Exception e) {}
		try { this.campioneMangime  = context.getRequest().getParameter("campioneMangime"); } catch (Exception e) {}
		try { this.campioneSottoprodotti  = context.getRequest().getParameter("campioneSottoprodotti"); } catch (Exception e) {}
		try { this.additiviNutrizionaliSpecifica  = context.getRequest().getParameter("additiviNutrizionaliSpecifica"); } catch (Exception e) {}
		try { this.dimensionePorzione  = context.getRequest().getParameter("dimensionePorzione"); } catch (Exception e) {}

		try { this.cf1Peso  = context.getRequest().getParameter("cf1peso"); } catch (Exception e) {}
		try { this.cf1Sigillo  = context.getRequest().getParameter("cf1sigillo"); } catch (Exception e) {}
		try { this.cf2Peso  = context.getRequest().getParameter("cf2peso"); } catch (Exception e) {}
		try { this.cf2Sigillo  = context.getRequest().getParameter("cf2sigillo"); } catch (Exception e) {}
		try { this.cf3Peso  = context.getRequest().getParameter("cf3peso"); } catch (Exception e) {}
		try { this.cf3Sigillo  = context.getRequest().getParameter("cf3sigillo"); } catch (Exception e) {}
		try { this.cf4Peso  = context.getRequest().getParameter("cf4peso"); } catch (Exception e) {}
		try { this.cf4Sigillo  = context.getRequest().getParameter("cf4sigillo"); } catch (Exception e) {}
		try { this.cf5Peso  = context.getRequest().getParameter("cf5peso"); } catch (Exception e) {}
		try { this.cf5Sigillo  = context.getRequest().getParameter("cf5sigillo"); } catch (Exception e) {}
		try { this.cfUlteriore = context.getRequest().getParameter("cfulteriore"); } catch (Exception e) {}
		try { this.cfUlteriorePeso = context.getRequest().getParameter("cfulteriorepeso"); } catch (Exception e) {}
		try { this.cfUlterioreRicerca = context.getRequest().getParameter("cfulteriorericerca"); } catch (Exception e) {}
		
		try { this.campioneNumPrelevati  = context.getRequest().getParameter("numPrelevati"); } catch (Exception e) {}

		try { this.idDpa = Integer.parseInt(context.getRequest().getParameter("dpa")); } catch (Exception e) {}
		try { this.idMetodoCampionamento = Integer.parseInt(context.getRequest().getParameter("metodoCampionamento")); } catch (Exception e) {}

		try { this.idPrincipiAdditivi = Integer.parseInt(context.getRequest().getParameter("principiAdditivi")); } catch (Exception e) {}
		try { this.idPrincipiAdditiviCO = Integer.parseInt(context.getRequest().getParameter("principiAdditiviCO")); } catch (Exception e) {}
		try { this.quantitaPa = context.getRequest().getParameter("quantitaPa"); } catch (Exception e) {}
		try { this.idContaminanti = Integer.parseInt(context.getRequest().getParameter("contaminanti")); } catch (Exception e) {}
		try { this.idLuogoPrelievo = Integer.parseInt(context.getRequest().getParameter("luogoPrelievo")); } catch (Exception e) {}
		try { this.codiceLuogoPrelievo = context.getRequest().getParameter("codiceLuogoPrelievo"); } catch (Exception e) {}
		try { this.targaMezzo = context.getRequest().getParameter("targaMezzo"); } catch (Exception e) {}
		try { this.indirizzoLuogoPrelievo = context.getRequest().getParameter("indirizzoLuogoPrelievo"); } catch (Exception e) {}
		try { this.comuneLuogoPrelievo = context.getRequest().getParameter("comuneLuogoPrelievo"); } catch (Exception e) {}
		try { this.provinciaLuogoPrelievo = context.getRequest().getParameter("provinciaLuogoPrelievo"); } catch (Exception e) {}
		try { this.latLuogoPrelievo = context.getRequest().getParameter("latLuogoPrelievo"); } catch (Exception e) {}
		try { this.lonLuogoPrelievo = context.getRequest().getParameter("lonLuogoPrelievo"); } catch (Exception e) {}
		try { this.ragioneSociale = context.getRequest().getParameter("ragioneSociale"); } catch (Exception e) {}
		try { this.codiceFiscale = context.getRequest().getParameter("codiceFiscale"); } catch (Exception e) {}
		try { this.rappresentanteLegale = context.getRequest().getParameter("rappresentanteLegale"); } catch (Exception e) {}
		try { this.detentore = context.getRequest().getParameter("detentore"); } catch (Exception e) {}
		try { this.telefono = context.getRequest().getParameter("telefono"); } catch (Exception e) {}
		try { this.micotossineSpecifica = context.getRequest().getParameter("micotossineSpecifica"); } catch (Exception e) {}
		try { this.altroSpecifica = context.getRequest().getParameter("altroSpecifica"); } catch (Exception e) {}
		try { this.programmaControlloFASpecifica = context.getRequest().getParameter("programmaControlloFASpecifica"); } catch (Exception e) {}
		try { this.programmaControlloANSpecifica = context.getRequest().getParameter("programmaControlloANSpecifica"); } catch (Exception e) {}
		try { this.programmaControlloCISpecifica = context.getRequest().getParameter("programmaControlloCISpecifica"); } catch (Exception e) {}
		try { this.programmaControlloATSpecifica = context.getRequest().getParameter("programmaControlloATSpecifica"); } catch (Exception e) {}
		try { this.programmaControlloAOSpecifica = context.getRequest().getParameter("programmaControlloAOSpecifica"); } catch (Exception e) {}
		try { this.programmaControlloAZSpecifica = context.getRequest().getParameter("programmaControlloAZSpecifica"); } catch (Exception e) {}
		try { this.programmaControlloCOFASpecifica = context.getRequest().getParameter("programmaControlloCOFASpecifica"); } catch (Exception e) {}
		try { this.programmaControlloCOCISpecifica = context.getRequest().getParameter("programmaControlloCOCISpecifica"); } catch (Exception e) {}
		try { this.programmaControlloINCISpecifica = context.getRequest().getParameter("programmaControlloINCISpecifica"); } catch (Exception e) {}
		try { this.programmaControlloINRASpecifica = context.getRequest().getParameter("programmaControlloINRASpecifica"); } catch (Exception e) {}
		try { this.programmaControlloINPESpecifica = context.getRequest().getParameter("programmaControlloINPESpecifica"); } catch (Exception e) {}
		
		try { this.aliquotaConoscitivaCromo = context.getRequest().getParameter("conoscitivoCromo"); } catch (Exception e) {} 
		try { this.aliquotaConoscitivaMicotossine = context.getRequest().getParameter("conoscitivoMicotossine"); } catch (Exception e) {}
		try { this.aliquotaConoscitivaNitrati = context.getRequest().getParameter("conoscitivoNitrati"); } catch (Exception e) {}
		try { this.aliquotaConoscitivaRadionuclidi = context.getRequest().getParameter("conoscitivoRadionuclidi"); } catch (Exception e) {}
		
		try { this.idMicotossineTipo = Integer.parseInt(context.getRequest().getParameter("idMicotossineTipo")); } catch (Exception e) {}

		try { this.idCategoriaSottoprodotti = Integer.parseInt(context.getRequest().getParameter("categoriaSottoprodotti")); } catch (Exception e) {}
		try { this.trattamentoMangime = context.getRequest().getParameter("trattamentoMangime"); } catch (Exception e) {}
		try { this.idConfezionamento = Integer.parseInt(context.getRequest().getParameter("confezionamento")); } catch (Exception e) {}
		try { this.ragioneSocialeDittaProduttrice = context.getRequest().getParameter("ragioneSocialeDittaProduttrice"); } catch (Exception e) {} 
		try { this.indirizzoDittaProduttrice = context.getRequest().getParameter("indirizzoDittaProduttrice"); } catch (Exception e) {}
		try { this.nomeCommercialeMangime = context.getRequest().getParameter("nomeCommercialeMangime"); } catch (Exception e) {}
		try { this.responsabileEtichettatura = context.getRequest().getParameter("responsabileEtichettatura"); } catch (Exception e) {}
		try { this.indirizzoResponsabileEtichettatura = context.getRequest().getParameter("indirizzoResponsabileEtichettatura"); } catch (Exception e) {}
		try { this.paeseProduzione = context.getRequest().getParameter("paeseProduzione"); } catch (Exception e) {}
		try { this.dataProduzione = context.getRequest().getParameter("dataProduzione"); } catch (Exception e) {}
		try { this.dataScadenza = context.getRequest().getParameter("dataScadenza"); } catch (Exception e) {}
		try { this.numLotto = context.getRequest().getParameter("numLotto"); } catch (Exception e) {}
		try { this.dimensioneLotto = context.getRequest().getParameter("dimensioneLotto"); } catch (Exception e) {}
		try { this.ingredienti = context.getRequest().getParameter("ingredienti"); } catch (Exception e) {}
		try { this.commentiMangimePrelevato = context.getRequest().getParameter("commentiMangimePrelevato"); } catch (Exception e) {}
		
		try { this.idMatriceCampione = Integer.parseInt(context.getRequest().getParameter("matriceCampione")); } catch (Exception e) {}
		try { this.mangimeSempliceSpecifica = context.getRequest().getParameter("mangimeSempliceSpecifica"); } catch (Exception e) {}
		try { this.idMangimeComposto = Integer.parseInt(context.getRequest().getParameter("mangimeComposto")); } catch (Exception e) {}
		try { this.idPremiscelaAdditivi = Integer.parseInt(context.getRequest().getParameter("premiscelaAdditivi")); } catch (Exception e) {}
		try { this.idMetodoProduzione = Integer.parseInt(context.getRequest().getParameter("metodoProduzione")); } catch (Exception e) {}
		
		for (int i = 0; i<50; i++)
			try { if (context.getRequest().getParameter("specieVegetaleDichiarata"+i)!=null){ this.listaSpecieVegetaleDichiarata = this.listaSpecieVegetaleDichiarata + context.getRequest().getParameter("specieVegetaleDichiarata"+i)+",";} } catch (Exception e) {}
		for (int i = 0; i<50; i++)
			try { if (context.getRequest().getParameter("specieAlimentoDestinato"+i)!=null){ this.listaSpecieAlimentoDestinato = this.listaSpecieAlimentoDestinato + context.getRequest().getParameter("specieAlimentoDestinato"+i)+",";} } catch (Exception e) {}
		for (int i = 0; i<50; i++)
			try { if (context.getRequest().getParameter("statoProdottoPrelievo"+i)!=null){ this.listaStatoProdottoPrelievo = this.listaStatoProdottoPrelievo + context.getRequest().getParameter("statoProdottoPrelievo"+i)+",";} } catch (Exception e) {}
			
		try { this.laboratorioDestinazione = context.getRequest().getParameter("laboratorioDestinazione"); } catch (Exception e) {}
		
		try { this.idAllegaCartellino= Integer.parseInt(context.getRequest().getParameter("allegaCartellino")); } catch (Exception e) {}
		try { this.descrizioneAttrezzature= context.getRequest().getParameter("descrizioneAttrezzature"); } catch (Exception e) {}
		try { this.numPunti= context.getRequest().getParameter("numPunti"); } catch (Exception e) {}
		try { this.numCE= context.getRequest().getParameter("numCE"); } catch (Exception e) {}
		try { this.volume= context.getRequest().getParameter("volume"); } catch (Exception e) {}
		try { this.operazioni= context.getRequest().getParameter("operazioni"); } catch (Exception e) {}
		try { this.volume2= context.getRequest().getParameter("volume2"); } catch (Exception e) {}
		try { this.volume3= context.getRequest().getParameter("volume3"); } catch (Exception e) {}
		try { this.operazioni2= context.getRequest().getParameter("operazioni2"); } catch (Exception e) {}
		try { this.numeroCF= context.getRequest().getParameter("numeroCF"); } catch (Exception e) {}
		try { this.quantitaGML= context.getRequest().getParameter("quantitaGML"); } catch (Exception e) {}
		try { this.dichiarazione= context.getRequest().getParameter("dichiarazione"); } catch (Exception e) {}
		try { this.conservazioneCampione= context.getRequest().getParameter("conservazioneCampione"); } catch (Exception e) {}
		try { this.numCopie= context.getRequest().getParameter("numCopie"); } catch (Exception e) {}
		try { this.numCampioniFinali= context.getRequest().getParameter("numCampioniFinali"); } catch (Exception e) {}
		try { this.custode= context.getRequest().getParameter("custode"); } catch (Exception e) {}
		try { this.idRinunciaCampione= Integer.parseInt(context.getRequest().getParameter("rinunciaCampione")); } catch (Exception e) {}
		try { this.idCampioneFinale= Integer.parseInt(context.getRequest().getParameter("campioneFinale")); } catch (Exception e) {}
		try { this.numCampioniFinaliInvio= context.getRequest().getParameter("numCampioniFinaliInvio"); } catch (Exception e) {}
		try { this.numCopieInvio= context.getRequest().getParameter("numCopieInvio"); } catch (Exception e) {}
		try { this.destinazioneInvio= context.getRequest().getParameter("destinazioneInvio"); } catch (Exception e) {}
		try { this.dataInvio= context.getRequest().getParameter("dataInvio"); } catch (Exception e) {}
		try { this.idCgRidotto = Integer.parseInt(context.getRequest().getParameter("cgRidotto")); } catch (Exception e) {}
		try { this.idCgCr = Integer.parseInt(context.getRequest().getParameter("cgCr")); } catch (Exception e) {}
		try { this.idSequestroPartita = Integer.parseInt(context.getRequest().getParameter("sequestroPartita")); } catch (Exception e) {}
		try { this.bozza = Boolean.parseBoolean(context.getRequest().getParameter("bozza")); } catch (Exception e) {}
		//Flusso 358
		try { this.numAliquoteCF = context.getRequest().getParameter("numAliquoteCF"); } catch (Exception e) {}
		try { this.numUnitaCampionarie = context.getRequest().getParameter("numUnitaCampionarie"); } catch (Exception e) {}
		try { this.pesoUnitaCampionaria = context.getRequest().getParameter("pesoUnitaCampionaria"); } catch (Exception e) {}
		try { this.dataInizioAnalisi = context.getRequest().getParameter("dataInizioAnalisi"); } catch (Exception e) {}
		try { this.oraInizioAnalisi = context.getRequest().getParameter("oraInizioAnalisi"); } catch (Exception e) {}
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Timestamp getEntered() {
		return entered;
	}

	public void setEntered(Timestamp entered) {
		this.entered = entered;
	}

	public int getEnteredBy() {
		return enteredBy;
	}

	public void setEnteredBy(int enteredBy) {
		this.enteredBy = enteredBy;
	}

	public int getIdCampione() {
		return idCampione;
	}

	public void setIdCampione(int idCampione) {
		this.idCampione = idCampione;
	}

	public String getCampioneMotivazione() {
		return campioneMotivazione;
	}

	public void setCampioneMotivazione(String campioneMotivazione) {
		this.campioneMotivazione = campioneMotivazione;
	}

	public Timestamp getCampioneData() {
		return campioneData;
	}

	public void setCampioneData(Timestamp campioneData) {
		this.campioneData = campioneData;
	}

	public String getCampioneVerbale() {
		return campioneVerbale;
	}

	public void setCampioneVerbale(String campioneVerbale) {
		this.campioneVerbale = campioneVerbale;
	}

	public String getCampioneCodicePreaccettazione() {
		return campioneCodicePreaccettazione;
	}

	public void setCampioneCodicePreaccettazione(String campioneCodicePreaccettazione) {
		this.campioneCodicePreaccettazione = campioneCodicePreaccettazione;
	}

	public String getCampioneAsl() {
		return campioneAsl;
	}

	public void setCampioneAsl(String campioneAsl) {
		this.campioneAsl = campioneAsl;
	}

	public String getCampionePerContoDi() {
		return campionePerContoDi;
	}

	public void setCampionePerContoDi(String campionePerContoDi) {
		this.campionePerContoDi = campionePerContoDi;
	}

	public String getCampioneAnno() {
		return campioneAnno;
	}

	public void setCampioneAnno(String campioneAnno) {
		this.campioneAnno = campioneAnno;
	}

	public String getCampioneMese() {
		return campioneMese;
	}

	public void setCampioneMese(String campioneMese) {
		this.campioneMese = campioneMese;
	}

	public String getCampioneGiorno() {
		return campioneGiorno;
	}

	public void setCampioneGiorno(String campioneGiorno) {
		this.campioneGiorno = campioneGiorno;
	}

	public String getCampioneOre() {
		return campioneOre;
	}

	public void setCampioneOre(String campioneOre) {
		this.campioneOre = campioneOre;
	}

	public String getCampionePresente() {
		return campionePresente;
	}

	public void setCampionePresente(String campionePresente) {
		this.campionePresente = campionePresente;
	}

	public String getCampioneSottoscritto() {
		return campioneSottoscritto;
	}

	public void setCampioneSottoscritto(String campioneSottoscritto) {
		this.campioneSottoscritto = campioneSottoscritto;
	}

	public String getCampioneNumPrelevati() {
		return campioneNumPrelevati;
	}

	public void setCampioneNumPrelevati(String campioneNumPrelevati) {
		this.campioneNumPrelevati = campioneNumPrelevati;
	}

	public String getNumeroScheda() {
		return numeroScheda;
	}

	public void setNumeroScheda(String numeroScheda) {
		this.numeroScheda = numeroScheda;
	}

	public int getIdDpa() {
		return idDpa;
	}

	public void setIdDpa(int idDpa) {
		this.idDpa = idDpa;
	}

	public int getIdStrategiaCampionamento() {
		return idStrategiaCampionamento;
	}

	public void setIdStrategiaCampionamento(int idStrategiaCampionamento) {
		this.idStrategiaCampionamento = idStrategiaCampionamento;
	}

	public int getIdMetodoCampionamento() {
		return idMetodoCampionamento;
	}

	public void setIdMetodoCampionamento(int idMetodoCampionamento) {
		this.idMetodoCampionamento = idMetodoCampionamento;
	}

	public int getIdProgrammaControllo() {
		return idProgrammaControllo;
	}

	public void setIdProgrammaControllo(int idProgrammaControllo) {
		this.idProgrammaControllo = idProgrammaControllo;
	}

	public int getIdPrincipiAdditivi() {
		return idPrincipiAdditivi;
	}

	public void setIdPrincipiAdditivi(int idPrincipiAdditivi) {
		this.idPrincipiAdditivi = idPrincipiAdditivi;
	}

	public int getIdPrincipiAdditiviCO() {
		return idPrincipiAdditiviCO;
	}

	public void setIdPrincipiAdditiviCO(int idPrincipiAdditiviCO) {
		this.idPrincipiAdditiviCO = idPrincipiAdditiviCO;
	}

	public String getQuantitaPa() {
		return quantitaPa;
	}

	public void setQuantitaPa(String quantitaPa) {
		this.quantitaPa = quantitaPa;
	}

	public int getIdContaminanti() {
		return idContaminanti;
	}

	public void setIdContaminanti(int idContaminanti) {
		this.idContaminanti = idContaminanti;
	}

	public String getPrelevatore() {
		return prelevatore;
	}

	public void setPrelevatore(String prelevatore) {
		this.prelevatore = prelevatore;
	}

	public int getIdLuogoPrelievo() {
		return idLuogoPrelievo;
	}

	public void setIdLuogoPrelievo(int idLuogoPrelievo) {
		this.idLuogoPrelievo = idLuogoPrelievo;
	}

	public String getCodiceLuogoPrelievo() {
		return codiceLuogoPrelievo;
	}

	public void setCodiceLuogoPrelievo(String codiceLuogoPrelievo) {
		this.codiceLuogoPrelievo = codiceLuogoPrelievo;
	}

	public String getTargaMezzo() {
		return targaMezzo;
	}

	public void setTargaMezzo(String targaMezzo) {
		this.targaMezzo = targaMezzo;
	}

	public String getIndirizzoLuogoPrelievo() {
		return indirizzoLuogoPrelievo;
	}

	public void setIndirizzoLuogoPrelievo(String indirizzoLuogoPrelievo) {
		this.indirizzoLuogoPrelievo = indirizzoLuogoPrelievo;
	}

	public String getComuneLuogoPrelievo() {
		return comuneLuogoPrelievo;
	}

	public void setComuneLuogoPrelievo(String comuneLuogoPrelievo) {
		this.comuneLuogoPrelievo = comuneLuogoPrelievo;
	}

	public String getProvinciaLuogoPrelievo() {
		return provinciaLuogoPrelievo;
	}

	public void setProvinciaLuogoPrelievo(String provinciaLuogoPrelievo) {
		this.provinciaLuogoPrelievo = provinciaLuogoPrelievo;
	}

	public String getLatLuogoPrelievo() {
		return latLuogoPrelievo;
	}

	public void setLatLuogoPrelievo(String latLuogoPrelievo) {
		this.latLuogoPrelievo = latLuogoPrelievo;
	}

	public String getLonLuogoPrelievo() {
		return lonLuogoPrelievo;
	}

	public void setLonLuogoPrelievo(String lonLuogoPrelievo) {
		this.lonLuogoPrelievo = lonLuogoPrelievo;
	}

	public String getRagioneSociale() {
		return ragioneSociale;
	}

	public void setRagioneSociale(String ragioneSociale) {
		this.ragioneSociale = ragioneSociale;
	}

	public String getCodiceFiscale() {
		return codiceFiscale;
	}

	public void setCodiceFiscale(String codiceFiscale) {
		this.codiceFiscale = codiceFiscale;
	}

	public String getRappresentanteLegale() {
		return rappresentanteLegale;
	}

	public void setRappresentanteLegale(String rappresentanteLegale) {
		this.rappresentanteLegale = rappresentanteLegale;
	}

	public String getDetentore() {
		return detentore;
	}

	public void setDetentore(String detentore) {
		this.detentore = detentore;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getMicotossineSpecifica() {
		return micotossineSpecifica;
	}

	public void setMicotossineSpecifica(String micotossineSpecifica) {
		this.micotossineSpecifica = micotossineSpecifica;
	}

	public String getAltroSpecifica() {
		return altroSpecifica;
	}

	public void setAltroSpecifica(String altroSpecifica) {
		this.altroSpecifica = altroSpecifica;
	}

	public String getProgrammaControlloFASpecifica() {
		return programmaControlloFASpecifica;
	}

	public void setProgrammaControlloFASpecifica(String programmaControlloFASpecifica) {
		this.programmaControlloFASpecifica = programmaControlloFASpecifica;
	}

	public String getProgrammaControlloANSpecifica() {
		return programmaControlloANSpecifica;
	}

	public void setProgrammaControlloANSpecifica(String programmaControlloANSpecifica) {
		this.programmaControlloANSpecifica = programmaControlloANSpecifica;
	}

	public String getProgrammaControlloCISpecifica() {
		return programmaControlloCISpecifica;
	}

	public void setProgrammaControlloCISpecifica(String programmaControlloCISpecifica) {
		this.programmaControlloCISpecifica = programmaControlloCISpecifica;
	}

	public String getProgrammaControlloATSpecifica() {
		return programmaControlloATSpecifica;
	}

	public void setProgrammaControlloATSpecifica(String programmaControlloATSpecifica) {
		this.programmaControlloATSpecifica = programmaControlloATSpecifica;
	}

	public String getProgrammaControlloAOSpecifica() {
		return programmaControlloAOSpecifica;
	}

	public void setProgrammaControlloAOSpecifica(String programmaControlloAOSpecifica) {
		this.programmaControlloAOSpecifica = programmaControlloAOSpecifica;
	}

	public String getProgrammaControlloAZSpecifica() {
		return programmaControlloAZSpecifica;
	}

	public void setProgrammaControlloAZSpecifica(String programmaControlloAZSpecifica) {
		this.programmaControlloAZSpecifica = programmaControlloAZSpecifica;
	}

	public String getProgrammaControlloCOFASpecifica() {
		return programmaControlloCOFASpecifica;
	}

	public void setProgrammaControlloCOFASpecifica(String programmaControlloCOFASpecifica) {
		this.programmaControlloCOFASpecifica = programmaControlloCOFASpecifica;
	}

	public String getProgrammaControlloCOCISpecifica() {
		return programmaControlloCOCISpecifica;
	}

	public void setProgrammaControlloCOCISpecifica(String programmaControlloCOCISpecifica) {
		this.programmaControlloCOCISpecifica = programmaControlloCOCISpecifica;
	}

	public String getProgrammaControlloINCISpecifica() {
		return programmaControlloINCISpecifica;
	}

	public void setProgrammaControlloINCISpecifica(String programmaControlloINCISpecifica) {
		this.programmaControlloINCISpecifica = programmaControlloINCISpecifica;
	}

	public String getProgrammaControlloINRASpecifica() {
		return programmaControlloINRASpecifica;
	}

	public void setProgrammaControlloINRASpecifica(String programmaControlloINRASpecifica) {
		this.programmaControlloINRASpecifica = programmaControlloINRASpecifica;
	}

	public String getProgrammaControlloINPESpecifica() {
		return programmaControlloINPESpecifica;
	}

	public void setProgrammaControlloINPESpecifica(String programmaControlloINPESpecifica) {
		this.programmaControlloINPESpecifica = programmaControlloINPESpecifica;
	}

	public String getTrattamentoMangime() {
		return trattamentoMangime;
	}

	public void setTrattamentoMangime(String trattamentoMangime) {
		this.trattamentoMangime = trattamentoMangime;
	}

	public int getIdConfezionamento() {
		return idConfezionamento;
	}

	public void setIdConfezionamento(int idConfezionamento) {
		this.idConfezionamento = idConfezionamento;
	}

	public String getRagioneSocialeDittaProduttrice() {
		return ragioneSocialeDittaProduttrice;
	}

	public void setRagioneSocialeDittaProduttrice(String ragioneSocialeDittaProduttrice) {
		this.ragioneSocialeDittaProduttrice = ragioneSocialeDittaProduttrice;
	}

	public String getIndirizzoDittaProduttrice() {
		return indirizzoDittaProduttrice;
	}

	public void setIndirizzoDittaProduttrice(String indirizzoDittaProduttrice) {
		this.indirizzoDittaProduttrice = indirizzoDittaProduttrice;
	}

	public String getNomeCommercialeMangime() {
		return nomeCommercialeMangime;
	}

	public void setNomeCommercialeMangime(String nomeCommercialeMangime) {
		this.nomeCommercialeMangime = nomeCommercialeMangime;
	}

	public String getResponsabileEtichettatura() {
		return responsabileEtichettatura;
	}

	public void setResponsabileEtichettatura(String responsabileEtichettatura) {
		this.responsabileEtichettatura = responsabileEtichettatura;
	}

	public String getIndirizzoResponsabileEtichettatura() {
		return indirizzoResponsabileEtichettatura;
	}

	public void setIndirizzoResponsabileEtichettatura(String indirizzoResponsabileEtichettatura) {
		this.indirizzoResponsabileEtichettatura = indirizzoResponsabileEtichettatura;
	}

	public String getPaeseProduzione() {
		return paeseProduzione;
	}

	public void setPaeseProduzione(String paeseProduzione) {
		this.paeseProduzione = paeseProduzione;
	}

	public String getDataProduzione() {
		return dataProduzione;
	}

	public void setDataProduzione(String dataProduzione) {
		this.dataProduzione = dataProduzione;
	}

	public String getDataScadenza() {
		return dataScadenza;
	}

	public void setDataScadenza(String dataScadenza) {
		this.dataScadenza = dataScadenza;
	}

	public String getNumLotto() {
		return numLotto;
	}

	public void setNumLotto(String numLotto) {
		this.numLotto = numLotto;
	}

	public String getDimensioneLotto() {
		return dimensioneLotto;
	}

	public void setDimensioneLotto(String dimensioneLotto) {
		this.dimensioneLotto = dimensioneLotto;
	}

	public String getIngredienti() {
		return ingredienti;
	}

	public void setIngredienti(String ingredienti) {
		this.ingredienti = ingredienti;
	}

	public String getCommentiMangimePrelevato() {
		return commentiMangimePrelevato;
	}

	public void setCommentiMangimePrelevato(String commentiMangimePrelevato) {
		this.commentiMangimePrelevato = commentiMangimePrelevato;
	}

	public int getIdMatriceCampione() {
		return idMatriceCampione;
	}

	public void setIdMatriceCampione(int idMatriceCampione) {
		this.idMatriceCampione = idMatriceCampione;
	}

	public String getMangimeSempliceSpecifica() {
		return mangimeSempliceSpecifica;
	}

	public void setMangimeSempliceSpecifica(String mangimeSempliceSpecifica) {
		this.mangimeSempliceSpecifica = mangimeSempliceSpecifica;
	}

	public int getIdMangimeComposto() {
		return idMangimeComposto;
	}

	public void setIdMangimeComposto(int idMangimeComposto) {
		this.idMangimeComposto = idMangimeComposto;
	}

	public int getIdPremiscelaAdditivi() {
		return idPremiscelaAdditivi;
	}

	public void setIdPremiscelaAdditivi(int idPremiscelaAdditivi) {
		this.idPremiscelaAdditivi = idPremiscelaAdditivi;
	}

	public int getIdMetodoProduzione() {
		return idMetodoProduzione;
	}

	public void setIdMetodoProduzione(int idMetodoProduzione) {
		this.idMetodoProduzione = idMetodoProduzione;
	}

	public String getListaSpecieVegetaleDichiarata() {
		return listaSpecieVegetaleDichiarata;
	}

	public void setListaSpecieVegetaleDichiarata(String listaSpecieVegetaleDichiarata) {
		this.listaSpecieVegetaleDichiarata = listaSpecieVegetaleDichiarata;
	}

	public String getListaSpecieAlimentoDestinato() {
		return listaSpecieAlimentoDestinato;
	}

	public void setListaSpecieAlimentoDestinato(String listaSpecieAlimentoDestinato) {
		this.listaSpecieAlimentoDestinato = listaSpecieAlimentoDestinato;
	}

	public String getListaStatoProdottoPrelievo() {
		return listaStatoProdottoPrelievo;
	}

	public void setListaStatoProdottoPrelievo(String listaStatoProdottoPrelievo) {
		this.listaStatoProdottoPrelievo = listaStatoProdottoPrelievo;
	}

	public String getLaboratorioDestinazione() {
		return laboratorioDestinazione;
	}

	public void setLaboratorioDestinazione(String laboratorioDestinazione) {
		this.laboratorioDestinazione = laboratorioDestinazione;
	}

	public int getIdAllegaCartellino() {
		return idAllegaCartellino;
	}

	public void setIdAllegaCartellino(int idAllegaCartellino) {
		this.idAllegaCartellino = idAllegaCartellino;
	}

	public String getDescrizioneAttrezzature() {
		return descrizioneAttrezzature;
	}

	public void setDescrizioneAttrezzature(String descrizioneAttrezzature) {
		this.descrizioneAttrezzature = descrizioneAttrezzature;
	}

	public String getNumPunti() {
		return numPunti;
	}

	public void setNumPunti(String numPunti) {
		this.numPunti = numPunti;
	}

	public String getNumCE() {
		return numCE;
	}

	public void setNumCE(String numCE) {
		this.numCE = numCE;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getOperazioni() {
		return operazioni;
	}

	public void setOperazioni(String operazioni) {
		this.operazioni = operazioni;
	}

	public String getVolume2() {
		return volume2;
	}

	public void setVolume2(String volume2) {
		this.volume2 = volume2;
	}

	public String getOperazioni2() {
		return operazioni2;
	}

	public void setOperazioni2(String operazioni2) {
		this.operazioni2 = operazioni2;
	}

	public String getNumeroCF() {
		return numeroCF;
	}

	public void setNumeroCF(String numeroCF) {
		this.numeroCF = numeroCF;
	}

	public String getQuantitaGML() {
		return quantitaGML;
	}

	public void setQuantitaGML(String quantitaGML) {
		this.quantitaGML = quantitaGML;
	}

	public String getDichiarazione() {
		return dichiarazione;
	}

	public void setDichiarazione(String dichiarazione) {
		this.dichiarazione = dichiarazione;
	}

	public String getConservazioneCampione() {
		return conservazioneCampione;
	}

	public void setConservazioneCampione(String conservazioneCampione) {
		this.conservazioneCampione = conservazioneCampione;
	}

	public String getNumCopie() {
		return numCopie;
	}

	public void setNumCopie(String numCopie) {
		this.numCopie = numCopie;
	}

	public String getNumCampioniFinali() {
		return numCampioniFinali;
	}

	public void setNumCampioniFinali(String numCampioniFinali) {
		this.numCampioniFinali = numCampioniFinali;
	}

	public String getCustode() {
		return custode;
	}

	public void setCustode(String custode) {
		this.custode = custode;
	}

	public int getIdRinunciaCampione() {
		return idRinunciaCampione;
	}

	public void setIdRinunciaCampione(int idRinunciaCampione) {
		this.idRinunciaCampione = idRinunciaCampione;
	}

	public int getIdCampioneFinale() {
		return idCampioneFinale;
	}

	public void setIdCampioneFinale(int idCampioneFinale) {
		this.idCampioneFinale = idCampioneFinale;
	}

	public String getCampioneCodiceEsame() {
		return campioneCodiceEsame;
	}

	public void setCampioneCodiceEsame(String campioneCodiceEsame) {
		this.campioneCodiceEsame = campioneCodiceEsame;
	}

	public String getCampioneCodiceOsa() {
		return campioneCodiceOsa;
	}

	public void setCampioneCodiceOsa(String campioneCodiceOsa) {
		this.campioneCodiceOsa = campioneCodiceOsa;
	}

	public String getCampioneListaCodiceMatrice() {
		return campioneListaCodiceMatrice;
	}

	public void setCampioneListaCodiceMatrice(String campioneListaCodiceMatrice) {
		this.campioneListaCodiceMatrice = campioneListaCodiceMatrice;
	}

	public String getVolume3() {
		return volume3;
	}

	public void setVolume3(String volume3) {
		this.volume3 = volume3;
	}

	public String getNumCampioniFinaliInvio() {
		return numCampioniFinaliInvio;
	}

	public void setNumCampioniFinaliInvio(String numCampioniFinaliInvio) {
		this.numCampioniFinaliInvio = numCampioniFinaliInvio;
	}

	public String getNumCopieInvio() {
		return numCopieInvio;
	}

	public void setNumCopieInvio(String numCopieInvio) {
		this.numCopieInvio = numCopieInvio;
	}

	public String getDestinazioneInvio() {
		return destinazioneInvio;
	}

	public void setDestinazioneInvio(String destinazioneInvio) {
		this.destinazioneInvio = destinazioneInvio;
	}

	public String getDataInvio() {
		return dataInvio;
	}

	public void setDataInvio(String dataInvio) {
		this.dataInvio = dataInvio;
	}

	public int getIdCgRidotto() {
		return idCgRidotto;
	}

	public void setIdCgRidotto(int idCgRidotto) {
		this.idCgRidotto = idCgRidotto;
	}

	public int getIdCgCr() {
		return idCgCr;
	}

	public void setIdCgCr(int idCgCr) {
		this.idCgCr = idCgCr;
	}

	public int getIdSequestroPartita() {
		return idSequestroPartita;
	}

	public void setIdSequestroPartita(int idSequestroPartita) {
		this.idSequestroPartita = idSequestroPartita;
	}

	public int getIdCategoriaSottoprodotti() {
		return idCategoriaSottoprodotti;
	}

	public void setIdCategoriaSottoprodotti(int idCategoriaSottoprodotti) {
		this.idCategoriaSottoprodotti = idCategoriaSottoprodotti;
	}

	public String getCampioneCodiceSinvsa() {
		return campioneCodiceSinvsa;
	}

	public void setCampioneCodiceSinvsa(String campioneCodiceSinvsa) {
		this.campioneCodiceSinvsa = campioneCodiceSinvsa;
	}

	public boolean getBozza(){
		return bozza;
	}
	
	public String getNumAliquoteCF() {
		return numAliquoteCF;
	}

	public void setNumAliquoteCF(String numAliquoteCF) {
		this.numAliquoteCF = numAliquoteCF;
	}

	public String getNumUnitaCampionarie() {
		return numUnitaCampionarie;
	}

	public void setNumUnitaCampionarie(String numUnitaCampionarie) {
		this.numUnitaCampionarie = numUnitaCampionarie;
	}

	public String getPesoUnitaCampionaria() {
		return pesoUnitaCampionaria;
	}

	public void setPesoUnitaCampionaria(String pesoUnitaCampionaria) {
		this.pesoUnitaCampionaria = pesoUnitaCampionaria;
	}

	public String getDataInizioAnalisi() {
		return dataInizioAnalisi;
	}

	public void setDataInizioAnalisi(String dataInizioAnalisi) {
		this.dataInizioAnalisi = dataInizioAnalisi;
	}

	public String getOraInizioAnalisi() {
		return oraInizioAnalisi;
	}

	public void setOraInizioAnalisi(String oraInizioAnalisi) {
		this.oraInizioAnalisi = oraInizioAnalisi;
	}

	public void setBozza(boolean bozza){
		this.bozza = bozza;
	}
	
	public void upsert(Connection db) throws SQLException {
		
		JSONObject json = new JSONObject();
		
		json.put("idCampione", idCampione);
		json.put("enteredBy", enteredBy);
		json.put("campioneNumPrelevati", campioneNumPrelevati);
		json.put("idMetodoCampionamento", idMetodoCampionamento);
		json.put("idPrincipiAdditivi", idPrincipiAdditivi);
		json.put("idPrincipiAdditiviCO", idPrincipiAdditiviCO);
		json.put("idContaminanti", idContaminanti);
		json.put("programmaControlloFASpecifica", programmaControlloFASpecifica);
		json.put("programmaControlloANSpecifica", programmaControlloANSpecifica);
		json.put("programmaControlloCISpecifica", programmaControlloCISpecifica);

		json.put("programmaControlloATSpecifica", programmaControlloATSpecifica);
		json.put("programmaControlloAOSpecifica", programmaControlloAOSpecifica);
		json.put("programmaControlloAZSpecifica", programmaControlloAZSpecifica);
		json.put("programmaControlloCOFASpecifica", programmaControlloCOFASpecifica);
		json.put("programmaControlloCOCISpecifica", programmaControlloCOCISpecifica);
		json.put("programmaControlloINCISpecifica", programmaControlloINCISpecifica);
		json.put("programmaControlloINRASpecifica", programmaControlloINRASpecifica);
		json.put("programmaControlloINPESpecifica", programmaControlloINPESpecifica);
		json.put("quantitaPa", quantitaPa);
		json.put("idLuogoPrelievo", idLuogoPrelievo);

		json.put("codiceLuogoPrelievo", codiceLuogoPrelievo);
		json.put("targaMezzo", targaMezzo);
		json.put("telefono", telefono);
		json.put("idMatriceCampione", idMatriceCampione);
		json.put("mangimeSempliceSpecifica", mangimeSempliceSpecifica);
		json.put("idMangimeComposto", idMangimeComposto);
		json.put("idPremiscelaAdditivi", idPremiscelaAdditivi);
		json.put("listaSpecieVegetaleDichiarata", listaSpecieVegetaleDichiarata);
		json.put("trattamentoMangime", trattamentoMangime);
		json.put("idConfezionamento", idConfezionamento);

		json.put("ragioneSocialeDittaProduttrice", ragioneSocialeDittaProduttrice);
		json.put("indirizzoDittaProduttrice", indirizzoDittaProduttrice);
		json.put("listaSpecieAlimentoDestinato", listaSpecieAlimentoDestinato);
		json.put("idMetodoProduzione", idMetodoProduzione);
		json.put("nomeCommercialeMangime", nomeCommercialeMangime);
		json.put("listaStatoProdottoPrelievo", listaStatoProdottoPrelievo);
		json.put("responsabileEtichettatura", responsabileEtichettatura);
		json.put("indirizzoResponsabileEtichettatura", indirizzoResponsabileEtichettatura);
		json.put("paeseProduzione", paeseProduzione);
		json.put("dataProduzione", dataProduzione);

		json.put("dataScadenza", dataScadenza);
		json.put("numLotto", numLotto);
		json.put("dimensioneLotto", dimensioneLotto);
		json.put("ingredienti", ingredienti);
		json.put("commentiMangimePrelevato", commentiMangimePrelevato);
		json.put("laboratorioDestinazione", laboratorioDestinazione);
		json.put("idAllegaCartellino", idAllegaCartellino);
		json.put("descrizioneAttrezzature", descrizioneAttrezzature);
		json.put("numPunti", numPunti);
		json.put("numCE", numCE);

		json.put("volume", volume);
		json.put("operazioni", operazioni);
		json.put("volume2", volume2);
		json.put("operazioni2", operazioni2);
		json.put("numeroCF", numeroCF);
		json.put("quantitaGML", quantitaGML);
		json.put("dichiarazione", dichiarazione);
		json.put("conservazioneCampione", conservazioneCampione);
		json.put("numCopie", numCopie);
		json.put("numCampioniFinali", numCampioniFinali);

		json.put("custode", custode);
		json.put("idRinunciaCampione", idRinunciaCampione);
		json.put("idCampioneFinale", idCampioneFinale);
		json.put("micotossineSpecifica", micotossineSpecifica);
		json.put("altroSpecifica", altroSpecifica); 
		json.put("campioneOre", campioneOre); 
		json.put("idDpa", idDpa);
		json.put("volume3", volume3);
		json.put("numCampioniFinaliInvio", numCampioniFinaliInvio);
		json.put("numCopieInvio", numCopieInvio);

		json.put("destinazioneInvio", destinazioneInvio);
		json.put("dataInvio", dataInvio);
		json.put("campionePresente", campionePresente);
		json.put("idCgRidotto", idCgRidotto);
		json.put("idCgCr", idCgCr);
		json.put("idSequestroPartita", idSequestroPartita);
		json.put("idCategoriaSottoprodotti", idCategoriaSottoprodotti);
		json.put("bozza", bozza);

		//Flusso 358
		json.put("numAliquoteCF", numAliquoteCF);
		json.put("numUnitaCampionarie", numUnitaCampionarie);
		json.put("pesoUnitaCampionaria", pesoUnitaCampionaria);
		json.put("dataInizioAnalisi", dataInizioAnalisi);
		json.put("oraInizioAnalisi", oraInizioAnalisi);
//			Flusso 384
		json.put("campioneMangime", campioneMangime);
		json.put("campioneSottoprodotti", campioneSottoprodotti);
		json.put("additiviNutrizionaliSpecifica", additiviNutrizionaliSpecifica);

		json.put("dimensionePorzione", dimensionePorzione);
		json.put("cf1Peso", cf1Peso);
		json.put("cf1Sigillo", cf1Sigillo);
		json.put("cf2Peso", cf2Peso);
		json.put("cf2Sigillo", cf2Sigillo);
		json.put("cf3Peso", cf3Peso);
		json.put("cf3Sigillo", cf3Sigillo);
		json.put("cf4Peso", cf4Peso);
		json.put("cf4Sigillo", cf4Sigillo);
		json.put("cf5Peso", cf5Peso);

		json.put("cf5Sigillo", cf5Sigillo);
		json.put("cfUlteriore", cfUlteriore);
		json.put("cfUlteriorePeso", cfUlteriorePeso);
		json.put("cfUlterioreRicerca", cfUlterioreRicerca);

		json.put("aliquotaConoscitivaCromo", aliquotaConoscitivaCromo);
		json.put("aliquotaConoscitivaMicotossine", aliquotaConoscitivaMicotossine);
		json.put("aliquotaConoscitivaNitrati", aliquotaConoscitivaNitrati);
		json.put("aliquotaConoscitivaRadionuclidi", aliquotaConoscitivaRadionuclidi);

		json.put("idMicotossineTipo", idMicotossineTipo);

		PreparedStatement pst = db.prepareStatement("select * from upsert_modello_pnaa(to_json(?::json))");
		int i = 0;
		pst.setString(++i, json.toString());
		
		System.out.println("[PNAA] Query upsert: "+pst.toString());
		
		pst.executeQuery();
		
	}

	public String getCampioneMangime() {
		return campioneMangime;
	}

	public void setCampioneMangime(String campioneMangime) {
		this.campioneMangime = campioneMangime;
	}

	public String getCampioneSottoprodotti() {
		return campioneSottoprodotti;
	}

	public void setCampioneSottoprodotti(String campioneSottoprodotti) {
		this.campioneSottoprodotti = campioneSottoprodotti;
	}

	
	
	public String getAdditiviNutrizionaliSpecifica() {
		return additiviNutrizionaliSpecifica;
	}

	public void setAdditiviNutrizionaliSpecifica(String additiviNutrizionaliSpecifica) {
		this.additiviNutrizionaliSpecifica = additiviNutrizionaliSpecifica;
	}


	public String getDimensionePorzione() {
		return dimensionePorzione;
	}

	public void setDimensionePorzione(String dimensionePorzione) {
		this.dimensionePorzione = dimensionePorzione;
	}

	public String getCf1Peso() {
		return cf1Peso;
	}

	public void setCf1Peso(String cf1Peso) {
		this.cf1Peso = cf1Peso;
	}

	public String getCf1Sigillo() {
		return cf1Sigillo;
	}

	public void setCf1Sigillo(String cf1Sigillo) {
		this.cf1Sigillo = cf1Sigillo;
	}

	public String getCf2Peso() {
		return cf2Peso;
	}

	public void setCf2Peso(String cf2Peso) {
		this.cf2Peso = cf2Peso;
	}

	public String getCf2Sigillo() {
		return cf2Sigillo;
	}

	public void setCf2Sigillo(String cf2Sigillo) {
		this.cf2Sigillo = cf2Sigillo;
	}

	public String getCf3Peso() {
		return cf3Peso;
	}

	public void setCf3Peso(String cf3Peso) {
		this.cf3Peso = cf3Peso;
	}

	public String getCf3Sigillo() {
		return cf3Sigillo;
	}

	public void setCf3Sigillo(String cf3Sigillo) {
		this.cf3Sigillo = cf3Sigillo;
	}

	public String getCf4Peso() {
		return cf4Peso;
	}

	public void setCf4Peso(String cf4Peso) {
		this.cf4Peso = cf4Peso;
	}

	public String getCf4Sigillo() {
		return cf4Sigillo;
	}

	public void setCf4Sigillo(String cf4Sigillo) {
		this.cf4Sigillo = cf4Sigillo;
	}

	public String getCf5Peso() {
		return cf5Peso;
	}

	public void setCf5Peso(String cf5Peso) {
		this.cf5Peso = cf5Peso;
	}

	public String getCf5Sigillo() {  
		return cf5Sigillo;
	}

	public void setCf5Sigillo(String cf5Sigillo) {
		this.cf5Sigillo = cf5Sigillo;
	}

	public String getCfUlteriore() {
		return cfUlteriore;
	}

	public void setCfUlteriore(String cfUlteriore) {
		this.cfUlteriore = cfUlteriore;
	}

	public String getCfUlteriorePeso() {
		return cfUlteriorePeso;
	}

	public void setCfUlteriorePeso(String cfUlteriorePeso) {
		this.cfUlteriorePeso = cfUlteriorePeso;
	}

	public String getCfUlterioreRicerca() {
		return cfUlterioreRicerca;
	}

	public void setCfUlterioreRicerca(String cfUlterioreRicerca) {
		this.cfUlterioreRicerca = cfUlterioreRicerca;
	}

	public String getAliquotaConoscitivaCromo() {
		return aliquotaConoscitivaCromo;
	}

	public void setAliquotaConoscitivaCromo(String aliquotaConoscitivaCromo) {
		this.aliquotaConoscitivaCromo = aliquotaConoscitivaCromo;
	}

	public String getAliquotaConoscitivaMicotossine() {
		return aliquotaConoscitivaMicotossine;
	}

	public void setAliquotaConoscitivaMicotossine(String aliquotaConoscitivaMicotossine) {
		this.aliquotaConoscitivaMicotossine = aliquotaConoscitivaMicotossine;
	}

	public String getAliquotaConoscitivaNitrati() {
		return aliquotaConoscitivaNitrati;
	}

	public void setAliquotaConoscitivaNitrati(String aliquotaConoscitivaNitrati) {
		this.aliquotaConoscitivaNitrati = aliquotaConoscitivaNitrati;
	}

	public String getAliquotaConoscitivaRadionuclidi() {
		return aliquotaConoscitivaRadionuclidi;
	}

	public void setAliquotaConoscitivaRadionuclidi(String aliquotaConoscitivaRadionuclidi) {
		this.aliquotaConoscitivaRadionuclidi = aliquotaConoscitivaRadionuclidi;
	}

	public int getIdMicotossineTipo() {
		return idMicotossineTipo;
	}

	public void setIdMicotossineTipo(int idMicotossineTipo) {
		this.idMicotossineTipo = idMicotossineTipo;
	}

	

	
	
		
}


 


	

