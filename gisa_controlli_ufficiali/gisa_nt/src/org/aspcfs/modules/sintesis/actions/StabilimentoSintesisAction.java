package org.aspcfs.modules.sintesis.actions;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

import javax.servlet.ServletException;

import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellReference;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.Role;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.diffida.base.Ticket;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiSintesis;
import org.aspcfs.modules.gestioneDocumenti.util.DocumentaleUtil;
import org.aspcfs.modules.gestioneml.actions.GestioneMasterList;
import org.aspcfs.modules.gestioneml.base.SuapMasterListLineaAttivita;
import org.aspcfs.modules.gestioneml.base.SuapMasterListSchedaAggiuntiva;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.opu.base.ComuniAnagrafica;
import org.aspcfs.modules.opu.base.RicercheAnagraficheTab;
import org.aspcfs.modules.opu.util.StabilimentoImportUtil;
import org.aspcfs.modules.sintesis.base.LogImport;
import org.aspcfs.modules.sintesis.base.SintesisAutomezzo;
import org.aspcfs.modules.sintesis.base.SintesisIndirizzo;
import org.aspcfs.modules.sintesis.base.SintesisOperatore;
import org.aspcfs.modules.sintesis.base.SintesisProdotto;
import org.aspcfs.modules.sintesis.base.SintesisRelazioneLineaProduttiva;
import org.aspcfs.modules.sintesis.base.SintesisSoggettoFisico;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.modules.sintesis.base.SintesisStorico;
import org.aspcfs.modules.sintesis.base.SintesisStoricoOperatore;
import org.aspcfs.modules.sintesis.base.SintesisStoricoRelazioneLineaProduttiva;
import org.aspcfs.modules.sintesis.base.SintesisStoricoSoggettoFisico;
import org.aspcfs.modules.sintesis.base.SintesisStoricoStabilimento;
import org.aspcfs.modules.sintesis.base.StabilimentoSintesisImport;
import org.aspcfs.modules.sintesis.util.StabilimentoSintesisImportThread;
import org.aspcfs.utils.PopolaCombo;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;

import com.darkhorseventures.framework.actions.ActionContext;
import com.isavvix.tools.FileInfo;
import com.isavvix.tools.HttpMultiPartParser;

public class StabilimentoSintesisAction extends CFSModule {

  public String executeCommandDefault(ActionContext context) {

    return executeCommandListaStabilimenti(context);
  }

  public String executeCommandPrepareImport(ActionContext context) throws EncryptedDocumentException, IllegalArgumentException, IllegalAccessException, InvalidFormatException, IOException {

    String msg = (String) context.getRequest().getAttribute("msg");
    context.getRequest().setAttribute("msg", msg);

    String msgSemaforo = "";

    Connection db = null;

    try {
      db = this.getConnection(context);

      LogImport log = new LogImport();
      msgSemaforo = log.checkSemaforo(db);
      context.getRequest().setAttribute("msgSemaforo", msgSemaforo);

      StringBuffer sql = new StringBuffer();
      sql.append("select * from sintesis_stabilimenti_import_log where ended is not null order by entered desc limit 1");
      PreparedStatement pst;
      pst = db.prepareStatement(sql.toString());
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        log = new LogImport(rs);
      }

      context.getRequest().setAttribute("log", log);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "prepareImportOK";
  }

