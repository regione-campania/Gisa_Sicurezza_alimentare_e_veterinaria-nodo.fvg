package org.aspcfs.taglib;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.tagext.TryCatchFinally;

import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.utils.GestoreConnessioni;

import ext.aspcfs.modules.apiari.base.DelegaList;

public class AnagraficaApicoltori extends TagSupport implements TryCatchFinally {
	  private String codiceFiscale = null;
	  private boolean allRequired = false;
	  private boolean hasNone = false;

	  public void doCatch(Throwable throwable) throws Throwable {
	    // Required but not needed
	  }

	  public void doFinally() {
	    // Reset each property or else the value gets reused
	    codiceFiscale = null;
	    allRequired = false;
	    hasNone = false;
	  }
	  
	  /**
	   * Sets the Name attribute of the PermissionHandler object
	   *
	   * @param tmp The new Name value
	   * @since 1.1
	   */
	 


	  public String getCodiceFiscale() {
		return codiceFiscale;
	}

	public void setCodiceFiscale(String codiceFiscale) {
		this.codiceFiscale = codiceFiscale;
	}

	/**
	   * Sets the All attribute of the PermissionHandler object. If set to true
	   * then the user must have all permissions passed in.
	   *
	   * @param tmp The new All value
	   * @since 1.1
	   */
	  public void setAll(String tmp) {
	    Boolean checkAll = new Boolean(tmp);
	    this.allRequired = checkAll.booleanValue();
	  }


	  /**
	   * Sets the None attribute of the PermissionHandler object
	   *
	   * @param tmp The new None value
	   * @since 1.1
	   */
	  public void setNone(String tmp) {
	    Boolean checkNone = new Boolean(tmp);
	    this.hasNone = checkNone.booleanValue();
	  }


	  /**
	   * Checks to see if the user has permission to access the body of the tag. A
	   * comma-separated list of permissions can be used to match any of the
	   * permissions.
	   *
	   * @return Description of the Returned Value
	   * @throws JspException Description of Exception
	   * @since 1.1
	   */
	  public final int doStartTag() throws JspException {
	    if (codiceFiscale == null || "".equals(codiceFiscale)) {
	      return EVAL_BODY_INCLUDE;
	    }
	    boolean result = false;
	    int matches = 0;
	    int checks = 0;
	    UserBean thisUser = (UserBean) pageContext.getSession().getAttribute(
	        "User");
	    Connection db = null ; 
	    if (thisUser != null) {
	    try
	    {
	    	String cf = thisUser.getContact().getCodiceFiscale() ; 
	    	if (thisUser.getContact().getCodiceFiscale()==null|| "".equalsIgnoreCase(thisUser.getContact().getCodiceFiscale()))
	    		cf = "#############";
	    	db =  GestoreConnessioni.getConnection();
	    	DelegaList listaDeleghe = new DelegaList();
	    	listaDeleghe.setCodice_fiscale_delegante(codiceFiscale);
	    	listaDeleghe.setCodice_fiscale_delegato(thisUser.getContact().getVisibilitaDelega());
	    	listaDeleghe.setIdAsl(thisUser.getSiteId());
	    	listaDeleghe.buildList(db,null,null);
	    	
	    	String codiceFiscaleCompare = null;
	    	if(thisUser.getRoleId()==org.aspcfs.modules.admin.base.Role.RUOLO_DELEGATO || thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("avellino") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("benevento") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("caserta") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 1 CENTRO") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 2 NORD") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 3 SUD") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("salerno"))
	    		codiceFiscaleCompare = thisUser.getSoggetto().getCodFiscale();
	    	else
	    		codiceFiscaleCompare = thisUser.getContact().getVisibilitaDelega();
	    			
	    	if ((codiceFiscale.equalsIgnoreCase(codiceFiscaleCompare)))
	    		 result = true;
	    }
	    catch(SQLException | IndirizzoNotFoundException e)
	    {
	    	e.printStackTrace();
	    }
	    finally{
	    	GestoreConnessioni.freeConnection(db);
	    }
	    
	    }
	   
	   

	    //The request wants to know if the user does not have the permissions
	    if (hasNone) {
	      result = !result;
	    }

	    if (result) {
	      return EVAL_BODY_INCLUDE;
	    } else {
	      return SKIP_BODY;
	    }
	  }

	  public int doEndTag() {
		    return EVAL_PAGE;
		  }

	}