package org.aspcfs.modules.suap.actions;
   
import java.sql.Connection;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.opu.base.LineaProduttiva;
import org.aspcfs.modules.opu.base.LineaProduttivaList;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;
import org.jmesa.facade.TableFacade;
import org.jmesa.facade.TableFacadeFactory;
import org.jmesa.limit.Limit;
import org.jmesa.view.html.component.HtmlColumn;
import org.jmesa.view.html.component.HtmlRow;
import org.jmesa.view.html.editor.HtmlCellEditor;

import com.darkhorseventures.framework.actions.ActionContext;

public class LineaProduttivaAction extends CFSModule {
 
	
	
	
	
	
	public String executeCommandSearch(ActionContext context){
		Connection db = null;
				
		try 
		{ 
			db = this.getConnection(context);
			LineaProduttivaList lpList = new LineaProduttivaList();
			PagedListInfo lpInfo = this.getPagedListInfo(context,"SearchLineaProduttiva");
			lpInfo.setLink("LineaProduttivaAction.do?command=Search");
			//lpInfo.setSearchCriteria(lpList, context);
			lpInfo.setColumnToSortBy("lp.tipo_iter,lp.id_categoria");
			lpList.setPagedListInfo(lpInfo);
			
			if ("AziendeAgricoleOpuStab".equalsIgnoreCase(context.getAction().getActionName()))
				lpList.setIdNorma(LineaProduttiva.NORMA_AZIENDE_AGRICOLE);
			else
				if ("Stabilimenti852".equalsIgnoreCase(context.getAction().getActionName()))
					lpList.setIdNorma(LineaProduttiva.NORMA_STABILIMENTI_852);
					
			
			
			lpList.setTipoSelezione(context.getRequest().getParameter("tipoSelezione"));
			lpList.setEnabledMacrocategoria(true);
			lpList.buildListSearch(db);
			context.getRequest().setAttribute("ListaLineaProduttiva", lpList);
			LookupList listaMacroCategoria = new LookupList(db,"opu_lookup_macrocategorie_linee_produttive");
			listaMacroCategoria.addItem(-1,"-SELEZIONA CATEGORIA-") ;
			LookupList listaCategoria = new LookupList(db,"opu_lookup_aggregazioni_linee_produttive");
			listaCategoria.addItem(-1,"-SELEZIONA CATEGORIA-") ;
			context.getRequest().setAttribute("ListaMacroCategoria", listaMacroCategoria);
			context.getRequest().setAttribute("listaCategoria", listaCategoria);
			
			
			TableFacade tf = TableFacadeFactory.createTableFacade("lineeproduttive", context.getRequest());
			tf.setMaxRowsIncrements(lpList.size());
			tf.setMaxRows(lpList.size());
			
			
			tf.setItems( lpList);
			tf.setColumnProperties( 
					"azione", "macrocategoria", "categoria", "attivita"
					
			);
		
			tf.setStateAttr("restore");					
			HtmlRow row = (HtmlRow) tf.getTable().getRow();
			row.setUniqueProperty("attivita"); // the unique worksheet properties to identify the row

 
			tf.getTable().getRow().getColumn( "azione" ).setTitle( "&nbsp;" );
			//tf.getTable().getRow().getColumn( "norma" ).setTitle( "Norma" );
			tf.getTable().getRow().getColumn( "macrocategoria" ).setTitle( "Macroarea" );
			tf.getTable().getRow().getColumn( "categoria" ).setTitle( "Aggregazione" );
			tf.getTable().getRow().getColumn( "attivita" ).setTitle( "Attivita" );
			 String [] param  = null ;
			 
			 String params = context.getRequest().getParameter("idLineaProduttivaRequest");
				if (params != null)
				{
					
					param = params.split(";");
					context.getRequest().setAttribute("idLineaProduttivaRequest", params);
					
				}
		
			HtmlColumn cg1 = (HtmlColumn) tf.getTable().getRow().getColumn("azione");
			CellEditor cellEditor = new CellEditor();
			cellEditor.setContext(context);
			cg1.getCellRenderer().setCellEditor(cellEditor);


			Limit limit = tf.getLimit();
			if(! limit.isExported() )
			{



//				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("norma");
//				
//				cg.setFilterable( true );
				
				//cg.setFilterable( true );
			
				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("macrocategoria");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("categoria");
				cg.setFilterable( true );

				cg = (HtmlColumn) tf.getTable().getRow().getColumn("attivita");
				cg.setFilterable( true );


				cg = (HtmlColumn) tf.getTable().getRow().getColumn("azione");
				cg.setFilterable( false );


				
			}


			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
		} 
		catch (Exception e) 
		{
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally 
		{
			this.freeConnection(context, db);
		}
		//return ("SearchOK"); 
		return getReturnLp(context, "Search");
	}
	
	 private class CellEditor implements org.jmesa.view.editor.CellEditor
	{	
		ActionContext context    ;
		public void setContext(ActionContext context)
		{
			this.context = context;
		}
		public CellEditor(){}
		public Object getValue(Object item, String property, int rowCount)
		{
			String [] param  = null ;
			 String params = context.getRequest().getParameter("idLineaProduttivaRequest");
				if (params != null)
				{
					
					param = params.split(";");
					
				}
			String temp	= (String) (new HtmlCellEditor()).getValue(item, "id", rowCount);
			String id	= (String) (new HtmlCellEditor()).getValue(item, "alimentoDistribuito", rowCount);
			boolean ischecked = false ;
			if (param != null)
			for (int i = 0 ; i<param.length; i++)
			{
				if (param[i].equals(temp))
					ischecked = true ;
			}
			temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
			if (ischecked==true)
				return "<input type='checkbox' name = 'idLineaProduttivaRequest' onclick='checkLineeProduttive(this.value,this)' checked value = '"+ temp +"'  >";
			else
				return "<input type='checkbox' name = 'idLineaProduttivaRequest'  onclick='checkLineeProduttive(this.value,this)'  value = '"+ temp +"'>";
//			return "<input type='checkbox' name = 'idLineaProduttivaRequest' checked value = '"+ temp +"' onclick='setidLineaProduttivaRequest(this)' >";
//			else
//				return "<input type='checkbox' name = 'idLineaProduttivaRequest'  value = '"+ temp +"' onclick='setidLineaProduttivaRequest(this)'>";

		}
	};
	
	
	
public String executeCommandScegliLineaProduttiva(ActionContext context){
		
		
		Connection db = null;
		try {
			db = getConnection(context);
			
			//String lineeProduttiveSelezionateS = context.getRequest().getParameter("idLineaProduttivaRequest");
			String[] lineeProduttiveSelezionate = null ;
//			if (lineeProduttiveSelezionateS!=null)
//				lineeProduttiveSelezionate = lineeProduttiveSelezionateS.split(";");
//			
			
			lineeProduttiveSelezionate =  context.getRequest().getParameterValues("idLineaProduttivaRequest");
			LineaProduttivaList listaLineeProduttive = new LineaProduttivaList() ; 
			if (lineeProduttiveSelezionate != null && lineeProduttiveSelezionate.length>0)
			{
				for (int i = 0 ; i < lineeProduttiveSelezionate.length; i++)
				{
					if(!lineeProduttiveSelezionate[i].equals("-1") && !lineeProduttiveSelezionate[i].equals(""))
					{
						LineaProduttiva lp = new LineaProduttiva ();
						lp.queryRecordScelta(db,Integer.parseInt(lineeProduttiveSelezionate[i]));
						listaLineeProduttive.add(lp);
					}
				}
				
			}
			
			
			listaLineeProduttive.setTipoSelezione(context.getParameter("tipoSelezione"));
			
			context.getRequest().setAttribute("LineeProduttiveList", listaLineeProduttive);
			
			if (context.getRequest().getParameter("tipoRegistrazione") != null)
				context.getRequest().setAttribute("tipoRegistrazione", context.getRequest().getParameter("tipoRegistrazione"));
			
		}catch (Exception e) {
			e.printStackTrace();
			// Go through the SystemError process
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return ("ClosePopupLpOK");
	}

 

/*
public String executeCommandDetails(ActionContext context) {

	Connection db = null;
	SystemStatus systemStatus = this.getSystemStatus(context);
	Operatore newOperatoreLineaProduttiva = null;
	try {

		String tempLineaProduttivaId = context.getRequest().getParameter("lineaId");
		if (tempLineaProduttivaId == null) {
			tempLineaProduttivaId = (String) context.getRequest().getAttribute("lineaId");
		}
		if (tempLineaProduttivaId == null){
			tempLineaProduttivaId = (String) context.getRequest().getParameter("idLinea");
		}

		//String iter = context.getRequest().getParameter("tipo");
		Integer lineaPId = null;

		if (tempLineaProduttivaId != null) {
			lineaPId = Integer.parseInt(tempLineaProduttivaId);
		}
		db = this.getConnection(context);
		//newOperatore = new Operatore(db, tempid);
		newOperatoreLineaProduttiva = new Operatore();
		newOperatoreLineaProduttiva.queryRecordOperatorebyIdLineaProduttiva(db, lineaPId);
		context.getRequest().setAttribute("OperatoreDettagli", newOperatoreLineaProduttiva);
		LookupList siteList = new LookupList(db, "lookup_site_id");
		siteList.addItem(-1, "-- SELEZIONA VOCE --");
		context.getRequest().setAttribute("AslList", siteList);
		ComuniAnagrafica c = new ComuniAnagrafica();
		//Provvisoriamente prendo tutti i comuni
		ArrayList<ComuniAnagrafica> listaComuni =  c.buildList_all(db, ((UserBean)context.getSession().getAttribute("User")).getSiteId());
		LookupList comuniList = new LookupList(listaComuni, -1);
		comuniList.addItem(-1, "Seleziona comune");
		context.getRequest().setAttribute("ComuniList", comuniList);
		return getReturn(context, "Details");

	} catch (Exception e) {
		e.printStackTrace();
		// Go through the SystemError process
		context.getRequest().setAttribute("Error", e);
		return ("SystemError");
	} finally {
		this.freeConnection(context, db);
	}



}*/



}