  public String executeCommandImportDaFile(ActionContext context) throws IllegalArgumentException, IllegalAccessException, IOException, InvalidFormatException, MagicParseException, MagicMatchNotFoundException, MagicException, IllegalStateException, ServletException, FileUploadException {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    //BLOCCO #1: LETTURA DEL FILE E CREAZIONE ARRAYLIST DI RICHIESTE

    Connection db = null;

    String filePath = this.getPath(context, "sintesis_import");
    String fileName = "";
    HttpMultiPartParser multiPart = new HttpMultiPartParser();

    HashMap parts = null;
    try {
      parts = multiPart.parseData(context.getRequest(), filePath);
    } catch (IllegalArgumentException | IOException e2) {
      // TODO Auto-generated catch block
      e2.printStackTrace();
    }

    String xlsFile = "";
    String csvFile = "";

    if ((Object) parts.get("file") instanceof FileInfo) {
      //Update the database with the resulting file
      FileInfo newFileInfo = (FileInfo) parts.get("file");
      //Insert a file description record into the database
      com.zeroio.iteam.base.FileItem thisItem = new com.zeroio.iteam.base.FileItem();
      thisItem.setLinkModuleId(Constants.ACCOUNTS);
      thisItem.setEnteredBy(getUserId(context));
      thisItem.setModifiedBy(getUserId(context));
      thisItem.setClientFilename(newFileInfo.getClientFileName());
      thisItem.setFilename(newFileInfo.getRealFilename());
      fileName = newFileInfo.getRealFilename();
      thisItem.setVersion(1.0);
      thisItem.setSize(newFileInfo.getSize());
      xlsFile = thisItem.getFullFilePath();
    }
  
    xlsFile = filePath + fileName;
    try {
    	ArrayList<String> listaFile = new ArrayList<String>();
    	listaFile.add("application/vnd.ms-excel");
    	listaFile.add("application/msword");
    	String mimeType = DocumentaleUtil.mimeType(xlsFile, listaFile);
    	if(mimeType != null)
    		if(mimeType.equals("errore")){
    			context.getRequest().setAttribute("msg", "Errore! Formato file non valido");
    			return executeCommandPrepareImport(context);
    		}
    } catch (IllegalStateException | IOException e1) {
    	// TODO Auto-generated catch block
    	e1.printStackTrace();
    }
    
    String dataSintesis = (String) parts.get("sintesisData");

    //BLOCCO #1: LETTURA DEL FILE E CREAZIONE ARRAYLIST DI RICHIESTE

    //verifico se le celle sono nel formato corretto
    boolean hasOnlyCelleTesto = true;
    String msgHasOnlyCelleTesto = "";
    String excelFilePath = xlsFile;
    FileInputStream inputStream = null;
    try {
      inputStream = new FileInputStream(new File(excelFilePath));
    } catch (FileNotFoundException e1) {
      e1.printStackTrace();
    }
    org.apache.poi.ss.usermodel.Workbook workbook = null;
    try {
      workbook = WorkbookFactory.create(inputStream);
    } catch (EncryptedDocumentException | InvalidFormatException | IOException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    }
    org.apache.poi.ss.usermodel.Sheet firstSheet = workbook.getSheetAt(0);
    Iterator < Row > iterator = firstSheet.iterator();

    int rigaIniziale = 0;
    int rigaFinale = 0;
    int numeroRiga = 0;

    while (iterator.hasNext()) {
      Row nextRow = iterator.next();
      numeroRiga = nextRow.getRowNum() + 1;

      Iterator < Cell > cellIterator = nextRow.cellIterator();

      while (cellIterator.hasNext()) {
        Cell cell = cellIterator.next();
        if (cell.getCellType() == Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(StabilimentoSintesisImportThread.markerIniziale))
          rigaIniziale = numeroRiga;
        if (cell.getCellType() == Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(StabilimentoSintesisImportThread.markerFinale))
          rigaFinale = numeroRiga;
      }

      if (rigaIniziale > 0 && rigaFinale > 0)
        break;
    }

    numeroRiga = 0;
    iterator = firstSheet.iterator();

    while (iterator.hasNext() && hasOnlyCelleTesto) {
      Row nextRow = iterator.next();
      numeroRiga = nextRow.getRowNum() + 1;

      if (numeroRiga > rigaFinale)
        break;

      if (numeroRiga > rigaIniziale && numeroRiga < rigaFinale) {
        Iterator < Cell > cellIterator = nextRow.cellIterator();
        int i = 0;
        while (cellIterator.hasNext() && hasOnlyCelleTesto) {
          Cell cell = cellIterator.next();
          if (i <= 23 && cell.getCellType() != Cell.CELL_TYPE_STRING) {
            hasOnlyCelleTesto = false;
            msgHasOnlyCelleTesto = "[Cella "+ (CellReference.convertNumToColString(cell.getColumnIndex())) + (nextRow.getRowNum()+1)+"]"; 
            break;
          }
          i++;
        }
      }
    }

    try {
      workbook.close();
    } catch (IOException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    }
    try {
      inputStream.close();
    } catch (IOException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    }

    if (!hasOnlyCelleTesto) {
      context.getRequest().setAttribute("msg", "Errore. Controllare il contenuto del file. Sono presenti celle in formato non testuale. "+msgHasOnlyCelleTesto);
      return executeCommandPrepareImport(context);
    }

    //Verifico se il file e' stato gia' caricato in precedenza
    boolean fileGiaEsistente = false;

    LogImport log = new LogImport();
    log.setFileImport(xlsFile);
    try {
      log.calcolaMd5();
    } catch (IOException e2) {
      // TODO Auto-generated catch block
      e2.printStackTrace();
    }
    log.setUtenteImport(getUserId(context));
    log.setDataDocumentoSintesis(dataSintesis);
    try {
      db = this.getConnection(context);

      fileGiaEsistente = log.md5Presente(db);
    

    if (fileGiaEsistente) {
      context.getRequest().setAttribute("msg", "Errore. File gia'' importato in precedenza. Il contenuto del file risulta identico a quello di un file importato in precedenza.");
      return executeCommandPrepareImport(context);
    }
    if (!fileGiaEsistente){
		log.insert(db);
	}
    /*ALLEGO IL FILE INVOCANDO IL DOCUMENTALE*/
    StabilimentoImportUtil.stampaLog("[SINTESIS] Carico file sul documentale.");
    String codDocumento = null;
    GestioneAllegatiSintesis gestioneAllegati = new GestioneAllegatiSintesis();
    gestioneAllegati.setIdInvioSintesis(log.getId());
    gestioneAllegati.setTipoAllegato("SINTESIS");
    gestioneAllegati.setFileDaCaricare(new File(xlsFile));
    gestioneAllegati.setOggetto("INVIO SINTESIS_" + log.getId() + "_" + log.getDataDocumentoSintesis());
    codDocumento = gestioneAllegati.allegaFile(context);	
	try {
		db =this.getConnection(context);
		log.aggiornaHeaderFile(db, codDocumento);
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally {this.freeConnection(context, db);
	}


    StabilimentoSintesisImportThread t = new StabilimentoSintesisImportThread(context, xlsFile, dataSintesis, log.getId(), getUserId(context));
    t.importaDaFile();

    context.getRequest().setAttribute("msg", "Import in corso. Attendere la fine della procedura.");
    return executeCommandPrepareImport(context);

  }

  public String executeCommandRestartImportDaFile(ActionContext context) throws IllegalArgumentException, IllegalAccessException, IOException, EncryptedDocumentException, InvalidFormatException {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    int idImport = -1;

    try {
      idImport = Integer.parseInt(context.getRequest().getParameter("idImport"));
    } catch (Exception e) {}
    if (idImport == -1) {
      try {
        idImport = Integer.parseInt((String) context.getRequest().getAttribute("idImport"));
      } catch (Exception e) {}
    }
    String xlsFile = "";
    String dataSintesis = "";

    Connection db = null;

    LogImport log = new LogImport();

    try {
      db = this.getConnection(context);

      log = new LogImport(db, idImport);
      xlsFile = log.getFileImport();
      dataSintesis = String.valueOf(log.getDataDocumentoSintesis());
      log.setUtenteImport(getUserId(context));

      log.cancellaPratiche(db);

      StabilimentoSintesisImportThread t = new StabilimentoSintesisImportThread(context, xlsFile, dataSintesis, log.getId(), getUserId(context));
      t.importaDaFile();

      context.getRequest().setAttribute("msg", "Import in corso. Attendere la fine della procedura.");

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandPrepareImport(context);

  }

  public String executeCommandListaRichiesteAggregate(ActionContext context) throws EncryptedDocumentException, IllegalArgumentException, IllegalAccessException, InvalidFormatException, IOException {

    if (!hasPermission(context, "sintesis-view")) {
      return ("PermissionError");
    }

    String msg = (String) context.getRequest().getAttribute("msg");
    context.getRequest().setAttribute("msg", msg);

    String limit = context.getRequest().getParameter("limit");

    StringBuffer sql = new StringBuffer();
    sql.append("select log.data_sintesis, s.* from sintesis_stabilimenti_import s left join sintesis_stabilimenti_import_log log on log.id = s.id_import where s.stato_import = " + StabilimentoSintesisImport.IMPORT_DA_VALIDARE + " and s.trashed_date is null order by s.approval_number DESC, s.id DESC ");
    //sql.append("select * from sintesis_stabilimenti_import  order by approval_number DESC, id DESC ");

    //	if (limit == null || limit.equals("null") || limit.equals(""))
    //		limit = "10";
    //	
    //	if (limit.equals("-1"))
    //		sql.append("");
    //	else
    //		sql.append(" limit "+limit);
    //	context.getRequest().setAttribute("limit", limit);

    PreparedStatement pst;

    Connection db = null;

    LinkedHashMap < String, ArrayList < StabilimentoSintesisImport >> listaRichieste = new LinkedHashMap < String, ArrayList < StabilimentoSintesisImport > > ();

    try {
      db = this.getConnection(context);

      LogImport log = new LogImport();
      String msgSemaforo = log.checkSemaforo(db);
      if (msgSemaforo != null && !msgSemaforo.equals(""))
        return executeCommandPrepareImport(context);

      pst = db.prepareStatement(sql.toString());

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        StabilimentoSintesisImport stab = new StabilimentoSintesisImport(rs);

        String chiave = stab.getApprovalNumber() + ";;" + stab.getDenominazioneSedeOperativa() + ";;" + stab.getPartitaIva() + ";;" + stab.getStatoSedeOperativa();

        ArrayList < StabilimentoSintesisImport > listaRichiesteAggreg = listaRichieste.get(chiave);
        if (listaRichiesteAggreg == null) {
          listaRichiesteAggreg = new ArrayList < StabilimentoSintesisImport > ();
          listaRichiesteAggreg.add(stab);
        } else {
          listaRichiesteAggreg.add(stab);
        }

        listaRichieste.put(chiave, listaRichiesteAggreg);
      }

      context.getRequest().setAttribute("listaRichieste", listaRichieste);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "RichiesteAggregateListOK";
  }

  public String executeCommandDettaglioCompletaRichiesta(ActionContext context) {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    int id = -1;

    String idString = context.getRequest().getParameter("id");

    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}
    if (id == -1)
      idString = (String) context.getRequest().getAttribute("id");
    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}

    Connection db = null;

    try {
      db = this.getConnection(context);
      StabilimentoSintesisImport stab = new StabilimentoSintesisImport(db, id);
      context.getRequest().setAttribute("Richiesta", stab);

      if (stab.getOpuIdLineaProduttivaMasterList() > 0) {
        String lineaAttivitaMasterList = GestioneMasterList.getPathCompleto(db, stab.getOpuIdLineaProduttivaMasterList());
        context.getRequest().setAttribute("lineaAttivitaMasterList", lineaAttivitaMasterList);
      }

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList NazioniList = new LookupList(db, "lookup_nazioni");
      NazioniList.addItem(-1, "Seleziona Nazione");
      context.getRequest().setAttribute("NazioniList", NazioniList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    if (context.getRequest().getParameter("popup") != null && context.getRequest().getParameter("popup").equals("true"))
      return "DettaglioCompletaRichiestaPopupOK";

    return "DettaglioCompletaRichiestaOK";
  }

  public String executeCommandCompletaProcessaRichiesta(ActionContext context) throws SQLException {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    String msg = "";
    int codiceUscita = -1;
    SintesisRelazioneLineaProduttiva relEsistente = null;
    SintesisRelazioneLineaProduttiva rel = null;
    SintesisStabilimento stabEsistente = null;
    Object[] outputValidazione = new Object[] {
      codiceUscita,
      msg,
      relEsistente,
      rel,
      stabEsistente
    };

    int idRichiesta = Integer.parseInt(context.getRequest().getParameter("idRichiesta"));

    String tipoImpresa = context.getRequest().getParameter("tipo_impresa");
    String tipoSocieta = context.getRequest().getParameter("tipo_societa");
    String domicilioDigitale = context.getRequest().getParameter("domicilioDigitale");
    String cap = context.getRequest().getParameter("capStab");

    String latitudine = context.getRequest().getParameter("latitudineStab");
    String longitudine = context.getRequest().getParameter("longitudineStab");

    String nomeRappresentante = context.getRequest().getParameter("nome");
    String cognomeRappresentante = context.getRequest().getParameter("cognome");
    String sessoRappresentante = context.getRequest().getParameter("sesso");
    String dataNascitaRappresentante = context.getRequest().getParameter("dataNascita");
    String nazioneNascitaRappresentante = context.getRequest().getParameter("nazioneNascita");
    String comuneNascitaRappresentante = context.getRequest().getParameter("comuneNascitainput");
    String codiceFiscaleRappresentante = context.getRequest().getParameter("codFiscaleSoggetto");

    String nazioneResidenzaRappresentante = context.getRequest().getParameter("nazioneResidenza");
    String provinciaResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCountry");
    String descrizioneProvinciaResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCountryinput");
    String comuneResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCity");
    String descrizioneComuneResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCityinput");
    String toponimoResidenzaRappresentante = context.getRequest().getParameter("toponimoResidenza");
    String descrizioneToponimoResidenzaRappresentante = context.getRequest().getParameter("toponimoResidenza");

    String viaResidenzaRappresentante = context.getRequest().getParameter("addressLegaleLine1input");
    String civicoResidenzaRappresentante = context.getRequest().getParameter("civicoResidenza");
    String capResidenzaRappresentante = context.getRequest().getParameter("capResidenza");

    String domicilioDigitaleRappresentante = context.getRequest().getParameter("domicilioDigitalePecSF");

    String nazioneSedeLegale = context.getRequest().getParameter("nazioneSedeLegale");
    String provinciaSedeLegale = context.getRequest().getParameter("searchcodeIdprovincia");
    String descrizioneProvinciaSedeLegale = context.getRequest().getParameter("searchcodeIdprovinciainput");
    String comuneSedeLegale = context.getRequest().getParameter("searchcodeIdComune");
    String descrizioneComuneSedeLegale = context.getRequest().getParameter("searchcodeIdComuneinput");
    String toponimoSedeLegale = context.getRequest().getParameter("toponimoSedeLegale");
    String descrizioneToponimoSedeLegale = context.getRequest().getParameter("toponimoSedeLegale");
    String viaSedeLegale = context.getRequest().getParameter("viainput");
    String civicoSedeLegale = context.getRequest().getParameter("civicoSedeLegale");
    String capSedeLegale = context.getRequest().getParameter("capSedeLegale");

    LogImport log = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      StabilimentoSintesisImport stab = new StabilimentoSintesisImport(db, idRichiesta);
      log = new LogImport(db, stab.getIdImport());

      stab.setOpuTipoImpresa(tipoImpresa);
      stab.setOpuTipoSocieta(tipoSocieta);
      stab.setOpuDomicilioDigitale(domicilioDigitale);
      stab.setCap(cap);

      stab.setLatitudine(latitudine);
      stab.setLongitudine(longitudine);

      stab.setOpuNomeRappresentante(nomeRappresentante);
      stab.setOpuCognomeRappresentante(cognomeRappresentante);
      stab.setOpuSessoRappresentante(sessoRappresentante);
      stab.setOpuNazioneNascitaRappresentante(nazioneNascitaRappresentante);
      stab.setOpuComuneNascitaRappresentante(comuneNascitaRappresentante);
      stab.setOpuDataNascitaRappresentante(dataNascitaRappresentante);
      stab.setOpuCodiceFiscaleRappresentante(codiceFiscaleRappresentante);

      stab.setOpuNazioneResidenzaRappresentante(nazioneResidenzaRappresentante);
      stab.setOpuProvinciaResidenzaRappresentante(provinciaResidenzaRappresentante);
      stab.setOpuDescrizioneProvinciaResidenzaRappresentante(descrizioneProvinciaResidenzaRappresentante);
      stab.setOpuComuneResidenzaRappresentante(comuneResidenzaRappresentante);
      stab.setOpuDescrizioneComuneResidenzaRappresentante(descrizioneComuneResidenzaRappresentante);
      stab.setOpuToponimoResidenzaRappresentante(toponimoResidenzaRappresentante);
      stab.setOpuDescrizioneToponimoResidenzaRappresentante(descrizioneToponimoResidenzaRappresentante);

      stab.setOpuViaResidenzaRappresentante(viaResidenzaRappresentante);
      stab.setOpuCivicoResidenzaRappresentante(civicoResidenzaRappresentante);
      stab.setOpuCapResidenzaRappresentante(capResidenzaRappresentante);

      stab.setOpuDomicilioDigitaleRappresentante(domicilioDigitaleRappresentante);

      stab.setOpuNazioneSedeLegale(nazioneSedeLegale);
      stab.setOpuProvinciaSedeLegale(provinciaSedeLegale);
      stab.setOpuDescrizioneProvinciaSedeLegale(descrizioneProvinciaSedeLegale);
      stab.setOpuComuneSedeLegale(comuneSedeLegale);
      stab.setOpuDescrizioneComuneSedeLegale(descrizioneComuneSedeLegale);
      stab.setOpuToponimoSedeLegale(toponimoSedeLegale);
      stab.setOpuDescrizioneToponimoSedeLegale(descrizioneToponimoSedeLegale);

      stab.setOpuViaSedeLegale(viaSedeLegale);
      stab.setOpuCivicoSedeLegale(civicoSedeLegale);
      stab.setOpuCapSedeLegale(capResidenzaRappresentante);

      stab.completaDati(db);
      //stab.propagaCompletaDati(db);

      boolean ignoraFlussoStati = (context.getRequest().getParameter("ignoraFlussoStati") != null && context.getRequest().getParameter("ignoraFlussoStati").equals("ok")) ? true : false;
      String salva = context.getRequest().getParameter("salva");
      if (salva == null || !salva.equalsIgnoreCase("salva"))
        outputValidazione = stab.processaRichiesta(db, getUserId(context), true);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("codiceUscita", String.valueOf(outputValidazione[0]));
    context.getRequest().setAttribute("msgValidazione", outputValidazione[1]);

    context.getRequest().setAttribute("relEsistente", outputValidazione[2]);
    context.getRequest().setAttribute("relNuova", outputValidazione[3]);
    context.getRequest().setAttribute("stabEsistente", outputValidazione[4]);

    context.getRequest().setAttribute("LogImport", log);

    context.getRequest().setAttribute("id", String.valueOf(idRichiesta));

    return executeCommandDettaglioCompletaRichiesta(context);

  }

  public String executeCommandListaStabilimenti(ActionContext context) {

    if (!hasPermission(context, "sintesis-view")) {
      return ("PermissionError");
    }

    String limit = context.getRequest().getParameter("limit");
    String offset = context.getRequest().getParameter("offset");
    int tot = 0;

    ArrayList < SintesisStabilimento > listaStabilimenti = new ArrayList < SintesisStabilimento > ();

    StringBuffer sql = new StringBuffer();
    sql.append("select distinct id from (select s.id from sintesis_stabilimento s join sintesis_operatore op on op.id = s.id_operatore join sintesis_indirizzo ind on ind.id = s.id_indirizzo join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id where s.trashed_date is null and op.trashed_date is null and rel.trashed_date is null order by s.id_operatore asc) aa");

    if (limit == null || limit.equals("null") || limit.equals(""))
      limit = "10";

    if (limit.equals("-1"))
      sql.append("");
    else
      sql.append(" limit " + limit);
    context.getRequest().setAttribute("limit", limit);

    if (offset == null || offset.equals("null") || offset.equals(""))
      offset = "0";

    if (offset.equals("-1"))
      sql.append("");
    else
      sql.append(" offset " + offset);
    context.getRequest().setAttribute("offset", offset);

    PreparedStatement pst;
    Connection db = null;

    try {
      db = this.getConnection(context);

      //		Conteggio stabilimenti
      PreparedStatement pstCount = db.prepareStatement("select count(distinct id) from (select s.id from sintesis_stabilimento s join sintesis_operatore op on op.id = s.id_operatore join sintesis_indirizzo ind on ind.id = s.id_indirizzo join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id where s.trashed_date is null and op.trashed_date is null and rel.trashed_date is null order by s.id_operatore asc) aa");
      ResultSet rsCount = pstCount.executeQuery();
      while (rsCount.next()) {
        tot = rsCount.getInt(1);
      }
      context.getRequest().setAttribute("tot", String.valueOf(tot));
      //		Conteggio stabilimenti		

      pst = db.prepareStatement(sql.toString());

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStabilimento stab = new SintesisStabilimento(db, rs.getInt("id"));
        listaStabilimenti.add(stab);
      }
      context.getRequest().setAttribute("listaStabilimenti", listaStabilimenti);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ListaStabilimentiOK";
  }

  public String executeCommandDettaglioStabilimento(ActionContext context) {

    //	if (!hasPermission(context, "sintesis-view")) {
    //		return ("PermissionError");
    //	}

    int id = -1;
    int stabId = -1;
    int altId = -1;

    String idString = context.getRequest().getParameter("id");
    String stabIdString = context.getRequest().getParameter("stabId");
    String altIdString = context.getRequest().getParameter("altId");

    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}
    if (id == -1)
      idString = (String) context.getRequest().getAttribute("id");
    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}

    try {
      stabId = Integer.parseInt(stabIdString);
    } catch (Exception e) {}
    if (stabId == -1)
      stabIdString = (String) context.getRequest().getAttribute("stabId");
    try {
      stabId = Integer.parseInt(stabIdString);
    } catch (Exception e) {}

    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}
    if (altId == -1)
      altIdString = (String) context.getRequest().getAttribute("altId");
    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}

