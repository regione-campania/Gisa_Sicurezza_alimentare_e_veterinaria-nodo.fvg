package ext.aspcfs.modules.apicolture.actions;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.util.ArrayList;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiUpload;
import org.aspcfs.modules.gestioneDocumenti.actions.GestioneAllegatiUploadDelegaApicoltore;
import org.aspcfs.modules.gestioneDocumenti.base.DocumentaleAllegato;
import org.aspcfs.modules.gestioneDocumenti.util.DocumentaleUtil;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;
import com.oreilly.servlet.MultipartRequest;

import ext.aspcfs.modules.apiari.base.Delega;
import ext.aspcfs.modules.apiari.base.DelegaList;

public class DelegaAction extends CFSModule {

	
	private static final int MAX_SIZE_REQ = 50000000;
	
	public String executeCommandDefault(ActionContext context) {

		return executeCommandSearchForm(context);
	}
	
	
	public String executeCommandSearchForm(ActionContext context) {
			
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			addModuleBean(context, "Search Accounts", "Accounts Search");

		return getReturn(context, "Search");

	}
	
	
	public String executeCommandList(ActionContext context) {
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		
		DelegaList delegaList = new DelegaList();
		delegaList.setId_utente_access_ext_delegato(user.getUserId());
		delegaList.setCodice_fiscale_delegato(user.getContact().getVisibilitaDelega());
		
	
		
		
		addModuleBean(context, "View Accounts", "Search Results");

		Connection db = null;
		try {
			db = this.getConnection(context);
			
			
			SystemStatus systemStatus = this.getSystemStatus(context);
			
			
			LookupList NazioniList = new LookupList(db,"lookup_nazioni");
			NazioniList.addItem(-1, "Seleziona Nazione");
			NazioniList.setRequired(true);
			context.getRequest().setAttribute("NazioniList", NazioniList);
			delegaList.setIdAsl(user.getSiteId());
			delegaList.buildList(db,systemStatus,context);
			context.getRequest().setAttribute("DelegaList", delegaList);
			
			return getReturn(context, "List");

		} catch (Exception e) {
			e.printStackTrace();
			// Go through the SystemError process
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	}
	
	
	public String executeCommandInsert(ActionContext context) throws ParseException, IOException {
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		
		
		//String filePath = this.getPath(context, "allegati");
	    String filePath = getWebInfPath(context,"tmp_allegati");

		
		MultipartRequest multi = new MultipartRequest(context.getRequest(),filePath,MAX_SIZE_REQ,"UTF-8");
		
		Delega newDelega = (Delega) context.getRequest().getAttribute("Delega");
		newDelega.setEntered_by(user.getUserId());
		newDelega.setModified_by(user.getUserId());
		newDelega.setIdAsl(user.getSiteId());
		newDelega.setId_soggetto_fisico_delegante(multi.getParameter("id_soggetto_fisico_delegante"));
		newDelega.setCodice_fiscale_delegante(multi.getParameter("codice_fiscale_delegante"));
		newDelega.setId_utente_access_ext_delegato(multi.getParameter("id_utente_access_ext_delegato"));
		newDelega.setCodice_fiscale_delegato(multi.getParameter("codice_fiscale_delegato"));
		newDelega.setData_assegnazione_delega(multi.getParameter("data_assegnazione_delega"));

		addModuleBean(context, "View Accounts", "Search Results");

		Connection db = null;
		try {
			db = this.getConnection(context);
			SystemStatus systemStatus = this.getSystemStatus(context);
			DelegaList listaDeleghe = new DelegaList();
			listaDeleghe.setCodice_fiscale_delegante(newDelega.getCodice_fiscale_delegante());
			listaDeleghe.buildList(db,systemStatus,context);
			
			if (listaDeleghe.size()>0 && multi.getParameter("conferma")!=null &&  ( "".equals(multi.getParameter("conferma")) || "no".equals(multi.getParameter("conferma"))))
			{
				Delega delega = (Delega)listaDeleghe.get(0);
				
				context.getRequest().setAttribute("EsitoInserimentoSoggettoFisico", "KOCONFIRM");
				context.getRequest().setAttribute("ErroreInserimento", "L'utente con codice fiscale "+delega.getCodice_fiscale_delegato() + " detiene una delega per il seguente codice Fiscale "+newDelega.getCodice_fiscale_delegante()+". Si desidera continuare con l'inserimento dei dati ?");
				return "StampaJson";
			}
			
			
			newDelega.insert(db);
			File file1 = (File) multi.getFile("allegatoDelega");
			if(file1 != null){
				String fileName= multi.getOriginalFileName("allegatoDelega");
				ArrayList<String> listaFile = new ArrayList<String>();
				listaFile.add("application/msword");
				listaFile.add("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
				listaFile.add("image/jpeg");
				listaFile.add("image/png");
				listaFile.add("application/pdf");
				String esito = DocumentaleUtil.mimeType((filePath + fileName), listaFile);
				if(esito != null)
					if(esito.equalsIgnoreCase("errore")){
						context.getRequest().setAttribute("EsitoInserimentoSoggettoFisico", "KOMIME");
						context.getRequest().setAttribute("erroreMime", "Errore! Formato file non valido");
						return "StampaJson";
					}
			}
			if (file1!=null)
			{
			GestioneAllegatiUploadDelegaApicoltore verbali = new GestioneAllegatiUploadDelegaApicoltore();
			verbali.setIdDelega(newDelega.getId());
			verbali.setFileDaCaricare(file1);
			verbali.setOggetto("Allegato Delega");
			verbali.setTipoAllegato("allegatoDelega");
			verbali.allegaFileDelega(multi, context);
			}
			
			context.getRequest().setAttribute("Delega", newDelega);
			context.getRequest().setAttribute("EsitoInserimentoSoggettoFisico", "OK");
			context.getRequest().setAttribute("ErroreInserimento", "");
			
			return "StampaJson";

		} catch (Exception e) {
			e.printStackTrace();
			// Go through the SystemError process
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
	}
	
	
	
	public String executeCommandDownloadDelega(ActionContext context) throws ParseException, IOException 
	{
		Connection db = null;
		
		try 
		{
			db = this.getConnection(context);
			
			PreparedStatement pst = null;
			GestioneAllegatiUploadDelegaApicoltore gestioneAllegatiDelega = new GestioneAllegatiUploadDelegaApicoltore();
			if(context!=null)
			{
				gestioneAllegatiDelega.setIdDelega(Integer.parseInt(context.getParameter("id")));
				try
				{
					DocumentaleAllegato allegato = gestioneAllegatiDelega.listaAllegati(context);
					if(allegato!=null)
					{
						GestioneAllegatiUpload upload = new GestioneAllegatiUpload();
						context.getRequest().setAttribute("codDocumento", allegato.getIdHeader());
						context.getRequest().setAttribute("idDocumento", allegato.getIdDocumento());
						context.getRequest().setAttribute("tipoDocumento", allegato.getEstensione());
						return upload.executeCommandDownloadPDF(context);
					}
					else
					{
						context.getRequest().setAttribute("Error", "Non esiste un allegato per questa delega");
						return "errorDownloadDelega";
					}
						
				}
				catch(Exception e)
				{
					context.getRequest().setAttribute("Error", e);
					return "errorDownloadDelega";
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		finally 
		{
			this.freeConnection(context, db);
		}
		return null;
	}
		
	private void resetPagedListInfo(ActionContext context) {
		this.deletePagedListInfo(context, "SearchOrgListInfo");
		this.deletePagedListInfo(context, "AccountFolderInfo");
		this.deletePagedListInfo(context, "RptListInfo");
		this.deletePagedListInfo(context, "OpportunityPagedInfo");
		this.deletePagedListInfo(context, "AccountTicketInfo");
		this.deletePagedListInfo(context, "AutoGuideAccountInfo");
		this.deletePagedListInfo(context, "RevenueListInfo");
		this.deletePagedListInfo(context, "AccountDocumentInfo");
		this.deletePagedListInfo(context, "ServiceContractListInfo");
		this.deletePagedListInfo(context, "AssetListInfo");
		this.deletePagedListInfo(context, "AccountProjectInfo");
		this.deletePagedListInfo(context, "orgHistoryListInfo");


	}

}
