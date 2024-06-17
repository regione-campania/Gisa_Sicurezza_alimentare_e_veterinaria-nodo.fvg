package org.aspcfs.modules.campioni.actions;

/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */


import java.sql.Connection;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.Parameter;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.macellazioni.base.Capo;
import org.aspcfs.modules.macellazioninew.base.Campione;
import org.aspcfs.modules.macellazioninew.base.Partita;
import org.aspcfs.modules.macellazioninew.base.PartitaSeduta;
import org.aspcfs.modules.macellazioninew.utils.ConfigTipo;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.ParameterUtils;

import com.darkhorseventures.framework.actions.ActionContext;

public final class CampioniAssociazioneEsiti extends CFSModule 
{
	public String executeCommandDefault( ActionContext context )
	{
		return executeCommandRicerca( context );
	}

    public String executeCommandRicerca( ActionContext context )
	{
		String			ret		= "RicercaOK";

		if (!hasPermission(context, "associazione_esiti_campioni-view"))
		{
			return ("PermissionError");
		}

		Connection		db		= null;

		try
		{
			db		= this.getConnection( context );
			
			String data = 		context.getParameter( "data" );
			String matricola =  context.getParameter( "matricola" );
			
			ArrayList<Campione> campioni = new ArrayList<Campione>();
			int asl = ((UserBean)context.getRequest().getSession().getAttribute("User")).getSiteId();
			campioni = Campione.loadAssociazioneEsiti ( data, matricola, asl, db);
			if(campioni.isEmpty())
			{
				context.getRequest().setAttribute("matricola", matricola);
				context.getRequest().setAttribute("data", data);
				context.getRequest().setAttribute("Error", "Nessun campione trovato con i criteri selezionati");
				return executeCommandToRicerca(context);
			
			}
			else
			{
				context.getRequest().setAttribute("Campioni", campioni);
				context.getRequest().setAttribute("matricola", matricola);
				context.getRequest().setAttribute("data", data);
				caricaLookup(context, true);
			}
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return ret;
	}
    
    public String executeCommandToRicerca( ActionContext context )
	{
		String			ret		= "ToRicercaOK";

		if (!hasPermission(context, "associazione_esiti_campioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		try
		{
			caricaLookup(context, true);
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		
		
		

		return ret;
	}
    
    
    public String executeCommandAssocia( ActionContext context )
	{
		String			ret		= "RicercaOK";

		if (!hasPermission(context, "associazione_esiti_campioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		try
		{
			db		= this.getConnection( context );
			
			ArrayList<Parameter> esiti			= ParameterUtils.list( context.getRequest(), "cmp_id_esito_" );
			ArrayList<Parameter> date_ricezione	= ParameterUtils.list( context.getRequest(), "cmp_data_ricezione_esito_" );
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			int i=0;
			while(i<esiti.size())
			{
				int p = Integer.parseInt(esiti.get(i).getValore());
				if(p>0)
				{
					String p2 = date_ricezione.get(i).getValore();
					int indiceTabella = Integer.parseInt(esiti.get(i).getNome().replace("cmp_id_esito_", ""));
							
					String idCampione = context.getParameter( "id_campione_" + indiceTabella);
					org.aspcfs.modules.macellazioni.base.Campione camp = org.aspcfs.modules.macellazioni.base.Campione.load(idCampione, db);
					camp.setId_esito		( p );
					
					if(p2 != null && !p2.equals(""))
					{
						Date s = sdf.parse( p2 );
						Timestamp t = new Timestamp(s.getTime());
						camp.setData_ricezione_esito ( t )  ;
					}
					camp.update(db);
					
					if(camp.getId_capo()>0)
					{
						Capo c = Capo.load(camp.getId_capo()+"", db);
						c.update(db, org.aspcfs.modules.macellazioni.base.Campione.load(camp.getId_capo(), db));
					}
					else if(camp.getId_seduta()>0)
					{
						PartitaSeduta sed = (PartitaSeduta)PartitaSeduta.load(camp.getId_seduta()+"", db, new ConfigTipo(2));
						sed.update(db, PartitaSeduta.loadCampioni	 ( camp.getId_seduta(), db ), new ConfigTipo(2));
					}
					else if(camp.getId_partita()>0)
					{
						Partita part = (Partita)Partita.load(camp.getId_partita()+"", db, new ConfigTipo(2));
						part.update(db, org.aspcfs.modules.macellazioninew.base.Campione.load(camp.getId_partita(),new ConfigTipo(2), db), new ConfigTipo(2));
					}
				}
				i++;
			}
			context.getRequest().setAttribute("Error2", "Esiti associati");
			
			String data = 		context.getParameter( "data" );
			String matricola =  context.getParameter( "matricola" );
			
			context.getRequest().setAttribute("matricola", matricola);
			context.getRequest().setAttribute("data", data);
			
			return executeCommandRicerca(context);
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		
		return ret;
	}
    
    
    private void caricaLookup(ActionContext context, boolean select)
	{
		Hashtable<String, String> lu = new Hashtable<String, String>();
		lu.put( "EsitiCampioni",			"m_lookup_campioni_esiti" );
		
		Enumeration<String> e = lu.keys();
		Connection db = null;

		try
		{
			db = this.getConnection( context );
			while( e.hasMoreElements() )
			{
				String key		= e.nextElement();
				String value	= lu.get( key );
				LookupList list	= new LookupList( db, value );
				if(select)
				{
					list.addItem( -1, " -- SELEZIONA -- " );
				}
				context.getRequest().setAttribute( key, list );
			}
			UserBean user=(UserBean)context.getSession().getAttribute("User");
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
	}




        
}

