package org.aspcfs.modules.registrotrasgressori.action;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.aspcf.modules.controlliufficiali.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiUpload;
import org.aspcfs.modules.registrotrasgressori.base.AnagraficaPagatore;
import org.aspcfs.modules.registrotrasgressori.base.ImportoOrdinanza;
import org.aspcfs.modules.registrotrasgressori.base.NotificaPagatore;
import org.aspcfs.modules.registrotrasgressori.base.Pagamento;
import org.aspcfs.modules.registrotrasgressori.base.Trasgressione;
import org.aspcfs.modules.registrotrasgressori.utils.PagoPaUtil;
import org.aspcfs.modules.sanzioni.base.Ticket;
import org.aspcfs.modules.util.imports.ApplicationProperties;

import com.darkhorseventures.framework.actions.ActionContext;
import com.sun.org.apache.bcel.internal.generic.RET;

public class GestionePagoPa extends CFSModule{

	public String executeCommandSearchFormPagatore(ActionContext context) {

		String trasgressoreObbligato = context.getRequest().getParameter("trasgressoreObbligato");
		context.getRequest().setAttribute("trasgressoreObbligato", trasgressoreObbligato);

		return "PagatoriSearchOK";

	}

	public String executeCommandSearchPagatore(ActionContext context) {


		String nome = context.getRequest().getParameter("nome");
		String piva = context.getRequest().getParameter("piva");
		String trasgressoreObbligato = context.getRequest().getParameter("trasgressoreObbligato");

		ArrayList<String> pagatori = new ArrayList<String>();
		Connection db = null;
		try {
			db = this.getConnection(context);
			PreparedStatement pst = db.prepareStatement("select * from pagopa_cerca_pagatore(?, ?)");
			int i = 0;
			pst.setString(++i, nome);
			pst.setString(++i, piva);
			ResultSet rs = pst.executeQuery();
			while (rs.next()){
				String origine = rs.getString("origine");
				String ragione_sociale_nominativo = rs.getString("ragione_sociale_nominativo");
				String piva_cf = rs.getString("piva_cf");
				String indirizzo = rs.getString("indirizzo");
				String civico = rs.getString("civico");
				String cap = rs.getString("cap");
				String comune = rs.getString("comune");
				String cod_provincia = rs.getString("cod_provincia");
				String nazione = rs.getString("nazione");
				String domicilio_digitale = rs.getString("domicilio_digitale");
				String telefono = rs.getString("telefono");
				String tipo = rs.getString("tipo_pagatore");

				pagatori.add(
						origine
						+";;"+ragione_sociale_nominativo
						+";;"+piva_cf
						+";;"+indirizzo
						+";;"+civico
						+";;"+cap
						+";;"+comune
						+";;"+cod_provincia
						+";;"+nazione
						+";;"+domicilio_digitale
						+";;"+telefono
						+";;"+tipo
						+";;--;;");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("listaPagatori", pagatori);
		context.getRequest().setAttribute("trasgressoreObbligato", trasgressoreObbligato);

		return "PagatoriResultsOK";

	}

	public String executeCommandView(ActionContext context) {

		if (!hasPermission(context, "pagopa_gestione-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;
		String origine = null;

		try { idSanzione = Integer.parseInt(context.getRequest().getParameter("idSanzione")); } catch (Exception e){};

		if (idSanzione==-1)
			idSanzione = (Integer) context.getRequest().getAttribute("idSanzione");

		origine = context.getRequest().getParameter("origine");
		if (origine==null)
			origine = (String) context.getRequest().getAttribute("origine");

		int idControllo = -1;
		if (idControllo==-1)
			try {idControllo = (Integer) context.getRequest().getAttribute("idControllo");} catch(Exception e){}
		if (idControllo>0){
			context.getRequest().setAttribute("idControllo", String.valueOf(idControllo));
			return origine+"PagamentoAddOK"; 
		}

		String messaggio = "";

		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
		ArrayList<Pagamento> listaPagamentiScaduti = new ArrayList<Pagamento>();

		Connection db = null;
		try {
			db = this.getConnection(context);

			Ticket sanzione = new Ticket(db, idSanzione);
			context.getRequest().setAttribute("SanzioneDettaglio", sanzione);

			listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, getUserId(context));
			listaPagamentiScaduti = Pagamento.getListaPagamentiScaduti(db, idSanzione, getUserId(context));

			AnagraficaPagatore trasgressore = new AnagraficaPagatore(db, idSanzione, "T");
			AnagraficaPagatore obbligato = new AnagraficaPagatore(db, idSanzione, "O");

			if (trasgressore.getId()==-1){
				trasgressore.setRagioneSocialeNominativo(sanzione.getTrasgressore());
				trasgressore.upsert(db, idSanzione, "T", getUserId(context));
			}
			if (obbligato.getId()==-1 && sanzione.getObbligatoinSolido()!=null && !sanzione.getObbligatoinSolido().equalsIgnoreCase("nessuno")){
				obbligato.setRagioneSocialeNominativo(sanzione.getObbligatoinSolido());
				obbligato.upsert(db, idSanzione, "O", getUserId(context));
			}

			context.getRequest().setAttribute("Trasgressore", trasgressore);
			context.getRequest().setAttribute("Obbligato", obbligato);


			double[] importiTotaliOrdinanza = Pagamento.getImportiTotaliOrdinanza(db, idSanzione); 
			context.getRequest().setAttribute("importoTotaleRichiesto", String.format(Locale.US, "%.2f", importiTotaliOrdinanza[0]));
			context.getRequest().setAttribute("importoTotaleVersato", String.format(Locale.US, "%.2f", importiTotaliOrdinanza[1]));
			context.getRequest().setAttribute("importoTotaleResiduo", String.format(Locale.US, "%.2f", importiTotaliOrdinanza[2]));
			
			boolean possibilitaRigenera = Pagamento.getPossibilitaRigeneraOrdinanza(db, idSanzione);
			context.getRequest().setAttribute("possibilitaRigenera", String.valueOf(possibilitaRigenera));
			
			boolean semaforoAttivo = PagoPaUtil.verificaSemaforoAttivo(db, idSanzione);
			context.getRequest().setAttribute("semaforoAttivo", String.valueOf(semaforoAttivo));
			
			ArrayList<Integer> doppiPagamenti = Pagamento.getDoppiPagamenti(db, idSanzione);  
			context.getRequest().setAttribute("doppiPagamenti", doppiPagamenti);

			if ( context.getRequest().getAttribute("messaggio") != null)
				messaggio = messaggio + ((String) context.getRequest().getAttribute("messaggio"));
			context.getRequest().setAttribute("messaggio", messaggio);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("listaPagamenti", listaPagamenti);
		context.getRequest().setAttribute("listaPagamentiScaduti", listaPagamentiScaduti);

		if (listaPagamenti.size()>0){
			return origine+"PagamentiListOK";
		}
		else {
			return origine+"PagamentoAddOK";   
		}

	}

	public String executeCommandInsertProcessoVerbale(ActionContext context) throws ParseException {

		if (!hasPermission(context, "pagopa_genera_processo_verbale-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		String origine = context.getRequest().getParameter("origine");

		String tipoPagatoreT = context.getRequest().getParameter("tipoPagatoreT");
		String pivaT = context.getRequest().getParameter("pivaT");
		String nomeT = context.getRequest().getParameter("nomeT");
		String indirizzoT = context.getRequest().getParameter("indirizzoT");
		String civicoT = context.getRequest().getParameter("civicoT");
		String capT = context.getRequest().getParameter("capT");
		String comuneT = context.getRequest().getParameter("comuneT");
		String provinciaT = context.getRequest().getParameter("provinciaT");
		String nazioneT = context.getRequest().getParameter("nazioneT");
		String mailT = context.getRequest().getParameter("mailT");
		String telefonoT = context.getRequest().getParameter("telefonoT");

		AnagraficaPagatore trasgressore = new AnagraficaPagatore(tipoPagatoreT, pivaT, nomeT, indirizzoT, civicoT, capT, comuneT, provinciaT, nazioneT, mailT, telefonoT);

		String tipoPagatoreO = context.getRequest().getParameter("tipoPagatoreO");
		String pivaO = context.getRequest().getParameter("pivaO");
		String nomeO = context.getRequest().getParameter("nomeO");
		String indirizzoO = context.getRequest().getParameter("indirizzoO");
		String civicoO = context.getRequest().getParameter("civicoO");
		String capO = context.getRequest().getParameter("capO");
		String comuneO = context.getRequest().getParameter("comuneO");
		String provinciaO = context.getRequest().getParameter("provinciaO");
		String nazioneO = context.getRequest().getParameter("nazioneO");
		String mailO = context.getRequest().getParameter("mailO");
		String telefonoO = context.getRequest().getParameter("telefonoO");

		AnagraficaPagatore obbligato = new AnagraficaPagatore(tipoPagatoreO, pivaO, nomeO, indirizzoO, civicoO, capO, comuneO, provinciaO, nazioneO, mailO, telefonoO);

		double importoTotaleVersamento = -1;
		try { importoTotaleVersamento = Double.parseDouble(context.getRequest().getParameter("importoTotaleVersamento_1")); } catch (Exception e) {};
		String tipoPagamento = context.getRequest().getParameter("tipoPagamento_1");

		double importoTotaleVersamento2 = -1;
		try { importoTotaleVersamento2 = Double.parseDouble(context.getRequest().getParameter("importoTotaleVersamento_2")); } catch (Exception e) {};
		String tipoPagamento2 = context.getRequest().getParameter("tipoPagamento_2");

		String dataNotificaT = context.getRequest().getParameter("dataNotificaT");
		String tipoNotificaT = context.getRequest().getParameter("tipoNotificaT");

		String dataNotificaO = context.getRequest().getParameter("dataNotificaO");
		String tipoNotificaO = context.getRequest().getParameter("tipoNotificaO");

		String messaggio = "";

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di generazione massiva IUV (Processo Verbale)");
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

			trasgressore.upsert(db,  idSanzione,  "T",  getUserId(context));
			obbligato.upsert(db,  idSanzione,  "O",  getUserId(context)); 

			if (trasgressore!=null)
				NotificaPagatore.insert(db, trasgressore.getId(), idSanzione, tipoNotificaT, dataNotificaT, getUserId(context));			
			if (obbligato!=null)
				NotificaPagatore.insert(db, obbligato.getId(), idSanzione, tipoNotificaO, dataNotificaO, getUserId(context)); 

			Pagamento p = new Pagamento();
			p.setIndice(1);
			p.setTipoRiduzione("R");
			p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoTotaleVersamento));
			p.setPagatore(trasgressore);
			p.setIdSanzione(idSanzione);
			p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaT, tipoNotificaT, tipoPagamento, "R", -1));
			p.setTipoPagamento(tipoPagamento);
			p.insert(db, getUserId(context));
			p.importaDovuto(db, getUserId(context));

			if (p.getEsitoInvio().equalsIgnoreCase("OK"))
				messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Pagamento Ridotto)\\nGenerato con successo!\\n\\n";
			else {
				messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Pagamento Ridotto)\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
				context.getRequest().setAttribute("idSanzione", idSanzione);
				context.getRequest().setAttribute("origine", origine);
				messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
				context.getRequest().setAttribute("messaggio", messaggio);
				return executeCommandAnnullaTutto(context);
			}

			if (obbligato!=null && obbligato.getId()>0){
				p = new Pagamento();
				p.setIndice(1);
				p.setTipoRiduzione("R");
				p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoTotaleVersamento));
				p.setPagatore(obbligato);
				p.setIdSanzione(idSanzione);
				p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaO, tipoNotificaO, tipoPagamento, "R", -1));
				p.setTipoPagamento(tipoPagamento);
				p.insert(db, getUserId(context));
				p.importaDovuto(db, getUserId(context));

				if (p.getEsitoInvio().equalsIgnoreCase("OK"))
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Pagamento Ridotto)\\nGenerato con successo!\\n\\n";
				else {
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Pagamento Ridotto)\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					context.getRequest().setAttribute("idSanzione", idSanzione);
					context.getRequest().setAttribute("origine", origine);
					messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
					context.getRequest().setAttribute("messaggio", messaggio);
					return executeCommandAnnullaTutto(context);
				}
			} 

			if (importoTotaleVersamento2>0){

				p = new Pagamento();
				p.setIndice(2);
				p.setTipoRiduzione("U");
				p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoTotaleVersamento2));
				p.setPagatore(trasgressore);
				p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaT, tipoNotificaT, tipoPagamento, "U", -1));
				p.setIdSanzione(idSanzione);
				p.setTipoPagamento(tipoPagamento2);
				p.insert(db, getUserId(context));
				p.importaDovuto(db, getUserId(context));

				if (p.getEsitoInvio().equalsIgnoreCase("OK"))
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Pagamento UltraRidotto)\\nGenerato con successo!\\n\\n";
				else {
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Pagamento UltraRidotto)\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					context.getRequest().setAttribute("idSanzione", idSanzione);
					context.getRequest().setAttribute("origine", origine);
					messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
					context.getRequest().setAttribute("messaggio", messaggio);
					return executeCommandAnnullaTutto(context);
				}

				if (obbligato!=null && obbligato.getId()>0){
					p = new Pagamento();
					p.setIndice(2);
					p.setTipoRiduzione("U");
					p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoTotaleVersamento2));
					p.setPagatore(obbligato);
					p.setIdSanzione(idSanzione);
					p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaO, tipoNotificaO, tipoPagamento, "U", -1));
					p.setTipoPagamento(tipoPagamento2);
					p.insert(db, getUserId(context));
					p.importaDovuto(db, getUserId(context));

					if (p.getEsitoInvio().equalsIgnoreCase("OK"))
						messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Pagamento UltraRidotto)\\nGenerato con successo!\\n\\n";
					else {
						messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Pagamento UltraRidotto)\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
						context.getRequest().setAttribute("idSanzione", idSanzione);
						context.getRequest().setAttribute("origine", origine);
						messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
						context.getRequest().setAttribute("messaggio", messaggio);
						return executeCommandAnnullaTutto(context);
					}
				}
			}

			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);

		} catch (SQLException e) { 
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		messaggio = "<b><font color='green'>Tutti gli avvisi sono stati generati.</font></b>\\n\\n"+messaggio;

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);

		return executeCommandView(context);

	}

	public String executeCommandInsertNumeroOrdinanza(ActionContext context) throws ParseException {

		if (!hasPermission(context, "pagopa_genera_numero_ordinanza-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		String origine = context.getRequest().getParameter("origine");

		String tipoPagatoreT = context.getRequest().getParameter("tipoPagatoreT");
		String pivaT = context.getRequest().getParameter("pivaT");
		String nomeT = context.getRequest().getParameter("nomeT");
		String indirizzoT = context.getRequest().getParameter("indirizzoT");
		String civicoT = context.getRequest().getParameter("civicoT");
		String capT = context.getRequest().getParameter("capT");
		String comuneT = context.getRequest().getParameter("comuneT");
		String provinciaT = context.getRequest().getParameter("provinciaT");
		String nazioneT = context.getRequest().getParameter("nazioneT");
		String mailT = context.getRequest().getParameter("mailT");
		String telefonoT = context.getRequest().getParameter("telefonoT");

		AnagraficaPagatore trasgressore = new AnagraficaPagatore(tipoPagatoreT, pivaT, nomeT, indirizzoT, civicoT, capT, comuneT, provinciaT, nazioneT, mailT, telefonoT);

		String tipoPagatoreO = context.getRequest().getParameter("tipoPagatoreO");
		String pivaO = context.getRequest().getParameter("pivaO");
		String nomeO = context.getRequest().getParameter("nomeO");
		String indirizzoO = context.getRequest().getParameter("indirizzoO");
		String civicoO = context.getRequest().getParameter("civicoO");
		String capO = context.getRequest().getParameter("capO");
		String comuneO = context.getRequest().getParameter("comuneO");
		String provinciaO = context.getRequest().getParameter("provinciaO");
		String nazioneO = context.getRequest().getParameter("nazioneO");
		String mailO = context.getRequest().getParameter("mailO");
		String telefonoO = context.getRequest().getParameter("telefonoO");

		AnagraficaPagatore obbligato = new AnagraficaPagatore(tipoPagatoreO, pivaO, nomeO, indirizzoO, civicoO, capO, comuneO, provinciaO, nazioneO, mailO, telefonoO);

		double importoTotaleVersamento = (Double.parseDouble(context.getRequest().getParameter("importoTotaleVersamento")));
		double importoSingolaRata = 0;

		String tipoPagamento = context.getRequest().getParameter("tipoPagamento");
		int numeroRate = (Integer.parseInt(context.getRequest().getParameter("numeroRate")));

		importoSingolaRata = importoTotaleVersamento/numeroRate;

		String dataNotificaT = context.getRequest().getParameter("dataNotificaT");
		String tipoNotificaT = context.getRequest().getParameter("tipoNotificaT");

		String dataNotificaO = context.getRequest().getParameter("dataNotificaO");
		String tipoNotificaO = context.getRequest().getParameter("tipoNotificaO");

		String messaggio = "";

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di generazione massiva IUV (Numero Ordinanza)");
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

			trasgressore.upsert(db,  idSanzione,  "T",  getUserId(context));
			obbligato.upsert(db,  idSanzione,  "O",  getUserId(context));

			if (trasgressore!=null)
				NotificaPagatore.insert(db, trasgressore.getId(), idSanzione, tipoNotificaT, dataNotificaT, getUserId(context));
			if (obbligato!=null)
				NotificaPagatore.insert(db, obbligato.getId(), idSanzione, tipoNotificaO, dataNotificaO, getUserId(context));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		for (int i = 1; i<=numeroRate; i++){

			try {

				db = this.getConnection(context);

				Pagamento p = new Pagamento();
				p.setIndice(i);
				p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoSingolaRata));
				p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaT, "", tipoPagamento, "", i));
				p.setPagatore(trasgressore);
				p.setIdSanzione(idSanzione);
				p.setTipoPagamento(tipoPagamento);
				p.setNumeroRate(numeroRate);
				p.insert(db, getUserId(context));
				p.importaDovuto(db, getUserId(context));

				if (p.getEsitoInvio().equalsIgnoreCase("OK"))
					messaggio=messaggio;//messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Rata "+(p.getIndice())+" )\\nGenerato con successo!\\n\\n";
				else {
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Rata "+(p.getIndice())+")\\nNon generato! <font color='red'>Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					context.getRequest().setAttribute("idSanzione", idSanzione);
					context.getRequest().setAttribute("origine", origine);
					messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
					context.getRequest().setAttribute("messaggio", messaggio);
					return executeCommandAnnullaTutto(context);
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}
		}

		if (obbligato!=null && obbligato.getId()>0){
			for (int i = 1; i<=numeroRate; i++){
				try {

					db = this.getConnection(context);

					Pagamento p = new Pagamento();
					p.setIndice(i);
					p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoSingolaRata));
					p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaO, "", tipoPagamento, "", i));
					p.setPagatore(obbligato);
					p.setIdSanzione(idSanzione);
					p.setTipoPagamento(tipoPagamento);
					p.setNumeroRate(numeroRate);
					p.insert(db, getUserId(context));
					p.importaDovuto(db, getUserId(context));

					if (p.getEsitoInvio().equalsIgnoreCase("OK"))
						messaggio=messaggio;//messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Rata "+(p.getIndice())+" )\\nGenerato con successo!\\n\\n";
					else {
						messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Rata "+(p.getIndice())+")\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
						context.getRequest().setAttribute("idSanzione", idSanzione);
						context.getRequest().setAttribute("origine", origine);
						messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
						context.getRequest().setAttribute("messaggio", messaggio);
						return executeCommandAnnullaTutto(context);
					}

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return ("SystemError");
				}
				finally
				{
					this.freeConnection(context, db);
				}
			}
		} 

		try {

			db = this.getConnection(context);

			ImportoOrdinanza.insert(db, idSanzione, String.valueOf(importoTotaleVersamento), numeroRate, "", true, getUserId(context));
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}	

		messaggio = "<b><font color='green'>Tutti gli avvisi sono stati generati.</font></b>\\n\\n"+messaggio;

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandUpdate(ActionContext context) {

		if (!hasPermission(context, "pagopa_modifica_notifica-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		String dataScadenza = context.getRequest().getParameter("dataScadenza_"+idPagamento);

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di aggiornamento IUV");

			Pagamento p = new Pagamento(db, idPagamento);
			p.setDataScadenza(dataScadenza);
			p.update(db, getUserId(context));
			p.aggiornaDovuto(db, getUserId(context));

			if (p.getEsitoInvio().equalsIgnoreCase("OK"))
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa data di scadenza del pagamento e' stata aggiornata con successo.\\n\\n");
			else
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa data di scadenza del pagamento non e' stata aggiornata. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"\\n\\n");


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandAnnulla(ActionContext context) {

		if (!hasPermission(context, "pagopa_annulla_singolo-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di annullamento IUV");

			Pagamento p = new Pagamento(db, idPagamento);
			p.chiediPagati(db, false, getUserId(context));

			if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento())) {
				p.annullaDovuto(db, getUserId(context));

				if (p.getEsitoInvio().equalsIgnoreCase("OK")){
					p.delete(db, getUserId(context));
					context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento e' stato annullato con successo.\\n\\n");
				}
				else
					context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n");
			}
			else 
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: lo stato del pagamento risulta IN CORSO o COMPLETATO.</font>\\n\\n");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandElimina(ActionContext context) {  

		if (!hasPermission(context, "pagopa_elimina_singolo-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di eliminazione IUV");

			Pagamento p = new Pagamento(db, idPagamento);
			p.chiediPagati(db, false, getUserId(context));

			if (p.getIdentificativoUnivocoVersamento()==null || (p.getStatoPagamento()==null || (!Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento()) && !Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(p.getStatoPagamento()) && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())))){
				p.delete(db, getUserId(context));
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento e' stato eliminato con successo.\\n\\n");
			} else {
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: l'avviso di pagamento risulta esistente in PagoPA.</font>\\n\\n");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}
	
	public String executeCommandTestPaga(ActionContext context) {    

		if (!hasPermission(context, "pagopa_paga_singolo-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di pagamento IUV");

			Pagamento p = new Pagamento(db, idPagamento);

			if (p.getIdentificativoUnivocoVersamento()!=null && p.getStatoPagamento()!=null && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())){
				p.testPaga(db, getUserId(context));
				
				try {
					PagoPaUtil.generaPdfRicevuta(context, null, null, db, p.getIdSanzione(), p.getId());
				} catch (ServletException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento e' stato pagato con successo.\\n\\n");
			} else {
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato pagato. Motivazione: lo stato non risulta pagabile.</font>\\n\\n");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}
	
	public String executeCommandTestScadi(ActionContext context) {    

		if (!hasPermission(context, "pagopa_scadi_singolo-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di scadenza IUV");

			Pagamento p = new Pagamento(db, idPagamento);

			if (p.getIdentificativoUnivocoVersamento()!=null && p.getStatoPagamento()!=null && !Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())){
				p.testScadi(db, getUserId(context));
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento e' stato fatto scadere con successo.\\n\\n");
			} else {
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato fatto scadere. Motivazione: lo stato non risulta scadente.</font>\\n\\n");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandAnnullaTutto(ActionContext context) {

		if (!hasPermission(context, "pagopa_annulla_tutto-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;

		try { idSanzione = ((int) context.getRequest().getAttribute("idSanzione"));} catch (Exception e) {};

		if (idSanzione == -1)
			idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));

		String messaggio = "";
		if ( context.getRequest().getAttribute("messaggio")!=null)
			messaggio = ((String) context.getRequest().getAttribute("messaggio"));

		String origine = "";

		try { origine = ((String) context.getRequest().getAttribute("origine"));} catch (Exception e) {};

		if (origine == null || origine.equals(""))
			origine = context.getRequest().getParameter("origine");

		String cancellaSanzione = context.getRequest().getParameter("cancellaSanzione");

		boolean almenoUnPagato = false;

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di annullamento massivo IUV");
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}	

		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		try {

			db = this.getConnection(context);
			listaPagamenti = Pagamento.getListaPagamentiConVerificaStato(db, idSanzione, getUserId(context));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}	

		for (int k = 0; k<listaPagamenti.size(); k++){
			Pagamento p1 = (Pagamento) listaPagamenti.get(k);

			if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p1.getStatoPagamento()) || Pagamento.PAGAMENTO_IN_CORSO.equalsIgnoreCase(p1.getStatoPagamento())){
				almenoUnPagato = true;
				messaggio+= "[<b>IUD</b>: " + (p1.getIdentificativoUnivocoDovuto()!=null ? p1.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p1.getIdentificativoUnivocoVersamento()!=null ? p1.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento non e' stato annullato! Errore nella verifica stato.\\n\\n";
			}
		}

		if (!almenoUnPagato) {

			for (int i = 0; i<listaPagamenti.size(); i++){
				try {

					db = this.getConnection(context);

					Pagamento p = (Pagamento) listaPagamenti.get(i);
					p.annullaDovuto(db, getUserId(context));
					if (p.getEsitoInvio().equalsIgnoreCase("OK") || (p.getIdentificativoUnivocoVersamento()==null || p.getIdentificativoUnivocoVersamento().equals("")) /*|| (p.getEsitoInvio().equalsIgnoreCase("KO") && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))*/){ 
						p.delete(db, getUserId(context));
						//messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nL'avviso di pagamento e' stato annullato.\\n\\n";
					}
					else
						messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return ("SystemError");
				}
				finally
				{
					this.freeConnection(context, db);
				}
			}


			try {

				db = this.getConnection(context);
				NotificaPagatore.delete(db, idSanzione, getUserId(context));
				ImportoOrdinanza.delete(db, idSanzione); 

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}
		}
		
		try {

			db = this.getConnection(context);
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandVerifica(ActionContext context) {

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		Connection db = null;
		try {

			db = this.getConnection(context); 

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di verifica stato IUV");

			Pagamento p = new Pagamento(db, idPagamento);
			p.chiediPagati(db, false, getUserId(context));
			
			if (Pagamento.PAGAMENTO_COMPLETATO.equals(p.getStatoPagamento()) && (p.getHeaderFileRicevuta()==null || p.getHeaderFileRicevuta().equals(""))){
				try {
					PagoPaUtil.generaPdfRicevuta(context, null, null, db, p.getIdSanzione(), p.getId());
				} catch (ServletException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nStato pagamento: "+p.getStatoPagamento() + (p.getStatoPagamento().equals(Pagamento.PAGAMENTO_IN_CORSO) ? ". Riprovare tra qualche minuto." : ""));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandStampaSanzione(ActionContext context) {

		int idSanzione = -1;
		String tipo = null;

		try { idSanzione = Integer.parseInt(context.getRequest().getParameter("idSanzione")); } catch (Exception e){};

		if (idSanzione==-1)
			idSanzione = (Integer) context.getRequest().getAttribute("idSanzione");

		tipo = context.getRequest().getParameter("tipo");
		if (tipo==null)
			tipo = (String) context.getRequest().getAttribute("tipo");


		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		Connection db = null;
		try {
			db = this.getConnection(context);

			Ticket sanzione = new Ticket(db, idSanzione);
			context.getRequest().setAttribute("SanzioneDettaglio", sanzione);

			listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, getUserId(context));
			context.getRequest().setAttribute("listaPagamenti", listaPagamenti);

			org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket(db, sanzione.getIdControlloUfficialeTicket());
			context.getRequest().setAttribute("CUDettaglio", cu);

			AnagraficaPagatore trasgressore = new AnagraficaPagatore(db, idSanzione, "T");
			AnagraficaPagatore obbligato = new AnagraficaPagatore(db, idSanzione, "O");

			context.getRequest().setAttribute("Trasgressore", trasgressore);
			context.getRequest().setAttribute("Obbligato", obbligato);


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return "StampaSanzione_"+tipo+"_OK";
	}

	public String executeCommandAggiornaNotifica(ActionContext context) throws ParseException {

		if (!hasPermission(context, "pagopa_modifica_notifica-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		String messaggio = "";
		String origine = context.getRequest().getParameter("origine");

		String tipo = context.getRequest().getParameter("tipo");

		int idPagatore = (Integer.parseInt(context.getRequest().getParameter("idPagatore"+tipo)));

		String dataNotifica = context.getRequest().getParameter("dataNotifica"+tipo);
		String tipoNotifica = context.getRequest().getParameter("tipoNotifica"+tipo);

		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		NotificaPagatore oldNotifica = new NotificaPagatore();

		Connection db = null;

		try {

			db = this.getConnection(context);

			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

			oldNotifica = new NotificaPagatore(db, idSanzione, idPagatore);

			listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, getUserId(context));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		//VERIFICO SE ALMENO UN IUV SCADREBBE PRIMA DELLA NUOVA SCADENZA

		boolean almenoUnoScaduto = false;
		for (int i = 0; i<listaPagamenti.size(); i++){
			Pagamento p = (Pagamento) listaPagamenti.get(i);
			if (p.getPagatore().getId() == idPagatore) {

				String newDataScadenza = PagoPaUtil.calcolaDataScadenza(dataNotifica, "", p.getTipoPagamento(), p.getTipoRiduzione(), 1*p.getIndice());
				String oldDataScadenza = p.getDataScadenza();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date date1 = sdf.parse(newDataScadenza);
				Date dataOggi = new Date();

				if (date1.before(dataOggi)) {
					messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa nuova data di scadenza del pagamento sarebbe " + newDataScadenza+".\\n\\n";
					almenoUnoScaduto = true;
				}
			}
		}	

		if (almenoUnoScaduto){
			messaggio= "<b><font color='red'>ATTENZIONE. AGGIORNAMENTO NON POSSIBILE IN QUANTO ALMENO UN IUV SAREBBE AGGIORNATO AD UNA DATA DI SCADENZA INFERIORE ALLA DATA ODIERNA. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
		
			try {

				db = this.getConnection(context);
				PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}
		
		}

		else {

			try {

				db = this.getConnection(context);

				PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di aggiornamento tipo notifica IUV");

				NotificaPagatore.update(db, idPagatore, idSanzione, tipoNotifica, dataNotifica, getUserId(context));

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}				

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date parsedDate = dateFormat.parse(dataNotifica);
			Timestamp dataNotificaTimestamp = new java.sql.Timestamp(parsedDate.getTime());

			boolean almenoUnKo = false;
			for (int i = 0; i<listaPagamenti.size(); i++){

				try {

					db = this.getConnection(context);

					Pagamento p = (Pagamento) listaPagamenti.get(i);
					if (p.getPagatore().getId() == idPagatore) {
						p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotifica, "", p.getTipoPagamento(), p.getTipoRiduzione(), 1*p.getIndice()));
						p.update(db, getUserId(context));
						p.aggiornaDovuto(db, getUserId(context));

						if (p.getEsitoInvio().equalsIgnoreCase("OK")){
							messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa data di scadenza del pagamento e' stata aggiornata.\\n\\n";
						}
						else{
							messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>La data di scadenza del pagamento non e' stata aggiornata. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
							p.setDataScadenza(null);
							p.update(db, getUserId(context)); 
							almenoUnKo = true;
						}
					}


				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return ("SystemError");
				}
				finally
				{
					this.freeConnection(context, db);
				}	
			}

			try {

				db = this.getConnection(context);
				PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}

			if (almenoUnKo){

				try {

					db = this.getConnection(context);
					NotificaPagatore.restore(db, idPagatore, idSanzione, tipoNotifica, oldNotifica.getDataNotifica(), getUserId(context));			

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return ("SystemError");
				}
				finally
				{
					this.freeConnection(context, db);
				}
				messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON AGGIORNATO A CAUSA DI ERRORI. LE INFORMAZIONI DI CONTESTAZIONE/NOTIFICA SONO STATE RIPRISTINATE. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;

			} else {
				messaggio = "<b><font color='green'>Tutti gli avvisi sono stati aggiornati.</font></b>\\n\\n"+messaggio;
			}
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandDownloadAll(ActionContext context) throws IOException {

		if (!hasPermission(context, "pagopa_gestione-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;
		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		try { idSanzione = Integer.parseInt(context.getRequest().getParameter("idSanzione")); } catch (Exception e){};

		if (idSanzione==-1)
			idSanzione = (Integer) context.getRequest().getAttribute("idSanzione");

		String folderName = "rt_iuv_"+idSanzione;
		String zipName = folderName + ".zip";

		Connection db = null;
		try {
			db = this.getConnection(context);

			listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, getUserId(context));
			
			String path_doc = getWebInfPath(context,"tmp_allegati"+File.separator+folderName);
			
			for (int i = 0; i<listaPagamenti.size(); i++){
				Pagamento p = (Pagamento) listaPagamenti.get(i);
				String nomeFile = "";
				String headerFile = "";
				if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(p.getStatoPagamento())){
					nomeFile = "RT_"+p.getIdentificativoUnivocoVersamento()+".pdf";
					headerFile = p.getHeaderFileRicevuta();
				} else if (p.getHeaderFileAvviso()!=null && !p.getHeaderFileAvviso().equals("")){
					nomeFile = "AVVISO_"+p.getIdentificativoUnivocoVersamento()+".pdf";
					headerFile = p.getHeaderFileAvviso();
				}
				
				if (headerFile!=null && !headerFile.equals("")){
					GestioneAllegatiUpload ga = new GestioneAllegatiUpload();
					ga.downloadSuPath(headerFile, nomeFile, path_doc);
				}
			}		

			FileOutputStream fos = null;
			ZipOutputStream zos = null;

			try {
				File srcFile = new File(path_doc);
				File[] files = srcFile.listFiles();
				fos = new FileOutputStream(path_doc+zipName);
				zos = new ZipOutputStream(fos);
				for (int i = 0; i < files.length; i++) {
					// create byte buffer
					byte[] buffer = new byte[1024];
					FileInputStream fis = new FileInputStream(files[i]);
					zos.putNextEntry(new ZipEntry(files[i].getName()));
					int length;
					while ((length = fis.read(buffer)) > 0) {
						zos.write(buffer, 0, length);
					}
					zos.closeEntry();
					// close the InputStream
					fis.close();
				}
				zos.close();
			}
			//
			catch (Exception e)
			{
				e.printStackTrace();
			}
			finally {
				fos.close();
				zos.close();
			}

			try {
				PagoPaUtil.inviaADocumentale(path_doc+zipName, "", idSanzione, getUserId(context));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			context.getResponse().setContentType("");
			context.getResponse().setHeader("Content-disposition","attachment; filename="+zipName);

			File inputFile = new File(path_doc+zipName);

			File my_file = new File(inputFile.getAbsolutePath());

			// This should send the file to browser
			OutputStream out = context.getResponse().getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0){
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();


			FileUtils.forceDelete(new File(path_doc));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return ("-none-");	

	}


	public String executeCommandModificaForzataSanzione(ActionContext context) {

		if (!hasPermission(context, "sanzioni_modifica_trasgressori-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;

		try { idSanzione = Integer.parseInt(context.getRequest().getParameter("idSanzione")); } catch (Exception e){};

		if (idSanzione==-1)
			idSanzione = (Integer) context.getRequest().getAttribute("idSanzione");

		Connection db = null;
		try {
			db = this.getConnection(context);

			ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();
			listaPagamenti = Pagamento.getListaPagamenti(db, idSanzione, getUserId(context));

			if (listaPagamenti.size()>0){
				context.getRequest().setAttribute("messaggio", "Attenzione. Alla sanzione in oggetto risultano associati avvisi di pagamento PagoPA. Annullarli prima di procedere alla modifica di Trasgressore ed Obbligato in solido.");
				return "ModificaForzataSanzioneOK";
			}

			Ticket sanzione = new Ticket(db, idSanzione);
			context.getRequest().setAttribute("SanzioneDettaglio", sanzione);

			AnagraficaPagatore pagatoreDefault = new AnagraficaPagatore(); 

			if (sanzione.getTipologiaNonConformita() == 8) { //non conformita classica 
				Organization thisOrganization = new Organization(db, Integer.parseInt(sanzione.getIdControlloUfficiale()));
				pagatoreDefault.recuperaDatiDefault(db, thisOrganization);
			} else if (sanzione.getTipologiaNonConformita() == 10) { //non conformita a carico di terzi
				org.aspcfs.modules.altriprovvedimenti.base.Ticket nc = new org.aspcfs.modules.altriprovvedimenti.base.Ticket(db, sanzione.getId_nonconformita());
				Organization thisOrganization = new Organization();
				thisOrganization.queryRecord(db, nc.getIdImpresaSanzionata(), nc.getIdTipologiaImpresaSanzionata());
				pagatoreDefault.recuperaDatiDefault(db, thisOrganization);
			}

			context.getRequest().setAttribute("PagatoreDefault", pagatoreDefault);

			AnagraficaPagatore trasgressore = new AnagraficaPagatore(db, idSanzione, "T");
			AnagraficaPagatore obbligato = new AnagraficaPagatore(db, idSanzione, "O");

			if (trasgressore.getId()==-1){
				trasgressore.setRagioneSocialeNominativo(sanzione.getTrasgressore());
				trasgressore.upsert(db, idSanzione, "T", getUserId(context));
			}
			if (obbligato.getId()==-1 && sanzione.getObbligatoinSolido()!=null && !sanzione.getObbligatoinSolido().equalsIgnoreCase("nessuno")){
				obbligato.setRagioneSocialeNominativo(sanzione.getObbligatoinSolido());
				obbligato.upsert(db, idSanzione, "O", getUserId(context));
			}

			context.getRequest().setAttribute("Trasgressore", trasgressore);
			context.getRequest().setAttribute("Obbligato", obbligato);

			Trasgressione trasgr = new Trasgressione();
			trasgr.buildByIdSanzione(db, idSanzione);
			context.getRequest().setAttribute("Trasgressione", trasgr);

			context.getRequest().setAttribute("messaggio", (String) context.getRequest().getAttribute("messaggio"));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		return "ModificaForzataSanzioneOK";   

	}

	public String executeCommandUpdateForzataSanzione(ActionContext context) {

		if (!hasPermission(context, "sanzioni_modifica_trasgressori-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;

		try { idSanzione = Integer.parseInt(context.getRequest().getParameter("idSanzione")); } catch (Exception e){};

		if (idSanzione==-1)
			idSanzione = (Integer) context.getRequest().getAttribute("idSanzione");

		String messaggio = "";

		boolean modificaRT = Boolean.parseBoolean(context.getRequest().getParameter("ModificaRT"));
		boolean modificaPagatori = Boolean.parseBoolean(context.getRequest().getParameter("ModificaPagatori"));

		Connection db = null;
		try {
			db = this.getConnection(context);

			if (modificaPagatori) {

				String tipoPagatoreT = context.getRequest().getParameter("tipoPagatoreT");
				String pivaT = context.getRequest().getParameter("pivaT");
				String nomeT = context.getRequest().getParameter("nomeT");
				String indirizzoT = context.getRequest().getParameter("indirizzoT");
				String civicoT = context.getRequest().getParameter("civicoT");
				String capT = context.getRequest().getParameter("capT");
				String comuneT = context.getRequest().getParameter("comuneT");
				String provinciaT = context.getRequest().getParameter("provinciaT");
				String nazioneT = context.getRequest().getParameter("nazioneT");
				String mailT = context.getRequest().getParameter("mailT");
				String telefonoT = context.getRequest().getParameter("telefonoT");

				String tipoPagatoreO = context.getRequest().getParameter("tipoPagatoreO");
				String pivaO = context.getRequest().getParameter("pivaO");
				String nomeO = context.getRequest().getParameter("nomeO");
				String indirizzoO = context.getRequest().getParameter("indirizzoO");
				String civicoO = context.getRequest().getParameter("civicoO");
				String capO = context.getRequest().getParameter("capO");
				String comuneO = context.getRequest().getParameter("comuneO");
				String provinciaO = context.getRequest().getParameter("provinciaO");
				String nazioneO = context.getRequest().getParameter("nazioneO");
				String mailO = context.getRequest().getParameter("mailO");
				String telefonoO = context.getRequest().getParameter("telefonoO");

				PreparedStatement pst = db.prepareStatement("select * from pagopa_aggiorna_sanzioni_forzato(?, "
						+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
						+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "
						+ "?); ");

				int i = 0;

				pst.setInt(++i, idSanzione);

				pst.setString(++i, tipoPagatoreT);
				pst.setString(++i, nomeT);
				pst.setString(++i, pivaT);
				pst.setString(++i, indirizzoT);
				pst.setString(++i, civicoT);
				pst.setString(++i, comuneT);
				pst.setString(++i, capT);
				pst.setString(++i, provinciaT);
				pst.setString(++i, nazioneT);
				pst.setString(++i, mailT);
				pst.setString(++i, telefonoT);

				pst.setString(++i, tipoPagatoreO);
				pst.setString(++i, nomeO);
				pst.setString(++i, pivaO);
				pst.setString(++i, indirizzoO);
				pst.setString(++i, civicoO);
				pst.setString(++i, comuneO);
				pst.setString(++i, capO);
				pst.setString(++i, provinciaO);
				pst.setString(++i, nazioneO);
				pst.setString(++i, mailO);
				pst.setString(++i, telefonoO);

				pst.setInt(++i, getUserId(context));

				System.out.println("AGGIORNAMENTO MODIFICA SANZIONE FORZATA query: "+pst.toString());

				ResultSet rs = pst.executeQuery();

				if (rs.next())
					messaggio += " - Aggiornamento Pagatori: "+rs.getString(1);
			}

			if (modificaRT) {

				String pvOblato = context.getRequest().getParameter("rtPvOblato");
				String pvData = context.getRequest().getParameter("rtPvData");

				boolean pvOblatoR = false;
				boolean pvOblatoU = false;

				if ("R".equals(pvOblato))
					pvOblatoR = true;
				else if ("U".equals(pvOblato))
					pvOblatoU = true;

				PreparedStatement pst = db.prepareStatement("select * from pagopa_aggiorna_registro_trasgressori_forzato(?, "
						+ "?, ?, ?, ?); ");

				int i = 0;

				pst.setInt(++i, idSanzione);

				pst.setBoolean(++i, pvOblatoR);
				pst.setBoolean(++i, pvOblatoU);
				pst.setString(++i, pvData);

				pst.setInt(++i, getUserId(context));

				System.out.println("AGGIORNAMENTO MODIFICA SANZIONE FORZATA query: "+pst.toString());

				ResultSet rs = pst.executeQuery();

				if (rs.next())
					messaggio += " - Aggiornamento Registro Trasgressori: "+rs.getString(1);
			}

			context.getRequest().setAttribute("messaggio", messaggio);
			context.getRequest().setAttribute("idSanzione", idSanzione);


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}
		return executeCommandModificaForzataSanzione(context);

	}


	public String executeCommandRigenera(ActionContext context) throws ParseException {

		if (!hasPermission(context, "pagopa_rigenera-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;

		try { idSanzione = ((int) context.getRequest().getAttribute("idSanzione"));} catch (Exception e) {};

		if (idSanzione == -1)
			idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));

		String messaggio = "";
		if ( context.getRequest().getAttribute("messaggio")!=null)
			messaggio = ((String) context.getRequest().getAttribute("messaggio"));

		String origine = "";

		try { origine = ((String) context.getRequest().getAttribute("origine"));} catch (Exception e) {};

		if (origine == null || origine.equals(""))
			origine = context.getRequest().getParameter("origine");

		double importoTotaleVersamento = (Double.parseDouble(context.getRequest().getParameter("importoTotaleVersamento")));
		double importoSingolaRata = 0;

		String tipoPagamento = context.getRequest().getParameter("tipoPagamento");
		int numeroRate = (Integer.parseInt(context.getRequest().getParameter("numeroRate")));

		importoSingolaRata = importoTotaleVersamento/numeroRate;

		String dataNotifica = context.getRequest().getParameter("dataNotifica");

		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		AnagraficaPagatore trasgressore = new AnagraficaPagatore();
		AnagraficaPagatore obbligato = new AnagraficaPagatore();

		int maxIndice = -1;

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di annullamento parziale IUV");
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

			listaPagamenti = Pagamento.getListaPagamentiConVerificaStato(db, idSanzione, getUserId(context));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}


		// ANNULLO TUTTI I PAGAMENTI NON INIZIATI
		for (int k = 0; k<listaPagamenti.size(); k++){

			try {

				db = this.getConnection(context);

				Pagamento p = (Pagamento) listaPagamenti.get(k);
				if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento())){
					p.annullaDovuto(db, getUserId(context));
					if (p.getEsitoInvio().equalsIgnoreCase("OK")  || (p.getIdentificativoUnivocoVersamento()==null || p.getIdentificativoUnivocoVersamento().equals("")) /*|| (p.getEsitoInvio().equalsIgnoreCase("KO") && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))*/){ 
						p.delete(db, getUserId(context));
					}
					else
						messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}

		}


		try {

			db = this.getConnection(context);
			// AGGIORNO GLI INDICI DEI PAGAMENTI
			maxIndice = PagoPaUtil.aggiornaIndici(db, idSanzione);

			//GENERO I PAGAMENTI

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di rigenerazione massiva IUV (Numero Ordinanza)");

			trasgressore = new AnagraficaPagatore(db, idSanzione, "T");
			obbligato = new AnagraficaPagatore(db, idSanzione, "O");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		int localIndice = 1;
		for (int i = maxIndice; i<maxIndice+numeroRate; i++){

			try {

				db = this.getConnection(context);
				Pagamento p = new Pagamento();
				p.setIndice(i);
				p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoSingolaRata));
				p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotifica, "", tipoPagamento, "", localIndice++));
				p.setPagatore(trasgressore);
				p.setIdSanzione(idSanzione);
				p.setTipoPagamento(tipoPagamento);
				p.setNumeroRate(numeroRate);
				p.setRigenerato(true);
				p.insert(db, getUserId(context));
				p.importaDovuto(db, getUserId(context));

				if (p.getEsitoInvio().equalsIgnoreCase("OK"))
					messaggio=messaggio;//messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Rata "+(p.getIndice())+" )\\nGenerato con successo!\\n\\n";
				else {
					messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Trasgressore/Rata "+(p.getIndice())+")\\nNon generato! <font color='red'>Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
					context.getRequest().setAttribute("idSanzione", idSanzione);
					context.getRequest().setAttribute("origine", origine);
					messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
					context.getRequest().setAttribute("messaggio", messaggio);
					return executeCommandAnnullaParziale(context);
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db);
			}
		}

		if (obbligato!=null && obbligato.getId()>0){
			localIndice = 1;
			for (int i = maxIndice; i<maxIndice+numeroRate; i++){
				try {

					db = this.getConnection(context);
					Pagamento p = new Pagamento();
					p.setIndice(i);
					p.setImportoSingoloVersamento(String.format(Locale.US, "%.2f", importoSingolaRata));
					p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotifica, "", tipoPagamento, "", localIndice++));
					p.setPagatore(obbligato);
					p.setIdSanzione(idSanzione);
					p.setTipoPagamento(tipoPagamento);
					p.setNumeroRate(numeroRate);
					p.setRigenerato(true);
					p.insert(db, getUserId(context));
					p.importaDovuto(db, getUserId(context));

					if (p.getEsitoInvio().equalsIgnoreCase("OK"))
						messaggio=messaggio;//messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Rata "+(p.getIndice())+" )\\nGenerato con successo!\\n\\n";
					else {
						messaggio+="[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n(Obbligato in solido/Rata "+(p.getIndice())+")\\n<font color='red'>Non generato! Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
						context.getRequest().setAttribute("idSanzione", idSanzione);
						context.getRequest().setAttribute("origine", origine);
						messaggio= "<b><font color='red'>ATTENZIONE. ALMENO UN IUV NON GENERATO A CAUSA DI ERRORI. VERRA' EFFETTUATO UN TENTATIVO DI ANNULLAMENTO DI TUTTI GLI AVVISI DI PAGAMENTO. VERIFICARE I DATI E RIPROVARE.</font></b>\\n\\n"+messaggio;
						context.getRequest().setAttribute("messaggio", messaggio);
						return executeCommandAnnullaParziale(context);
					}


				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return ("SystemError");
				}
				finally
				{
					this.freeConnection(context, db);
				}
			}  
		}

		try {

			db = this.getConnection(context);
			ImportoOrdinanza.insert(db, idSanzione, String.valueOf(importoTotaleVersamento), numeroRate, dataNotifica, false, getUserId(context));
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		messaggio = "<b><font color='green'>Tutti gli avvisi sono stati rigenerati.</font></b>\\n\\n"+messaggio;

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandAnnullaParziale(ActionContext context) {

		if (!hasPermission(context, "pagopa_rigenera-view")) {
			return ("PermissionError");
		}

		int idSanzione = -1;

		try { idSanzione = ((int) context.getRequest().getAttribute("idSanzione"));} catch (Exception e) {};

		if (idSanzione == -1)
			idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));

		String messaggio = "";
		if ( context.getRequest().getAttribute("messaggio")!=null)
			messaggio = ((String) context.getRequest().getAttribute("messaggio"));

		String origine = "";

		try { origine = ((String) context.getRequest().getAttribute("origine"));} catch (Exception e) {};

		if (origine == null || origine.equals(""))
			origine = context.getRequest().getParameter("origine");

		ArrayList<Pagamento> listaPagamenti = new ArrayList<Pagamento>();

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, -1, "Tentativo di annullamento parziale IUV");
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), true);

			listaPagamenti = Pagamento.getListaPagamentiConVerificaStato(db, idSanzione, getUserId(context));

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		for (int k = 0; k<listaPagamenti.size(); k++){

			try {
				db = this.getConnection(context);

				Pagamento p = (Pagamento) listaPagamenti.get(k);

				if (Pagamento.PAGAMENTO_NON_INIZIATO.equalsIgnoreCase(p.getStatoPagamento())){
					p.annullaDovuto(db, getUserId(context));
					if (p.getEsitoInvio().equalsIgnoreCase("OK")  || (p.getIdentificativoUnivocoVersamento()==null || p.getIdentificativoUnivocoVersamento().equals("")) /*|| (p.getEsitoInvio().equalsIgnoreCase("KO") && p.getDescrizioneErrore().contains("Dovuto non presente o in pagamento nel database"))*/){ 
						p.delete(db, getUserId(context));
					}
					else
						messaggio+= "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\n<font color='red'>L'avviso di pagamento non e' stato annullato. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"</font>\\n\\n";
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ("SystemError");
			}
			finally
			{
				this.freeConnection(context, db); 
			}
		}

		try {
			db = this.getConnection(context);
			PagoPaUtil.gestioneSemaforo(db, idSanzione, getUserId(context), false);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		try {
			db = this.getConnection(context);

			NotificaPagatore.delete(db, idSanzione, getUserId(context));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("messaggio", messaggio);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}

	public String executeCommandAggiornaNotificaRigenerata(ActionContext context) throws ParseException {

		if (!hasPermission(context, "pagopa_rigenera-view")) {
			return ("PermissionError");
		}

		int idSanzione = (Integer.parseInt(context.getRequest().getParameter("idSanzione")));
		int idPagamento = (Integer.parseInt(context.getRequest().getParameter("idPagamento")));
		String origine = context.getRequest().getParameter("origine");

		String dataNotificaRigenerata = context.getRequest().getParameter("dataNotificaRigenerata_"+idPagamento);

		Connection db = null;
		try {

			db = this.getConnection(context);

			PagoPaUtil.salvaStorico(db, getUserId(context), idSanzione, idPagamento, "Tentativo di aggiornamento IUV");

			Pagamento p = new Pagamento(db, idPagamento);
			p.setDataScadenza(PagoPaUtil.calcolaDataScadenza(dataNotificaRigenerata, "", "NO", "", 1));
			p.update(db, getUserId(context));
			p.aggiornaDovuto(db, getUserId(context));

			if (p.getEsitoInvio().equalsIgnoreCase("OK"))
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa data di scadenza del pagamento e' stata aggiornata con successo.\\n\\n");
			else
				context.getRequest().setAttribute("messaggio", "[<b>IUD</b>: " + (p.getIdentificativoUnivocoDovuto()!=null ? p.getIdentificativoUnivocoDovuto() : "") +"/<b>IUV</b>: "+(p.getIdentificativoUnivocoVersamento()!=null ? p.getIdentificativoUnivocoVersamento() : "")+"]\\nLa data di scadenza del pagamento non e' stata aggiornata. Motivazione: "+PagoPaUtil.fixDescrizioneErrore(p.getDescrizioneErrore())+"\\n\\n");


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		context.getRequest().setAttribute("idSanzione", idSanzione);
		context.getRequest().setAttribute("origine", origine);
		return executeCommandView(context);

	}
	
	public String executeCommandStampaRicevuta(ActionContext context) {

		int idPagamento = -1;
		String ret = "";
		
		try { idPagamento = Integer.parseInt(context.getRequest().getParameter("idPagamento")); } catch (Exception e){};

		if (idPagamento==-1)
			idPagamento = (Integer) context.getRequest().getAttribute("idPagamento");

		Pagamento pagamento = new Pagamento();
		Connection db = null;
		try {
			db = this.getConnection(context);

			pagamento = new Pagamento(db, idPagamento);
			context.getRequest().setAttribute("pagamento", pagamento);

			if (Pagamento.PAGAMENTO_COMPLETATO.equalsIgnoreCase(pagamento.getStatoPagamento()))
				ret = "StampaRicevuta_OK";
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ("SystemError");
		}
		finally
		{
			this.freeConnection(context, db);
		}

		return ret;
	}
	
	public String executeCommandAutomatismi(ActionContext context) { 

		return "AutomatismiOK";

	}
}