    if (id < 0 && stabId > 0)
      id = stabId;

    Connection db = null;

    try {
      db = this.getConnection(context);
      SintesisStabilimento stab = null;

      if (id > 0)
        stab = new SintesisStabilimento(db, id);
      else if (altId > 0)
        stab = new SintesisStabilimento(db, altId, true);
      context.getRequest().setAttribute("Stabilimento", stab);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

      //Caricamento Diffide
      Ticket t = new Ticket();
      context.getRequest().setAttribute("DiffideList", t.getDiffide(db, false, null, null, null, stab.getAltId(), null));
      context.getRequest().setAttribute("DiffideListStorico", t.getDiffide(db, true, null, null, null, stab.getAltId(), null));

      //GESTIONE BIOGAS
      context.getRequest().setAttribute("MessaggioSchedaBiogas", (String) context.getRequest().getAttribute("MessaggioSchedaBiogas"));

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "DettaglioStabilimentoOK";
  }

  public String executeCommandStoricoStabilimento(ActionContext context) {

    if (!hasPermission(context, "sintesis-storico-view")) {
      return ("PermissionError");
    }

    int id = -1;
    String idString = context.getRequest().getParameter("id");

    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}
    if (id == -1)
      idString = (String) context.getRequest().getAttribute("id");
    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}

    int altId = -1;
    String altIdString = context.getRequest().getParameter("altId");

    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}
    if (altId == -1)
      altIdString = (String) context.getRequest().getAttribute("altId");
    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisStabilimento stab = null;

      if (id > 0)
        stab = new SintesisStabilimento(db, id);
      else if (altId > 0)
        stab = new SintesisStabilimento(db, altId, true);

      ArrayList < SintesisStoricoStabilimento > listaStoricoStabilimento = new ArrayList < SintesisStoricoStabilimento > ();

      StringBuffer sql = new StringBuffer();
      sql.append("select * from sintesis_storico_stabilimento where id_stabilimento = ? order by data_modifica desc");
      PreparedStatement pst;
      pst = db.prepareStatement(sql.toString());
      pst.setInt(1, stab.getIdStabilimento());

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStoricoStabilimento stoStab = new SintesisStoricoStabilimento(rs, db);
        listaStoricoStabilimento.add(stoStab);
      }

      context.getRequest().setAttribute("listaStoricoStabilimento", listaStoricoStabilimento);

      ArrayList < SintesisStoricoRelazioneLineaProduttiva > listaStoricoRelazione = new ArrayList < SintesisStoricoRelazioneLineaProduttiva > ();

      sql = new StringBuffer();
      sql.append("select * from sintesis_storico_relazione_stabilimento_linee_produttive where id_relazione in (select id from sintesis_relazione_stabilimento_linee_produttive where id_stabilimento = ?) order by data_modifica desc");

      pst = db.prepareStatement(sql.toString());
      pst.setInt(1, stab.getIdStabilimento());

      rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStoricoRelazioneLineaProduttiva stoRel = new SintesisStoricoRelazioneLineaProduttiva(rs, db);
        listaStoricoRelazione.add(stoRel);
      }

      context.getRequest().setAttribute("listaStoricoRelazione", listaStoricoRelazione);

      ArrayList < SintesisStoricoOperatore > listaStoricoOperatore = new ArrayList < SintesisStoricoOperatore > ();

      sql = new StringBuffer();
      sql.append("select * from sintesis_storico_operatore where id_operatore = ? order by data_modifica desc");
      pst = db.prepareStatement(sql.toString());
      pst.setInt(1, stab.getIdOperatore());

      rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStoricoOperatore stoOp = new SintesisStoricoOperatore(rs, db);
        listaStoricoOperatore.add(stoOp);
      }

      context.getRequest().setAttribute("listaStoricoOperatore", listaStoricoOperatore);

      ArrayList < SintesisStoricoSoggettoFisico > listaStoricoSoggettoFisico = new ArrayList < SintesisStoricoSoggettoFisico > ();

      sql = new StringBuffer();
      sql.append("select * from sintesis_storico_soggetto_fisico where id_soggetto_fisico = ? order by data_modifica desc");
      pst = db.prepareStatement(sql.toString());
      pst.setInt(1, stab.getOperatore().getRappLegale().getId());

      rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStoricoSoggettoFisico stoSogg = new SintesisStoricoSoggettoFisico(rs, db);
        listaStoricoSoggettoFisico.add(stoSogg);
      }

      context.getRequest().setAttribute("listaStoricoSoggettoFisico", listaStoricoSoggettoFisico);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

      context.getRequest().setAttribute("Stabilimento", stab);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "StoricoStabilimentoOK";
  }

  public String executeCommandPrepareModificaDati(ActionContext context) {

    if (!hasPermission(context, "sintesis-edit")) {
      return ("PermissionError");
    }

    int id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);
      SintesisStabilimento stab = new SintesisStabilimento(db, id);
      context.getRequest().setAttribute("Stabilimento", stab);

      LookupList NazioniList = new LookupList(db, "lookup_nazioni");
      NazioniList.addItem(-1, "Seleziona Nazione");
      context.getRequest().setAttribute("NazioniList", NazioniList);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "PrepareModificaDatiOK";
  }

  public String executeCommandPrepareSelezionaLinea(ActionContext context) {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    int id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);
      StabilimentoSintesisImport stab = new StabilimentoSintesisImport(db, id);
      context.getRequest().setAttribute("Richiesta", stab);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "PrepareSelezionaLineaOK";
  }

  public String executeCommandSelezionaLinea(ActionContext context) {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    int idRichiesta = Integer.parseInt(context.getRequest().getParameter("idRichiesta"));
    int idLinea = Integer.parseInt(context.getRequest().getParameter("idLinea"));

    Connection db = null;

    try {
      db = this.getConnection(context);
      StabilimentoSintesisImport stab = new StabilimentoSintesisImport(db, idRichiesta);
      stab.setOpuIdLineaProduttivaMasterList(idLinea);
      stab.aggiornaLineaProduttivaMasterList(db);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("id", String.valueOf(idRichiesta));
    return executeCommandDettaglioCompletaRichiesta(context);
  }

  public String executeCommandModificaDati(ActionContext context) {

    if (!hasPermission(context, "sintesis-edit")) {
      return ("PermissionError");
    }

    int idStabilimento = Integer.parseInt(context.getRequest().getParameter("idStabilimento"));

    String tipoImpresa = context.getRequest().getParameter("tipo_impresa");
    String tipoSocieta = context.getRequest().getParameter("tipo_societa");
    String domicilioDigitale = context.getRequest().getParameter("domicilioDigitale");
    //String noteImpresa = context.getRequest().getParameter("noteImpresa");

    String nomeRappresentante = context.getRequest().getParameter("nome");
    String cognomeRappresentante = context.getRequest().getParameter("cognome");
    String sessoRappresentante = context.getRequest().getParameter("sesso");
    String dataNascitaRappresentante = context.getRequest().getParameter("dataNascita");
    String nazioneNascitaRappresentante = context.getRequest().getParameter("nazioneNascita");
    String comuneNascitaRappresentante = context.getRequest().getParameter("comuneNascitainput"); //
    String codiceFiscaleRappresentante = context.getRequest().getParameter("codFiscaleSoggetto");

    String nazioneResidenzaRappresentante = context.getRequest().getParameter("nazioneResidenza");
    String provinciaResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCountry");
    String comuneResidenzaRappresentante = context.getRequest().getParameter("addressLegaleCity");
    String toponimoResidenzaRappresentante = context.getRequest().getParameter("toponimoResidenza");
    String viaResidenzaRappresentante = context.getRequest().getParameter("addressLegaleLine1input");
    String civicoResidenzaRappresentante = context.getRequest().getParameter("civicoResidenza");
    String capResidenzaRappresentante = context.getRequest().getParameter("capResidenza");

    String domicilioDigitaleRappresentante = context.getRequest().getParameter("domicilioDigitalePecSF");

    String nazioneSedeLegale = context.getRequest().getParameter("nazioneSedeLegale");
    String provinciaSedeLegale = context.getRequest().getParameter("searchcodeIdprovincia");
    String comuneSedeLegale = context.getRequest().getParameter("searchcodeIdComune");
    String toponimoSedeLegale = context.getRequest().getParameter("toponimoSedeLegale");
    String viaSedeLegale = context.getRequest().getParameter("viainput");
    String civicoSedeLegale = context.getRequest().getParameter("civicoSedeLegale");
    String capSedeLegale = context.getRequest().getParameter("presso");

    String latitudine = context.getRequest().getParameter("latitudineStab");
    String longitudine = context.getRequest().getParameter("longitudineStab");
    String cap = context.getRequest().getParameter("capStab");

    Connection db = null;

    try {
      db = this.getConnection(context);
      SintesisStabilimento stabEsistente = new SintesisStabilimento(db, idStabilimento);

      SintesisIndirizzo indStabilimento = stabEsistente.getIndirizzo();
      indStabilimento.setLatitudine(latitudine);
      indStabilimento.setLongitudine(longitudine);
      indStabilimento.setCap(cap);
      indStabilimento.aggiornaCoordinateCap(db);

      SintesisIndirizzo indResidenza = new SintesisIndirizzo();
      indResidenza.setNazione(nazioneResidenzaRappresentante);
      indResidenza.setIdProvincia(provinciaResidenzaRappresentante);
      indResidenza.setComune(comuneResidenzaRappresentante);
      indResidenza.setToponimo(toponimoResidenzaRappresentante);
      indResidenza.setVia(viaResidenzaRappresentante);
      indResidenza.setCivico(civicoResidenzaRappresentante);
      indResidenza.setCap(capResidenzaRappresentante);
      indResidenza.insertIndirizzo(db);

      SintesisIndirizzo indLegale = new SintesisIndirizzo();
      indLegale.setNazione(nazioneSedeLegale);
      indLegale.setIdProvincia(provinciaSedeLegale);
      indLegale.setComune(comuneSedeLegale);
      indLegale.setToponimo(toponimoSedeLegale);
      indLegale.setVia(viaSedeLegale);
      indLegale.setCivico(civicoSedeLegale);
      indLegale.setCap(capResidenzaRappresentante);
      indLegale.insertIndirizzo(db);

      SintesisOperatore opEsistente = stabEsistente.getOperatore();
      SintesisOperatore op = new SintesisOperatore();
      op.setTipoImpresa(tipoImpresa);
      op.setTipoSocieta(tipoSocieta);
      op.setDomicilioDigitale(domicilioDigitale);
      op.setIdIndirizzo(indLegale.getIdIndirizzo());
      op.setIdOperatore(opEsistente.getIdOperatore());

      if (op.isDiversoCompleta(db, opEsistente)) {
        SintesisStorico.salvaStoricoOperatoreCompleta(db, getUserId(context), opEsistente, op);
        op.setModifiedby(getUserId(context));
        op.aggiornaOperatoreCompleta(db);
      }

      SintesisSoggettoFisico soggEsistente = opEsistente.getRappLegale();
      SintesisSoggettoFisico sogg = new SintesisSoggettoFisico();
      sogg.setNome(nomeRappresentante);
      sogg.setCognome(cognomeRappresentante);
      sogg.setSesso(sessoRappresentante);
      sogg.setComuneNascita(comuneNascitaRappresentante);
      sogg.setNazioneNascita(nazioneNascitaRappresentante);
      sogg.setDataNascita(dataNascitaRappresentante);
      sogg.setCodiceFiscale(codiceFiscaleRappresentante);
      sogg.setDomicilioDigitale(domicilioDigitaleRappresentante);
      sogg.setIdIndirizzo(indResidenza.getIdIndirizzo());
      sogg.setId(soggEsistente.getId());

      if (sogg.isDiversoCompleta(db, soggEsistente)) {
        SintesisStorico.salvaStoricoSoggettoCompleta(db, getUserId(context), soggEsistente, sogg);
        sogg.setModifiedBy(getUserId(context));
        sogg.aggiornaSoggettoCompleta(db, op.getIdOperatore());
      }

      RicercheAnagraficheTab.insertSintesis(db, stabEsistente.getIdStabilimento());

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("id", String.valueOf(idStabilimento));
    return executeCommandDettaglioStabilimento(context);
  }
  public String executeCommandRifiutaRichiesta(ActionContext context) throws EncryptedDocumentException, IllegalArgumentException, IllegalAccessException, InvalidFormatException, IOException {

    if (!hasPermission(context, "sintesis-add")) {
      return ("PermissionError");
    }

    int id = -1;

    String idString = context.getRequest().getParameter("id");

    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}
    if (id == -1)
      idString = (String) context.getRequest().getAttribute("id");
    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}

    Connection db = null;

    try {
      db = this.getConnection(context);
      StabilimentoSintesisImport stab = new StabilimentoSintesisImport(db, id);
      stab.setIdUtenteProcess(getUserId(context));
      stab.rifiuta(db);
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandListaRichiesteAggregate(context);
  }

  public String executeCommandDownloadImport(ActionContext context) {

    // TODO Auto-generated method stub

    int idImport = -1;
    String path_server = "", titolo = "";

    idImport = Integer.parseInt(context.getRequest().getParameter("idImport"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      LogImport log = new LogImport(db, idImport);
      path_server = log.getFileImport();
      titolo = "Import_" + log.getId() + ".xls";

      String fileType = "";
      String fileName = path_server;

      if (new File(fileName).exists()) {
        // Find this file id in database to get file name, and file type

        // You must tell the browser the file type you are going to send
        // for example application/pdf, text/plain, text/html, image/jpg
        context.getResponse().setContentType(fileType);

        // Make sure to show the download dialog
        context.getResponse().setHeader("Content-disposition", "attachment; filename=" + titolo);

        // Assume file name is retrieved from database
        // For example D:\\file\\test.pdf

        File my_file = new File(fileName);

        // This should send the file to browser
        OutputStream out = context.getResponse().getOutputStream();
        FileInputStream in = new FileInputStream(my_file);
        byte[] buffer = new byte[4096];
        int length;
        while ((length = in.read(buffer)) > 0) {
          out.write(buffer, 0, length);
        }
        in.close();
        out.flush();
      } else {
        PrintWriter out = context.getResponse().getWriter();
        out.println("File non trovato!");
        out.println(fileName);
        out.println("Si e' verificato un problema con il recupero del file. Si prega di contattare l'HelpDesk.");
      }

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();

    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return ("-none-");

  }

  public String executeCommandEsitoImport(ActionContext context) {

    // TODO Auto-generated method stub

    int idImport = -1;

    try {
      idImport = Integer.parseInt(context.getRequest().getParameter("idImport"));
    } catch (Exception e) {}
    if (idImport == -1)
      try {
        idImport = Integer.parseInt((String) context.getRequest().getAttribute("idImport"));
      } catch (Exception e) {}

    String popup = context.getRequest().getParameter("popup");
    context.getRequest().setAttribute("popup", popup);

    Connection db = null;

    try {
      db = this.getConnection(context);

      LogImport log = new LogImport(db, idImport);
      context.getRequest().setAttribute("logImport", log);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    if (popup != null)
      return "EsitoImportPopupOK";

    return "EsitoImportOK";

  }

  public String executeCommandSearchFormStabilimento(ActionContext context) {
    return "SearchFormStabilimentoOK";
  }

  public String executeCommandSearchFormPratica(ActionContext context) throws EncryptedDocumentException, IllegalArgumentException, IllegalAccessException, InvalidFormatException, IOException {

    Connection db = null;

    try {
      db = this.getConnection(context);
      LogImport log = new LogImport();
      String msgSemaforo = log.checkSemaforo(db);
      if (msgSemaforo != null && !msgSemaforo.equals(""))
        return executeCommandPrepareImport(context);
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "SearchFormPraticaOK";

  }

  public String executeCommandSearchStabilimento(ActionContext context) {
    String ragioneSociale = context.getRequest().getParameter("ragioneSociale");
    String partitaIva = context.getRequest().getParameter("partitaIva");
    String approvalNumber = context.getRequest().getParameter("approvalNumber");
    String numeroIdentificativo = context.getRequest().getParameter("numeroIdentificativo");
    String targa = context.getRequest().getParameter("targa");

    ragioneSociale = ragioneSociale.trim();
    partitaIva = partitaIva.trim();
    approvalNumber = approvalNumber.trim();
    numeroIdentificativo = numeroIdentificativo.trim();
    targa = targa.trim();

    ArrayList < SintesisStabilimento > listaStabilimenti = new ArrayList < SintesisStabilimento > ();

    StringBuffer sql = new StringBuffer();
    sql.append("select distinct id from (" +
      "select s.id from sintesis_stabilimento s left join sintesis_operatore op on op.id = s.id_operatore left join sintesis_indirizzo ind on ind.id = s.id_indirizzo left join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id left join sintesis_automezzi sa on sa.id_sintesis_rel_stab_lp = rel.id where s.trashed_date is null and op.trashed_date is null and rel.trashed_date is null and sa.trashed_date is null and sa.data_dismissione is null");

    if (ragioneSociale != null && !ragioneSociale.equals(""))
      sql.append(" and op.ragione_sociale ilike ? ");
    if (partitaIva != null && !partitaIva.equals(""))
      sql.append(" and op.partita_iva ilike ? ");
    if (approvalNumber != null && !approvalNumber.equals(""))
      sql.append(" and s.approval_number ilike ? ");
    if (numeroIdentificativo != null && !numeroIdentificativo.equals(""))
      sql.append(" and sa.numero_identificativo ilike ? ");
    if (targa != null && !targa.equals(""))
      sql.append(" and sa.automezzo_targa ilike ? ");

    sql.append(" ORDER by s.id_operatore asc) aa");
    PreparedStatement pst;
    Connection db = null;

    try {
      db = this.getConnection(context);
      pst = db.prepareStatement(sql.toString());

      int i = 0;
      if (ragioneSociale != null && !ragioneSociale.equals(""))
        pst.setString(++i, "%" + ragioneSociale + "%");
      if (partitaIva != null && !partitaIva.equals(""))
        pst.setString(++i, "%" + partitaIva + "%");
      if (approvalNumber != null && !approvalNumber.equals(""))
        pst.setString(++i, "%" + approvalNumber + "%");
      if (numeroIdentificativo != null && !numeroIdentificativo.equals(""))
        pst.setString(++i, "%" + numeroIdentificativo + "%");
      if (targa != null && !targa.equals(""))
        pst.setString(++i, "%" + targa + "%");

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStabilimento stab = new SintesisStabilimento(db, rs.getInt("id"));
        listaStabilimenti.add(stab);
      }
      context.getRequest().setAttribute("listaStabilimenti", listaStabilimenti);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ListaStabilimentiOK";
  }

  public String executeCommandSearchPratica(ActionContext context) {

    String ragioneSociale = context.getRequest().getParameter("ragioneSociale");
    String partitaIva = context.getRequest().getParameter("partitaIva");
    String approvalNumber = context.getRequest().getParameter("approvalNumber");

    ragioneSociale = ragioneSociale.trim();
    partitaIva = partitaIva.trim();
    approvalNumber = approvalNumber.trim();

    StringBuffer sql = new StringBuffer();
    //sql.append("select * from sintesis_stabilimenti_import where stato_import = "+ StabilimentoSintesisImport.IMPORT_DA_VALIDARE+"  order by approval_number DESC, id DESC ");
    sql.append("select log.data_sintesis, s.* from sintesis_stabilimenti_import s left join sintesis_stabilimenti_import_log log on log.id = s.id_import where 1=1 and s.trashed_date is null ");

    if (ragioneSociale != null && !ragioneSociale.equals(""))
      sql.append(" and ragione_sociale_impresa ilike ? ");
    if (partitaIva != null && !partitaIva.equals(""))
      sql.append(" and partita_iva ilike ? ");
    if (approvalNumber != null && !approvalNumber.equals(""))
      sql.append(" and approval_number ilike ? ");

    sql.append(" order by approval_number DESC, id DESC ");

    PreparedStatement pst;

    Connection db = null;

    LinkedHashMap < String, ArrayList < StabilimentoSintesisImport >> listaRichieste = new LinkedHashMap < String, ArrayList < StabilimentoSintesisImport > > ();

    try {
      db = this.getConnection(context);
      pst = db.prepareStatement(sql.toString());

      int i = 0;
      if (ragioneSociale != null && !ragioneSociale.equals(""))
        pst.setString(++i, "%" + ragioneSociale + "%");
      if (partitaIva != null && !partitaIva.equals(""))
        pst.setString(++i, "%" + partitaIva + "%");
      if (approvalNumber != null && !approvalNumber.equals(""))
        pst.setString(++i, "%" + approvalNumber + "%");

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        StabilimentoSintesisImport stab = new StabilimentoSintesisImport(rs);

        String chiave = stab.getApprovalNumber() + ";;" + stab.getDenominazioneSedeOperativa() + ";;" + stab.getPartitaIva() + ";;" + stab.getStatoSedeOperativa();

        ArrayList < StabilimentoSintesisImport > listaRichiesteAggreg = listaRichieste.get(chiave);
        if (listaRichiesteAggreg == null) {
          listaRichiesteAggreg = new ArrayList < StabilimentoSintesisImport > ();
          listaRichiesteAggreg.add(stab);
        } else {
          listaRichiesteAggreg.add(stab);
        }

        listaRichieste.put(chiave, listaRichiesteAggreg);
      }

      context.getRequest().setAttribute("listaRichieste", listaRichieste);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }
    return "RichiesteAggregateListOK";
  }

  public String executeCommandListaProdottiLinea(ActionContext context) {

    String idRelazione = context.getRequest().getParameter("idRelazione");
    if (idRelazione == null)
      idRelazione = (String) context.getRequest().getAttribute("idRelazione");

    Connection db = null;

    try {
      db = this.getConnection(context);

      ArrayList < SuapMasterListSchedaAggiuntiva > listaSchede = new ArrayList < SuapMasterListSchedaAggiuntiva > ();

      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, Integer.parseInt(idRelazione));
      rel.setPathCompleto(db);
      SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());

      int idLinea = rel.getIdLineaMasterList();
      SuapMasterListLineaAttivita linea = new SuapMasterListLineaAttivita(db, idLinea);

      ArrayList < SuapMasterListSchedaAggiuntiva > listaSchedeAggiuntiveLinea = new ArrayList < SuapMasterListSchedaAggiuntiva > ();
      listaSchedeAggiuntiveLinea = SuapMasterListSchedaAggiuntiva.getElencoSchedeAggiuntive(db, rel.getIdRelazione(), linea);
      listaSchede.addAll(listaSchedeAggiuntiveLinea);

      context.getRequest().setAttribute("listaSchede", listaSchede);

      HashMap < Integer, SintesisProdotto > hashProdotti = new HashMap < Integer, SintesisProdotto > ();

      ArrayList < SintesisProdotto > listaProdottiLinea = SintesisProdotto.getListaProdottiPerLinea(db, rel.getIdRelazione(), "sintesis");

      for (int j = 0; j < listaProdottiLinea.size(); j++) {
        SintesisProdotto prod = (SintesisProdotto) listaProdottiLinea.get(j);
        hashProdotti.put(prod.getIdProdotto(), prod);
      }

      context.getRequest().setAttribute("hashProdotti", hashProdotti);

      context.getRequest().setAttribute("Stabilimento", stab);
      context.getRequest().setAttribute("Relazione", rel);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("esito", (String) context.getRequest().getAttribute("esito"));

    return "ListaProdottiOK";
  }

  public String executeCommandSalvaProdotti(ActionContext context) {

    if (!hasPermission(context, "sintesis-prodotti-edit")) {
      return ("PermissionError");
    }

    int totSchede = Integer.parseInt(context.getRequest().getParameter("totSchede"));
    int idStabilimento = Integer.parseInt(context.getRequest().getParameter("idStabilimento"));
    int idRelazione = Integer.parseInt(context.getRequest().getParameter("idRelazione"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      for (int i = 0; i < totSchede; i++) {

        int idProdotto = Integer.parseInt(context.getRequest().getParameter("idProdotto_" + i));
        boolean checked = false;
        if (context.getRequest().getParameter("cb_prod_" + i) != null)
          checked = true;
        String valore = context.getRequest().getParameter("valore_prod_" + i);

        SintesisProdotto prod = new SintesisProdotto();
        prod.setIdProdotto(idProdotto);
        prod.setIdLinea(idRelazione);
        prod.setIdStabilimento(idStabilimento);
        prod.setChecked(checked);
        prod.setValoreProdotto(valore);
        prod.setOrigine("sintesis");
        prod.gestisciUpdate(db);
      }
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }
    //	context.getRequest().setAttribute("id", String.valueOf(idStabilimento));
    //	context.getRequest().setAttribute("esito", "ok");
    //
    //	return executeCommandListaProdotti(context);

    context.getRequest().setAttribute("idRelazione", String.valueOf(idRelazione));
    context.getRequest().setAttribute("esito", "ok");

    return executeCommandListaProdottiLinea(context);

  }

  public String executeCommandViewVigilanza(ActionContext context) {

    if (!hasPermission(context, "sintesis-sintesis-vigilanza-view")) {
      return ("PermissionError");
    }

    Connection db = null;
    org.aspcfs.modules.vigilanza.base.TicketList ticList = new org.aspcfs.modules.vigilanza.base.TicketList();

    String tempAltId = context.getRequest().getParameter("altId");
    if (tempAltId == null) {
      tempAltId = "" +
        (Integer) context.getRequest().getAttribute("altId");
    }
    // String iter = context.getRequest().getParameter("tipo");
    Integer tempid = null;
    Integer altid = null;

    if (tempAltId != null) {
      altid = Integer.parseInt(tempAltId);
    }
    ticList.setAltId(altid);
    // Prepare PagedListInfo
    PagedListInfo ticketListInfo = this.getPagedListInfo(context,
      "AccountTicketInfo", "t.assigned_date", "desc");
    ticketListInfo.setLink(context.getAction().getActionName() + ".do?command=ViewVigilanza&altId=" + altid);
    ticList.setPagedListInfo(ticketListInfo);
    try {

      db = this.getConnection(context);

      SintesisStabilimento newStabilimento = new SintesisStabilimento(db, altid, true);
      newStabilimento.getPrefissoAction(context.getAction().getActionName());

      context.getRequest().setAttribute("OrgDetails", newStabilimento);

      SystemStatus systemStatus = this.getSystemStatus(context);
      LookupList TipoCampione = new LookupList(db,
        "lookup_tipo_controllo");
      TipoCampione.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("TipoCampione", TipoCampione);

      LookupList AuditTipo = new LookupList(db, "lookup_audit_tipo");
      AuditTipo.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("AuditTipo", AuditTipo);

      LookupList TipoAudit = new LookupList(db, "lookup_tipo_audit");
      TipoAudit.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("TipoAudit", TipoAudit);

      LookupList TipoIspezione = new LookupList(db,
        "lookup_tipo_ispezione");
      TipoIspezione.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("TipoIspezione", TipoIspezione);

      org.aspcfs.modules.vigilanza.base.TicketList controlliList = new org.aspcfs.modules.vigilanza.base.TicketList();
      controlliList.setAltId(newStabilimento.getAltId());
      /*
       * int punteggioAccumulato =
       * controlliList.buildListControlliUltimiAnni(db, passedId);
       * context.getRequest().setAttribute("punteggioUltimiAnni",
       * punteggioAccumulato);
       */
      LookupList EsitoCampione = new LookupList(db,
        "lookup_esito_campione");
      EsitoCampione.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("EsitoCampione", EsitoCampione);
      // find record permissions for portal users

      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      if (thisUser.getRoleId() == Role.RUOLO_CRAS)
        ticList.setIdRuolo(thisUser.getRoleId());

      ticList.buildList(db);

      context.getRequest().setAttribute("TicList", ticList);
      addModuleBean(context, "View Accounts", "Accounts View");
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      errorMessage.printStackTrace();
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return getReturn(context, "ViewVigilanza");
  }

  public String executeCommandDetails(ActionContext context) {

    //	if (!hasPermission(context, "sintesis-view")) {
    //		return ("PermissionError");
    //	}

    int id = -1;
    int altId = -1;

    String idString = context.getRequest().getParameter("id");
    String altIdString = context.getRequest().getParameter("altId");

    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}
    if (id == -1)
      idString = (String) context.getRequest().getAttribute("id");
    try {
      id = Integer.parseInt(idString);
    } catch (Exception e) {}

    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}
    if (altId == -1)
      altIdString = (String) context.getRequest().getAttribute("altId");
    try {
      altId = Integer.parseInt(altIdString);
    } catch (Exception e) {}

    Connection db = null;

    try {
      db = this.getConnection(context);

      if (id > 0) {
        context.getRequest().setAttribute("id", String.valueOf(id));
      } else if (altId > 0) {

        SintesisStabilimento stab = new SintesisStabilimento(db, altId, true);
        context.getRequest().setAttribute("id", String.valueOf(stab.getIdStabilimento()));
      }

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandDettaglioStabilimento(context);
  }

  public String executeCommandDettaglioStabilimentoDaRichiesta(ActionContext context) {

    //	if (!hasPermission(context, "sintesis-view")) {
    //		return ("PermissionError");
    //	}

    int idRichiesta = -1;
    int id = -1;

    String idRichiestaString = context.getRequest().getParameter("idRichiesta");

    try {
      idRichiesta = Integer.parseInt(idRichiestaString);
    } catch (Exception e) {}
    if (idRichiesta == -1)
      idRichiestaString = (String) context.getRequest().getAttribute("idRichiesta");
    try {
      idRichiesta = Integer.parseInt(idRichiestaString);
    } catch (Exception e) {}

    Connection db = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
      db = this.getConnection(context);
      pst = db.prepareStatement("select id_stabilimento from sintesis_storico_stabilimento where id_sintesis_stabilimenti_import  = ?");
      pst.setInt(1, idRichiesta);
      rs = pst.executeQuery();
      if (rs.next()) {
        id = rs.getInt("id_stabilimento");
      } else {
        pst = db.prepareStatement("select rel.id_stabilimento from sintesis_storico_relazione_stabilimento_linee_produttive st join sintesis_relazione_stabilimento_linee_produttive rel on rel.id = st.id_relazione  where st.id_sintesis_stabilimenti_import  = ?");
        pst.setInt(1, idRichiesta);
        rs = pst.executeQuery();
        if (rs.next())
          id = rs.getInt("id_stabilimento");
      }

      context.getRequest().setAttribute("id", String.valueOf(id));

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandDettaglioStabilimento(context);
  }

  public String executeCommandScadenzarioCondizionato(ActionContext context) {

    if (!hasPermission(context, "sintesis-scadenzario-view")) {
      return ("PermissionError");
    }

    ArrayList < SintesisStabilimento > listaStabilimenti = new ArrayList < SintesisStabilimento > ();

    StringBuffer sql = new StringBuffer();
    sql.append("select distinct id from (select s.id from sintesis_stabilimento s join sintesis_operatore op on op.id = s.id_operatore join sintesis_indirizzo ind on ind.id = s.id_indirizzo join sintesis_relazione_stabilimento_linee_produttive rel on rel.id_stabilimento = s.id where s.trashed_date is null and op.trashed_date is null and rel.trashed_date is null and s.stato = 2 and (rel.data_inizio is null or data_inizio <  now() - '6 months 15 days'::interval) order by s.id_operatore asc) aa");

    PreparedStatement pst;
    Connection db = null;

    try {
      db = this.getConnection(context);
      pst = db.prepareStatement(sql.toString());

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        SintesisStabilimento stab = new SintesisStabilimento(db, rs.getInt("id"));
        listaStabilimenti.add(stab);
      }
      context.getRequest().setAttribute("listaStabilimenti", listaStabilimenti);

      LookupList TipoImpresaList = new LookupList(db, "lookup_opu_tipo_impresa");
      context.getRequest().setAttribute("TipoImpresaList", TipoImpresaList);

      LookupList TipoSocietaList = new LookupList(db, "lookup_opu_tipo_impresa_societa");
      TipoSocietaList.addItem(-1, "Seleziona Tipo Societa");
      context.getRequest().setAttribute("TipoSocietaList", TipoSocietaList);

      ComuniAnagrafica c = new ComuniAnagrafica();
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, ((UserBean) context.getSession().getAttribute("User")).getSiteId());
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

      LookupList ProvinceList = new LookupList(db, "lookup_province");
      context.getRequest().setAttribute("ProvinceList", ProvinceList);

      LookupList StatiStabilimento = new LookupList(db, "lookup_stato_stabilimento_sintesis");
      context.getRequest().setAttribute("StatiStabilimento", StatiStabilimento);

      LookupList StatiLinea = new LookupList(db, "lookup_stato_attivita_sintesis");
      context.getRequest().setAttribute("StatiLinea", StatiLinea);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ScadenzarioOK";
  }

  public String executeCommandStoricoImport(ActionContext context) {

    if (!hasPermission(context, "sintesis-storico-view")) {
      return ("PermissionError");
    }

    String tutti = context.getRequest().getParameter("tutti");
    context.getRequest().setAttribute("tutti", tutti);

    ArrayList < LogImport > listaImport = new ArrayList < LogImport > ();

    StringBuffer sql = new StringBuffer();
    sql.append("select * from sintesis_stabilimenti_import_log order by entered desc ");
    if (tutti == null || !"si".equals(tutti))
      sql.append(" limit 20");

    PreparedStatement pst;

    Connection db = null;

    try {
      db = this.getConnection(context);
      pst = db.prepareStatement(sql.toString());

      ResultSet rs = pst.executeQuery();

      while (rs.next()) {
        LogImport log = new LogImport(rs);
        listaImport.add(log);
      }

      context.getRequest().setAttribute("listaImport", listaImport);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ImportLogListOK";
  }

  public String executeCommandListaAutomezziLinea(ActionContext context) {

    //	if (!hasPermission(context, "sintesis-scarrabili-view")) {
    //		return ("PermissionError");
    //	}

    int idRelazione = -1;

    try {
      idRelazione = (Integer)(context.getRequest().getAttribute("idRelazione"));
    } catch (Exception e) {}
    if (idRelazione == -1)
      idRelazione = Integer.parseInt(context.getRequest().getParameter("idRelazione"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, idRelazione);
      rel.setPathCompleto(db);
      SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());

      context.getRequest().setAttribute("Stabilimento", stab);
      context.getRequest().setAttribute("Relazione", rel);

      ArrayList < SintesisAutomezzo > listaAutomezzi = new ArrayList < SintesisAutomezzo > ();

      int idLinea = rel.getIdLineaMasterList();
      SuapMasterListLineaAttivita linea = new SuapMasterListLineaAttivita(db, idLinea);

      if (!linea.getCodiceUnivoco().equals("1069-R-37-TRANS") && !linea.getCodiceUnivoco().equals("1069-R-38-TRANS") && !linea.getCodiceUnivoco().equals("1069-R-39-TRANS")) {
        context.getRequest().setAttribute("Errore", "La linea selezionata non prevede la gestione degli automezzi.");
        context.getRequest().setAttribute("CloseWindow", "si");
        return "ListaAutomezziOK";
      }

      ArrayList < SintesisAutomezzo > listaAutomezziLinea = new ArrayList < SintesisAutomezzo > ();
      listaAutomezziLinea = SintesisAutomezzo.getElencoAutomezzi(db, rel.getIdRelazione());
      listaAutomezzi.addAll(listaAutomezziLinea);
      context.getRequest().setAttribute("listaAutomezzi", listaAutomezzi);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ListaAutomezziOK";
  }

  public String executeCommandDettaglioAutomezzo(ActionContext context) {

    //	if (!hasPermission(context, "sintesis-scarrabili-view")) {
    //		return ("PermissionError");
    //	}

    int id = -1;

    try {
      id = (Integer)(context.getRequest().getAttribute("id"));
    } catch (Exception e) {}
    if (id == -1)
      id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisAutomezzo automezzo = new SintesisAutomezzo(db, id);
      context.getRequest().setAttribute("Automezzo", automezzo);

      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, automezzo.getIdRelazione());
      rel.setPathCompleto(db);
      context.getRequest().setAttribute("Relazione", rel);
      SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());
      context.getRequest().setAttribute("Stabilimento", stab);

      ComuniAnagrafica c = new ComuniAnagrafica();
      //c.setInRegione(true);
      ArrayList < ComuniAnagrafica > listaComuni = c.buildList_all(db, -1);
      LookupList comuniList = new LookupList();
      comuniList.queryListComuni(listaComuni, -1);
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      LookupList provinceList = new LookupList(db, "lookup_province");
      provinceList.addItem(-1, "");
      context.getRequest().setAttribute("ProvinceList", provinceList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    if (context.getRequest().getParameter("print") != null && context.getRequest().getParameter("print").equals("print"))
      return "StampaAutomezzoOK";
    return "DettaglioAutomezzoOK";
  }

  public String executeCommandModificaAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-edit")) {
      return ("PermissionError");
    }

    int id = -1;

    try {
      id = (Integer)(context.getRequest().getAttribute("id"));
    } catch (Exception e) {}
    if (id == -1)
      id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisAutomezzo automezzo = new SintesisAutomezzo(db, id);
      context.getRequest().setAttribute("Automezzo", automezzo);

      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, automezzo.getIdRelazione());
      rel.setPathCompleto(db);
      context.getRequest().setAttribute("Relazione", rel);
      SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());
      context.getRequest().setAttribute("Stabilimento", stab);

      LookupList provinceList = new LookupList(db, "lookup_province");
      provinceList.addItem(-1, "");
      context.getRequest().setAttribute("ProvinceList", provinceList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "ModificaAutomezzoOK";
  }

  public String executeCommandEliminaAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-delete")) {
      return ("PermissionError");
    }

    int id = -1;

    try {
      id = (Integer)(context.getRequest().getAttribute("id"));
    } catch (Exception e) {}
    if (id == -1)
      id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisAutomezzo automezzo = new SintesisAutomezzo(db, id);
      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, automezzo.getIdRelazione());

      String controlli = null;
      controlli = automezzo.getCuAssociati(db);
      if (controlli != null) {
        context.getRequest().setAttribute("Errore", "Impossibile cancellare questo automezzo. Risulta associato ai seguenti CU: " + controlli);
      } else {
        automezzo.delete(db, getUserId(context));
        RicercheAnagraficheTab.insertSintesis(db, rel.getIdStabilimento());

      }

      context.getRequest().setAttribute("idRelazione", automezzo.getIdRelazione());

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandListaAutomezziLinea(context);
  }

  public String executeCommandDismettiAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-edit")) {
      return ("PermissionError");
    }

    int id = -1;

    try {
      id = (Integer)(context.getRequest().getAttribute("id"));
    } catch (Exception e) {}
    if (id == -1)
      id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisAutomezzo automezzo = new SintesisAutomezzo(db, id);
      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, automezzo.getIdRelazione());
      automezzo.dismetti(db, getUserId(context));
      RicercheAnagraficheTab.insertSintesis(db, rel.getIdStabilimento());

      context.getRequest().setAttribute("idRelazione", automezzo.getIdRelazione());

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return executeCommandListaAutomezziLinea(context);
  }

  public String executeCommandAggiungiAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-add")) {
      return ("PermissionError");
    }

    int idRelazione = -1;

    try {
      idRelazione = (Integer)(context.getRequest().getAttribute("idRelazione"));
    } catch (Exception e) {}
    if (idRelazione == -1)
      idRelazione = Integer.parseInt(context.getRequest().getParameter("idRelazione"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, idRelazione);
      rel.setPathCompleto(db);
      SintesisStabilimento stab = new SintesisStabilimento(db, rel.getIdStabilimento());

      context.getRequest().setAttribute("Stabilimento", stab);
      context.getRequest().setAttribute("Relazione", rel);

      LookupList provinceList = new LookupList(db, "lookup_province");
      provinceList.addItem(-1, "");
      context.getRequest().setAttribute("ProvinceList", provinceList);

      LookupList listaToponimi = new LookupList();
      listaToponimi.setTable("lookup_toponimi");
      listaToponimi.buildList(db);
      context.getRequest().setAttribute("ToponimiList", listaToponimi);

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }

    return "AggiungiAutomezzoOK";
  }

  public String executeCommandAggiornaAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-edit")) {
      return ("PermissionError");
    }

    int id = -1;

    try {
      id = (Integer)(context.getRequest().getAttribute("id"));
    } catch (Exception e) {}
    if (id == -1)
      id = Integer.parseInt(context.getRequest().getParameter("id"));

    Connection db = null;

    try {
      db = this.getConnection(context);

      SintesisAutomezzo automezzoOld = new SintesisAutomezzo(db, id);
      SintesisAutomezzo automezzoNew = new SintesisAutomezzo(db, id);
      automezzoNew.buildFromRequest(context);
      automezzoOld.insertStorico(db, getUserId(context));
      automezzoNew.update(db, getUserId(context));
      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, automezzoNew.getIdRelazione());
      RicercheAnagraficheTab.insertSintesis(db, rel.getIdStabilimento());
      context.getRequest().setAttribute("id", automezzoNew.getId());

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }
    return executeCommandDettaglioAutomezzo(context);
  }

  public String executeCommandInserisciAutomezzo(ActionContext context) {

    if (!hasPermission(context, "sintesis-scarrabili-add")) {
      return ("PermissionError");
    }

    int idRelazione = -1;

    try {
      idRelazione = (Integer)(context.getRequest().getAttribute("idRelazione"));
    } catch (Exception e) {}
    if (idRelazione == -1)
      idRelazione = Integer.parseInt(context.getRequest().getParameter("idRelazione"));

    Connection db = null;

    try {
      db = this.getConnection(context);
      SintesisRelazioneLineaProduttiva rel = new SintesisRelazioneLineaProduttiva(db, idRelazione);

      SintesisAutomezzo automezzo = new SintesisAutomezzo();
      automezzo.buildFromRequest(context);
      automezzo.setIdRelazione(idRelazione);
      automezzo.insert(db, getUserId(context));
      automezzo.generaNumeroIdentificativo(db);
      RicercheAnagraficheTab.insertSintesis(db, rel.getIdStabilimento());
      context.getRequest().setAttribute("id", automezzo.getId());

    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      this.freeConnection(context, db);
    }
    return executeCommandDettaglioAutomezzo(context);
  }

  public String executeCommandSetCodiceSINVSA(ActionContext context) throws SQLException {
    String codice = context.getRequest().getParameter("codice-sinvsa");
    String dataCodice = context.getRequest().getParameter("data-codice-sinvsa");
    int riferimentoId = Integer.parseInt(context.getRequest().getParameter("riferimento-id"));
    String riferimentoId_nomeTab = context.getRequest().getParameter("riferimento-id-nome-tab");
    int userId = Integer.parseInt(context.getRequest().getParameter("user-id"));

    context.getRequest().setAttribute("stabId", String.valueOf(riferimentoId));

    try {
      PopolaCombo.setCodiceSINVSA(codice, dataCodice, riferimentoId, riferimentoId_nomeTab, userId);
    } catch (SQLException e) {
      throw e;
    }

    return this.executeCommandDettaglioStabilimento(context);
  }

}