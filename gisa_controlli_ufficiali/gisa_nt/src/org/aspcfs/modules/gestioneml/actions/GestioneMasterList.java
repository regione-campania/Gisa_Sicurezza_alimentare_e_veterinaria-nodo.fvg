package org.aspcfs.modules.gestioneml.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.gestioneml.base.SuapMasterListAggregazioneList;
import org.aspcfs.modules.gestioneml.base.SuapMasterListLineaAttivitaList;
import org.aspcfs.modules.gestioneml.base.SuapMasterListMacroareaList;
import org.aspcfs.modules.gestioneml.base.SuapMasterListNormaList;
import org.aspcfs.modules.gestioneml.util.MasterListImportUtil;

import com.darkhorseventures.framework.actions.ActionContext;



public class GestioneMasterList extends CFSModule {
	
	public String executeCommandCostruisciMasterList(ActionContext context)  {

		String tipologiaDaVisualizzare = context.getParameter("tipologia");
		Connection db = null;
		try
		{
			db = super.getConnection(context);
			switch(tipologiaDaVisualizzare) 
			{
			
			case "norma" :
			{
				int rev =-1 ;
				if(context.getParameter("rev")!=null && !context.getParameter("rev").equals("null"))
				{
					rev = Integer.parseInt(context.getParameter("rev"));
				}
				SuapMasterListNormaList masterListSuapNorma = new SuapMasterListNormaList();
				masterListSuapNorma.setRev(rev);

				String flagFisso = context.getParameter("flagFisso");
				String flagMobile = context.getParameter("flagMobile");
				String flagApicoltura = context.getParameter("flagApicoltura");
				String flagRegistrabili = context.getParameter("flagRegistrabili");
				String flagRiconoscibili = context.getParameter("flagRiconoscibili");
				String flagSintesis = context.getParameter("flagSintesis");
				String flagBdu = context.getParameter("flagBdu");
				String flagVam = context.getParameter("flagVam");
				String flagNoScia = context.getParameter("flagNoScia"); 
				
				if (flagFisso!=null && !flagFisso.equals("null"))
					masterListSuapNorma.setFlagFisso(flagFisso);
				if (flagMobile!=null && !flagMobile.equals("null"))
					masterListSuapNorma.setFlagMobile(flagMobile);
				if (flagApicoltura!=null && !flagApicoltura.equals("null"))
					masterListSuapNorma.setFlagApicoltura(flagApicoltura);
				if (flagRegistrabili!=null && !flagRegistrabili.equals("null"))
					masterListSuapNorma.setFlagRegistrabili(flagRegistrabili);
				if (flagRiconoscibili!=null && !flagRiconoscibili.equals("null"))
					masterListSuapNorma.setFlagRiconoscibili(flagRiconoscibili);
				if (flagSintesis!=null && !flagSintesis.equals("null"))
					masterListSuapNorma.setFlagSintesis(flagSintesis);
				if (flagBdu!=null && !flagBdu.equals("null"))
					masterListSuapNorma.setFlagBdu(flagBdu);
				if (flagVam!=null && !flagVam.equals("null"))
					masterListSuapNorma.setFlagVam(flagVam);
				if (flagNoScia!=null && !flagNoScia.equals("null"))
					masterListSuapNorma.setFlagNoScia(flagNoScia);
				
				masterListSuapNorma.buildList(db);
				context.getRequest().setAttribute("Lista", masterListSuapNorma);
				
				break ;
			}
			case "macroarea" :
			{
				int rev =-1 ;
				if(context.getParameter("rev")!=null && !context.getParameter("rev").equals("null"))
				{
					rev = Integer.parseInt(context.getParameter("rev"));
				}
				
				if (context.getParameter("idNorma")==null || context.getParameter("idNorma").equals(""))
					break ;
				
				int idNorma = Integer.parseInt(context.getParameter("idNorma"));

				String flagFisso = context.getParameter("flagFisso");
				String flagMobile = context.getParameter("flagMobile");
				String flagApicoltura = context.getParameter("flagApicoltura");
				String flagRegistrabili = context.getParameter("flagRegistrabili");
				String flagRiconoscibili = context.getParameter("flagRiconoscibili");
				String flagSintesis = context.getParameter("flagSintesis");
				String flagBdu = context.getParameter("flagBdu");
				String flagVam = context.getParameter("flagVam");
				String flagNoScia = context.getParameter("flagNoScia"); 
				
				SuapMasterListMacroareaList masterListSuapMacroarea = new SuapMasterListMacroareaList();
				masterListSuapMacroarea.setIdNorma(idNorma);
				masterListSuapMacroarea.setRev(rev);
				
				if (flagFisso!=null && !flagFisso.equals("null"))
					masterListSuapMacroarea.setFlagFisso(flagFisso);
				if (flagMobile!=null && !flagMobile.equals("null"))
					masterListSuapMacroarea.setFlagMobile(flagMobile);
				if (flagApicoltura!=null && !flagApicoltura.equals("null"))
					masterListSuapMacroarea.setFlagApicoltura(flagApicoltura);
				if (flagRegistrabili!=null && !flagRegistrabili.equals("null"))
					masterListSuapMacroarea.setFlagRegistrabili(flagRegistrabili);
				if (flagRiconoscibili!=null && !flagRiconoscibili.equals("null"))
					masterListSuapMacroarea.setFlagRiconoscibili(flagRiconoscibili);
				if (flagSintesis!=null && !flagSintesis.equals("null"))
					masterListSuapMacroarea.setFlagSintesis(flagSintesis);
				if (flagBdu!=null && !flagBdu.equals("null"))
					masterListSuapMacroarea.setFlagBdu(flagBdu);
				if (flagVam!=null && !flagVam.equals("null"))
					masterListSuapMacroarea.setFlagVam(flagVam);
				if (flagNoScia!=null && !flagNoScia.equals("null"))
					masterListSuapMacroarea.setFlagNoScia(flagNoScia);
				
				masterListSuapMacroarea.buildList(db);
				context.getRequest().setAttribute("Lista", masterListSuapMacroarea);
				
				break ;
			}
			case "aggregazione" :
			{
				if (context.getParameter("idMacroarea")==null || context.getParameter("idMacroarea").equals(""))
					break ;
				
				int idMacroarea = Integer.parseInt(context.getParameter("idMacroarea"));
				
				String flagFisso = context.getParameter("flagFisso");
				String flagMobile = context.getParameter("flagMobile");
				String flagApicoltura = context.getParameter("flagApicoltura");
				String flagRegistrabili = context.getParameter("flagRegistrabili");
				String flagRiconoscibili = context.getParameter("flagRiconoscibili");
				String flagSintesis = context.getParameter("flagSintesis");
				String flagBdu = context.getParameter("flagBdu");
				String flagVam = context.getParameter("flagVam");
				String flagNoScia = context.getParameter("flagNoScia");
				
				SuapMasterListAggregazioneList masterListSuapAggregazione = new SuapMasterListAggregazioneList();
				masterListSuapAggregazione.setIdMacroarea(idMacroarea);
				
				if (flagFisso!=null && !flagFisso.equals("null"))
					masterListSuapAggregazione.setFlagFisso(flagFisso);
				if (flagMobile!=null && !flagMobile.equals("null"))
					masterListSuapAggregazione.setFlagMobile(flagMobile);
				if (flagApicoltura!=null && !flagApicoltura.equals("null"))
					masterListSuapAggregazione.setFlagApicoltura(flagApicoltura);
				if (flagRegistrabili!=null && !flagRegistrabili.equals("null"))
					masterListSuapAggregazione.setFlagRegistrabili(flagRegistrabili);
				if (flagRiconoscibili!=null && !flagRiconoscibili.equals("null"))
					masterListSuapAggregazione.setFlagRiconoscibili(flagRiconoscibili);
				if (flagSintesis!=null && !flagSintesis.equals("null"))
					masterListSuapAggregazione.setFlagSintesis(flagSintesis);
				if (flagBdu!=null && !flagBdu.equals("null"))
					masterListSuapAggregazione.setFlagBdu(flagBdu);
				if (flagVam!=null && !flagVam.equals("null"))
					masterListSuapAggregazione.setFlagVam(flagVam);
				if (flagNoScia!=null && !flagNoScia.equals("null"))
					masterListSuapAggregazione.setFlagNoScia(flagNoScia);
				
				masterListSuapAggregazione.buildList(db);
				context.getRequest().setAttribute("Lista", masterListSuapAggregazione);
				break ;
				
			}
			case "attivita":
			{
				if (context.getParameter("idAggregazione")==null || context.getParameter("idAggregazione").equals(""))
					break ;
				
				int idAggregazione = Integer.parseInt(context.getParameter("idAggregazione"));
				
				String flagFisso = context.getParameter("flagFisso");
				String flagMobile = context.getParameter("flagMobile");
				String flagApicoltura = context.getParameter("flagApicoltura");
				String flagRegistrabili = context.getParameter("flagRegistrabili");
				String flagRiconoscibili = context.getParameter("flagRiconoscibili");
				String flagSintesis = context.getParameter("flagSintesis");
				String flagBdu = context.getParameter("flagBdu");
				String flagVam = context.getParameter("flagVam");
				String flagNoScia = context.getParameter("flagNoScia");
				
				SuapMasterListLineaAttivitaList masterListSuapLineaAttivita = new SuapMasterListLineaAttivitaList();
				masterListSuapLineaAttivita.setIdAggregazione(idAggregazione);
				
				if (flagFisso!=null && !flagFisso.equals("null"))
					masterListSuapLineaAttivita.setFlagFisso(flagFisso);
				if (flagMobile!=null && !flagMobile.equals("null"))
					masterListSuapLineaAttivita.setFlagMobile(flagMobile);
				if (flagApicoltura!=null && !flagApicoltura.equals("null"))
					masterListSuapLineaAttivita.setFlagApicoltura(flagApicoltura);
				if (flagRegistrabili!=null && !flagRegistrabili.equals("null"))
					masterListSuapLineaAttivita.setFlagRegistrabili(flagRegistrabili);
				if (flagRiconoscibili!=null && !flagRiconoscibili.equals("null"))
					masterListSuapLineaAttivita.setFlagRiconoscibili(flagRiconoscibili);
				if (flagSintesis!=null && !flagSintesis.equals("null"))
					masterListSuapLineaAttivita.setFlagSintesis(flagSintesis);
				if (flagBdu!=null && !flagBdu.equals("null"))
					masterListSuapLineaAttivita.setFlagBdu(flagBdu);
				if (flagVam!=null && !flagVam.equals("null"))
					masterListSuapLineaAttivita.setFlagVam(flagVam);
				if (flagNoScia!=null && !flagNoScia.equals("null"))
					masterListSuapLineaAttivita.setFlagNoScia(flagNoScia);
				
				masterListSuapLineaAttivita.buildList(db);
				context.getRequest().setAttribute("Lista", masterListSuapLineaAttivita);
				break ;
				
			}
			default :
			{
				
			}

			}
		}catch(SQLException e)
		{

		}
		finally
		{
			super.freeConnection(context, db);
		}

		return "masterListJSONOK";
	}
	
	
	public static String getPathCompleto(Connection db, int idLinea) throws SQLException{
		String ret = "";
		PreparedStatement pst = db.prepareStatement("select m.macroarea || ' -> ' || a.aggregazione || ' -> ' || l.linea_attivita l from "+ MasterListImportUtil.TAB_LINEA_ATTIVITA +" l join "+ MasterListImportUtil.TAB_AGGREGAZIONE +" a on a.id = l.id_aggregazione join "+ MasterListImportUtil.TAB_MACROAREA +" m on m.id = a.id_macroarea where l.id = ?");
		pst.setInt(1, idLinea);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			ret = rs.getString(1);
		return ret;
	}
	public static String getCodiceUnivoco(Connection db, int idLinea) throws SQLException{
		String ret = "";
		PreparedStatement pst = db.prepareStatement("select codice_univoco from "+ MasterListImportUtil.TAB_LINEA_ATTIVITA +" where id = ?");
		pst.setInt(1, idLinea);
		ResultSet rs = pst.executeQuery();
		if (rs.next())
			ret = rs.getString(1);
		return ret;
	}

}
